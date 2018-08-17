
bin/kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <kern_init>:
void kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

void
kern_init(void){
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	83 ec 28             	sub    $0x28,%esp
    extern char edata[], end[];
	//清空BSS段，BSS段通常是指用来存放程序中未初始化的全局变量和静态变量的一块内存区域
    memset(edata, 0, end - edata);
  100006:	ba 80 fd 10 00       	mov    $0x10fd80,%edx
  10000b:	b8 16 ea 10 00       	mov    $0x10ea16,%eax
  100010:	29 c2                	sub    %eax,%edx
  100012:	89 d0                	mov    %edx,%eax
  100014:	89 44 24 08          	mov    %eax,0x8(%esp)
  100018:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10001f:	00 
  100020:	c7 04 24 16 ea 10 00 	movl   $0x10ea16,(%esp)
  100027:	e8 3f 34 00 00       	call   10346b <memset>

	//初始化控制台
    cons_init();                // init the console
  10002c:	e8 c6 15 00 00       	call   1015f7 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  100031:	c7 45 f4 00 36 10 00 	movl   $0x103600,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100038:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10003b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10003f:	c7 04 24 1c 36 10 00 	movl   $0x10361c,(%esp)
  100046:	e8 d7 02 00 00       	call   100322 <cprintf>

    print_kerninfo();
  10004b:	e8 06 08 00 00       	call   100856 <print_kerninfo>

    grade_backtrace(); 			//作业2，函数堆栈，
  100050:	e8 8b 00 00 00       	call   1000e0 <grade_backtrace>

    pmm_init();                 // init physical memory management
  100055:	e8 57 2a 00 00       	call   102ab1 <pmm_init>

    pic_init();                 // init interrupt controller
  10005a:	e8 db 16 00 00       	call   10173a <pic_init>
    idt_init();                 // init interrupt descriptor table
  10005f:	e8 2d 18 00 00       	call   101891 <idt_init>

    clock_init();               // init clock interrupt
  100064:	e8 81 0d 00 00       	call   100dea <clock_init>
    intr_enable();              // enable irq interrupt
  100069:	e8 3a 16 00 00       	call   1016a8 <intr_enable>

    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    lab1_switch_test();
  10006e:	e8 6d 01 00 00       	call   1001e0 <lab1_switch_test>

    /* do nothing */
    while (1);
  100073:	eb fe                	jmp    100073 <kern_init+0x73>

00100075 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  100075:	55                   	push   %ebp
  100076:	89 e5                	mov    %esp,%ebp
  100078:	83 ec 18             	sub    $0x18,%esp
    mon_backtrace(0, NULL, NULL);
  10007b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  100082:	00 
  100083:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10008a:	00 
  10008b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100092:	e8 74 0c 00 00       	call   100d0b <mon_backtrace>
}
  100097:	c9                   	leave  
  100098:	c3                   	ret    

00100099 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  100099:	55                   	push   %ebp
  10009a:	89 e5                	mov    %esp,%ebp
  10009c:	53                   	push   %ebx
  10009d:	83 ec 14             	sub    $0x14,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  1000a0:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  1000a3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  1000a6:	8d 55 08             	lea    0x8(%ebp),%edx
  1000a9:	8b 45 08             	mov    0x8(%ebp),%eax
  1000ac:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  1000b0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  1000b4:	89 54 24 04          	mov    %edx,0x4(%esp)
  1000b8:	89 04 24             	mov    %eax,(%esp)
  1000bb:	e8 b5 ff ff ff       	call   100075 <grade_backtrace2>
}
  1000c0:	83 c4 14             	add    $0x14,%esp
  1000c3:	5b                   	pop    %ebx
  1000c4:	5d                   	pop    %ebp
  1000c5:	c3                   	ret    

001000c6 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000c6:	55                   	push   %ebp
  1000c7:	89 e5                	mov    %esp,%ebp
  1000c9:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace1(arg0, arg2);
  1000cc:	8b 45 10             	mov    0x10(%ebp),%eax
  1000cf:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000d3:	8b 45 08             	mov    0x8(%ebp),%eax
  1000d6:	89 04 24             	mov    %eax,(%esp)
  1000d9:	e8 bb ff ff ff       	call   100099 <grade_backtrace1>
}
  1000de:	c9                   	leave  
  1000df:	c3                   	ret    

001000e0 <grade_backtrace>:

void
grade_backtrace(void) {
  1000e0:	55                   	push   %ebp
  1000e1:	89 e5                	mov    %esp,%ebp
  1000e3:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  1000e6:	b8 00 00 10 00       	mov    $0x100000,%eax
  1000eb:	c7 44 24 08 00 00 ff 	movl   $0xffff0000,0x8(%esp)
  1000f2:	ff 
  1000f3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000f7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1000fe:	e8 c3 ff ff ff       	call   1000c6 <grade_backtrace0>
}
  100103:	c9                   	leave  
  100104:	c3                   	ret    

00100105 <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  100105:	55                   	push   %ebp
  100106:	89 e5                	mov    %esp,%ebp
  100108:	83 ec 28             	sub    $0x28,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  10010b:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  10010e:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  100111:	8c 45 f2             	mov    %es,-0xe(%ebp)
  100114:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  100117:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10011b:	0f b7 c0             	movzwl %ax,%eax
  10011e:	83 e0 03             	and    $0x3,%eax
  100121:	89 c2                	mov    %eax,%edx
  100123:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100128:	89 54 24 08          	mov    %edx,0x8(%esp)
  10012c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100130:	c7 04 24 21 36 10 00 	movl   $0x103621,(%esp)
  100137:	e8 e6 01 00 00       	call   100322 <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
  10013c:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100140:	0f b7 d0             	movzwl %ax,%edx
  100143:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100148:	89 54 24 08          	mov    %edx,0x8(%esp)
  10014c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100150:	c7 04 24 2f 36 10 00 	movl   $0x10362f,(%esp)
  100157:	e8 c6 01 00 00       	call   100322 <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
  10015c:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  100160:	0f b7 d0             	movzwl %ax,%edx
  100163:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100168:	89 54 24 08          	mov    %edx,0x8(%esp)
  10016c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100170:	c7 04 24 3d 36 10 00 	movl   $0x10363d,(%esp)
  100177:	e8 a6 01 00 00       	call   100322 <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
  10017c:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100180:	0f b7 d0             	movzwl %ax,%edx
  100183:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100188:	89 54 24 08          	mov    %edx,0x8(%esp)
  10018c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100190:	c7 04 24 4b 36 10 00 	movl   $0x10364b,(%esp)
  100197:	e8 86 01 00 00       	call   100322 <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
  10019c:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001a0:	0f b7 d0             	movzwl %ax,%edx
  1001a3:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  1001a8:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001ac:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001b0:	c7 04 24 59 36 10 00 	movl   $0x103659,(%esp)
  1001b7:	e8 66 01 00 00       	call   100322 <cprintf>
    round ++;
  1001bc:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  1001c1:	83 c0 01             	add    $0x1,%eax
  1001c4:	a3 20 ea 10 00       	mov    %eax,0x10ea20
}
  1001c9:	c9                   	leave  
  1001ca:	c3                   	ret    

001001cb <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  1001cb:	55                   	push   %ebp
  1001cc:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
	asm volatile (
  1001ce:	83 ec 08             	sub    $0x8,%esp
  1001d1:	cd 78                	int    $0x78
  1001d3:	89 ec                	mov    %ebp,%esp
	    "int %0 \n"
	    "movl %%ebp, %%esp"
	    : 
	    : "i"(T_SWITCH_TOU)
	);
}
  1001d5:	5d                   	pop    %ebp
  1001d6:	c3                   	ret    

001001d7 <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001d7:	55                   	push   %ebp
  1001d8:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
	asm volatile (
  1001da:	cd 79                	int    $0x79
  1001dc:	89 ec                	mov    %ebp,%esp
	    "int %0 \n"
	    "movl %%ebp, %%esp \n"
	    : 
	    : "i"(T_SWITCH_TOK)
	);
}
  1001de:	5d                   	pop    %ebp
  1001df:	c3                   	ret    

001001e0 <lab1_switch_test>:

static void
lab1_switch_test(void) {
  1001e0:	55                   	push   %ebp
  1001e1:	89 e5                	mov    %esp,%ebp
  1001e3:	83 ec 18             	sub    $0x18,%esp
    lab1_print_cur_status();
  1001e6:	e8 1a ff ff ff       	call   100105 <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  1001eb:	c7 04 24 68 36 10 00 	movl   $0x103668,(%esp)
  1001f2:	e8 2b 01 00 00       	call   100322 <cprintf>
    lab1_switch_to_user();
  1001f7:	e8 cf ff ff ff       	call   1001cb <lab1_switch_to_user>
    lab1_print_cur_status();
  1001fc:	e8 04 ff ff ff       	call   100105 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  100201:	c7 04 24 88 36 10 00 	movl   $0x103688,(%esp)
  100208:	e8 15 01 00 00       	call   100322 <cprintf>
    lab1_switch_to_kernel();
  10020d:	e8 c5 ff ff ff       	call   1001d7 <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100212:	e8 ee fe ff ff       	call   100105 <lab1_print_cur_status>
}
  100217:	c9                   	leave  
  100218:	c3                   	ret    

00100219 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  100219:	55                   	push   %ebp
  10021a:	89 e5                	mov    %esp,%ebp
  10021c:	83 ec 28             	sub    $0x28,%esp
    if (prompt != NULL) {
  10021f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100223:	74 13                	je     100238 <readline+0x1f>
        cprintf("%s", prompt);
  100225:	8b 45 08             	mov    0x8(%ebp),%eax
  100228:	89 44 24 04          	mov    %eax,0x4(%esp)
  10022c:	c7 04 24 a7 36 10 00 	movl   $0x1036a7,(%esp)
  100233:	e8 ea 00 00 00       	call   100322 <cprintf>
    }
    int i = 0, c;
  100238:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  10023f:	e8 66 01 00 00       	call   1003aa <getchar>
  100244:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  100247:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10024b:	79 07                	jns    100254 <readline+0x3b>
            return NULL;
  10024d:	b8 00 00 00 00       	mov    $0x0,%eax
  100252:	eb 79                	jmp    1002cd <readline+0xb4>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  100254:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  100258:	7e 28                	jle    100282 <readline+0x69>
  10025a:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100261:	7f 1f                	jg     100282 <readline+0x69>
            cputchar(c);
  100263:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100266:	89 04 24             	mov    %eax,(%esp)
  100269:	e8 da 00 00 00       	call   100348 <cputchar>
            buf[i ++] = c;
  10026e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100271:	8d 50 01             	lea    0x1(%eax),%edx
  100274:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100277:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10027a:	88 90 40 ea 10 00    	mov    %dl,0x10ea40(%eax)
  100280:	eb 46                	jmp    1002c8 <readline+0xaf>
        }
        else if (c == '\b' && i > 0) {
  100282:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  100286:	75 17                	jne    10029f <readline+0x86>
  100288:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10028c:	7e 11                	jle    10029f <readline+0x86>
            cputchar(c);
  10028e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100291:	89 04 24             	mov    %eax,(%esp)
  100294:	e8 af 00 00 00       	call   100348 <cputchar>
            i --;
  100299:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  10029d:	eb 29                	jmp    1002c8 <readline+0xaf>
        }
        else if (c == '\n' || c == '\r') {
  10029f:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  1002a3:	74 06                	je     1002ab <readline+0x92>
  1002a5:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  1002a9:	75 1d                	jne    1002c8 <readline+0xaf>
            cputchar(c);
  1002ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1002ae:	89 04 24             	mov    %eax,(%esp)
  1002b1:	e8 92 00 00 00       	call   100348 <cputchar>
            buf[i] = '\0';
  1002b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1002b9:	05 40 ea 10 00       	add    $0x10ea40,%eax
  1002be:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1002c1:	b8 40 ea 10 00       	mov    $0x10ea40,%eax
  1002c6:	eb 05                	jmp    1002cd <readline+0xb4>
        }
    }
  1002c8:	e9 72 ff ff ff       	jmp    10023f <readline+0x26>
}
  1002cd:	c9                   	leave  
  1002ce:	c3                   	ret    

001002cf <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  1002cf:	55                   	push   %ebp
  1002d0:	89 e5                	mov    %esp,%ebp
  1002d2:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  1002d5:	8b 45 08             	mov    0x8(%ebp),%eax
  1002d8:	89 04 24             	mov    %eax,(%esp)
  1002db:	e8 43 13 00 00       	call   101623 <cons_putc>
    (*cnt) ++;
  1002e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002e3:	8b 00                	mov    (%eax),%eax
  1002e5:	8d 50 01             	lea    0x1(%eax),%edx
  1002e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002eb:	89 10                	mov    %edx,(%eax)
}
  1002ed:	c9                   	leave  
  1002ee:	c3                   	ret    

001002ef <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  1002ef:	55                   	push   %ebp
  1002f0:	89 e5                	mov    %esp,%ebp
  1002f2:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  1002f5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  1002fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002ff:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100303:	8b 45 08             	mov    0x8(%ebp),%eax
  100306:	89 44 24 08          	mov    %eax,0x8(%esp)
  10030a:	8d 45 f4             	lea    -0xc(%ebp),%eax
  10030d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100311:	c7 04 24 cf 02 10 00 	movl   $0x1002cf,(%esp)
  100318:	e8 67 29 00 00       	call   102c84 <vprintfmt>
    return cnt;
  10031d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100320:	c9                   	leave  
  100321:	c3                   	ret    

00100322 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  100322:	55                   	push   %ebp
  100323:	89 e5                	mov    %esp,%ebp
  100325:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100328:	8d 45 0c             	lea    0xc(%ebp),%eax
  10032b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  10032e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100331:	89 44 24 04          	mov    %eax,0x4(%esp)
  100335:	8b 45 08             	mov    0x8(%ebp),%eax
  100338:	89 04 24             	mov    %eax,(%esp)
  10033b:	e8 af ff ff ff       	call   1002ef <vcprintf>
  100340:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  100343:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100346:	c9                   	leave  
  100347:	c3                   	ret    

00100348 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  100348:	55                   	push   %ebp
  100349:	89 e5                	mov    %esp,%ebp
  10034b:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  10034e:	8b 45 08             	mov    0x8(%ebp),%eax
  100351:	89 04 24             	mov    %eax,(%esp)
  100354:	e8 ca 12 00 00       	call   101623 <cons_putc>
}
  100359:	c9                   	leave  
  10035a:	c3                   	ret    

0010035b <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  10035b:	55                   	push   %ebp
  10035c:	89 e5                	mov    %esp,%ebp
  10035e:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  100361:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  100368:	eb 13                	jmp    10037d <cputs+0x22>
        cputch(c, &cnt);
  10036a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  10036e:	8d 55 f0             	lea    -0x10(%ebp),%edx
  100371:	89 54 24 04          	mov    %edx,0x4(%esp)
  100375:	89 04 24             	mov    %eax,(%esp)
  100378:	e8 52 ff ff ff       	call   1002cf <cputch>
 * */
int
cputs(const char *str) {
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
  10037d:	8b 45 08             	mov    0x8(%ebp),%eax
  100380:	8d 50 01             	lea    0x1(%eax),%edx
  100383:	89 55 08             	mov    %edx,0x8(%ebp)
  100386:	0f b6 00             	movzbl (%eax),%eax
  100389:	88 45 f7             	mov    %al,-0x9(%ebp)
  10038c:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  100390:	75 d8                	jne    10036a <cputs+0xf>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
  100392:	8d 45 f0             	lea    -0x10(%ebp),%eax
  100395:	89 44 24 04          	mov    %eax,0x4(%esp)
  100399:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  1003a0:	e8 2a ff ff ff       	call   1002cf <cputch>
    return cnt;
  1003a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  1003a8:	c9                   	leave  
  1003a9:	c3                   	ret    

001003aa <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  1003aa:	55                   	push   %ebp
  1003ab:	89 e5                	mov    %esp,%ebp
  1003ad:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  1003b0:	e8 97 12 00 00       	call   10164c <cons_getc>
  1003b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1003b8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003bc:	74 f2                	je     1003b0 <getchar+0x6>
        /* do nothing */;
    return c;
  1003be:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1003c1:	c9                   	leave  
  1003c2:	c3                   	ret    

001003c3 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1003c3:	55                   	push   %ebp
  1003c4:	89 e5                	mov    %esp,%ebp
  1003c6:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  1003c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1003cc:	8b 00                	mov    (%eax),%eax
  1003ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1003d1:	8b 45 10             	mov    0x10(%ebp),%eax
  1003d4:	8b 00                	mov    (%eax),%eax
  1003d6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1003d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  1003e0:	e9 d2 00 00 00       	jmp    1004b7 <stab_binsearch+0xf4>
        int true_m = (l + r) / 2, m = true_m;
  1003e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1003e8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1003eb:	01 d0                	add    %edx,%eax
  1003ed:	89 c2                	mov    %eax,%edx
  1003ef:	c1 ea 1f             	shr    $0x1f,%edx
  1003f2:	01 d0                	add    %edx,%eax
  1003f4:	d1 f8                	sar    %eax
  1003f6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1003f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1003fc:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  1003ff:	eb 04                	jmp    100405 <stab_binsearch+0x42>
            m --;
  100401:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)

    while (l <= r) {
        int true_m = (l + r) / 2, m = true_m;

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  100405:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100408:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  10040b:	7c 1f                	jl     10042c <stab_binsearch+0x69>
  10040d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100410:	89 d0                	mov    %edx,%eax
  100412:	01 c0                	add    %eax,%eax
  100414:	01 d0                	add    %edx,%eax
  100416:	c1 e0 02             	shl    $0x2,%eax
  100419:	89 c2                	mov    %eax,%edx
  10041b:	8b 45 08             	mov    0x8(%ebp),%eax
  10041e:	01 d0                	add    %edx,%eax
  100420:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100424:	0f b6 c0             	movzbl %al,%eax
  100427:	3b 45 14             	cmp    0x14(%ebp),%eax
  10042a:	75 d5                	jne    100401 <stab_binsearch+0x3e>
            m --;
        }
        if (m < l) {    // no match in [l, m]
  10042c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10042f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100432:	7d 0b                	jge    10043f <stab_binsearch+0x7c>
            l = true_m + 1;
  100434:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100437:	83 c0 01             	add    $0x1,%eax
  10043a:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  10043d:	eb 78                	jmp    1004b7 <stab_binsearch+0xf4>
        }

        // actual binary search
        any_matches = 1;
  10043f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  100446:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100449:	89 d0                	mov    %edx,%eax
  10044b:	01 c0                	add    %eax,%eax
  10044d:	01 d0                	add    %edx,%eax
  10044f:	c1 e0 02             	shl    $0x2,%eax
  100452:	89 c2                	mov    %eax,%edx
  100454:	8b 45 08             	mov    0x8(%ebp),%eax
  100457:	01 d0                	add    %edx,%eax
  100459:	8b 40 08             	mov    0x8(%eax),%eax
  10045c:	3b 45 18             	cmp    0x18(%ebp),%eax
  10045f:	73 13                	jae    100474 <stab_binsearch+0xb1>
            *region_left = m;
  100461:	8b 45 0c             	mov    0xc(%ebp),%eax
  100464:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100467:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  100469:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10046c:	83 c0 01             	add    $0x1,%eax
  10046f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100472:	eb 43                	jmp    1004b7 <stab_binsearch+0xf4>
        } else if (stabs[m].n_value > addr) {
  100474:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100477:	89 d0                	mov    %edx,%eax
  100479:	01 c0                	add    %eax,%eax
  10047b:	01 d0                	add    %edx,%eax
  10047d:	c1 e0 02             	shl    $0x2,%eax
  100480:	89 c2                	mov    %eax,%edx
  100482:	8b 45 08             	mov    0x8(%ebp),%eax
  100485:	01 d0                	add    %edx,%eax
  100487:	8b 40 08             	mov    0x8(%eax),%eax
  10048a:	3b 45 18             	cmp    0x18(%ebp),%eax
  10048d:	76 16                	jbe    1004a5 <stab_binsearch+0xe2>
            *region_right = m - 1;
  10048f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100492:	8d 50 ff             	lea    -0x1(%eax),%edx
  100495:	8b 45 10             	mov    0x10(%ebp),%eax
  100498:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  10049a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10049d:	83 e8 01             	sub    $0x1,%eax
  1004a0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1004a3:	eb 12                	jmp    1004b7 <stab_binsearch+0xf4>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  1004a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004a8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1004ab:	89 10                	mov    %edx,(%eax)
            l = m;
  1004ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1004b3:	83 45 18 01          	addl   $0x1,0x18(%ebp)
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
    int l = *region_left, r = *region_right, any_matches = 0;

    while (l <= r) {
  1004b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1004ba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1004bd:	0f 8e 22 ff ff ff    	jle    1003e5 <stab_binsearch+0x22>
            l = m;
            addr ++;
        }
    }

    if (!any_matches) {
  1004c3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1004c7:	75 0f                	jne    1004d8 <stab_binsearch+0x115>
        *region_right = *region_left - 1;
  1004c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004cc:	8b 00                	mov    (%eax),%eax
  1004ce:	8d 50 ff             	lea    -0x1(%eax),%edx
  1004d1:	8b 45 10             	mov    0x10(%ebp),%eax
  1004d4:	89 10                	mov    %edx,(%eax)
  1004d6:	eb 3f                	jmp    100517 <stab_binsearch+0x154>
    }
    else {
        // find rightmost region containing 'addr'
        l = *region_right;
  1004d8:	8b 45 10             	mov    0x10(%ebp),%eax
  1004db:	8b 00                	mov    (%eax),%eax
  1004dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  1004e0:	eb 04                	jmp    1004e6 <stab_binsearch+0x123>
  1004e2:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  1004e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004e9:	8b 00                	mov    (%eax),%eax
  1004eb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1004ee:	7d 1f                	jge    10050f <stab_binsearch+0x14c>
  1004f0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1004f3:	89 d0                	mov    %edx,%eax
  1004f5:	01 c0                	add    %eax,%eax
  1004f7:	01 d0                	add    %edx,%eax
  1004f9:	c1 e0 02             	shl    $0x2,%eax
  1004fc:	89 c2                	mov    %eax,%edx
  1004fe:	8b 45 08             	mov    0x8(%ebp),%eax
  100501:	01 d0                	add    %edx,%eax
  100503:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100507:	0f b6 c0             	movzbl %al,%eax
  10050a:	3b 45 14             	cmp    0x14(%ebp),%eax
  10050d:	75 d3                	jne    1004e2 <stab_binsearch+0x11f>
            /* do nothing */;
        *region_left = l;
  10050f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100512:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100515:	89 10                	mov    %edx,(%eax)
    }
}
  100517:	c9                   	leave  
  100518:	c3                   	ret    

00100519 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  100519:	55                   	push   %ebp
  10051a:	89 e5                	mov    %esp,%ebp
  10051c:	83 ec 58             	sub    $0x58,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  10051f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100522:	c7 00 ac 36 10 00    	movl   $0x1036ac,(%eax)
    info->eip_line = 0;
  100528:	8b 45 0c             	mov    0xc(%ebp),%eax
  10052b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  100532:	8b 45 0c             	mov    0xc(%ebp),%eax
  100535:	c7 40 08 ac 36 10 00 	movl   $0x1036ac,0x8(%eax)
    info->eip_fn_namelen = 9;
  10053c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10053f:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  100546:	8b 45 0c             	mov    0xc(%ebp),%eax
  100549:	8b 55 08             	mov    0x8(%ebp),%edx
  10054c:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  10054f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100552:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  100559:	c7 45 f4 0c 3f 10 00 	movl   $0x103f0c,-0xc(%ebp)
    stab_end = __STAB_END__;
  100560:	c7 45 f0 9c b7 10 00 	movl   $0x10b79c,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  100567:	c7 45 ec 9d b7 10 00 	movl   $0x10b79d,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  10056e:	c7 45 e8 b8 d7 10 00 	movl   $0x10d7b8,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  100575:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100578:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  10057b:	76 0d                	jbe    10058a <debuginfo_eip+0x71>
  10057d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100580:	83 e8 01             	sub    $0x1,%eax
  100583:	0f b6 00             	movzbl (%eax),%eax
  100586:	84 c0                	test   %al,%al
  100588:	74 0a                	je     100594 <debuginfo_eip+0x7b>
        return -1;
  10058a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10058f:	e9 c0 02 00 00       	jmp    100854 <debuginfo_eip+0x33b>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  100594:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  10059b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10059e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1005a1:	29 c2                	sub    %eax,%edx
  1005a3:	89 d0                	mov    %edx,%eax
  1005a5:	c1 f8 02             	sar    $0x2,%eax
  1005a8:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  1005ae:	83 e8 01             	sub    $0x1,%eax
  1005b1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1005b4:	8b 45 08             	mov    0x8(%ebp),%eax
  1005b7:	89 44 24 10          	mov    %eax,0x10(%esp)
  1005bb:	c7 44 24 0c 64 00 00 	movl   $0x64,0xc(%esp)
  1005c2:	00 
  1005c3:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1005c6:	89 44 24 08          	mov    %eax,0x8(%esp)
  1005ca:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1005cd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1005d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1005d4:	89 04 24             	mov    %eax,(%esp)
  1005d7:	e8 e7 fd ff ff       	call   1003c3 <stab_binsearch>
    if (lfile == 0)
  1005dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1005df:	85 c0                	test   %eax,%eax
  1005e1:	75 0a                	jne    1005ed <debuginfo_eip+0xd4>
        return -1;
  1005e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1005e8:	e9 67 02 00 00       	jmp    100854 <debuginfo_eip+0x33b>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1005ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1005f0:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1005f3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1005f6:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  1005f9:	8b 45 08             	mov    0x8(%ebp),%eax
  1005fc:	89 44 24 10          	mov    %eax,0x10(%esp)
  100600:	c7 44 24 0c 24 00 00 	movl   $0x24,0xc(%esp)
  100607:	00 
  100608:	8d 45 d8             	lea    -0x28(%ebp),%eax
  10060b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10060f:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100612:	89 44 24 04          	mov    %eax,0x4(%esp)
  100616:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100619:	89 04 24             	mov    %eax,(%esp)
  10061c:	e8 a2 fd ff ff       	call   1003c3 <stab_binsearch>

    if (lfun <= rfun) {
  100621:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100624:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100627:	39 c2                	cmp    %eax,%edx
  100629:	7f 7c                	jg     1006a7 <debuginfo_eip+0x18e>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  10062b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10062e:	89 c2                	mov    %eax,%edx
  100630:	89 d0                	mov    %edx,%eax
  100632:	01 c0                	add    %eax,%eax
  100634:	01 d0                	add    %edx,%eax
  100636:	c1 e0 02             	shl    $0x2,%eax
  100639:	89 c2                	mov    %eax,%edx
  10063b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10063e:	01 d0                	add    %edx,%eax
  100640:	8b 10                	mov    (%eax),%edx
  100642:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  100645:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100648:	29 c1                	sub    %eax,%ecx
  10064a:	89 c8                	mov    %ecx,%eax
  10064c:	39 c2                	cmp    %eax,%edx
  10064e:	73 22                	jae    100672 <debuginfo_eip+0x159>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  100650:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100653:	89 c2                	mov    %eax,%edx
  100655:	89 d0                	mov    %edx,%eax
  100657:	01 c0                	add    %eax,%eax
  100659:	01 d0                	add    %edx,%eax
  10065b:	c1 e0 02             	shl    $0x2,%eax
  10065e:	89 c2                	mov    %eax,%edx
  100660:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100663:	01 d0                	add    %edx,%eax
  100665:	8b 10                	mov    (%eax),%edx
  100667:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10066a:	01 c2                	add    %eax,%edx
  10066c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10066f:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  100672:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100675:	89 c2                	mov    %eax,%edx
  100677:	89 d0                	mov    %edx,%eax
  100679:	01 c0                	add    %eax,%eax
  10067b:	01 d0                	add    %edx,%eax
  10067d:	c1 e0 02             	shl    $0x2,%eax
  100680:	89 c2                	mov    %eax,%edx
  100682:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100685:	01 d0                	add    %edx,%eax
  100687:	8b 50 08             	mov    0x8(%eax),%edx
  10068a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10068d:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  100690:	8b 45 0c             	mov    0xc(%ebp),%eax
  100693:	8b 40 10             	mov    0x10(%eax),%eax
  100696:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  100699:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10069c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  10069f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1006a2:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1006a5:	eb 15                	jmp    1006bc <debuginfo_eip+0x1a3>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  1006a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006aa:	8b 55 08             	mov    0x8(%ebp),%edx
  1006ad:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  1006b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006b3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  1006b6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1006b9:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  1006bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006bf:	8b 40 08             	mov    0x8(%eax),%eax
  1006c2:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
  1006c9:	00 
  1006ca:	89 04 24             	mov    %eax,(%esp)
  1006cd:	e8 0d 2c 00 00       	call   1032df <strfind>
  1006d2:	89 c2                	mov    %eax,%edx
  1006d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006d7:	8b 40 08             	mov    0x8(%eax),%eax
  1006da:	29 c2                	sub    %eax,%edx
  1006dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006df:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1006e2:	8b 45 08             	mov    0x8(%ebp),%eax
  1006e5:	89 44 24 10          	mov    %eax,0x10(%esp)
  1006e9:	c7 44 24 0c 44 00 00 	movl   $0x44,0xc(%esp)
  1006f0:	00 
  1006f1:	8d 45 d0             	lea    -0x30(%ebp),%eax
  1006f4:	89 44 24 08          	mov    %eax,0x8(%esp)
  1006f8:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  1006fb:	89 44 24 04          	mov    %eax,0x4(%esp)
  1006ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100702:	89 04 24             	mov    %eax,(%esp)
  100705:	e8 b9 fc ff ff       	call   1003c3 <stab_binsearch>
    if (lline <= rline) {
  10070a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10070d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100710:	39 c2                	cmp    %eax,%edx
  100712:	7f 24                	jg     100738 <debuginfo_eip+0x21f>
        info->eip_line = stabs[rline].n_desc;
  100714:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100717:	89 c2                	mov    %eax,%edx
  100719:	89 d0                	mov    %edx,%eax
  10071b:	01 c0                	add    %eax,%eax
  10071d:	01 d0                	add    %edx,%eax
  10071f:	c1 e0 02             	shl    $0x2,%eax
  100722:	89 c2                	mov    %eax,%edx
  100724:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100727:	01 d0                	add    %edx,%eax
  100729:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  10072d:	0f b7 d0             	movzwl %ax,%edx
  100730:	8b 45 0c             	mov    0xc(%ebp),%eax
  100733:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  100736:	eb 13                	jmp    10074b <debuginfo_eip+0x232>
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
    if (lline <= rline) {
        info->eip_line = stabs[rline].n_desc;
    } else {
        return -1;
  100738:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10073d:	e9 12 01 00 00       	jmp    100854 <debuginfo_eip+0x33b>
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  100742:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100745:	83 e8 01             	sub    $0x1,%eax
  100748:	89 45 d4             	mov    %eax,-0x2c(%ebp)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  10074b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10074e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100751:	39 c2                	cmp    %eax,%edx
  100753:	7c 56                	jl     1007ab <debuginfo_eip+0x292>
           && stabs[lline].n_type != N_SOL
  100755:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100758:	89 c2                	mov    %eax,%edx
  10075a:	89 d0                	mov    %edx,%eax
  10075c:	01 c0                	add    %eax,%eax
  10075e:	01 d0                	add    %edx,%eax
  100760:	c1 e0 02             	shl    $0x2,%eax
  100763:	89 c2                	mov    %eax,%edx
  100765:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100768:	01 d0                	add    %edx,%eax
  10076a:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10076e:	3c 84                	cmp    $0x84,%al
  100770:	74 39                	je     1007ab <debuginfo_eip+0x292>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  100772:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100775:	89 c2                	mov    %eax,%edx
  100777:	89 d0                	mov    %edx,%eax
  100779:	01 c0                	add    %eax,%eax
  10077b:	01 d0                	add    %edx,%eax
  10077d:	c1 e0 02             	shl    $0x2,%eax
  100780:	89 c2                	mov    %eax,%edx
  100782:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100785:	01 d0                	add    %edx,%eax
  100787:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10078b:	3c 64                	cmp    $0x64,%al
  10078d:	75 b3                	jne    100742 <debuginfo_eip+0x229>
  10078f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100792:	89 c2                	mov    %eax,%edx
  100794:	89 d0                	mov    %edx,%eax
  100796:	01 c0                	add    %eax,%eax
  100798:	01 d0                	add    %edx,%eax
  10079a:	c1 e0 02             	shl    $0x2,%eax
  10079d:	89 c2                	mov    %eax,%edx
  10079f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007a2:	01 d0                	add    %edx,%eax
  1007a4:	8b 40 08             	mov    0x8(%eax),%eax
  1007a7:	85 c0                	test   %eax,%eax
  1007a9:	74 97                	je     100742 <debuginfo_eip+0x229>
        lline --;
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  1007ab:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1007ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007b1:	39 c2                	cmp    %eax,%edx
  1007b3:	7c 46                	jl     1007fb <debuginfo_eip+0x2e2>
  1007b5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007b8:	89 c2                	mov    %eax,%edx
  1007ba:	89 d0                	mov    %edx,%eax
  1007bc:	01 c0                	add    %eax,%eax
  1007be:	01 d0                	add    %edx,%eax
  1007c0:	c1 e0 02             	shl    $0x2,%eax
  1007c3:	89 c2                	mov    %eax,%edx
  1007c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007c8:	01 d0                	add    %edx,%eax
  1007ca:	8b 10                	mov    (%eax),%edx
  1007cc:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  1007cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1007d2:	29 c1                	sub    %eax,%ecx
  1007d4:	89 c8                	mov    %ecx,%eax
  1007d6:	39 c2                	cmp    %eax,%edx
  1007d8:	73 21                	jae    1007fb <debuginfo_eip+0x2e2>
        info->eip_file = stabstr + stabs[lline].n_strx;
  1007da:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007dd:	89 c2                	mov    %eax,%edx
  1007df:	89 d0                	mov    %edx,%eax
  1007e1:	01 c0                	add    %eax,%eax
  1007e3:	01 d0                	add    %edx,%eax
  1007e5:	c1 e0 02             	shl    $0x2,%eax
  1007e8:	89 c2                	mov    %eax,%edx
  1007ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007ed:	01 d0                	add    %edx,%eax
  1007ef:	8b 10                	mov    (%eax),%edx
  1007f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1007f4:	01 c2                	add    %eax,%edx
  1007f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007f9:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  1007fb:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1007fe:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100801:	39 c2                	cmp    %eax,%edx
  100803:	7d 4a                	jge    10084f <debuginfo_eip+0x336>
        for (lline = lfun + 1;
  100805:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100808:	83 c0 01             	add    $0x1,%eax
  10080b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  10080e:	eb 18                	jmp    100828 <debuginfo_eip+0x30f>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  100810:	8b 45 0c             	mov    0xc(%ebp),%eax
  100813:	8b 40 14             	mov    0x14(%eax),%eax
  100816:	8d 50 01             	lea    0x1(%eax),%edx
  100819:	8b 45 0c             	mov    0xc(%ebp),%eax
  10081c:	89 50 14             	mov    %edx,0x14(%eax)
    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
  10081f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100822:	83 c0 01             	add    $0x1,%eax
  100825:	89 45 d4             	mov    %eax,-0x2c(%ebp)

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100828:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10082b:	8b 45 d8             	mov    -0x28(%ebp),%eax
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
  10082e:	39 c2                	cmp    %eax,%edx
  100830:	7d 1d                	jge    10084f <debuginfo_eip+0x336>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100832:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100835:	89 c2                	mov    %eax,%edx
  100837:	89 d0                	mov    %edx,%eax
  100839:	01 c0                	add    %eax,%eax
  10083b:	01 d0                	add    %edx,%eax
  10083d:	c1 e0 02             	shl    $0x2,%eax
  100840:	89 c2                	mov    %eax,%edx
  100842:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100845:	01 d0                	add    %edx,%eax
  100847:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10084b:	3c a0                	cmp    $0xa0,%al
  10084d:	74 c1                	je     100810 <debuginfo_eip+0x2f7>
             lline ++) {
            info->eip_fn_narg ++;
        }
    }
    return 0;
  10084f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100854:	c9                   	leave  
  100855:	c3                   	ret    

00100856 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100856:	55                   	push   %ebp
  100857:	89 e5                	mov    %esp,%ebp
  100859:	83 ec 18             	sub    $0x18,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  10085c:	c7 04 24 b6 36 10 00 	movl   $0x1036b6,(%esp)
  100863:	e8 ba fa ff ff       	call   100322 <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100868:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  10086f:	00 
  100870:	c7 04 24 cf 36 10 00 	movl   $0x1036cf,(%esp)
  100877:	e8 a6 fa ff ff       	call   100322 <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
  10087c:	c7 44 24 04 f4 35 10 	movl   $0x1035f4,0x4(%esp)
  100883:	00 
  100884:	c7 04 24 e7 36 10 00 	movl   $0x1036e7,(%esp)
  10088b:	e8 92 fa ff ff       	call   100322 <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
  100890:	c7 44 24 04 16 ea 10 	movl   $0x10ea16,0x4(%esp)
  100897:	00 
  100898:	c7 04 24 ff 36 10 00 	movl   $0x1036ff,(%esp)
  10089f:	e8 7e fa ff ff       	call   100322 <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
  1008a4:	c7 44 24 04 80 fd 10 	movl   $0x10fd80,0x4(%esp)
  1008ab:	00 
  1008ac:	c7 04 24 17 37 10 00 	movl   $0x103717,(%esp)
  1008b3:	e8 6a fa ff ff       	call   100322 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  1008b8:	b8 80 fd 10 00       	mov    $0x10fd80,%eax
  1008bd:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1008c3:	b8 00 00 10 00       	mov    $0x100000,%eax
  1008c8:	29 c2                	sub    %eax,%edx
  1008ca:	89 d0                	mov    %edx,%eax
  1008cc:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1008d2:	85 c0                	test   %eax,%eax
  1008d4:	0f 48 c2             	cmovs  %edx,%eax
  1008d7:	c1 f8 0a             	sar    $0xa,%eax
  1008da:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008de:	c7 04 24 30 37 10 00 	movl   $0x103730,(%esp)
  1008e5:	e8 38 fa ff ff       	call   100322 <cprintf>
}
  1008ea:	c9                   	leave  
  1008eb:	c3                   	ret    

001008ec <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  1008ec:	55                   	push   %ebp
  1008ed:	89 e5                	mov    %esp,%ebp
  1008ef:	81 ec 48 01 00 00    	sub    $0x148,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  1008f5:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1008f8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008fc:	8b 45 08             	mov    0x8(%ebp),%eax
  1008ff:	89 04 24             	mov    %eax,(%esp)
  100902:	e8 12 fc ff ff       	call   100519 <debuginfo_eip>
  100907:	85 c0                	test   %eax,%eax
  100909:	74 15                	je     100920 <print_debuginfo+0x34>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  10090b:	8b 45 08             	mov    0x8(%ebp),%eax
  10090e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100912:	c7 04 24 5a 37 10 00 	movl   $0x10375a,(%esp)
  100919:	e8 04 fa ff ff       	call   100322 <cprintf>
  10091e:	eb 6d                	jmp    10098d <print_debuginfo+0xa1>
    }
    else {
        char fnname[256];
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100920:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100927:	eb 1c                	jmp    100945 <print_debuginfo+0x59>
            fnname[j] = info.eip_fn_name[j];
  100929:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10092c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10092f:	01 d0                	add    %edx,%eax
  100931:	0f b6 00             	movzbl (%eax),%eax
  100934:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  10093a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10093d:	01 ca                	add    %ecx,%edx
  10093f:	88 02                	mov    %al,(%edx)
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
    }
    else {
        char fnname[256];
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100941:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100945:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100948:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  10094b:	7f dc                	jg     100929 <print_debuginfo+0x3d>
            fnname[j] = info.eip_fn_name[j];
        }
        fnname[j] = '\0';
  10094d:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100953:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100956:	01 d0                	add    %edx,%eax
  100958:	c6 00 00             	movb   $0x0,(%eax)
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
  10095b:	8b 45 ec             	mov    -0x14(%ebp),%eax
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
            fnname[j] = info.eip_fn_name[j];
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  10095e:	8b 55 08             	mov    0x8(%ebp),%edx
  100961:	89 d1                	mov    %edx,%ecx
  100963:	29 c1                	sub    %eax,%ecx
  100965:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100968:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10096b:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  10096f:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100975:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100979:	89 54 24 08          	mov    %edx,0x8(%esp)
  10097d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100981:	c7 04 24 76 37 10 00 	movl   $0x103776,(%esp)
  100988:	e8 95 f9 ff ff       	call   100322 <cprintf>
                fnname, eip - info.eip_fn_addr);
    }
}
  10098d:	c9                   	leave  
  10098e:	c3                   	ret    

