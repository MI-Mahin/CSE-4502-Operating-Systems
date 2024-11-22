
obj/kern/init/boot_ap.elf:     file format elf32-i386


Disassembly of section .text:

00008000 <start_ap>:
	.set CR0_PE_ON, 0x1		# protected mode enable flag

	.globl start_ap, end_ap
start_ap:
	.code16
	cli
    8000:	fa                   	cli    
	cld
    8001:	fc                   	cld    

	xorw	%ax, %ax
    8002:	31 c0                	xor    %eax,%eax
	movw	%ax, %ds
    8004:	8e d8                	mov    %eax,%ds
	movw	%ax, %es
    8006:	8e c0                	mov    %eax,%es
	movw	%ax, %ss
    8008:	8e d0                	mov    %eax,%ss

	lgdt	gdtdesc
    800a:	0f 01 16             	lgdtl  (%esi)
    800d:	5c                   	pop    %esp
    800e:	80 0f 20             	orb    $0x20,(%edi)
	movl	%cr0, %eax
    8011:	c0 66 83 c8          	shlb   $0xc8,-0x7d(%esi)
	orl	$CR0_PE_ON, %eax
    8015:	01 0f                	add    %ecx,(%edi)
	movl	%eax, %cr0
    8017:	22 c0                	and    %al,%al

	ljmp	$PROT_MODE_CSEG, $protcseg
    8019:	ea                   	.byte 0xea
    801a:	1e                   	push   %ds
    801b:	80 08 00             	orb    $0x0,(%eax)

0000801e <protcseg>:

	.code32
protcseg:
	movw	$PROT_MODE_DSEG, %ax
    801e:	66 b8 10 00          	mov    $0x10,%ax
	movw	%ax, %ds
    8022:	8e d8                	mov    %eax,%ds
	movw	%ax, %es
    8024:	8e c0                	mov    %eax,%es
	movw	%ax, %ss
    8026:	8e d0                	mov    %eax,%ss
	xorw	%ax, %ax
    8028:	66 31 c0             	xor    %ax,%ax
	movw	%ax, %fs
    802b:	8e e0                	mov    %eax,%fs
	movw	%ax, %gs
    802d:	8e e8                	mov    %eax,%gs

	movl	start_ap - 4, %esp
    802f:	8b 25 fc 7f 00 00    	mov    0x7ffc,%esp
	movl	start_ap - 8, %eax
    8035:	a1 f8 7f 00 00       	mov    0x7ff8,%eax
	pushl	%eax
    803a:	50                   	push   %eax
	call	*(start_ap - 12)
    803b:	ff 15 f4 7f 00 00    	call   *0x7ff4

00008041 <spin>:

spin:
	hlt
    8041:	f4                   	hlt    
    8042:	66 90                	xchg   %ax,%ax

00008044 <gdt>:
	...
    804c:	ff                   	(bad)  
    804d:	ff 00                	incl   (%eax)
    804f:	00 00                	add    %al,(%eax)
    8051:	9a cf 00 ff ff 00 00 	lcall  $0x0,$0xffff00cf
    8058:	00                   	.byte 0x0
    8059:	92                   	xchg   %eax,%edx
    805a:	cf                   	iret   
	...

0000805c <gdtdesc>:
    805c:	17                   	pop    %ss
    805d:	00 44 80 00          	add    %al,0x0(%eax,%eax,4)
	...
