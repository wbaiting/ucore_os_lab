#include <asm.h>
# 在看代码之前 要清楚：
# 1、 这里是AT&T汇编，因此语法与Intel格式略微不同。
#     典型就是 源操作与目的操作数顺序想法。其次是寻址的写法。
# 2、gcc内联汇编，扩展内联汇编语句，如下
#    asm [volatile] (Assembler Template
#	: Output Operands
# 	[: Input Operands
# 	[: Clobbers ] ])
#   例如：
# 	asm(
# 	  "cld \n\t"
# 	  "rep \n\t"
# 	  "stosl"
# 	:
# 	: "c" (count), "a" (value), "D" (buf)
# 	);
# 	第一个冒号后面是输出 例如 
# 	__asm__(\
# 	    "movl %%cr0, %0\n\t" \
# 	    :"=r" (__dummy)
# 	);
# 	"=r"表示相应的目标操作数(指令部分的%0)可以使用任何一个通用寄存器。
#        并且变量__dummy存放在这个寄存器中。
# 	还有以下字母：m,v,o,R,Q,I,h,E,F,G,a,b,c,d,,S,D,I
#       __asm__ __volatile__("cli":::"memory");
# 3、BIOS启动过程
#   以Intel80386为例,计算机加电后，CPU从物理地址0xFFFFFFF0开始执行。在0xFFFFFFF0这里只是存放了一条跳转指令，通过跳转指令跳到BIOS例行程序起始点。BIOS做完计算机硬件自检和初始化后，会选择一个启动设备，并且读取该设备的第一扇区，到内存一个特定的地址0x7c00处，然后CPU控制权会转移到那个地址执行，至此，就跳到这里继续执行了。
#   第一条指令位于F000:FFF0，里面存放EA5BE000F0,意为 JMP F000:E05B,对于这的困惑，被这篇博客给解答了。<a href=https://blog.csdn.net/xuefeng0707/article/details/8526306>BIOS入口地址:FFFF:0000是指什么意思?在物理上是指内存条的什么位置? - CSDN博客</a>
# 4、物理内存空间分布图（个人在网上找资料总结的，未必正确）
# 	+------------------------------+0xFFFFFFFF(4GB)
# 	| 32bit设备映射空间 	       |
# 	| EA5BE000F0 		       | 0xFFFFFFF0 存放跳转F000:E05B指令
# 	| 			       |
# 	+------------------------------+
# 	| 			       |
# 	| 			       |
# 	+------------------------------+实际物理内存空间结束地址
# 	| 			       |
# 	| 			       |
# 	|空闲内存空间 		       |
# 	+------------------------------+
# 	|n*sizeof(struct Page)大小的   |
# 	|空间 			       |
# 	+------------------------------+
# 	|ucore的BSS段 		       |
# 	+------------------------------+
# 	|ucore的DATA段 		       |
# 	+------------------------------+
# 	|ucore的TEXT段 		       |
# 	+------------------------------+0x100000(1MB)
#  	|BIOS Boot Block 	       |
# 	+------------------------------+0xFE000(1016KB)
# 	|BIOS Routine&Card BIOS        |
# 	+------------------------------+0xF0000(960KB)
# 	|16bit设备扩展ROM 	       |
# 	+------------------------------+0xC0000(768KB)
# 	|CGA/EGA+ Chroma text 	       |
# 	|video buffer 		       |
# 	+------------------------------+0xB8000
# 	|Mono text text video buffer   |
#       +------------------------------+0xB0000
# 	|EGA/VGA/XGA/XVGA Graphic Video|
#       | Buffer 		       |
# 	+------------------------------+0xA0000
# 	|Extended BIOS Data Area       |
#       |  (usually 1k)                |
# 	+------------------------------+0x9FC00
# 	|                              |
# 	|                              |
# 	|空闲内存                      |
# 	+------------------------------+基于bootlodaer的大小，不大于5102字节
# 	|bootloader的TEXT段以及DATA段  |
# 	+------------------------------+0x7c00
# 	|bootloader和ucore共用的堆栈   |
#  	+------------------------------+基于对堆栈的使用情况
# 	|低地址空闲空间 	       |
#  	+------------------------------+0x500
# 	|BIOS Data Area                |
#       +------------------------------+0x400
# 	|Interrupt Vector(256*4B=1024B)|
# 	+------------------------------+0x0