0010098f <read_eip>:

static __noinline uint32_t
read_eip(void) {
  10098f:	55                   	push   %ebp
  100990:	89 e5                	mov    %esp,%ebp
  100992:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100995:	8b 45 04             	mov    0x4(%ebp),%eax
  100998:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  10099b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  10099e:	c9                   	leave  
  10099f:	c3                   	ret    

001009a0 <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  1009a0:	55                   	push   %ebp
  1009a1:	89 e5                	mov    %esp,%ebp
  1009a3:	83 ec 38             	sub    $0x38,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  1009a6:	89 e8                	mov    %ebp,%eax
  1009a8:	89 45 dc             	mov    %eax,-0x24(%ebp)
    return ebp;
  1009ab:	8b 45 dc             	mov    -0x24(%ebp),%eax
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
    uint32_t ebp = read_ebp(), eip = read_eip();
  1009ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1009b1:	e8 d9 ff ff ff       	call   10098f <read_eip>
  1009b6:	89 45 f0             	mov    %eax,-0x10(%ebp)

    int i, j;
    for (i = 0; ebp != 0 && i < STACKFRAME_DEPTH; i ++) {
  1009b9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  1009c0:	e9 88 00 00 00       	jmp    100a4d <print_stackframe+0xad>
        cprintf("ebp:0x%08x eip:0x%08x args:", ebp, eip);
  1009c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1009c8:	89 44 24 08          	mov    %eax,0x8(%esp)
  1009cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009cf:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009d3:	c7 04 24 88 37 10 00 	movl   $0x103788,(%esp)
  1009da:	e8 43 f9 ff ff       	call   100322 <cprintf>
        uint32_t *args = (uint32_t *)ebp + 2;
  1009df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009e2:	83 c0 08             	add    $0x8,%eax
  1009e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        for (j = 0; j < 4; j ++) {
  1009e8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  1009ef:	eb 25                	jmp    100a16 <print_stackframe+0x76>
            cprintf("0x%08x ", args[j]);
  1009f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1009f4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  1009fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1009fe:	01 d0                	add    %edx,%eax
  100a00:	8b 00                	mov    (%eax),%eax
  100a02:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a06:	c7 04 24 a4 37 10 00 	movl   $0x1037a4,(%esp)
  100a0d:	e8 10 f9 ff ff       	call   100322 <cprintf>

    int i, j;
    for (i = 0; ebp != 0 && i < STACKFRAME_DEPTH; i ++) {
        cprintf("ebp:0x%08x eip:0x%08x args:", ebp, eip);
        uint32_t *args = (uint32_t *)ebp + 2;
        for (j = 0; j < 4; j ++) {
  100a12:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
  100a16:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  100a1a:	7e d5                	jle    1009f1 <print_stackframe+0x51>
            cprintf("0x%08x ", args[j]);
        }
        cprintf("\n");
  100a1c:	c7 04 24 ac 37 10 00 	movl   $0x1037ac,(%esp)
  100a23:	e8 fa f8 ff ff       	call   100322 <cprintf>
        print_debuginfo(eip - 1);
  100a28:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100a2b:	83 e8 01             	sub    $0x1,%eax
  100a2e:	89 04 24             	mov    %eax,(%esp)
  100a31:	e8 b6 fe ff ff       	call   1008ec <print_debuginfo>
        eip = ((uint32_t *)ebp)[1];
  100a36:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a39:	83 c0 04             	add    $0x4,%eax
  100a3c:	8b 00                	mov    (%eax),%eax
  100a3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
        ebp = ((uint32_t *)ebp)[0];
  100a41:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a44:	8b 00                	mov    (%eax),%eax
  100a46:	89 45 f4             	mov    %eax,-0xc(%ebp)
      *                   the calling funciton's ebp = ss:[ebp]
      */
    uint32_t ebp = read_ebp(), eip = read_eip();

    int i, j;
    for (i = 0; ebp != 0 && i < STACKFRAME_DEPTH; i ++) {
  100a49:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  100a4d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100a51:	74 0a                	je     100a5d <print_stackframe+0xbd>
  100a53:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
  100a57:	0f 8e 68 ff ff ff    	jle    1009c5 <print_stackframe+0x25>
        cprintf("\n");
        print_debuginfo(eip - 1);
        eip = ((uint32_t *)ebp)[1];
        ebp = ((uint32_t *)ebp)[0];
    }
}
  100a5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100a60:	89 44 24 08          	mov    %eax,0x8(%esp)
  100a64:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a67:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a6b:	c7 04 24 88 37 10 00 	movl   $0x103788,(%esp)
  100a72:	e8 ab f8 ff ff       	call   100322 <cprintf>

  100a77:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a7a:	83 c0 08             	add    $0x8,%eax
  100a7d:	89 45 e0             	mov    %eax,-0x20(%ebp)
//函数堆栈
  100a80:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  100a87:	eb 25                	jmp    100aae <print_stackframe+0x10e>
// | 栈底方向 		| 高位地址
  100a89:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100a8c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100a93:	8b 45 e0             	mov    -0x20(%ebp),%eax
  100a96:	01 d0                	add    %edx,%eax
  100a98:	8b 00                	mov    (%eax),%eax
  100a9a:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a9e:	c7 04 24 a4 37 10 00 	movl   $0x1037a4,(%esp)
  100aa5:	e8 78 f8 ff ff       	call   100322 <cprintf>
        eip = ((uint32_t *)ebp)[1];
        ebp = ((uint32_t *)ebp)[0];
    }
}

//函数堆栈
  100aaa:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
  100aae:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  100ab2:	7e d5                	jle    100a89 <print_stackframe+0xe9>
// | 栈底方向 		| 高位地址
// | 。。。  		|
// | 。。。 		|
  100ab4:	c7 04 24 ac 37 10 00 	movl   $0x1037ac,(%esp)
  100abb:	e8 62 f8 ff ff       	call   100322 <cprintf>
// | 参数3 			|
  100ac0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100ac3:	83 e8 01             	sub    $0x1,%eax
  100ac6:	89 04 24             	mov    %eax,(%esp)
  100ac9:	e8 1e fe ff ff       	call   1008ec <print_debuginfo>
// | 参数2 			|
  100ace:	c9                   	leave  
  100acf:	c3                   	ret    

00100ad0 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100ad0:	55                   	push   %ebp
  100ad1:	89 e5                	mov    %esp,%ebp
  100ad3:	83 ec 28             	sub    $0x28,%esp
    int argc = 0;
  100ad6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100add:	eb 0c                	jmp    100aeb <parse+0x1b>
            *buf ++ = '\0';
  100adf:	8b 45 08             	mov    0x8(%ebp),%eax
  100ae2:	8d 50 01             	lea    0x1(%eax),%edx
  100ae5:	89 55 08             	mov    %edx,0x8(%ebp)
  100ae8:	c6 00 00             	movb   $0x0,(%eax)
static int
parse(char *buf, char **argv) {
    int argc = 0;
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100aeb:	8b 45 08             	mov    0x8(%ebp),%eax
  100aee:	0f b6 00             	movzbl (%eax),%eax
  100af1:	84 c0                	test   %al,%al
  100af3:	74 1d                	je     100b12 <parse+0x42>
  100af5:	8b 45 08             	mov    0x8(%ebp),%eax
  100af8:	0f b6 00             	movzbl (%eax),%eax
  100afb:	0f be c0             	movsbl %al,%eax
  100afe:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b02:	c7 04 24 30 38 10 00 	movl   $0x103830,(%esp)
  100b09:	e8 9e 27 00 00       	call   1032ac <strchr>
  100b0e:	85 c0                	test   %eax,%eax
  100b10:	75 cd                	jne    100adf <parse+0xf>
            *buf ++ = '\0';
        }
        if (*buf == '\0') {
  100b12:	8b 45 08             	mov    0x8(%ebp),%eax
  100b15:	0f b6 00             	movzbl (%eax),%eax
  100b18:	84 c0                	test   %al,%al
  100b1a:	75 02                	jne    100b1e <parse+0x4e>
            break;
  100b1c:	eb 67                	jmp    100b85 <parse+0xb5>
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100b1e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100b22:	75 14                	jne    100b38 <parse+0x68>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100b24:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  100b2b:	00 
  100b2c:	c7 04 24 35 38 10 00 	movl   $0x103835,(%esp)
  100b33:	e8 ea f7 ff ff       	call   100322 <cprintf>
        }
        argv[argc ++] = buf;
  100b38:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b3b:	8d 50 01             	lea    0x1(%eax),%edx
  100b3e:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100b41:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100b48:	8b 45 0c             	mov    0xc(%ebp),%eax
  100b4b:	01 c2                	add    %eax,%edx
  100b4d:	8b 45 08             	mov    0x8(%ebp),%eax
  100b50:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100b52:	eb 04                	jmp    100b58 <parse+0x88>
            buf ++;
  100b54:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        // save and scan past next arg
        if (argc == MAXARGS - 1) {
            cprintf("Too many arguments (max %d).\n", MAXARGS);
        }
        argv[argc ++] = buf;
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100b58:	8b 45 08             	mov    0x8(%ebp),%eax
  100b5b:	0f b6 00             	movzbl (%eax),%eax
  100b5e:	84 c0                	test   %al,%al
  100b60:	74 1d                	je     100b7f <parse+0xaf>
  100b62:	8b 45 08             	mov    0x8(%ebp),%eax
  100b65:	0f b6 00             	movzbl (%eax),%eax
  100b68:	0f be c0             	movsbl %al,%eax
  100b6b:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b6f:	c7 04 24 30 38 10 00 	movl   $0x103830,(%esp)
  100b76:	e8 31 27 00 00       	call   1032ac <strchr>
  100b7b:	85 c0                	test   %eax,%eax
  100b7d:	74 d5                	je     100b54 <parse+0x84>
            buf ++;
        }
    }
  100b7f:	90                   	nop
static int
parse(char *buf, char **argv) {
    int argc = 0;
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b80:	e9 66 ff ff ff       	jmp    100aeb <parse+0x1b>
        argv[argc ++] = buf;
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
            buf ++;
        }
    }
    return argc;
  100b85:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100b88:	c9                   	leave  
  100b89:	c3                   	ret    

00100b8a <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100b8a:	55                   	push   %ebp
  100b8b:	89 e5                	mov    %esp,%ebp
  100b8d:	83 ec 68             	sub    $0x68,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100b90:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100b93:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b97:	8b 45 08             	mov    0x8(%ebp),%eax
  100b9a:	89 04 24             	mov    %eax,(%esp)
  100b9d:	e8 2e ff ff ff       	call   100ad0 <parse>
  100ba2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100ba5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100ba9:	75 0a                	jne    100bb5 <runcmd+0x2b>
        return 0;
  100bab:	b8 00 00 00 00       	mov    $0x0,%eax
  100bb0:	e9 85 00 00 00       	jmp    100c3a <runcmd+0xb0>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100bb5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100bbc:	eb 5c                	jmp    100c1a <runcmd+0x90>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100bbe:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100bc1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100bc4:	89 d0                	mov    %edx,%eax
  100bc6:	01 c0                	add    %eax,%eax
  100bc8:	01 d0                	add    %edx,%eax
  100bca:	c1 e0 02             	shl    $0x2,%eax
  100bcd:	05 00 e0 10 00       	add    $0x10e000,%eax
  100bd2:	8b 00                	mov    (%eax),%eax
  100bd4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100bd8:	89 04 24             	mov    %eax,(%esp)
  100bdb:	e8 2d 26 00 00       	call   10320d <strcmp>
  100be0:	85 c0                	test   %eax,%eax
  100be2:	75 32                	jne    100c16 <runcmd+0x8c>
            return commands[i].func(argc - 1, argv + 1, tf);
  100be4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100be7:	89 d0                	mov    %edx,%eax
  100be9:	01 c0                	add    %eax,%eax
  100beb:	01 d0                	add    %edx,%eax
  100bed:	c1 e0 02             	shl    $0x2,%eax
  100bf0:	05 00 e0 10 00       	add    $0x10e000,%eax
  100bf5:	8b 40 08             	mov    0x8(%eax),%eax
  100bf8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100bfb:	8d 4a ff             	lea    -0x1(%edx),%ecx
  100bfe:	8b 55 0c             	mov    0xc(%ebp),%edx
  100c01:	89 54 24 08          	mov    %edx,0x8(%esp)
  100c05:	8d 55 b0             	lea    -0x50(%ebp),%edx
  100c08:	83 c2 04             	add    $0x4,%edx
  100c0b:	89 54 24 04          	mov    %edx,0x4(%esp)
  100c0f:	89 0c 24             	mov    %ecx,(%esp)
  100c12:	ff d0                	call   *%eax
  100c14:	eb 24                	jmp    100c3a <runcmd+0xb0>
    int argc = parse(buf, argv);
    if (argc == 0) {
        return 0;
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100c16:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100c1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c1d:	83 f8 02             	cmp    $0x2,%eax
  100c20:	76 9c                	jbe    100bbe <runcmd+0x34>
        if (strcmp(commands[i].name, argv[0]) == 0) {
            return commands[i].func(argc - 1, argv + 1, tf);
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100c22:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100c25:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c29:	c7 04 24 53 38 10 00 	movl   $0x103853,(%esp)
  100c30:	e8 ed f6 ff ff       	call   100322 <cprintf>
    return 0;
  100c35:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100c3a:	c9                   	leave  
  100c3b:	c3                   	ret    

00100c3c <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100c3c:	55                   	push   %ebp
  100c3d:	89 e5                	mov    %esp,%ebp
  100c3f:	83 ec 28             	sub    $0x28,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100c42:	c7 04 24 6c 38 10 00 	movl   $0x10386c,(%esp)
  100c49:	e8 d4 f6 ff ff       	call   100322 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
  100c4e:	c7 04 24 94 38 10 00 	movl   $0x103894,(%esp)
  100c55:	e8 c8 f6 ff ff       	call   100322 <cprintf>

    if (tf != NULL) {
  100c5a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100c5e:	74 0b                	je     100c6b <kmonitor+0x2f>
        print_trapframe(tf);
  100c60:	8b 45 08             	mov    0x8(%ebp),%eax
  100c63:	89 04 24             	mov    %eax,(%esp)
  100c66:	e8 de 0d 00 00       	call   101a49 <print_trapframe>
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100c6b:	c7 04 24 b9 38 10 00 	movl   $0x1038b9,(%esp)
  100c72:	e8 a2 f5 ff ff       	call   100219 <readline>
  100c77:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100c7a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100c7e:	74 18                	je     100c98 <kmonitor+0x5c>
            if (runcmd(buf, tf) < 0) {
  100c80:	8b 45 08             	mov    0x8(%ebp),%eax
  100c83:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c87:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c8a:	89 04 24             	mov    %eax,(%esp)
  100c8d:	e8 f8 fe ff ff       	call   100b8a <runcmd>
  100c92:	85 c0                	test   %eax,%eax
  100c94:	79 02                	jns    100c98 <kmonitor+0x5c>
                break;
  100c96:	eb 02                	jmp    100c9a <kmonitor+0x5e>
            }
        }
    }
  100c98:	eb d1                	jmp    100c6b <kmonitor+0x2f>
}
  100c9a:	c9                   	leave  
  100c9b:	c3                   	ret    

00100c9c <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100c9c:	55                   	push   %ebp
  100c9d:	89 e5                	mov    %esp,%ebp
  100c9f:	83 ec 28             	sub    $0x28,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100ca2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100ca9:	eb 3f                	jmp    100cea <mon_help+0x4e>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100cab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100cae:	89 d0                	mov    %edx,%eax
  100cb0:	01 c0                	add    %eax,%eax
  100cb2:	01 d0                	add    %edx,%eax
  100cb4:	c1 e0 02             	shl    $0x2,%eax
  100cb7:	05 00 e0 10 00       	add    $0x10e000,%eax
  100cbc:	8b 48 04             	mov    0x4(%eax),%ecx
  100cbf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100cc2:	89 d0                	mov    %edx,%eax
  100cc4:	01 c0                	add    %eax,%eax
  100cc6:	01 d0                	add    %edx,%eax
  100cc8:	c1 e0 02             	shl    $0x2,%eax
  100ccb:	05 00 e0 10 00       	add    $0x10e000,%eax
  100cd0:	8b 00                	mov    (%eax),%eax
  100cd2:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100cd6:	89 44 24 04          	mov    %eax,0x4(%esp)
  100cda:	c7 04 24 bd 38 10 00 	movl   $0x1038bd,(%esp)
  100ce1:	e8 3c f6 ff ff       	call   100322 <cprintf>

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100ce6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100cea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ced:	83 f8 02             	cmp    $0x2,%eax
  100cf0:	76 b9                	jbe    100cab <mon_help+0xf>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
    }
    return 0;
  100cf2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100cf7:	c9                   	leave  
  100cf8:	c3                   	ret    

00100cf9 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100cf9:	55                   	push   %ebp
  100cfa:	89 e5                	mov    %esp,%ebp
  100cfc:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100cff:	e8 52 fb ff ff       	call   100856 <print_kerninfo>
    return 0;
  100d04:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d09:	c9                   	leave  
  100d0a:	c3                   	ret    

00100d0b <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100d0b:	55                   	push   %ebp
  100d0c:	89 e5                	mov    %esp,%ebp
  100d0e:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100d11:	e8 8a fc ff ff       	call   1009a0 <print_stackframe>
    return 0;
  100d16:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d1b:	c9                   	leave  
  100d1c:	c3                   	ret    

00100d1d <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  100d1d:	55                   	push   %ebp
  100d1e:	89 e5                	mov    %esp,%ebp
  100d20:	83 ec 28             	sub    $0x28,%esp
    if (is_panic) {
  100d23:	a1 40 ee 10 00       	mov    0x10ee40,%eax
  100d28:	85 c0                	test   %eax,%eax
  100d2a:	74 02                	je     100d2e <__panic+0x11>
        goto panic_dead;
  100d2c:	eb 59                	jmp    100d87 <__panic+0x6a>
    }
    is_panic = 1;
  100d2e:	c7 05 40 ee 10 00 01 	movl   $0x1,0x10ee40
  100d35:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  100d38:	8d 45 14             	lea    0x14(%ebp),%eax
  100d3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  100d3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  100d41:	89 44 24 08          	mov    %eax,0x8(%esp)
  100d45:	8b 45 08             	mov    0x8(%ebp),%eax
  100d48:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d4c:	c7 04 24 c6 38 10 00 	movl   $0x1038c6,(%esp)
  100d53:	e8 ca f5 ff ff       	call   100322 <cprintf>
    vcprintf(fmt, ap);
  100d58:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d5b:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d5f:	8b 45 10             	mov    0x10(%ebp),%eax
  100d62:	89 04 24             	mov    %eax,(%esp)
  100d65:	e8 85 f5 ff ff       	call   1002ef <vcprintf>
    cprintf("\n");
  100d6a:	c7 04 24 e2 38 10 00 	movl   $0x1038e2,(%esp)
  100d71:	e8 ac f5 ff ff       	call   100322 <cprintf>
    
    cprintf("stack trackback:\n");
  100d76:	c7 04 24 e4 38 10 00 	movl   $0x1038e4,(%esp)
  100d7d:	e8 a0 f5 ff ff       	call   100322 <cprintf>
    print_stackframe();
  100d82:	e8 19 fc ff ff       	call   1009a0 <print_stackframe>
    
    va_end(ap);

panic_dead:
    intr_disable();
  100d87:	e8 22 09 00 00       	call   1016ae <intr_disable>
    while (1) {
        kmonitor(NULL);
  100d8c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100d93:	e8 a4 fe ff ff       	call   100c3c <kmonitor>
    }
  100d98:	eb f2                	jmp    100d8c <__panic+0x6f>

00100d9a <__warn>:
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100d9a:	55                   	push   %ebp
  100d9b:	89 e5                	mov    %esp,%ebp
  100d9d:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    va_start(ap, fmt);
  100da0:	8d 45 14             	lea    0x14(%ebp),%eax
  100da3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  100da6:	8b 45 0c             	mov    0xc(%ebp),%eax
  100da9:	89 44 24 08          	mov    %eax,0x8(%esp)
  100dad:	8b 45 08             	mov    0x8(%ebp),%eax
  100db0:	89 44 24 04          	mov    %eax,0x4(%esp)
  100db4:	c7 04 24 f6 38 10 00 	movl   $0x1038f6,(%esp)
  100dbb:	e8 62 f5 ff ff       	call   100322 <cprintf>
    vcprintf(fmt, ap);
  100dc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100dc3:	89 44 24 04          	mov    %eax,0x4(%esp)
  100dc7:	8b 45 10             	mov    0x10(%ebp),%eax
  100dca:	89 04 24             	mov    %eax,(%esp)
  100dcd:	e8 1d f5 ff ff       	call   1002ef <vcprintf>
    cprintf("\n");
  100dd2:	c7 04 24 e2 38 10 00 	movl   $0x1038e2,(%esp)
  100dd9:	e8 44 f5 ff ff       	call   100322 <cprintf>
    va_end(ap);
}
  100dde:	c9                   	leave  
  100ddf:	c3                   	ret    

00100de0 <is_kernel_panic>:

bool
is_kernel_panic(void) {
  100de0:	55                   	push   %ebp
  100de1:	89 e5                	mov    %esp,%ebp
    return is_panic;
  100de3:	a1 40 ee 10 00       	mov    0x10ee40,%eax
}
  100de8:	5d                   	pop    %ebp
  100de9:	c3                   	ret    

00100dea <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100dea:	55                   	push   %ebp
  100deb:	89 e5                	mov    %esp,%ebp
  100ded:	83 ec 28             	sub    $0x28,%esp
  100df0:	66 c7 45 f6 43 00    	movw   $0x43,-0xa(%ebp)
  100df6:	c6 45 f5 34          	movb   $0x34,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100dfa:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100dfe:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100e02:	ee                   	out    %al,(%dx)
  100e03:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100e09:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
  100e0d:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100e11:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100e15:	ee                   	out    %al,(%dx)
  100e16:	66 c7 45 ee 40 00    	movw   $0x40,-0x12(%ebp)
  100e1c:	c6 45 ed 2e          	movb   $0x2e,-0x13(%ebp)
  100e20:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100e24:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100e28:	ee                   	out    %al,(%dx)
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100e29:	c7 05 08 f9 10 00 00 	movl   $0x0,0x10f908
  100e30:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100e33:	c7 04 24 14 39 10 00 	movl   $0x103914,(%esp)
  100e3a:	e8 e3 f4 ff ff       	call   100322 <cprintf>
    pic_enable(IRQ_TIMER);
  100e3f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100e46:	e8 c1 08 00 00       	call   10170c <pic_enable>
}
  100e4b:	c9                   	leave  
  100e4c:	c3                   	ret    

