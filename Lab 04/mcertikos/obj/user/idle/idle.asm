
obj/user/idle/idle:     file format elf32-i386


Disassembly of section .text:

40000000 <main>:
#include <syscall.h>
#include <x86.h>

int main(int argc, char **argv)
{
    while (1) {}
40000000:	eb fe                	jmp    40000000 <main>

40000002 <_start>:
_start:
	/*
	 * If there are arguments on the stack, then the current stack will not
	 * be aligned to a nice big power-of-two boundary.
	 */
	testl	$0x0fffffff, %esp
40000002:	f7 c4 ff ff ff 0f    	test   $0xfffffff,%esp
	jnz	args_exist
40000008:	75 04                	jne    4000000e <args_exist>

4000000a <noargs>:

noargs:
	/* If no arguments are on the stack, push two dummy zero. */
	pushl	$0
4000000a:	6a 00                	push   $0x0
	pushl	$0
4000000c:	6a 00                	push   $0x0

4000000e <args_exist>:

args_exist:
	/* Jump to the C part. */
	call	main
4000000e:	e8 ed ff ff ff       	call   40000000 <main>

	/* When returning, push the return value on the stack. */
	pushl	%eax
40000013:	50                   	push   %eax

40000014 <spin>:
spin:
	jmp	spin
40000014:	eb fe                	jmp    40000014 <spin>
40000016:	66 90                	xchg   %ax,%ax
40000018:	66 90                	xchg   %ax,%ax
4000001a:	66 90                	xchg   %ax,%ax
4000001c:	66 90                	xchg   %ax,%ax
4000001e:	66 90                	xchg   %ax,%ax

40000020 <debug>:
#include <proc.h>
#include <stdarg.h>
#include <stdio.h>

void debug(const char *file, int line, const char *fmt, ...)
{
40000020:	53                   	push   %ebx
40000021:	e8 c1 00 00 00       	call   400000e7 <__x86.get_pc_thunk.bx>
40000026:	81 c3 da 3f 00 00    	add    $0x3fda,%ebx
4000002c:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[D] %s:%d: ", file, line);
4000002f:	ff 74 24 18          	push   0x18(%esp)
40000033:	ff 74 24 18          	push   0x18(%esp)
40000037:	8d 83 00 e0 ff ff    	lea    -0x2000(%ebx),%eax
4000003d:	50                   	push   %eax
4000003e:	e8 fd 01 00 00       	call   40000240 <printf>
    vcprintf(fmt, ap);
40000043:	58                   	pop    %eax
40000044:	5a                   	pop    %edx
40000045:	8d 44 24 24          	lea    0x24(%esp),%eax
40000049:	50                   	push   %eax
4000004a:	ff 74 24 24          	push   0x24(%esp)
4000004e:	e8 8d 01 00 00       	call   400001e0 <vcprintf>
    va_end(ap);
}
40000053:	83 c4 18             	add    $0x18,%esp
40000056:	5b                   	pop    %ebx
40000057:	c3                   	ret    
40000058:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000005f:	90                   	nop

40000060 <warn>:

void warn(const char *file, int line, const char *fmt, ...)
{
40000060:	53                   	push   %ebx
40000061:	e8 81 00 00 00       	call   400000e7 <__x86.get_pc_thunk.bx>
40000066:	81 c3 9a 3f 00 00    	add    $0x3f9a,%ebx
4000006c:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[W] %s:%d: ", file, line);
4000006f:	ff 74 24 18          	push   0x18(%esp)
40000073:	ff 74 24 18          	push   0x18(%esp)
40000077:	8d 83 0c e0 ff ff    	lea    -0x1ff4(%ebx),%eax
4000007d:	50                   	push   %eax
4000007e:	e8 bd 01 00 00       	call   40000240 <printf>
    vcprintf(fmt, ap);
40000083:	58                   	pop    %eax
40000084:	5a                   	pop    %edx
40000085:	8d 44 24 24          	lea    0x24(%esp),%eax
40000089:	50                   	push   %eax
4000008a:	ff 74 24 24          	push   0x24(%esp)
4000008e:	e8 4d 01 00 00       	call   400001e0 <vcprintf>
    va_end(ap);
}
40000093:	83 c4 18             	add    $0x18,%esp
40000096:	5b                   	pop    %ebx
40000097:	c3                   	ret    
40000098:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000009f:	90                   	nop

400000a0 <panic>:

void panic(const char *file, int line, const char *fmt, ...)
{
400000a0:	53                   	push   %ebx
400000a1:	e8 41 00 00 00       	call   400000e7 <__x86.get_pc_thunk.bx>
400000a6:	81 c3 5a 3f 00 00    	add    $0x3f5a,%ebx
400000ac:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[P] %s:%d: ", file, line);
400000af:	ff 74 24 18          	push   0x18(%esp)
400000b3:	ff 74 24 18          	push   0x18(%esp)
400000b7:	8d 83 18 e0 ff ff    	lea    -0x1fe8(%ebx),%eax
400000bd:	50                   	push   %eax
400000be:	e8 7d 01 00 00       	call   40000240 <printf>
    vcprintf(fmt, ap);
400000c3:	58                   	pop    %eax
400000c4:	5a                   	pop    %edx
400000c5:	8d 44 24 24          	lea    0x24(%esp),%eax
400000c9:	50                   	push   %eax
400000ca:	ff 74 24 24          	push   0x24(%esp)
400000ce:	e8 0d 01 00 00       	call   400001e0 <vcprintf>
400000d3:	83 c4 10             	add    $0x10,%esp
400000d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400000dd:	8d 76 00             	lea    0x0(%esi),%esi
    va_end(ap);

    while (1)
        yield();
400000e0:	e8 3b 09 00 00       	call   40000a20 <yield>
    while (1)
400000e5:	eb f9                	jmp    400000e0 <panic+0x40>

400000e7 <__x86.get_pc_thunk.bx>:
400000e7:	8b 1c 24             	mov    (%esp),%ebx
400000ea:	c3                   	ret    
400000eb:	66 90                	xchg   %ax,%ax
400000ed:	66 90                	xchg   %ax,%ax
400000ef:	90                   	nop

400000f0 <atoi>:
#include <stdlib.h>

int atoi(const char *buf, int *i)
{
400000f0:	55                   	push   %ebp
400000f1:	57                   	push   %edi
400000f2:	56                   	push   %esi
400000f3:	53                   	push   %ebx
    int loc = 0;
    int numstart = 0;
    int acc = 0;
    int negative = 0;
    if (buf[loc] == '+')
400000f4:	8b 44 24 14          	mov    0x14(%esp),%eax
400000f8:	0f b6 00             	movzbl (%eax),%eax
400000fb:	3c 2b                	cmp    $0x2b,%al
400000fd:	0f 84 85 00 00 00    	je     40000188 <atoi+0x98>
    int negative = 0;
40000103:	31 ff                	xor    %edi,%edi
    int loc = 0;
40000105:	31 f6                	xor    %esi,%esi
        loc++;
    else if (buf[loc] == '-') {
40000107:	3c 2d                	cmp    $0x2d,%al
40000109:	74 55                	je     40000160 <atoi+0x70>
        negative = 1;
        loc++;
    }
    numstart = loc;
    // no grab the numbers
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000010b:	8d 50 d0             	lea    -0x30(%eax),%edx
4000010e:	80 fa 09             	cmp    $0x9,%dl
40000111:	77 67                	ja     4000017a <atoi+0x8a>
40000113:	89 f2                	mov    %esi,%edx
    int acc = 0;
40000115:	31 c9                	xor    %ecx,%ecx
40000117:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000011e:	66 90                	xchg   %ax,%ax
        acc = acc * 10 + (buf[loc] - '0');
40000120:	83 e8 30             	sub    $0x30,%eax
40000123:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
        loc++;
40000126:	83 c2 01             	add    $0x1,%edx
        acc = acc * 10 + (buf[loc] - '0');
40000129:	0f be c0             	movsbl %al,%eax
4000012c:	8d 0c 48             	lea    (%eax,%ecx,2),%ecx
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000012f:	8b 44 24 14          	mov    0x14(%esp),%eax
40000133:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
40000137:	8d 68 d0             	lea    -0x30(%eax),%ebp
4000013a:	89 eb                	mov    %ebp,%ebx
4000013c:	80 fb 09             	cmp    $0x9,%bl
4000013f:	76 df                	jbe    40000120 <atoi+0x30>
    }
    if (numstart == loc) {
40000141:	39 d6                	cmp    %edx,%esi
40000143:	74 35                	je     4000017a <atoi+0x8a>
        // no numbers have actually been scanned
        return 0;
    }
    if (negative)
        acc = -acc;
40000145:	89 c8                	mov    %ecx,%eax
40000147:	f7 d8                	neg    %eax
40000149:	85 ff                	test   %edi,%edi
4000014b:	0f 45 c8             	cmovne %eax,%ecx
    *i = acc;
4000014e:	8b 44 24 18          	mov    0x18(%esp),%eax
40000152:	89 08                	mov    %ecx,(%eax)
    return loc;
}
40000154:	89 d0                	mov    %edx,%eax
40000156:	5b                   	pop    %ebx
40000157:	5e                   	pop    %esi
40000158:	5f                   	pop    %edi
40000159:	5d                   	pop    %ebp
4000015a:	c3                   	ret    
4000015b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
4000015f:	90                   	nop
    while ('0' <= buf[loc] && buf[loc] <= '9') {
40000160:	8b 44 24 14          	mov    0x14(%esp),%eax
        negative = 1;
40000164:	bf 01 00 00 00       	mov    $0x1,%edi
        loc++;
40000169:	be 01 00 00 00       	mov    $0x1,%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000016e:	0f b6 40 01          	movzbl 0x1(%eax),%eax
40000172:	8d 50 d0             	lea    -0x30(%eax),%edx
40000175:	80 fa 09             	cmp    $0x9,%dl
40000178:	76 99                	jbe    40000113 <atoi+0x23>
        return 0;
4000017a:	31 d2                	xor    %edx,%edx
}
4000017c:	5b                   	pop    %ebx
4000017d:	5e                   	pop    %esi
4000017e:	89 d0                	mov    %edx,%eax
40000180:	5f                   	pop    %edi
40000181:	5d                   	pop    %ebp
40000182:	c3                   	ret    
40000183:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000187:	90                   	nop
    while ('0' <= buf[loc] && buf[loc] <= '9') {
40000188:	8b 44 24 14          	mov    0x14(%esp),%eax
    int negative = 0;
4000018c:	31 ff                	xor    %edi,%edi
        loc++;
4000018e:	be 01 00 00 00       	mov    $0x1,%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
40000193:	0f b6 40 01          	movzbl 0x1(%eax),%eax
40000197:	e9 6f ff ff ff       	jmp    4000010b <atoi+0x1b>
4000019c:	66 90                	xchg   %ax,%ax
4000019e:	66 90                	xchg   %ax,%ax

400001a0 <putch>:
    int cnt;            // total bytes printed so far
    char buf[MAX_BUF];
};

static void putch(int ch, struct printbuf *b)
{
400001a0:	53                   	push   %ebx
400001a1:	8b 54 24 0c          	mov    0xc(%esp),%edx
    b->buf[b->idx++] = ch;
400001a5:	0f b6 5c 24 08       	movzbl 0x8(%esp),%ebx
400001aa:	8b 02                	mov    (%edx),%eax
400001ac:	8d 48 01             	lea    0x1(%eax),%ecx
400001af:	89 0a                	mov    %ecx,(%edx)
400001b1:	88 5c 02 08          	mov    %bl,0x8(%edx,%eax,1)
    if (b->idx == MAX_BUF - 1) {
400001b5:	81 f9 ff 01 00 00    	cmp    $0x1ff,%ecx
400001bb:	75 14                	jne    400001d1 <putch+0x31>
        b->buf[b->idx] = 0;
400001bd:	c6 82 07 02 00 00 00 	movb   $0x0,0x207(%edx)
        puts(b->buf, b->idx);
400001c4:	8d 5a 08             	lea    0x8(%edx),%ebx
#include <types.h>
#include <x86.h>

static gcc_inline void sys_puts(const char *s, size_t len)
{
    asm volatile ("int %0"
400001c7:	31 c0                	xor    %eax,%eax
400001c9:	cd 30                	int    $0x30
        b->idx = 0;
400001cb:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
    }
    b->cnt++;
400001d1:	83 42 04 01          	addl   $0x1,0x4(%edx)
}
400001d5:	5b                   	pop    %ebx
400001d6:	c3                   	ret    
400001d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400001de:	66 90                	xchg   %ax,%ax

400001e0 <vcprintf>:

int vcprintf(const char *fmt, va_list ap)
{
400001e0:	53                   	push   %ebx
400001e1:	e8 01 ff ff ff       	call   400000e7 <__x86.get_pc_thunk.bx>
400001e6:	81 c3 1a 3e 00 00    	add    $0x3e1a,%ebx
400001ec:	81 ec 18 02 00 00    	sub    $0x218,%esp
    struct printbuf b;

    b.idx = 0;
400001f2:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
400001f9:	00 
    b.cnt = 0;
400001fa:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000201:	00 
    vprintfmt((void *) putch, &b, fmt, ap);
40000202:	ff b4 24 24 02 00 00 	push   0x224(%esp)
40000209:	ff b4 24 24 02 00 00 	push   0x224(%esp)
40000210:	8d 44 24 10          	lea    0x10(%esp),%eax
40000214:	50                   	push   %eax
40000215:	8d 83 a0 c1 ff ff    	lea    -0x3e60(%ebx),%eax
4000021b:	50                   	push   %eax
4000021c:	e8 3f 01 00 00       	call   40000360 <vprintfmt>

    b.buf[b.idx] = 0;
40000221:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000225:	8d 5c 24 20          	lea    0x20(%esp),%ebx
40000229:	31 c0                	xor    %eax,%eax
4000022b:	c6 44 0c 20 00       	movb   $0x0,0x20(%esp,%ecx,1)
40000230:	cd 30                	int    $0x30
    puts(b.buf, b.idx);

    return b.cnt;
}
40000232:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000236:	81 c4 28 02 00 00    	add    $0x228,%esp
4000023c:	5b                   	pop    %ebx
4000023d:	c3                   	ret    
4000023e:	66 90                	xchg   %ax,%ax

40000240 <printf>:

int printf(const char *fmt, ...)
{
40000240:	83 ec 14             	sub    $0x14,%esp
    va_list ap;
    int cnt;

    va_start(ap, fmt);
    cnt = vcprintf(fmt, ap);
40000243:	8d 44 24 1c          	lea    0x1c(%esp),%eax
40000247:	50                   	push   %eax
40000248:	ff 74 24 1c          	push   0x1c(%esp)
4000024c:	e8 8f ff ff ff       	call   400001e0 <vcprintf>
    va_end(ap);

    return cnt;
}
40000251:	83 c4 1c             	add    $0x1c,%esp
40000254:	c3                   	ret    
40000255:	66 90                	xchg   %ax,%ax
40000257:	66 90                	xchg   %ax,%ax
40000259:	66 90                	xchg   %ax,%ax
4000025b:	66 90                	xchg   %ax,%ax
4000025d:	66 90                	xchg   %ax,%ax
4000025f:	90                   	nop

40000260 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void *), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
40000260:	e8 96 07 00 00       	call   400009fb <__x86.get_pc_thunk.cx>
40000265:	81 c1 9b 3d 00 00    	add    $0x3d9b,%ecx
4000026b:	55                   	push   %ebp
4000026c:	57                   	push   %edi
4000026d:	89 d7                	mov    %edx,%edi
4000026f:	56                   	push   %esi
40000270:	89 c6                	mov    %eax,%esi
40000272:	53                   	push   %ebx
40000273:	83 ec 2c             	sub    $0x2c,%esp
40000276:	8b 54 24 44          	mov    0x44(%esp),%edx
4000027a:	8b 44 24 40          	mov    0x40(%esp),%eax
4000027e:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, num / base, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (--width > 0)
40000282:	8b 4c 24 4c          	mov    0x4c(%esp),%ecx
{
40000286:	8b 5c 24 50          	mov    0x50(%esp),%ebx
    if (num >= base) {
4000028a:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
40000291:	00 
{
40000292:	89 54 24 0c          	mov    %edx,0xc(%esp)
40000296:	8b 54 24 48          	mov    0x48(%esp),%edx
4000029a:	89 44 24 08          	mov    %eax,0x8(%esp)
    if (num >= base) {
4000029e:	8b 44 24 0c          	mov    0xc(%esp),%eax
        while (--width > 0)
400002a2:	8d 69 ff             	lea    -0x1(%ecx),%ebp
    if (num >= base) {
400002a5:	39 54 24 08          	cmp    %edx,0x8(%esp)
400002a9:	1b 44 24 14          	sbb    0x14(%esp),%eax
400002ad:	89 54 24 10          	mov    %edx,0x10(%esp)
400002b1:	73 55                	jae    40000308 <printnum+0xa8>
        while (--width > 0)
400002b3:	85 ed                	test   %ebp,%ebp
400002b5:	7e 18                	jle    400002cf <printnum+0x6f>
400002b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400002be:	66 90                	xchg   %ax,%ax
            putch(padc, putdat);
400002c0:	83 ec 08             	sub    $0x8,%esp
400002c3:	57                   	push   %edi
400002c4:	53                   	push   %ebx
400002c5:	ff d6                	call   *%esi
        while (--width > 0)
400002c7:	83 c4 10             	add    $0x10,%esp
400002ca:	83 ed 01             	sub    $0x1,%ebp
400002cd:	75 f1                	jne    400002c0 <printnum+0x60>
    }

    // then print this (the least significant) digit
    putch("0123456789abcdef"[num % base], putdat);
400002cf:	89 7c 24 44          	mov    %edi,0x44(%esp)
400002d3:	ff 74 24 14          	push   0x14(%esp)
400002d7:	ff 74 24 14          	push   0x14(%esp)
400002db:	ff 74 24 14          	push   0x14(%esp)
400002df:	ff 74 24 14          	push   0x14(%esp)
400002e3:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
400002e7:	e8 a4 0d 00 00       	call   40001090 <__umoddi3>
400002ec:	0f be 84 03 24 e0 ff 	movsbl -0x1fdc(%ebx,%eax,1),%eax
400002f3:	ff 
400002f4:	89 44 24 50          	mov    %eax,0x50(%esp)
}
400002f8:	83 c4 3c             	add    $0x3c,%esp
    putch("0123456789abcdef"[num % base], putdat);
400002fb:	89 f0                	mov    %esi,%eax
}
400002fd:	5b                   	pop    %ebx
400002fe:	5e                   	pop    %esi
400002ff:	5f                   	pop    %edi
40000300:	5d                   	pop    %ebp
    putch("0123456789abcdef"[num % base], putdat);
40000301:	ff e0                	jmp    *%eax
40000303:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000307:	90                   	nop
        printnum(putch, putdat, num / base, base, width - 1, padc);
40000308:	83 ec 0c             	sub    $0xc,%esp
4000030b:	53                   	push   %ebx
4000030c:	55                   	push   %ebp
4000030d:	52                   	push   %edx
4000030e:	83 ec 08             	sub    $0x8,%esp
40000311:	ff 74 24 34          	push   0x34(%esp)
40000315:	ff 74 24 34          	push   0x34(%esp)
40000319:	ff 74 24 34          	push   0x34(%esp)
4000031d:	ff 74 24 34          	push   0x34(%esp)
40000321:	8b 5c 24 4c          	mov    0x4c(%esp),%ebx
40000325:	e8 46 0c 00 00       	call   40000f70 <__udivdi3>
4000032a:	83 c4 18             	add    $0x18,%esp
4000032d:	52                   	push   %edx
4000032e:	89 fa                	mov    %edi,%edx
40000330:	50                   	push   %eax
40000331:	89 f0                	mov    %esi,%eax
40000333:	e8 28 ff ff ff       	call   40000260 <printnum>
40000338:	83 c4 20             	add    $0x20,%esp
4000033b:	eb 92                	jmp    400002cf <printnum+0x6f>
4000033d:	8d 76 00             	lea    0x0(%esi),%esi

40000340 <sprintputch>:
    char *ebuf;
    int cnt;
};

static void sprintputch(int ch, struct sprintbuf *b)
{
40000340:	8b 44 24 08          	mov    0x8(%esp),%eax
    b->cnt++;
40000344:	83 40 08 01          	addl   $0x1,0x8(%eax)
    if (b->buf < b->ebuf)
40000348:	8b 10                	mov    (%eax),%edx
4000034a:	3b 50 04             	cmp    0x4(%eax),%edx
4000034d:	73 0b                	jae    4000035a <sprintputch+0x1a>
        *b->buf++ = ch;
4000034f:	8d 4a 01             	lea    0x1(%edx),%ecx
40000352:	89 08                	mov    %ecx,(%eax)
40000354:	8b 44 24 04          	mov    0x4(%esp),%eax
40000358:	88 02                	mov    %al,(%edx)
}
4000035a:	c3                   	ret    
4000035b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
4000035f:	90                   	nop

40000360 <vprintfmt>:
{
40000360:	e8 8e 06 00 00       	call   400009f3 <__x86.get_pc_thunk.ax>
40000365:	05 9b 3c 00 00       	add    $0x3c9b,%eax
4000036a:	55                   	push   %ebp
4000036b:	57                   	push   %edi
4000036c:	56                   	push   %esi
4000036d:	53                   	push   %ebx
4000036e:	83 ec 3c             	sub    $0x3c,%esp
40000371:	8b 74 24 50          	mov    0x50(%esp),%esi
40000375:	8b 6c 24 54          	mov    0x54(%esp),%ebp
40000379:	89 44 24 14          	mov    %eax,0x14(%esp)
                for (width -= strnlen(p, precision); width > 0; width--)
4000037d:	8d 80 35 e0 ff ff    	lea    -0x1fcb(%eax),%eax
40000383:	89 44 24 24          	mov    %eax,0x24(%esp)
{
40000387:	8b 7c 24 58          	mov    0x58(%esp),%edi
        while ((ch = *(unsigned char *) fmt++) != '%') {
4000038b:	0f b6 07             	movzbl (%edi),%eax
4000038e:	8d 5f 01             	lea    0x1(%edi),%ebx
40000391:	83 f8 25             	cmp    $0x25,%eax
40000394:	75 20                	jne    400003b6 <vprintfmt+0x56>
40000396:	eb 30                	jmp    400003c8 <vprintfmt+0x68>
40000398:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000039f:	90                   	nop
            putch(ch, putdat);
400003a0:	83 ec 08             	sub    $0x8,%esp
        while ((ch = *(unsigned char *) fmt++) != '%') {
400003a3:	83 c3 01             	add    $0x1,%ebx
            putch(ch, putdat);
400003a6:	55                   	push   %ebp
400003a7:	50                   	push   %eax
400003a8:	ff d6                	call   *%esi
        while ((ch = *(unsigned char *) fmt++) != '%') {
400003aa:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
400003ae:	83 c4 10             	add    $0x10,%esp
400003b1:	83 f8 25             	cmp    $0x25,%eax
400003b4:	74 12                	je     400003c8 <vprintfmt+0x68>
            if (ch == '\0')
400003b6:	85 c0                	test   %eax,%eax
400003b8:	75 e6                	jne    400003a0 <vprintfmt+0x40>
}
400003ba:	83 c4 3c             	add    $0x3c,%esp
400003bd:	5b                   	pop    %ebx
400003be:	5e                   	pop    %esi
400003bf:	5f                   	pop    %edi
400003c0:	5d                   	pop    %ebp
400003c1:	c3                   	ret    
400003c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        precision = -1;
400003c8:	ba ff ff ff ff       	mov    $0xffffffff,%edx
        padc = ' ';
400003cd:	c6 44 24 18 20       	movb   $0x20,0x18(%esp)
        altflag = 0;
400003d2:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
400003d9:	00 
        width = -1;
400003da:	c7 44 24 10 ff ff ff 	movl   $0xffffffff,0x10(%esp)
400003e1:	ff 
        lflag = 0;
400003e2:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%esp)
400003e9:	00 
400003ea:	89 54 24 1c          	mov    %edx,0x1c(%esp)
400003ee:	89 74 24 50          	mov    %esi,0x50(%esp)
        switch (ch = *(unsigned char *) fmt++) {
400003f2:	0f b6 0b             	movzbl (%ebx),%ecx
400003f5:	8d 7b 01             	lea    0x1(%ebx),%edi
400003f8:	8d 41 dd             	lea    -0x23(%ecx),%eax
400003fb:	3c 55                	cmp    $0x55,%al
400003fd:	77 19                	ja     40000418 <.L20>
400003ff:	8b 54 24 14          	mov    0x14(%esp),%edx
40000403:	0f b6 c0             	movzbl %al,%eax
40000406:	8b b4 82 3c e0 ff ff 	mov    -0x1fc4(%edx,%eax,4),%esi
4000040d:	01 d6                	add    %edx,%esi
4000040f:	ff e6                	jmp    *%esi
40000411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000418 <.L20>:
            putch('%', putdat);
40000418:	8b 74 24 50          	mov    0x50(%esp),%esi
4000041c:	83 ec 08             	sub    $0x8,%esp
            for (fmt--; fmt[-1] != '%'; fmt--)
4000041f:	89 df                	mov    %ebx,%edi
            putch('%', putdat);
40000421:	55                   	push   %ebp
40000422:	6a 25                	push   $0x25
40000424:	ff d6                	call   *%esi
            for (fmt--; fmt[-1] != '%'; fmt--)
40000426:	83 c4 10             	add    $0x10,%esp
40000429:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
4000042d:	0f 84 58 ff ff ff    	je     4000038b <vprintfmt+0x2b>
40000433:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000437:	90                   	nop
40000438:	83 ef 01             	sub    $0x1,%edi
4000043b:	80 7f ff 25          	cmpb   $0x25,-0x1(%edi)
4000043f:	75 f7                	jne    40000438 <.L20+0x20>
40000441:	e9 45 ff ff ff       	jmp    4000038b <vprintfmt+0x2b>
40000446:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000044d:	8d 76 00             	lea    0x0(%esi),%esi

40000450 <.L30>:
                ch = *fmt;
40000450:	0f be 43 01          	movsbl 0x1(%ebx),%eax
                precision = precision * 10 + ch - '0';
40000454:	8d 51 d0             	lea    -0x30(%ecx),%edx
        switch (ch = *(unsigned char *) fmt++) {
40000457:	89 fb                	mov    %edi,%ebx
                precision = precision * 10 + ch - '0';
40000459:	89 54 24 1c          	mov    %edx,0x1c(%esp)
                if (ch < '0' || ch > '9')
4000045d:	8d 48 d0             	lea    -0x30(%eax),%ecx
40000460:	83 f9 09             	cmp    $0x9,%ecx
40000463:	77 28                	ja     4000048d <.L30+0x3d>
        switch (ch = *(unsigned char *) fmt++) {
40000465:	8b 74 24 50          	mov    0x50(%esp),%esi
40000469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            for (precision = 0;; ++fmt) {
40000470:	83 c3 01             	add    $0x1,%ebx
                precision = precision * 10 + ch - '0';
40000473:	8d 14 92             	lea    (%edx,%edx,4),%edx
40000476:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
                ch = *fmt;
4000047a:	0f be 03             	movsbl (%ebx),%eax
                if (ch < '0' || ch > '9')
4000047d:	8d 48 d0             	lea    -0x30(%eax),%ecx
40000480:	83 f9 09             	cmp    $0x9,%ecx
40000483:	76 eb                	jbe    40000470 <.L30+0x20>
40000485:	89 54 24 1c          	mov    %edx,0x1c(%esp)
40000489:	89 74 24 50          	mov    %esi,0x50(%esp)
            if (width < 0)
4000048d:	8b 74 24 10          	mov    0x10(%esp),%esi
40000491:	85 f6                	test   %esi,%esi
40000493:	0f 89 59 ff ff ff    	jns    400003f2 <vprintfmt+0x92>
                width = precision, precision = -1;
40000499:	8b 44 24 1c          	mov    0x1c(%esp),%eax
4000049d:	c7 44 24 1c ff ff ff 	movl   $0xffffffff,0x1c(%esp)
400004a4:	ff 
400004a5:	89 44 24 10          	mov    %eax,0x10(%esp)
400004a9:	e9 44 ff ff ff       	jmp    400003f2 <vprintfmt+0x92>

400004ae <.L35>:
            altflag = 1;
400004ae:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
400004b5:	00 
        switch (ch = *(unsigned char *) fmt++) {
400004b6:	89 fb                	mov    %edi,%ebx
            goto reswitch;
400004b8:	e9 35 ff ff ff       	jmp    400003f2 <vprintfmt+0x92>

400004bd <.L34>:
            putch(ch, putdat);
400004bd:	8b 74 24 50          	mov    0x50(%esp),%esi
400004c1:	83 ec 08             	sub    $0x8,%esp
400004c4:	55                   	push   %ebp
400004c5:	6a 25                	push   $0x25
400004c7:	ff d6                	call   *%esi
            break;
400004c9:	83 c4 10             	add    $0x10,%esp
400004cc:	e9 ba fe ff ff       	jmp    4000038b <vprintfmt+0x2b>

400004d1 <.L33>:
            precision = va_arg(ap, int);
400004d1:	8b 44 24 5c          	mov    0x5c(%esp),%eax
        switch (ch = *(unsigned char *) fmt++) {
400004d5:	89 fb                	mov    %edi,%ebx
            precision = va_arg(ap, int);
400004d7:	8b 00                	mov    (%eax),%eax
400004d9:	89 44 24 1c          	mov    %eax,0x1c(%esp)
400004dd:	8b 44 24 5c          	mov    0x5c(%esp),%eax
400004e1:	83 c0 04             	add    $0x4,%eax
400004e4:	89 44 24 5c          	mov    %eax,0x5c(%esp)
            goto process_precision;
400004e8:	eb a3                	jmp    4000048d <.L30+0x3d>

400004ea <.L32>:
            if (width < 0)
400004ea:	8b 4c 24 10          	mov    0x10(%esp),%ecx
400004ee:	31 c0                	xor    %eax,%eax
        switch (ch = *(unsigned char *) fmt++) {
400004f0:	89 fb                	mov    %edi,%ebx
400004f2:	85 c9                	test   %ecx,%ecx
400004f4:	0f 49 c1             	cmovns %ecx,%eax
400004f7:	89 44 24 10          	mov    %eax,0x10(%esp)
            goto reswitch;
400004fb:	e9 f2 fe ff ff       	jmp    400003f2 <vprintfmt+0x92>

40000500 <.L29>:
            putch(va_arg(ap, int), putdat);
40000500:	8b 44 24 5c          	mov    0x5c(%esp),%eax
40000504:	8b 74 24 50          	mov    0x50(%esp),%esi
40000508:	83 ec 08             	sub    $0x8,%esp
4000050b:	55                   	push   %ebp
4000050c:	8d 58 04             	lea    0x4(%eax),%ebx
4000050f:	8b 44 24 68          	mov    0x68(%esp),%eax
40000513:	ff 30                	push   (%eax)
40000515:	ff d6                	call   *%esi
40000517:	89 5c 24 6c          	mov    %ebx,0x6c(%esp)
            break;
4000051b:	83 c4 10             	add    $0x10,%esp
4000051e:	e9 68 fe ff ff       	jmp    4000038b <vprintfmt+0x2b>

40000523 <.L23>:
    if (lflag >= 2)
40000523:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
40000528:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, unsigned long long);
4000052c:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
40000530:	0f 8f d7 01 00 00    	jg     4000070d <.L24+0xe0>
        return va_arg(*ap, unsigned long);
40000536:	8b 4c 24 5c          	mov    0x5c(%esp),%ecx
            precision = va_arg(ap, int);
4000053a:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
4000053d:	31 db                	xor    %ebx,%ebx
4000053f:	ba 0a 00 00 00       	mov    $0xa,%edx
40000544:	8b 09                	mov    (%ecx),%ecx
40000546:	89 44 24 5c          	mov    %eax,0x5c(%esp)
4000054a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            printnum(putch, putdat, num, base, width, padc);
40000550:	83 ec 0c             	sub    $0xc,%esp
40000553:	0f be 44 24 24       	movsbl 0x24(%esp),%eax
40000558:	50                   	push   %eax
40000559:	89 f0                	mov    %esi,%eax
4000055b:	ff 74 24 20          	push   0x20(%esp)
4000055f:	52                   	push   %edx
40000560:	89 ea                	mov    %ebp,%edx
40000562:	53                   	push   %ebx
40000563:	51                   	push   %ecx
40000564:	e8 f7 fc ff ff       	call   40000260 <printnum>
            break;
40000569:	83 c4 20             	add    $0x20,%esp
4000056c:	e9 1a fe ff ff       	jmp    4000038b <vprintfmt+0x2b>

40000571 <.L25>:
            putch('0', putdat);
40000571:	8b 74 24 50          	mov    0x50(%esp),%esi
40000575:	83 ec 08             	sub    $0x8,%esp
40000578:	55                   	push   %ebp
40000579:	6a 30                	push   $0x30
4000057b:	ff d6                	call   *%esi
            putch('x', putdat);
4000057d:	59                   	pop    %ecx
4000057e:	5b                   	pop    %ebx
4000057f:	55                   	push   %ebp
40000580:	6a 78                	push   $0x78
            num = (unsigned long long)
40000582:	31 db                	xor    %ebx,%ebx
            putch('x', putdat);
40000584:	ff d6                	call   *%esi
            num = (unsigned long long)
40000586:	8b 44 24 6c          	mov    0x6c(%esp),%eax
            goto number;
4000058a:	ba 10 00 00 00       	mov    $0x10,%edx
            num = (unsigned long long)
4000058f:	8b 08                	mov    (%eax),%ecx
            goto number;
40000591:	83 c4 10             	add    $0x10,%esp
                (uintptr_t) va_arg(ap, void *);
40000594:	83 c0 04             	add    $0x4,%eax
40000597:	89 44 24 5c          	mov    %eax,0x5c(%esp)
            goto number;
4000059b:	eb b3                	jmp    40000550 <.L23+0x2d>

4000059d <.L21>:
    if (lflag >= 2)
4000059d:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
400005a2:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, unsigned long long);
400005a6:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
400005aa:	0f 8f 6e 01 00 00    	jg     4000071e <.L24+0xf1>
        return va_arg(*ap, unsigned long);
400005b0:	8b 4c 24 5c          	mov    0x5c(%esp),%ecx
            precision = va_arg(ap, int);
400005b4:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
400005b7:	31 db                	xor    %ebx,%ebx
400005b9:	ba 10 00 00 00       	mov    $0x10,%edx
400005be:	8b 09                	mov    (%ecx),%ecx
400005c0:	89 44 24 5c          	mov    %eax,0x5c(%esp)
400005c4:	eb 8a                	jmp    40000550 <.L23+0x2d>

400005c6 <.L28>:
    if (lflag >= 2)
400005c6:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
400005cb:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, long long);
400005cf:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
400005d3:	0f 8f 5b 01 00 00    	jg     40000734 <.L24+0x107>
        return va_arg(*ap, long);
400005d9:	8b 00                	mov    (%eax),%eax
400005db:	89 c3                	mov    %eax,%ebx
400005dd:	89 c1                	mov    %eax,%ecx
400005df:	8b 44 24 5c          	mov    0x5c(%esp),%eax
400005e3:	c1 fb 1f             	sar    $0x1f,%ebx
400005e6:	83 c0 04             	add    $0x4,%eax
400005e9:	89 44 24 5c          	mov    %eax,0x5c(%esp)
            if ((long long) num < 0) {
400005ed:	85 db                	test   %ebx,%ebx
400005ef:	0f 88 68 01 00 00    	js     4000075d <.L31+0xc>
        return va_arg(*ap, unsigned long long);
400005f5:	ba 0a 00 00 00       	mov    $0xa,%edx
400005fa:	e9 51 ff ff ff       	jmp    40000550 <.L23+0x2d>

400005ff <.L27>:
            lflag++;
400005ff:	83 44 24 20 01       	addl   $0x1,0x20(%esp)
        switch (ch = *(unsigned char *) fmt++) {
40000604:	89 fb                	mov    %edi,%ebx
            goto reswitch;
40000606:	e9 e7 fd ff ff       	jmp    400003f2 <vprintfmt+0x92>

4000060b <.L26>:
            putch('X', putdat);
4000060b:	8b 74 24 50          	mov    0x50(%esp),%esi
4000060f:	83 ec 08             	sub    $0x8,%esp
40000612:	55                   	push   %ebp
40000613:	6a 58                	push   $0x58
40000615:	ff d6                	call   *%esi
            putch('X', putdat);
40000617:	58                   	pop    %eax
40000618:	5a                   	pop    %edx
40000619:	55                   	push   %ebp
4000061a:	6a 58                	push   $0x58
4000061c:	ff d6                	call   *%esi
            putch('X', putdat);
4000061e:	59                   	pop    %ecx
4000061f:	5b                   	pop    %ebx
40000620:	55                   	push   %ebp
40000621:	6a 58                	push   $0x58
40000623:	ff d6                	call   *%esi
            break;
40000625:	83 c4 10             	add    $0x10,%esp
40000628:	e9 5e fd ff ff       	jmp    4000038b <vprintfmt+0x2b>

4000062d <.L24>:
            if ((p = va_arg(ap, char *)) == NULL)
4000062d:	8b 44 24 5c          	mov    0x5c(%esp),%eax
            if (width > 0 && padc != '-')
40000631:	8b 5c 24 10          	mov    0x10(%esp),%ebx
            if ((p = va_arg(ap, char *)) == NULL)
40000635:	8b 54 24 1c          	mov    0x1c(%esp),%edx
40000639:	8b 74 24 50          	mov    0x50(%esp),%esi
4000063d:	83 c0 04             	add    $0x4,%eax
            if (width > 0 && padc != '-')
40000640:	80 7c 24 18 2d       	cmpb   $0x2d,0x18(%esp)
            if ((p = va_arg(ap, char *)) == NULL)
40000645:	89 44 24 1c          	mov    %eax,0x1c(%esp)
40000649:	8b 44 24 5c          	mov    0x5c(%esp),%eax
4000064d:	8b 08                	mov    (%eax),%ecx
            if (width > 0 && padc != '-')
4000064f:	0f 95 c0             	setne  %al
40000652:	85 db                	test   %ebx,%ebx
40000654:	0f 9f c3             	setg   %bl
40000657:	21 d8                	and    %ebx,%eax
            if ((p = va_arg(ap, char *)) == NULL)
40000659:	85 c9                	test   %ecx,%ecx
4000065b:	0f 84 28 01 00 00    	je     40000789 <.L31+0x38>
                 (ch = *p++) != '\0' && (precision < 0
40000661:	8d 59 01             	lea    0x1(%ecx),%ebx
40000664:	89 5c 24 20          	mov    %ebx,0x20(%esp)
            if (width > 0 && padc != '-')
40000668:	84 c0                	test   %al,%al
4000066a:	0f 85 48 01 00 00    	jne    400007b8 <.L31+0x67>
                 (ch = *p++) != '\0' && (precision < 0
40000670:	0f be 09             	movsbl (%ecx),%ecx
40000673:	89 c8                	mov    %ecx,%eax
40000675:	85 c9                	test   %ecx,%ecx
40000677:	74 67                	je     400006e0 <.L24+0xb3>
40000679:	89 74 24 50          	mov    %esi,0x50(%esp)
4000067d:	89 d6                	mov    %edx,%esi
4000067f:	89 7c 24 58          	mov    %edi,0x58(%esp)
40000683:	8b 7c 24 10          	mov    0x10(%esp),%edi
40000687:	eb 2c                	jmp    400006b5 <.L24+0x88>
40000689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                if (altflag && (ch < ' ' || ch > '~'))
40000690:	83 e8 20             	sub    $0x20,%eax
40000693:	83 f8 5e             	cmp    $0x5e,%eax
40000696:	76 2e                	jbe    400006c6 <.L24+0x99>
                    putch('?', putdat);
40000698:	83 ec 08             	sub    $0x8,%esp
4000069b:	55                   	push   %ebp
4000069c:	6a 3f                	push   $0x3f
4000069e:	ff 54 24 60          	call   *0x60(%esp)
400006a2:	83 c4 10             	add    $0x10,%esp
                 (ch = *p++) != '\0' && (precision < 0
400006a5:	0f be 03             	movsbl (%ebx),%eax
400006a8:	83 c3 01             	add    $0x1,%ebx
                                         || --precision >= 0); width--)
400006ab:	83 ef 01             	sub    $0x1,%edi
                 (ch = *p++) != '\0' && (precision < 0
400006ae:	0f be c8             	movsbl %al,%ecx
400006b1:	85 c9                	test   %ecx,%ecx
400006b3:	74 1f                	je     400006d4 <.L24+0xa7>
400006b5:	85 f6                	test   %esi,%esi
400006b7:	78 05                	js     400006be <.L24+0x91>
                                         || --precision >= 0); width--)
400006b9:	83 ee 01             	sub    $0x1,%esi
400006bc:	72 16                	jb     400006d4 <.L24+0xa7>
                if (altflag && (ch < ' ' || ch > '~'))
400006be:	8b 54 24 08          	mov    0x8(%esp),%edx
400006c2:	85 d2                	test   %edx,%edx
400006c4:	75 ca                	jne    40000690 <.L24+0x63>
                    putch(ch, putdat);
400006c6:	83 ec 08             	sub    $0x8,%esp
400006c9:	55                   	push   %ebp
400006ca:	51                   	push   %ecx
400006cb:	ff 54 24 60          	call   *0x60(%esp)
400006cf:	83 c4 10             	add    $0x10,%esp
400006d2:	eb d1                	jmp    400006a5 <.L24+0x78>
400006d4:	89 7c 24 10          	mov    %edi,0x10(%esp)
400006d8:	8b 74 24 50          	mov    0x50(%esp),%esi
400006dc:	8b 7c 24 58          	mov    0x58(%esp),%edi
            for (; width > 0; width--)
400006e0:	8b 4c 24 10          	mov    0x10(%esp),%ecx
400006e4:	8b 5c 24 10          	mov    0x10(%esp),%ebx
400006e8:	85 c9                	test   %ecx,%ecx
400006ea:	7e 14                	jle    40000700 <.L24+0xd3>
400006ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                putch(' ', putdat);
400006f0:	83 ec 08             	sub    $0x8,%esp
400006f3:	55                   	push   %ebp
400006f4:	6a 20                	push   $0x20
400006f6:	ff d6                	call   *%esi
            for (; width > 0; width--)
400006f8:	83 c4 10             	add    $0x10,%esp
400006fb:	83 eb 01             	sub    $0x1,%ebx
400006fe:	75 f0                	jne    400006f0 <.L24+0xc3>
            if ((p = va_arg(ap, char *)) == NULL)
40000700:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000704:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000708:	e9 7e fc ff ff       	jmp    4000038b <vprintfmt+0x2b>
        return va_arg(*ap, unsigned long long);
4000070d:	8b 08                	mov    (%eax),%ecx
4000070f:	8b 58 04             	mov    0x4(%eax),%ebx
40000712:	83 c0 08             	add    $0x8,%eax
40000715:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000719:	e9 d7 fe ff ff       	jmp    400005f5 <.L28+0x2f>
4000071e:	8b 08                	mov    (%eax),%ecx
40000720:	8b 58 04             	mov    0x4(%eax),%ebx
40000723:	83 c0 08             	add    $0x8,%eax
40000726:	ba 10 00 00 00       	mov    $0x10,%edx
4000072b:	89 44 24 5c          	mov    %eax,0x5c(%esp)
4000072f:	e9 1c fe ff ff       	jmp    40000550 <.L23+0x2d>
        return va_arg(*ap, long long);
40000734:	8b 08                	mov    (%eax),%ecx
40000736:	8b 58 04             	mov    0x4(%eax),%ebx
40000739:	83 c0 08             	add    $0x8,%eax
4000073c:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000740:	e9 a8 fe ff ff       	jmp    400005ed <.L28+0x27>

40000745 <.L61>:
            padc = '-';
40000745:	c6 44 24 18 2d       	movb   $0x2d,0x18(%esp)
        switch (ch = *(unsigned char *) fmt++) {
4000074a:	89 fb                	mov    %edi,%ebx
4000074c:	e9 a1 fc ff ff       	jmp    400003f2 <vprintfmt+0x92>

40000751 <.L31>:
40000751:	c6 44 24 18 30       	movb   $0x30,0x18(%esp)
40000756:	89 fb                	mov    %edi,%ebx
40000758:	e9 95 fc ff ff       	jmp    400003f2 <vprintfmt+0x92>
4000075d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
                putch('-', putdat);
40000761:	83 ec 08             	sub    $0x8,%esp
40000764:	89 5c 24 14          	mov    %ebx,0x14(%esp)
40000768:	55                   	push   %ebp
40000769:	6a 2d                	push   $0x2d
4000076b:	ff d6                	call   *%esi
                num = -(long long) num;
4000076d:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000771:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
40000775:	ba 0a 00 00 00       	mov    $0xa,%edx
4000077a:	f7 d9                	neg    %ecx
4000077c:	83 d3 00             	adc    $0x0,%ebx
4000077f:	83 c4 10             	add    $0x10,%esp
40000782:	f7 db                	neg    %ebx
40000784:	e9 c7 fd ff ff       	jmp    40000550 <.L23+0x2d>
            if (width > 0 && padc != '-')
40000789:	84 c0                	test   %al,%al
4000078b:	0f 85 9f 00 00 00    	jne    40000830 <.L31+0xdf>
                 (ch = *p++) != '\0' && (precision < 0
40000791:	8b 44 24 14          	mov    0x14(%esp),%eax
40000795:	b9 28 00 00 00       	mov    $0x28,%ecx
4000079a:	8d 98 36 e0 ff ff    	lea    -0x1fca(%eax),%ebx
400007a0:	89 74 24 50          	mov    %esi,0x50(%esp)
400007a4:	b8 28 00 00 00       	mov    $0x28,%eax
400007a9:	89 d6                	mov    %edx,%esi
400007ab:	89 7c 24 58          	mov    %edi,0x58(%esp)
400007af:	8b 7c 24 10          	mov    0x10(%esp),%edi
400007b3:	e9 fd fe ff ff       	jmp    400006b5 <.L24+0x88>
                for (width -= strnlen(p, precision); width > 0; width--)
400007b8:	83 ec 08             	sub    $0x8,%esp
400007bb:	52                   	push   %edx
400007bc:	89 54 24 38          	mov    %edx,0x38(%esp)
400007c0:	51                   	push   %ecx
400007c1:	8b 5c 24 24          	mov    0x24(%esp),%ebx
400007c5:	89 4c 24 38          	mov    %ecx,0x38(%esp)
400007c9:	e8 12 03 00 00       	call   40000ae0 <strnlen>
400007ce:	29 44 24 20          	sub    %eax,0x20(%esp)
400007d2:	8b 4c 24 20          	mov    0x20(%esp),%ecx
400007d6:	83 c4 10             	add    $0x10,%esp
400007d9:	8b 54 24 2c          	mov    0x2c(%esp),%edx
400007dd:	85 c9                	test   %ecx,%ecx
400007df:	8b 4c 24 28          	mov    0x28(%esp),%ecx
400007e3:	7e 34                	jle    40000819 <.L31+0xc8>
                    putch(padc, putdat);
400007e5:	0f be 5c 24 18       	movsbl 0x18(%esp),%ebx
400007ea:	89 4c 24 28          	mov    %ecx,0x28(%esp)
400007ee:	89 54 24 18          	mov    %edx,0x18(%esp)
400007f2:	89 7c 24 58          	mov    %edi,0x58(%esp)
400007f6:	8b 7c 24 10          	mov    0x10(%esp),%edi
400007fa:	83 ec 08             	sub    $0x8,%esp
400007fd:	55                   	push   %ebp
400007fe:	53                   	push   %ebx
400007ff:	ff d6                	call   *%esi
                for (width -= strnlen(p, precision); width > 0; width--)
40000801:	83 c4 10             	add    $0x10,%esp
40000804:	83 ef 01             	sub    $0x1,%edi
40000807:	75 f1                	jne    400007fa <.L31+0xa9>
40000809:	8b 54 24 18          	mov    0x18(%esp),%edx
4000080d:	8b 4c 24 28          	mov    0x28(%esp),%ecx
40000811:	89 7c 24 10          	mov    %edi,0x10(%esp)
40000815:	8b 7c 24 58          	mov    0x58(%esp),%edi
                 (ch = *p++) != '\0' && (precision < 0
40000819:	0f be 01             	movsbl (%ecx),%eax
4000081c:	8b 5c 24 20          	mov    0x20(%esp),%ebx
40000820:	0f be c8             	movsbl %al,%ecx
40000823:	85 c9                	test   %ecx,%ecx
40000825:	0f 85 4e fe ff ff    	jne    40000679 <.L24+0x4c>
4000082b:	e9 d0 fe ff ff       	jmp    40000700 <.L24+0xd3>
                for (width -= strnlen(p, precision); width > 0; width--)
40000830:	83 ec 08             	sub    $0x8,%esp
40000833:	52                   	push   %edx
40000834:	89 54 24 34          	mov    %edx,0x34(%esp)
40000838:	ff 74 24 30          	push   0x30(%esp)
4000083c:	8b 5c 24 24          	mov    0x24(%esp),%ebx
40000840:	e8 9b 02 00 00       	call   40000ae0 <strnlen>
40000845:	29 44 24 20          	sub    %eax,0x20(%esp)
40000849:	8b 44 24 20          	mov    0x20(%esp),%eax
4000084d:	83 c4 10             	add    $0x10,%esp
                p = "(null)";
40000850:	8b 54 24 24          	mov    0x24(%esp),%edx
40000854:	89 d1                	mov    %edx,%ecx
40000856:	83 c2 01             	add    $0x1,%edx
                for (width -= strnlen(p, precision); width > 0; width--)
40000859:	85 c0                	test   %eax,%eax
4000085b:	89 54 24 20          	mov    %edx,0x20(%esp)
4000085f:	8b 54 24 28          	mov    0x28(%esp),%edx
40000863:	7f 80                	jg     400007e5 <.L31+0x94>
                 (ch = *p++) != '\0' && (precision < 0
40000865:	8b 5c 24 20          	mov    0x20(%esp),%ebx
40000869:	b9 28 00 00 00       	mov    $0x28,%ecx
4000086e:	e9 2d ff ff ff       	jmp    400007a0 <.L31+0x4f>
40000873:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000087a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000880 <printfmt>:
{
40000880:	83 ec 0c             	sub    $0xc,%esp
    vprintfmt(putch, putdat, fmt, ap);
40000883:	8d 44 24 1c          	lea    0x1c(%esp),%eax
40000887:	50                   	push   %eax
40000888:	ff 74 24 1c          	push   0x1c(%esp)
4000088c:	ff 74 24 1c          	push   0x1c(%esp)
40000890:	ff 74 24 1c          	push   0x1c(%esp)
40000894:	e8 c7 fa ff ff       	call   40000360 <vprintfmt>
}
40000899:	83 c4 1c             	add    $0x1c,%esp
4000089c:	c3                   	ret    
4000089d:	8d 76 00             	lea    0x0(%esi),%esi

400008a0 <vsprintf>:

int vsprintf(char *buf, const char *fmt, va_list ap)
{
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
400008a0:	e8 4e 01 00 00       	call   400009f3 <__x86.get_pc_thunk.ax>
400008a5:	05 5b 37 00 00       	add    $0x375b,%eax
{
400008aa:	83 ec 1c             	sub    $0x1c,%esp
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
400008ad:	8b 54 24 20          	mov    0x20(%esp),%edx
400008b1:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
400008b8:	ff 
400008b9:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
400008c0:	00 
400008c1:	89 54 24 04          	mov    %edx,0x4(%esp)

    // print the string to the buffer
    vprintfmt((void *) sprintputch, &b, fmt, ap);
400008c5:	ff 74 24 28          	push   0x28(%esp)
400008c9:	ff 74 24 28          	push   0x28(%esp)
400008cd:	8d 80 40 c3 ff ff    	lea    -0x3cc0(%eax),%eax
400008d3:	8d 54 24 0c          	lea    0xc(%esp),%edx
400008d7:	52                   	push   %edx
400008d8:	50                   	push   %eax
400008d9:	e8 82 fa ff ff       	call   40000360 <vprintfmt>

    // null terminate the buffer
    *b.buf = '\0';
400008de:	8b 44 24 14          	mov    0x14(%esp),%eax
400008e2:	c6 00 00             	movb   $0x0,(%eax)

    return b.cnt;
}
400008e5:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400008e9:	83 c4 2c             	add    $0x2c,%esp
400008ec:	c3                   	ret    
400008ed:	8d 76 00             	lea    0x0(%esi),%esi

400008f0 <sprintf>:
int sprintf(char *buf, const char *fmt, ...)
{
    va_list ap;
    int rc;

    va_start(ap, fmt);
400008f0:	e8 fe 00 00 00       	call   400009f3 <__x86.get_pc_thunk.ax>
400008f5:	05 0b 37 00 00       	add    $0x370b,%eax
{
400008fa:	83 ec 1c             	sub    $0x1c,%esp
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
400008fd:	8b 54 24 20          	mov    0x20(%esp),%edx
40000901:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
40000908:	ff 
40000909:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000910:	00 
40000911:	89 54 24 04          	mov    %edx,0x4(%esp)
    vprintfmt((void *) sprintputch, &b, fmt, ap);
40000915:	8d 54 24 28          	lea    0x28(%esp),%edx
40000919:	52                   	push   %edx
4000091a:	ff 74 24 28          	push   0x28(%esp)
4000091e:	8d 80 40 c3 ff ff    	lea    -0x3cc0(%eax),%eax
40000924:	8d 54 24 0c          	lea    0xc(%esp),%edx
40000928:	52                   	push   %edx
40000929:	50                   	push   %eax
4000092a:	e8 31 fa ff ff       	call   40000360 <vprintfmt>
    *b.buf = '\0';
4000092f:	8b 44 24 14          	mov    0x14(%esp),%eax
40000933:	c6 00 00             	movb   $0x0,(%eax)
    rc = vsprintf(buf, fmt, ap);
    va_end(ap);

    return rc;
}
40000936:	8b 44 24 1c          	mov    0x1c(%esp),%eax
4000093a:	83 c4 2c             	add    $0x2c,%esp
4000093d:	c3                   	ret    
4000093e:	66 90                	xchg   %ax,%ax

40000940 <vsnprintf>:

int vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
    struct sprintbuf b = { buf, buf + n - 1, 0 };
40000940:	e8 b2 00 00 00       	call   400009f7 <__x86.get_pc_thunk.dx>
40000945:	81 c2 bb 36 00 00    	add    $0x36bb,%edx
{
4000094b:	83 ec 1c             	sub    $0x1c,%esp
4000094e:	8b 44 24 20          	mov    0x20(%esp),%eax
    struct sprintbuf b = { buf, buf + n - 1, 0 };
40000952:	8b 4c 24 24          	mov    0x24(%esp),%ecx
40000956:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
4000095d:	00 
4000095e:	89 44 24 04          	mov    %eax,0x4(%esp)
40000962:	8d 44 08 ff          	lea    -0x1(%eax,%ecx,1),%eax
40000966:	89 44 24 08          	mov    %eax,0x8(%esp)

    // print the string to the buffer
    vprintfmt((void *) sprintputch, &b, fmt, ap);
4000096a:	ff 74 24 2c          	push   0x2c(%esp)
4000096e:	ff 74 24 2c          	push   0x2c(%esp)
40000972:	8d 44 24 0c          	lea    0xc(%esp),%eax
40000976:	50                   	push   %eax
40000977:	8d 82 40 c3 ff ff    	lea    -0x3cc0(%edx),%eax
4000097d:	50                   	push   %eax
4000097e:	e8 dd f9 ff ff       	call   40000360 <vprintfmt>

    // null terminate the buffer
    *b.buf = '\0';
40000983:	8b 44 24 14          	mov    0x14(%esp),%eax
40000987:	c6 00 00             	movb   $0x0,(%eax)

    return b.cnt;
}
4000098a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
4000098e:	83 c4 2c             	add    $0x2c,%esp
40000991:	c3                   	ret    
40000992:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

400009a0 <snprintf>:
int snprintf(char *buf, int n, const char *fmt, ...)
{
    va_list ap;
    int rc;

    va_start(ap, fmt);
400009a0:	e8 52 00 00 00       	call   400009f7 <__x86.get_pc_thunk.dx>
400009a5:	81 c2 5b 36 00 00    	add    $0x365b,%edx
{
400009ab:	83 ec 1c             	sub    $0x1c,%esp
400009ae:	8b 44 24 20          	mov    0x20(%esp),%eax
    struct sprintbuf b = { buf, buf + n - 1, 0 };
400009b2:	8b 4c 24 24          	mov    0x24(%esp),%ecx
400009b6:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
400009bd:	00 
400009be:	89 44 24 04          	mov    %eax,0x4(%esp)
400009c2:	8d 44 08 ff          	lea    -0x1(%eax,%ecx,1),%eax
400009c6:	89 44 24 08          	mov    %eax,0x8(%esp)
    vprintfmt((void *) sprintputch, &b, fmt, ap);
400009ca:	8d 44 24 2c          	lea    0x2c(%esp),%eax
400009ce:	50                   	push   %eax
400009cf:	ff 74 24 2c          	push   0x2c(%esp)
400009d3:	8d 44 24 0c          	lea    0xc(%esp),%eax
400009d7:	50                   	push   %eax
400009d8:	8d 82 40 c3 ff ff    	lea    -0x3cc0(%edx),%eax
400009de:	50                   	push   %eax
400009df:	e8 7c f9 ff ff       	call   40000360 <vprintfmt>
    *b.buf = '\0';
400009e4:	8b 44 24 14          	mov    0x14(%esp),%eax
400009e8:	c6 00 00             	movb   $0x0,(%eax)
    rc = vsnprintf(buf, n, fmt, ap);
    va_end(ap);

    return rc;
}
400009eb:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400009ef:	83 c4 2c             	add    $0x2c,%esp
400009f2:	c3                   	ret    

400009f3 <__x86.get_pc_thunk.ax>:
400009f3:	8b 04 24             	mov    (%esp),%eax
400009f6:	c3                   	ret    

400009f7 <__x86.get_pc_thunk.dx>:
400009f7:	8b 14 24             	mov    (%esp),%edx
400009fa:	c3                   	ret    

400009fb <__x86.get_pc_thunk.cx>:
400009fb:	8b 0c 24             	mov    (%esp),%ecx
400009fe:	c3                   	ret    
400009ff:	90                   	nop

40000a00 <spawn>:
#include <proc.h>
#include <syscall.h>
#include <types.h>

pid_t spawn(uintptr_t exec, unsigned int quota)
{
40000a00:	53                   	push   %ebx
static gcc_inline pid_t sys_spawn(unsigned int elf_id, unsigned int quota)
{
    int errno;
    pid_t pid;

    asm volatile ("int %2"
40000a01:	b8 01 00 00 00       	mov    $0x1,%eax
40000a06:	8b 5c 24 08          	mov    0x8(%esp),%ebx
40000a0a:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000a0e:	cd 30                	int    $0x30
                    "a" (SYS_spawn),
                    "b" (elf_id),
                    "c" (quota)
                  : "cc", "memory");

    return errno ? -1 : pid;
40000a10:	85 c0                	test   %eax,%eax
40000a12:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
40000a17:	0f 44 c3             	cmove  %ebx,%eax
    return sys_spawn(exec, quota);
}
40000a1a:	5b                   	pop    %ebx
40000a1b:	c3                   	ret    
40000a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000a20 <yield>:
}

static gcc_inline void sys_yield(void)
{
    asm volatile ("int %0"
40000a20:	b8 02 00 00 00       	mov    $0x2,%eax
40000a25:	cd 30                	int    $0x30

void yield(void)
{
    sys_yield();
}
40000a27:	c3                   	ret    
40000a28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000a2f:	90                   	nop

40000a30 <produce>:
                  : "cc", "memory");
}

static gcc_inline void sys_produce(void)
{
    asm volatile ("int %0"
40000a30:	b8 03 00 00 00       	mov    $0x3,%eax
40000a35:	cd 30                	int    $0x30

void produce(void)
{
    sys_produce();
}
40000a37:	c3                   	ret    
40000a38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000a3f:	90                   	nop

40000a40 <consume>:
                  : "cc", "memory");
}

static gcc_inline void sys_consume(void)
{
    asm volatile ("int %0"
40000a40:	b8 04 00 00 00       	mov    $0x4,%eax
40000a45:	cd 30                	int    $0x30

void consume(void)
{
    sys_consume();
}
40000a47:	c3                   	ret    
40000a48:	66 90                	xchg   %ax,%ax
40000a4a:	66 90                	xchg   %ax,%ax
40000a4c:	66 90                	xchg   %ax,%ax
40000a4e:	66 90                	xchg   %ax,%ax

40000a50 <spinlock_init>:
    return result;
}

void spinlock_init(spinlock_t *lk)
{
    *lk = 0;
40000a50:	8b 44 24 04          	mov    0x4(%esp),%eax
40000a54:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
40000a5a:	c3                   	ret    
40000a5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000a5f:	90                   	nop

40000a60 <spinlock_acquire>:

void spinlock_acquire(spinlock_t *lk)
{
40000a60:	8b 54 24 04          	mov    0x4(%esp),%edx
    asm volatile ("lock; xchgl %0, %1"
40000a64:	b8 01 00 00 00       	mov    $0x1,%eax
40000a69:	f0 87 02             	lock xchg %eax,(%edx)
    while (xchg(lk, 1) != 0)
40000a6c:	85 c0                	test   %eax,%eax
40000a6e:	74 13                	je     40000a83 <spinlock_acquire+0x23>
    asm volatile ("lock; xchgl %0, %1"
40000a70:	b9 01 00 00 00       	mov    $0x1,%ecx
40000a75:	8d 76 00             	lea    0x0(%esi),%esi
        asm volatile ("pause");
40000a78:	f3 90                	pause  
    asm volatile ("lock; xchgl %0, %1"
40000a7a:	89 c8                	mov    %ecx,%eax
40000a7c:	f0 87 02             	lock xchg %eax,(%edx)
    while (xchg(lk, 1) != 0)
40000a7f:	85 c0                	test   %eax,%eax
40000a81:	75 f5                	jne    40000a78 <spinlock_acquire+0x18>
}
40000a83:	c3                   	ret    
40000a84:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000a8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000a8f:	90                   	nop

40000a90 <spinlock_release>:

// Release the lock.
void spinlock_release(spinlock_t *lk)
{
40000a90:	8b 54 24 04          	mov    0x4(%esp),%edx
}

// Check whether this cpu is holding the lock.
bool spinlock_holding(spinlock_t *lk)
{
    return *lk;
40000a94:	8b 02                	mov    (%edx),%eax
    if (spinlock_holding(lk) == FALSE)
40000a96:	84 c0                	test   %al,%al
40000a98:	74 05                	je     40000a9f <spinlock_release+0xf>
    asm volatile ("lock; xchgl %0, %1"
40000a9a:	31 c0                	xor    %eax,%eax
40000a9c:	f0 87 02             	lock xchg %eax,(%edx)
}
40000a9f:	c3                   	ret    

40000aa0 <spinlock_holding>:
    return *lk;
40000aa0:	8b 44 24 04          	mov    0x4(%esp),%eax
40000aa4:	8b 00                	mov    (%eax),%eax
}
40000aa6:	c3                   	ret    
40000aa7:	66 90                	xchg   %ax,%ax
40000aa9:	66 90                	xchg   %ax,%ax
40000aab:	66 90                	xchg   %ax,%ax
40000aad:	66 90                	xchg   %ax,%ax
40000aaf:	90                   	nop

40000ab0 <strlen>:
#include <string.h>
#include <types.h>

int strlen(const char *s)
{
40000ab0:	8b 54 24 04          	mov    0x4(%esp),%edx
    int n;

    for (n = 0; *s != '\0'; s++)
40000ab4:	31 c0                	xor    %eax,%eax
40000ab6:	80 3a 00             	cmpb   $0x0,(%edx)
40000ab9:	74 15                	je     40000ad0 <strlen+0x20>
40000abb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000abf:	90                   	nop
        n++;
40000ac0:	83 c0 01             	add    $0x1,%eax
    for (n = 0; *s != '\0'; s++)
40000ac3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
40000ac7:	75 f7                	jne    40000ac0 <strlen+0x10>
40000ac9:	c3                   	ret    
40000aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return n;
}
40000ad0:	c3                   	ret    
40000ad1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000ad8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000adf:	90                   	nop

40000ae0 <strnlen>:

int strnlen(const char *s, size_t size)
{
40000ae0:	8b 54 24 08          	mov    0x8(%esp),%edx
40000ae4:	8b 4c 24 04          	mov    0x4(%esp),%ecx
    int n;

    for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000ae8:	31 c0                	xor    %eax,%eax
40000aea:	85 d2                	test   %edx,%edx
40000aec:	75 09                	jne    40000af7 <strnlen+0x17>
40000aee:	eb 10                	jmp    40000b00 <strnlen+0x20>
        n++;
40000af0:	83 c0 01             	add    $0x1,%eax
    for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000af3:	39 d0                	cmp    %edx,%eax
40000af5:	74 09                	je     40000b00 <strnlen+0x20>
40000af7:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
40000afb:	75 f3                	jne    40000af0 <strnlen+0x10>
40000afd:	c3                   	ret    
40000afe:	66 90                	xchg   %ax,%ax
    return n;
}
40000b00:	c3                   	ret    
40000b01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b0f:	90                   	nop

40000b10 <strcpy>:

char *strcpy(char *dst, const char *src)
{
40000b10:	53                   	push   %ebx
40000b11:	8b 4c 24 08          	mov    0x8(%esp),%ecx
    char *ret;

    ret = dst;
    while ((*dst++ = *src++) != '\0')
40000b15:	31 c0                	xor    %eax,%eax
{
40000b17:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40000b1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000b1f:	90                   	nop
    while ((*dst++ = *src++) != '\0')
40000b20:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
40000b24:	88 14 01             	mov    %dl,(%ecx,%eax,1)
40000b27:	83 c0 01             	add    $0x1,%eax
40000b2a:	84 d2                	test   %dl,%dl
40000b2c:	75 f2                	jne    40000b20 <strcpy+0x10>
        /* do nothing */ ;
    return ret;
}
40000b2e:	89 c8                	mov    %ecx,%eax
40000b30:	5b                   	pop    %ebx
40000b31:	c3                   	ret    
40000b32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000b40 <strncpy>:

char *strncpy(char *dst, const char *src, size_t size)
{
40000b40:	56                   	push   %esi
40000b41:	53                   	push   %ebx
40000b42:	8b 5c 24 14          	mov    0x14(%esp),%ebx
40000b46:	8b 74 24 0c          	mov    0xc(%esp),%esi
40000b4a:	8b 54 24 10          	mov    0x10(%esp),%edx
    size_t i;
    char *ret;

    ret = dst;
    for (i = 0; i < size; i++) {
40000b4e:	85 db                	test   %ebx,%ebx
40000b50:	74 21                	je     40000b73 <strncpy+0x33>
40000b52:	01 f3                	add    %esi,%ebx
40000b54:	89 f0                	mov    %esi,%eax
40000b56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b5d:	8d 76 00             	lea    0x0(%esi),%esi
        *dst++ = *src;
40000b60:	0f b6 0a             	movzbl (%edx),%ecx
40000b63:	83 c0 01             	add    $0x1,%eax
        // If strlen(src) < size, null-pad 'dst' out to 'size' chars
        if (*src != '\0')
            src++;
40000b66:	80 f9 01             	cmp    $0x1,%cl
        *dst++ = *src;
40000b69:	88 48 ff             	mov    %cl,-0x1(%eax)
            src++;
40000b6c:	83 da ff             	sbb    $0xffffffff,%edx
    for (i = 0; i < size; i++) {
40000b6f:	39 d8                	cmp    %ebx,%eax
40000b71:	75 ed                	jne    40000b60 <strncpy+0x20>
    }
    return ret;
}
40000b73:	89 f0                	mov    %esi,%eax
40000b75:	5b                   	pop    %ebx
40000b76:	5e                   	pop    %esi
40000b77:	c3                   	ret    
40000b78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b7f:	90                   	nop

40000b80 <strlcpy>:

size_t strlcpy(char *dst, const char *src, size_t size)
{
40000b80:	53                   	push   %ebx
40000b81:	8b 44 24 10          	mov    0x10(%esp),%eax
40000b85:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    char *dst_in;

    dst_in = dst;
    if (size > 0) {
40000b89:	85 c0                	test   %eax,%eax
40000b8b:	74 30                	je     40000bbd <strlcpy+0x3d>
        while (--size > 0 && *src != '\0')
40000b8d:	8b 54 24 08          	mov    0x8(%esp),%edx
40000b91:	83 e8 01             	sub    $0x1,%eax
40000b94:	74 24                	je     40000bba <strlcpy+0x3a>
40000b96:	01 d0                	add    %edx,%eax
40000b98:	89 c3                	mov    %eax,%ebx
40000b9a:	eb 11                	jmp    40000bad <strlcpy+0x2d>
40000b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            *dst++ = *src++;
40000ba0:	83 c2 01             	add    $0x1,%edx
40000ba3:	83 c1 01             	add    $0x1,%ecx
40000ba6:	88 42 ff             	mov    %al,-0x1(%edx)
        while (--size > 0 && *src != '\0')
40000ba9:	39 da                	cmp    %ebx,%edx
40000bab:	74 07                	je     40000bb4 <strlcpy+0x34>
40000bad:	0f b6 01             	movzbl (%ecx),%eax
40000bb0:	84 c0                	test   %al,%al
40000bb2:	75 ec                	jne    40000ba0 <strlcpy+0x20>
        *dst = '\0';
    }
    return dst - dst_in;
40000bb4:	89 d0                	mov    %edx,%eax
40000bb6:	2b 44 24 08          	sub    0x8(%esp),%eax
        *dst = '\0';
40000bba:	c6 02 00             	movb   $0x0,(%edx)
}
40000bbd:	5b                   	pop    %ebx
40000bbe:	c3                   	ret    
40000bbf:	90                   	nop

40000bc0 <strcmp>:

int strcmp(const char *p, const char *q)
{
40000bc0:	53                   	push   %ebx
40000bc1:	8b 54 24 08          	mov    0x8(%esp),%edx
40000bc5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    while (*p && *p == *q)
40000bc9:	0f b6 02             	movzbl (%edx),%eax
40000bcc:	84 c0                	test   %al,%al
40000bce:	75 18                	jne    40000be8 <strcmp+0x28>
40000bd0:	eb 30                	jmp    40000c02 <strcmp+0x42>
40000bd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000bd8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        p++, q++;
40000bdc:	83 c2 01             	add    $0x1,%edx
40000bdf:	8d 59 01             	lea    0x1(%ecx),%ebx
    while (*p && *p == *q)
40000be2:	84 c0                	test   %al,%al
40000be4:	74 12                	je     40000bf8 <strcmp+0x38>
        p++, q++;
40000be6:	89 d9                	mov    %ebx,%ecx
    while (*p && *p == *q)
40000be8:	0f b6 19             	movzbl (%ecx),%ebx
40000beb:	38 c3                	cmp    %al,%bl
40000bed:	74 e9                	je     40000bd8 <strcmp+0x18>
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000bef:	29 d8                	sub    %ebx,%eax
}
40000bf1:	5b                   	pop    %ebx
40000bf2:	c3                   	ret    
40000bf3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000bf7:	90                   	nop
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000bf8:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
40000bfc:	31 c0                	xor    %eax,%eax
40000bfe:	29 d8                	sub    %ebx,%eax
}
40000c00:	5b                   	pop    %ebx
40000c01:	c3                   	ret    
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000c02:	0f b6 19             	movzbl (%ecx),%ebx
40000c05:	31 c0                	xor    %eax,%eax
40000c07:	eb e6                	jmp    40000bef <strcmp+0x2f>
40000c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000c10 <strncmp>:

int strncmp(const char *p, const char *q, size_t n)
{
40000c10:	56                   	push   %esi
40000c11:	53                   	push   %ebx
40000c12:	8b 74 24 14          	mov    0x14(%esp),%esi
40000c16:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000c1a:	8b 44 24 10          	mov    0x10(%esp),%eax
    while (n > 0 && *p && *p == *q)
40000c1e:	85 f6                	test   %esi,%esi
40000c20:	74 2e                	je     40000c50 <strncmp+0x40>
40000c22:	01 c6                	add    %eax,%esi
40000c24:	eb 18                	jmp    40000c3e <strncmp+0x2e>
40000c26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000c2d:	8d 76 00             	lea    0x0(%esi),%esi
40000c30:	38 da                	cmp    %bl,%dl
40000c32:	75 14                	jne    40000c48 <strncmp+0x38>
        n--, p++, q++;
40000c34:	83 c0 01             	add    $0x1,%eax
40000c37:	83 c1 01             	add    $0x1,%ecx
    while (n > 0 && *p && *p == *q)
40000c3a:	39 f0                	cmp    %esi,%eax
40000c3c:	74 12                	je     40000c50 <strncmp+0x40>
40000c3e:	0f b6 11             	movzbl (%ecx),%edx
40000c41:	0f b6 18             	movzbl (%eax),%ebx
40000c44:	84 d2                	test   %dl,%dl
40000c46:	75 e8                	jne    40000c30 <strncmp+0x20>
    if (n == 0)
        return 0;
    else
        return (int) ((unsigned char) *p - (unsigned char) *q);
40000c48:	0f b6 c2             	movzbl %dl,%eax
40000c4b:	29 d8                	sub    %ebx,%eax
}
40000c4d:	5b                   	pop    %ebx
40000c4e:	5e                   	pop    %esi
40000c4f:	c3                   	ret    
        return 0;
40000c50:	31 c0                	xor    %eax,%eax
}
40000c52:	5b                   	pop    %ebx
40000c53:	5e                   	pop    %esi
40000c54:	c3                   	ret    
40000c55:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000c60 <strchr>:

char *strchr(const char *s, char c)
{
40000c60:	8b 44 24 04          	mov    0x4(%esp),%eax
40000c64:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
    for (; *s; s++)
40000c69:	0f b6 10             	movzbl (%eax),%edx
40000c6c:	84 d2                	test   %dl,%dl
40000c6e:	75 13                	jne    40000c83 <strchr+0x23>
40000c70:	eb 1e                	jmp    40000c90 <strchr+0x30>
40000c72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000c78:	0f b6 50 01          	movzbl 0x1(%eax),%edx
40000c7c:	83 c0 01             	add    $0x1,%eax
40000c7f:	84 d2                	test   %dl,%dl
40000c81:	74 0d                	je     40000c90 <strchr+0x30>
        if (*s == c)
40000c83:	38 d1                	cmp    %dl,%cl
40000c85:	75 f1                	jne    40000c78 <strchr+0x18>
            return (char *) s;
    return 0;
}
40000c87:	c3                   	ret    
40000c88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000c8f:	90                   	nop
    return 0;
40000c90:	31 c0                	xor    %eax,%eax
}
40000c92:	c3                   	ret    
40000c93:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000ca0 <strfind>:

char *strfind(const char *s, char c)
{
40000ca0:	53                   	push   %ebx
40000ca1:	8b 44 24 08          	mov    0x8(%esp),%eax
40000ca5:	8b 54 24 0c          	mov    0xc(%esp),%edx
    for (; *s; s++)
40000ca9:	0f b6 18             	movzbl (%eax),%ebx
        if (*s == c)
40000cac:	38 d3                	cmp    %dl,%bl
40000cae:	74 1f                	je     40000ccf <strfind+0x2f>
40000cb0:	89 d1                	mov    %edx,%ecx
40000cb2:	84 db                	test   %bl,%bl
40000cb4:	75 0e                	jne    40000cc4 <strfind+0x24>
40000cb6:	eb 17                	jmp    40000ccf <strfind+0x2f>
40000cb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000cbf:	90                   	nop
40000cc0:	84 d2                	test   %dl,%dl
40000cc2:	74 0b                	je     40000ccf <strfind+0x2f>
    for (; *s; s++)
40000cc4:	0f b6 50 01          	movzbl 0x1(%eax),%edx
40000cc8:	83 c0 01             	add    $0x1,%eax
        if (*s == c)
40000ccb:	38 ca                	cmp    %cl,%dl
40000ccd:	75 f1                	jne    40000cc0 <strfind+0x20>
            break;
    return (char *) s;
}
40000ccf:	5b                   	pop    %ebx
40000cd0:	c3                   	ret    
40000cd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000cd8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000cdf:	90                   	nop

40000ce0 <strtol>:

long strtol(const char *s, char **endptr, int base)
{
40000ce0:	55                   	push   %ebp
40000ce1:	57                   	push   %edi
40000ce2:	56                   	push   %esi
40000ce3:	53                   	push   %ebx
40000ce4:	8b 54 24 14          	mov    0x14(%esp),%edx
40000ce8:	8b 74 24 18          	mov    0x18(%esp),%esi
40000cec:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
40000cf0:	0f b6 02             	movzbl (%edx),%eax
40000cf3:	3c 09                	cmp    $0x9,%al
40000cf5:	74 09                	je     40000d00 <strtol+0x20>
40000cf7:	3c 20                	cmp    $0x20,%al
40000cf9:	75 14                	jne    40000d0f <strtol+0x2f>
40000cfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000cff:	90                   	nop
40000d00:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        s++;
40000d04:	83 c2 01             	add    $0x1,%edx
    while (*s == ' ' || *s == '\t')
40000d07:	3c 20                	cmp    $0x20,%al
40000d09:	74 f5                	je     40000d00 <strtol+0x20>
40000d0b:	3c 09                	cmp    $0x9,%al
40000d0d:	74 f1                	je     40000d00 <strtol+0x20>

    // plus/minus sign
    if (*s == '+')
40000d0f:	3c 2b                	cmp    $0x2b,%al
40000d11:	0f 84 99 00 00 00    	je     40000db0 <strtol+0xd0>
    int neg = 0;
40000d17:	31 ff                	xor    %edi,%edi
        s++;
    else if (*s == '-')
40000d19:	3c 2d                	cmp    $0x2d,%al
40000d1b:	0f 84 7f 00 00 00    	je     40000da0 <strtol+0xc0>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000d21:	0f b6 2a             	movzbl (%edx),%ebp
40000d24:	f7 c3 ef ff ff ff    	test   $0xffffffef,%ebx
40000d2a:	75 13                	jne    40000d3f <strtol+0x5f>
40000d2c:	89 e8                	mov    %ebp,%eax
40000d2e:	3c 30                	cmp    $0x30,%al
40000d30:	0f 84 8a 00 00 00    	je     40000dc0 <strtol+0xe0>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
40000d36:	85 db                	test   %ebx,%ebx
40000d38:	75 05                	jne    40000d3f <strtol+0x5f>
        s++, base = 8;
    else if (base == 0)
        base = 10;
40000d3a:	bb 0a 00 00 00       	mov    $0xa,%ebx
40000d3f:	31 c9                	xor    %ecx,%ecx
40000d41:	eb 22                	jmp    40000d65 <strtol+0x85>
40000d43:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000d47:	90                   	nop
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
40000d48:	8d 45 9f             	lea    -0x61(%ebp),%eax
40000d4b:	3c 19                	cmp    $0x19,%al
40000d4d:	77 41                	ja     40000d90 <strtol+0xb0>
            dig = *s - 'a' + 10;
40000d4f:	8d 45 a9             	lea    -0x57(%ebp),%eax
40000d52:	0f be c0             	movsbl %al,%eax
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
40000d55:	39 d8                	cmp    %ebx,%eax
40000d57:	7d 1a                	jge    40000d73 <strtol+0x93>
            break;
        s++, val = (val * base) + dig;
40000d59:	0f af cb             	imul   %ebx,%ecx
        if (*s >= '0' && *s <= '9')
40000d5c:	0f b6 6a 01          	movzbl 0x1(%edx),%ebp
        s++, val = (val * base) + dig;
40000d60:	83 c2 01             	add    $0x1,%edx
40000d63:	01 c1                	add    %eax,%ecx
        if (*s >= '0' && *s <= '9')
40000d65:	8d 45 d0             	lea    -0x30(%ebp),%eax
40000d68:	3c 09                	cmp    $0x9,%al
40000d6a:	77 dc                	ja     40000d48 <strtol+0x68>
            dig = *s - 'A' + 10;
40000d6c:	0f be c0             	movsbl %al,%eax
        if (dig >= base)
40000d6f:	39 d8                	cmp    %ebx,%eax
40000d71:	7c e6                	jl     40000d59 <strtol+0x79>
        // we don't properly detect overflow!
    }

    if (endptr)
40000d73:	85 f6                	test   %esi,%esi
40000d75:	74 02                	je     40000d79 <strtol+0x99>
        *endptr = (char *) s;
40000d77:	89 16                	mov    %edx,(%esi)
    return (neg ? -val : val);
40000d79:	89 c8                	mov    %ecx,%eax
}
40000d7b:	5b                   	pop    %ebx
40000d7c:	5e                   	pop    %esi
    return (neg ? -val : val);
40000d7d:	f7 d8                	neg    %eax
40000d7f:	85 ff                	test   %edi,%edi
}
40000d81:	5f                   	pop    %edi
40000d82:	5d                   	pop    %ebp
    return (neg ? -val : val);
40000d83:	0f 45 c8             	cmovne %eax,%ecx
}
40000d86:	89 c8                	mov    %ecx,%eax
40000d88:	c3                   	ret    
40000d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        else if (*s >= 'A' && *s <= 'Z')
40000d90:	8d 45 bf             	lea    -0x41(%ebp),%eax
40000d93:	3c 19                	cmp    $0x19,%al
40000d95:	77 dc                	ja     40000d73 <strtol+0x93>
            dig = *s - 'A' + 10;
40000d97:	8d 45 c9             	lea    -0x37(%ebp),%eax
40000d9a:	0f be c0             	movsbl %al,%eax
40000d9d:	eb d0                	jmp    40000d6f <strtol+0x8f>
40000d9f:	90                   	nop
        s++, neg = 1;
40000da0:	83 c2 01             	add    $0x1,%edx
40000da3:	bf 01 00 00 00       	mov    $0x1,%edi
40000da8:	e9 74 ff ff ff       	jmp    40000d21 <strtol+0x41>
40000dad:	8d 76 00             	lea    0x0(%esi),%esi
        s++;
40000db0:	83 c2 01             	add    $0x1,%edx
    int neg = 0;
40000db3:	31 ff                	xor    %edi,%edi
40000db5:	e9 67 ff ff ff       	jmp    40000d21 <strtol+0x41>
40000dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000dc0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
40000dc4:	3c 78                	cmp    $0x78,%al
40000dc6:	74 17                	je     40000ddf <strtol+0xff>
    else if (base == 0 && s[0] == '0')
40000dc8:	85 db                	test   %ebx,%ebx
40000dca:	0f 85 6f ff ff ff    	jne    40000d3f <strtol+0x5f>
        s++, base = 8;
40000dd0:	83 c2 01             	add    $0x1,%edx
40000dd3:	89 c5                	mov    %eax,%ebp
40000dd5:	bb 08 00 00 00       	mov    $0x8,%ebx
40000dda:	e9 60 ff ff ff       	jmp    40000d3f <strtol+0x5f>
        if (*s >= '0' && *s <= '9')
40000ddf:	0f b6 6a 02          	movzbl 0x2(%edx),%ebp
        s += 2, base = 16;
40000de3:	bb 10 00 00 00       	mov    $0x10,%ebx
40000de8:	83 c2 02             	add    $0x2,%edx
40000deb:	e9 4f ff ff ff       	jmp    40000d3f <strtol+0x5f>

40000df0 <memset>:

void *memset(void *v, int c, size_t n)
{
40000df0:	57                   	push   %edi
40000df1:	56                   	push   %esi
40000df2:	53                   	push   %ebx
40000df3:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000df7:	8b 7c 24 10          	mov    0x10(%esp),%edi
    if (n == 0)
40000dfb:	85 c9                	test   %ecx,%ecx
40000dfd:	74 28                	je     40000e27 <memset+0x37>
        return v;
    if ((int) v % 4 == 0 && n % 4 == 0) {
40000dff:	89 f8                	mov    %edi,%eax
40000e01:	09 c8                	or     %ecx,%eax
40000e03:	a8 03                	test   $0x3,%al
40000e05:	75 29                	jne    40000e30 <memset+0x40>
        c &= 0xFF;
40000e07:	0f b6 5c 24 14       	movzbl 0x14(%esp),%ebx
        c = (c << 24) | (c << 16) | (c << 8) | c;
        asm volatile ("cld; rep stosl\n"
                      :: "D" (v), "a" (c), "c" (n / 4)
40000e0c:	c1 e9 02             	shr    $0x2,%ecx
        c = (c << 24) | (c << 16) | (c << 8) | c;
40000e0f:	89 da                	mov    %ebx,%edx
40000e11:	89 de                	mov    %ebx,%esi
40000e13:	89 d8                	mov    %ebx,%eax
40000e15:	c1 e2 18             	shl    $0x18,%edx
40000e18:	c1 e6 10             	shl    $0x10,%esi
40000e1b:	09 f2                	or     %esi,%edx
40000e1d:	c1 e0 08             	shl    $0x8,%eax
40000e20:	09 da                	or     %ebx,%edx
40000e22:	09 d0                	or     %edx,%eax
        asm volatile ("cld; rep stosl\n"
40000e24:	fc                   	cld    
40000e25:	f3 ab                	rep stos %eax,%es:(%edi)
    } else
        asm volatile ("cld; rep stosb\n"
                      :: "D" (v), "a" (c), "c" (n)
                      : "cc", "memory");
    return v;
}
40000e27:	89 f8                	mov    %edi,%eax
40000e29:	5b                   	pop    %ebx
40000e2a:	5e                   	pop    %esi
40000e2b:	5f                   	pop    %edi
40000e2c:	c3                   	ret    
40000e2d:	8d 76 00             	lea    0x0(%esi),%esi
        asm volatile ("cld; rep stosb\n"
40000e30:	8b 44 24 14          	mov    0x14(%esp),%eax
40000e34:	fc                   	cld    
40000e35:	f3 aa                	rep stos %al,%es:(%edi)
}
40000e37:	89 f8                	mov    %edi,%eax
40000e39:	5b                   	pop    %ebx
40000e3a:	5e                   	pop    %esi
40000e3b:	5f                   	pop    %edi
40000e3c:	c3                   	ret    
40000e3d:	8d 76 00             	lea    0x0(%esi),%esi

40000e40 <memmove>:

void *memmove(void *dst, const void *src, size_t n)
{
40000e40:	57                   	push   %edi
40000e41:	56                   	push   %esi
40000e42:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000e46:	8b 74 24 10          	mov    0x10(%esp),%esi
40000e4a:	8b 4c 24 14          	mov    0x14(%esp),%ecx
    const char *s;
    char *d;

    s = src;
    d = dst;
    if (s < d && s + n > d) {
40000e4e:	39 c6                	cmp    %eax,%esi
40000e50:	73 26                	jae    40000e78 <memmove+0x38>
40000e52:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
40000e55:	39 c2                	cmp    %eax,%edx
40000e57:	76 1f                	jbe    40000e78 <memmove+0x38>
        s += n;
        d += n;
40000e59:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
40000e5c:	89 d6                	mov    %edx,%esi
40000e5e:	09 fe                	or     %edi,%esi
40000e60:	09 ce                	or     %ecx,%esi
40000e62:	83 e6 03             	and    $0x3,%esi
40000e65:	74 39                	je     40000ea0 <memmove+0x60>
            asm volatile ("std; rep movsl\n"
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
                          : "cc", "memory");
        else
            asm volatile ("std; rep movsb\n"
                          :: "D" (d - 1), "S" (s - 1), "c" (n)
40000e67:	83 ef 01             	sub    $0x1,%edi
40000e6a:	8d 72 ff             	lea    -0x1(%edx),%esi
            asm volatile ("std; rep movsb\n"
40000e6d:	fd                   	std    
40000e6e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
                          : "cc", "memory");
        // Some versions of GCC rely on DF being clear
        asm volatile ("cld" ::: "cc");
40000e70:	fc                   	cld    
            asm volatile ("cld; rep movsb\n"
                          :: "D" (d), "S" (s), "c" (n)
                          : "cc", "memory");
    }
    return dst;
}
40000e71:	5e                   	pop    %esi
40000e72:	5f                   	pop    %edi
40000e73:	c3                   	ret    
40000e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
40000e78:	89 f2                	mov    %esi,%edx
40000e7a:	09 c2                	or     %eax,%edx
40000e7c:	09 ca                	or     %ecx,%edx
40000e7e:	83 e2 03             	and    $0x3,%edx
40000e81:	74 0d                	je     40000e90 <memmove+0x50>
            asm volatile ("cld; rep movsb\n"
40000e83:	89 c7                	mov    %eax,%edi
40000e85:	fc                   	cld    
40000e86:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
}
40000e88:	5e                   	pop    %esi
40000e89:	5f                   	pop    %edi
40000e8a:	c3                   	ret    
40000e8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000e8f:	90                   	nop
                          :: "D" (d), "S" (s), "c" (n / 4)
40000e90:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("cld; rep movsl\n"
40000e93:	89 c7                	mov    %eax,%edi
40000e95:	fc                   	cld    
40000e96:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000e98:	eb ee                	jmp    40000e88 <memmove+0x48>
40000e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
40000ea0:	83 ef 04             	sub    $0x4,%edi
40000ea3:	8d 72 fc             	lea    -0x4(%edx),%esi
40000ea6:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("std; rep movsl\n"
40000ea9:	fd                   	std    
40000eaa:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000eac:	eb c2                	jmp    40000e70 <memmove+0x30>
40000eae:	66 90                	xchg   %ax,%ax

40000eb0 <memcpy>:

void *memcpy(void *dst, const void *src, size_t n)
{
    return memmove(dst, src, n);
40000eb0:	eb 8e                	jmp    40000e40 <memmove>
40000eb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000ec0 <memcmp>:
}

int memcmp(const void *v1, const void *v2, size_t n)
{
40000ec0:	56                   	push   %esi
40000ec1:	53                   	push   %ebx
40000ec2:	8b 74 24 14          	mov    0x14(%esp),%esi
40000ec6:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000eca:	8b 44 24 10          	mov    0x10(%esp),%eax
    const uint8_t *s1 = (const uint8_t *) v1;
    const uint8_t *s2 = (const uint8_t *) v2;

    while (n-- > 0) {
40000ece:	85 f6                	test   %esi,%esi
40000ed0:	74 2e                	je     40000f00 <memcmp+0x40>
40000ed2:	01 c6                	add    %eax,%esi
40000ed4:	eb 14                	jmp    40000eea <memcmp+0x2a>
40000ed6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000edd:	8d 76 00             	lea    0x0(%esi),%esi
        if (*s1 != *s2)
            return (int) *s1 - (int) *s2;
        s1++, s2++;
40000ee0:	83 c0 01             	add    $0x1,%eax
40000ee3:	83 c2 01             	add    $0x1,%edx
    while (n-- > 0) {
40000ee6:	39 f0                	cmp    %esi,%eax
40000ee8:	74 16                	je     40000f00 <memcmp+0x40>
        if (*s1 != *s2)
40000eea:	0f b6 0a             	movzbl (%edx),%ecx
40000eed:	0f b6 18             	movzbl (%eax),%ebx
40000ef0:	38 d9                	cmp    %bl,%cl
40000ef2:	74 ec                	je     40000ee0 <memcmp+0x20>
            return (int) *s1 - (int) *s2;
40000ef4:	0f b6 c1             	movzbl %cl,%eax
40000ef7:	29 d8                	sub    %ebx,%eax
    }

    return 0;
}
40000ef9:	5b                   	pop    %ebx
40000efa:	5e                   	pop    %esi
40000efb:	c3                   	ret    
40000efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
40000f00:	31 c0                	xor    %eax,%eax
}
40000f02:	5b                   	pop    %ebx
40000f03:	5e                   	pop    %esi
40000f04:	c3                   	ret    
40000f05:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000f10 <memchr>:

void *memchr(const void *s, int c, size_t n)
{
40000f10:	8b 44 24 04          	mov    0x4(%esp),%eax
    const void *ends = (const char *) s + n;
40000f14:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000f18:	01 c2                	add    %eax,%edx
    for (; s < ends; s++)
40000f1a:	39 d0                	cmp    %edx,%eax
40000f1c:	73 1a                	jae    40000f38 <memchr+0x28>
        if (*(const unsigned char *) s == (unsigned char) c)
40000f1e:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
40000f23:	eb 0a                	jmp    40000f2f <memchr+0x1f>
40000f25:	8d 76 00             	lea    0x0(%esi),%esi
    for (; s < ends; s++)
40000f28:	83 c0 01             	add    $0x1,%eax
40000f2b:	39 c2                	cmp    %eax,%edx
40000f2d:	74 09                	je     40000f38 <memchr+0x28>
        if (*(const unsigned char *) s == (unsigned char) c)
40000f2f:	38 08                	cmp    %cl,(%eax)
40000f31:	75 f5                	jne    40000f28 <memchr+0x18>
            return (void *) s;
    return NULL;
}
40000f33:	c3                   	ret    
40000f34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return NULL;
40000f38:	31 c0                	xor    %eax,%eax
}
40000f3a:	c3                   	ret    
40000f3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000f3f:	90                   	nop

40000f40 <memzero>:

void *memzero(void *v, size_t n)
{
40000f40:	57                   	push   %edi
40000f41:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000f45:	8b 7c 24 08          	mov    0x8(%esp),%edi
    if (n == 0)
40000f49:	85 c9                	test   %ecx,%ecx
40000f4b:	74 0f                	je     40000f5c <memzero+0x1c>
    if ((int) v % 4 == 0 && n % 4 == 0) {
40000f4d:	89 f8                	mov    %edi,%eax
40000f4f:	09 c8                	or     %ecx,%eax
40000f51:	83 e0 03             	and    $0x3,%eax
40000f54:	75 0a                	jne    40000f60 <memzero+0x20>
                      :: "D" (v), "a" (c), "c" (n / 4)
40000f56:	c1 e9 02             	shr    $0x2,%ecx
        asm volatile ("cld; rep stosl\n"
40000f59:	fc                   	cld    
40000f5a:	f3 ab                	rep stos %eax,%es:(%edi)
    return memset(v, 0, n);
}
40000f5c:	89 f8                	mov    %edi,%eax
40000f5e:	5f                   	pop    %edi
40000f5f:	c3                   	ret    
        asm volatile ("cld; rep stosb\n"
40000f60:	31 c0                	xor    %eax,%eax
40000f62:	fc                   	cld    
40000f63:	f3 aa                	rep stos %al,%es:(%edi)
}
40000f65:	89 f8                	mov    %edi,%eax
40000f67:	5f                   	pop    %edi
40000f68:	c3                   	ret    
40000f69:	66 90                	xchg   %ax,%ax
40000f6b:	66 90                	xchg   %ax,%ax
40000f6d:	66 90                	xchg   %ax,%ax
40000f6f:	90                   	nop

40000f70 <__udivdi3>:
40000f70:	f3 0f 1e fb          	endbr32 
40000f74:	55                   	push   %ebp
40000f75:	57                   	push   %edi
40000f76:	56                   	push   %esi
40000f77:	53                   	push   %ebx
40000f78:	83 ec 1c             	sub    $0x1c,%esp
40000f7b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
40000f7f:	8b 6c 24 30          	mov    0x30(%esp),%ebp
40000f83:	8b 74 24 34          	mov    0x34(%esp),%esi
40000f87:	8b 5c 24 38          	mov    0x38(%esp),%ebx
40000f8b:	85 c0                	test   %eax,%eax
40000f8d:	75 19                	jne    40000fa8 <__udivdi3+0x38>
40000f8f:	39 f3                	cmp    %esi,%ebx
40000f91:	76 4d                	jbe    40000fe0 <__udivdi3+0x70>
40000f93:	31 ff                	xor    %edi,%edi
40000f95:	89 e8                	mov    %ebp,%eax
40000f97:	89 f2                	mov    %esi,%edx
40000f99:	f7 f3                	div    %ebx
40000f9b:	89 fa                	mov    %edi,%edx
40000f9d:	83 c4 1c             	add    $0x1c,%esp
40000fa0:	5b                   	pop    %ebx
40000fa1:	5e                   	pop    %esi
40000fa2:	5f                   	pop    %edi
40000fa3:	5d                   	pop    %ebp
40000fa4:	c3                   	ret    
40000fa5:	8d 76 00             	lea    0x0(%esi),%esi
40000fa8:	39 f0                	cmp    %esi,%eax
40000faa:	76 14                	jbe    40000fc0 <__udivdi3+0x50>
40000fac:	31 ff                	xor    %edi,%edi
40000fae:	31 c0                	xor    %eax,%eax
40000fb0:	89 fa                	mov    %edi,%edx
40000fb2:	83 c4 1c             	add    $0x1c,%esp
40000fb5:	5b                   	pop    %ebx
40000fb6:	5e                   	pop    %esi
40000fb7:	5f                   	pop    %edi
40000fb8:	5d                   	pop    %ebp
40000fb9:	c3                   	ret    
40000fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000fc0:	0f bd f8             	bsr    %eax,%edi
40000fc3:	83 f7 1f             	xor    $0x1f,%edi
40000fc6:	75 48                	jne    40001010 <__udivdi3+0xa0>
40000fc8:	39 f0                	cmp    %esi,%eax
40000fca:	72 06                	jb     40000fd2 <__udivdi3+0x62>
40000fcc:	31 c0                	xor    %eax,%eax
40000fce:	39 eb                	cmp    %ebp,%ebx
40000fd0:	77 de                	ja     40000fb0 <__udivdi3+0x40>
40000fd2:	b8 01 00 00 00       	mov    $0x1,%eax
40000fd7:	eb d7                	jmp    40000fb0 <__udivdi3+0x40>
40000fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000fe0:	89 d9                	mov    %ebx,%ecx
40000fe2:	85 db                	test   %ebx,%ebx
40000fe4:	75 0b                	jne    40000ff1 <__udivdi3+0x81>
40000fe6:	b8 01 00 00 00       	mov    $0x1,%eax
40000feb:	31 d2                	xor    %edx,%edx
40000fed:	f7 f3                	div    %ebx
40000fef:	89 c1                	mov    %eax,%ecx
40000ff1:	31 d2                	xor    %edx,%edx
40000ff3:	89 f0                	mov    %esi,%eax
40000ff5:	f7 f1                	div    %ecx
40000ff7:	89 c6                	mov    %eax,%esi
40000ff9:	89 e8                	mov    %ebp,%eax
40000ffb:	89 f7                	mov    %esi,%edi
40000ffd:	f7 f1                	div    %ecx
40000fff:	89 fa                	mov    %edi,%edx
40001001:	83 c4 1c             	add    $0x1c,%esp
40001004:	5b                   	pop    %ebx
40001005:	5e                   	pop    %esi
40001006:	5f                   	pop    %edi
40001007:	5d                   	pop    %ebp
40001008:	c3                   	ret    
40001009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40001010:	89 f9                	mov    %edi,%ecx
40001012:	ba 20 00 00 00       	mov    $0x20,%edx
40001017:	29 fa                	sub    %edi,%edx
40001019:	d3 e0                	shl    %cl,%eax
4000101b:	89 44 24 08          	mov    %eax,0x8(%esp)
4000101f:	89 d1                	mov    %edx,%ecx
40001021:	89 d8                	mov    %ebx,%eax
40001023:	d3 e8                	shr    %cl,%eax
40001025:	8b 4c 24 08          	mov    0x8(%esp),%ecx
40001029:	09 c1                	or     %eax,%ecx
4000102b:	89 f0                	mov    %esi,%eax
4000102d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
40001031:	89 f9                	mov    %edi,%ecx
40001033:	d3 e3                	shl    %cl,%ebx
40001035:	89 d1                	mov    %edx,%ecx
40001037:	d3 e8                	shr    %cl,%eax
40001039:	89 f9                	mov    %edi,%ecx
4000103b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
4000103f:	89 eb                	mov    %ebp,%ebx
40001041:	d3 e6                	shl    %cl,%esi
40001043:	89 d1                	mov    %edx,%ecx
40001045:	d3 eb                	shr    %cl,%ebx
40001047:	09 f3                	or     %esi,%ebx
40001049:	89 c6                	mov    %eax,%esi
4000104b:	89 f2                	mov    %esi,%edx
4000104d:	89 d8                	mov    %ebx,%eax
4000104f:	f7 74 24 08          	divl   0x8(%esp)
40001053:	89 d6                	mov    %edx,%esi
40001055:	89 c3                	mov    %eax,%ebx
40001057:	f7 64 24 0c          	mull   0xc(%esp)
4000105b:	39 d6                	cmp    %edx,%esi
4000105d:	72 19                	jb     40001078 <__udivdi3+0x108>
4000105f:	89 f9                	mov    %edi,%ecx
40001061:	d3 e5                	shl    %cl,%ebp
40001063:	39 c5                	cmp    %eax,%ebp
40001065:	73 04                	jae    4000106b <__udivdi3+0xfb>
40001067:	39 d6                	cmp    %edx,%esi
40001069:	74 0d                	je     40001078 <__udivdi3+0x108>
4000106b:	89 d8                	mov    %ebx,%eax
4000106d:	31 ff                	xor    %edi,%edi
4000106f:	e9 3c ff ff ff       	jmp    40000fb0 <__udivdi3+0x40>
40001074:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40001078:	8d 43 ff             	lea    -0x1(%ebx),%eax
4000107b:	31 ff                	xor    %edi,%edi
4000107d:	e9 2e ff ff ff       	jmp    40000fb0 <__udivdi3+0x40>
40001082:	66 90                	xchg   %ax,%ax
40001084:	66 90                	xchg   %ax,%ax
40001086:	66 90                	xchg   %ax,%ax
40001088:	66 90                	xchg   %ax,%ax
4000108a:	66 90                	xchg   %ax,%ax
4000108c:	66 90                	xchg   %ax,%ax
4000108e:	66 90                	xchg   %ax,%ax

40001090 <__umoddi3>:
40001090:	f3 0f 1e fb          	endbr32 
40001094:	55                   	push   %ebp
40001095:	57                   	push   %edi
40001096:	56                   	push   %esi
40001097:	53                   	push   %ebx
40001098:	83 ec 1c             	sub    $0x1c,%esp
4000109b:	8b 74 24 30          	mov    0x30(%esp),%esi
4000109f:	8b 5c 24 34          	mov    0x34(%esp),%ebx
400010a3:	8b 7c 24 3c          	mov    0x3c(%esp),%edi
400010a7:	8b 6c 24 38          	mov    0x38(%esp),%ebp
400010ab:	89 f0                	mov    %esi,%eax
400010ad:	89 da                	mov    %ebx,%edx
400010af:	85 ff                	test   %edi,%edi
400010b1:	75 15                	jne    400010c8 <__umoddi3+0x38>
400010b3:	39 dd                	cmp    %ebx,%ebp
400010b5:	76 39                	jbe    400010f0 <__umoddi3+0x60>
400010b7:	f7 f5                	div    %ebp
400010b9:	89 d0                	mov    %edx,%eax
400010bb:	31 d2                	xor    %edx,%edx
400010bd:	83 c4 1c             	add    $0x1c,%esp
400010c0:	5b                   	pop    %ebx
400010c1:	5e                   	pop    %esi
400010c2:	5f                   	pop    %edi
400010c3:	5d                   	pop    %ebp
400010c4:	c3                   	ret    
400010c5:	8d 76 00             	lea    0x0(%esi),%esi
400010c8:	39 df                	cmp    %ebx,%edi
400010ca:	77 f1                	ja     400010bd <__umoddi3+0x2d>
400010cc:	0f bd cf             	bsr    %edi,%ecx
400010cf:	83 f1 1f             	xor    $0x1f,%ecx
400010d2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
400010d6:	75 40                	jne    40001118 <__umoddi3+0x88>
400010d8:	39 df                	cmp    %ebx,%edi
400010da:	72 04                	jb     400010e0 <__umoddi3+0x50>
400010dc:	39 f5                	cmp    %esi,%ebp
400010de:	77 dd                	ja     400010bd <__umoddi3+0x2d>
400010e0:	89 da                	mov    %ebx,%edx
400010e2:	89 f0                	mov    %esi,%eax
400010e4:	29 e8                	sub    %ebp,%eax
400010e6:	19 fa                	sbb    %edi,%edx
400010e8:	eb d3                	jmp    400010bd <__umoddi3+0x2d>
400010ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
400010f0:	89 e9                	mov    %ebp,%ecx
400010f2:	85 ed                	test   %ebp,%ebp
400010f4:	75 0b                	jne    40001101 <__umoddi3+0x71>
400010f6:	b8 01 00 00 00       	mov    $0x1,%eax
400010fb:	31 d2                	xor    %edx,%edx
400010fd:	f7 f5                	div    %ebp
400010ff:	89 c1                	mov    %eax,%ecx
40001101:	89 d8                	mov    %ebx,%eax
40001103:	31 d2                	xor    %edx,%edx
40001105:	f7 f1                	div    %ecx
40001107:	89 f0                	mov    %esi,%eax
40001109:	f7 f1                	div    %ecx
4000110b:	89 d0                	mov    %edx,%eax
4000110d:	31 d2                	xor    %edx,%edx
4000110f:	eb ac                	jmp    400010bd <__umoddi3+0x2d>
40001111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40001118:	8b 44 24 04          	mov    0x4(%esp),%eax
4000111c:	ba 20 00 00 00       	mov    $0x20,%edx
40001121:	29 c2                	sub    %eax,%edx
40001123:	89 c1                	mov    %eax,%ecx
40001125:	89 e8                	mov    %ebp,%eax
40001127:	d3 e7                	shl    %cl,%edi
40001129:	89 d1                	mov    %edx,%ecx
4000112b:	89 54 24 0c          	mov    %edx,0xc(%esp)
4000112f:	d3 e8                	shr    %cl,%eax
40001131:	89 c1                	mov    %eax,%ecx
40001133:	8b 44 24 04          	mov    0x4(%esp),%eax
40001137:	09 f9                	or     %edi,%ecx
40001139:	89 df                	mov    %ebx,%edi
4000113b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
4000113f:	89 c1                	mov    %eax,%ecx
40001141:	d3 e5                	shl    %cl,%ebp
40001143:	89 d1                	mov    %edx,%ecx
40001145:	d3 ef                	shr    %cl,%edi
40001147:	89 c1                	mov    %eax,%ecx
40001149:	89 f0                	mov    %esi,%eax
4000114b:	d3 e3                	shl    %cl,%ebx
4000114d:	89 d1                	mov    %edx,%ecx
4000114f:	89 fa                	mov    %edi,%edx
40001151:	d3 e8                	shr    %cl,%eax
40001153:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
40001158:	09 d8                	or     %ebx,%eax
4000115a:	f7 74 24 08          	divl   0x8(%esp)
4000115e:	89 d3                	mov    %edx,%ebx
40001160:	d3 e6                	shl    %cl,%esi
40001162:	f7 e5                	mul    %ebp
40001164:	89 c7                	mov    %eax,%edi
40001166:	89 d1                	mov    %edx,%ecx
40001168:	39 d3                	cmp    %edx,%ebx
4000116a:	72 06                	jb     40001172 <__umoddi3+0xe2>
4000116c:	75 0e                	jne    4000117c <__umoddi3+0xec>
4000116e:	39 c6                	cmp    %eax,%esi
40001170:	73 0a                	jae    4000117c <__umoddi3+0xec>
40001172:	29 e8                	sub    %ebp,%eax
40001174:	1b 54 24 08          	sbb    0x8(%esp),%edx
40001178:	89 d1                	mov    %edx,%ecx
4000117a:	89 c7                	mov    %eax,%edi
4000117c:	89 f5                	mov    %esi,%ebp
4000117e:	8b 74 24 04          	mov    0x4(%esp),%esi
40001182:	29 fd                	sub    %edi,%ebp
40001184:	19 cb                	sbb    %ecx,%ebx
40001186:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
4000118b:	89 d8                	mov    %ebx,%eax
4000118d:	d3 e0                	shl    %cl,%eax
4000118f:	89 f1                	mov    %esi,%ecx
40001191:	d3 ed                	shr    %cl,%ebp
40001193:	d3 eb                	shr    %cl,%ebx
40001195:	09 e8                	or     %ebp,%eax
40001197:	89 da                	mov    %ebx,%edx
40001199:	83 c4 1c             	add    $0x1c,%esp
4000119c:	5b                   	pop    %ebx
4000119d:	5e                   	pop    %esi
4000119e:	5f                   	pop    %edi
4000119f:	5d                   	pop    %ebp
400011a0:	c3                   	ret    