# ucore实验指导书中对于物理空间是这样划分的：
#
# 	+-------------------------------+0xFFFFFFFF(4GB)
# 	| 无效空间 			|
# 	| 				|
# 	+-------------------------------+addr:3G+256M
# 	| 256MB 			|
# 	| IO外设地址空间 		|
# 	| 				|
# 	+-------------------------------+0xC0000000(3GB)
# 	| 				|
# 	/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#
# 	/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
# 	| 无效空间 			|
# 	+-------------------------------+0x40000000(1GB)
# 	| 				|
# 	| 实际有效内存			|
# 	| 				|
# 	+-------------------------------+0x100000(1MB)
# 	| BIOS ROM 			|
# 	+-------------------------------+0xF0000(960KB)
# 	| 16-bit devices,		|
# 	| expansion ROMs		|
# 	+-------------------------------+0xC0000(768KB)
# 	| 	VGA Display 	        |
# 	+-------------------------------+0xA0000(640KB)
# 	| 			        |
# 	| 	Low Memory 	        |
# 	| 			        |
# 	+-------------------------------+0x0


# Start the CPU: switch to 32-bit protected mode, jump into C.
# The BIOS loads this code from the first sector of the hard disk into
# memory at physical address 0x7c00 and starts executing in real mode
# with %cs=0 %ip=7c00.

# 伪指令.set，给变量赋值，这里设置代码段和数据段的选择子。相关的是GDT全局描述符表，因为待会就要切换到保护模式，将使能地址映射，所以需要配置这两个选择子。在../kern/mmu/mmu.c中有关于GDT结构体的描述。
.set PROT_MODE_CSEG,        0x8                     # kernel code segment selector
.set PROT_MODE_DSEG,        0x10                    # kernel data segment selector
.set CR0_PE_ON,             0x1                     # protected mode enable flag

# start address should be 0:7c00, in real mode, the beginning address of the running bootloader
# 将start变量设置为全局变量，在链接文件中要用到。
.globl start
start:
.code16                                             # Assemble for 16-bit mode
    cli                                             # Disable interrupts
    cld                                             # String operations increment

    # Set up the important data segment registers (DS, ES, SS).
    xorw %ax, %ax                                   # Segment number zero
    movw %ax, %ds                                   # -> Data Segment
    movw %ax, %es                                   # -> Extra Segment
    movw %ax, %ss                                   # -> Stack Segment

    # Enable A20:
    #  For backwards compatibility with the earliest PCs, physical
    #  address line 20 is tied low, so that addresses higher than
    #  1MB wrap around to zero by default. This code undoes this.
# 在实验指导书中有A20地址线的详细介绍，以及别人的博客链接地址
seta20.1:
    inb $0x64, %al                                  # Wait for not busy(8042 input buffer empty).
    testb $0x2, %al
    jnz seta20.1

    movb $0xd1, %al                                 # 0xd1 -> port 0x64
    outb %al, $0x64                                 # 0xd1 means: write data to 8042's P2 port

seta20.2:
    inb $0x64, %al                                  # Wait for not busy(8042 input buffer empty).
    testb $0x2, %al
    jnz seta20.2

    movb $0xdf, %al                                 # 0xdf -> port 0x60
    outb %al, $0x60                                 # 0xdf = 11011111, means set P2's A20 bit(the 1 bit) to 1

    # Switch from real to protected mode, using a bootstrap GDT
    # and segment translation that makes virtual addresses
    # identical to physical addresses, so that the
    # effective memory map does not change during the switch.
# 加载全局描述符
    lgdt gdtdesc
    movl %cr0, %eax
    orl $CR0_PE_ON, %eax
    movl %eax, %cr0

    # Jump to next instruction, but in 32-bit code segment.
    # Switches processor into 32-bit mode.
# 使用CS:IP重新跳转
    ljmp $PROT_MODE_CSEG, $protcseg

.code32                                             # Assemble for 32-bit mode
protcseg:
    # Set up the protected-mode data segment registers
    movw $PROT_MODE_DSEG, %ax                       # Our data segment selector
    movw %ax, %ds                                   # -> DS: Data Segment
    movw %ax, %es                                   # -> ES: Extra Segment
    movw %ax, %fs                                   # -> FS
    movw %ax, %gs                                   # -> GS
    movw %ax, %ss                                   # -> SS: Stack Segment

    # Set up the stack pointer and call into C. The stack region is from 0--start(0x7c00)
    movl $0x0, %ebp
    movl $start, %esp
    call bootmain

    # If bootmain returns (it shouldn't), loop.
spin:
    jmp spin

# Bootstrap GDT
# 全局描述符表项为8字节
.p2align 2                                          # force 4 byte alignment
gdt:
    SEG_NULLASM                                     # null seg
    SEG_ASM(STA_X|STA_R, 0x0, 0xffffffff)           # code seg for bootloader and kernel
    SEG_ASM(STA_W, 0x0, 0xffffffff)                 # data seg for bootloader and kernel

gdtdesc:
# 
# +-------------+--------+
# |基址 	|表限 	 |
# +-------------+--------+
# 47          16 15       0
    .word 0x17                                      # sizeof(gdt) - 1
    .long gdt                                       # address gdt