00100e4d <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100e4d:	55                   	push   %ebp
  100e4e:	89 e5                	mov    %esp,%ebp
  100e50:	83 ec 10             	sub    $0x10,%esp
  100e53:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100e59:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100e5d:	89 c2                	mov    %eax,%edx
  100e5f:	ec                   	in     (%dx),%al
  100e60:	88 45 fd             	mov    %al,-0x3(%ebp)
  100e63:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100e69:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100e6d:	89 c2                	mov    %eax,%edx
  100e6f:	ec                   	in     (%dx),%al
  100e70:	88 45 f9             	mov    %al,-0x7(%ebp)
  100e73:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100e79:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100e7d:	89 c2                	mov    %eax,%edx
  100e7f:	ec                   	in     (%dx),%al
  100e80:	88 45 f5             	mov    %al,-0xb(%ebp)
  100e83:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
  100e89:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100e8d:	89 c2                	mov    %eax,%edx
  100e8f:	ec                   	in     (%dx),%al
  100e90:	88 45 f1             	mov    %al,-0xf(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100e93:	c9                   	leave  
  100e94:	c3                   	ret    

00100e95 <cga_init>:
static uint16_t addr_6845;

/* TEXT-mode CGA/VGA display output */

static void
cga_init(void) {
  100e95:	55                   	push   %ebp
  100e96:	89 e5                	mov    %esp,%ebp
  100e98:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;
  100e9b:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;
  100ea2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ea5:	0f b7 00             	movzwl (%eax),%eax
  100ea8:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;
  100eac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100eaf:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {
  100eb4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100eb7:	0f b7 00             	movzwl (%eax),%eax
  100eba:	66 3d 5a a5          	cmp    $0xa55a,%ax
  100ebe:	74 12                	je     100ed2 <cga_init+0x3d>
        cp = (uint16_t*)MONO_BUF;
  100ec0:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;
  100ec7:	66 c7 05 66 ee 10 00 	movw   $0x3b4,0x10ee66
  100ece:	b4 03 
  100ed0:	eb 13                	jmp    100ee5 <cga_init+0x50>
    } else {
        *cp = was;
  100ed2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ed5:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100ed9:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;
  100edc:	66 c7 05 66 ee 10 00 	movw   $0x3d4,0x10ee66
  100ee3:	d4 03 
    }

    // Extract cursor location
    uint32_t pos;
    outb(addr_6845, 14);
  100ee5:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100eec:	0f b7 c0             	movzwl %ax,%eax
  100eef:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  100ef3:	c6 45 f1 0e          	movb   $0xe,-0xf(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100ef7:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100efb:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100eff:	ee                   	out    %al,(%dx)
    pos = inb(addr_6845 + 1) << 8;
  100f00:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100f07:	83 c0 01             	add    $0x1,%eax
  100f0a:	0f b7 c0             	movzwl %ax,%eax
  100f0d:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f11:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  100f15:	89 c2                	mov    %eax,%edx
  100f17:	ec                   	in     (%dx),%al
  100f18:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  100f1b:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f1f:	0f b6 c0             	movzbl %al,%eax
  100f22:	c1 e0 08             	shl    $0x8,%eax
  100f25:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100f28:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100f2f:	0f b7 c0             	movzwl %ax,%eax
  100f32:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
  100f36:	c6 45 e9 0f          	movb   $0xf,-0x17(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f3a:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100f3e:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100f42:	ee                   	out    %al,(%dx)
    pos |= inb(addr_6845 + 1);
  100f43:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100f4a:	83 c0 01             	add    $0x1,%eax
  100f4d:	0f b7 c0             	movzwl %ax,%eax
  100f50:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f54:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
  100f58:	89 c2                	mov    %eax,%edx
  100f5a:	ec                   	in     (%dx),%al
  100f5b:	88 45 e5             	mov    %al,-0x1b(%ebp)
    return data;
  100f5e:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100f62:	0f b6 c0             	movzbl %al,%eax
  100f65:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;
  100f68:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f6b:	a3 60 ee 10 00       	mov    %eax,0x10ee60
    crt_pos = pos;
  100f70:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100f73:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
}
  100f79:	c9                   	leave  
  100f7a:	c3                   	ret    

00100f7b <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100f7b:	55                   	push   %ebp
  100f7c:	89 e5                	mov    %esp,%ebp
  100f7e:	83 ec 48             	sub    $0x48,%esp
  100f81:	66 c7 45 f6 fa 03    	movw   $0x3fa,-0xa(%ebp)
  100f87:	c6 45 f5 00          	movb   $0x0,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f8b:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100f8f:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100f93:	ee                   	out    %al,(%dx)
  100f94:	66 c7 45 f2 fb 03    	movw   $0x3fb,-0xe(%ebp)
  100f9a:	c6 45 f1 80          	movb   $0x80,-0xf(%ebp)
  100f9e:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100fa2:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100fa6:	ee                   	out    %al,(%dx)
  100fa7:	66 c7 45 ee f8 03    	movw   $0x3f8,-0x12(%ebp)
  100fad:	c6 45 ed 0c          	movb   $0xc,-0x13(%ebp)
  100fb1:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100fb5:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100fb9:	ee                   	out    %al,(%dx)
  100fba:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100fc0:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
  100fc4:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100fc8:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100fcc:	ee                   	out    %al,(%dx)
  100fcd:	66 c7 45 e6 fb 03    	movw   $0x3fb,-0x1a(%ebp)
  100fd3:	c6 45 e5 03          	movb   $0x3,-0x1b(%ebp)
  100fd7:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100fdb:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100fdf:	ee                   	out    %al,(%dx)
  100fe0:	66 c7 45 e2 fc 03    	movw   $0x3fc,-0x1e(%ebp)
  100fe6:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
  100fea:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100fee:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100ff2:	ee                   	out    %al,(%dx)
  100ff3:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  100ff9:	c6 45 dd 01          	movb   $0x1,-0x23(%ebp)
  100ffd:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101001:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  101005:	ee                   	out    %al,(%dx)
  101006:	66 c7 45 da fd 03    	movw   $0x3fd,-0x26(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10100c:	0f b7 45 da          	movzwl -0x26(%ebp),%eax
  101010:	89 c2                	mov    %eax,%edx
  101012:	ec                   	in     (%dx),%al
  101013:	88 45 d9             	mov    %al,-0x27(%ebp)
    return data;
  101016:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  10101a:	3c ff                	cmp    $0xff,%al
  10101c:	0f 95 c0             	setne  %al
  10101f:	0f b6 c0             	movzbl %al,%eax
  101022:	a3 68 ee 10 00       	mov    %eax,0x10ee68
  101027:	66 c7 45 d6 fa 03    	movw   $0x3fa,-0x2a(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10102d:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
  101031:	89 c2                	mov    %eax,%edx
  101033:	ec                   	in     (%dx),%al
  101034:	88 45 d5             	mov    %al,-0x2b(%ebp)
  101037:	66 c7 45 d2 f8 03    	movw   $0x3f8,-0x2e(%ebp)
  10103d:	0f b7 45 d2          	movzwl -0x2e(%ebp),%eax
  101041:	89 c2                	mov    %eax,%edx
  101043:	ec                   	in     (%dx),%al
  101044:	88 45 d1             	mov    %al,-0x2f(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  101047:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  10104c:	85 c0                	test   %eax,%eax
  10104e:	74 0c                	je     10105c <serial_init+0xe1>
        pic_enable(IRQ_COM1);
  101050:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  101057:	e8 b0 06 00 00       	call   10170c <pic_enable>
    }
}
  10105c:	c9                   	leave  
  10105d:	c3                   	ret    

0010105e <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  10105e:	55                   	push   %ebp
  10105f:	89 e5                	mov    %esp,%ebp
  101061:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101064:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10106b:	eb 09                	jmp    101076 <lpt_putc_sub+0x18>
        delay();
  10106d:	e8 db fd ff ff       	call   100e4d <delay>
}

static void
lpt_putc_sub(int c) {
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101072:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101076:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  10107c:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101080:	89 c2                	mov    %eax,%edx
  101082:	ec                   	in     (%dx),%al
  101083:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101086:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10108a:	84 c0                	test   %al,%al
  10108c:	78 09                	js     101097 <lpt_putc_sub+0x39>
  10108e:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101095:	7e d6                	jle    10106d <lpt_putc_sub+0xf>
        delay();
    }
    outb(LPTPORT + 0, c);
  101097:	8b 45 08             	mov    0x8(%ebp),%eax
  10109a:	0f b6 c0             	movzbl %al,%eax
  10109d:	66 c7 45 f6 78 03    	movw   $0x378,-0xa(%ebp)
  1010a3:	88 45 f5             	mov    %al,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010a6:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1010aa:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1010ae:	ee                   	out    %al,(%dx)
  1010af:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  1010b5:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
  1010b9:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1010bd:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1010c1:	ee                   	out    %al,(%dx)
  1010c2:	66 c7 45 ee 7a 03    	movw   $0x37a,-0x12(%ebp)
  1010c8:	c6 45 ed 08          	movb   $0x8,-0x13(%ebp)
  1010cc:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1010d0:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1010d4:	ee                   	out    %al,(%dx)
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  1010d5:	c9                   	leave  
  1010d6:	c3                   	ret    

001010d7 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  1010d7:	55                   	push   %ebp
  1010d8:	89 e5                	mov    %esp,%ebp
  1010da:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  1010dd:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  1010e1:	74 0d                	je     1010f0 <lpt_putc+0x19>
        lpt_putc_sub(c);
  1010e3:	8b 45 08             	mov    0x8(%ebp),%eax
  1010e6:	89 04 24             	mov    %eax,(%esp)
  1010e9:	e8 70 ff ff ff       	call   10105e <lpt_putc_sub>
  1010ee:	eb 24                	jmp    101114 <lpt_putc+0x3d>
    }
    else {
        lpt_putc_sub('\b');
  1010f0:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1010f7:	e8 62 ff ff ff       	call   10105e <lpt_putc_sub>
        lpt_putc_sub(' ');
  1010fc:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101103:	e8 56 ff ff ff       	call   10105e <lpt_putc_sub>
        lpt_putc_sub('\b');
  101108:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10110f:	e8 4a ff ff ff       	call   10105e <lpt_putc_sub>
    }
}
  101114:	c9                   	leave  
  101115:	c3                   	ret    

00101116 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  101116:	55                   	push   %ebp
  101117:	89 e5                	mov    %esp,%ebp
  101119:	53                   	push   %ebx
  10111a:	83 ec 34             	sub    $0x34,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  10111d:	8b 45 08             	mov    0x8(%ebp),%eax
  101120:	b0 00                	mov    $0x0,%al
  101122:	85 c0                	test   %eax,%eax
  101124:	75 07                	jne    10112d <cga_putc+0x17>
        c |= 0x0700;
  101126:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  10112d:	8b 45 08             	mov    0x8(%ebp),%eax
  101130:	0f b6 c0             	movzbl %al,%eax
  101133:	83 f8 0a             	cmp    $0xa,%eax
  101136:	74 4c                	je     101184 <cga_putc+0x6e>
  101138:	83 f8 0d             	cmp    $0xd,%eax
  10113b:	74 57                	je     101194 <cga_putc+0x7e>
  10113d:	83 f8 08             	cmp    $0x8,%eax
  101140:	0f 85 88 00 00 00    	jne    1011ce <cga_putc+0xb8>
    case '\b':
        if (crt_pos > 0) {
  101146:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10114d:	66 85 c0             	test   %ax,%ax
  101150:	74 30                	je     101182 <cga_putc+0x6c>
            crt_pos --;
  101152:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101159:	83 e8 01             	sub    $0x1,%eax
  10115c:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  101162:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  101167:	0f b7 15 64 ee 10 00 	movzwl 0x10ee64,%edx
  10116e:	0f b7 d2             	movzwl %dx,%edx
  101171:	01 d2                	add    %edx,%edx
  101173:	01 c2                	add    %eax,%edx
  101175:	8b 45 08             	mov    0x8(%ebp),%eax
  101178:	b0 00                	mov    $0x0,%al
  10117a:	83 c8 20             	or     $0x20,%eax
  10117d:	66 89 02             	mov    %ax,(%edx)
        }
        break;
  101180:	eb 72                	jmp    1011f4 <cga_putc+0xde>
  101182:	eb 70                	jmp    1011f4 <cga_putc+0xde>
    case '\n':
        crt_pos += CRT_COLS;
  101184:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10118b:	83 c0 50             	add    $0x50,%eax
  10118e:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  101194:	0f b7 1d 64 ee 10 00 	movzwl 0x10ee64,%ebx
  10119b:	0f b7 0d 64 ee 10 00 	movzwl 0x10ee64,%ecx
  1011a2:	0f b7 c1             	movzwl %cx,%eax
  1011a5:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  1011ab:	c1 e8 10             	shr    $0x10,%eax
  1011ae:	89 c2                	mov    %eax,%edx
  1011b0:	66 c1 ea 06          	shr    $0x6,%dx
  1011b4:	89 d0                	mov    %edx,%eax
  1011b6:	c1 e0 02             	shl    $0x2,%eax
  1011b9:	01 d0                	add    %edx,%eax
  1011bb:	c1 e0 04             	shl    $0x4,%eax
  1011be:	29 c1                	sub    %eax,%ecx
  1011c0:	89 ca                	mov    %ecx,%edx
  1011c2:	89 d8                	mov    %ebx,%eax
  1011c4:	29 d0                	sub    %edx,%eax
  1011c6:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
        break;
  1011cc:	eb 26                	jmp    1011f4 <cga_putc+0xde>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  1011ce:	8b 0d 60 ee 10 00    	mov    0x10ee60,%ecx
  1011d4:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1011db:	8d 50 01             	lea    0x1(%eax),%edx
  1011de:	66 89 15 64 ee 10 00 	mov    %dx,0x10ee64
  1011e5:	0f b7 c0             	movzwl %ax,%eax
  1011e8:	01 c0                	add    %eax,%eax
  1011ea:	8d 14 01             	lea    (%ecx,%eax,1),%edx
  1011ed:	8b 45 08             	mov    0x8(%ebp),%eax
  1011f0:	66 89 02             	mov    %ax,(%edx)
        break;
  1011f3:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  1011f4:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1011fb:	66 3d cf 07          	cmp    $0x7cf,%ax
  1011ff:	76 5b                	jbe    10125c <cga_putc+0x146>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  101201:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  101206:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  10120c:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  101211:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
  101218:	00 
  101219:	89 54 24 04          	mov    %edx,0x4(%esp)
  10121d:	89 04 24             	mov    %eax,(%esp)
  101220:	e8 85 22 00 00       	call   1034aa <memmove>
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101225:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  10122c:	eb 15                	jmp    101243 <cga_putc+0x12d>
            crt_buf[i] = 0x0700 | ' ';
  10122e:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  101233:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101236:	01 d2                	add    %edx,%edx
  101238:	01 d0                	add    %edx,%eax
  10123a:	66 c7 00 20 07       	movw   $0x720,(%eax)

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  10123f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101243:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  10124a:	7e e2                	jle    10122e <cga_putc+0x118>
            crt_buf[i] = 0x0700 | ' ';
        }
        crt_pos -= CRT_COLS;
  10124c:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101253:	83 e8 50             	sub    $0x50,%eax
  101256:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  10125c:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  101263:	0f b7 c0             	movzwl %ax,%eax
  101266:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  10126a:	c6 45 f1 0e          	movb   $0xe,-0xf(%ebp)
  10126e:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101272:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101276:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos >> 8);
  101277:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10127e:	66 c1 e8 08          	shr    $0x8,%ax
  101282:	0f b6 c0             	movzbl %al,%eax
  101285:	0f b7 15 66 ee 10 00 	movzwl 0x10ee66,%edx
  10128c:	83 c2 01             	add    $0x1,%edx
  10128f:	0f b7 d2             	movzwl %dx,%edx
  101292:	66 89 55 ee          	mov    %dx,-0x12(%ebp)
  101296:	88 45 ed             	mov    %al,-0x13(%ebp)
  101299:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  10129d:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1012a1:	ee                   	out    %al,(%dx)
    outb(addr_6845, 15);
  1012a2:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  1012a9:	0f b7 c0             	movzwl %ax,%eax
  1012ac:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
  1012b0:	c6 45 e9 0f          	movb   $0xf,-0x17(%ebp)
  1012b4:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1012b8:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  1012bc:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos);
  1012bd:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1012c4:	0f b6 c0             	movzbl %al,%eax
  1012c7:	0f b7 15 66 ee 10 00 	movzwl 0x10ee66,%edx
  1012ce:	83 c2 01             	add    $0x1,%edx
  1012d1:	0f b7 d2             	movzwl %dx,%edx
  1012d4:	66 89 55 e6          	mov    %dx,-0x1a(%ebp)
  1012d8:	88 45 e5             	mov    %al,-0x1b(%ebp)
  1012db:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  1012df:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  1012e3:	ee                   	out    %al,(%dx)
}
  1012e4:	83 c4 34             	add    $0x34,%esp
  1012e7:	5b                   	pop    %ebx
  1012e8:	5d                   	pop    %ebp
  1012e9:	c3                   	ret    

001012ea <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  1012ea:	55                   	push   %ebp
  1012eb:	89 e5                	mov    %esp,%ebp
  1012ed:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1012f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1012f7:	eb 09                	jmp    101302 <serial_putc_sub+0x18>
        delay();
  1012f9:	e8 4f fb ff ff       	call   100e4d <delay>
}

static void
serial_putc_sub(int c) {
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1012fe:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101302:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101308:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10130c:	89 c2                	mov    %eax,%edx
  10130e:	ec                   	in     (%dx),%al
  10130f:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101312:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101316:	0f b6 c0             	movzbl %al,%eax
  101319:	83 e0 20             	and    $0x20,%eax
  10131c:	85 c0                	test   %eax,%eax
  10131e:	75 09                	jne    101329 <serial_putc_sub+0x3f>
  101320:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101327:	7e d0                	jle    1012f9 <serial_putc_sub+0xf>
        delay();
    }
    outb(COM1 + COM_TX, c);
  101329:	8b 45 08             	mov    0x8(%ebp),%eax
  10132c:	0f b6 c0             	movzbl %al,%eax
  10132f:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  101335:	88 45 f5             	mov    %al,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101338:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  10133c:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101340:	ee                   	out    %al,(%dx)
}
  101341:	c9                   	leave  
  101342:	c3                   	ret    

00101343 <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  101343:	55                   	push   %ebp
  101344:	89 e5                	mov    %esp,%ebp
  101346:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  101349:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  10134d:	74 0d                	je     10135c <serial_putc+0x19>
        serial_putc_sub(c);
  10134f:	8b 45 08             	mov    0x8(%ebp),%eax
  101352:	89 04 24             	mov    %eax,(%esp)
  101355:	e8 90 ff ff ff       	call   1012ea <serial_putc_sub>
  10135a:	eb 24                	jmp    101380 <serial_putc+0x3d>
    }
    else {
        serial_putc_sub('\b');
  10135c:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  101363:	e8 82 ff ff ff       	call   1012ea <serial_putc_sub>
        serial_putc_sub(' ');
  101368:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10136f:	e8 76 ff ff ff       	call   1012ea <serial_putc_sub>
        serial_putc_sub('\b');
  101374:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10137b:	e8 6a ff ff ff       	call   1012ea <serial_putc_sub>
    }
}
  101380:	c9                   	leave  
  101381:	c3                   	ret    

00101382 <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  101382:	55                   	push   %ebp
  101383:	89 e5                	mov    %esp,%ebp
  101385:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  101388:	eb 33                	jmp    1013bd <cons_intr+0x3b>
        if (c != 0) {
  10138a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10138e:	74 2d                	je     1013bd <cons_intr+0x3b>
            cons.buf[cons.wpos ++] = c;
  101390:	a1 84 f0 10 00       	mov    0x10f084,%eax
  101395:	8d 50 01             	lea    0x1(%eax),%edx
  101398:	89 15 84 f0 10 00    	mov    %edx,0x10f084
  10139e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1013a1:	88 90 80 ee 10 00    	mov    %dl,0x10ee80(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  1013a7:	a1 84 f0 10 00       	mov    0x10f084,%eax
  1013ac:	3d 00 02 00 00       	cmp    $0x200,%eax
  1013b1:	75 0a                	jne    1013bd <cons_intr+0x3b>
                cons.wpos = 0;
  1013b3:	c7 05 84 f0 10 00 00 	movl   $0x0,0x10f084
  1013ba:	00 00 00 
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
    int c;
    while ((c = (*proc)()) != -1) {
  1013bd:	8b 45 08             	mov    0x8(%ebp),%eax
  1013c0:	ff d0                	call   *%eax
  1013c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1013c5:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  1013c9:	75 bf                	jne    10138a <cons_intr+0x8>
            if (cons.wpos == CONSBUFSIZE) {
                cons.wpos = 0;
            }
        }
    }
}
  1013cb:	c9                   	leave  
  1013cc:	c3                   	ret    

001013cd <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  1013cd:	55                   	push   %ebp
  1013ce:	89 e5                	mov    %esp,%ebp
  1013d0:	83 ec 10             	sub    $0x10,%esp
  1013d3:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1013d9:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1013dd:	89 c2                	mov    %eax,%edx
  1013df:	ec                   	in     (%dx),%al
  1013e0:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  1013e3:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  1013e7:	0f b6 c0             	movzbl %al,%eax
  1013ea:	83 e0 01             	and    $0x1,%eax
  1013ed:	85 c0                	test   %eax,%eax
  1013ef:	75 07                	jne    1013f8 <serial_proc_data+0x2b>
        return -1;
  1013f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1013f6:	eb 2a                	jmp    101422 <serial_proc_data+0x55>
  1013f8:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1013fe:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101402:	89 c2                	mov    %eax,%edx
  101404:	ec                   	in     (%dx),%al
  101405:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  101408:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  10140c:	0f b6 c0             	movzbl %al,%eax
  10140f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  101412:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  101416:	75 07                	jne    10141f <serial_proc_data+0x52>
        c = '\b';
  101418:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  10141f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  101422:	c9                   	leave  
  101423:	c3                   	ret    

00101424 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  101424:	55                   	push   %ebp
  101425:	89 e5                	mov    %esp,%ebp
  101427:	83 ec 18             	sub    $0x18,%esp
    if (serial_exists) {
  10142a:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  10142f:	85 c0                	test   %eax,%eax
  101431:	74 0c                	je     10143f <serial_intr+0x1b>
        cons_intr(serial_proc_data);
  101433:	c7 04 24 cd 13 10 00 	movl   $0x1013cd,(%esp)
  10143a:	e8 43 ff ff ff       	call   101382 <cons_intr>
    }
}
  10143f:	c9                   	leave  
  101440:	c3                   	ret    

00101441 <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  101441:	55                   	push   %ebp
  101442:	89 e5                	mov    %esp,%ebp
  101444:	83 ec 38             	sub    $0x38,%esp
  101447:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10144d:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  101451:	89 c2                	mov    %eax,%edx
  101453:	ec                   	in     (%dx),%al
  101454:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  101457:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  10145b:	0f b6 c0             	movzbl %al,%eax
  10145e:	83 e0 01             	and    $0x1,%eax
  101461:	85 c0                	test   %eax,%eax
  101463:	75 0a                	jne    10146f <kbd_proc_data+0x2e>
        return -1;
  101465:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10146a:	e9 59 01 00 00       	jmp    1015c8 <kbd_proc_data+0x187>
  10146f:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101475:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101479:	89 c2                	mov    %eax,%edx
  10147b:	ec                   	in     (%dx),%al
  10147c:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  10147f:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  101483:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  101486:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  10148a:	75 17                	jne    1014a3 <kbd_proc_data+0x62>
        // E0 escape character
        shift |= E0ESC;
  10148c:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101491:	83 c8 40             	or     $0x40,%eax
  101494:	a3 88 f0 10 00       	mov    %eax,0x10f088
        return 0;
  101499:	b8 00 00 00 00       	mov    $0x0,%eax
  10149e:	e9 25 01 00 00       	jmp    1015c8 <kbd_proc_data+0x187>
    } else if (data & 0x80) {
  1014a3:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014a7:	84 c0                	test   %al,%al
  1014a9:	79 47                	jns    1014f2 <kbd_proc_data+0xb1>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  1014ab:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014b0:	83 e0 40             	and    $0x40,%eax
  1014b3:	85 c0                	test   %eax,%eax
  1014b5:	75 09                	jne    1014c0 <kbd_proc_data+0x7f>
  1014b7:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014bb:	83 e0 7f             	and    $0x7f,%eax
  1014be:	eb 04                	jmp    1014c4 <kbd_proc_data+0x83>
  1014c0:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014c4:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  1014c7:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014cb:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  1014d2:	83 c8 40             	or     $0x40,%eax
  1014d5:	0f b6 c0             	movzbl %al,%eax
  1014d8:	f7 d0                	not    %eax
  1014da:	89 c2                	mov    %eax,%edx
  1014dc:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014e1:	21 d0                	and    %edx,%eax
  1014e3:	a3 88 f0 10 00       	mov    %eax,0x10f088
        return 0;
  1014e8:	b8 00 00 00 00       	mov    $0x0,%eax
  1014ed:	e9 d6 00 00 00       	jmp    1015c8 <kbd_proc_data+0x187>
    } else if (shift & E0ESC) {
  1014f2:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014f7:	83 e0 40             	and    $0x40,%eax
  1014fa:	85 c0                	test   %eax,%eax
  1014fc:	74 11                	je     10150f <kbd_proc_data+0xce>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  1014fe:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  101502:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101507:	83 e0 bf             	and    $0xffffffbf,%eax
  10150a:	a3 88 f0 10 00       	mov    %eax,0x10f088
    }

    shift |= shiftcode[data];
  10150f:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101513:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  10151a:	0f b6 d0             	movzbl %al,%edx
  10151d:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101522:	09 d0                	or     %edx,%eax
  101524:	a3 88 f0 10 00       	mov    %eax,0x10f088
    shift ^= togglecode[data];
  101529:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10152d:	0f b6 80 40 e1 10 00 	movzbl 0x10e140(%eax),%eax
  101534:	0f b6 d0             	movzbl %al,%edx
  101537:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10153c:	31 d0                	xor    %edx,%eax
  10153e:	a3 88 f0 10 00       	mov    %eax,0x10f088

    c = charcode[shift & (CTL | SHIFT)][data];
  101543:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101548:	83 e0 03             	and    $0x3,%eax
  10154b:	8b 14 85 40 e5 10 00 	mov    0x10e540(,%eax,4),%edx
  101552:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101556:	01 d0                	add    %edx,%eax
  101558:	0f b6 00             	movzbl (%eax),%eax
  10155b:	0f b6 c0             	movzbl %al,%eax
  10155e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  101561:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101566:	83 e0 08             	and    $0x8,%eax
  101569:	85 c0                	test   %eax,%eax
  10156b:	74 22                	je     10158f <kbd_proc_data+0x14e>
        if ('a' <= c && c <= 'z')
  10156d:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  101571:	7e 0c                	jle    10157f <kbd_proc_data+0x13e>
  101573:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  101577:	7f 06                	jg     10157f <kbd_proc_data+0x13e>
            c += 'A' - 'a';
  101579:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  10157d:	eb 10                	jmp    10158f <kbd_proc_data+0x14e>
        else if ('A' <= c && c <= 'Z')
  10157f:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  101583:	7e 0a                	jle    10158f <kbd_proc_data+0x14e>
  101585:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  101589:	7f 04                	jg     10158f <kbd_proc_data+0x14e>
            c += 'a' - 'A';
  10158b:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  10158f:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101594:	f7 d0                	not    %eax
  101596:	83 e0 06             	and    $0x6,%eax
  101599:	85 c0                	test   %eax,%eax
  10159b:	75 28                	jne    1015c5 <kbd_proc_data+0x184>
  10159d:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  1015a4:	75 1f                	jne    1015c5 <kbd_proc_data+0x184>
        cprintf("Rebooting!\n");
  1015a6:	c7 04 24 2f 39 10 00 	movl   $0x10392f,(%esp)
  1015ad:	e8 70 ed ff ff       	call   100322 <cprintf>
  1015b2:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  1015b8:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1015bc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  1015c0:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
  1015c4:	ee                   	out    %al,(%dx)
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  1015c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1015c8:	c9                   	leave  
  1015c9:	c3                   	ret    

001015ca <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  1015ca:	55                   	push   %ebp
  1015cb:	89 e5                	mov    %esp,%ebp
  1015cd:	83 ec 18             	sub    $0x18,%esp
    cons_intr(kbd_proc_data);
  1015d0:	c7 04 24 41 14 10 00 	movl   $0x101441,(%esp)
  1015d7:	e8 a6 fd ff ff       	call   101382 <cons_intr>
}
  1015dc:	c9                   	leave  
  1015dd:	c3                   	ret    

001015de <kbd_init>:

static void
kbd_init(void) {
  1015de:	55                   	push   %ebp
  1015df:	89 e5                	mov    %esp,%ebp
  1015e1:	83 ec 18             	sub    $0x18,%esp
    // drain the kbd buffer
    kbd_intr();
  1015e4:	e8 e1 ff ff ff       	call   1015ca <kbd_intr>
    pic_enable(IRQ_KBD);
  1015e9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1015f0:	e8 17 01 00 00       	call   10170c <pic_enable>
}
  1015f5:	c9                   	leave  
  1015f6:	c3                   	ret    

001015f7 <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  1015f7:	55                   	push   %ebp
  1015f8:	89 e5                	mov    %esp,%ebp
  1015fa:	83 ec 18             	sub    $0x18,%esp
    cga_init();
  1015fd:	e8 93 f8 ff ff       	call   100e95 <cga_init>
    serial_init();
  101602:	e8 74 f9 ff ff       	call   100f7b <serial_init>
    kbd_init();
  101607:	e8 d2 ff ff ff       	call   1015de <kbd_init>
    if (!serial_exists) {
  10160c:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  101611:	85 c0                	test   %eax,%eax
  101613:	75 0c                	jne    101621 <cons_init+0x2a>
        cprintf("serial port does not exist!!\n");
  101615:	c7 04 24 3b 39 10 00 	movl   $0x10393b,(%esp)
  10161c:	e8 01 ed ff ff       	call   100322 <cprintf>
    }
}
  101621:	c9                   	leave  
  101622:	c3                   	ret    

00101623 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  101623:	55                   	push   %ebp
  101624:	89 e5                	mov    %esp,%ebp
  101626:	83 ec 18             	sub    $0x18,%esp
    lpt_putc(c);
  101629:	8b 45 08             	mov    0x8(%ebp),%eax
  10162c:	89 04 24             	mov    %eax,(%esp)
  10162f:	e8 a3 fa ff ff       	call   1010d7 <lpt_putc>
    cga_putc(c);
  101634:	8b 45 08             	mov    0x8(%ebp),%eax
  101637:	89 04 24             	mov    %eax,(%esp)
  10163a:	e8 d7 fa ff ff       	call   101116 <cga_putc>
    serial_putc(c);
  10163f:	8b 45 08             	mov    0x8(%ebp),%eax
  101642:	89 04 24             	mov    %eax,(%esp)
  101645:	e8 f9 fc ff ff       	call   101343 <serial_putc>
}
  10164a:	c9                   	leave  
  10164b:	c3                   	ret    

0010164c <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  10164c:	55                   	push   %ebp
  10164d:	89 e5                	mov    %esp,%ebp
  10164f:	83 ec 18             	sub    $0x18,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  101652:	e8 cd fd ff ff       	call   101424 <serial_intr>
    kbd_intr();
  101657:	e8 6e ff ff ff       	call   1015ca <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  10165c:	8b 15 80 f0 10 00    	mov    0x10f080,%edx
  101662:	a1 84 f0 10 00       	mov    0x10f084,%eax
  101667:	39 c2                	cmp    %eax,%edx
  101669:	74 36                	je     1016a1 <cons_getc+0x55>
        c = cons.buf[cons.rpos ++];
  10166b:	a1 80 f0 10 00       	mov    0x10f080,%eax
  101670:	8d 50 01             	lea    0x1(%eax),%edx
  101673:	89 15 80 f0 10 00    	mov    %edx,0x10f080
  101679:	0f b6 80 80 ee 10 00 	movzbl 0x10ee80(%eax),%eax
  101680:	0f b6 c0             	movzbl %al,%eax
  101683:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  101686:	a1 80 f0 10 00       	mov    0x10f080,%eax
  10168b:	3d 00 02 00 00       	cmp    $0x200,%eax
  101690:	75 0a                	jne    10169c <cons_getc+0x50>
            cons.rpos = 0;
  101692:	c7 05 80 f0 10 00 00 	movl   $0x0,0x10f080
  101699:	00 00 00 
        }
        return c;
  10169c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10169f:	eb 05                	jmp    1016a6 <cons_getc+0x5a>
    }
    return 0;
  1016a1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1016a6:	c9                   	leave  
  1016a7:	c3                   	ret    

001016a8 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  1016a8:	55                   	push   %ebp
  1016a9:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  1016ab:	fb                   	sti    
    sti();
}
  1016ac:	5d                   	pop    %ebp
  1016ad:	c3                   	ret    

001016ae <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  1016ae:	55                   	push   %ebp
  1016af:	89 e5                	mov    %esp,%ebp
}

static inline void
cli(void) {
    asm volatile ("cli");
  1016b1:	fa                   	cli    
    cli();
}
  1016b2:	5d                   	pop    %ebp
  1016b3:	c3                   	ret    

