
obj/boot/boot0.elf:     file format elf32-i386


Disassembly of section .text:

00007c00 <start>:
	.set PR_BOOTABLE, 0x80		# bootable partition

	.globl start
start:
	.code16
	cli
    7c00:	fa                   	cli    
	cld
    7c01:	fc                   	cld    

	/* clear segment registers */
	xorw	%ax, %ax
    7c02:	31 c0                	xor    %ax,%ax
	movw	%ax, %ds
    7c04:	8e d8                	mov    %ax,%ds
	movw	%ax, %es
    7c06:	8e c0                	mov    %ax,%es
	movw	%ax, %ss
    7c08:	8e d0                	mov    %ax,%ss

	/* store the booting device id */
	xorl	%eax, %eax
    7c0a:	66 31 c0             	xor    %eax,%eax
	movb	%dl, %al
    7c0d:	88 d0                	mov    %dl,%al
	movl	%eax, BOOT0 - 4
    7c0f:	66 a3 fc 7b          	mov    %eax,0x7bfc

	/* set up the stack */
	movw	$(BOOT0 - 4), %bp
    7c13:	bd fc 7b             	mov    $0x7bfc,%bp
	movw	$(BOOT0 - 4), %sp
    7c16:	bc fc 7b             	mov    $0x7bfc,%sp

00007c19 <set_video_mode>:

	/* set to normal (80x25 text) video mode */
set_video_mode:
	movw	$0x03, %ax
    7c19:	b8 03 00             	mov    $0x3,%ax
	int	$0x10
    7c1c:	cd 10                	int    $0x10

	/* print starting message */
	movw	$STARTUP_MSG, %si
    7c1e:	be 53 7c             	mov    $0x7c53,%si
	call	putstr
    7c21:	e8 21 00             	call   7c45 <putstr>

00007c24 <load_boot1>:
	/*
	 * load boot1 from sector 2 to sector 63
	 */
load_boot1:
	/* read disk */
	pushl	$0x0			# set the start
    7c24:	66 6a 00             	pushl  $0x0
	pushl	$0x1			# LBA address
    7c27:	66 6a 01             	pushl  $0x1
	pushw	%es			# set the buffer address
    7c2a:	06                   	push   %es
	pushw	$BOOT1			# to 0x7e00
    7c2b:	68 00 7e             	push   $0x7e00
	pushw	$62			# set the number of sectors to be read
    7c2e:	6a 3e                	push   $0x3e
	pushw	$0x10			# set the size of DAP
    7c30:	6a 10                	push   $0x10
	movw	%sp, %si		# set the DAP address
    7c32:	89 e6                	mov    %sp,%si
	movw	$0x4200, %ax		# ah = 0x42, al = 0x00
    7c34:	b8 00 42             	mov    $0x4200,%ax
	int	$0x13			# read sectors
    7c37:	cd 13                	int    $0x13
	jc	load_fail		# encouter errors
    7c39:	72 03                	jb     7c3e <load_fail>

	jmp	BOOT1			# jump to boot1
    7c3b:	e9 c2 01             	jmp    7e00 <BOOT1>

00007c3e <load_fail>:

load_fail:
	movw	$LOAD_FAIL_MSG, %si
    7c3e:	be 65 7c             	mov    $0x7c65,%si
	call	putstr
    7c41:	e8 01 00             	call   7c45 <putstr>

00007c44 <spin>:

spin:
	hlt
    7c44:	f4                   	hlt    

00007c45 <putstr>:

/*
 * print a string (@ %si) to the screen
 */
putstr:
	pusha
    7c45:	60                   	pusha  
	movb	$0xe, %ah
    7c46:	b4 0e                	mov    $0xe,%ah

00007c48 <putstr.1>:
putstr.1:
	lodsb
    7c48:	ac                   	lods   %ds:(%si),%al
	cmp	$0, %al
    7c49:	3c 00                	cmp    $0x0,%al
	je	putstr.2
    7c4b:	74 04                	je     7c51 <putstr.2>
	int	$0x10
    7c4d:	cd 10                	int    $0x10
	jmp	putstr.1
    7c4f:	eb f7                	jmp    7c48 <putstr.1>

00007c51 <putstr.2>:
putstr.2:
	popa
    7c51:	61                   	popa   
	ret
    7c52:	c3                   	ret    

00007c53 <STARTUP_MSG>:
    7c53:	53                   	push   %bx
    7c54:	74 61                	je     7cb7 <_end+0x33>
    7c56:	72 74                	jb     7ccc <_end+0x48>
    7c58:	20 62 6f             	and    %ah,0x6f(%bp,%si)
    7c5b:	6f                   	outsw  %ds:(%si),(%dx)
    7c5c:	74 30                	je     7c8e <_end+0xa>
    7c5e:	20 2e 2e 2e          	and    %ch,0x2e2e
    7c62:	0d 0a 00             	or     $0xa,%ax

00007c65 <LOAD_FAIL_MSG>:
    7c65:	45                   	inc    %bp
    7c66:	72 72                	jb     7cda <_end+0x56>
    7c68:	6f                   	outsw  %ds:(%si),(%dx)
    7c69:	72 20                	jb     7c8b <_end+0x7>
    7c6b:	64 75 72             	fs jne 7ce0 <_end+0x5c>
    7c6e:	69 6e 67 20 6c       	imul   $0x6c20,0x67(%bp),%bp
    7c73:	6f                   	outsw  %ds:(%si),(%dx)
    7c74:	61                   	popa   
    7c75:	64 69 6e 67 20 62    	imul   $0x6220,%fs:0x67(%bp),%bp
    7c7b:	6f                   	outsw  %ds:(%si),(%dx)
    7c7c:	6f                   	outsw  %ds:(%si),(%dx)
    7c7d:	74 31                	je     7cb0 <_end+0x2c>
    7c7f:	2e 0d 0a 00          	cs or  $0xa,%ax
