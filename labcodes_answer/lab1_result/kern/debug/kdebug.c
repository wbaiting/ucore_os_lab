#include <defs.h>
#include <x86.h>
#include <stab.h>
#include <stdio.h>
#include <string.h>
#include <kdebug.h>

#define STACKFRAME_DEPTH 20

//以下四个变量定义于链接文件kernel.lds中
extern const struct stab __STAB_BEGIN__[];  // beginning of stabs table
extern const struct stab __STAB_END__[];    // end of stabs table
extern const char __STABSTR_BEGIN__[];      // beginning of string table
extern const char __STABSTR_END__[];        // end of string table

/* debug information about a particular instruction pointer */
struct eipdebuginfo {
    const char *eip_file;                   // source code filename for eip
    int eip_line;                           // source code line number for eip
    const char *eip_fn_name;                // name of function containing eip
    int eip_fn_namelen;                     // length of function's name
    uintptr_t eip_fn_addr;                  // start address of function
    int eip_fn_narg;                        // number of function arguments
};

//二分查找，在stab中查找包含eip的函数名字等信息
/* *
 * stab_binsearch - according to the input, the initial value of
 * range [*@region_left, *@region_right], find a single stab entry
 * that includes the address @addr and matches the type @type,
 * and then save its boundary to the locations that pointed
 * by @region_left and @region_right.
 *
 * Some stab types are arranged in increasing order by instruction address.
 * For example, N_FUN stabs (stab entries with n_type == N_FUN), which
 * mark functions, and N_SO stabs, which mark source files.
 *
 * Given an instruction address, this function finds the single stab entry
 * of type @type that contains that address.
 *
 * The search takes place within the range [*@region_left, *@region_right].
 * Thus, to search an entire set of N stabs, you might do:
 *
 *      left = 0;
 *      right = N - 1;    (rightmost stab)
 *      stab_binsearch(stabs, &left, &right, type, addr);
 *
 * The search modifies *region_left and *region_right to bracket the @addr.
 * *@region_left points to the matching stab that contains @addr,
 * and *@region_right points just before the next stab.
 * If *@region_left > *region_right, then @addr is not contained in any
 * matching stab.
 *
 * For example, given these N_SO stabs:
 *      Index  Type   Address
 *      0      SO     f0100000
 *      13     SO     f0100040
 *      117    SO     f0100176
 *      118    SO     f0100178
 *      555    SO     f0100652
 *      556    SO     f0100654
 *      657    SO     f0100849
 * this code:
 *      left = 0, right = 657;
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
    int l = *region_left, r = *region_right, any_matches = 0;

    while (l <= r) {
        int true_m = (l + r) / 2, m = true_m;

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
            m --;
        }
        if (m < l) {    // no match in [l, m]
            l = true_m + 1;
            continue;
        }

        // actual binary search
        any_matches = 1;
        if (stabs[m].n_value < addr) {
            *region_left = m;
            l = true_m + 1;
        } else if (stabs[m].n_value > addr) {
            *region_right = m - 1;
            r = m - 1;
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
            l = m;
            addr ++;
        }
    }

    if (!any_matches) {
        *region_right = *region_left - 1;
    }
    else {
        // find rightmost region containing 'addr'
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}

/* *
 * debuginfo_eip - Fill in the @info structure with information about
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
    info->eip_line = 0;
    info->eip_fn_name = "<unknown>";
    info->eip_fn_namelen = 9;
    info->eip_fn_addr = addr;
    info->eip_fn_narg = 0;

    stabs = __STAB_BEGIN__;
    stab_end = __STAB_END__;
    stabstr = __STABSTR_BEGIN__;
    stabstr_end = __STABSTR_END__;

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
        return -1;
    }

    // Now we find the right stabs that define the function containing
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
    if (lfile == 0)
        return -1;

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);

    if (lfun <= rfun) {
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
        }
        info->eip_fn_addr = stabs[lfun].n_value;
        addr -= info->eip_fn_addr;
        // Search within the function definition for the line number.
        lline = lfun;
        rline = rfun;
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
        lline = lfile;
        rline = rfile;
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
    if (lline <= rline) {
        info->eip_line = stabs[rline].n_desc;
    } else {
        return -1;
    }

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
        info->eip_file = stabstr + stabs[lline].n_strx;
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
        }
    }
    return 0;
}

/* *
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
    cprintf("  entry  0x%08x (phys)\n", kern_init);
    cprintf("  etext  0x%08x (phys)\n", etext);
    cprintf("  edata  0x%08x (phys)\n", edata);
    cprintf("  end    0x%08x (phys)\n", end);
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
}

/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
    }
    else {
        char fnname[256];
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
            fnname[j] = info.eip_fn_name[j];
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}

static __noinline uint32_t
read_eip(void) {
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
    return eip;
}

/* *
 * print_stackframe - print a list of the saved eip values from the nested 'call'
 * instructions that led to the current point of execution
 *
 * The x86 stack pointer, namely esp, points to the lowest location on the stack
 * that is currently in use. Everything below that location in stack is free. Pushing
 * a value onto the stack will invole decreasing the stack pointer and then writing
 * the value to the place that stack pointer pointes to. And popping a value do the
 * opposite.
 *
 * The ebp (base pointer) register, in contrast, is associated with the stack
 * primarily by software convention. On entry to a C function, the function's
 * prologue code normally saves the previous function's base pointer by pushing
 * it onto the stack, and then copies the current esp value into ebp for the duration
 * of the function. If all the functions in a program obey this convention,
 * then at any given point during the program's execution, it is possible to trace
 * back through the stack by following the chain of saved ebp pointers and determining
 * exactly what nested sequence of function calls caused this particular point in the
 * program to be reached. This capability can be particularly useful, for example,
 * when a particular function causes an assert failure or panic because bad arguments
 * were passed to it, but you aren't sure who passed the bad arguments. A stack
 * backtrace lets you find the offending function.
 *
 * The inline function read_ebp() can tell us the value of current ebp. And the
 * non-inline function read_eip() is useful, it can read the value of current eip,
 * since while calling this function, read_eip() can read the caller's eip from
 * stack easily.
 *
 * In print_debuginfo(), the function debuginfo_eip() can get enough information about
 * calling-chain. Finally print_stackframe() will trace and print them for debugging.
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
     /* LAB1 YOUR CODE : STEP 1 */
     /* (1) call read_ebp() to get the value of ebp. the type is (uint32_t);
      * (2) call read_eip() to get the value of eip. the type is (uint32_t);
      * (3) from 0 .. STACKFRAME_DEPTH
      *    (3.1) printf value of ebp, eip
      *    (3.2) (uint32_t)calling arguments [0..4] = the contents in address (uint32_t)ebp +2 [0..4]
      *    (3.3) cprintf("\n");
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
    uint32_t ebp = read_ebp(), eip = read_eip();

    int i, j;
    for (i = 0; ebp != 0 && i < STACKFRAME_DEPTH; i ++) {
        cprintf("ebp:0x%08x eip:0x%08x args:", ebp, eip);
        uint32_t *args = (uint32_t *)ebp + 2;
        for (j = 0; j < 4; j ++) {
            cprintf("0x%08x ", args[j]);
        }
        cprintf("\n");
        print_debuginfo(eip - 1);
        eip = ((uint32_t *)ebp)[1];
        ebp = ((uint32_t *)ebp)[0];
    }
}


//函数调用可以描述为以下几个步骤：
//- 1、参数入栈：将参数从右向左依次压入栈中。
//- 2、返回地址入栈：call指令内部隐含的动作，将call的下一条指令入栈
//- 3、代码区跳转：跳转到被调用函数入口处
//- 4、函数入口处前两条指令，为本地编译器自动插入的指令，执行这两条指令
//- 4.1、将ebp的值入栈，即调用之前的那个栈帧的底部
//- 4.2、将当前的esp值赋给ebp，当前的esp即为新的函数的栈帧的底部，保存到ebp中
//- 4.3、给新栈帧分配空间（把ESP减去所需空间的大小）。
//
//函数返回的大概步骤：
//- 1、保存返回值，通常将函数返回值保存到寄存器EAX中。
//- 2、将当前的ebp赋给esp
//- 3、从栈中弹出一个值给ebp
//- 4、弹出返回地址，从返回地址处继续执行
//
//就是一个相反的过程。
//
//对于函数调用时为什么会有4、3这个步骤，有如下解释：
//&nbsp深入理解计算机系统一书P154这样描述：“GCC坚持一个x86编程指导方针，也就是一个函数使用的所有栈空间必须是16字节的整数倍。包括保存%ebp值的4个字节和返回值的4个字节，采用这个规则是为了保证访问数据的严格对齐。”


//函数堆栈
// | 栈底方向 		| 高位地址
// | 。。。  		|
// | 。。。 		|
// | 参数3 			|
// | 参数2 			|
// | 参数1 		 	|
// | 返回地址eip 	|
// | 上一层[ebp] 	|<-------------[ebp]
// | 局部变量 		|地位地址
//
//
// 作业2的调用过程中，堆栈情况如下所示
//
// | 栈底 				| <----0x7c00
// | 0x7c4f 			| 即将进入bootmain（），此处是bootmain的返回地址，bootasm.s的spin
// | 0 					| <----0x7bf8
// | 局部变量 			|
// | ..... 				|
// | 0x7d64 			| 即将调用内核init_main，内核调用的返回地址，bootmain.c的outw
// | 0x7bf8 			| <----0x7be8   //gcc默认以16字节对齐函数堆栈
// | 局部变量 			|
// | 。。。。。 		|  //这里存在疑问，为什么这一层的堆栈有48个字节，init_main用了48个字节的堆栈。^puzzle2^
// |....... 			| 调用grade_backtrace()
// | 0x100055 			| 此处为返回地址也就是pmm_init的地址
// | 0x7be8 			| <----0x7bb8
// | 局部变量 			|
// | 。。。。。  		|
// | 参数3 0xffff0000 	|调用grade_backtrace0()
// | 参数2 0x100000 	|
// | 参数1 0x0 			|
// | 0x100103 			|
// | 0x7bb8 			| <----0x7b98
// | 局部变量 			|
// | 。。。。。 		| 调用grade——backtrace1()
// | 参数2 0xffff0000 	| <----0x7b84
// | 参数1 0x0 			| <----0x7b80
// | 0x1000de 			|
// | 0x7b98 			| <----0x7b78
// | 局部变量 			|
// | 。。。。。 		|
// | 参数4 0x7b84 		|调用grade_backtrace2,准备传参
// | 参数3 0xffff0000 	|
// | 参数2 0x7b80 		|
// | 参数1 0x0 			|
// | 0x1000c0 			|
// | 0x7b78 			| <----0x7b58
// | 局部变量 			|
// | 。。。。。 		|
// | 参数3 0x0 			| 调用mon_backtrace()
// | 参数2 0x0 			|
// | 参数1 0x0 			|
// | 0x100097 			|
// | 0x7b58 			| <----0x7b38
// | 局部变量			|
// |。。。。。 			|
// | 0x100d1b 			| 调用print_stackframe()
// | 0x7b38 			| <----0x7b28
// | 局部变量			|
// | 。。。。。 		|
//