001016b4 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  1016b4:	55                   	push   %ebp
  1016b5:	89 e5                	mov    %esp,%ebp
  1016b7:	83 ec 14             	sub    $0x14,%esp
  1016ba:	8b 45 08             	mov    0x8(%ebp),%eax
  1016bd:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  1016c1:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  1016c5:	66 a3 50 e5 10 00    	mov    %ax,0x10e550
    if (did_init) {
  1016cb:	a1 8c f0 10 00       	mov    0x10f08c,%eax
  1016d0:	85 c0                	test   %eax,%eax
  1016d2:	74 36                	je     10170a <pic_setmask+0x56>
        outb(IO_PIC1 + 1, mask);
  1016d4:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  1016d8:	0f b6 c0             	movzbl %al,%eax
  1016db:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
  1016e1:	88 45 fd             	mov    %al,-0x3(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1016e4:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1016e8:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1016ec:	ee                   	out    %al,(%dx)
        outb(IO_PIC2 + 1, mask >> 8);
  1016ed:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  1016f1:	66 c1 e8 08          	shr    $0x8,%ax
  1016f5:	0f b6 c0             	movzbl %al,%eax
  1016f8:	66 c7 45 fa a1 00    	movw   $0xa1,-0x6(%ebp)
  1016fe:	88 45 f9             	mov    %al,-0x7(%ebp)
  101701:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101705:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101709:	ee                   	out    %al,(%dx)
    }
}
  10170a:	c9                   	leave  
  10170b:	c3                   	ret    

0010170c <pic_enable>:

void
pic_enable(unsigned int irq) {
  10170c:	55                   	push   %ebp
  10170d:	89 e5                	mov    %esp,%ebp
  10170f:	83 ec 04             	sub    $0x4,%esp
    pic_setmask(irq_mask & ~(1 << irq));
  101712:	8b 45 08             	mov    0x8(%ebp),%eax
  101715:	ba 01 00 00 00       	mov    $0x1,%edx
  10171a:	89 c1                	mov    %eax,%ecx
  10171c:	d3 e2                	shl    %cl,%edx
  10171e:	89 d0                	mov    %edx,%eax
  101720:	f7 d0                	not    %eax
  101722:	89 c2                	mov    %eax,%edx
  101724:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  10172b:	21 d0                	and    %edx,%eax
  10172d:	0f b7 c0             	movzwl %ax,%eax
  101730:	89 04 24             	mov    %eax,(%esp)
  101733:	e8 7c ff ff ff       	call   1016b4 <pic_setmask>
}
  101738:	c9                   	leave  
  101739:	c3                   	ret    

0010173a <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  10173a:	55                   	push   %ebp
  10173b:	89 e5                	mov    %esp,%ebp
  10173d:	83 ec 44             	sub    $0x44,%esp
    did_init = 1;
  101740:	c7 05 8c f0 10 00 01 	movl   $0x1,0x10f08c
  101747:	00 00 00 
  10174a:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
  101750:	c6 45 fd ff          	movb   $0xff,-0x3(%ebp)
  101754:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101758:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  10175c:	ee                   	out    %al,(%dx)
  10175d:	66 c7 45 fa a1 00    	movw   $0xa1,-0x6(%ebp)
  101763:	c6 45 f9 ff          	movb   $0xff,-0x7(%ebp)
  101767:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10176b:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  10176f:	ee                   	out    %al,(%dx)
  101770:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  101776:	c6 45 f5 11          	movb   $0x11,-0xb(%ebp)
  10177a:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  10177e:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101782:	ee                   	out    %al,(%dx)
  101783:	66 c7 45 f2 21 00    	movw   $0x21,-0xe(%ebp)
  101789:	c6 45 f1 20          	movb   $0x20,-0xf(%ebp)
  10178d:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101791:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101795:	ee                   	out    %al,(%dx)
  101796:	66 c7 45 ee 21 00    	movw   $0x21,-0x12(%ebp)
  10179c:	c6 45 ed 04          	movb   $0x4,-0x13(%ebp)
  1017a0:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1017a4:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1017a8:	ee                   	out    %al,(%dx)
  1017a9:	66 c7 45 ea 21 00    	movw   $0x21,-0x16(%ebp)
  1017af:	c6 45 e9 03          	movb   $0x3,-0x17(%ebp)
  1017b3:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1017b7:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  1017bb:	ee                   	out    %al,(%dx)
  1017bc:	66 c7 45 e6 a0 00    	movw   $0xa0,-0x1a(%ebp)
  1017c2:	c6 45 e5 11          	movb   $0x11,-0x1b(%ebp)
  1017c6:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  1017ca:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  1017ce:	ee                   	out    %al,(%dx)
  1017cf:	66 c7 45 e2 a1 00    	movw   $0xa1,-0x1e(%ebp)
  1017d5:	c6 45 e1 28          	movb   $0x28,-0x1f(%ebp)
  1017d9:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  1017dd:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  1017e1:	ee                   	out    %al,(%dx)
  1017e2:	66 c7 45 de a1 00    	movw   $0xa1,-0x22(%ebp)
  1017e8:	c6 45 dd 02          	movb   $0x2,-0x23(%ebp)
  1017ec:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  1017f0:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  1017f4:	ee                   	out    %al,(%dx)
  1017f5:	66 c7 45 da a1 00    	movw   $0xa1,-0x26(%ebp)
  1017fb:	c6 45 d9 03          	movb   $0x3,-0x27(%ebp)
  1017ff:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  101803:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  101807:	ee                   	out    %al,(%dx)
  101808:	66 c7 45 d6 20 00    	movw   $0x20,-0x2a(%ebp)
  10180e:	c6 45 d5 68          	movb   $0x68,-0x2b(%ebp)
  101812:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  101816:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  10181a:	ee                   	out    %al,(%dx)
  10181b:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  101821:	c6 45 d1 0a          	movb   $0xa,-0x2f(%ebp)
  101825:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  101829:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  10182d:	ee                   	out    %al,(%dx)
  10182e:	66 c7 45 ce a0 00    	movw   $0xa0,-0x32(%ebp)
  101834:	c6 45 cd 68          	movb   $0x68,-0x33(%ebp)
  101838:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  10183c:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  101840:	ee                   	out    %al,(%dx)
  101841:	66 c7 45 ca a0 00    	movw   $0xa0,-0x36(%ebp)
  101847:	c6 45 c9 0a          	movb   $0xa,-0x37(%ebp)
  10184b:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  10184f:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  101853:	ee                   	out    %al,(%dx)
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  101854:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  10185b:	66 83 f8 ff          	cmp    $0xffff,%ax
  10185f:	74 12                	je     101873 <pic_init+0x139>
        pic_setmask(irq_mask);
  101861:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  101868:	0f b7 c0             	movzwl %ax,%eax
  10186b:	89 04 24             	mov    %eax,(%esp)
  10186e:	e8 41 fe ff ff       	call   1016b4 <pic_setmask>
    }
}
  101873:	c9                   	leave  
  101874:	c3                   	ret    

00101875 <print_ticks>:
#include <console.h>
#include <kdebug.h>
#include <string.h>
#define TICK_NUM 100

static void print_ticks() {
  101875:	55                   	push   %ebp
  101876:	89 e5                	mov    %esp,%ebp
  101878:	83 ec 18             	sub    $0x18,%esp
    cprintf("%d ticks\n",TICK_NUM);
  10187b:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
  101882:	00 
  101883:	c7 04 24 60 39 10 00 	movl   $0x103960,(%esp)
  10188a:	e8 93 ea ff ff       	call   100322 <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}
  10188f:	c9                   	leave  
  101890:	c3                   	ret    

00101891 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  101891:	55                   	push   %ebp
  101892:	89 e5                	mov    %esp,%ebp
  101894:	83 ec 10             	sub    $0x10,%esp
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
    extern uintptr_t __vectors[];
    int i;
    for (i = 0; i < sizeof(idt) / sizeof(struct gatedesc); i ++) {
  101897:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10189e:	e9 c3 00 00 00       	jmp    101966 <idt_init+0xd5>
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
  1018a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018a6:	8b 04 85 e0 e5 10 00 	mov    0x10e5e0(,%eax,4),%eax
  1018ad:	89 c2                	mov    %eax,%edx
  1018af:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018b2:	66 89 14 c5 a0 f0 10 	mov    %dx,0x10f0a0(,%eax,8)
  1018b9:	00 
  1018ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018bd:	66 c7 04 c5 a2 f0 10 	movw   $0x8,0x10f0a2(,%eax,8)
  1018c4:	00 08 00 
  1018c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018ca:	0f b6 14 c5 a4 f0 10 	movzbl 0x10f0a4(,%eax,8),%edx
  1018d1:	00 
  1018d2:	83 e2 e0             	and    $0xffffffe0,%edx
  1018d5:	88 14 c5 a4 f0 10 00 	mov    %dl,0x10f0a4(,%eax,8)
  1018dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018df:	0f b6 14 c5 a4 f0 10 	movzbl 0x10f0a4(,%eax,8),%edx
  1018e6:	00 
  1018e7:	83 e2 1f             	and    $0x1f,%edx
  1018ea:	88 14 c5 a4 f0 10 00 	mov    %dl,0x10f0a4(,%eax,8)
  1018f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018f4:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  1018fb:	00 
  1018fc:	83 e2 f0             	and    $0xfffffff0,%edx
  1018ff:	83 ca 0e             	or     $0xe,%edx
  101902:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  101909:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10190c:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  101913:	00 
  101914:	83 e2 ef             	and    $0xffffffef,%edx
  101917:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  10191e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101921:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  101928:	00 
  101929:	83 e2 9f             	and    $0xffffff9f,%edx
  10192c:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  101933:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101936:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  10193d:	00 
  10193e:	83 ca 80             	or     $0xffffff80,%edx
  101941:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  101948:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10194b:	8b 04 85 e0 e5 10 00 	mov    0x10e5e0(,%eax,4),%eax
  101952:	c1 e8 10             	shr    $0x10,%eax
  101955:	89 c2                	mov    %eax,%edx
  101957:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10195a:	66 89 14 c5 a6 f0 10 	mov    %dx,0x10f0a6(,%eax,8)
  101961:	00 
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
    extern uintptr_t __vectors[];
    int i;
    for (i = 0; i < sizeof(idt) / sizeof(struct gatedesc); i ++) {
  101962:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101966:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101969:	3d ff 00 00 00       	cmp    $0xff,%eax
  10196e:	0f 86 2f ff ff ff    	jbe    1018a3 <idt_init+0x12>
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
    }
	// set for switch from user to kernel
    SETGATE(idt[T_SWITCH_TOK], 0, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);
  101974:	a1 c4 e7 10 00       	mov    0x10e7c4,%eax
  101979:	66 a3 68 f4 10 00    	mov    %ax,0x10f468
  10197f:	66 c7 05 6a f4 10 00 	movw   $0x8,0x10f46a
  101986:	08 00 
  101988:	0f b6 05 6c f4 10 00 	movzbl 0x10f46c,%eax
  10198f:	83 e0 e0             	and    $0xffffffe0,%eax
  101992:	a2 6c f4 10 00       	mov    %al,0x10f46c
  101997:	0f b6 05 6c f4 10 00 	movzbl 0x10f46c,%eax
  10199e:	83 e0 1f             	and    $0x1f,%eax
  1019a1:	a2 6c f4 10 00       	mov    %al,0x10f46c
  1019a6:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  1019ad:	83 e0 f0             	and    $0xfffffff0,%eax
  1019b0:	83 c8 0e             	or     $0xe,%eax
  1019b3:	a2 6d f4 10 00       	mov    %al,0x10f46d
  1019b8:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  1019bf:	83 e0 ef             	and    $0xffffffef,%eax
  1019c2:	a2 6d f4 10 00       	mov    %al,0x10f46d
  1019c7:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  1019ce:	83 c8 60             	or     $0x60,%eax
  1019d1:	a2 6d f4 10 00       	mov    %al,0x10f46d
  1019d6:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  1019dd:	83 c8 80             	or     $0xffffff80,%eax
  1019e0:	a2 6d f4 10 00       	mov    %al,0x10f46d
  1019e5:	a1 c4 e7 10 00       	mov    0x10e7c4,%eax
  1019ea:	c1 e8 10             	shr    $0x10,%eax
  1019ed:	66 a3 6e f4 10 00    	mov    %ax,0x10f46e
  1019f3:	c7 45 f8 60 e5 10 00 	movl   $0x10e560,-0x8(%ebp)
    return ebp;
}

static inline void
lidt(struct pseudodesc *pd) {
    asm volatile ("lidt (%0)" :: "r" (pd));
  1019fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1019fd:	0f 01 18             	lidtl  (%eax)
	// load the IDT
    lidt(&idt_pd);
}
  101a00:	c9                   	leave  
  101a01:	c3                   	ret    

00101a02 <trapname>:

static const char *
trapname(int trapno) {
  101a02:	55                   	push   %ebp
  101a03:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101a05:	8b 45 08             	mov    0x8(%ebp),%eax
  101a08:	83 f8 13             	cmp    $0x13,%eax
  101a0b:	77 0c                	ja     101a19 <trapname+0x17>
        return excnames[trapno];
  101a0d:	8b 45 08             	mov    0x8(%ebp),%eax
  101a10:	8b 04 85 c0 3c 10 00 	mov    0x103cc0(,%eax,4),%eax
  101a17:	eb 18                	jmp    101a31 <trapname+0x2f>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101a19:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101a1d:	7e 0d                	jle    101a2c <trapname+0x2a>
  101a1f:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101a23:	7f 07                	jg     101a2c <trapname+0x2a>
        return "Hardware Interrupt";
  101a25:	b8 6a 39 10 00       	mov    $0x10396a,%eax
  101a2a:	eb 05                	jmp    101a31 <trapname+0x2f>
    }
    return "(unknown trap)";
  101a2c:	b8 7d 39 10 00       	mov    $0x10397d,%eax
}
  101a31:	5d                   	pop    %ebp
  101a32:	c3                   	ret    

00101a33 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  101a33:	55                   	push   %ebp
  101a34:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101a36:	8b 45 08             	mov    0x8(%ebp),%eax
  101a39:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101a3d:	66 83 f8 08          	cmp    $0x8,%ax
  101a41:	0f 94 c0             	sete   %al
  101a44:	0f b6 c0             	movzbl %al,%eax
}
  101a47:	5d                   	pop    %ebp
  101a48:	c3                   	ret    

00101a49 <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101a49:	55                   	push   %ebp
  101a4a:	89 e5                	mov    %esp,%ebp
  101a4c:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
  101a4f:	8b 45 08             	mov    0x8(%ebp),%eax
  101a52:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a56:	c7 04 24 be 39 10 00 	movl   $0x1039be,(%esp)
  101a5d:	e8 c0 e8 ff ff       	call   100322 <cprintf>
    print_regs(&tf->tf_regs);
  101a62:	8b 45 08             	mov    0x8(%ebp),%eax
  101a65:	89 04 24             	mov    %eax,(%esp)
  101a68:	e8 a1 01 00 00       	call   101c0e <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101a6d:	8b 45 08             	mov    0x8(%ebp),%eax
  101a70:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101a74:	0f b7 c0             	movzwl %ax,%eax
  101a77:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a7b:	c7 04 24 cf 39 10 00 	movl   $0x1039cf,(%esp)
  101a82:	e8 9b e8 ff ff       	call   100322 <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101a87:	8b 45 08             	mov    0x8(%ebp),%eax
  101a8a:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101a8e:	0f b7 c0             	movzwl %ax,%eax
  101a91:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a95:	c7 04 24 e2 39 10 00 	movl   $0x1039e2,(%esp)
  101a9c:	e8 81 e8 ff ff       	call   100322 <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101aa1:	8b 45 08             	mov    0x8(%ebp),%eax
  101aa4:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101aa8:	0f b7 c0             	movzwl %ax,%eax
  101aab:	89 44 24 04          	mov    %eax,0x4(%esp)
  101aaf:	c7 04 24 f5 39 10 00 	movl   $0x1039f5,(%esp)
  101ab6:	e8 67 e8 ff ff       	call   100322 <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101abb:	8b 45 08             	mov    0x8(%ebp),%eax
  101abe:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101ac2:	0f b7 c0             	movzwl %ax,%eax
  101ac5:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ac9:	c7 04 24 08 3a 10 00 	movl   $0x103a08,(%esp)
  101ad0:	e8 4d e8 ff ff       	call   100322 <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101ad5:	8b 45 08             	mov    0x8(%ebp),%eax
  101ad8:	8b 40 30             	mov    0x30(%eax),%eax
  101adb:	89 04 24             	mov    %eax,(%esp)
  101ade:	e8 1f ff ff ff       	call   101a02 <trapname>
  101ae3:	8b 55 08             	mov    0x8(%ebp),%edx
  101ae6:	8b 52 30             	mov    0x30(%edx),%edx
  101ae9:	89 44 24 08          	mov    %eax,0x8(%esp)
  101aed:	89 54 24 04          	mov    %edx,0x4(%esp)
  101af1:	c7 04 24 1b 3a 10 00 	movl   $0x103a1b,(%esp)
  101af8:	e8 25 e8 ff ff       	call   100322 <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
  101afd:	8b 45 08             	mov    0x8(%ebp),%eax
  101b00:	8b 40 34             	mov    0x34(%eax),%eax
  101b03:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b07:	c7 04 24 2d 3a 10 00 	movl   $0x103a2d,(%esp)
  101b0e:	e8 0f e8 ff ff       	call   100322 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101b13:	8b 45 08             	mov    0x8(%ebp),%eax
  101b16:	8b 40 38             	mov    0x38(%eax),%eax
  101b19:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b1d:	c7 04 24 3c 3a 10 00 	movl   $0x103a3c,(%esp)
  101b24:	e8 f9 e7 ff ff       	call   100322 <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101b29:	8b 45 08             	mov    0x8(%ebp),%eax
  101b2c:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101b30:	0f b7 c0             	movzwl %ax,%eax
  101b33:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b37:	c7 04 24 4b 3a 10 00 	movl   $0x103a4b,(%esp)
  101b3e:	e8 df e7 ff ff       	call   100322 <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101b43:	8b 45 08             	mov    0x8(%ebp),%eax
  101b46:	8b 40 40             	mov    0x40(%eax),%eax
  101b49:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b4d:	c7 04 24 5e 3a 10 00 	movl   $0x103a5e,(%esp)
  101b54:	e8 c9 e7 ff ff       	call   100322 <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101b59:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101b60:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101b67:	eb 3e                	jmp    101ba7 <print_trapframe+0x15e>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101b69:	8b 45 08             	mov    0x8(%ebp),%eax
  101b6c:	8b 50 40             	mov    0x40(%eax),%edx
  101b6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101b72:	21 d0                	and    %edx,%eax
  101b74:	85 c0                	test   %eax,%eax
  101b76:	74 28                	je     101ba0 <print_trapframe+0x157>
  101b78:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101b7b:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  101b82:	85 c0                	test   %eax,%eax
  101b84:	74 1a                	je     101ba0 <print_trapframe+0x157>
            cprintf("%s,", IA32flags[i]);
  101b86:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101b89:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  101b90:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b94:	c7 04 24 6d 3a 10 00 	movl   $0x103a6d,(%esp)
  101b9b:	e8 82 e7 ff ff       	call   100322 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
    cprintf("  flag 0x%08x ", tf->tf_eflags);

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101ba0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101ba4:	d1 65 f0             	shll   -0x10(%ebp)
  101ba7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101baa:	83 f8 17             	cmp    $0x17,%eax
  101bad:	76 ba                	jbe    101b69 <print_trapframe+0x120>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
            cprintf("%s,", IA32flags[i]);
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101baf:	8b 45 08             	mov    0x8(%ebp),%eax
  101bb2:	8b 40 40             	mov    0x40(%eax),%eax
  101bb5:	25 00 30 00 00       	and    $0x3000,%eax
  101bba:	c1 e8 0c             	shr    $0xc,%eax
  101bbd:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bc1:	c7 04 24 71 3a 10 00 	movl   $0x103a71,(%esp)
  101bc8:	e8 55 e7 ff ff       	call   100322 <cprintf>

    if (!trap_in_kernel(tf)) {
  101bcd:	8b 45 08             	mov    0x8(%ebp),%eax
  101bd0:	89 04 24             	mov    %eax,(%esp)
  101bd3:	e8 5b fe ff ff       	call   101a33 <trap_in_kernel>
  101bd8:	85 c0                	test   %eax,%eax
  101bda:	75 30                	jne    101c0c <print_trapframe+0x1c3>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  101bdf:	8b 40 44             	mov    0x44(%eax),%eax
  101be2:	89 44 24 04          	mov    %eax,0x4(%esp)
  101be6:	c7 04 24 7a 3a 10 00 	movl   $0x103a7a,(%esp)
  101bed:	e8 30 e7 ff ff       	call   100322 <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101bf2:	8b 45 08             	mov    0x8(%ebp),%eax
  101bf5:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101bf9:	0f b7 c0             	movzwl %ax,%eax
  101bfc:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c00:	c7 04 24 89 3a 10 00 	movl   $0x103a89,(%esp)
  101c07:	e8 16 e7 ff ff       	call   100322 <cprintf>
    }
}
  101c0c:	c9                   	leave  
  101c0d:	c3                   	ret    

00101c0e <print_regs>:

void
print_regs(struct pushregs *regs) {
  101c0e:	55                   	push   %ebp
  101c0f:	89 e5                	mov    %esp,%ebp
  101c11:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101c14:	8b 45 08             	mov    0x8(%ebp),%eax
  101c17:	8b 00                	mov    (%eax),%eax
  101c19:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c1d:	c7 04 24 9c 3a 10 00 	movl   $0x103a9c,(%esp)
  101c24:	e8 f9 e6 ff ff       	call   100322 <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101c29:	8b 45 08             	mov    0x8(%ebp),%eax
  101c2c:	8b 40 04             	mov    0x4(%eax),%eax
  101c2f:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c33:	c7 04 24 ab 3a 10 00 	movl   $0x103aab,(%esp)
  101c3a:	e8 e3 e6 ff ff       	call   100322 <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101c3f:	8b 45 08             	mov    0x8(%ebp),%eax
  101c42:	8b 40 08             	mov    0x8(%eax),%eax
  101c45:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c49:	c7 04 24 ba 3a 10 00 	movl   $0x103aba,(%esp)
  101c50:	e8 cd e6 ff ff       	call   100322 <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101c55:	8b 45 08             	mov    0x8(%ebp),%eax
  101c58:	8b 40 0c             	mov    0xc(%eax),%eax
  101c5b:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c5f:	c7 04 24 c9 3a 10 00 	movl   $0x103ac9,(%esp)
  101c66:	e8 b7 e6 ff ff       	call   100322 <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101c6b:	8b 45 08             	mov    0x8(%ebp),%eax
  101c6e:	8b 40 10             	mov    0x10(%eax),%eax
  101c71:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c75:	c7 04 24 d8 3a 10 00 	movl   $0x103ad8,(%esp)
  101c7c:	e8 a1 e6 ff ff       	call   100322 <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101c81:	8b 45 08             	mov    0x8(%ebp),%eax
  101c84:	8b 40 14             	mov    0x14(%eax),%eax
  101c87:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c8b:	c7 04 24 e7 3a 10 00 	movl   $0x103ae7,(%esp)
  101c92:	e8 8b e6 ff ff       	call   100322 <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101c97:	8b 45 08             	mov    0x8(%ebp),%eax
  101c9a:	8b 40 18             	mov    0x18(%eax),%eax
  101c9d:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ca1:	c7 04 24 f6 3a 10 00 	movl   $0x103af6,(%esp)
  101ca8:	e8 75 e6 ff ff       	call   100322 <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101cad:	8b 45 08             	mov    0x8(%ebp),%eax
  101cb0:	8b 40 1c             	mov    0x1c(%eax),%eax
  101cb3:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cb7:	c7 04 24 05 3b 10 00 	movl   $0x103b05,(%esp)
  101cbe:	e8 5f e6 ff ff       	call   100322 <cprintf>
}
  101cc3:	c9                   	leave  
  101cc4:	c3                   	ret    

00101cc5 <trap_dispatch>:
/* temporary trapframe or pointer to trapframe */
struct trapframe switchk2u, *switchu2k;

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101cc5:	55                   	push   %ebp
  101cc6:	89 e5                	mov    %esp,%ebp
  101cc8:	57                   	push   %edi
  101cc9:	56                   	push   %esi
  101cca:	53                   	push   %ebx
  101ccb:	83 ec 2c             	sub    $0x2c,%esp
    char c;

    switch (tf->tf_trapno) {
  101cce:	8b 45 08             	mov    0x8(%ebp),%eax
  101cd1:	8b 40 30             	mov    0x30(%eax),%eax
  101cd4:	83 f8 2f             	cmp    $0x2f,%eax
  101cd7:	77 21                	ja     101cfa <trap_dispatch+0x35>
  101cd9:	83 f8 2e             	cmp    $0x2e,%eax
  101cdc:	0f 83 ec 01 00 00    	jae    101ece <trap_dispatch+0x209>
  101ce2:	83 f8 21             	cmp    $0x21,%eax
  101ce5:	0f 84 8a 00 00 00    	je     101d75 <trap_dispatch+0xb0>
  101ceb:	83 f8 24             	cmp    $0x24,%eax
  101cee:	74 5c                	je     101d4c <trap_dispatch+0x87>
  101cf0:	83 f8 20             	cmp    $0x20,%eax
  101cf3:	74 1c                	je     101d11 <trap_dispatch+0x4c>
  101cf5:	e9 9c 01 00 00       	jmp    101e96 <trap_dispatch+0x1d1>
  101cfa:	83 f8 78             	cmp    $0x78,%eax
  101cfd:	0f 84 9b 00 00 00    	je     101d9e <trap_dispatch+0xd9>
  101d03:	83 f8 79             	cmp    $0x79,%eax
  101d06:	0f 84 11 01 00 00    	je     101e1d <trap_dispatch+0x158>
  101d0c:	e9 85 01 00 00       	jmp    101e96 <trap_dispatch+0x1d1>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        ticks ++;
  101d11:	a1 08 f9 10 00       	mov    0x10f908,%eax
  101d16:	83 c0 01             	add    $0x1,%eax
  101d19:	a3 08 f9 10 00       	mov    %eax,0x10f908
        if (ticks % TICK_NUM == 0) {
  101d1e:	8b 0d 08 f9 10 00    	mov    0x10f908,%ecx
  101d24:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  101d29:	89 c8                	mov    %ecx,%eax
  101d2b:	f7 e2                	mul    %edx
  101d2d:	89 d0                	mov    %edx,%eax
  101d2f:	c1 e8 05             	shr    $0x5,%eax
  101d32:	6b c0 64             	imul   $0x64,%eax,%eax
  101d35:	29 c1                	sub    %eax,%ecx
  101d37:	89 c8                	mov    %ecx,%eax
  101d39:	85 c0                	test   %eax,%eax
  101d3b:	75 0a                	jne    101d47 <trap_dispatch+0x82>
            print_ticks();
  101d3d:	e8 33 fb ff ff       	call   101875 <print_ticks>
        }
        break;
  101d42:	e9 88 01 00 00       	jmp    101ecf <trap_dispatch+0x20a>
  101d47:	e9 83 01 00 00       	jmp    101ecf <trap_dispatch+0x20a>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101d4c:	e8 fb f8 ff ff       	call   10164c <cons_getc>
  101d51:	88 45 e7             	mov    %al,-0x19(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101d54:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
  101d58:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  101d5c:	89 54 24 08          	mov    %edx,0x8(%esp)
  101d60:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d64:	c7 04 24 14 3b 10 00 	movl   $0x103b14,(%esp)
  101d6b:	e8 b2 e5 ff ff       	call   100322 <cprintf>
        break;
  101d70:	e9 5a 01 00 00       	jmp    101ecf <trap_dispatch+0x20a>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101d75:	e8 d2 f8 ff ff       	call   10164c <cons_getc>
  101d7a:	88 45 e7             	mov    %al,-0x19(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101d7d:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
  101d81:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  101d85:	89 54 24 08          	mov    %edx,0x8(%esp)
  101d89:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d8d:	c7 04 24 26 3b 10 00 	movl   $0x103b26,(%esp)
  101d94:	e8 89 e5 ff ff       	call   100322 <cprintf>
        break;
  101d99:	e9 31 01 00 00       	jmp    101ecf <trap_dispatch+0x20a>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
        if (tf->tf_cs != USER_CS) {
  101d9e:	8b 45 08             	mov    0x8(%ebp),%eax
  101da1:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101da5:	66 83 f8 1b          	cmp    $0x1b,%ax
  101da9:	74 6d                	je     101e18 <trap_dispatch+0x153>
            switchk2u = *tf;
  101dab:	8b 45 08             	mov    0x8(%ebp),%eax
  101dae:	ba 20 f9 10 00       	mov    $0x10f920,%edx
  101db3:	89 c3                	mov    %eax,%ebx
  101db5:	b8 13 00 00 00       	mov    $0x13,%eax
  101dba:	89 d7                	mov    %edx,%edi
  101dbc:	89 de                	mov    %ebx,%esi
  101dbe:	89 c1                	mov    %eax,%ecx
  101dc0:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
            switchk2u.tf_cs = USER_CS;
  101dc2:	66 c7 05 5c f9 10 00 	movw   $0x1b,0x10f95c
  101dc9:	1b 00 
            switchk2u.tf_ds = switchk2u.tf_es = switchk2u.tf_ss = USER_DS;
  101dcb:	66 c7 05 68 f9 10 00 	movw   $0x23,0x10f968
  101dd2:	23 00 
  101dd4:	0f b7 05 68 f9 10 00 	movzwl 0x10f968,%eax
  101ddb:	66 a3 48 f9 10 00    	mov    %ax,0x10f948
  101de1:	0f b7 05 48 f9 10 00 	movzwl 0x10f948,%eax
  101de8:	66 a3 4c f9 10 00    	mov    %ax,0x10f94c
            switchk2u.tf_esp = (uint32_t)tf + sizeof(struct trapframe) - 8;
  101dee:	8b 45 08             	mov    0x8(%ebp),%eax
  101df1:	83 c0 44             	add    $0x44,%eax
  101df4:	a3 64 f9 10 00       	mov    %eax,0x10f964
		
            // set eflags, make sure ucore can use io under user mode.
            // if CPL > IOPL, then cpu will generate a general protection.
            switchk2u.tf_eflags |= FL_IOPL_MASK;
  101df9:	a1 60 f9 10 00       	mov    0x10f960,%eax
  101dfe:	80 cc 30             	or     $0x30,%ah
  101e01:	a3 60 f9 10 00       	mov    %eax,0x10f960
		
            // set temporary stack
            // then iret will jump to the right stack
            *((uint32_t *)tf - 1) = (uint32_t)&switchk2u;
  101e06:	8b 45 08             	mov    0x8(%ebp),%eax
  101e09:	8d 50 fc             	lea    -0x4(%eax),%edx
  101e0c:	b8 20 f9 10 00       	mov    $0x10f920,%eax
  101e11:	89 02                	mov    %eax,(%edx)
        }
        break;
  101e13:	e9 b7 00 00 00       	jmp    101ecf <trap_dispatch+0x20a>
  101e18:	e9 b2 00 00 00       	jmp    101ecf <trap_dispatch+0x20a>
    case T_SWITCH_TOK:
        if (tf->tf_cs != KERNEL_CS) {
  101e1d:	8b 45 08             	mov    0x8(%ebp),%eax
  101e20:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e24:	66 83 f8 08          	cmp    $0x8,%ax
  101e28:	74 6a                	je     101e94 <trap_dispatch+0x1cf>
            tf->tf_cs = KERNEL_CS;
  101e2a:	8b 45 08             	mov    0x8(%ebp),%eax
  101e2d:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
            tf->tf_ds = tf->tf_es = KERNEL_DS;
  101e33:	8b 45 08             	mov    0x8(%ebp),%eax
  101e36:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
  101e3c:	8b 45 08             	mov    0x8(%ebp),%eax
  101e3f:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101e43:	8b 45 08             	mov    0x8(%ebp),%eax
  101e46:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_eflags &= ~FL_IOPL_MASK;
  101e4a:	8b 45 08             	mov    0x8(%ebp),%eax
  101e4d:	8b 40 40             	mov    0x40(%eax),%eax
  101e50:	80 e4 cf             	and    $0xcf,%ah
  101e53:	89 c2                	mov    %eax,%edx
  101e55:	8b 45 08             	mov    0x8(%ebp),%eax
  101e58:	89 50 40             	mov    %edx,0x40(%eax)
            switchu2k = (struct trapframe *)(tf->tf_esp - (sizeof(struct trapframe) - 8));
  101e5b:	8b 45 08             	mov    0x8(%ebp),%eax
  101e5e:	8b 40 44             	mov    0x44(%eax),%eax
  101e61:	83 e8 44             	sub    $0x44,%eax
  101e64:	a3 6c f9 10 00       	mov    %eax,0x10f96c
            memmove(switchu2k, tf, sizeof(struct trapframe) - 8);
  101e69:	a1 6c f9 10 00       	mov    0x10f96c,%eax
  101e6e:	c7 44 24 08 44 00 00 	movl   $0x44,0x8(%esp)
  101e75:	00 
  101e76:	8b 55 08             	mov    0x8(%ebp),%edx
  101e79:	89 54 24 04          	mov    %edx,0x4(%esp)
  101e7d:	89 04 24             	mov    %eax,(%esp)
  101e80:	e8 25 16 00 00       	call   1034aa <memmove>
            *((uint32_t *)tf - 1) = (uint32_t)switchu2k;
  101e85:	8b 45 08             	mov    0x8(%ebp),%eax
  101e88:	8d 50 fc             	lea    -0x4(%eax),%edx
  101e8b:	a1 6c f9 10 00       	mov    0x10f96c,%eax
  101e90:	89 02                	mov    %eax,(%edx)
        }
        break;
  101e92:	eb 3b                	jmp    101ecf <trap_dispatch+0x20a>
  101e94:	eb 39                	jmp    101ecf <trap_dispatch+0x20a>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101e96:	8b 45 08             	mov    0x8(%ebp),%eax
  101e99:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e9d:	0f b7 c0             	movzwl %ax,%eax
  101ea0:	83 e0 03             	and    $0x3,%eax
  101ea3:	85 c0                	test   %eax,%eax
  101ea5:	75 28                	jne    101ecf <trap_dispatch+0x20a>
            print_trapframe(tf);
  101ea7:	8b 45 08             	mov    0x8(%ebp),%eax
  101eaa:	89 04 24             	mov    %eax,(%esp)
  101ead:	e8 97 fb ff ff       	call   101a49 <print_trapframe>
            panic("unexpected trap in kernel.\n");
  101eb2:	c7 44 24 08 35 3b 10 	movl   $0x103b35,0x8(%esp)
  101eb9:	00 
  101eba:	c7 44 24 04 d2 00 00 	movl   $0xd2,0x4(%esp)
  101ec1:	00 
  101ec2:	c7 04 24 51 3b 10 00 	movl   $0x103b51,(%esp)
  101ec9:	e8 4f ee ff ff       	call   100d1d <__panic>
        }
        break;
    case IRQ_OFFSET + IRQ_IDE1:
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
  101ece:	90                   	nop
        if ((tf->tf_cs & 3) == 0) {
            print_trapframe(tf);
            panic("unexpected trap in kernel.\n");
        }
    }
}
  101ecf:	83 c4 2c             	add    $0x2c,%esp
  101ed2:	5b                   	pop    %ebx
  101ed3:	5e                   	pop    %esi
  101ed4:	5f                   	pop    %edi
  101ed5:	5d                   	pop    %ebp
  101ed6:	c3                   	ret    

00101ed7 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101ed7:	55                   	push   %ebp
  101ed8:	89 e5                	mov    %esp,%ebp
  101eda:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101edd:	8b 45 08             	mov    0x8(%ebp),%eax
  101ee0:	89 04 24             	mov    %eax,(%esp)
  101ee3:	e8 dd fd ff ff       	call   101cc5 <trap_dispatch>
}
  101ee8:	c9                   	leave  
  101ee9:	c3                   	ret    

00101eea <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  101eea:	1e                   	push   %ds
    pushl %es
  101eeb:	06                   	push   %es
    pushl %fs
  101eec:	0f a0                	push   %fs
    pushl %gs
  101eee:	0f a8                	push   %gs
    pushal
  101ef0:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  101ef1:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  101ef6:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  101ef8:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  101efa:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  101efb:	e8 d7 ff ff ff       	call   101ed7 <trap>

    # pop the pushed stack pointer
    popl %esp
  101f00:	5c                   	pop    %esp

00101f01 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  101f01:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  101f02:	0f a9                	pop    %gs
    popl %fs
  101f04:	0f a1                	pop    %fs
    popl %es
  101f06:	07                   	pop    %es
    popl %ds
  101f07:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  101f08:	83 c4 08             	add    $0x8,%esp
    iret
  101f0b:	cf                   	iret   

00101f0c <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101f0c:	6a 00                	push   $0x0
  pushl $0
  101f0e:	6a 00                	push   $0x0
  jmp __alltraps
  101f10:	e9 d5 ff ff ff       	jmp    101eea <__alltraps>

00101f15 <vector1>:
.globl vector1
vector1:
  pushl $0
  101f15:	6a 00                	push   $0x0
  pushl $1
  101f17:	6a 01                	push   $0x1
  jmp __alltraps
  101f19:	e9 cc ff ff ff       	jmp    101eea <__alltraps>

00101f1e <vector2>:
.globl vector2
vector2:
  pushl $0
  101f1e:	6a 00                	push   $0x0
  pushl $2
  101f20:	6a 02                	push   $0x2
  jmp __alltraps
  101f22:	e9 c3 ff ff ff       	jmp    101eea <__alltraps>

00101f27 <vector3>:
.globl vector3
vector3:
  pushl $0
  101f27:	6a 00                	push   $0x0
  pushl $3
  101f29:	6a 03                	push   $0x3
  jmp __alltraps
  101f2b:	e9 ba ff ff ff       	jmp    101eea <__alltraps>

00101f30 <vector4>:
.globl vector4
vector4:
  pushl $0
  101f30:	6a 00                	push   $0x0
  pushl $4
  101f32:	6a 04                	push   $0x4
  jmp __alltraps
  101f34:	e9 b1 ff ff ff       	jmp    101eea <__alltraps>

00101f39 <vector5>:
.globl vector5
vector5:
  pushl $0
  101f39:	6a 00                	push   $0x0
  pushl $5
  101f3b:	6a 05                	push   $0x5
  jmp __alltraps
  101f3d:	e9 a8 ff ff ff       	jmp    101eea <__alltraps>

00101f42 <vector6>:
.globl vector6
vector6:
  pushl $0
  101f42:	6a 00                	push   $0x0
  pushl $6
  101f44:	6a 06                	push   $0x6
  jmp __alltraps
  101f46:	e9 9f ff ff ff       	jmp    101eea <__alltraps>

00101f4b <vector7>:
.globl vector7
vector7:
  pushl $0
  101f4b:	6a 00                	push   $0x0
  pushl $7
  101f4d:	6a 07                	push   $0x7
  jmp __alltraps
  101f4f:	e9 96 ff ff ff       	jmp    101eea <__alltraps>

00101f54 <vector8>:
.globl vector8
vector8:
  pushl $8
  101f54:	6a 08                	push   $0x8
  jmp __alltraps
  101f56:	e9 8f ff ff ff       	jmp    101eea <__alltraps>

00101f5b <vector9>:
.globl vector9
vector9:
  pushl $9
  101f5b:	6a 09                	push   $0x9
  jmp __alltraps
  101f5d:	e9 88 ff ff ff       	jmp    101eea <__alltraps>

00101f62 <vector10>:
.globl vector10
vector10:
  pushl $10
  101f62:	6a 0a                	push   $0xa
  jmp __alltraps
  101f64:	e9 81 ff ff ff       	jmp    101eea <__alltraps>

00101f69 <vector11>:
.globl vector11
vector11:
  pushl $11
  101f69:	6a 0b                	push   $0xb
  jmp __alltraps
  101f6b:	e9 7a ff ff ff       	jmp    101eea <__alltraps>

00101f70 <vector12>:
.globl vector12
vector12:
  pushl $12
  101f70:	6a 0c                	push   $0xc
  jmp __alltraps
  101f72:	e9 73 ff ff ff       	jmp    101eea <__alltraps>

00101f77 <vector13>:
.globl vector13
vector13:
  pushl $13
  101f77:	6a 0d                	push   $0xd
  jmp __alltraps
  101f79:	e9 6c ff ff ff       	jmp    101eea <__alltraps>

00101f7e <vector14>:
.globl vector14
vector14:
  pushl $14
  101f7e:	6a 0e                	push   $0xe
  jmp __alltraps
  101f80:	e9 65 ff ff ff       	jmp    101eea <__alltraps>

00101f85 <vector15>:
.globl vector15
vector15:
  pushl $0
  101f85:	6a 00                	push   $0x0
  pushl $15
  101f87:	6a 0f                	push   $0xf
  jmp __alltraps
  101f89:	e9 5c ff ff ff       	jmp    101eea <__alltraps>

00101f8e <vector16>:
.globl vector16
vector16:
  pushl $0
  101f8e:	6a 00                	push   $0x0
  pushl $16
  101f90:	6a 10                	push   $0x10
  jmp __alltraps
  101f92:	e9 53 ff ff ff       	jmp    101eea <__alltraps>

00101f97 <vector17>:
.globl vector17
vector17:
  pushl $17
  101f97:	6a 11                	push   $0x11
  jmp __alltraps
  101f99:	e9 4c ff ff ff       	jmp    101eea <__alltraps>

00101f9e <vector18>:
.globl vector18
vector18:
  pushl $0
  101f9e:	6a 00                	push   $0x0
  pushl $18
  101fa0:	6a 12                	push   $0x12
  jmp __alltraps
  101fa2:	e9 43 ff ff ff       	jmp    101eea <__alltraps>

00101fa7 <vector19>:
.globl vector19
vector19:
  pushl $0
  101fa7:	6a 00                	push   $0x0
  pushl $19
  101fa9:	6a 13                	push   $0x13
  jmp __alltraps
  101fab:	e9 3a ff ff ff       	jmp    101eea <__alltraps>

00101fb0 <vector20>:
.globl vector20
vector20:
  pushl $0
  101fb0:	6a 00                	push   $0x0
  pushl $20
  101fb2:	6a 14                	push   $0x14
  jmp __alltraps
  101fb4:	e9 31 ff ff ff       	jmp    101eea <__alltraps>

00101fb9 <vector21>:
.globl vector21
vector21:
  pushl $0
  101fb9:	6a 00                	push   $0x0
  pushl $21
  101fbb:	6a 15                	push   $0x15
  jmp __alltraps
  101fbd:	e9 28 ff ff ff       	jmp    101eea <__alltraps>

00101fc2 <vector22>:
.globl vector22
vector22:
  pushl $0
  101fc2:	6a 00                	push   $0x0
  pushl $22
  101fc4:	6a 16                	push   $0x16
  jmp __alltraps
  101fc6:	e9 1f ff ff ff       	jmp    101eea <__alltraps>

00101fcb <vector23>:
.globl vector23
vector23:
  pushl $0
  101fcb:	6a 00                	push   $0x0
  pushl $23
  101fcd:	6a 17                	push   $0x17
  jmp __alltraps
  101fcf:	e9 16 ff ff ff       	jmp    101eea <__alltraps>

00101fd4 <vector24>:
.globl vector24
vector24:
  pushl $0
  101fd4:	6a 00                	push   $0x0
  pushl $24
  101fd6:	6a 18                	push   $0x18
  jmp __alltraps
  101fd8:	e9 0d ff ff ff       	jmp    101eea <__alltraps>

00101fdd <vector25>:
.globl vector25
vector25:
  pushl $0
  101fdd:	6a 00                	push   $0x0
  pushl $25
  101fdf:	6a 19                	push   $0x19
  jmp __alltraps
  101fe1:	e9 04 ff ff ff       	jmp    101eea <__alltraps>

00101fe6 <vector26>:
.globl vector26
vector26:
  pushl $0
  101fe6:	6a 00                	push   $0x0
  pushl $26
  101fe8:	6a 1a                	push   $0x1a
  jmp __alltraps
  101fea:	e9 fb fe ff ff       	jmp    101eea <__alltraps>

00101fef <vector27>:
.globl vector27
vector27:
  pushl $0
  101fef:	6a 00                	push   $0x0
  pushl $27
  101ff1:	6a 1b                	push   $0x1b
  jmp __alltraps
  101ff3:	e9 f2 fe ff ff       	jmp    101eea <__alltraps>

00101ff8 <vector28>:
.globl vector28
vector28:
  pushl $0
  101ff8:	6a 00                	push   $0x0
  pushl $28
  101ffa:	6a 1c                	push   $0x1c
  jmp __alltraps
  101ffc:	e9 e9 fe ff ff       	jmp    101eea <__alltraps>

00102001 <vector29>:
.globl vector29
vector29:
  pushl $0
  102001:	6a 00                	push   $0x0
  pushl $29
  102003:	6a 1d                	push   $0x1d
  jmp __alltraps
  102005:	e9 e0 fe ff ff       	jmp    101eea <__alltraps>

0010200a <vector30>:
.globl vector30
vector30:
  pushl $0
  10200a:	6a 00                	push   $0x0
  pushl $30
  10200c:	6a 1e                	push   $0x1e
  jmp __alltraps
  10200e:	e9 d7 fe ff ff       	jmp    101eea <__alltraps>

00102013 <vector31>:
.globl vector31
vector31:
  pushl $0
  102013:	6a 00                	push   $0x0
  pushl $31
  102015:	6a 1f                	push   $0x1f
  jmp __alltraps
  102017:	e9 ce fe ff ff       	jmp    101eea <__alltraps>

0010201c <vector32>:
.globl vector32
vector32:
  pushl $0
  10201c:	6a 00                	push   $0x0
  pushl $32
  10201e:	6a 20                	push   $0x20
  jmp __alltraps
  102020:	e9 c5 fe ff ff       	jmp    101eea <__alltraps>

00102025 <vector33>:
.globl vector33
vector33:
  pushl $0
  102025:	6a 00                	push   $0x0
  pushl $33
  102027:	6a 21                	push   $0x21
  jmp __alltraps
  102029:	e9 bc fe ff ff       	jmp    101eea <__alltraps>

0010202e <vector34>:
.globl vector34
vector34:
  pushl $0
  10202e:	6a 00                	push   $0x0
  pushl $34
  102030:	6a 22                	push   $0x22
  jmp __alltraps
  102032:	e9 b3 fe ff ff       	jmp    101eea <__alltraps>

00102037 <vector35>:
.globl vector35
vector35:
  pushl $0
  102037:	6a 00                	push   $0x0
  pushl $35
  102039:	6a 23                	push   $0x23
  jmp __alltraps
  10203b:	e9 aa fe ff ff       	jmp    101eea <__alltraps>

00102040 <vector36>:
.globl vector36
vector36:
  pushl $0
  102040:	6a 00                	push   $0x0
  pushl $36
  102042:	6a 24                	push   $0x24
  jmp __alltraps
  102044:	e9 a1 fe ff ff       	jmp    101eea <__alltraps>

00102049 <vector37>:
.globl vector37
vector37:
  pushl $0
  102049:	6a 00                	push   $0x0
  pushl $37
  10204b:	6a 25                	push   $0x25
  jmp __alltraps
  10204d:	e9 98 fe ff ff       	jmp    101eea <__alltraps>

00102052 <vector38>:
.globl vector38
vector38:
  pushl $0
  102052:	6a 00                	push   $0x0
  pushl $38
  102054:	6a 26                	push   $0x26
  jmp __alltraps
  102056:	e9 8f fe ff ff       	jmp    101eea <__alltraps>

0010205b <vector39>:
.globl vector39
vector39:
  pushl $0
  10205b:	6a 00                	push   $0x0
  pushl $39
  10205d:	6a 27                	push   $0x27
  jmp __alltraps
  10205f:	e9 86 fe ff ff       	jmp    101eea <__alltraps>

00102064 <vector40>:
.globl vector40
vector40:
  pushl $0
  102064:	6a 00                	push   $0x0
  pushl $40
  102066:	6a 28                	push   $0x28
  jmp __alltraps
  102068:	e9 7d fe ff ff       	jmp    101eea <__alltraps>

0010206d <vector41>:
.globl vector41
vector41:
  pushl $0
  10206d:	6a 00                	push   $0x0
  pushl $41
  10206f:	6a 29                	push   $0x29
  jmp __alltraps
  102071:	e9 74 fe ff ff       	jmp    101eea <__alltraps>

00102076 <vector42>:
.globl vector42
vector42:
  pushl $0
  102076:	6a 00                	push   $0x0
  pushl $42
  102078:	6a 2a                	push   $0x2a
  jmp __alltraps
  10207a:	e9 6b fe ff ff       	jmp    101eea <__alltraps>

0010207f <vector43>:
.globl vector43
vector43:
  pushl $0
  10207f:	6a 00                	push   $0x0
  pushl $43
  102081:	6a 2b                	push   $0x2b
  jmp __alltraps
  102083:	e9 62 fe ff ff       	jmp    101eea <__alltraps>

00102088 <vector44>:
.globl vector44
vector44:
  pushl $0
  102088:	6a 00                	push   $0x0
  pushl $44
  10208a:	6a 2c                	push   $0x2c
  jmp __alltraps
  10208c:	e9 59 fe ff ff       	jmp    101eea <__alltraps>

00102091 <vector45>:
.globl vector45
vector45:
  pushl $0
  102091:	6a 00                	push   $0x0
  pushl $45
  102093:	6a 2d                	push   $0x2d
  jmp __alltraps
  102095:	e9 50 fe ff ff       	jmp    101eea <__alltraps>

0010209a <vector46>:
.globl vector46
vector46:
  pushl $0
  10209a:	6a 00                	push   $0x0
  pushl $46
  10209c:	6a 2e                	push   $0x2e
  jmp __alltraps
  10209e:	e9 47 fe ff ff       	jmp    101eea <__alltraps>

001020a3 <vector47>:
.globl vector47
vector47:
  pushl $0
  1020a3:	6a 00                	push   $0x0
  pushl $47
  1020a5:	6a 2f                	push   $0x2f
  jmp __alltraps
  1020a7:	e9 3e fe ff ff       	jmp    101eea <__alltraps>

001020ac <vector48>:
.globl vector48
vector48:
  pushl $0
  1020ac:	6a 00                	push   $0x0
  pushl $48
  1020ae:	6a 30                	push   $0x30
  jmp __alltraps
  1020b0:	e9 35 fe ff ff       	jmp    101eea <__alltraps>

001020b5 <vector49>:
.globl vector49
vector49:
  pushl $0
  1020b5:	6a 00                	push   $0x0
  pushl $49
  1020b7:	6a 31                	push   $0x31
  jmp __alltraps
  1020b9:	e9 2c fe ff ff       	jmp    101eea <__alltraps>

001020be <vector50>:
.globl vector50
vector50:
  pushl $0
  1020be:	6a 00                	push   $0x0
  pushl $50
  1020c0:	6a 32                	push   $0x32
  jmp __alltraps
  1020c2:	e9 23 fe ff ff       	jmp    101eea <__alltraps>

001020c7 <vector51>:
.globl vector51
vector51:
  pushl $0
  1020c7:	6a 00                	push   $0x0
  pushl $51
  1020c9:	6a 33                	push   $0x33
  jmp __alltraps
  1020cb:	e9 1a fe ff ff       	jmp    101eea <__alltraps>

001020d0 <vector52>:
.globl vector52
vector52:
  pushl $0
  1020d0:	6a 00                	push   $0x0
  pushl $52
  1020d2:	6a 34                	push   $0x34
  jmp __alltraps
  1020d4:	e9 11 fe ff ff       	jmp    101eea <__alltraps>

001020d9 <vector53>:
.globl vector53
vector53:
  pushl $0
  1020d9:	6a 00                	push   $0x0
  pushl $53
  1020db:	6a 35                	push   $0x35
  jmp __alltraps
  1020dd:	e9 08 fe ff ff       	jmp    101eea <__alltraps>

001020e2 <vector54>:
.globl vector54
vector54:
  pushl $0
  1020e2:	6a 00                	push   $0x0
  pushl $54
  1020e4:	6a 36                	push   $0x36
  jmp __alltraps
  1020e6:	e9 ff fd ff ff       	jmp    101eea <__alltraps>

001020eb <vector55>:
.globl vector55
vector55:
  pushl $0
  1020eb:	6a 00                	push   $0x0
  pushl $55
  1020ed:	6a 37                	push   $0x37
  jmp __alltraps
  1020ef:	e9 f6 fd ff ff       	jmp    101eea <__alltraps>

001020f4 <vector56>:
.globl vector56
vector56:
  pushl $0
  1020f4:	6a 00                	push   $0x0
  pushl $56
  1020f6:	6a 38                	push   $0x38
  jmp __alltraps
  1020f8:	e9 ed fd ff ff       	jmp    101eea <__alltraps>

001020fd <vector57>:
.globl vector57
vector57:
  pushl $0
  1020fd:	6a 00                	push   $0x0
  pushl $57
  1020ff:	6a 39                	push   $0x39
  jmp __alltraps
  102101:	e9 e4 fd ff ff       	jmp    101eea <__alltraps>

00102106 <vector58>:
.globl vector58
vector58:
  pushl $0
  102106:	6a 00                	push   $0x0
  pushl $58
  102108:	6a 3a                	push   $0x3a
  jmp __alltraps
  10210a:	e9 db fd ff ff       	jmp    101eea <__alltraps>

0010210f <vector59>:
.globl vector59
vector59:
  pushl $0
  10210f:	6a 00                	push   $0x0
  pushl $59
  102111:	6a 3b                	push   $0x3b
  jmp __alltraps
  102113:	e9 d2 fd ff ff       	jmp    101eea <__alltraps>

00102118 <vector60>:
.globl vector60
vector60:
  pushl $0
  102118:	6a 00                	push   $0x0
  pushl $60
  10211a:	6a 3c                	push   $0x3c
  jmp __alltraps
  10211c:	e9 c9 fd ff ff       	jmp    101eea <__alltraps>

00102121 <vector61>:
.globl vector61
vector61:
  pushl $0
  102121:	6a 00                	push   $0x0
  pushl $61
  102123:	6a 3d                	push   $0x3d
  jmp __alltraps
  102125:	e9 c0 fd ff ff       	jmp    101eea <__alltraps>

0010212a <vector62>:
.globl vector62
vector62:
  pushl $0
  10212a:	6a 00                	push   $0x0
  pushl $62
  10212c:	6a 3e                	push   $0x3e
  jmp __alltraps
  10212e:	e9 b7 fd ff ff       	jmp    101eea <__alltraps>

00102133 <vector63>:
.globl vector63
vector63:
  pushl $0
  102133:	6a 00                	push   $0x0
  pushl $63
  102135:	6a 3f                	push   $0x3f
  jmp __alltraps
  102137:	e9 ae fd ff ff       	jmp    101eea <__alltraps>

0010213c <vector64>:
.globl vector64
vector64:
  pushl $0
  10213c:	6a 00                	push   $0x0
  pushl $64
  10213e:	6a 40                	push   $0x40
  jmp __alltraps
  102140:	e9 a5 fd ff ff       	jmp    101eea <__alltraps>

00102145 <vector65>:
.globl vector65
vector65:
  pushl $0
  102145:	6a 00                	push   $0x0
  pushl $65
  102147:	6a 41                	push   $0x41
  jmp __alltraps
  102149:	e9 9c fd ff ff       	jmp    101eea <__alltraps>

0010214e <vector66>:
.globl vector66
vector66:
  pushl $0
  10214e:	6a 00                	push   $0x0
  pushl $66
  102150:	6a 42                	push   $0x42
  jmp __alltraps
  102152:	e9 93 fd ff ff       	jmp    101eea <__alltraps>

00102157 <vector67>:
.globl vector67
vector67:
  pushl $0
  102157:	6a 00                	push   $0x0
  pushl $67
  102159:	6a 43                	push   $0x43
  jmp __alltraps
  10215b:	e9 8a fd ff ff       	jmp    101eea <__alltraps>

00102160 <vector68>:
.globl vector68
vector68:
  pushl $0
  102160:	6a 00                	push   $0x0
  pushl $68
  102162:	6a 44                	push   $0x44
  jmp __alltraps
  102164:	e9 81 fd ff ff       	jmp    101eea <__alltraps>

00102169 <vector69>:
.globl vector69
vector69:
  pushl $0
  102169:	6a 00                	push   $0x0
  pushl $69
  10216b:	6a 45                	push   $0x45
  jmp __alltraps
  10216d:	e9 78 fd ff ff       	jmp    101eea <__alltraps>

00102172 <vector70>:
.globl vector70
vector70:
  pushl $0
  102172:	6a 00                	push   $0x0
  pushl $70
  102174:	6a 46                	push   $0x46
  jmp __alltraps
  102176:	e9 6f fd ff ff       	jmp    101eea <__alltraps>

0010217b <vector71>:
.globl vector71
vector71:
  pushl $0
  10217b:	6a 00                	push   $0x0
  pushl $71
  10217d:	6a 47                	push   $0x47
  jmp __alltraps
  10217f:	e9 66 fd ff ff       	jmp    101eea <__alltraps>

00102184 <vector72>:
.globl vector72
vector72:
  pushl $0
  102184:	6a 00                	push   $0x0
  pushl $72
  102186:	6a 48                	push   $0x48
  jmp __alltraps
  102188:	e9 5d fd ff ff       	jmp    101eea <__alltraps>

0010218d <vector73>:
.globl vector73
vector73:
  pushl $0
  10218d:	6a 00                	push   $0x0
  pushl $73
  10218f:	6a 49                	push   $0x49
  jmp __alltraps
  102191:	e9 54 fd ff ff       	jmp    101eea <__alltraps>

00102196 <vector74>:
.globl vector74
vector74:
  pushl $0
  102196:	6a 00                	push   $0x0
  pushl $74
  102198:	6a 4a                	push   $0x4a
  jmp __alltraps
  10219a:	e9 4b fd ff ff       	jmp    101eea <__alltraps>

0010219f <vector75>:
.globl vector75
vector75:
  pushl $0
  10219f:	6a 00                	push   $0x0
  pushl $75
  1021a1:	6a 4b                	push   $0x4b
  jmp __alltraps
  1021a3:	e9 42 fd ff ff       	jmp    101eea <__alltraps>

001021a8 <vector76>:
.globl vector76
vector76:
  pushl $0
  1021a8:	6a 00                	push   $0x0
  pushl $76
  1021aa:	6a 4c                	push   $0x4c
  jmp __alltraps
  1021ac:	e9 39 fd ff ff       	jmp    101eea <__alltraps>

001021b1 <vector77>:
.globl vector77
vector77:
  pushl $0
  1021b1:	6a 00                	push   $0x0
  pushl $77
  1021b3:	6a 4d                	push   $0x4d
  jmp __alltraps
  1021b5:	e9 30 fd ff ff       	jmp    101eea <__alltraps>

001021ba <vector78>:
.globl vector78
vector78:
  pushl $0
  1021ba:	6a 00                	push   $0x0
  pushl $78
  1021bc:	6a 4e                	push   $0x4e
  jmp __alltraps
  1021be:	e9 27 fd ff ff       	jmp    101eea <__alltraps>

001021c3 <vector79>:
.globl vector79
vector79:
  pushl $0
  1021c3:	6a 00                	push   $0x0
  pushl $79
  1021c5:	6a 4f                	push   $0x4f
  jmp __alltraps
  1021c7:	e9 1e fd ff ff       	jmp    101eea <__alltraps>

001021cc <vector80>:
.globl vector80
vector80:
  pushl $0
  1021cc:	6a 00                	push   $0x0
  pushl $80
  1021ce:	6a 50                	push   $0x50
  jmp __alltraps
  1021d0:	e9 15 fd ff ff       	jmp    101eea <__alltraps>

001021d5 <vector81>:
.globl vector81
vector81:
  pushl $0
  1021d5:	6a 00                	push   $0x0
  pushl $81
  1021d7:	6a 51                	push   $0x51
  jmp __alltraps
  1021d9:	e9 0c fd ff ff       	jmp    101eea <__alltraps>

001021de <vector82>:
.globl vector82
vector82:
  pushl $0
  1021de:	6a 00                	push   $0x0
  pushl $82
  1021e0:	6a 52                	push   $0x52
  jmp __alltraps
  1021e2:	e9 03 fd ff ff       	jmp    101eea <__alltraps>

001021e7 <vector83>:
.globl vector83
vector83:
  pushl $0
  1021e7:	6a 00                	push   $0x0
  pushl $83
  1021e9:	6a 53                	push   $0x53
  jmp __alltraps
  1021eb:	e9 fa fc ff ff       	jmp    101eea <__alltraps>

001021f0 <vector84>:
.globl vector84
vector84:
  pushl $0
  1021f0:	6a 00                	push   $0x0
  pushl $84
  1021f2:	6a 54                	push   $0x54
  jmp __alltraps
  1021f4:	e9 f1 fc ff ff       	jmp    101eea <__alltraps>

001021f9 <vector85>:
.globl vector85
vector85:
  pushl $0
  1021f9:	6a 00                	push   $0x0
  pushl $85
  1021fb:	6a 55                	push   $0x55
  jmp __alltraps
  1021fd:	e9 e8 fc ff ff       	jmp    101eea <__alltraps>

00102202 <vector86>:
.globl vector86
vector86:
  pushl $0
  102202:	6a 00                	push   $0x0
  pushl $86
  102204:	6a 56                	push   $0x56
  jmp __alltraps
  102206:	e9 df fc ff ff       	jmp    101eea <__alltraps>

0010220b <vector87>:
.globl vector87
vector87:
  pushl $0
  10220b:	6a 00                	push   $0x0
  pushl $87
  10220d:	6a 57                	push   $0x57
  jmp __alltraps
  10220f:	e9 d6 fc ff ff       	jmp    101eea <__alltraps>

00102214 <vector88>:
.globl vector88
vector88:
  pushl $0
  102214:	6a 00                	push   $0x0
  pushl $88
  102216:	6a 58                	push   $0x58
  jmp __alltraps
  102218:	e9 cd fc ff ff       	jmp    101eea <__alltraps>

0010221d <vector89>:
.globl vector89
vector89:
  pushl $0
  10221d:	6a 00                	push   $0x0
  pushl $89
  10221f:	6a 59                	push   $0x59
  jmp __alltraps
  102221:	e9 c4 fc ff ff       	jmp    101eea <__alltraps>

00102226 <vector90>:
.globl vector90
vector90:
  pushl $0
  102226:	6a 00                	push   $0x0
  pushl $90
  102228:	6a 5a                	push   $0x5a
  jmp __alltraps
  10222a:	e9 bb fc ff ff       	jmp    101eea <__alltraps>

0010222f <vector91>:
.globl vector91
vector91:
  pushl $0
  10222f:	6a 00                	push   $0x0
  pushl $91
  102231:	6a 5b                	push   $0x5b
  jmp __alltraps
  102233:	e9 b2 fc ff ff       	jmp    101eea <__alltraps>

00102238 <vector92>:
.globl vector92
vector92:
  pushl $0
  102238:	6a 00                	push   $0x0
  pushl $92
  10223a:	6a 5c                	push   $0x5c
  jmp __alltraps
  10223c:	e9 a9 fc ff ff       	jmp    101eea <__alltraps>

00102241 <vector93>:
.globl vector93
vector93:
  pushl $0
  102241:	6a 00                	push   $0x0
  pushl $93
  102243:	6a 5d                	push   $0x5d
  jmp __alltraps
  102245:	e9 a0 fc ff ff       	jmp    101eea <__alltraps>

0010224a <vector94>:
.globl vector94
vector94:
  pushl $0
  10224a:	6a 00                	push   $0x0
  pushl $94
  10224c:	6a 5e                	push   $0x5e
  jmp __alltraps
  10224e:	e9 97 fc ff ff       	jmp    101eea <__alltraps>

00102253 <vector95>:
.globl vector95
vector95:
  pushl $0
  102253:	6a 00                	push   $0x0
  pushl $95
  102255:	6a 5f                	push   $0x5f
  jmp __alltraps
  102257:	e9 8e fc ff ff       	jmp    101eea <__alltraps>

0010225c <vector96>:
.globl vector96
vector96:
  pushl $0
  10225c:	6a 00                	push   $0x0
  pushl $96
  10225e:	6a 60                	push   $0x60
  jmp __alltraps
  102260:	e9 85 fc ff ff       	jmp    101eea <__alltraps>

00102265 <vector97>:
.globl vector97
vector97:
  pushl $0
  102265:	6a 00                	push   $0x0
  pushl $97
  102267:	6a 61                	push   $0x61
  jmp __alltraps
  102269:	e9 7c fc ff ff       	jmp    101eea <__alltraps>

0010226e <vector98>:
.globl vector98
vector98:
  pushl $0
  10226e:	6a 00                	push   $0x0
  pushl $98
  102270:	6a 62                	push   $0x62
  jmp __alltraps
  102272:	e9 73 fc ff ff       	jmp    101eea <__alltraps>

00102277 <vector99>:
.globl vector99
vector99:
  pushl $0
  102277:	6a 00                	push   $0x0
  pushl $99
  102279:	6a 63                	push   $0x63
  jmp __alltraps
  10227b:	e9 6a fc ff ff       	jmp    101eea <__alltraps>

00102280 <vector100>:
.globl vector100
vector100:
  pushl $0
  102280:	6a 00                	push   $0x0
  pushl $100
  102282:	6a 64                	push   $0x64
  jmp __alltraps
  102284:	e9 61 fc ff ff       	jmp    101eea <__alltraps>

00102289 <vector101>:
.globl vector101
vector101:
  pushl $0
  102289:	6a 00                	push   $0x0
  pushl $101
  10228b:	6a 65                	push   $0x65
  jmp __alltraps
  10228d:	e9 58 fc ff ff       	jmp    101eea <__alltraps>

00102292 <vector102>:
.globl vector102
vector102:
  pushl $0
  102292:	6a 00                	push   $0x0
  pushl $102
  102294:	6a 66                	push   $0x66
  jmp __alltraps
  102296:	e9 4f fc ff ff       	jmp    101eea <__alltraps>

0010229b <vector103>:
.globl vector103
vector103:
  pushl $0
  10229b:	6a 00                	push   $0x0
  pushl $103
  10229d:	6a 67                	push   $0x67
  jmp __alltraps
  10229f:	e9 46 fc ff ff       	jmp    101eea <__alltraps>

001022a4 <vector104>:
.globl vector104
vector104:
  pushl $0
  1022a4:	6a 00                	push   $0x0
  pushl $104
  1022a6:	6a 68                	push   $0x68
  jmp __alltraps
  1022a8:	e9 3d fc ff ff       	jmp    101eea <__alltraps>

001022ad <vector105>:
.globl vector105
vector105:
  pushl $0
  1022ad:	6a 00                	push   $0x0
  pushl $105
  1022af:	6a 69                	push   $0x69
  jmp __alltraps
  1022b1:	e9 34 fc ff ff       	jmp    101eea <__alltraps>

001022b6 <vector106>:
.globl vector106
vector106:
  pushl $0
  1022b6:	6a 00                	push   $0x0
  pushl $106
  1022b8:	6a 6a                	push   $0x6a
  jmp __alltraps
  1022ba:	e9 2b fc ff ff       	jmp    101eea <__alltraps>

001022bf <vector107>:
.globl vector107
vector107:
  pushl $0
  1022bf:	6a 00                	push   $0x0
  pushl $107
  1022c1:	6a 6b                	push   $0x6b
  jmp __alltraps
  1022c3:	e9 22 fc ff ff       	jmp    101eea <__alltraps>

001022c8 <vector108>:
.globl vector108
vector108:
  pushl $0
  1022c8:	6a 00                	push   $0x0
  pushl $108
  1022ca:	6a 6c                	push   $0x6c
  jmp __alltraps
  1022cc:	e9 19 fc ff ff       	jmp    101eea <__alltraps>

001022d1 <vector109>:
.globl vector109
vector109:
  pushl $0
  1022d1:	6a 00                	push   $0x0
  pushl $109
  1022d3:	6a 6d                	push   $0x6d
  jmp __alltraps
  1022d5:	e9 10 fc ff ff       	jmp    101eea <__alltraps>

001022da <vector110>:
.globl vector110
vector110:
  pushl $0
  1022da:	6a 00                	push   $0x0
  pushl $110
  1022dc:	6a 6e                	push   $0x6e
  jmp __alltraps
  1022de:	e9 07 fc ff ff       	jmp    101eea <__alltraps>

001022e3 <vector111>:
.globl vector111
vector111:
  pushl $0
  1022e3:	6a 00                	push   $0x0
  pushl $111
  1022e5:	6a 6f                	push   $0x6f
  jmp __alltraps
  1022e7:	e9 fe fb ff ff       	jmp    101eea <__alltraps>

001022ec <vector112>:
.globl vector112
vector112:
  pushl $0
  1022ec:	6a 00                	push   $0x0
  pushl $112
  1022ee:	6a 70                	push   $0x70
  jmp __alltraps
  1022f0:	e9 f5 fb ff ff       	jmp    101eea <__alltraps>

001022f5 <vector113>:
.globl vector113
vector113:
  pushl $0
  1022f5:	6a 00                	push   $0x0
  pushl $113
  1022f7:	6a 71                	push   $0x71
  jmp __alltraps
  1022f9:	e9 ec fb ff ff       	jmp    101eea <__alltraps>

001022fe <vector114>:
.globl vector114
vector114:
  pushl $0
  1022fe:	6a 00                	push   $0x0
  pushl $114
  102300:	6a 72                	push   $0x72
  jmp __alltraps
  102302:	e9 e3 fb ff ff       	jmp    101eea <__alltraps>

00102307 <vector115>:
.globl vector115
vector115:
  pushl $0
  102307:	6a 00                	push   $0x0
  pushl $115
  102309:	6a 73                	push   $0x73
  jmp __alltraps
  10230b:	e9 da fb ff ff       	jmp    101eea <__alltraps>

00102310 <vector116>:
.globl vector116
vector116:
  pushl $0
  102310:	6a 00                	push   $0x0
  pushl $116
  102312:	6a 74                	push   $0x74
  jmp __alltraps
  102314:	e9 d1 fb ff ff       	jmp    101eea <__alltraps>

00102319 <vector117>:
.globl vector117
vector117:
  pushl $0
  102319:	6a 00                	push   $0x0
  pushl $117
  10231b:	6a 75                	push   $0x75
  jmp __alltraps
  10231d:	e9 c8 fb ff ff       	jmp    101eea <__alltraps>

00102322 <vector118>:
.globl vector118
vector118:
  pushl $0
  102322:	6a 00                	push   $0x0
  pushl $118
  102324:	6a 76                	push   $0x76
  jmp __alltraps
  102326:	e9 bf fb ff ff       	jmp    101eea <__alltraps>

0010232b <vector119>:
.globl vector119
vector119:
  pushl $0
  10232b:	6a 00                	push   $0x0
  pushl $119
  10232d:	6a 77                	push   $0x77
  jmp __alltraps
  10232f:	e9 b6 fb ff ff       	jmp    101eea <__alltraps>

00102334 <vector120>:
.globl vector120
vector120:
  pushl $0
  102334:	6a 00                	push   $0x0
  pushl $120
  102336:	6a 78                	push   $0x78
  jmp __alltraps
  102338:	e9 ad fb ff ff       	jmp    101eea <__alltraps>

0010233d <vector121>:
.globl vector121
vector121:
  pushl $0
  10233d:	6a 00                	push   $0x0
  pushl $121
  10233f:	6a 79                	push   $0x79
  jmp __alltraps
  102341:	e9 a4 fb ff ff       	jmp    101eea <__alltraps>

00102346 <vector122>:
.globl vector122
vector122:
  pushl $0
  102346:	6a 00                	push   $0x0
  pushl $122
  102348:	6a 7a                	push   $0x7a
  jmp __alltraps
  10234a:	e9 9b fb ff ff       	jmp    101eea <__alltraps>

0010234f <vector123>:
.globl vector123
vector123:
  pushl $0
  10234f:	6a 00                	push   $0x0
  pushl $123
  102351:	6a 7b                	push   $0x7b
  jmp __alltraps
  102353:	e9 92 fb ff ff       	jmp    101eea <__alltraps>

00102358 <vector124>:
.globl vector124
vector124:
  pushl $0
  102358:	6a 00                	push   $0x0
  pushl $124
  10235a:	6a 7c                	push   $0x7c
  jmp __alltraps
  10235c:	e9 89 fb ff ff       	jmp    101eea <__alltraps>

00102361 <vector125>:
.globl vector125
vector125:
  pushl $0
  102361:	6a 00                	push   $0x0
  pushl $125
  102363:	6a 7d                	push   $0x7d
  jmp __alltraps
  102365:	e9 80 fb ff ff       	jmp    101eea <__alltraps>

0010236a <vector126>:
.globl vector126
vector126:
  pushl $0
  10236a:	6a 00                	push   $0x0
  pushl $126
  10236c:	6a 7e                	push   $0x7e
  jmp __alltraps
  10236e:	e9 77 fb ff ff       	jmp    101eea <__alltraps>

00102373 <vector127>:
.globl vector127
vector127:
  pushl $0
  102373:	6a 00                	push   $0x0
  pushl $127
  102375:	6a 7f                	push   $0x7f
  jmp __alltraps
  102377:	e9 6e fb ff ff       	jmp    101eea <__alltraps>

0010237c <vector128>:
.globl vector128
vector128:
  pushl $0
  10237c:	6a 00                	push   $0x0
  pushl $128
  10237e:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  102383:	e9 62 fb ff ff       	jmp    101eea <__alltraps>

00102388 <vector129>:
.globl vector129
vector129:
  pushl $0
  102388:	6a 00                	push   $0x0
  pushl $129
  10238a:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  10238f:	e9 56 fb ff ff       	jmp    101eea <__alltraps>

00102394 <vector130>:
.globl vector130
vector130:
  pushl $0
  102394:	6a 00                	push   $0x0
  pushl $130
  102396:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  10239b:	e9 4a fb ff ff       	jmp    101eea <__alltraps>

001023a0 <vector131>:
.globl vector131
vector131:
  pushl $0
  1023a0:	6a 00                	push   $0x0
  pushl $131
  1023a2:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  1023a7:	e9 3e fb ff ff       	jmp    101eea <__alltraps>

001023ac <vector132>:
.globl vector132
vector132:
  pushl $0
  1023ac:	6a 00                	push   $0x0
  pushl $132
  1023ae:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  1023b3:	e9 32 fb ff ff       	jmp    101eea <__alltraps>

001023b8 <vector133>:
.globl vector133
vector133:
  pushl $0
  1023b8:	6a 00                	push   $0x0
  pushl $133
  1023ba:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  1023bf:	e9 26 fb ff ff       	jmp    101eea <__alltraps>

001023c4 <vector134>:
.globl vector134
vector134:
  pushl $0
  1023c4:	6a 00                	push   $0x0
  pushl $134
  1023c6:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  1023cb:	e9 1a fb ff ff       	jmp    101eea <__alltraps>

001023d0 <vector135>:
.globl vector135
vector135:
  pushl $0
  1023d0:	6a 00                	push   $0x0
  pushl $135
  1023d2:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  1023d7:	e9 0e fb ff ff       	jmp    101eea <__alltraps>

001023dc <vector136>:
.globl vector136
vector136:
  pushl $0
  1023dc:	6a 00                	push   $0x0
  pushl $136
  1023de:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  1023e3:	e9 02 fb ff ff       	jmp    101eea <__alltraps>

001023e8 <vector137>:
.globl vector137
vector137:
  pushl $0
  1023e8:	6a 00                	push   $0x0
  pushl $137
  1023ea:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  1023ef:	e9 f6 fa ff ff       	jmp    101eea <__alltraps>

001023f4 <vector138>:
.globl vector138
vector138:
  pushl $0
  1023f4:	6a 00                	push   $0x0
  pushl $138
  1023f6:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  1023fb:	e9 ea fa ff ff       	jmp    101eea <__alltraps>

00102400 <vector139>:
.globl vector139
vector139:
  pushl $0
  102400:	6a 00                	push   $0x0
  pushl $139
  102402:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  102407:	e9 de fa ff ff       	jmp    101eea <__alltraps>

0010240c <vector140>:
.globl vector140
vector140:
  pushl $0
  10240c:	6a 00                	push   $0x0
  pushl $140
  10240e:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  102413:	e9 d2 fa ff ff       	jmp    101eea <__alltraps>

00102418 <vector141>:
.globl vector141
vector141:
  pushl $0
  102418:	6a 00                	push   $0x0
  pushl $141
  10241a:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  10241f:	e9 c6 fa ff ff       	jmp    101eea <__alltraps>

00102424 <vector142>:
.globl vector142
vector142:
  pushl $0
  102424:	6a 00                	push   $0x0
  pushl $142
  102426:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  10242b:	e9 ba fa ff ff       	jmp    101eea <__alltraps>

00102430 <vector143>:
.globl vector143
vector143:
  pushl $0
  102430:	6a 00                	push   $0x0
  pushl $143
  102432:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  102437:	e9 ae fa ff ff       	jmp    101eea <__alltraps>

0010243c <vector144>:
.globl vector144
vector144:
  pushl $0
  10243c:	6a 00                	push   $0x0
  pushl $144
  10243e:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  102443:	e9 a2 fa ff ff       	jmp    101eea <__alltraps>

00102448 <vector145>:
.globl vector145
vector145:
  pushl $0
  102448:	6a 00                	push   $0x0
  pushl $145
  10244a:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  10244f:	e9 96 fa ff ff       	jmp    101eea <__alltraps>

00102454 <vector146>:
.globl vector146
vector146:
  pushl $0
  102454:	6a 00                	push   $0x0
  pushl $146
  102456:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  10245b:	e9 8a fa ff ff       	jmp    101eea <__alltraps>

00102460 <vector147>:
.globl vector147
vector147:
  pushl $0
  102460:	6a 00                	push   $0x0
  pushl $147
  102462:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  102467:	e9 7e fa ff ff       	jmp    101eea <__alltraps>

0010246c <vector148>:
.globl vector148
vector148:
  pushl $0
  10246c:	6a 00                	push   $0x0
  pushl $148
  10246e:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  102473:	e9 72 fa ff ff       	jmp    101eea <__alltraps>

00102478 <vector149>:
.globl vector149
vector149:
  pushl $0
  102478:	6a 00                	push   $0x0
  pushl $149
  10247a:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  10247f:	e9 66 fa ff ff       	jmp    101eea <__alltraps>

00102484 <vector150>:
.globl vector150
vector150:
  pushl $0
  102484:	6a 00                	push   $0x0
  pushl $150
  102486:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  10248b:	e9 5a fa ff ff       	jmp    101eea <__alltraps>

00102490 <vector151>:
.globl vector151
vector151:
  pushl $0
  102490:	6a 00                	push   $0x0
  pushl $151
  102492:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  102497:	e9 4e fa ff ff       	jmp    101eea <__alltraps>

0010249c <vector152>:
.globl vector152
vector152:
  pushl $0
  10249c:	6a 00                	push   $0x0
  pushl $152
  10249e:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  1024a3:	e9 42 fa ff ff       	jmp    101eea <__alltraps>

001024a8 <vector153>:
.globl vector153
vector153:
  pushl $0
  1024a8:	6a 00                	push   $0x0
  pushl $153
  1024aa:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  1024af:	e9 36 fa ff ff       	jmp    101eea <__alltraps>

001024b4 <vector154>:
.globl vector154
vector154:
  pushl $0
  1024b4:	6a 00                	push   $0x0
  pushl $154
  1024b6:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  1024bb:	e9 2a fa ff ff       	jmp    101eea <__alltraps>

001024c0 <vector155>:
.globl vector155
vector155:
  pushl $0
  1024c0:	6a 00                	push   $0x0
  pushl $155
  1024c2:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  1024c7:	e9 1e fa ff ff       	jmp    101eea <__alltraps>

001024cc <vector156>:
.globl vector156
vector156:
  pushl $0
  1024cc:	6a 00                	push   $0x0
  pushl $156
  1024ce:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  1024d3:	e9 12 fa ff ff       	jmp    101eea <__alltraps>

001024d8 <vector157>:
.globl vector157
vector157:
  pushl $0
  1024d8:	6a 00                	push   $0x0
  pushl $157
  1024da:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  1024df:	e9 06 fa ff ff       	jmp    101eea <__alltraps>

001024e4 <vector158>:
.globl vector158
vector158:
  pushl $0
  1024e4:	6a 00                	push   $0x0
  pushl $158
  1024e6:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  1024eb:	e9 fa f9 ff ff       	jmp    101eea <__alltraps>

001024f0 <vector159>:
.globl vector159
vector159:
  pushl $0
  1024f0:	6a 00                	push   $0x0
  pushl $159
  1024f2:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  1024f7:	e9 ee f9 ff ff       	jmp    101eea <__alltraps>

001024fc <vector160>:
.globl vector160
vector160:
  pushl $0
  1024fc:	6a 00                	push   $0x0
  pushl $160
  1024fe:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  102503:	e9 e2 f9 ff ff       	jmp    101eea <__alltraps>

00102508 <vector161>:
.globl vector161
vector161:
  pushl $0
  102508:	6a 00                	push   $0x0
  pushl $161
  10250a:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  10250f:	e9 d6 f9 ff ff       	jmp    101eea <__alltraps>

00102514 <vector162>:
.globl vector162
vector162:
  pushl $0
  102514:	6a 00                	push   $0x0
  pushl $162
  102516:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  10251b:	e9 ca f9 ff ff       	jmp    101eea <__alltraps>

00102520 <vector163>:
.globl vector163
vector163:
  pushl $0
  102520:	6a 00                	push   $0x0
  pushl $163
  102522:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  102527:	e9 be f9 ff ff       	jmp    101eea <__alltraps>

0010252c <vector164>:
.globl vector164
vector164:
  pushl $0
  10252c:	6a 00                	push   $0x0
  pushl $164
  10252e:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  102533:	e9 b2 f9 ff ff       	jmp    101eea <__alltraps>

00102538 <vector165>:
.globl vector165
vector165:
  pushl $0
  102538:	6a 00                	push   $0x0
  pushl $165
  10253a:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  10253f:	e9 a6 f9 ff ff       	jmp    101eea <__alltraps>

00102544 <vector166>:
.globl vector166
vector166:
  pushl $0
  102544:	6a 00                	push   $0x0
  pushl $166
  102546:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  10254b:	e9 9a f9 ff ff       	jmp    101eea <__alltraps>

00102550 <vector167>:
.globl vector167
vector167:
  pushl $0
  102550:	6a 00                	push   $0x0
  pushl $167
  102552:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  102557:	e9 8e f9 ff ff       	jmp    101eea <__alltraps>

0010255c <vector168>:
.globl vector168
vector168:
  pushl $0
  10255c:	6a 00                	push   $0x0
  pushl $168
  10255e:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  102563:	e9 82 f9 ff ff       	jmp    101eea <__alltraps>

00102568 <vector169>:
.globl vector169
vector169:
  pushl $0
  102568:	6a 00                	push   $0x0
  pushl $169
  10256a:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  10256f:	e9 76 f9 ff ff       	jmp    101eea <__alltraps>

00102574 <vector170>:
.globl vector170
vector170:
  pushl $0
  102574:	6a 00                	push   $0x0
  pushl $170
  102576:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  10257b:	e9 6a f9 ff ff       	jmp    101eea <__alltraps>

00102580 <vector171>:
.globl vector171
vector171:
  pushl $0
  102580:	6a 00                	push   $0x0
  pushl $171
  102582:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  102587:	e9 5e f9 ff ff       	jmp    101eea <__alltraps>

0010258c <vector172>:
.globl vector172
vector172:
  pushl $0
  10258c:	6a 00                	push   $0x0
  pushl $172
  10258e:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  102593:	e9 52 f9 ff ff       	jmp    101eea <__alltraps>

00102598 <vector173>:
.globl vector173
vector173:
  pushl $0
  102598:	6a 00                	push   $0x0
  pushl $173
  10259a:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  10259f:	e9 46 f9 ff ff       	jmp    101eea <__alltraps>

001025a4 <vector174>:
.globl vector174
vector174:
  pushl $0
  1025a4:	6a 00                	push   $0x0
  pushl $174
  1025a6:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  1025ab:	e9 3a f9 ff ff       	jmp    101eea <__alltraps>

001025b0 <vector175>:
.globl vector175
vector175:
  pushl $0
  1025b0:	6a 00                	push   $0x0
  pushl $175
  1025b2:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  1025b7:	e9 2e f9 ff ff       	jmp    101eea <__alltraps>

001025bc <vector176>:
.globl vector176
vector176:
  pushl $0
  1025bc:	6a 00                	push   $0x0
  pushl $176
  1025be:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  1025c3:	e9 22 f9 ff ff       	jmp    101eea <__alltraps>

001025c8 <vector177>:
.globl vector177
vector177:
  pushl $0
  1025c8:	6a 00                	push   $0x0
  pushl $177
  1025ca:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  1025cf:	e9 16 f9 ff ff       	jmp    101eea <__alltraps>

001025d4 <vector178>:
.globl vector178
vector178:
  pushl $0
  1025d4:	6a 00                	push   $0x0
  pushl $178
  1025d6:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  1025db:	e9 0a f9 ff ff       	jmp    101eea <__alltraps>

001025e0 <vector179>:
.globl vector179
vector179:
  pushl $0
  1025e0:	6a 00                	push   $0x0
  pushl $179
  1025e2:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  1025e7:	e9 fe f8 ff ff       	jmp    101eea <__alltraps>

001025ec <vector180>:
.globl vector180
vector180:
  pushl $0
  1025ec:	6a 00                	push   $0x0
  pushl $180
  1025ee:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  1025f3:	e9 f2 f8 ff ff       	jmp    101eea <__alltraps>

001025f8 <vector181>:
.globl vector181
vector181:
  pushl $0
  1025f8:	6a 00                	push   $0x0
  pushl $181
  1025fa:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  1025ff:	e9 e6 f8 ff ff       	jmp    101eea <__alltraps>

00102604 <vector182>:
.globl vector182
vector182:
  pushl $0
  102604:	6a 00                	push   $0x0
  pushl $182
  102606:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  10260b:	e9 da f8 ff ff       	jmp    101eea <__alltraps>

00102610 <vector183>:
.globl vector183
vector183:
  pushl $0
  102610:	6a 00                	push   $0x0
  pushl $183
  102612:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  102617:	e9 ce f8 ff ff       	jmp    101eea <__alltraps>

0010261c <vector184>:
.globl vector184
vector184:
  pushl $0
  10261c:	6a 00                	push   $0x0
  pushl $184
  10261e:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  102623:	e9 c2 f8 ff ff       	jmp    101eea <__alltraps>

00102628 <vector185>:
.globl vector185
vector185:
  pushl $0
  102628:	6a 00                	push   $0x0
  pushl $185
  10262a:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  10262f:	e9 b6 f8 ff ff       	jmp    101eea <__alltraps>

00102634 <vector186>:
.globl vector186
vector186:
  pushl $0
  102634:	6a 00                	push   $0x0
  pushl $186
  102636:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  10263b:	e9 aa f8 ff ff       	jmp    101eea <__alltraps>

00102640 <vector187>:
.globl vector187
vector187:
  pushl $0
  102640:	6a 00                	push   $0x0
  pushl $187
  102642:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  102647:	e9 9e f8 ff ff       	jmp    101eea <__alltraps>

0010264c <vector188>:
.globl vector188
vector188:
  pushl $0
  10264c:	6a 00                	push   $0x0
  pushl $188
  10264e:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  102653:	e9 92 f8 ff ff       	jmp    101eea <__alltraps>

00102658 <vector189>:
.globl vector189
vector189:
  pushl $0
  102658:	6a 00                	push   $0x0
  pushl $189
  10265a:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  10265f:	e9 86 f8 ff ff       	jmp    101eea <__alltraps>

00102664 <vector190>:
.globl vector190
vector190:
  pushl $0
  102664:	6a 00                	push   $0x0
  pushl $190
  102666:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  10266b:	e9 7a f8 ff ff       	jmp    101eea <__alltraps>

00102670 <vector191>:
.globl vector191
vector191:
  pushl $0
  102670:	6a 00                	push   $0x0
  pushl $191
  102672:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  102677:	e9 6e f8 ff ff       	jmp    101eea <__alltraps>

0010267c <vector192>:
.globl vector192
vector192:
  pushl $0
  10267c:	6a 00                	push   $0x0
  pushl $192
  10267e:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  102683:	e9 62 f8 ff ff       	jmp    101eea <__alltraps>

00102688 <vector193>:
.globl vector193
vector193:
  pushl $0
  102688:	6a 00                	push   $0x0
  pushl $193
  10268a:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  10268f:	e9 56 f8 ff ff       	jmp    101eea <__alltraps>

00102694 <vector194>:
.globl vector194
vector194:
  pushl $0
  102694:	6a 00                	push   $0x0
  pushl $194
  102696:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  10269b:	e9 4a f8 ff ff       	jmp    101eea <__alltraps>

001026a0 <vector195>:
.globl vector195
vector195:
  pushl $0
  1026a0:	6a 00                	push   $0x0
  pushl $195
  1026a2:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  1026a7:	e9 3e f8 ff ff       	jmp    101eea <__alltraps>

001026ac <vector196>:
.globl vector196
vector196:
  pushl $0
  1026ac:	6a 00                	push   $0x0
  pushl $196
  1026ae:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  1026b3:	e9 32 f8 ff ff       	jmp    101eea <__alltraps>

001026b8 <vector197>:
.globl vector197
vector197:
  pushl $0
  1026b8:	6a 00                	push   $0x0
  pushl $197
  1026ba:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  1026bf:	e9 26 f8 ff ff       	jmp    101eea <__alltraps>

001026c4 <vector198>:
.globl vector198
vector198:
  pushl $0
  1026c4:	6a 00                	push   $0x0
  pushl $198
  1026c6:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  1026cb:	e9 1a f8 ff ff       	jmp    101eea <__alltraps>

001026d0 <vector199>:
.globl vector199
vector199:
  pushl $0
  1026d0:	6a 00                	push   $0x0
  pushl $199
  1026d2:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  1026d7:	e9 0e f8 ff ff       	jmp    101eea <__alltraps>

001026dc <vector200>:
.globl vector200
vector200:
  pushl $0
  1026dc:	6a 00                	push   $0x0
  pushl $200
  1026de:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  1026e3:	e9 02 f8 ff ff       	jmp    101eea <__alltraps>

001026e8 <vector201>:
.globl vector201
vector201:
  pushl $0
  1026e8:	6a 00                	push   $0x0
  pushl $201
  1026ea:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  1026ef:	e9 f6 f7 ff ff       	jmp    101eea <__alltraps>

001026f4 <vector202>:
.globl vector202
vector202:
  pushl $0
  1026f4:	6a 00                	push   $0x0
  pushl $202
  1026f6:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  1026fb:	e9 ea f7 ff ff       	jmp    101eea <__alltraps>

00102700 <vector203>:
.globl vector203
vector203:
  pushl $0
  102700:	6a 00                	push   $0x0
  pushl $203
  102702:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  102707:	e9 de f7 ff ff       	jmp    101eea <__alltraps>

0010270c <vector204>:
.globl vector204
vector204:
  pushl $0
  10270c:	6a 00                	push   $0x0
  pushl $204
  10270e:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  102713:	e9 d2 f7 ff ff       	jmp    101eea <__alltraps>

00102718 <vector205>:
.globl vector205
vector205:
  pushl $0
  102718:	6a 00                	push   $0x0
  pushl $205
  10271a:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  10271f:	e9 c6 f7 ff ff       	jmp    101eea <__alltraps>

00102724 <vector206>:
.globl vector206
vector206:
  pushl $0
  102724:	6a 00                	push   $0x0
  pushl $206
  102726:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  10272b:	e9 ba f7 ff ff       	jmp    101eea <__alltraps>

00102730 <vector207>:
.globl vector207
vector207:
  pushl $0
  102730:	6a 00                	push   $0x0
  pushl $207
  102732:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  102737:	e9 ae f7 ff ff       	jmp    101eea <__alltraps>

0010273c <vector208>:
.globl vector208
vector208:
  pushl $0
  10273c:	6a 00                	push   $0x0
  pushl $208
  10273e:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  102743:	e9 a2 f7 ff ff       	jmp    101eea <__alltraps>

00102748 <vector209>:
.globl vector209
vector209:
  pushl $0
  102748:	6a 00                	push   $0x0
  pushl $209
  10274a:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  10274f:	e9 96 f7 ff ff       	jmp    101eea <__alltraps>

00102754 <vector210>:
.globl vector210
vector210:
  pushl $0
  102754:	6a 00                	push   $0x0
  pushl $210
  102756:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  10275b:	e9 8a f7 ff ff       	jmp    101eea <__alltraps>

00102760 <vector211>:
.globl vector211
vector211:
  pushl $0
  102760:	6a 00                	push   $0x0
  pushl $211
  102762:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  102767:	e9 7e f7 ff ff       	jmp    101eea <__alltraps>

0010276c <vector212>:
.globl vector212
vector212:
  pushl $0
  10276c:	6a 00                	push   $0x0
  pushl $212
  10276e:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  102773:	e9 72 f7 ff ff       	jmp    101eea <__alltraps>

00102778 <vector213>:
.globl vector213
vector213:
  pushl $0
  102778:	6a 00                	push   $0x0
  pushl $213
  10277a:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  10277f:	e9 66 f7 ff ff       	jmp    101eea <__alltraps>

00102784 <vector214>:
.globl vector214
vector214:
  pushl $0
  102784:	6a 00                	push   $0x0
  pushl $214
  102786:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  10278b:	e9 5a f7 ff ff       	jmp    101eea <__alltraps>

00102790 <vector215>:
.globl vector215
vector215:
  pushl $0
  102790:	6a 00                	push   $0x0
  pushl $215
  102792:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  102797:	e9 4e f7 ff ff       	jmp    101eea <__alltraps>

0010279c <vector216>:
.globl vector216
vector216:
  pushl $0
  10279c:	6a 00                	push   $0x0
  pushl $216
  10279e:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  1027a3:	e9 42 f7 ff ff       	jmp    101eea <__alltraps>

001027a8 <vector217>:
.globl vector217
vector217:
  pushl $0
  1027a8:	6a 00                	push   $0x0
  pushl $217
  1027aa:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  1027af:	e9 36 f7 ff ff       	jmp    101eea <__alltraps>

001027b4 <vector218>:
.globl vector218
vector218:
  pushl $0
  1027b4:	6a 00                	push   $0x0
  pushl $218
  1027b6:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  1027bb:	e9 2a f7 ff ff       	jmp    101eea <__alltraps>

001027c0 <vector219>:
.globl vector219
vector219:
  pushl $0
  1027c0:	6a 00                	push   $0x0
  pushl $219
  1027c2:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  1027c7:	e9 1e f7 ff ff       	jmp    101eea <__alltraps>

001027cc <vector220>:
.globl vector220
vector220:
  pushl $0
  1027cc:	6a 00                	push   $0x0
  pushl $220
  1027ce:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  1027d3:	e9 12 f7 ff ff       	jmp    101eea <__alltraps>

001027d8 <vector221>:
.globl vector221
vector221:
  pushl $0
  1027d8:	6a 00                	push   $0x0
  pushl $221
  1027da:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  1027df:	e9 06 f7 ff ff       	jmp    101eea <__alltraps>

001027e4 <vector222>:
.globl vector222
vector222:
  pushl $0
  1027e4:	6a 00                	push   $0x0
  pushl $222
  1027e6:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  1027eb:	e9 fa f6 ff ff       	jmp    101eea <__alltraps>

001027f0 <vector223>:
.globl vector223
vector223:
  pushl $0
  1027f0:	6a 00                	push   $0x0
  pushl $223
  1027f2:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  1027f7:	e9 ee f6 ff ff       	jmp    101eea <__alltraps>

001027fc <vector224>:
.globl vector224
vector224:
  pushl $0
  1027fc:	6a 00                	push   $0x0
  pushl $224
  1027fe:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  102803:	e9 e2 f6 ff ff       	jmp    101eea <__alltraps>

00102808 <vector225>:
.globl vector225
vector225:
  pushl $0
  102808:	6a 00                	push   $0x0
  pushl $225
  10280a:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  10280f:	e9 d6 f6 ff ff       	jmp    101eea <__alltraps>

00102814 <vector226>:
.globl vector226
vector226:
  pushl $0
  102814:	6a 00                	push   $0x0
  pushl $226
  102816:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  10281b:	e9 ca f6 ff ff       	jmp    101eea <__alltraps>

00102820 <vector227>:
.globl vector227
vector227:
  pushl $0
  102820:	6a 00                	push   $0x0
  pushl $227
  102822:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  102827:	e9 be f6 ff ff       	jmp    101eea <__alltraps>

0010282c <vector228>:
.globl vector228
vector228:
  pushl $0
  10282c:	6a 00                	push   $0x0
  pushl $228
  10282e:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  102833:	e9 b2 f6 ff ff       	jmp    101eea <__alltraps>

00102838 <vector229>:
.globl vector229
vector229:
  pushl $0
  102838:	6a 00                	push   $0x0
  pushl $229
  10283a:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  10283f:	e9 a6 f6 ff ff       	jmp    101eea <__alltraps>

00102844 <vector230>:
.globl vector230
vector230:
  pushl $0
  102844:	6a 00                	push   $0x0
  pushl $230
  102846:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  10284b:	e9 9a f6 ff ff       	jmp    101eea <__alltraps>

00102850 <vector231>:
.globl vector231
vector231:
  pushl $0
  102850:	6a 00                	push   $0x0
  pushl $231
  102852:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  102857:	e9 8e f6 ff ff       	jmp    101eea <__alltraps>

0010285c <vector232>:
.globl vector232
vector232:
  pushl $0
  10285c:	6a 00                	push   $0x0
  pushl $232
  10285e:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  102863:	e9 82 f6 ff ff       	jmp    101eea <__alltraps>

00102868 <vector233>:
.globl vector233
vector233:
  pushl $0
  102868:	6a 00                	push   $0x0
  pushl $233
  10286a:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  10286f:	e9 76 f6 ff ff       	jmp    101eea <__alltraps>

00102874 <vector234>:
.globl vector234
vector234:
  pushl $0
  102874:	6a 00                	push   $0x0
  pushl $234
  102876:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  10287b:	e9 6a f6 ff ff       	jmp    101eea <__alltraps>

00102880 <vector235>:
.globl vector235
vector235:
  pushl $0
  102880:	6a 00                	push   $0x0
  pushl $235
  102882:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  102887:	e9 5e f6 ff ff       	jmp    101eea <__alltraps>

0010288c <vector236>:
.globl vector236
vector236:
  pushl $0
  10288c:	6a 00                	push   $0x0
  pushl $236
  10288e:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  102893:	e9 52 f6 ff ff       	jmp    101eea <__alltraps>

00102898 <vector237>:
.globl vector237
vector237:
  pushl $0
  102898:	6a 00                	push   $0x0
  pushl $237
  10289a:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  10289f:	e9 46 f6 ff ff       	jmp    101eea <__alltraps>

001028a4 <vector238>:
.globl vector238
vector238:
  pushl $0
  1028a4:	6a 00                	push   $0x0
  pushl $238
  1028a6:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  1028ab:	e9 3a f6 ff ff       	jmp    101eea <__alltraps>

001028b0 <vector239>:
.globl vector239
vector239:
  pushl $0
  1028b0:	6a 00                	push   $0x0
  pushl $239
  1028b2:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  1028b7:	e9 2e f6 ff ff       	jmp    101eea <__alltraps>

001028bc <vector240>:
.globl vector240
vector240:
  pushl $0
  1028bc:	6a 00                	push   $0x0
  pushl $240
  1028be:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  1028c3:	e9 22 f6 ff ff       	jmp    101eea <__alltraps>

001028c8 <vector241>:
.globl vector241
vector241:
  pushl $0
  1028c8:	6a 00                	push   $0x0
  pushl $241
  1028ca:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  1028cf:	e9 16 f6 ff ff       	jmp    101eea <__alltraps>

001028d4 <vector242>:
.globl vector242
vector242:
  pushl $0
  1028d4:	6a 00                	push   $0x0
  pushl $242
  1028d6:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  1028db:	e9 0a f6 ff ff       	jmp    101eea <__alltraps>

001028e0 <vector243>:
.globl vector243
vector243:
  pushl $0
  1028e0:	6a 00                	push   $0x0
  pushl $243
  1028e2:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  1028e7:	e9 fe f5 ff ff       	jmp    101eea <__alltraps>

001028ec <vector244>:
.globl vector244
vector244:
  pushl $0
  1028ec:	6a 00                	push   $0x0
  pushl $244
  1028ee:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  1028f3:	e9 f2 f5 ff ff       	jmp    101eea <__alltraps>

001028f8 <vector245>:
.globl vector245
vector245:
  pushl $0
  1028f8:	6a 00                	push   $0x0
  pushl $245
  1028fa:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  1028ff:	e9 e6 f5 ff ff       	jmp    101eea <__alltraps>

00102904 <vector246>:
.globl vector246
vector246:
  pushl $0
  102904:	6a 00                	push   $0x0
  pushl $246
  102906:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  10290b:	e9 da f5 ff ff       	jmp    101eea <__alltraps>

00102910 <vector247>:
.globl vector247
vector247:
  pushl $0
  102910:	6a 00                	push   $0x0
  pushl $247
  102912:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  102917:	e9 ce f5 ff ff       	jmp    101eea <__alltraps>

0010291c <vector248>:
.globl vector248
vector248:
  pushl $0
  10291c:	6a 00                	push   $0x0
  pushl $248
  10291e:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  102923:	e9 c2 f5 ff ff       	jmp    101eea <__alltraps>

00102928 <vector249>:
.globl vector249
vector249:
  pushl $0
  102928:	6a 00                	push   $0x0
  pushl $249
  10292a:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  10292f:	e9 b6 f5 ff ff       	jmp    101eea <__alltraps>

00102934 <vector250>:
.globl vector250
vector250:
  pushl $0
  102934:	6a 00                	push   $0x0
  pushl $250
  102936:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  10293b:	e9 aa f5 ff ff       	jmp    101eea <__alltraps>

00102940 <vector251>:
.globl vector251
vector251:
  pushl $0
  102940:	6a 00                	push   $0x0
  pushl $251
  102942:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  102947:	e9 9e f5 ff ff       	jmp    101eea <__alltraps>

0010294c <vector252>:
.globl vector252
vector252:
  pushl $0
  10294c:	6a 00                	push   $0x0
  pushl $252
  10294e:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  102953:	e9 92 f5 ff ff       	jmp    101eea <__alltraps>

00102958 <vector253>:
.globl vector253
vector253:
  pushl $0
  102958:	6a 00                	push   $0x0
  pushl $253
  10295a:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  10295f:	e9 86 f5 ff ff       	jmp    101eea <__alltraps>

00102964 <vector254>:
.globl vector254
vector254:
  pushl $0
  102964:	6a 00                	push   $0x0
  pushl $254
  102966:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  10296b:	e9 7a f5 ff ff       	jmp    101eea <__alltraps>

00102970 <vector255>:
.globl vector255
vector255:
  pushl $0
  102970:	6a 00                	push   $0x0
  pushl $255
  102972:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  102977:	e9 6e f5 ff ff       	jmp    101eea <__alltraps>

0010297c <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  10297c:	55                   	push   %ebp
  10297d:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  10297f:	8b 45 08             	mov    0x8(%ebp),%eax
  102982:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102985:	b8 23 00 00 00       	mov    $0x23,%eax
  10298a:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  10298c:	b8 23 00 00 00       	mov    $0x23,%eax
  102991:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102993:	b8 10 00 00 00       	mov    $0x10,%eax
  102998:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  10299a:	b8 10 00 00 00       	mov    $0x10,%eax
  10299f:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  1029a1:	b8 10 00 00 00       	mov    $0x10,%eax
  1029a6:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  1029a8:	ea af 29 10 00 08 00 	ljmp   $0x8,$0x1029af
}
  1029af:	5d                   	pop    %ebp
  1029b0:	c3                   	ret    

001029b1 <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  1029b1:	55                   	push   %ebp
  1029b2:	89 e5                	mov    %esp,%ebp
  1029b4:	83 ec 14             	sub    $0x14,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  1029b7:	b8 80 f9 10 00       	mov    $0x10f980,%eax
  1029bc:	05 00 04 00 00       	add    $0x400,%eax
  1029c1:	a3 a4 f8 10 00       	mov    %eax,0x10f8a4
    ts.ts_ss0 = KERNEL_DS;
  1029c6:	66 c7 05 a8 f8 10 00 	movw   $0x10,0x10f8a8
  1029cd:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  1029cf:	66 c7 05 08 ea 10 00 	movw   $0x68,0x10ea08
  1029d6:	68 00 
  1029d8:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  1029dd:	66 a3 0a ea 10 00    	mov    %ax,0x10ea0a
  1029e3:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  1029e8:	c1 e8 10             	shr    $0x10,%eax
  1029eb:	a2 0c ea 10 00       	mov    %al,0x10ea0c
  1029f0:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1029f7:	83 e0 f0             	and    $0xfffffff0,%eax
  1029fa:	83 c8 09             	or     $0x9,%eax
  1029fd:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  102a02:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102a09:	83 c8 10             	or     $0x10,%eax
  102a0c:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  102a11:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102a18:	83 e0 9f             	and    $0xffffff9f,%eax
  102a1b:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  102a20:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102a27:	83 c8 80             	or     $0xffffff80,%eax
  102a2a:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  102a2f:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102a36:	83 e0 f0             	and    $0xfffffff0,%eax
  102a39:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102a3e:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102a45:	83 e0 ef             	and    $0xffffffef,%eax
  102a48:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102a4d:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102a54:	83 e0 df             	and    $0xffffffdf,%eax
  102a57:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102a5c:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102a63:	83 c8 40             	or     $0x40,%eax
  102a66:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102a6b:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102a72:	83 e0 7f             	and    $0x7f,%eax
  102a75:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102a7a:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  102a7f:	c1 e8 18             	shr    $0x18,%eax
  102a82:	a2 0f ea 10 00       	mov    %al,0x10ea0f
    gdt[SEG_TSS].sd_s = 0;
  102a87:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102a8e:	83 e0 ef             	and    $0xffffffef,%eax
  102a91:	a2 0d ea 10 00       	mov    %al,0x10ea0d

    // reload all segment registers
    lgdt(&gdt_pd);
  102a96:	c7 04 24 10 ea 10 00 	movl   $0x10ea10,(%esp)
  102a9d:	e8 da fe ff ff       	call   10297c <lgdt>
  102aa2:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
    asm volatile ("cli");
}

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102aa8:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102aac:	0f 00 d8             	ltr    %ax

    // load the TSS
    ltr(GD_TSS);
}
  102aaf:	c9                   	leave  
  102ab0:	c3                   	ret    

00102ab1 <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102ab1:	55                   	push   %ebp
  102ab2:	89 e5                	mov    %esp,%ebp
    gdt_init();
  102ab4:	e8 f8 fe ff ff       	call   1029b1 <gdt_init>
}
  102ab9:	5d                   	pop    %ebp
  102aba:	c3                   	ret    

00102abb <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  102abb:	55                   	push   %ebp
  102abc:	89 e5                	mov    %esp,%ebp
  102abe:	83 ec 58             	sub    $0x58,%esp
  102ac1:	8b 45 10             	mov    0x10(%ebp),%eax
  102ac4:	89 45 d0             	mov    %eax,-0x30(%ebp)
  102ac7:	8b 45 14             	mov    0x14(%ebp),%eax
  102aca:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  102acd:	8b 45 d0             	mov    -0x30(%ebp),%eax
  102ad0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  102ad3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102ad6:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  102ad9:	8b 45 18             	mov    0x18(%ebp),%eax
  102adc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102adf:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102ae2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102ae5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102ae8:	89 55 f0             	mov    %edx,-0x10(%ebp)
  102aeb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102aee:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102af1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  102af5:	74 1c                	je     102b13 <printnum+0x58>
  102af7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102afa:	ba 00 00 00 00       	mov    $0x0,%edx
  102aff:	f7 75 e4             	divl   -0x1c(%ebp)
  102b02:	89 55 f4             	mov    %edx,-0xc(%ebp)
  102b05:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102b08:	ba 00 00 00 00       	mov    $0x0,%edx
  102b0d:	f7 75 e4             	divl   -0x1c(%ebp)
  102b10:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102b13:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102b16:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102b19:	f7 75 e4             	divl   -0x1c(%ebp)
  102b1c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102b1f:	89 55 dc             	mov    %edx,-0x24(%ebp)
  102b22:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102b25:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102b28:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102b2b:	89 55 ec             	mov    %edx,-0x14(%ebp)
  102b2e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102b31:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  102b34:	8b 45 18             	mov    0x18(%ebp),%eax
  102b37:	ba 00 00 00 00       	mov    $0x0,%edx
  102b3c:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  102b3f:	77 56                	ja     102b97 <printnum+0xdc>
  102b41:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  102b44:	72 05                	jb     102b4b <printnum+0x90>
  102b46:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  102b49:	77 4c                	ja     102b97 <printnum+0xdc>
        printnum(putch, putdat, result, base, width - 1, padc);
  102b4b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  102b4e:	8d 50 ff             	lea    -0x1(%eax),%edx
  102b51:	8b 45 20             	mov    0x20(%ebp),%eax
  102b54:	89 44 24 18          	mov    %eax,0x18(%esp)
  102b58:	89 54 24 14          	mov    %edx,0x14(%esp)
  102b5c:	8b 45 18             	mov    0x18(%ebp),%eax
  102b5f:	89 44 24 10          	mov    %eax,0x10(%esp)
  102b63:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102b66:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102b69:	89 44 24 08          	mov    %eax,0x8(%esp)
  102b6d:	89 54 24 0c          	mov    %edx,0xc(%esp)
  102b71:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b74:	89 44 24 04          	mov    %eax,0x4(%esp)
  102b78:	8b 45 08             	mov    0x8(%ebp),%eax
  102b7b:	89 04 24             	mov    %eax,(%esp)
  102b7e:	e8 38 ff ff ff       	call   102abb <printnum>
  102b83:	eb 1c                	jmp    102ba1 <printnum+0xe6>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  102b85:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b88:	89 44 24 04          	mov    %eax,0x4(%esp)
  102b8c:	8b 45 20             	mov    0x20(%ebp),%eax
  102b8f:	89 04 24             	mov    %eax,(%esp)
  102b92:	8b 45 08             	mov    0x8(%ebp),%eax
  102b95:	ff d0                	call   *%eax
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  102b97:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  102b9b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  102b9f:	7f e4                	jg     102b85 <printnum+0xca>
            putch(padc, putdat);
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  102ba1:	8b 45 d8             	mov    -0x28(%ebp),%eax
  102ba4:	05 90 3d 10 00       	add    $0x103d90,%eax
  102ba9:	0f b6 00             	movzbl (%eax),%eax
  102bac:	0f be c0             	movsbl %al,%eax
  102baf:	8b 55 0c             	mov    0xc(%ebp),%edx
  102bb2:	89 54 24 04          	mov    %edx,0x4(%esp)
  102bb6:	89 04 24             	mov    %eax,(%esp)
  102bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  102bbc:	ff d0                	call   *%eax
}
  102bbe:	c9                   	leave  
  102bbf:	c3                   	ret    

00102bc0 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  102bc0:	55                   	push   %ebp
  102bc1:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102bc3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102bc7:	7e 14                	jle    102bdd <getuint+0x1d>
        return va_arg(*ap, unsigned long long);
  102bc9:	8b 45 08             	mov    0x8(%ebp),%eax
  102bcc:	8b 00                	mov    (%eax),%eax
  102bce:	8d 48 08             	lea    0x8(%eax),%ecx
  102bd1:	8b 55 08             	mov    0x8(%ebp),%edx
  102bd4:	89 0a                	mov    %ecx,(%edx)
  102bd6:	8b 50 04             	mov    0x4(%eax),%edx
  102bd9:	8b 00                	mov    (%eax),%eax
  102bdb:	eb 30                	jmp    102c0d <getuint+0x4d>
    }
    else if (lflag) {
  102bdd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102be1:	74 16                	je     102bf9 <getuint+0x39>
        return va_arg(*ap, unsigned long);
  102be3:	8b 45 08             	mov    0x8(%ebp),%eax
  102be6:	8b 00                	mov    (%eax),%eax
  102be8:	8d 48 04             	lea    0x4(%eax),%ecx
  102beb:	8b 55 08             	mov    0x8(%ebp),%edx
  102bee:	89 0a                	mov    %ecx,(%edx)
  102bf0:	8b 00                	mov    (%eax),%eax
  102bf2:	ba 00 00 00 00       	mov    $0x0,%edx
  102bf7:	eb 14                	jmp    102c0d <getuint+0x4d>
    }
    else {
        return va_arg(*ap, unsigned int);
  102bf9:	8b 45 08             	mov    0x8(%ebp),%eax
  102bfc:	8b 00                	mov    (%eax),%eax
  102bfe:	8d 48 04             	lea    0x4(%eax),%ecx
  102c01:	8b 55 08             	mov    0x8(%ebp),%edx
  102c04:	89 0a                	mov    %ecx,(%edx)
  102c06:	8b 00                	mov    (%eax),%eax
  102c08:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  102c0d:	5d                   	pop    %ebp
  102c0e:	c3                   	ret    

00102c0f <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  102c0f:	55                   	push   %ebp
  102c10:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102c12:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102c16:	7e 14                	jle    102c2c <getint+0x1d>
        return va_arg(*ap, long long);
  102c18:	8b 45 08             	mov    0x8(%ebp),%eax
  102c1b:	8b 00                	mov    (%eax),%eax
  102c1d:	8d 48 08             	lea    0x8(%eax),%ecx
  102c20:	8b 55 08             	mov    0x8(%ebp),%edx
  102c23:	89 0a                	mov    %ecx,(%edx)
  102c25:	8b 50 04             	mov    0x4(%eax),%edx
  102c28:	8b 00                	mov    (%eax),%eax
  102c2a:	eb 28                	jmp    102c54 <getint+0x45>
    }
    else if (lflag) {
  102c2c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102c30:	74 12                	je     102c44 <getint+0x35>
        return va_arg(*ap, long);
  102c32:	8b 45 08             	mov    0x8(%ebp),%eax
  102c35:	8b 00                	mov    (%eax),%eax
  102c37:	8d 48 04             	lea    0x4(%eax),%ecx
  102c3a:	8b 55 08             	mov    0x8(%ebp),%edx
  102c3d:	89 0a                	mov    %ecx,(%edx)
  102c3f:	8b 00                	mov    (%eax),%eax
  102c41:	99                   	cltd   
  102c42:	eb 10                	jmp    102c54 <getint+0x45>
    }
    else {
        return va_arg(*ap, int);
  102c44:	8b 45 08             	mov    0x8(%ebp),%eax
  102c47:	8b 00                	mov    (%eax),%eax
  102c49:	8d 48 04             	lea    0x4(%eax),%ecx
  102c4c:	8b 55 08             	mov    0x8(%ebp),%edx
  102c4f:	89 0a                	mov    %ecx,(%edx)
  102c51:	8b 00                	mov    (%eax),%eax
  102c53:	99                   	cltd   
    }
}
  102c54:	5d                   	pop    %ebp
  102c55:	c3                   	ret    

00102c56 <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  102c56:	55                   	push   %ebp
  102c57:	89 e5                	mov    %esp,%ebp
  102c59:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  102c5c:	8d 45 14             	lea    0x14(%ebp),%eax
  102c5f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  102c62:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102c65:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102c69:	8b 45 10             	mov    0x10(%ebp),%eax
  102c6c:	89 44 24 08          	mov    %eax,0x8(%esp)
  102c70:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c73:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c77:	8b 45 08             	mov    0x8(%ebp),%eax
  102c7a:	89 04 24             	mov    %eax,(%esp)
  102c7d:	e8 02 00 00 00       	call   102c84 <vprintfmt>
    va_end(ap);
}
  102c82:	c9                   	leave  
  102c83:	c3                   	ret    

00102c84 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  102c84:	55                   	push   %ebp
  102c85:	89 e5                	mov    %esp,%ebp
  102c87:	56                   	push   %esi
  102c88:	53                   	push   %ebx
  102c89:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102c8c:	eb 18                	jmp    102ca6 <vprintfmt+0x22>
            if (ch == '\0') {
  102c8e:	85 db                	test   %ebx,%ebx
  102c90:	75 05                	jne    102c97 <vprintfmt+0x13>
                return;
  102c92:	e9 d1 03 00 00       	jmp    103068 <vprintfmt+0x3e4>
            }
            putch(ch, putdat);
  102c97:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c9a:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c9e:	89 1c 24             	mov    %ebx,(%esp)
  102ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  102ca4:	ff d0                	call   *%eax
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102ca6:	8b 45 10             	mov    0x10(%ebp),%eax
  102ca9:	8d 50 01             	lea    0x1(%eax),%edx
  102cac:	89 55 10             	mov    %edx,0x10(%ebp)
  102caf:	0f b6 00             	movzbl (%eax),%eax
  102cb2:	0f b6 d8             	movzbl %al,%ebx
  102cb5:	83 fb 25             	cmp    $0x25,%ebx
  102cb8:	75 d4                	jne    102c8e <vprintfmt+0xa>
            }
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
  102cba:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  102cbe:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  102cc5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102cc8:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  102ccb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  102cd2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102cd5:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  102cd8:	8b 45 10             	mov    0x10(%ebp),%eax
  102cdb:	8d 50 01             	lea    0x1(%eax),%edx
  102cde:	89 55 10             	mov    %edx,0x10(%ebp)
  102ce1:	0f b6 00             	movzbl (%eax),%eax
  102ce4:	0f b6 d8             	movzbl %al,%ebx
  102ce7:	8d 43 dd             	lea    -0x23(%ebx),%eax
  102cea:	83 f8 55             	cmp    $0x55,%eax
  102ced:	0f 87 44 03 00 00    	ja     103037 <vprintfmt+0x3b3>
  102cf3:	8b 04 85 b4 3d 10 00 	mov    0x103db4(,%eax,4),%eax
  102cfa:	ff e0                	jmp    *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  102cfc:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  102d00:	eb d6                	jmp    102cd8 <vprintfmt+0x54>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  102d02:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  102d06:	eb d0                	jmp    102cd8 <vprintfmt+0x54>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  102d08:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  102d0f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102d12:	89 d0                	mov    %edx,%eax
  102d14:	c1 e0 02             	shl    $0x2,%eax
  102d17:	01 d0                	add    %edx,%eax
  102d19:	01 c0                	add    %eax,%eax
  102d1b:	01 d8                	add    %ebx,%eax
  102d1d:	83 e8 30             	sub    $0x30,%eax
  102d20:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  102d23:	8b 45 10             	mov    0x10(%ebp),%eax
  102d26:	0f b6 00             	movzbl (%eax),%eax
  102d29:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  102d2c:	83 fb 2f             	cmp    $0x2f,%ebx
  102d2f:	7e 0b                	jle    102d3c <vprintfmt+0xb8>
  102d31:	83 fb 39             	cmp    $0x39,%ebx
  102d34:	7f 06                	jg     102d3c <vprintfmt+0xb8>
            padc = '0';
            goto reswitch;

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  102d36:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
                ch = *fmt;
                if (ch < '0' || ch > '9') {
                    break;
                }
            }
  102d3a:	eb d3                	jmp    102d0f <vprintfmt+0x8b>
            goto process_precision;
  102d3c:	eb 33                	jmp    102d71 <vprintfmt+0xed>

        case '*':
            precision = va_arg(ap, int);
  102d3e:	8b 45 14             	mov    0x14(%ebp),%eax
  102d41:	8d 50 04             	lea    0x4(%eax),%edx
  102d44:	89 55 14             	mov    %edx,0x14(%ebp)
  102d47:	8b 00                	mov    (%eax),%eax
  102d49:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  102d4c:	eb 23                	jmp    102d71 <vprintfmt+0xed>

        case '.':
            if (width < 0)
  102d4e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102d52:	79 0c                	jns    102d60 <vprintfmt+0xdc>
                width = 0;
  102d54:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  102d5b:	e9 78 ff ff ff       	jmp    102cd8 <vprintfmt+0x54>
  102d60:	e9 73 ff ff ff       	jmp    102cd8 <vprintfmt+0x54>

        case '#':
            altflag = 1;
  102d65:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  102d6c:	e9 67 ff ff ff       	jmp    102cd8 <vprintfmt+0x54>

        process_precision:
            if (width < 0)
  102d71:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102d75:	79 12                	jns    102d89 <vprintfmt+0x105>
                width = precision, precision = -1;
  102d77:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102d7a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102d7d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  102d84:	e9 4f ff ff ff       	jmp    102cd8 <vprintfmt+0x54>
  102d89:	e9 4a ff ff ff       	jmp    102cd8 <vprintfmt+0x54>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  102d8e:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
  102d92:	e9 41 ff ff ff       	jmp    102cd8 <vprintfmt+0x54>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  102d97:	8b 45 14             	mov    0x14(%ebp),%eax
  102d9a:	8d 50 04             	lea    0x4(%eax),%edx
  102d9d:	89 55 14             	mov    %edx,0x14(%ebp)
  102da0:	8b 00                	mov    (%eax),%eax
  102da2:	8b 55 0c             	mov    0xc(%ebp),%edx
  102da5:	89 54 24 04          	mov    %edx,0x4(%esp)
  102da9:	89 04 24             	mov    %eax,(%esp)
  102dac:	8b 45 08             	mov    0x8(%ebp),%eax
  102daf:	ff d0                	call   *%eax
            break;
  102db1:	e9 ac 02 00 00       	jmp    103062 <vprintfmt+0x3de>

        // error message
        case 'e':
            err = va_arg(ap, int);
  102db6:	8b 45 14             	mov    0x14(%ebp),%eax
  102db9:	8d 50 04             	lea    0x4(%eax),%edx
  102dbc:	89 55 14             	mov    %edx,0x14(%ebp)
  102dbf:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  102dc1:	85 db                	test   %ebx,%ebx
  102dc3:	79 02                	jns    102dc7 <vprintfmt+0x143>
                err = -err;
  102dc5:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  102dc7:	83 fb 06             	cmp    $0x6,%ebx
  102dca:	7f 0b                	jg     102dd7 <vprintfmt+0x153>
  102dcc:	8b 34 9d 74 3d 10 00 	mov    0x103d74(,%ebx,4),%esi
  102dd3:	85 f6                	test   %esi,%esi
  102dd5:	75 23                	jne    102dfa <vprintfmt+0x176>
                printfmt(putch, putdat, "error %d", err);
  102dd7:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  102ddb:	c7 44 24 08 a1 3d 10 	movl   $0x103da1,0x8(%esp)
  102de2:	00 
  102de3:	8b 45 0c             	mov    0xc(%ebp),%eax
  102de6:	89 44 24 04          	mov    %eax,0x4(%esp)
  102dea:	8b 45 08             	mov    0x8(%ebp),%eax
  102ded:	89 04 24             	mov    %eax,(%esp)
  102df0:	e8 61 fe ff ff       	call   102c56 <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  102df5:	e9 68 02 00 00       	jmp    103062 <vprintfmt+0x3de>
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
                printfmt(putch, putdat, "error %d", err);
            }
            else {
                printfmt(putch, putdat, "%s", p);
  102dfa:	89 74 24 0c          	mov    %esi,0xc(%esp)
  102dfe:	c7 44 24 08 aa 3d 10 	movl   $0x103daa,0x8(%esp)
  102e05:	00 
  102e06:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e09:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e0d:	8b 45 08             	mov    0x8(%ebp),%eax
  102e10:	89 04 24             	mov    %eax,(%esp)
  102e13:	e8 3e fe ff ff       	call   102c56 <printfmt>
            }
            break;
  102e18:	e9 45 02 00 00       	jmp    103062 <vprintfmt+0x3de>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  102e1d:	8b 45 14             	mov    0x14(%ebp),%eax
  102e20:	8d 50 04             	lea    0x4(%eax),%edx
  102e23:	89 55 14             	mov    %edx,0x14(%ebp)
  102e26:	8b 30                	mov    (%eax),%esi
  102e28:	85 f6                	test   %esi,%esi
  102e2a:	75 05                	jne    102e31 <vprintfmt+0x1ad>
                p = "(null)";
  102e2c:	be ad 3d 10 00       	mov    $0x103dad,%esi
            }
            if (width > 0 && padc != '-') {
  102e31:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102e35:	7e 3e                	jle    102e75 <vprintfmt+0x1f1>
  102e37:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  102e3b:	74 38                	je     102e75 <vprintfmt+0x1f1>
                for (width -= strnlen(p, precision); width > 0; width --) {
  102e3d:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  102e40:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102e43:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e47:	89 34 24             	mov    %esi,(%esp)
  102e4a:	e8 15 03 00 00       	call   103164 <strnlen>
  102e4f:	29 c3                	sub    %eax,%ebx
  102e51:	89 d8                	mov    %ebx,%eax
  102e53:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102e56:	eb 17                	jmp    102e6f <vprintfmt+0x1eb>
                    putch(padc, putdat);
  102e58:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  102e5c:	8b 55 0c             	mov    0xc(%ebp),%edx
  102e5f:	89 54 24 04          	mov    %edx,0x4(%esp)
  102e63:	89 04 24             	mov    %eax,(%esp)
  102e66:	8b 45 08             	mov    0x8(%ebp),%eax
  102e69:	ff d0                	call   *%eax
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
                p = "(null)";
            }
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
  102e6b:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102e6f:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102e73:	7f e3                	jg     102e58 <vprintfmt+0x1d4>
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  102e75:	eb 38                	jmp    102eaf <vprintfmt+0x22b>
                if (altflag && (ch < ' ' || ch > '~')) {
  102e77:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  102e7b:	74 1f                	je     102e9c <vprintfmt+0x218>
  102e7d:	83 fb 1f             	cmp    $0x1f,%ebx
  102e80:	7e 05                	jle    102e87 <vprintfmt+0x203>
  102e82:	83 fb 7e             	cmp    $0x7e,%ebx
  102e85:	7e 15                	jle    102e9c <vprintfmt+0x218>
                    putch('?', putdat);
  102e87:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e8a:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e8e:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  102e95:	8b 45 08             	mov    0x8(%ebp),%eax
  102e98:	ff d0                	call   *%eax
  102e9a:	eb 0f                	jmp    102eab <vprintfmt+0x227>
                }
                else {
                    putch(ch, putdat);
  102e9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e9f:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ea3:	89 1c 24             	mov    %ebx,(%esp)
  102ea6:	8b 45 08             	mov    0x8(%ebp),%eax
  102ea9:	ff d0                	call   *%eax
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  102eab:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102eaf:	89 f0                	mov    %esi,%eax
  102eb1:	8d 70 01             	lea    0x1(%eax),%esi
  102eb4:	0f b6 00             	movzbl (%eax),%eax
  102eb7:	0f be d8             	movsbl %al,%ebx
  102eba:	85 db                	test   %ebx,%ebx
  102ebc:	74 10                	je     102ece <vprintfmt+0x24a>
  102ebe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102ec2:	78 b3                	js     102e77 <vprintfmt+0x1f3>
  102ec4:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  102ec8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102ecc:	79 a9                	jns    102e77 <vprintfmt+0x1f3>
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
  102ece:	eb 17                	jmp    102ee7 <vprintfmt+0x263>
                putch(' ', putdat);
  102ed0:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ed3:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ed7:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  102ede:	8b 45 08             	mov    0x8(%ebp),%eax
  102ee1:	ff d0                	call   *%eax
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
  102ee3:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102ee7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102eeb:	7f e3                	jg     102ed0 <vprintfmt+0x24c>
                putch(' ', putdat);
            }
            break;
  102eed:	e9 70 01 00 00       	jmp    103062 <vprintfmt+0x3de>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  102ef2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102ef5:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ef9:	8d 45 14             	lea    0x14(%ebp),%eax
  102efc:	89 04 24             	mov    %eax,(%esp)
  102eff:	e8 0b fd ff ff       	call   102c0f <getint>
  102f04:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102f07:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  102f0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f0d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102f10:	85 d2                	test   %edx,%edx
  102f12:	79 26                	jns    102f3a <vprintfmt+0x2b6>
                putch('-', putdat);
  102f14:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f17:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f1b:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  102f22:	8b 45 08             	mov    0x8(%ebp),%eax
  102f25:	ff d0                	call   *%eax
                num = -(long long)num;
  102f27:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f2a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102f2d:	f7 d8                	neg    %eax
  102f2f:	83 d2 00             	adc    $0x0,%edx
  102f32:	f7 da                	neg    %edx
  102f34:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102f37:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  102f3a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  102f41:	e9 a8 00 00 00       	jmp    102fee <vprintfmt+0x36a>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  102f46:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102f49:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f4d:	8d 45 14             	lea    0x14(%ebp),%eax
  102f50:	89 04 24             	mov    %eax,(%esp)
  102f53:	e8 68 fc ff ff       	call   102bc0 <getuint>
  102f58:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102f5b:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  102f5e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  102f65:	e9 84 00 00 00       	jmp    102fee <vprintfmt+0x36a>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  102f6a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102f6d:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f71:	8d 45 14             	lea    0x14(%ebp),%eax
  102f74:	89 04 24             	mov    %eax,(%esp)
  102f77:	e8 44 fc ff ff       	call   102bc0 <getuint>
  102f7c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102f7f:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  102f82:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  102f89:	eb 63                	jmp    102fee <vprintfmt+0x36a>

        // pointer
        case 'p':
            putch('0', putdat);
  102f8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f8e:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f92:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  102f99:	8b 45 08             	mov    0x8(%ebp),%eax
  102f9c:	ff d0                	call   *%eax
            putch('x', putdat);
  102f9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fa1:	89 44 24 04          	mov    %eax,0x4(%esp)
  102fa5:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  102fac:	8b 45 08             	mov    0x8(%ebp),%eax
  102faf:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  102fb1:	8b 45 14             	mov    0x14(%ebp),%eax
  102fb4:	8d 50 04             	lea    0x4(%eax),%edx
  102fb7:	89 55 14             	mov    %edx,0x14(%ebp)
  102fba:	8b 00                	mov    (%eax),%eax
  102fbc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102fbf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  102fc6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  102fcd:	eb 1f                	jmp    102fee <vprintfmt+0x36a>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  102fcf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102fd2:	89 44 24 04          	mov    %eax,0x4(%esp)
  102fd6:	8d 45 14             	lea    0x14(%ebp),%eax
  102fd9:	89 04 24             	mov    %eax,(%esp)
  102fdc:	e8 df fb ff ff       	call   102bc0 <getuint>
  102fe1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102fe4:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  102fe7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  102fee:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  102ff2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102ff5:	89 54 24 18          	mov    %edx,0x18(%esp)
  102ff9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  102ffc:	89 54 24 14          	mov    %edx,0x14(%esp)
  103000:	89 44 24 10          	mov    %eax,0x10(%esp)
  103004:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103007:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10300a:	89 44 24 08          	mov    %eax,0x8(%esp)
  10300e:	89 54 24 0c          	mov    %edx,0xc(%esp)
  103012:	8b 45 0c             	mov    0xc(%ebp),%eax
  103015:	89 44 24 04          	mov    %eax,0x4(%esp)
  103019:	8b 45 08             	mov    0x8(%ebp),%eax
  10301c:	89 04 24             	mov    %eax,(%esp)
  10301f:	e8 97 fa ff ff       	call   102abb <printnum>
            break;
  103024:	eb 3c                	jmp    103062 <vprintfmt+0x3de>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  103026:	8b 45 0c             	mov    0xc(%ebp),%eax
  103029:	89 44 24 04          	mov    %eax,0x4(%esp)
  10302d:	89 1c 24             	mov    %ebx,(%esp)
  103030:	8b 45 08             	mov    0x8(%ebp),%eax
  103033:	ff d0                	call   *%eax
            break;
  103035:	eb 2b                	jmp    103062 <vprintfmt+0x3de>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  103037:	8b 45 0c             	mov    0xc(%ebp),%eax
  10303a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10303e:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  103045:	8b 45 08             	mov    0x8(%ebp),%eax
  103048:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  10304a:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  10304e:	eb 04                	jmp    103054 <vprintfmt+0x3d0>
  103050:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  103054:	8b 45 10             	mov    0x10(%ebp),%eax
  103057:	83 e8 01             	sub    $0x1,%eax
  10305a:	0f b6 00             	movzbl (%eax),%eax
  10305d:	3c 25                	cmp    $0x25,%al
  10305f:	75 ef                	jne    103050 <vprintfmt+0x3cc>
                /* do nothing */;
            break;
  103061:	90                   	nop
        }
    }
  103062:	90                   	nop
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  103063:	e9 3e fc ff ff       	jmp    102ca6 <vprintfmt+0x22>
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  103068:	83 c4 40             	add    $0x40,%esp
  10306b:	5b                   	pop    %ebx
  10306c:	5e                   	pop    %esi
  10306d:	5d                   	pop    %ebp
  10306e:	c3                   	ret    

0010306f <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  10306f:	55                   	push   %ebp
  103070:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  103072:	8b 45 0c             	mov    0xc(%ebp),%eax
  103075:	8b 40 08             	mov    0x8(%eax),%eax
  103078:	8d 50 01             	lea    0x1(%eax),%edx
  10307b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10307e:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  103081:	8b 45 0c             	mov    0xc(%ebp),%eax
  103084:	8b 10                	mov    (%eax),%edx
  103086:	8b 45 0c             	mov    0xc(%ebp),%eax
  103089:	8b 40 04             	mov    0x4(%eax),%eax
  10308c:	39 c2                	cmp    %eax,%edx
  10308e:	73 12                	jae    1030a2 <sprintputch+0x33>
        *b->buf ++ = ch;
  103090:	8b 45 0c             	mov    0xc(%ebp),%eax
  103093:	8b 00                	mov    (%eax),%eax
  103095:	8d 48 01             	lea    0x1(%eax),%ecx
  103098:	8b 55 0c             	mov    0xc(%ebp),%edx
  10309b:	89 0a                	mov    %ecx,(%edx)
  10309d:	8b 55 08             	mov    0x8(%ebp),%edx
  1030a0:	88 10                	mov    %dl,(%eax)
    }
}
  1030a2:	5d                   	pop    %ebp
  1030a3:	c3                   	ret    

001030a4 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  1030a4:	55                   	push   %ebp
  1030a5:	89 e5                	mov    %esp,%ebp
  1030a7:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  1030aa:	8d 45 14             	lea    0x14(%ebp),%eax
  1030ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  1030b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1030b3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1030b7:	8b 45 10             	mov    0x10(%ebp),%eax
  1030ba:	89 44 24 08          	mov    %eax,0x8(%esp)
  1030be:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030c1:	89 44 24 04          	mov    %eax,0x4(%esp)
  1030c5:	8b 45 08             	mov    0x8(%ebp),%eax
  1030c8:	89 04 24             	mov    %eax,(%esp)
  1030cb:	e8 08 00 00 00       	call   1030d8 <vsnprintf>
  1030d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  1030d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1030d6:	c9                   	leave  
  1030d7:	c3                   	ret    

001030d8 <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  1030d8:	55                   	push   %ebp
  1030d9:	89 e5                	mov    %esp,%ebp
  1030db:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  1030de:	8b 45 08             	mov    0x8(%ebp),%eax
  1030e1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1030e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030e7:	8d 50 ff             	lea    -0x1(%eax),%edx
  1030ea:	8b 45 08             	mov    0x8(%ebp),%eax
  1030ed:	01 d0                	add    %edx,%eax
  1030ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1030f2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  1030f9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1030fd:	74 0a                	je     103109 <vsnprintf+0x31>
  1030ff:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103102:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103105:	39 c2                	cmp    %eax,%edx
  103107:	76 07                	jbe    103110 <vsnprintf+0x38>
        return -E_INVAL;
  103109:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  10310e:	eb 2a                	jmp    10313a <vsnprintf+0x62>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  103110:	8b 45 14             	mov    0x14(%ebp),%eax
  103113:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103117:	8b 45 10             	mov    0x10(%ebp),%eax
  10311a:	89 44 24 08          	mov    %eax,0x8(%esp)
  10311e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  103121:	89 44 24 04          	mov    %eax,0x4(%esp)
  103125:	c7 04 24 6f 30 10 00 	movl   $0x10306f,(%esp)
  10312c:	e8 53 fb ff ff       	call   102c84 <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  103131:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103134:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  103137:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10313a:	c9                   	leave  
  10313b:	c3                   	ret    

0010313c <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  10313c:	55                   	push   %ebp
  10313d:	89 e5                	mov    %esp,%ebp
  10313f:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  103142:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  103149:	eb 04                	jmp    10314f <strlen+0x13>
        cnt ++;
  10314b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
  10314f:	8b 45 08             	mov    0x8(%ebp),%eax
  103152:	8d 50 01             	lea    0x1(%eax),%edx
  103155:	89 55 08             	mov    %edx,0x8(%ebp)
  103158:	0f b6 00             	movzbl (%eax),%eax
  10315b:	84 c0                	test   %al,%al
  10315d:	75 ec                	jne    10314b <strlen+0xf>
        cnt ++;
    }
    return cnt;
  10315f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  103162:	c9                   	leave  
  103163:	c3                   	ret    

00103164 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  103164:	55                   	push   %ebp
  103165:	89 e5                	mov    %esp,%ebp
  103167:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  10316a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  103171:	eb 04                	jmp    103177 <strnlen+0x13>
        cnt ++;
  103173:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
    while (cnt < len && *s ++ != '\0') {
  103177:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10317a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  10317d:	73 10                	jae    10318f <strnlen+0x2b>
  10317f:	8b 45 08             	mov    0x8(%ebp),%eax
  103182:	8d 50 01             	lea    0x1(%eax),%edx
  103185:	89 55 08             	mov    %edx,0x8(%ebp)
  103188:	0f b6 00             	movzbl (%eax),%eax
  10318b:	84 c0                	test   %al,%al
  10318d:	75 e4                	jne    103173 <strnlen+0xf>
        cnt ++;
    }
    return cnt;
  10318f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  103192:	c9                   	leave  
  103193:	c3                   	ret    

00103194 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  103194:	55                   	push   %ebp
  103195:	89 e5                	mov    %esp,%ebp
  103197:	57                   	push   %edi
  103198:	56                   	push   %esi
  103199:	83 ec 20             	sub    $0x20,%esp
  10319c:	8b 45 08             	mov    0x8(%ebp),%eax
  10319f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1031a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  1031a8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1031ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1031ae:	89 d1                	mov    %edx,%ecx
  1031b0:	89 c2                	mov    %eax,%edx
  1031b2:	89 ce                	mov    %ecx,%esi
  1031b4:	89 d7                	mov    %edx,%edi
  1031b6:	ac                   	lods   %ds:(%esi),%al
  1031b7:	aa                   	stos   %al,%es:(%edi)
  1031b8:	84 c0                	test   %al,%al
  1031ba:	75 fa                	jne    1031b6 <strcpy+0x22>
  1031bc:	89 fa                	mov    %edi,%edx
  1031be:	89 f1                	mov    %esi,%ecx
  1031c0:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  1031c3:	89 55 e8             	mov    %edx,-0x18(%ebp)
  1031c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  1031c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  1031cc:	83 c4 20             	add    $0x20,%esp
  1031cf:	5e                   	pop    %esi
  1031d0:	5f                   	pop    %edi
  1031d1:	5d                   	pop    %ebp
  1031d2:	c3                   	ret    

001031d3 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  1031d3:	55                   	push   %ebp
  1031d4:	89 e5                	mov    %esp,%ebp
  1031d6:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  1031d9:	8b 45 08             	mov    0x8(%ebp),%eax
  1031dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  1031df:	eb 21                	jmp    103202 <strncpy+0x2f>
        if ((*p = *src) != '\0') {
  1031e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031e4:	0f b6 10             	movzbl (%eax),%edx
  1031e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1031ea:	88 10                	mov    %dl,(%eax)
  1031ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1031ef:	0f b6 00             	movzbl (%eax),%eax
  1031f2:	84 c0                	test   %al,%al
  1031f4:	74 04                	je     1031fa <strncpy+0x27>
            src ++;
  1031f6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  1031fa:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1031fe:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
    char *p = dst;
    while (len > 0) {
  103202:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103206:	75 d9                	jne    1031e1 <strncpy+0xe>
        if ((*p = *src) != '\0') {
            src ++;
        }
        p ++, len --;
    }
    return dst;
  103208:	8b 45 08             	mov    0x8(%ebp),%eax
}
  10320b:	c9                   	leave  
  10320c:	c3                   	ret    

0010320d <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  10320d:	55                   	push   %ebp
  10320e:	89 e5                	mov    %esp,%ebp
  103210:	57                   	push   %edi
  103211:	56                   	push   %esi
  103212:	83 ec 20             	sub    $0x20,%esp
  103215:	8b 45 08             	mov    0x8(%ebp),%eax
  103218:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10321b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10321e:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCMP
#define __HAVE_ARCH_STRCMP
static inline int
__strcmp(const char *s1, const char *s2) {
    int d0, d1, ret;
    asm volatile (
  103221:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103224:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103227:	89 d1                	mov    %edx,%ecx
  103229:	89 c2                	mov    %eax,%edx
  10322b:	89 ce                	mov    %ecx,%esi
  10322d:	89 d7                	mov    %edx,%edi
  10322f:	ac                   	lods   %ds:(%esi),%al
  103230:	ae                   	scas   %es:(%edi),%al
  103231:	75 08                	jne    10323b <strcmp+0x2e>
  103233:	84 c0                	test   %al,%al
  103235:	75 f8                	jne    10322f <strcmp+0x22>
  103237:	31 c0                	xor    %eax,%eax
  103239:	eb 04                	jmp    10323f <strcmp+0x32>
  10323b:	19 c0                	sbb    %eax,%eax
  10323d:	0c 01                	or     $0x1,%al
  10323f:	89 fa                	mov    %edi,%edx
  103241:	89 f1                	mov    %esi,%ecx
  103243:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103246:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  103249:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            "orb $1, %%al;"
            "3:"
            : "=a" (ret), "=&S" (d0), "=&D" (d1)
            : "1" (s1), "2" (s2)
            : "memory");
    return ret;
  10324c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  10324f:	83 c4 20             	add    $0x20,%esp
  103252:	5e                   	pop    %esi
  103253:	5f                   	pop    %edi
  103254:	5d                   	pop    %ebp
  103255:	c3                   	ret    

00103256 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  103256:	55                   	push   %ebp
  103257:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  103259:	eb 0c                	jmp    103267 <strncmp+0x11>
        n --, s1 ++, s2 ++;
  10325b:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  10325f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103263:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  103267:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10326b:	74 1a                	je     103287 <strncmp+0x31>
  10326d:	8b 45 08             	mov    0x8(%ebp),%eax
  103270:	0f b6 00             	movzbl (%eax),%eax
  103273:	84 c0                	test   %al,%al
  103275:	74 10                	je     103287 <strncmp+0x31>
  103277:	8b 45 08             	mov    0x8(%ebp),%eax
  10327a:	0f b6 10             	movzbl (%eax),%edx
  10327d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103280:	0f b6 00             	movzbl (%eax),%eax
  103283:	38 c2                	cmp    %al,%dl
  103285:	74 d4                	je     10325b <strncmp+0x5>
        n --, s1 ++, s2 ++;
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  103287:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10328b:	74 18                	je     1032a5 <strncmp+0x4f>
  10328d:	8b 45 08             	mov    0x8(%ebp),%eax
  103290:	0f b6 00             	movzbl (%eax),%eax
  103293:	0f b6 d0             	movzbl %al,%edx
  103296:	8b 45 0c             	mov    0xc(%ebp),%eax
  103299:	0f b6 00             	movzbl (%eax),%eax
  10329c:	0f b6 c0             	movzbl %al,%eax
  10329f:	29 c2                	sub    %eax,%edx
  1032a1:	89 d0                	mov    %edx,%eax
  1032a3:	eb 05                	jmp    1032aa <strncmp+0x54>
  1032a5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1032aa:	5d                   	pop    %ebp
  1032ab:	c3                   	ret    

001032ac <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  1032ac:	55                   	push   %ebp
  1032ad:	89 e5                	mov    %esp,%ebp
  1032af:	83 ec 04             	sub    $0x4,%esp
  1032b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032b5:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  1032b8:	eb 14                	jmp    1032ce <strchr+0x22>
        if (*s == c) {
  1032ba:	8b 45 08             	mov    0x8(%ebp),%eax
  1032bd:	0f b6 00             	movzbl (%eax),%eax
  1032c0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  1032c3:	75 05                	jne    1032ca <strchr+0x1e>
            return (char *)s;
  1032c5:	8b 45 08             	mov    0x8(%ebp),%eax
  1032c8:	eb 13                	jmp    1032dd <strchr+0x31>
        }
        s ++;
  1032ca:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
  1032ce:	8b 45 08             	mov    0x8(%ebp),%eax
  1032d1:	0f b6 00             	movzbl (%eax),%eax
  1032d4:	84 c0                	test   %al,%al
  1032d6:	75 e2                	jne    1032ba <strchr+0xe>
        if (*s == c) {
            return (char *)s;
        }
        s ++;
    }
    return NULL;
  1032d8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1032dd:	c9                   	leave  
  1032de:	c3                   	ret    

001032df <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  1032df:	55                   	push   %ebp
  1032e0:	89 e5                	mov    %esp,%ebp
  1032e2:	83 ec 04             	sub    $0x4,%esp
  1032e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032e8:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  1032eb:	eb 11                	jmp    1032fe <strfind+0x1f>
        if (*s == c) {
  1032ed:	8b 45 08             	mov    0x8(%ebp),%eax
  1032f0:	0f b6 00             	movzbl (%eax),%eax
  1032f3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  1032f6:	75 02                	jne    1032fa <strfind+0x1b>
            break;
  1032f8:	eb 0e                	jmp    103308 <strfind+0x29>
        }
        s ++;
  1032fa:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
    while (*s != '\0') {
  1032fe:	8b 45 08             	mov    0x8(%ebp),%eax
  103301:	0f b6 00             	movzbl (%eax),%eax
  103304:	84 c0                	test   %al,%al
  103306:	75 e5                	jne    1032ed <strfind+0xe>
        if (*s == c) {
            break;
        }
        s ++;
    }
    return (char *)s;
  103308:	8b 45 08             	mov    0x8(%ebp),%eax
}
  10330b:	c9                   	leave  
  10330c:	c3                   	ret    

0010330d <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  10330d:	55                   	push   %ebp
  10330e:	89 e5                	mov    %esp,%ebp
  103310:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  103313:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  10331a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  103321:	eb 04                	jmp    103327 <strtol+0x1a>
        s ++;
  103323:	83 45 08 01          	addl   $0x1,0x8(%ebp)
strtol(const char *s, char **endptr, int base) {
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  103327:	8b 45 08             	mov    0x8(%ebp),%eax
  10332a:	0f b6 00             	movzbl (%eax),%eax
  10332d:	3c 20                	cmp    $0x20,%al
  10332f:	74 f2                	je     103323 <strtol+0x16>
  103331:	8b 45 08             	mov    0x8(%ebp),%eax
  103334:	0f b6 00             	movzbl (%eax),%eax
  103337:	3c 09                	cmp    $0x9,%al
  103339:	74 e8                	je     103323 <strtol+0x16>
        s ++;
    }

    // plus/minus sign
    if (*s == '+') {
  10333b:	8b 45 08             	mov    0x8(%ebp),%eax
  10333e:	0f b6 00             	movzbl (%eax),%eax
  103341:	3c 2b                	cmp    $0x2b,%al
  103343:	75 06                	jne    10334b <strtol+0x3e>
        s ++;
  103345:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103349:	eb 15                	jmp    103360 <strtol+0x53>
    }
    else if (*s == '-') {
  10334b:	8b 45 08             	mov    0x8(%ebp),%eax
  10334e:	0f b6 00             	movzbl (%eax),%eax
  103351:	3c 2d                	cmp    $0x2d,%al
  103353:	75 0b                	jne    103360 <strtol+0x53>
        s ++, neg = 1;
  103355:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103359:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  103360:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103364:	74 06                	je     10336c <strtol+0x5f>
  103366:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  10336a:	75 24                	jne    103390 <strtol+0x83>
  10336c:	8b 45 08             	mov    0x8(%ebp),%eax
  10336f:	0f b6 00             	movzbl (%eax),%eax
  103372:	3c 30                	cmp    $0x30,%al
  103374:	75 1a                	jne    103390 <strtol+0x83>
  103376:	8b 45 08             	mov    0x8(%ebp),%eax
  103379:	83 c0 01             	add    $0x1,%eax
  10337c:	0f b6 00             	movzbl (%eax),%eax
  10337f:	3c 78                	cmp    $0x78,%al
  103381:	75 0d                	jne    103390 <strtol+0x83>
        s += 2, base = 16;
  103383:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  103387:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  10338e:	eb 2a                	jmp    1033ba <strtol+0xad>
    }
    else if (base == 0 && s[0] == '0') {
  103390:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103394:	75 17                	jne    1033ad <strtol+0xa0>
  103396:	8b 45 08             	mov    0x8(%ebp),%eax
  103399:	0f b6 00             	movzbl (%eax),%eax
  10339c:	3c 30                	cmp    $0x30,%al
  10339e:	75 0d                	jne    1033ad <strtol+0xa0>
        s ++, base = 8;
  1033a0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1033a4:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  1033ab:	eb 0d                	jmp    1033ba <strtol+0xad>
    }
    else if (base == 0) {
  1033ad:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1033b1:	75 07                	jne    1033ba <strtol+0xad>
        base = 10;
  1033b3:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  1033ba:	8b 45 08             	mov    0x8(%ebp),%eax
  1033bd:	0f b6 00             	movzbl (%eax),%eax
  1033c0:	3c 2f                	cmp    $0x2f,%al
  1033c2:	7e 1b                	jle    1033df <strtol+0xd2>
  1033c4:	8b 45 08             	mov    0x8(%ebp),%eax
  1033c7:	0f b6 00             	movzbl (%eax),%eax
  1033ca:	3c 39                	cmp    $0x39,%al
  1033cc:	7f 11                	jg     1033df <strtol+0xd2>
            dig = *s - '0';
  1033ce:	8b 45 08             	mov    0x8(%ebp),%eax
  1033d1:	0f b6 00             	movzbl (%eax),%eax
  1033d4:	0f be c0             	movsbl %al,%eax
  1033d7:	83 e8 30             	sub    $0x30,%eax
  1033da:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1033dd:	eb 48                	jmp    103427 <strtol+0x11a>
        }
        else if (*s >= 'a' && *s <= 'z') {
  1033df:	8b 45 08             	mov    0x8(%ebp),%eax
  1033e2:	0f b6 00             	movzbl (%eax),%eax
  1033e5:	3c 60                	cmp    $0x60,%al
  1033e7:	7e 1b                	jle    103404 <strtol+0xf7>
  1033e9:	8b 45 08             	mov    0x8(%ebp),%eax
  1033ec:	0f b6 00             	movzbl (%eax),%eax
  1033ef:	3c 7a                	cmp    $0x7a,%al
  1033f1:	7f 11                	jg     103404 <strtol+0xf7>
            dig = *s - 'a' + 10;
  1033f3:	8b 45 08             	mov    0x8(%ebp),%eax
  1033f6:	0f b6 00             	movzbl (%eax),%eax
  1033f9:	0f be c0             	movsbl %al,%eax
  1033fc:	83 e8 57             	sub    $0x57,%eax
  1033ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103402:	eb 23                	jmp    103427 <strtol+0x11a>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  103404:	8b 45 08             	mov    0x8(%ebp),%eax
  103407:	0f b6 00             	movzbl (%eax),%eax
  10340a:	3c 40                	cmp    $0x40,%al
  10340c:	7e 3d                	jle    10344b <strtol+0x13e>
  10340e:	8b 45 08             	mov    0x8(%ebp),%eax
  103411:	0f b6 00             	movzbl (%eax),%eax
  103414:	3c 5a                	cmp    $0x5a,%al
  103416:	7f 33                	jg     10344b <strtol+0x13e>
            dig = *s - 'A' + 10;
  103418:	8b 45 08             	mov    0x8(%ebp),%eax
  10341b:	0f b6 00             	movzbl (%eax),%eax
  10341e:	0f be c0             	movsbl %al,%eax
  103421:	83 e8 37             	sub    $0x37,%eax
  103424:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  103427:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10342a:	3b 45 10             	cmp    0x10(%ebp),%eax
  10342d:	7c 02                	jl     103431 <strtol+0x124>
            break;
  10342f:	eb 1a                	jmp    10344b <strtol+0x13e>
        }
        s ++, val = (val * base) + dig;
  103431:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103435:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103438:	0f af 45 10          	imul   0x10(%ebp),%eax
  10343c:	89 c2                	mov    %eax,%edx
  10343e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103441:	01 d0                	add    %edx,%eax
  103443:	89 45 f8             	mov    %eax,-0x8(%ebp)
        // we don't properly detect overflow!
    }
  103446:	e9 6f ff ff ff       	jmp    1033ba <strtol+0xad>

    if (endptr) {
  10344b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  10344f:	74 08                	je     103459 <strtol+0x14c>
        *endptr = (char *) s;
  103451:	8b 45 0c             	mov    0xc(%ebp),%eax
  103454:	8b 55 08             	mov    0x8(%ebp),%edx
  103457:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  103459:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  10345d:	74 07                	je     103466 <strtol+0x159>
  10345f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103462:	f7 d8                	neg    %eax
  103464:	eb 03                	jmp    103469 <strtol+0x15c>
  103466:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  103469:	c9                   	leave  
  10346a:	c3                   	ret    

0010346b <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  10346b:	55                   	push   %ebp
  10346c:	89 e5                	mov    %esp,%ebp
  10346e:	57                   	push   %edi
  10346f:	83 ec 24             	sub    $0x24,%esp
  103472:	8b 45 0c             	mov    0xc(%ebp),%eax
  103475:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  103478:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  10347c:	8b 55 08             	mov    0x8(%ebp),%edx
  10347f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  103482:	88 45 f7             	mov    %al,-0x9(%ebp)
  103485:	8b 45 10             	mov    0x10(%ebp),%eax
  103488:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  10348b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  10348e:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  103492:	8b 55 f8             	mov    -0x8(%ebp),%edx
  103495:	89 d7                	mov    %edx,%edi
  103497:	f3 aa                	rep stos %al,%es:(%edi)
  103499:	89 fa                	mov    %edi,%edx
  10349b:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  10349e:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  1034a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  1034a4:	83 c4 24             	add    $0x24,%esp
  1034a7:	5f                   	pop    %edi
  1034a8:	5d                   	pop    %ebp
  1034a9:	c3                   	ret    

001034aa <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  1034aa:	55                   	push   %ebp
  1034ab:	89 e5                	mov    %esp,%ebp
  1034ad:	57                   	push   %edi
  1034ae:	56                   	push   %esi
  1034af:	53                   	push   %ebx
  1034b0:	83 ec 30             	sub    $0x30,%esp
  1034b3:	8b 45 08             	mov    0x8(%ebp),%eax
  1034b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1034b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1034bc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1034bf:	8b 45 10             	mov    0x10(%ebp),%eax
  1034c2:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  1034c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1034c8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  1034cb:	73 42                	jae    10350f <memmove+0x65>
  1034cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1034d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1034d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1034d6:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1034d9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1034dc:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  1034df:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1034e2:	c1 e8 02             	shr    $0x2,%eax
  1034e5:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  1034e7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1034ea:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1034ed:	89 d7                	mov    %edx,%edi
  1034ef:	89 c6                	mov    %eax,%esi
  1034f1:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  1034f3:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  1034f6:	83 e1 03             	and    $0x3,%ecx
  1034f9:	74 02                	je     1034fd <memmove+0x53>
  1034fb:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1034fd:	89 f0                	mov    %esi,%eax
  1034ff:	89 fa                	mov    %edi,%edx
  103501:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  103504:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  103507:	89 45 d0             	mov    %eax,-0x30(%ebp)
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
            : "memory");
    return dst;
  10350a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10350d:	eb 36                	jmp    103545 <memmove+0x9b>
    asm volatile (
            "std;"
            "rep; movsb;"
            "cld;"
            : "=&c" (d0), "=&S" (d1), "=&D" (d2)
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  10350f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103512:	8d 50 ff             	lea    -0x1(%eax),%edx
  103515:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103518:	01 c2                	add    %eax,%edx
  10351a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10351d:	8d 48 ff             	lea    -0x1(%eax),%ecx
  103520:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103523:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
        return __memcpy(dst, src, n);
    }
    int d0, d1, d2;
    asm volatile (
  103526:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103529:	89 c1                	mov    %eax,%ecx
  10352b:	89 d8                	mov    %ebx,%eax
  10352d:	89 d6                	mov    %edx,%esi
  10352f:	89 c7                	mov    %eax,%edi
  103531:	fd                   	std    
  103532:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  103534:	fc                   	cld    
  103535:	89 f8                	mov    %edi,%eax
  103537:	89 f2                	mov    %esi,%edx
  103539:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  10353c:	89 55 c8             	mov    %edx,-0x38(%ebp)
  10353f:	89 45 c4             	mov    %eax,-0x3c(%ebp)
            "rep; movsb;"
            "cld;"
            : "=&c" (d0), "=&S" (d1), "=&D" (d2)
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
            : "memory");
    return dst;
  103542:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  103545:	83 c4 30             	add    $0x30,%esp
  103548:	5b                   	pop    %ebx
  103549:	5e                   	pop    %esi
  10354a:	5f                   	pop    %edi
  10354b:	5d                   	pop    %ebp
  10354c:	c3                   	ret    

0010354d <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  10354d:	55                   	push   %ebp
  10354e:	89 e5                	mov    %esp,%ebp
  103550:	57                   	push   %edi
  103551:	56                   	push   %esi
  103552:	83 ec 20             	sub    $0x20,%esp
  103555:	8b 45 08             	mov    0x8(%ebp),%eax
  103558:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10355b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10355e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103561:	8b 45 10             	mov    0x10(%ebp),%eax
  103564:	89 45 ec             	mov    %eax,-0x14(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  103567:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10356a:	c1 e8 02             	shr    $0x2,%eax
  10356d:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  10356f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103572:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103575:	89 d7                	mov    %edx,%edi
  103577:	89 c6                	mov    %eax,%esi
  103579:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  10357b:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  10357e:	83 e1 03             	and    $0x3,%ecx
  103581:	74 02                	je     103585 <memcpy+0x38>
  103583:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  103585:	89 f0                	mov    %esi,%eax
  103587:	89 fa                	mov    %edi,%edx
  103589:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  10358c:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  10358f:	89 45 e0             	mov    %eax,-0x20(%ebp)
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
            : "memory");
    return dst;
  103592:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  103595:	83 c4 20             	add    $0x20,%esp
  103598:	5e                   	pop    %esi
  103599:	5f                   	pop    %edi
  10359a:	5d                   	pop    %ebp
  10359b:	c3                   	ret    

0010359c <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  10359c:	55                   	push   %ebp
  10359d:	89 e5                	mov    %esp,%ebp
  10359f:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  1035a2:	8b 45 08             	mov    0x8(%ebp),%eax
  1035a5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  1035a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035ab:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  1035ae:	eb 30                	jmp    1035e0 <memcmp+0x44>
        if (*s1 != *s2) {
  1035b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1035b3:	0f b6 10             	movzbl (%eax),%edx
  1035b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1035b9:	0f b6 00             	movzbl (%eax),%eax
  1035bc:	38 c2                	cmp    %al,%dl
  1035be:	74 18                	je     1035d8 <memcmp+0x3c>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  1035c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1035c3:	0f b6 00             	movzbl (%eax),%eax
  1035c6:	0f b6 d0             	movzbl %al,%edx
  1035c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1035cc:	0f b6 00             	movzbl (%eax),%eax
  1035cf:	0f b6 c0             	movzbl %al,%eax
  1035d2:	29 c2                	sub    %eax,%edx
  1035d4:	89 d0                	mov    %edx,%eax
  1035d6:	eb 1a                	jmp    1035f2 <memcmp+0x56>
        }
        s1 ++, s2 ++;
  1035d8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1035dc:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
    const char *s1 = (const char *)v1;
    const char *s2 = (const char *)v2;
    while (n -- > 0) {
  1035e0:	8b 45 10             	mov    0x10(%ebp),%eax
  1035e3:	8d 50 ff             	lea    -0x1(%eax),%edx
  1035e6:	89 55 10             	mov    %edx,0x10(%ebp)
  1035e9:	85 c0                	test   %eax,%eax
  1035eb:	75 c3                	jne    1035b0 <memcmp+0x14>
        if (*s1 != *s2) {
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
        }
        s1 ++, s2 ++;
    }
    return 0;
  1035ed:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1035f2:	c9                   	leave  
  1035f3:	c3                   	ret    
