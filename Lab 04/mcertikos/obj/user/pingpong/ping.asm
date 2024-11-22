
obj/user/pingpong/ping:     file format elf32-i386


Disassembly of section .text:

40000000 <main>:
#include <proc.h>
#include <stdio.h>
#include <syscall.h>

int main(int argc, char **argv)
{
40000000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
40000004:	83 e4 f0             	and    $0xfffffff0,%esp
40000007:	ff 71 fc             	push   -0x4(%ecx)
4000000a:	55                   	push   %ebp
4000000b:	89 e5                	mov    %esp,%ebp
4000000d:	56                   	push   %esi
    unsigned int i;
    printf("ping started.\n");
4000000e:	be 0a 00 00 00       	mov    $0xa,%esi
{
40000013:	53                   	push   %ebx
40000014:	e8 3e 01 00 00       	call   40000157 <__x86.get_pc_thunk.bx>
40000019:	81 c3 e7 3f 00 00    	add    $0x3fe7,%ebx
4000001f:	51                   	push   %ecx
40000020:	83 ec 18             	sub    $0x18,%esp
    printf("ping started.\n");
40000023:	8d 83 94 e1 ff ff    	lea    -0x1e6c(%ebx),%eax
40000029:	50                   	push   %eax
4000002a:	e8 81 02 00 00       	call   400002b0 <printf>
4000002f:	83 c4 10             	add    $0x10,%esp
40000032:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

    // fast producing
    for (i = 0; i < 10; i++)
        produce();
40000038:	e8 63 0a 00 00       	call   40000aa0 <produce>
    for (i = 0; i < 10; i++)
4000003d:	83 ee 01             	sub    $0x1,%esi
40000040:	75 f6                	jne    40000038 <main+0x38>

    // slow producing
    for (i = 0; i < 40; i++) {
        if (i % 4 == 0)
40000042:	f7 c6 03 00 00 00    	test   $0x3,%esi
40000048:	74 16                	je     40000060 <main+0x60>
4000004a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for (i = 0; i < 40; i++) {
40000050:	83 c6 01             	add    $0x1,%esi
40000053:	83 fe 28             	cmp    $0x28,%esi
40000056:	74 15                	je     4000006d <main+0x6d>
        if (i % 4 == 0)
40000058:	f7 c6 03 00 00 00    	test   $0x3,%esi
4000005e:	75 f0                	jne    40000050 <main+0x50>
            produce();
40000060:	e8 3b 0a 00 00       	call   40000aa0 <produce>
    for (i = 0; i < 40; i++) {
40000065:	83 c6 01             	add    $0x1,%esi
40000068:	83 fe 28             	cmp    $0x28,%esi
4000006b:	75 eb                	jne    40000058 <main+0x58>
    }

    return 0;
}
4000006d:	8d 65 f4             	lea    -0xc(%ebp),%esp
40000070:	31 c0                	xor    %eax,%eax
40000072:	59                   	pop    %ecx
40000073:	5b                   	pop    %ebx
40000074:	5e                   	pop    %esi
40000075:	5d                   	pop    %ebp
40000076:	8d 61 fc             	lea    -0x4(%ecx),%esp
40000079:	c3                   	ret    

4000007a <_start>:
_start:
	/*
	 * If there are arguments on the stack, then the current stack will not
	 * be aligned to a nice big power-of-two boundary.
	 */
	testl	$0x0fffffff, %esp
4000007a:	f7 c4 ff ff ff 0f    	test   $0xfffffff,%esp
	jnz	args_exist
40000080:	75 04                	jne    40000086 <args_exist>

40000082 <noargs>:

noargs:
	/* If no arguments are on the stack, push two dummy zero. */
	pushl	$0
40000082:	6a 00                	push   $0x0
	pushl	$0
40000084:	6a 00                	push   $0x0

40000086 <args_exist>:

args_exist:
	/* Jump to the C part. */
	call	main
40000086:	e8 75 ff ff ff       	call   40000000 <main>

	/* When returning, push the return value on the stack. */
	pushl	%eax
4000008b:	50                   	push   %eax

4000008c <spin>:
spin:
	jmp	spin
4000008c:	eb fe                	jmp    4000008c <spin>
4000008e:	66 90                	xchg   %ax,%ax

40000090 <debug>:
#include <proc.h>
#include <stdarg.h>
#include <stdio.h>

void debug(const char *file, int line, const char *fmt, ...)
{
40000090:	53                   	push   %ebx
40000091:	e8 c1 00 00 00       	call   40000157 <__x86.get_pc_thunk.bx>
40000096:	81 c3 6a 3f 00 00    	add    $0x3f6a,%ebx
4000009c:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[D] %s:%d: ", file, line);
4000009f:	ff 74 24 18          	push   0x18(%esp)
400000a3:	ff 74 24 18          	push   0x18(%esp)
400000a7:	8d 83 00 e0 ff ff    	lea    -0x2000(%ebx),%eax
400000ad:	50                   	push   %eax
400000ae:	e8 fd 01 00 00       	call   400002b0 <printf>
    vcprintf(fmt, ap);
400000b3:	58                   	pop    %eax
400000b4:	5a                   	pop    %edx
400000b5:	8d 44 24 24          	lea    0x24(%esp),%eax
400000b9:	50                   	push   %eax
400000ba:	ff 74 24 24          	push   0x24(%esp)
400000be:	e8 8d 01 00 00       	call   40000250 <vcprintf>
    va_end(ap);
}
400000c3:	83 c4 18             	add    $0x18,%esp
400000c6:	5b                   	pop    %ebx
400000c7:	c3                   	ret    
400000c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400000cf:	90                   	nop

400000d0 <warn>:

void warn(const char *file, int line, const char *fmt, ...)
{
400000d0:	53                   	push   %ebx
400000d1:	e8 81 00 00 00       	call   40000157 <__x86.get_pc_thunk.bx>
400000d6:	81 c3 2a 3f 00 00    	add    $0x3f2a,%ebx
400000dc:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[W] %s:%d: ", file, line);
400000df:	ff 74 24 18          	push   0x18(%esp)
400000e3:	ff 74 24 18          	push   0x18(%esp)
400000e7:	8d 83 0c e0 ff ff    	lea    -0x1ff4(%ebx),%eax
400000ed:	50                   	push   %eax
400000ee:	e8 bd 01 00 00       	call   400002b0 <printf>
    vcprintf(fmt, ap);
400000f3:	58                   	pop    %eax
400000f4:	5a                   	pop    %edx
400000f5:	8d 44 24 24          	lea    0x24(%esp),%eax
400000f9:	50                   	push   %eax
400000fa:	ff 74 24 24          	push   0x24(%esp)
400000fe:	e8 4d 01 00 00       	call   40000250 <vcprintf>
    va_end(ap);
}
40000103:	83 c4 18             	add    $0x18,%esp
40000106:	5b                   	pop    %ebx
40000107:	c3                   	ret    
40000108:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000010f:	90                   	nop

40000110 <panic>:

void panic(const char *file, int line, const char *fmt, ...)
{
40000110:	53                   	push   %ebx
40000111:	e8 41 00 00 00       	call   40000157 <__x86.get_pc_thunk.bx>
40000116:	81 c3 ea 3e 00 00    	add    $0x3eea,%ebx
4000011c:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[P] %s:%d: ", file, line);
4000011f:	ff 74 24 18          	push   0x18(%esp)
40000123:	ff 74 24 18          	push   0x18(%esp)
40000127:	8d 83 18 e0 ff ff    	lea    -0x1fe8(%ebx),%eax
4000012d:	50                   	push   %eax
4000012e:	e8 7d 01 00 00       	call   400002b0 <printf>
    vcprintf(fmt, ap);
40000133:	58                   	pop    %eax
40000134:	5a                   	pop    %edx
40000135:	8d 44 24 24          	lea    0x24(%esp),%eax
40000139:	50                   	push   %eax
4000013a:	ff 74 24 24          	push   0x24(%esp)
4000013e:	e8 0d 01 00 00       	call   40000250 <vcprintf>
40000143:	83 c4 10             	add    $0x10,%esp
40000146:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000014d:	8d 76 00             	lea    0x0(%esi),%esi
    va_end(ap);

    while (1)
        yield();
40000150:	e8 3b 09 00 00       	call   40000a90 <yield>
    while (1)
40000155:	eb f9                	jmp    40000150 <panic+0x40>

40000157 <__x86.get_pc_thunk.bx>:
40000157:	8b 1c 24             	mov    (%esp),%ebx
4000015a:	c3                   	ret    
4000015b:	66 90                	xchg   %ax,%ax
4000015d:	66 90                	xchg   %ax,%ax
4000015f:	90                   	nop

40000160 <atoi>:
#include <stdlib.h>

int atoi(const char *buf, int *i)
{
40000160:	55                   	push   %ebp
40000161:	57                   	push   %edi
40000162:	56                   	push   %esi
40000163:	53                   	push   %ebx
    int loc = 0;
    int numstart = 0;
    int acc = 0;
    int negative = 0;
    if (buf[loc] == '+')
40000164:	8b 44 24 14          	mov    0x14(%esp),%eax
40000168:	0f b6 00             	movzbl (%eax),%eax
4000016b:	3c 2b                	cmp    $0x2b,%al
4000016d:	0f 84 85 00 00 00    	je     400001f8 <atoi+0x98>
    int negative = 0;
40000173:	31 ff                	xor    %edi,%edi
    int loc = 0;
40000175:	31 f6                	xor    %esi,%esi
        loc++;
    else if (buf[loc] == '-') {
40000177:	3c 2d                	cmp    $0x2d,%al
40000179:	74 55                	je     400001d0 <atoi+0x70>
        negative = 1;
        loc++;
    }
    numstart = loc;
    // no grab the numbers
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000017b:	8d 50 d0             	lea    -0x30(%eax),%edx
4000017e:	80 fa 09             	cmp    $0x9,%dl
40000181:	77 67                	ja     400001ea <atoi+0x8a>
40000183:	89 f2                	mov    %esi,%edx
    int acc = 0;
40000185:	31 c9                	xor    %ecx,%ecx
40000187:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000018e:	66 90                	xchg   %ax,%ax
        acc = acc * 10 + (buf[loc] - '0');
40000190:	83 e8 30             	sub    $0x30,%eax
40000193:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
        loc++;
40000196:	83 c2 01             	add    $0x1,%edx
        acc = acc * 10 + (buf[loc] - '0');
40000199:	0f be c0             	movsbl %al,%eax
4000019c:	8d 0c 48             	lea    (%eax,%ecx,2),%ecx
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000019f:	8b 44 24 14          	mov    0x14(%esp),%eax
400001a3:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
400001a7:	8d 68 d0             	lea    -0x30(%eax),%ebp
400001aa:	89 eb                	mov    %ebp,%ebx
400001ac:	80 fb 09             	cmp    $0x9,%bl
400001af:	76 df                	jbe    40000190 <atoi+0x30>
    }
    if (numstart == loc) {
400001b1:	39 d6                	cmp    %edx,%esi
400001b3:	74 35                	je     400001ea <atoi+0x8a>
        // no numbers have actually been scanned
        return 0;
    }
    if (negative)
        acc = -acc;
400001b5:	89 c8                	mov    %ecx,%eax
400001b7:	f7 d8                	neg    %eax
400001b9:	85 ff                	test   %edi,%edi
400001bb:	0f 45 c8             	cmovne %eax,%ecx
    *i = acc;
400001be:	8b 44 24 18          	mov    0x18(%esp),%eax
400001c2:	89 08                	mov    %ecx,(%eax)
    return loc;
}
400001c4:	89 d0                	mov    %edx,%eax
400001c6:	5b                   	pop    %ebx
400001c7:	5e                   	pop    %esi
400001c8:	5f                   	pop    %edi
400001c9:	5d                   	pop    %ebp
400001ca:	c3                   	ret    
400001cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400001cf:	90                   	nop
    while ('0' <= buf[loc] && buf[loc] <= '9') {
400001d0:	8b 44 24 14          	mov    0x14(%esp),%eax
        negative = 1;
400001d4:	bf 01 00 00 00       	mov    $0x1,%edi
        loc++;
400001d9:	be 01 00 00 00       	mov    $0x1,%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
400001de:	0f b6 40 01          	movzbl 0x1(%eax),%eax
400001e2:	8d 50 d0             	lea    -0x30(%eax),%edx
400001e5:	80 fa 09             	cmp    $0x9,%dl
400001e8:	76 99                	jbe    40000183 <atoi+0x23>
        return 0;
400001ea:	31 d2                	xor    %edx,%edx
}
400001ec:	5b                   	pop    %ebx
400001ed:	5e                   	pop    %esi
400001ee:	89 d0                	mov    %edx,%eax
400001f0:	5f                   	pop    %edi
400001f1:	5d                   	pop    %ebp
400001f2:	c3                   	ret    
400001f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400001f7:	90                   	nop
    while ('0' <= buf[loc] && buf[loc] <= '9') {
400001f8:	8b 44 24 14          	mov    0x14(%esp),%eax
    int negative = 0;
400001fc:	31 ff                	xor    %edi,%edi
        loc++;
400001fe:	be 01 00 00 00       	mov    $0x1,%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
40000203:	0f b6 40 01          	movzbl 0x1(%eax),%eax
40000207:	e9 6f ff ff ff       	jmp    4000017b <atoi+0x1b>
4000020c:	66 90                	xchg   %ax,%ax
4000020e:	66 90                	xchg   %ax,%ax

40000210 <putch>:
    int cnt;            // total bytes printed so far
    char buf[MAX_BUF];
};

static void putch(int ch, struct printbuf *b)
{
40000210:	53                   	push   %ebx
40000211:	8b 54 24 0c          	mov    0xc(%esp),%edx
    b->buf[b->idx++] = ch;
40000215:	0f b6 5c 24 08       	movzbl 0x8(%esp),%ebx
4000021a:	8b 02                	mov    (%edx),%eax
4000021c:	8d 48 01             	lea    0x1(%eax),%ecx
4000021f:	89 0a                	mov    %ecx,(%edx)
40000221:	88 5c 02 08          	mov    %bl,0x8(%edx,%eax,1)
    if (b->idx == MAX_BUF - 1) {
40000225:	81 f9 ff 01 00 00    	cmp    $0x1ff,%ecx
4000022b:	75 14                	jne    40000241 <putch+0x31>
        b->buf[b->idx] = 0;
4000022d:	c6 82 07 02 00 00 00 	movb   $0x0,0x207(%edx)
        puts(b->buf, b->idx);
40000234:	8d 5a 08             	lea    0x8(%edx),%ebx
#include <types.h>
#include <x86.h>

static gcc_inline void sys_puts(const char *s, size_t len)
{
    asm volatile ("int %0"
40000237:	31 c0                	xor    %eax,%eax
40000239:	cd 30                	int    $0x30
        b->idx = 0;
4000023b:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
    }
    b->cnt++;
40000241:	83 42 04 01          	addl   $0x1,0x4(%edx)
}
40000245:	5b                   	pop    %ebx
40000246:	c3                   	ret    
40000247:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000024e:	66 90                	xchg   %ax,%ax

40000250 <vcprintf>:

int vcprintf(const char *fmt, va_list ap)
{
40000250:	53                   	push   %ebx
40000251:	e8 01 ff ff ff       	call   40000157 <__x86.get_pc_thunk.bx>
40000256:	81 c3 aa 3d 00 00    	add    $0x3daa,%ebx
4000025c:	81 ec 18 02 00 00    	sub    $0x218,%esp
    struct printbuf b;

    b.idx = 0;
40000262:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
40000269:	00 
    b.cnt = 0;
4000026a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000271:	00 
    vprintfmt((void *) putch, &b, fmt, ap);
40000272:	ff b4 24 24 02 00 00 	push   0x224(%esp)
40000279:	ff b4 24 24 02 00 00 	push   0x224(%esp)
40000280:	8d 44 24 10          	lea    0x10(%esp),%eax
40000284:	50                   	push   %eax
40000285:	8d 83 10 c2 ff ff    	lea    -0x3df0(%ebx),%eax
4000028b:	50                   	push   %eax
4000028c:	e8 3f 01 00 00       	call   400003d0 <vprintfmt>

    b.buf[b.idx] = 0;
40000291:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000295:	8d 5c 24 20          	lea    0x20(%esp),%ebx
40000299:	31 c0                	xor    %eax,%eax
4000029b:	c6 44 0c 20 00       	movb   $0x0,0x20(%esp,%ecx,1)
400002a0:	cd 30                	int    $0x30
    puts(b.buf, b.idx);

    return b.cnt;
}
400002a2:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400002a6:	81 c4 28 02 00 00    	add    $0x228,%esp
400002ac:	5b                   	pop    %ebx
400002ad:	c3                   	ret    
400002ae:	66 90                	xchg   %ax,%ax

400002b0 <printf>:

int printf(const char *fmt, ...)
{
400002b0:	83 ec 14             	sub    $0x14,%esp
    va_list ap;
    int cnt;

    va_start(ap, fmt);
    cnt = vcprintf(fmt, ap);
400002b3:	8d 44 24 1c          	lea    0x1c(%esp),%eax
400002b7:	50                   	push   %eax
400002b8:	ff 74 24 1c          	push   0x1c(%esp)
400002bc:	e8 8f ff ff ff       	call   40000250 <vcprintf>
    va_end(ap);

    return cnt;
}
400002c1:	83 c4 1c             	add    $0x1c,%esp
400002c4:	c3                   	ret    
400002c5:	66 90                	xchg   %ax,%ax
400002c7:	66 90                	xchg   %ax,%ax
400002c9:	66 90                	xchg   %ax,%ax
400002cb:	66 90                	xchg   %ax,%ax
400002cd:	66 90                	xchg   %ax,%ax
400002cf:	90                   	nop

400002d0 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void *), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
400002d0:	e8 96 07 00 00       	call   40000a6b <__x86.get_pc_thunk.cx>
400002d5:	81 c1 2b 3d 00 00    	add    $0x3d2b,%ecx
400002db:	55                   	push   %ebp
400002dc:	57                   	push   %edi
400002dd:	89 d7                	mov    %edx,%edi
400002df:	56                   	push   %esi
400002e0:	89 c6                	mov    %eax,%esi
400002e2:	53                   	push   %ebx
400002e3:	83 ec 2c             	sub    $0x2c,%esp
400002e6:	8b 54 24 44          	mov    0x44(%esp),%edx
400002ea:	8b 44 24 40          	mov    0x40(%esp),%eax
400002ee:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, num / base, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (--width > 0)
400002f2:	8b 4c 24 4c          	mov    0x4c(%esp),%ecx
{
400002f6:	8b 5c 24 50          	mov    0x50(%esp),%ebx
    if (num >= base) {
400002fa:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
40000301:	00 
{
40000302:	89 54 24 0c          	mov    %edx,0xc(%esp)
40000306:	8b 54 24 48          	mov    0x48(%esp),%edx
4000030a:	89 44 24 08          	mov    %eax,0x8(%esp)
    if (num >= base) {
4000030e:	8b 44 24 0c          	mov    0xc(%esp),%eax
        while (--width > 0)
40000312:	8d 69 ff             	lea    -0x1(%ecx),%ebp
    if (num >= base) {
40000315:	39 54 24 08          	cmp    %edx,0x8(%esp)
40000319:	1b 44 24 14          	sbb    0x14(%esp),%eax
4000031d:	89 54 24 10          	mov    %edx,0x10(%esp)
40000321:	73 55                	jae    40000378 <printnum+0xa8>
        while (--width > 0)
40000323:	85 ed                	test   %ebp,%ebp
40000325:	7e 18                	jle    4000033f <printnum+0x6f>
40000327:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000032e:	66 90                	xchg   %ax,%ax
            putch(padc, putdat);
40000330:	83 ec 08             	sub    $0x8,%esp
40000333:	57                   	push   %edi
40000334:	53                   	push   %ebx
40000335:	ff d6                	call   *%esi
        while (--width > 0)
40000337:	83 c4 10             	add    $0x10,%esp
4000033a:	83 ed 01             	sub    $0x1,%ebp
4000033d:	75 f1                	jne    40000330 <printnum+0x60>
    }

    // then print this (the least significant) digit
    putch("0123456789abcdef"[num % base], putdat);
4000033f:	89 7c 24 44          	mov    %edi,0x44(%esp)
40000343:	ff 74 24 14          	push   0x14(%esp)
40000347:	ff 74 24 14          	push   0x14(%esp)
4000034b:	ff 74 24 14          	push   0x14(%esp)
4000034f:	ff 74 24 14          	push   0x14(%esp)
40000353:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
40000357:	e8 a4 0d 00 00       	call   40001100 <__umoddi3>
4000035c:	0f be 84 03 24 e0 ff 	movsbl -0x1fdc(%ebx,%eax,1),%eax
40000363:	ff 
40000364:	89 44 24 50          	mov    %eax,0x50(%esp)
}
40000368:	83 c4 3c             	add    $0x3c,%esp
    putch("0123456789abcdef"[num % base], putdat);
4000036b:	89 f0                	mov    %esi,%eax
}
4000036d:	5b                   	pop    %ebx
4000036e:	5e                   	pop    %esi
4000036f:	5f                   	pop    %edi
40000370:	5d                   	pop    %ebp
    putch("0123456789abcdef"[num % base], putdat);
40000371:	ff e0                	jmp    *%eax
40000373:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000377:	90                   	nop
        printnum(putch, putdat, num / base, base, width - 1, padc);
40000378:	83 ec 0c             	sub    $0xc,%esp
4000037b:	53                   	push   %ebx
4000037c:	55                   	push   %ebp
4000037d:	52                   	push   %edx
4000037e:	83 ec 08             	sub    $0x8,%esp
40000381:	ff 74 24 34          	push   0x34(%esp)
40000385:	ff 74 24 34          	push   0x34(%esp)
40000389:	ff 74 24 34          	push   0x34(%esp)
4000038d:	ff 74 24 34          	push   0x34(%esp)
40000391:	8b 5c 24 4c          	mov    0x4c(%esp),%ebx
40000395:	e8 46 0c 00 00       	call   40000fe0 <__udivdi3>
4000039a:	83 c4 18             	add    $0x18,%esp
4000039d:	52                   	push   %edx
4000039e:	89 fa                	mov    %edi,%edx
400003a0:	50                   	push   %eax
400003a1:	89 f0                	mov    %esi,%eax
400003a3:	e8 28 ff ff ff       	call   400002d0 <printnum>
400003a8:	83 c4 20             	add    $0x20,%esp
400003ab:	eb 92                	jmp    4000033f <printnum+0x6f>
400003ad:	8d 76 00             	lea    0x0(%esi),%esi

400003b0 <sprintputch>:
    char *ebuf;
    int cnt;
};

static void sprintputch(int ch, struct sprintbuf *b)
{
400003b0:	8b 44 24 08          	mov    0x8(%esp),%eax
    b->cnt++;
400003b4:	83 40 08 01          	addl   $0x1,0x8(%eax)
    if (b->buf < b->ebuf)
400003b8:	8b 10                	mov    (%eax),%edx
400003ba:	3b 50 04             	cmp    0x4(%eax),%edx
400003bd:	73 0b                	jae    400003ca <sprintputch+0x1a>
        *b->buf++ = ch;
400003bf:	8d 4a 01             	lea    0x1(%edx),%ecx
400003c2:	89 08                	mov    %ecx,(%eax)
400003c4:	8b 44 24 04          	mov    0x4(%esp),%eax
400003c8:	88 02                	mov    %al,(%edx)
}
400003ca:	c3                   	ret    
400003cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400003cf:	90                   	nop

400003d0 <vprintfmt>:
{
400003d0:	e8 8e 06 00 00       	call   40000a63 <__x86.get_pc_thunk.ax>
400003d5:	05 2b 3c 00 00       	add    $0x3c2b,%eax
400003da:	55                   	push   %ebp
400003db:	57                   	push   %edi
400003dc:	56                   	push   %esi
400003dd:	53                   	push   %ebx
400003de:	83 ec 3c             	sub    $0x3c,%esp
400003e1:	8b 74 24 50          	mov    0x50(%esp),%esi
400003e5:	8b 6c 24 54          	mov    0x54(%esp),%ebp
400003e9:	89 44 24 14          	mov    %eax,0x14(%esp)
                for (width -= strnlen(p, precision); width > 0; width--)
400003ed:	8d 80 35 e0 ff ff    	lea    -0x1fcb(%eax),%eax
400003f3:	89 44 24 24          	mov    %eax,0x24(%esp)
{
400003f7:	8b 7c 24 58          	mov    0x58(%esp),%edi
        while ((ch = *(unsigned char *) fmt++) != '%') {
400003fb:	0f b6 07             	movzbl (%edi),%eax
400003fe:	8d 5f 01             	lea    0x1(%edi),%ebx
40000401:	83 f8 25             	cmp    $0x25,%eax
40000404:	75 20                	jne    40000426 <vprintfmt+0x56>
40000406:	eb 30                	jmp    40000438 <vprintfmt+0x68>
40000408:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000040f:	90                   	nop
            putch(ch, putdat);
40000410:	83 ec 08             	sub    $0x8,%esp
        while ((ch = *(unsigned char *) fmt++) != '%') {
40000413:	83 c3 01             	add    $0x1,%ebx
            putch(ch, putdat);
40000416:	55                   	push   %ebp
40000417:	50                   	push   %eax
40000418:	ff d6                	call   *%esi
        while ((ch = *(unsigned char *) fmt++) != '%') {
4000041a:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
4000041e:	83 c4 10             	add    $0x10,%esp
40000421:	83 f8 25             	cmp    $0x25,%eax
40000424:	74 12                	je     40000438 <vprintfmt+0x68>
            if (ch == '\0')
40000426:	85 c0                	test   %eax,%eax
40000428:	75 e6                	jne    40000410 <vprintfmt+0x40>
}
4000042a:	83 c4 3c             	add    $0x3c,%esp
4000042d:	5b                   	pop    %ebx
4000042e:	5e                   	pop    %esi
4000042f:	5f                   	pop    %edi
40000430:	5d                   	pop    %ebp
40000431:	c3                   	ret    
40000432:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        precision = -1;
40000438:	ba ff ff ff ff       	mov    $0xffffffff,%edx
        padc = ' ';
4000043d:	c6 44 24 18 20       	movb   $0x20,0x18(%esp)
        altflag = 0;
40000442:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
40000449:	00 
        width = -1;
4000044a:	c7 44 24 10 ff ff ff 	movl   $0xffffffff,0x10(%esp)
40000451:	ff 
        lflag = 0;
40000452:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%esp)
40000459:	00 
4000045a:	89 54 24 1c          	mov    %edx,0x1c(%esp)
4000045e:	89 74 24 50          	mov    %esi,0x50(%esp)
        switch (ch = *(unsigned char *) fmt++) {
40000462:	0f b6 0b             	movzbl (%ebx),%ecx
40000465:	8d 7b 01             	lea    0x1(%ebx),%edi
40000468:	8d 41 dd             	lea    -0x23(%ecx),%eax
4000046b:	3c 55                	cmp    $0x55,%al
4000046d:	77 19                	ja     40000488 <.L20>
4000046f:	8b 54 24 14          	mov    0x14(%esp),%edx
40000473:	0f b6 c0             	movzbl %al,%eax
40000476:	8b b4 82 3c e0 ff ff 	mov    -0x1fc4(%edx,%eax,4),%esi
4000047d:	01 d6                	add    %edx,%esi
4000047f:	ff e6                	jmp    *%esi
40000481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000488 <.L20>:
            putch('%', putdat);
40000488:	8b 74 24 50          	mov    0x50(%esp),%esi
4000048c:	83 ec 08             	sub    $0x8,%esp
            for (fmt--; fmt[-1] != '%'; fmt--)
4000048f:	89 df                	mov    %ebx,%edi
            putch('%', putdat);
40000491:	55                   	push   %ebp
40000492:	6a 25                	push   $0x25
40000494:	ff d6                	call   *%esi
            for (fmt--; fmt[-1] != '%'; fmt--)
40000496:	83 c4 10             	add    $0x10,%esp
40000499:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
4000049d:	0f 84 58 ff ff ff    	je     400003fb <vprintfmt+0x2b>
400004a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400004a7:	90                   	nop
400004a8:	83 ef 01             	sub    $0x1,%edi
400004ab:	80 7f ff 25          	cmpb   $0x25,-0x1(%edi)
400004af:	75 f7                	jne    400004a8 <.L20+0x20>
400004b1:	e9 45 ff ff ff       	jmp    400003fb <vprintfmt+0x2b>
400004b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400004bd:	8d 76 00             	lea    0x0(%esi),%esi

400004c0 <.L30>:
                ch = *fmt;
400004c0:	0f be 43 01          	movsbl 0x1(%ebx),%eax
                precision = precision * 10 + ch - '0';
400004c4:	8d 51 d0             	lea    -0x30(%ecx),%edx
        switch (ch = *(unsigned char *) fmt++) {
400004c7:	89 fb                	mov    %edi,%ebx
                precision = precision * 10 + ch - '0';
400004c9:	89 54 24 1c          	mov    %edx,0x1c(%esp)
                if (ch < '0' || ch > '9')
400004cd:	8d 48 d0             	lea    -0x30(%eax),%ecx
400004d0:	83 f9 09             	cmp    $0x9,%ecx
400004d3:	77 28                	ja     400004fd <.L30+0x3d>
        switch (ch = *(unsigned char *) fmt++) {
400004d5:	8b 74 24 50          	mov    0x50(%esp),%esi
400004d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            for (precision = 0;; ++fmt) {
400004e0:	83 c3 01             	add    $0x1,%ebx
                precision = precision * 10 + ch - '0';
400004e3:	8d 14 92             	lea    (%edx,%edx,4),%edx
400004e6:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
                ch = *fmt;
400004ea:	0f be 03             	movsbl (%ebx),%eax
                if (ch < '0' || ch > '9')
400004ed:	8d 48 d0             	lea    -0x30(%eax),%ecx
400004f0:	83 f9 09             	cmp    $0x9,%ecx
400004f3:	76 eb                	jbe    400004e0 <.L30+0x20>
400004f5:	89 54 24 1c          	mov    %edx,0x1c(%esp)
400004f9:	89 74 24 50          	mov    %esi,0x50(%esp)
            if (width < 0)
400004fd:	8b 74 24 10          	mov    0x10(%esp),%esi
40000501:	85 f6                	test   %esi,%esi
40000503:	0f 89 59 ff ff ff    	jns    40000462 <vprintfmt+0x92>
                width = precision, precision = -1;
40000509:	8b 44 24 1c          	mov    0x1c(%esp),%eax
4000050d:	c7 44 24 1c ff ff ff 	movl   $0xffffffff,0x1c(%esp)
40000514:	ff 
40000515:	89 44 24 10          	mov    %eax,0x10(%esp)
40000519:	e9 44 ff ff ff       	jmp    40000462 <vprintfmt+0x92>

4000051e <.L35>:
            altflag = 1;
4000051e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
40000525:	00 
        switch (ch = *(unsigned char *) fmt++) {
40000526:	89 fb                	mov    %edi,%ebx
            goto reswitch;
40000528:	e9 35 ff ff ff       	jmp    40000462 <vprintfmt+0x92>

4000052d <.L34>:
            putch(ch, putdat);
4000052d:	8b 74 24 50          	mov    0x50(%esp),%esi
40000531:	83 ec 08             	sub    $0x8,%esp
40000534:	55                   	push   %ebp
40000535:	6a 25                	push   $0x25
40000537:	ff d6                	call   *%esi
            break;
40000539:	83 c4 10             	add    $0x10,%esp
4000053c:	e9 ba fe ff ff       	jmp    400003fb <vprintfmt+0x2b>

40000541 <.L33>:
            precision = va_arg(ap, int);
40000541:	8b 44 24 5c          	mov    0x5c(%esp),%eax
        switch (ch = *(unsigned char *) fmt++) {
40000545:	89 fb                	mov    %edi,%ebx
            precision = va_arg(ap, int);
40000547:	8b 00                	mov    (%eax),%eax
40000549:	89 44 24 1c          	mov    %eax,0x1c(%esp)
4000054d:	8b 44 24 5c          	mov    0x5c(%esp),%eax
40000551:	83 c0 04             	add    $0x4,%eax
40000554:	89 44 24 5c          	mov    %eax,0x5c(%esp)
            goto process_precision;
40000558:	eb a3                	jmp    400004fd <.L30+0x3d>

4000055a <.L32>:
            if (width < 0)
4000055a:	8b 4c 24 10          	mov    0x10(%esp),%ecx
4000055e:	31 c0                	xor    %eax,%eax
        switch (ch = *(unsigned char *) fmt++) {
40000560:	89 fb                	mov    %edi,%ebx
40000562:	85 c9                	test   %ecx,%ecx
40000564:	0f 49 c1             	cmovns %ecx,%eax
40000567:	89 44 24 10          	mov    %eax,0x10(%esp)
            goto reswitch;
4000056b:	e9 f2 fe ff ff       	jmp    40000462 <vprintfmt+0x92>

40000570 <.L29>:
            putch(va_arg(ap, int), putdat);
40000570:	8b 44 24 5c          	mov    0x5c(%esp),%eax
40000574:	8b 74 24 50          	mov    0x50(%esp),%esi
40000578:	83 ec 08             	sub    $0x8,%esp
4000057b:	55                   	push   %ebp
4000057c:	8d 58 04             	lea    0x4(%eax),%ebx
4000057f:	8b 44 24 68          	mov    0x68(%esp),%eax
40000583:	ff 30                	push   (%eax)
40000585:	ff d6                	call   *%esi
40000587:	89 5c 24 6c          	mov    %ebx,0x6c(%esp)
            break;
4000058b:	83 c4 10             	add    $0x10,%esp
4000058e:	e9 68 fe ff ff       	jmp    400003fb <vprintfmt+0x2b>

40000593 <.L23>:
    if (lflag >= 2)
40000593:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
40000598:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, unsigned long long);
4000059c:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
400005a0:	0f 8f d7 01 00 00    	jg     4000077d <.L24+0xe0>
        return va_arg(*ap, unsigned long);
400005a6:	8b 4c 24 5c          	mov    0x5c(%esp),%ecx
            precision = va_arg(ap, int);
400005aa:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
400005ad:	31 db                	xor    %ebx,%ebx
400005af:	ba 0a 00 00 00       	mov    $0xa,%edx
400005b4:	8b 09                	mov    (%ecx),%ecx
400005b6:	89 44 24 5c          	mov    %eax,0x5c(%esp)
400005ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            printnum(putch, putdat, num, base, width, padc);
400005c0:	83 ec 0c             	sub    $0xc,%esp
400005c3:	0f be 44 24 24       	movsbl 0x24(%esp),%eax
400005c8:	50                   	push   %eax
400005c9:	89 f0                	mov    %esi,%eax
400005cb:	ff 74 24 20          	push   0x20(%esp)
400005cf:	52                   	push   %edx
400005d0:	89 ea                	mov    %ebp,%edx
400005d2:	53                   	push   %ebx
400005d3:	51                   	push   %ecx
400005d4:	e8 f7 fc ff ff       	call   400002d0 <printnum>
            break;
400005d9:	83 c4 20             	add    $0x20,%esp
400005dc:	e9 1a fe ff ff       	jmp    400003fb <vprintfmt+0x2b>

400005e1 <.L25>:
            putch('0', putdat);
400005e1:	8b 74 24 50          	mov    0x50(%esp),%esi
400005e5:	83 ec 08             	sub    $0x8,%esp
400005e8:	55                   	push   %ebp
400005e9:	6a 30                	push   $0x30
400005eb:	ff d6                	call   *%esi
            putch('x', putdat);
400005ed:	59                   	pop    %ecx
400005ee:	5b                   	pop    %ebx
400005ef:	55                   	push   %ebp
400005f0:	6a 78                	push   $0x78
            num = (unsigned long long)
400005f2:	31 db                	xor    %ebx,%ebx
            putch('x', putdat);
400005f4:	ff d6                	call   *%esi
            num = (unsigned long long)
400005f6:	8b 44 24 6c          	mov    0x6c(%esp),%eax
            goto number;
400005fa:	ba 10 00 00 00       	mov    $0x10,%edx
            num = (unsigned long long)
400005ff:	8b 08                	mov    (%eax),%ecx
            goto number;
40000601:	83 c4 10             	add    $0x10,%esp
                (uintptr_t) va_arg(ap, void *);
40000604:	83 c0 04             	add    $0x4,%eax
40000607:	89 44 24 5c          	mov    %eax,0x5c(%esp)
            goto number;
4000060b:	eb b3                	jmp    400005c0 <.L23+0x2d>

4000060d <.L21>:
    if (lflag >= 2)
4000060d:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
40000612:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, unsigned long long);
40000616:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
4000061a:	0f 8f 6e 01 00 00    	jg     4000078e <.L24+0xf1>
        return va_arg(*ap, unsigned long);
40000620:	8b 4c 24 5c          	mov    0x5c(%esp),%ecx
            precision = va_arg(ap, int);
40000624:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
40000627:	31 db                	xor    %ebx,%ebx
40000629:	ba 10 00 00 00       	mov    $0x10,%edx
4000062e:	8b 09                	mov    (%ecx),%ecx
40000630:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000634:	eb 8a                	jmp    400005c0 <.L23+0x2d>

40000636 <.L28>:
    if (lflag >= 2)
40000636:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
4000063b:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, long long);
4000063f:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
40000643:	0f 8f 5b 01 00 00    	jg     400007a4 <.L24+0x107>
        return va_arg(*ap, long);
40000649:	8b 00                	mov    (%eax),%eax
4000064b:	89 c3                	mov    %eax,%ebx
4000064d:	89 c1                	mov    %eax,%ecx
4000064f:	8b 44 24 5c          	mov    0x5c(%esp),%eax
40000653:	c1 fb 1f             	sar    $0x1f,%ebx
40000656:	83 c0 04             	add    $0x4,%eax
40000659:	89 44 24 5c          	mov    %eax,0x5c(%esp)
            if ((long long) num < 0) {
4000065d:	85 db                	test   %ebx,%ebx
4000065f:	0f 88 68 01 00 00    	js     400007cd <.L31+0xc>
        return va_arg(*ap, unsigned long long);
40000665:	ba 0a 00 00 00       	mov    $0xa,%edx
4000066a:	e9 51 ff ff ff       	jmp    400005c0 <.L23+0x2d>

4000066f <.L27>:
            lflag++;
4000066f:	83 44 24 20 01       	addl   $0x1,0x20(%esp)
        switch (ch = *(unsigned char *) fmt++) {
40000674:	89 fb                	mov    %edi,%ebx
            goto reswitch;
40000676:	e9 e7 fd ff ff       	jmp    40000462 <vprintfmt+0x92>

4000067b <.L26>:
            putch('X', putdat);
4000067b:	8b 74 24 50          	mov    0x50(%esp),%esi
4000067f:	83 ec 08             	sub    $0x8,%esp
40000682:	55                   	push   %ebp
40000683:	6a 58                	push   $0x58
40000685:	ff d6                	call   *%esi
            putch('X', putdat);
40000687:	58                   	pop    %eax
40000688:	5a                   	pop    %edx
40000689:	55                   	push   %ebp
4000068a:	6a 58                	push   $0x58
4000068c:	ff d6                	call   *%esi
            putch('X', putdat);
4000068e:	59                   	pop    %ecx
4000068f:	5b                   	pop    %ebx
40000690:	55                   	push   %ebp
40000691:	6a 58                	push   $0x58
40000693:	ff d6                	call   *%esi
            break;
40000695:	83 c4 10             	add    $0x10,%esp
40000698:	e9 5e fd ff ff       	jmp    400003fb <vprintfmt+0x2b>

4000069d <.L24>:
            if ((p = va_arg(ap, char *)) == NULL)
4000069d:	8b 44 24 5c          	mov    0x5c(%esp),%eax
            if (width > 0 && padc != '-')
400006a1:	8b 5c 24 10          	mov    0x10(%esp),%ebx
            if ((p = va_arg(ap, char *)) == NULL)
400006a5:	8b 54 24 1c          	mov    0x1c(%esp),%edx
400006a9:	8b 74 24 50          	mov    0x50(%esp),%esi
400006ad:	83 c0 04             	add    $0x4,%eax
            if (width > 0 && padc != '-')
400006b0:	80 7c 24 18 2d       	cmpb   $0x2d,0x18(%esp)
            if ((p = va_arg(ap, char *)) == NULL)
400006b5:	89 44 24 1c          	mov    %eax,0x1c(%esp)
400006b9:	8b 44 24 5c          	mov    0x5c(%esp),%eax
400006bd:	8b 08                	mov    (%eax),%ecx
            if (width > 0 && padc != '-')
400006bf:	0f 95 c0             	setne  %al
400006c2:	85 db                	test   %ebx,%ebx
400006c4:	0f 9f c3             	setg   %bl
400006c7:	21 d8                	and    %ebx,%eax
            if ((p = va_arg(ap, char *)) == NULL)
400006c9:	85 c9                	test   %ecx,%ecx
400006cb:	0f 84 28 01 00 00    	je     400007f9 <.L31+0x38>
                 (ch = *p++) != '\0' && (precision < 0
400006d1:	8d 59 01             	lea    0x1(%ecx),%ebx
400006d4:	89 5c 24 20          	mov    %ebx,0x20(%esp)
            if (width > 0 && padc != '-')
400006d8:	84 c0                	test   %al,%al
400006da:	0f 85 48 01 00 00    	jne    40000828 <.L31+0x67>
                 (ch = *p++) != '\0' && (precision < 0
400006e0:	0f be 09             	movsbl (%ecx),%ecx
400006e3:	89 c8                	mov    %ecx,%eax
400006e5:	85 c9                	test   %ecx,%ecx
400006e7:	74 67                	je     40000750 <.L24+0xb3>
400006e9:	89 74 24 50          	mov    %esi,0x50(%esp)
400006ed:	89 d6                	mov    %edx,%esi
400006ef:	89 7c 24 58          	mov    %edi,0x58(%esp)
400006f3:	8b 7c 24 10          	mov    0x10(%esp),%edi
400006f7:	eb 2c                	jmp    40000725 <.L24+0x88>
400006f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                if (altflag && (ch < ' ' || ch > '~'))
40000700:	83 e8 20             	sub    $0x20,%eax
40000703:	83 f8 5e             	cmp    $0x5e,%eax
40000706:	76 2e                	jbe    40000736 <.L24+0x99>
                    putch('?', putdat);
40000708:	83 ec 08             	sub    $0x8,%esp
4000070b:	55                   	push   %ebp
4000070c:	6a 3f                	push   $0x3f
4000070e:	ff 54 24 60          	call   *0x60(%esp)
40000712:	83 c4 10             	add    $0x10,%esp
                 (ch = *p++) != '\0' && (precision < 0
40000715:	0f be 03             	movsbl (%ebx),%eax
40000718:	83 c3 01             	add    $0x1,%ebx
                                         || --precision >= 0); width--)
4000071b:	83 ef 01             	sub    $0x1,%edi
                 (ch = *p++) != '\0' && (precision < 0
4000071e:	0f be c8             	movsbl %al,%ecx
40000721:	85 c9                	test   %ecx,%ecx
40000723:	74 1f                	je     40000744 <.L24+0xa7>
40000725:	85 f6                	test   %esi,%esi
40000727:	78 05                	js     4000072e <.L24+0x91>
                                         || --precision >= 0); width--)
40000729:	83 ee 01             	sub    $0x1,%esi
4000072c:	72 16                	jb     40000744 <.L24+0xa7>
                if (altflag && (ch < ' ' || ch > '~'))
4000072e:	8b 54 24 08          	mov    0x8(%esp),%edx
40000732:	85 d2                	test   %edx,%edx
40000734:	75 ca                	jne    40000700 <.L24+0x63>
                    putch(ch, putdat);
40000736:	83 ec 08             	sub    $0x8,%esp
40000739:	55                   	push   %ebp
4000073a:	51                   	push   %ecx
4000073b:	ff 54 24 60          	call   *0x60(%esp)
4000073f:	83 c4 10             	add    $0x10,%esp
40000742:	eb d1                	jmp    40000715 <.L24+0x78>
40000744:	89 7c 24 10          	mov    %edi,0x10(%esp)
40000748:	8b 74 24 50          	mov    0x50(%esp),%esi
4000074c:	8b 7c 24 58          	mov    0x58(%esp),%edi
            for (; width > 0; width--)
40000750:	8b 4c 24 10          	mov    0x10(%esp),%ecx
40000754:	8b 5c 24 10          	mov    0x10(%esp),%ebx
40000758:	85 c9                	test   %ecx,%ecx
4000075a:	7e 14                	jle    40000770 <.L24+0xd3>
4000075c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                putch(' ', putdat);
40000760:	83 ec 08             	sub    $0x8,%esp
40000763:	55                   	push   %ebp
40000764:	6a 20                	push   $0x20
40000766:	ff d6                	call   *%esi
            for (; width > 0; width--)
40000768:	83 c4 10             	add    $0x10,%esp
4000076b:	83 eb 01             	sub    $0x1,%ebx
4000076e:	75 f0                	jne    40000760 <.L24+0xc3>
            if ((p = va_arg(ap, char *)) == NULL)
40000770:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000774:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000778:	e9 7e fc ff ff       	jmp    400003fb <vprintfmt+0x2b>
        return va_arg(*ap, unsigned long long);
4000077d:	8b 08                	mov    (%eax),%ecx
4000077f:	8b 58 04             	mov    0x4(%eax),%ebx
40000782:	83 c0 08             	add    $0x8,%eax
40000785:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000789:	e9 d7 fe ff ff       	jmp    40000665 <.L28+0x2f>
4000078e:	8b 08                	mov    (%eax),%ecx
40000790:	8b 58 04             	mov    0x4(%eax),%ebx
40000793:	83 c0 08             	add    $0x8,%eax
40000796:	ba 10 00 00 00       	mov    $0x10,%edx
4000079b:	89 44 24 5c          	mov    %eax,0x5c(%esp)
4000079f:	e9 1c fe ff ff       	jmp    400005c0 <.L23+0x2d>
        return va_arg(*ap, long long);
400007a4:	8b 08                	mov    (%eax),%ecx
400007a6:	8b 58 04             	mov    0x4(%eax),%ebx
400007a9:	83 c0 08             	add    $0x8,%eax
400007ac:	89 44 24 5c          	mov    %eax,0x5c(%esp)
400007b0:	e9 a8 fe ff ff       	jmp    4000065d <.L28+0x27>

400007b5 <.L61>:
            padc = '-';
400007b5:	c6 44 24 18 2d       	movb   $0x2d,0x18(%esp)
        switch (ch = *(unsigned char *) fmt++) {
400007ba:	89 fb                	mov    %edi,%ebx
400007bc:	e9 a1 fc ff ff       	jmp    40000462 <vprintfmt+0x92>

400007c1 <.L31>:
400007c1:	c6 44 24 18 30       	movb   $0x30,0x18(%esp)
400007c6:	89 fb                	mov    %edi,%ebx
400007c8:	e9 95 fc ff ff       	jmp    40000462 <vprintfmt+0x92>
400007cd:	89 4c 24 08          	mov    %ecx,0x8(%esp)
                putch('-', putdat);
400007d1:	83 ec 08             	sub    $0x8,%esp
400007d4:	89 5c 24 14          	mov    %ebx,0x14(%esp)
400007d8:	55                   	push   %ebp
400007d9:	6a 2d                	push   $0x2d
400007db:	ff d6                	call   *%esi
                num = -(long long) num;
400007dd:	8b 4c 24 18          	mov    0x18(%esp),%ecx
400007e1:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
400007e5:	ba 0a 00 00 00       	mov    $0xa,%edx
400007ea:	f7 d9                	neg    %ecx
400007ec:	83 d3 00             	adc    $0x0,%ebx
400007ef:	83 c4 10             	add    $0x10,%esp
400007f2:	f7 db                	neg    %ebx
400007f4:	e9 c7 fd ff ff       	jmp    400005c0 <.L23+0x2d>
            if (width > 0 && padc != '-')
400007f9:	84 c0                	test   %al,%al
400007fb:	0f 85 9f 00 00 00    	jne    400008a0 <.L31+0xdf>
                 (ch = *p++) != '\0' && (precision < 0
40000801:	8b 44 24 14          	mov    0x14(%esp),%eax
40000805:	b9 28 00 00 00       	mov    $0x28,%ecx
4000080a:	8d 98 36 e0 ff ff    	lea    -0x1fca(%eax),%ebx
40000810:	89 74 24 50          	mov    %esi,0x50(%esp)
40000814:	b8 28 00 00 00       	mov    $0x28,%eax
40000819:	89 d6                	mov    %edx,%esi
4000081b:	89 7c 24 58          	mov    %edi,0x58(%esp)
4000081f:	8b 7c 24 10          	mov    0x10(%esp),%edi
40000823:	e9 fd fe ff ff       	jmp    40000725 <.L24+0x88>
                for (width -= strnlen(p, precision); width > 0; width--)
40000828:	83 ec 08             	sub    $0x8,%esp
4000082b:	52                   	push   %edx
4000082c:	89 54 24 38          	mov    %edx,0x38(%esp)
40000830:	51                   	push   %ecx
40000831:	8b 5c 24 24          	mov    0x24(%esp),%ebx
40000835:	89 4c 24 38          	mov    %ecx,0x38(%esp)
40000839:	e8 12 03 00 00       	call   40000b50 <strnlen>
4000083e:	29 44 24 20          	sub    %eax,0x20(%esp)
40000842:	8b 4c 24 20          	mov    0x20(%esp),%ecx
40000846:	83 c4 10             	add    $0x10,%esp
40000849:	8b 54 24 2c          	mov    0x2c(%esp),%edx
4000084d:	85 c9                	test   %ecx,%ecx
4000084f:	8b 4c 24 28          	mov    0x28(%esp),%ecx
40000853:	7e 34                	jle    40000889 <.L31+0xc8>
                    putch(padc, putdat);
40000855:	0f be 5c 24 18       	movsbl 0x18(%esp),%ebx
4000085a:	89 4c 24 28          	mov    %ecx,0x28(%esp)
4000085e:	89 54 24 18          	mov    %edx,0x18(%esp)
40000862:	89 7c 24 58          	mov    %edi,0x58(%esp)
40000866:	8b 7c 24 10          	mov    0x10(%esp),%edi
4000086a:	83 ec 08             	sub    $0x8,%esp
4000086d:	55                   	push   %ebp
4000086e:	53                   	push   %ebx
4000086f:	ff d6                	call   *%esi
                for (width -= strnlen(p, precision); width > 0; width--)
40000871:	83 c4 10             	add    $0x10,%esp
40000874:	83 ef 01             	sub    $0x1,%edi
40000877:	75 f1                	jne    4000086a <.L31+0xa9>
40000879:	8b 54 24 18          	mov    0x18(%esp),%edx
4000087d:	8b 4c 24 28          	mov    0x28(%esp),%ecx
40000881:	89 7c 24 10          	mov    %edi,0x10(%esp)
40000885:	8b 7c 24 58          	mov    0x58(%esp),%edi
                 (ch = *p++) != '\0' && (precision < 0
40000889:	0f be 01             	movsbl (%ecx),%eax
4000088c:	8b 5c 24 20          	mov    0x20(%esp),%ebx
40000890:	0f be c8             	movsbl %al,%ecx
40000893:	85 c9                	test   %ecx,%ecx
40000895:	0f 85 4e fe ff ff    	jne    400006e9 <.L24+0x4c>
4000089b:	e9 d0 fe ff ff       	jmp    40000770 <.L24+0xd3>
                for (width -= strnlen(p, precision); width > 0; width--)
400008a0:	83 ec 08             	sub    $0x8,%esp
400008a3:	52                   	push   %edx
400008a4:	89 54 24 34          	mov    %edx,0x34(%esp)
400008a8:	ff 74 24 30          	push   0x30(%esp)
400008ac:	8b 5c 24 24          	mov    0x24(%esp),%ebx
400008b0:	e8 9b 02 00 00       	call   40000b50 <strnlen>
400008b5:	29 44 24 20          	sub    %eax,0x20(%esp)
400008b9:	8b 44 24 20          	mov    0x20(%esp),%eax
400008bd:	83 c4 10             	add    $0x10,%esp
                p = "(null)";
400008c0:	8b 54 24 24          	mov    0x24(%esp),%edx
400008c4:	89 d1                	mov    %edx,%ecx
400008c6:	83 c2 01             	add    $0x1,%edx
                for (width -= strnlen(p, precision); width > 0; width--)
400008c9:	85 c0                	test   %eax,%eax
400008cb:	89 54 24 20          	mov    %edx,0x20(%esp)
400008cf:	8b 54 24 28          	mov    0x28(%esp),%edx
400008d3:	7f 80                	jg     40000855 <.L31+0x94>
                 (ch = *p++) != '\0' && (precision < 0
400008d5:	8b 5c 24 20          	mov    0x20(%esp),%ebx
400008d9:	b9 28 00 00 00       	mov    $0x28,%ecx
400008de:	e9 2d ff ff ff       	jmp    40000810 <.L31+0x4f>
400008e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400008ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

400008f0 <printfmt>:
{
400008f0:	83 ec 0c             	sub    $0xc,%esp
    vprintfmt(putch, putdat, fmt, ap);
400008f3:	8d 44 24 1c          	lea    0x1c(%esp),%eax
400008f7:	50                   	push   %eax
400008f8:	ff 74 24 1c          	push   0x1c(%esp)
400008fc:	ff 74 24 1c          	push   0x1c(%esp)
40000900:	ff 74 24 1c          	push   0x1c(%esp)
40000904:	e8 c7 fa ff ff       	call   400003d0 <vprintfmt>
}
40000909:	83 c4 1c             	add    $0x1c,%esp
4000090c:	c3                   	ret    
4000090d:	8d 76 00             	lea    0x0(%esi),%esi

40000910 <vsprintf>:

int vsprintf(char *buf, const char *fmt, va_list ap)
{
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
40000910:	e8 4e 01 00 00       	call   40000a63 <__x86.get_pc_thunk.ax>
40000915:	05 eb 36 00 00       	add    $0x36eb,%eax
{
4000091a:	83 ec 1c             	sub    $0x1c,%esp
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
4000091d:	8b 54 24 20          	mov    0x20(%esp),%edx
40000921:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
40000928:	ff 
40000929:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000930:	00 
40000931:	89 54 24 04          	mov    %edx,0x4(%esp)

    // print the string to the buffer
    vprintfmt((void *) sprintputch, &b, fmt, ap);
40000935:	ff 74 24 28          	push   0x28(%esp)
40000939:	ff 74 24 28          	push   0x28(%esp)
4000093d:	8d 80 b0 c3 ff ff    	lea    -0x3c50(%eax),%eax
40000943:	8d 54 24 0c          	lea    0xc(%esp),%edx
40000947:	52                   	push   %edx
40000948:	50                   	push   %eax
40000949:	e8 82 fa ff ff       	call   400003d0 <vprintfmt>

    // null terminate the buffer
    *b.buf = '\0';
4000094e:	8b 44 24 14          	mov    0x14(%esp),%eax
40000952:	c6 00 00             	movb   $0x0,(%eax)

    return b.cnt;
}
40000955:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000959:	83 c4 2c             	add    $0x2c,%esp
4000095c:	c3                   	ret    
4000095d:	8d 76 00             	lea    0x0(%esi),%esi

40000960 <sprintf>:
int sprintf(char *buf, const char *fmt, ...)
{
    va_list ap;
    int rc;

    va_start(ap, fmt);
40000960:	e8 fe 00 00 00       	call   40000a63 <__x86.get_pc_thunk.ax>
40000965:	05 9b 36 00 00       	add    $0x369b,%eax
{
4000096a:	83 ec 1c             	sub    $0x1c,%esp
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
4000096d:	8b 54 24 20          	mov    0x20(%esp),%edx
40000971:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
40000978:	ff 
40000979:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000980:	00 
40000981:	89 54 24 04          	mov    %edx,0x4(%esp)
    vprintfmt((void *) sprintputch, &b, fmt, ap);
40000985:	8d 54 24 28          	lea    0x28(%esp),%edx
40000989:	52                   	push   %edx
4000098a:	ff 74 24 28          	push   0x28(%esp)
4000098e:	8d 80 b0 c3 ff ff    	lea    -0x3c50(%eax),%eax
40000994:	8d 54 24 0c          	lea    0xc(%esp),%edx
40000998:	52                   	push   %edx
40000999:	50                   	push   %eax
4000099a:	e8 31 fa ff ff       	call   400003d0 <vprintfmt>
    *b.buf = '\0';
4000099f:	8b 44 24 14          	mov    0x14(%esp),%eax
400009a3:	c6 00 00             	movb   $0x0,(%eax)
    rc = vsprintf(buf, fmt, ap);
    va_end(ap);

    return rc;
}
400009a6:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400009aa:	83 c4 2c             	add    $0x2c,%esp
400009ad:	c3                   	ret    
400009ae:	66 90                	xchg   %ax,%ax

400009b0 <vsnprintf>:

int vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
    struct sprintbuf b = { buf, buf + n - 1, 0 };
400009b0:	e8 b2 00 00 00       	call   40000a67 <__x86.get_pc_thunk.dx>
400009b5:	81 c2 4b 36 00 00    	add    $0x364b,%edx
{
400009bb:	83 ec 1c             	sub    $0x1c,%esp
400009be:	8b 44 24 20          	mov    0x20(%esp),%eax
    struct sprintbuf b = { buf, buf + n - 1, 0 };
400009c2:	8b 4c 24 24          	mov    0x24(%esp),%ecx
400009c6:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
400009cd:	00 
400009ce:	89 44 24 04          	mov    %eax,0x4(%esp)
400009d2:	8d 44 08 ff          	lea    -0x1(%eax,%ecx,1),%eax
400009d6:	89 44 24 08          	mov    %eax,0x8(%esp)

    // print the string to the buffer
    vprintfmt((void *) sprintputch, &b, fmt, ap);
400009da:	ff 74 24 2c          	push   0x2c(%esp)
400009de:	ff 74 24 2c          	push   0x2c(%esp)
400009e2:	8d 44 24 0c          	lea    0xc(%esp),%eax
400009e6:	50                   	push   %eax
400009e7:	8d 82 b0 c3 ff ff    	lea    -0x3c50(%edx),%eax
400009ed:	50                   	push   %eax
400009ee:	e8 dd f9 ff ff       	call   400003d0 <vprintfmt>

    // null terminate the buffer
    *b.buf = '\0';
400009f3:	8b 44 24 14          	mov    0x14(%esp),%eax
400009f7:	c6 00 00             	movb   $0x0,(%eax)

    return b.cnt;
}
400009fa:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400009fe:	83 c4 2c             	add    $0x2c,%esp
40000a01:	c3                   	ret    
40000a02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000a10 <snprintf>:
int snprintf(char *buf, int n, const char *fmt, ...)
{
    va_list ap;
    int rc;

    va_start(ap, fmt);
40000a10:	e8 52 00 00 00       	call   40000a67 <__x86.get_pc_thunk.dx>
40000a15:	81 c2 eb 35 00 00    	add    $0x35eb,%edx
{
40000a1b:	83 ec 1c             	sub    $0x1c,%esp
40000a1e:	8b 44 24 20          	mov    0x20(%esp),%eax
    struct sprintbuf b = { buf, buf + n - 1, 0 };
40000a22:	8b 4c 24 24          	mov    0x24(%esp),%ecx
40000a26:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000a2d:	00 
40000a2e:	89 44 24 04          	mov    %eax,0x4(%esp)
40000a32:	8d 44 08 ff          	lea    -0x1(%eax,%ecx,1),%eax
40000a36:	89 44 24 08          	mov    %eax,0x8(%esp)
    vprintfmt((void *) sprintputch, &b, fmt, ap);
40000a3a:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000a3e:	50                   	push   %eax
40000a3f:	ff 74 24 2c          	push   0x2c(%esp)
40000a43:	8d 44 24 0c          	lea    0xc(%esp),%eax
40000a47:	50                   	push   %eax
40000a48:	8d 82 b0 c3 ff ff    	lea    -0x3c50(%edx),%eax
40000a4e:	50                   	push   %eax
40000a4f:	e8 7c f9 ff ff       	call   400003d0 <vprintfmt>
    *b.buf = '\0';
40000a54:	8b 44 24 14          	mov    0x14(%esp),%eax
40000a58:	c6 00 00             	movb   $0x0,(%eax)
    rc = vsnprintf(buf, n, fmt, ap);
    va_end(ap);

    return rc;
}
40000a5b:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000a5f:	83 c4 2c             	add    $0x2c,%esp
40000a62:	c3                   	ret    

40000a63 <__x86.get_pc_thunk.ax>:
40000a63:	8b 04 24             	mov    (%esp),%eax
40000a66:	c3                   	ret    

40000a67 <__x86.get_pc_thunk.dx>:
40000a67:	8b 14 24             	mov    (%esp),%edx
40000a6a:	c3                   	ret    

40000a6b <__x86.get_pc_thunk.cx>:
40000a6b:	8b 0c 24             	mov    (%esp),%ecx
40000a6e:	c3                   	ret    
40000a6f:	90                   	nop

40000a70 <spawn>:
#include <proc.h>
#include <syscall.h>
#include <types.h>

pid_t spawn(uintptr_t exec, unsigned int quota)
{
40000a70:	53                   	push   %ebx
static gcc_inline pid_t sys_spawn(unsigned int elf_id, unsigned int quota)
{
    int errno;
    pid_t pid;

    asm volatile ("int %2"
40000a71:	b8 01 00 00 00       	mov    $0x1,%eax
40000a76:	8b 5c 24 08          	mov    0x8(%esp),%ebx
40000a7a:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000a7e:	cd 30                	int    $0x30
                    "a" (SYS_spawn),
                    "b" (elf_id),
                    "c" (quota)
                  : "cc", "memory");

    return errno ? -1 : pid;
40000a80:	85 c0                	test   %eax,%eax
40000a82:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
40000a87:	0f 44 c3             	cmove  %ebx,%eax
    return sys_spawn(exec, quota);
}
40000a8a:	5b                   	pop    %ebx
40000a8b:	c3                   	ret    
40000a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000a90 <yield>:
}

static gcc_inline void sys_yield(void)
{
    asm volatile ("int %0"
40000a90:	b8 02 00 00 00       	mov    $0x2,%eax
40000a95:	cd 30                	int    $0x30

void yield(void)
{
    sys_yield();
}
40000a97:	c3                   	ret    
40000a98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000a9f:	90                   	nop

40000aa0 <produce>:
                  : "cc", "memory");
}

static gcc_inline void sys_produce(void)
{
    asm volatile ("int %0"
40000aa0:	b8 03 00 00 00       	mov    $0x3,%eax
40000aa5:	cd 30                	int    $0x30

void produce(void)
{
    sys_produce();
}
40000aa7:	c3                   	ret    
40000aa8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000aaf:	90                   	nop

40000ab0 <consume>:
                  : "cc", "memory");
}

static gcc_inline void sys_consume(void)
{
    asm volatile ("int %0"
40000ab0:	b8 04 00 00 00       	mov    $0x4,%eax
40000ab5:	cd 30                	int    $0x30

void consume(void)
{
    sys_consume();
}
40000ab7:	c3                   	ret    
40000ab8:	66 90                	xchg   %ax,%ax
40000aba:	66 90                	xchg   %ax,%ax
40000abc:	66 90                	xchg   %ax,%ax
40000abe:	66 90                	xchg   %ax,%ax

40000ac0 <spinlock_init>:
    return result;
}

void spinlock_init(spinlock_t *lk)
{
    *lk = 0;
40000ac0:	8b 44 24 04          	mov    0x4(%esp),%eax
40000ac4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
40000aca:	c3                   	ret    
40000acb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000acf:	90                   	nop

40000ad0 <spinlock_acquire>:

void spinlock_acquire(spinlock_t *lk)
{
40000ad0:	8b 54 24 04          	mov    0x4(%esp),%edx
    asm volatile ("lock; xchgl %0, %1"
40000ad4:	b8 01 00 00 00       	mov    $0x1,%eax
40000ad9:	f0 87 02             	lock xchg %eax,(%edx)
    while (xchg(lk, 1) != 0)
40000adc:	85 c0                	test   %eax,%eax
40000ade:	74 13                	je     40000af3 <spinlock_acquire+0x23>
    asm volatile ("lock; xchgl %0, %1"
40000ae0:	b9 01 00 00 00       	mov    $0x1,%ecx
40000ae5:	8d 76 00             	lea    0x0(%esi),%esi
        asm volatile ("pause");
40000ae8:	f3 90                	pause  
    asm volatile ("lock; xchgl %0, %1"
40000aea:	89 c8                	mov    %ecx,%eax
40000aec:	f0 87 02             	lock xchg %eax,(%edx)
    while (xchg(lk, 1) != 0)
40000aef:	85 c0                	test   %eax,%eax
40000af1:	75 f5                	jne    40000ae8 <spinlock_acquire+0x18>
}
40000af3:	c3                   	ret    
40000af4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000afb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000aff:	90                   	nop

40000b00 <spinlock_release>:

// Release the lock.
void spinlock_release(spinlock_t *lk)
{
40000b00:	8b 54 24 04          	mov    0x4(%esp),%edx
}

// Check whether this cpu is holding the lock.
bool spinlock_holding(spinlock_t *lk)
{
    return *lk;
40000b04:	8b 02                	mov    (%edx),%eax
    if (spinlock_holding(lk) == FALSE)
40000b06:	84 c0                	test   %al,%al
40000b08:	74 05                	je     40000b0f <spinlock_release+0xf>
    asm volatile ("lock; xchgl %0, %1"
40000b0a:	31 c0                	xor    %eax,%eax
40000b0c:	f0 87 02             	lock xchg %eax,(%edx)
}
40000b0f:	c3                   	ret    

40000b10 <spinlock_holding>:
    return *lk;
40000b10:	8b 44 24 04          	mov    0x4(%esp),%eax
40000b14:	8b 00                	mov    (%eax),%eax
}
40000b16:	c3                   	ret    
40000b17:	66 90                	xchg   %ax,%ax
40000b19:	66 90                	xchg   %ax,%ax
40000b1b:	66 90                	xchg   %ax,%ax
40000b1d:	66 90                	xchg   %ax,%ax
40000b1f:	90                   	nop

40000b20 <strlen>:
#include <string.h>
#include <types.h>

int strlen(const char *s)
{
40000b20:	8b 54 24 04          	mov    0x4(%esp),%edx
    int n;

    for (n = 0; *s != '\0'; s++)
40000b24:	31 c0                	xor    %eax,%eax
40000b26:	80 3a 00             	cmpb   $0x0,(%edx)
40000b29:	74 15                	je     40000b40 <strlen+0x20>
40000b2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000b2f:	90                   	nop
        n++;
40000b30:	83 c0 01             	add    $0x1,%eax
    for (n = 0; *s != '\0'; s++)
40000b33:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
40000b37:	75 f7                	jne    40000b30 <strlen+0x10>
40000b39:	c3                   	ret    
40000b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return n;
}
40000b40:	c3                   	ret    
40000b41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b4f:	90                   	nop

40000b50 <strnlen>:

int strnlen(const char *s, size_t size)
{
40000b50:	8b 54 24 08          	mov    0x8(%esp),%edx
40000b54:	8b 4c 24 04          	mov    0x4(%esp),%ecx
    int n;

    for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000b58:	31 c0                	xor    %eax,%eax
40000b5a:	85 d2                	test   %edx,%edx
40000b5c:	75 09                	jne    40000b67 <strnlen+0x17>
40000b5e:	eb 10                	jmp    40000b70 <strnlen+0x20>
        n++;
40000b60:	83 c0 01             	add    $0x1,%eax
    for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000b63:	39 d0                	cmp    %edx,%eax
40000b65:	74 09                	je     40000b70 <strnlen+0x20>
40000b67:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
40000b6b:	75 f3                	jne    40000b60 <strnlen+0x10>
40000b6d:	c3                   	ret    
40000b6e:	66 90                	xchg   %ax,%ax
    return n;
}
40000b70:	c3                   	ret    
40000b71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b7f:	90                   	nop

40000b80 <strcpy>:

char *strcpy(char *dst, const char *src)
{
40000b80:	53                   	push   %ebx
40000b81:	8b 4c 24 08          	mov    0x8(%esp),%ecx
    char *ret;

    ret = dst;
    while ((*dst++ = *src++) != '\0')
40000b85:	31 c0                	xor    %eax,%eax
{
40000b87:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40000b8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000b8f:	90                   	nop
    while ((*dst++ = *src++) != '\0')
40000b90:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
40000b94:	88 14 01             	mov    %dl,(%ecx,%eax,1)
40000b97:	83 c0 01             	add    $0x1,%eax
40000b9a:	84 d2                	test   %dl,%dl
40000b9c:	75 f2                	jne    40000b90 <strcpy+0x10>
        /* do nothing */ ;
    return ret;
}
40000b9e:	89 c8                	mov    %ecx,%eax
40000ba0:	5b                   	pop    %ebx
40000ba1:	c3                   	ret    
40000ba2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000bb0 <strncpy>:

char *strncpy(char *dst, const char *src, size_t size)
{
40000bb0:	56                   	push   %esi
40000bb1:	53                   	push   %ebx
40000bb2:	8b 5c 24 14          	mov    0x14(%esp),%ebx
40000bb6:	8b 74 24 0c          	mov    0xc(%esp),%esi
40000bba:	8b 54 24 10          	mov    0x10(%esp),%edx
    size_t i;
    char *ret;

    ret = dst;
    for (i = 0; i < size; i++) {
40000bbe:	85 db                	test   %ebx,%ebx
40000bc0:	74 21                	je     40000be3 <strncpy+0x33>
40000bc2:	01 f3                	add    %esi,%ebx
40000bc4:	89 f0                	mov    %esi,%eax
40000bc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000bcd:	8d 76 00             	lea    0x0(%esi),%esi
        *dst++ = *src;
40000bd0:	0f b6 0a             	movzbl (%edx),%ecx
40000bd3:	83 c0 01             	add    $0x1,%eax
        // If strlen(src) < size, null-pad 'dst' out to 'size' chars
        if (*src != '\0')
            src++;
40000bd6:	80 f9 01             	cmp    $0x1,%cl
        *dst++ = *src;
40000bd9:	88 48 ff             	mov    %cl,-0x1(%eax)
            src++;
40000bdc:	83 da ff             	sbb    $0xffffffff,%edx
    for (i = 0; i < size; i++) {
40000bdf:	39 d8                	cmp    %ebx,%eax
40000be1:	75 ed                	jne    40000bd0 <strncpy+0x20>
    }
    return ret;
}
40000be3:	89 f0                	mov    %esi,%eax
40000be5:	5b                   	pop    %ebx
40000be6:	5e                   	pop    %esi
40000be7:	c3                   	ret    
40000be8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000bef:	90                   	nop

40000bf0 <strlcpy>:

size_t strlcpy(char *dst, const char *src, size_t size)
{
40000bf0:	53                   	push   %ebx
40000bf1:	8b 44 24 10          	mov    0x10(%esp),%eax
40000bf5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    char *dst_in;

    dst_in = dst;
    if (size > 0) {
40000bf9:	85 c0                	test   %eax,%eax
40000bfb:	74 30                	je     40000c2d <strlcpy+0x3d>
        while (--size > 0 && *src != '\0')
40000bfd:	8b 54 24 08          	mov    0x8(%esp),%edx
40000c01:	83 e8 01             	sub    $0x1,%eax
40000c04:	74 24                	je     40000c2a <strlcpy+0x3a>
40000c06:	01 d0                	add    %edx,%eax
40000c08:	89 c3                	mov    %eax,%ebx
40000c0a:	eb 11                	jmp    40000c1d <strlcpy+0x2d>
40000c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            *dst++ = *src++;
40000c10:	83 c2 01             	add    $0x1,%edx
40000c13:	83 c1 01             	add    $0x1,%ecx
40000c16:	88 42 ff             	mov    %al,-0x1(%edx)
        while (--size > 0 && *src != '\0')
40000c19:	39 da                	cmp    %ebx,%edx
40000c1b:	74 07                	je     40000c24 <strlcpy+0x34>
40000c1d:	0f b6 01             	movzbl (%ecx),%eax
40000c20:	84 c0                	test   %al,%al
40000c22:	75 ec                	jne    40000c10 <strlcpy+0x20>
        *dst = '\0';
    }
    return dst - dst_in;
40000c24:	89 d0                	mov    %edx,%eax
40000c26:	2b 44 24 08          	sub    0x8(%esp),%eax
        *dst = '\0';
40000c2a:	c6 02 00             	movb   $0x0,(%edx)
}
40000c2d:	5b                   	pop    %ebx
40000c2e:	c3                   	ret    
40000c2f:	90                   	nop

40000c30 <strcmp>:

int strcmp(const char *p, const char *q)
{
40000c30:	53                   	push   %ebx
40000c31:	8b 54 24 08          	mov    0x8(%esp),%edx
40000c35:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    while (*p && *p == *q)
40000c39:	0f b6 02             	movzbl (%edx),%eax
40000c3c:	84 c0                	test   %al,%al
40000c3e:	75 18                	jne    40000c58 <strcmp+0x28>
40000c40:	eb 30                	jmp    40000c72 <strcmp+0x42>
40000c42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000c48:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        p++, q++;
40000c4c:	83 c2 01             	add    $0x1,%edx
40000c4f:	8d 59 01             	lea    0x1(%ecx),%ebx
    while (*p && *p == *q)
40000c52:	84 c0                	test   %al,%al
40000c54:	74 12                	je     40000c68 <strcmp+0x38>
        p++, q++;
40000c56:	89 d9                	mov    %ebx,%ecx
    while (*p && *p == *q)
40000c58:	0f b6 19             	movzbl (%ecx),%ebx
40000c5b:	38 c3                	cmp    %al,%bl
40000c5d:	74 e9                	je     40000c48 <strcmp+0x18>
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000c5f:	29 d8                	sub    %ebx,%eax
}
40000c61:	5b                   	pop    %ebx
40000c62:	c3                   	ret    
40000c63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000c67:	90                   	nop
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000c68:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
40000c6c:	31 c0                	xor    %eax,%eax
40000c6e:	29 d8                	sub    %ebx,%eax
}
40000c70:	5b                   	pop    %ebx
40000c71:	c3                   	ret    
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000c72:	0f b6 19             	movzbl (%ecx),%ebx
40000c75:	31 c0                	xor    %eax,%eax
40000c77:	eb e6                	jmp    40000c5f <strcmp+0x2f>
40000c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000c80 <strncmp>:

int strncmp(const char *p, const char *q, size_t n)
{
40000c80:	56                   	push   %esi
40000c81:	53                   	push   %ebx
40000c82:	8b 74 24 14          	mov    0x14(%esp),%esi
40000c86:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000c8a:	8b 44 24 10          	mov    0x10(%esp),%eax
    while (n > 0 && *p && *p == *q)
40000c8e:	85 f6                	test   %esi,%esi
40000c90:	74 2e                	je     40000cc0 <strncmp+0x40>
40000c92:	01 c6                	add    %eax,%esi
40000c94:	eb 18                	jmp    40000cae <strncmp+0x2e>
40000c96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000c9d:	8d 76 00             	lea    0x0(%esi),%esi
40000ca0:	38 da                	cmp    %bl,%dl
40000ca2:	75 14                	jne    40000cb8 <strncmp+0x38>
        n--, p++, q++;
40000ca4:	83 c0 01             	add    $0x1,%eax
40000ca7:	83 c1 01             	add    $0x1,%ecx
    while (n > 0 && *p && *p == *q)
40000caa:	39 f0                	cmp    %esi,%eax
40000cac:	74 12                	je     40000cc0 <strncmp+0x40>
40000cae:	0f b6 11             	movzbl (%ecx),%edx
40000cb1:	0f b6 18             	movzbl (%eax),%ebx
40000cb4:	84 d2                	test   %dl,%dl
40000cb6:	75 e8                	jne    40000ca0 <strncmp+0x20>
    if (n == 0)
        return 0;
    else
        return (int) ((unsigned char) *p - (unsigned char) *q);
40000cb8:	0f b6 c2             	movzbl %dl,%eax
40000cbb:	29 d8                	sub    %ebx,%eax
}
40000cbd:	5b                   	pop    %ebx
40000cbe:	5e                   	pop    %esi
40000cbf:	c3                   	ret    
        return 0;
40000cc0:	31 c0                	xor    %eax,%eax
}
40000cc2:	5b                   	pop    %ebx
40000cc3:	5e                   	pop    %esi
40000cc4:	c3                   	ret    
40000cc5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000cd0 <strchr>:

char *strchr(const char *s, char c)
{
40000cd0:	8b 44 24 04          	mov    0x4(%esp),%eax
40000cd4:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
    for (; *s; s++)
40000cd9:	0f b6 10             	movzbl (%eax),%edx
40000cdc:	84 d2                	test   %dl,%dl
40000cde:	75 13                	jne    40000cf3 <strchr+0x23>
40000ce0:	eb 1e                	jmp    40000d00 <strchr+0x30>
40000ce2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000ce8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
40000cec:	83 c0 01             	add    $0x1,%eax
40000cef:	84 d2                	test   %dl,%dl
40000cf1:	74 0d                	je     40000d00 <strchr+0x30>
        if (*s == c)
40000cf3:	38 d1                	cmp    %dl,%cl
40000cf5:	75 f1                	jne    40000ce8 <strchr+0x18>
            return (char *) s;
    return 0;
}
40000cf7:	c3                   	ret    
40000cf8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000cff:	90                   	nop
    return 0;
40000d00:	31 c0                	xor    %eax,%eax
}
40000d02:	c3                   	ret    
40000d03:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000d10 <strfind>:

char *strfind(const char *s, char c)
{
40000d10:	53                   	push   %ebx
40000d11:	8b 44 24 08          	mov    0x8(%esp),%eax
40000d15:	8b 54 24 0c          	mov    0xc(%esp),%edx
    for (; *s; s++)
40000d19:	0f b6 18             	movzbl (%eax),%ebx
        if (*s == c)
40000d1c:	38 d3                	cmp    %dl,%bl
40000d1e:	74 1f                	je     40000d3f <strfind+0x2f>
40000d20:	89 d1                	mov    %edx,%ecx
40000d22:	84 db                	test   %bl,%bl
40000d24:	75 0e                	jne    40000d34 <strfind+0x24>
40000d26:	eb 17                	jmp    40000d3f <strfind+0x2f>
40000d28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000d2f:	90                   	nop
40000d30:	84 d2                	test   %dl,%dl
40000d32:	74 0b                	je     40000d3f <strfind+0x2f>
    for (; *s; s++)
40000d34:	0f b6 50 01          	movzbl 0x1(%eax),%edx
40000d38:	83 c0 01             	add    $0x1,%eax
        if (*s == c)
40000d3b:	38 ca                	cmp    %cl,%dl
40000d3d:	75 f1                	jne    40000d30 <strfind+0x20>
            break;
    return (char *) s;
}
40000d3f:	5b                   	pop    %ebx
40000d40:	c3                   	ret    
40000d41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000d48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000d4f:	90                   	nop

40000d50 <strtol>:

long strtol(const char *s, char **endptr, int base)
{
40000d50:	55                   	push   %ebp
40000d51:	57                   	push   %edi
40000d52:	56                   	push   %esi
40000d53:	53                   	push   %ebx
40000d54:	8b 54 24 14          	mov    0x14(%esp),%edx
40000d58:	8b 74 24 18          	mov    0x18(%esp),%esi
40000d5c:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
40000d60:	0f b6 02             	movzbl (%edx),%eax
40000d63:	3c 09                	cmp    $0x9,%al
40000d65:	74 09                	je     40000d70 <strtol+0x20>
40000d67:	3c 20                	cmp    $0x20,%al
40000d69:	75 14                	jne    40000d7f <strtol+0x2f>
40000d6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000d6f:	90                   	nop
40000d70:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        s++;
40000d74:	83 c2 01             	add    $0x1,%edx
    while (*s == ' ' || *s == '\t')
40000d77:	3c 20                	cmp    $0x20,%al
40000d79:	74 f5                	je     40000d70 <strtol+0x20>
40000d7b:	3c 09                	cmp    $0x9,%al
40000d7d:	74 f1                	je     40000d70 <strtol+0x20>

    // plus/minus sign
    if (*s == '+')
40000d7f:	3c 2b                	cmp    $0x2b,%al
40000d81:	0f 84 99 00 00 00    	je     40000e20 <strtol+0xd0>
    int neg = 0;
40000d87:	31 ff                	xor    %edi,%edi
        s++;
    else if (*s == '-')
40000d89:	3c 2d                	cmp    $0x2d,%al
40000d8b:	0f 84 7f 00 00 00    	je     40000e10 <strtol+0xc0>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000d91:	0f b6 2a             	movzbl (%edx),%ebp
40000d94:	f7 c3 ef ff ff ff    	test   $0xffffffef,%ebx
40000d9a:	75 13                	jne    40000daf <strtol+0x5f>
40000d9c:	89 e8                	mov    %ebp,%eax
40000d9e:	3c 30                	cmp    $0x30,%al
40000da0:	0f 84 8a 00 00 00    	je     40000e30 <strtol+0xe0>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
40000da6:	85 db                	test   %ebx,%ebx
40000da8:	75 05                	jne    40000daf <strtol+0x5f>
        s++, base = 8;
    else if (base == 0)
        base = 10;
40000daa:	bb 0a 00 00 00       	mov    $0xa,%ebx
40000daf:	31 c9                	xor    %ecx,%ecx
40000db1:	eb 22                	jmp    40000dd5 <strtol+0x85>
40000db3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000db7:	90                   	nop
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
40000db8:	8d 45 9f             	lea    -0x61(%ebp),%eax
40000dbb:	3c 19                	cmp    $0x19,%al
40000dbd:	77 41                	ja     40000e00 <strtol+0xb0>
            dig = *s - 'a' + 10;
40000dbf:	8d 45 a9             	lea    -0x57(%ebp),%eax
40000dc2:	0f be c0             	movsbl %al,%eax
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
40000dc5:	39 d8                	cmp    %ebx,%eax
40000dc7:	7d 1a                	jge    40000de3 <strtol+0x93>
            break;
        s++, val = (val * base) + dig;
40000dc9:	0f af cb             	imul   %ebx,%ecx
        if (*s >= '0' && *s <= '9')
40000dcc:	0f b6 6a 01          	movzbl 0x1(%edx),%ebp
        s++, val = (val * base) + dig;
40000dd0:	83 c2 01             	add    $0x1,%edx
40000dd3:	01 c1                	add    %eax,%ecx
        if (*s >= '0' && *s <= '9')
40000dd5:	8d 45 d0             	lea    -0x30(%ebp),%eax
40000dd8:	3c 09                	cmp    $0x9,%al
40000dda:	77 dc                	ja     40000db8 <strtol+0x68>
            dig = *s - 'A' + 10;
40000ddc:	0f be c0             	movsbl %al,%eax
        if (dig >= base)
40000ddf:	39 d8                	cmp    %ebx,%eax
40000de1:	7c e6                	jl     40000dc9 <strtol+0x79>
        // we don't properly detect overflow!
    }

    if (endptr)
40000de3:	85 f6                	test   %esi,%esi
40000de5:	74 02                	je     40000de9 <strtol+0x99>
        *endptr = (char *) s;
40000de7:	89 16                	mov    %edx,(%esi)
    return (neg ? -val : val);
40000de9:	89 c8                	mov    %ecx,%eax
}
40000deb:	5b                   	pop    %ebx
40000dec:	5e                   	pop    %esi
    return (neg ? -val : val);
40000ded:	f7 d8                	neg    %eax
40000def:	85 ff                	test   %edi,%edi
}
40000df1:	5f                   	pop    %edi
40000df2:	5d                   	pop    %ebp
    return (neg ? -val : val);
40000df3:	0f 45 c8             	cmovne %eax,%ecx
}
40000df6:	89 c8                	mov    %ecx,%eax
40000df8:	c3                   	ret    
40000df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        else if (*s >= 'A' && *s <= 'Z')
40000e00:	8d 45 bf             	lea    -0x41(%ebp),%eax
40000e03:	3c 19                	cmp    $0x19,%al
40000e05:	77 dc                	ja     40000de3 <strtol+0x93>
            dig = *s - 'A' + 10;
40000e07:	8d 45 c9             	lea    -0x37(%ebp),%eax
40000e0a:	0f be c0             	movsbl %al,%eax
40000e0d:	eb d0                	jmp    40000ddf <strtol+0x8f>
40000e0f:	90                   	nop
        s++, neg = 1;
40000e10:	83 c2 01             	add    $0x1,%edx
40000e13:	bf 01 00 00 00       	mov    $0x1,%edi
40000e18:	e9 74 ff ff ff       	jmp    40000d91 <strtol+0x41>
40000e1d:	8d 76 00             	lea    0x0(%esi),%esi
        s++;
40000e20:	83 c2 01             	add    $0x1,%edx
    int neg = 0;
40000e23:	31 ff                	xor    %edi,%edi
40000e25:	e9 67 ff ff ff       	jmp    40000d91 <strtol+0x41>
40000e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000e30:	0f b6 42 01          	movzbl 0x1(%edx),%eax
40000e34:	3c 78                	cmp    $0x78,%al
40000e36:	74 17                	je     40000e4f <strtol+0xff>
    else if (base == 0 && s[0] == '0')
40000e38:	85 db                	test   %ebx,%ebx
40000e3a:	0f 85 6f ff ff ff    	jne    40000daf <strtol+0x5f>
        s++, base = 8;
40000e40:	83 c2 01             	add    $0x1,%edx
40000e43:	89 c5                	mov    %eax,%ebp
40000e45:	bb 08 00 00 00       	mov    $0x8,%ebx
40000e4a:	e9 60 ff ff ff       	jmp    40000daf <strtol+0x5f>
        if (*s >= '0' && *s <= '9')
40000e4f:	0f b6 6a 02          	movzbl 0x2(%edx),%ebp
        s += 2, base = 16;
40000e53:	bb 10 00 00 00       	mov    $0x10,%ebx
40000e58:	83 c2 02             	add    $0x2,%edx
40000e5b:	e9 4f ff ff ff       	jmp    40000daf <strtol+0x5f>

40000e60 <memset>:

void *memset(void *v, int c, size_t n)
{
40000e60:	57                   	push   %edi
40000e61:	56                   	push   %esi
40000e62:	53                   	push   %ebx
40000e63:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000e67:	8b 7c 24 10          	mov    0x10(%esp),%edi
    if (n == 0)
40000e6b:	85 c9                	test   %ecx,%ecx
40000e6d:	74 28                	je     40000e97 <memset+0x37>
        return v;
    if ((int) v % 4 == 0 && n % 4 == 0) {
40000e6f:	89 f8                	mov    %edi,%eax
40000e71:	09 c8                	or     %ecx,%eax
40000e73:	a8 03                	test   $0x3,%al
40000e75:	75 29                	jne    40000ea0 <memset+0x40>
        c &= 0xFF;
40000e77:	0f b6 5c 24 14       	movzbl 0x14(%esp),%ebx
        c = (c << 24) | (c << 16) | (c << 8) | c;
        asm volatile ("cld; rep stosl\n"
                      :: "D" (v), "a" (c), "c" (n / 4)
40000e7c:	c1 e9 02             	shr    $0x2,%ecx
        c = (c << 24) | (c << 16) | (c << 8) | c;
40000e7f:	89 da                	mov    %ebx,%edx
40000e81:	89 de                	mov    %ebx,%esi
40000e83:	89 d8                	mov    %ebx,%eax
40000e85:	c1 e2 18             	shl    $0x18,%edx
40000e88:	c1 e6 10             	shl    $0x10,%esi
40000e8b:	09 f2                	or     %esi,%edx
40000e8d:	c1 e0 08             	shl    $0x8,%eax
40000e90:	09 da                	or     %ebx,%edx
40000e92:	09 d0                	or     %edx,%eax
        asm volatile ("cld; rep stosl\n"
40000e94:	fc                   	cld    
40000e95:	f3 ab                	rep stos %eax,%es:(%edi)
    } else
        asm volatile ("cld; rep stosb\n"
                      :: "D" (v), "a" (c), "c" (n)
                      : "cc", "memory");
    return v;
}
40000e97:	89 f8                	mov    %edi,%eax
40000e99:	5b                   	pop    %ebx
40000e9a:	5e                   	pop    %esi
40000e9b:	5f                   	pop    %edi
40000e9c:	c3                   	ret    
40000e9d:	8d 76 00             	lea    0x0(%esi),%esi
        asm volatile ("cld; rep stosb\n"
40000ea0:	8b 44 24 14          	mov    0x14(%esp),%eax
40000ea4:	fc                   	cld    
40000ea5:	f3 aa                	rep stos %al,%es:(%edi)
}
40000ea7:	89 f8                	mov    %edi,%eax
40000ea9:	5b                   	pop    %ebx
40000eaa:	5e                   	pop    %esi
40000eab:	5f                   	pop    %edi
40000eac:	c3                   	ret    
40000ead:	8d 76 00             	lea    0x0(%esi),%esi

40000eb0 <memmove>:

void *memmove(void *dst, const void *src, size_t n)
{
40000eb0:	57                   	push   %edi
40000eb1:	56                   	push   %esi
40000eb2:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000eb6:	8b 74 24 10          	mov    0x10(%esp),%esi
40000eba:	8b 4c 24 14          	mov    0x14(%esp),%ecx
    const char *s;
    char *d;

    s = src;
    d = dst;
    if (s < d && s + n > d) {
40000ebe:	39 c6                	cmp    %eax,%esi
40000ec0:	73 26                	jae    40000ee8 <memmove+0x38>
40000ec2:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
40000ec5:	39 c2                	cmp    %eax,%edx
40000ec7:	76 1f                	jbe    40000ee8 <memmove+0x38>
        s += n;
        d += n;
40000ec9:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
40000ecc:	89 d6                	mov    %edx,%esi
40000ece:	09 fe                	or     %edi,%esi
40000ed0:	09 ce                	or     %ecx,%esi
40000ed2:	83 e6 03             	and    $0x3,%esi
40000ed5:	74 39                	je     40000f10 <memmove+0x60>
            asm volatile ("std; rep movsl\n"
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
                          : "cc", "memory");
        else
            asm volatile ("std; rep movsb\n"
                          :: "D" (d - 1), "S" (s - 1), "c" (n)
40000ed7:	83 ef 01             	sub    $0x1,%edi
40000eda:	8d 72 ff             	lea    -0x1(%edx),%esi
            asm volatile ("std; rep movsb\n"
40000edd:	fd                   	std    
40000ede:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
                          : "cc", "memory");
        // Some versions of GCC rely on DF being clear
        asm volatile ("cld" ::: "cc");
40000ee0:	fc                   	cld    
            asm volatile ("cld; rep movsb\n"
                          :: "D" (d), "S" (s), "c" (n)
                          : "cc", "memory");
    }
    return dst;
}
40000ee1:	5e                   	pop    %esi
40000ee2:	5f                   	pop    %edi
40000ee3:	c3                   	ret    
40000ee4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
40000ee8:	89 f2                	mov    %esi,%edx
40000eea:	09 c2                	or     %eax,%edx
40000eec:	09 ca                	or     %ecx,%edx
40000eee:	83 e2 03             	and    $0x3,%edx
40000ef1:	74 0d                	je     40000f00 <memmove+0x50>
            asm volatile ("cld; rep movsb\n"
40000ef3:	89 c7                	mov    %eax,%edi
40000ef5:	fc                   	cld    
40000ef6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
}
40000ef8:	5e                   	pop    %esi
40000ef9:	5f                   	pop    %edi
40000efa:	c3                   	ret    
40000efb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000eff:	90                   	nop
                          :: "D" (d), "S" (s), "c" (n / 4)
40000f00:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("cld; rep movsl\n"
40000f03:	89 c7                	mov    %eax,%edi
40000f05:	fc                   	cld    
40000f06:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000f08:	eb ee                	jmp    40000ef8 <memmove+0x48>
40000f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
40000f10:	83 ef 04             	sub    $0x4,%edi
40000f13:	8d 72 fc             	lea    -0x4(%edx),%esi
40000f16:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("std; rep movsl\n"
40000f19:	fd                   	std    
40000f1a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000f1c:	eb c2                	jmp    40000ee0 <memmove+0x30>
40000f1e:	66 90                	xchg   %ax,%ax

40000f20 <memcpy>:

void *memcpy(void *dst, const void *src, size_t n)
{
    return memmove(dst, src, n);
40000f20:	eb 8e                	jmp    40000eb0 <memmove>
40000f22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000f30 <memcmp>:
}

int memcmp(const void *v1, const void *v2, size_t n)
{
40000f30:	56                   	push   %esi
40000f31:	53                   	push   %ebx
40000f32:	8b 74 24 14          	mov    0x14(%esp),%esi
40000f36:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000f3a:	8b 44 24 10          	mov    0x10(%esp),%eax
    const uint8_t *s1 = (const uint8_t *) v1;
    const uint8_t *s2 = (const uint8_t *) v2;

    while (n-- > 0) {
40000f3e:	85 f6                	test   %esi,%esi
40000f40:	74 2e                	je     40000f70 <memcmp+0x40>
40000f42:	01 c6                	add    %eax,%esi
40000f44:	eb 14                	jmp    40000f5a <memcmp+0x2a>
40000f46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000f4d:	8d 76 00             	lea    0x0(%esi),%esi
        if (*s1 != *s2)
            return (int) *s1 - (int) *s2;
        s1++, s2++;
40000f50:	83 c0 01             	add    $0x1,%eax
40000f53:	83 c2 01             	add    $0x1,%edx
    while (n-- > 0) {
40000f56:	39 f0                	cmp    %esi,%eax
40000f58:	74 16                	je     40000f70 <memcmp+0x40>
        if (*s1 != *s2)
40000f5a:	0f b6 0a             	movzbl (%edx),%ecx
40000f5d:	0f b6 18             	movzbl (%eax),%ebx
40000f60:	38 d9                	cmp    %bl,%cl
40000f62:	74 ec                	je     40000f50 <memcmp+0x20>
            return (int) *s1 - (int) *s2;
40000f64:	0f b6 c1             	movzbl %cl,%eax
40000f67:	29 d8                	sub    %ebx,%eax
    }

    return 0;
}
40000f69:	5b                   	pop    %ebx
40000f6a:	5e                   	pop    %esi
40000f6b:	c3                   	ret    
40000f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
40000f70:	31 c0                	xor    %eax,%eax
}
40000f72:	5b                   	pop    %ebx
40000f73:	5e                   	pop    %esi
40000f74:	c3                   	ret    
40000f75:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000f80 <memchr>:

void *memchr(const void *s, int c, size_t n)
{
40000f80:	8b 44 24 04          	mov    0x4(%esp),%eax
    const void *ends = (const char *) s + n;
40000f84:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000f88:	01 c2                	add    %eax,%edx
    for (; s < ends; s++)
40000f8a:	39 d0                	cmp    %edx,%eax
40000f8c:	73 1a                	jae    40000fa8 <memchr+0x28>
        if (*(const unsigned char *) s == (unsigned char) c)
40000f8e:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
40000f93:	eb 0a                	jmp    40000f9f <memchr+0x1f>
40000f95:	8d 76 00             	lea    0x0(%esi),%esi
    for (; s < ends; s++)
40000f98:	83 c0 01             	add    $0x1,%eax
40000f9b:	39 c2                	cmp    %eax,%edx
40000f9d:	74 09                	je     40000fa8 <memchr+0x28>
        if (*(const unsigned char *) s == (unsigned char) c)
40000f9f:	38 08                	cmp    %cl,(%eax)
40000fa1:	75 f5                	jne    40000f98 <memchr+0x18>
            return (void *) s;
    return NULL;
}
40000fa3:	c3                   	ret    
40000fa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return NULL;
40000fa8:	31 c0                	xor    %eax,%eax
}
40000faa:	c3                   	ret    
40000fab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000faf:	90                   	nop

40000fb0 <memzero>:

void *memzero(void *v, size_t n)
{
40000fb0:	57                   	push   %edi
40000fb1:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000fb5:	8b 7c 24 08          	mov    0x8(%esp),%edi
    if (n == 0)
40000fb9:	85 c9                	test   %ecx,%ecx
40000fbb:	74 0f                	je     40000fcc <memzero+0x1c>
    if ((int) v % 4 == 0 && n % 4 == 0) {
40000fbd:	89 f8                	mov    %edi,%eax
40000fbf:	09 c8                	or     %ecx,%eax
40000fc1:	83 e0 03             	and    $0x3,%eax
40000fc4:	75 0a                	jne    40000fd0 <memzero+0x20>
                      :: "D" (v), "a" (c), "c" (n / 4)
40000fc6:	c1 e9 02             	shr    $0x2,%ecx
        asm volatile ("cld; rep stosl\n"
40000fc9:	fc                   	cld    
40000fca:	f3 ab                	rep stos %eax,%es:(%edi)
    return memset(v, 0, n);
}
40000fcc:	89 f8                	mov    %edi,%eax
40000fce:	5f                   	pop    %edi
40000fcf:	c3                   	ret    
        asm volatile ("cld; rep stosb\n"
40000fd0:	31 c0                	xor    %eax,%eax
40000fd2:	fc                   	cld    
40000fd3:	f3 aa                	rep stos %al,%es:(%edi)
}
40000fd5:	89 f8                	mov    %edi,%eax
40000fd7:	5f                   	pop    %edi
40000fd8:	c3                   	ret    
40000fd9:	66 90                	xchg   %ax,%ax
40000fdb:	66 90                	xchg   %ax,%ax
40000fdd:	66 90                	xchg   %ax,%ax
40000fdf:	90                   	nop

40000fe0 <__udivdi3>:
40000fe0:	f3 0f 1e fb          	endbr32 
40000fe4:	55                   	push   %ebp
40000fe5:	57                   	push   %edi
40000fe6:	56                   	push   %esi
40000fe7:	53                   	push   %ebx
40000fe8:	83 ec 1c             	sub    $0x1c,%esp
40000feb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
40000fef:	8b 6c 24 30          	mov    0x30(%esp),%ebp
40000ff3:	8b 74 24 34          	mov    0x34(%esp),%esi
40000ff7:	8b 5c 24 38          	mov    0x38(%esp),%ebx
40000ffb:	85 c0                	test   %eax,%eax
40000ffd:	75 19                	jne    40001018 <__udivdi3+0x38>
40000fff:	39 f3                	cmp    %esi,%ebx
40001001:	76 4d                	jbe    40001050 <__udivdi3+0x70>
40001003:	31 ff                	xor    %edi,%edi
40001005:	89 e8                	mov    %ebp,%eax
40001007:	89 f2                	mov    %esi,%edx
40001009:	f7 f3                	div    %ebx
4000100b:	89 fa                	mov    %edi,%edx
4000100d:	83 c4 1c             	add    $0x1c,%esp
40001010:	5b                   	pop    %ebx
40001011:	5e                   	pop    %esi
40001012:	5f                   	pop    %edi
40001013:	5d                   	pop    %ebp
40001014:	c3                   	ret    
40001015:	8d 76 00             	lea    0x0(%esi),%esi
40001018:	39 f0                	cmp    %esi,%eax
4000101a:	76 14                	jbe    40001030 <__udivdi3+0x50>
4000101c:	31 ff                	xor    %edi,%edi
4000101e:	31 c0                	xor    %eax,%eax
40001020:	89 fa                	mov    %edi,%edx
40001022:	83 c4 1c             	add    $0x1c,%esp
40001025:	5b                   	pop    %ebx
40001026:	5e                   	pop    %esi
40001027:	5f                   	pop    %edi
40001028:	5d                   	pop    %ebp
40001029:	c3                   	ret    
4000102a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40001030:	0f bd f8             	bsr    %eax,%edi
40001033:	83 f7 1f             	xor    $0x1f,%edi
40001036:	75 48                	jne    40001080 <__udivdi3+0xa0>
40001038:	39 f0                	cmp    %esi,%eax
4000103a:	72 06                	jb     40001042 <__udivdi3+0x62>
4000103c:	31 c0                	xor    %eax,%eax
4000103e:	39 eb                	cmp    %ebp,%ebx
40001040:	77 de                	ja     40001020 <__udivdi3+0x40>
40001042:	b8 01 00 00 00       	mov    $0x1,%eax
40001047:	eb d7                	jmp    40001020 <__udivdi3+0x40>
40001049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40001050:	89 d9                	mov    %ebx,%ecx
40001052:	85 db                	test   %ebx,%ebx
40001054:	75 0b                	jne    40001061 <__udivdi3+0x81>
40001056:	b8 01 00 00 00       	mov    $0x1,%eax
4000105b:	31 d2                	xor    %edx,%edx
4000105d:	f7 f3                	div    %ebx
4000105f:	89 c1                	mov    %eax,%ecx
40001061:	31 d2                	xor    %edx,%edx
40001063:	89 f0                	mov    %esi,%eax
40001065:	f7 f1                	div    %ecx
40001067:	89 c6                	mov    %eax,%esi
40001069:	89 e8                	mov    %ebp,%eax
4000106b:	89 f7                	mov    %esi,%edi
4000106d:	f7 f1                	div    %ecx
4000106f:	89 fa                	mov    %edi,%edx
40001071:	83 c4 1c             	add    $0x1c,%esp
40001074:	5b                   	pop    %ebx
40001075:	5e                   	pop    %esi
40001076:	5f                   	pop    %edi
40001077:	5d                   	pop    %ebp
40001078:	c3                   	ret    
40001079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40001080:	89 f9                	mov    %edi,%ecx
40001082:	ba 20 00 00 00       	mov    $0x20,%edx
40001087:	29 fa                	sub    %edi,%edx
40001089:	d3 e0                	shl    %cl,%eax
4000108b:	89 44 24 08          	mov    %eax,0x8(%esp)
4000108f:	89 d1                	mov    %edx,%ecx
40001091:	89 d8                	mov    %ebx,%eax
40001093:	d3 e8                	shr    %cl,%eax
40001095:	8b 4c 24 08          	mov    0x8(%esp),%ecx
40001099:	09 c1                	or     %eax,%ecx
4000109b:	89 f0                	mov    %esi,%eax
4000109d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
400010a1:	89 f9                	mov    %edi,%ecx
400010a3:	d3 e3                	shl    %cl,%ebx
400010a5:	89 d1                	mov    %edx,%ecx
400010a7:	d3 e8                	shr    %cl,%eax
400010a9:	89 f9                	mov    %edi,%ecx
400010ab:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
400010af:	89 eb                	mov    %ebp,%ebx
400010b1:	d3 e6                	shl    %cl,%esi
400010b3:	89 d1                	mov    %edx,%ecx
400010b5:	d3 eb                	shr    %cl,%ebx
400010b7:	09 f3                	or     %esi,%ebx
400010b9:	89 c6                	mov    %eax,%esi
400010bb:	89 f2                	mov    %esi,%edx
400010bd:	89 d8                	mov    %ebx,%eax
400010bf:	f7 74 24 08          	divl   0x8(%esp)
400010c3:	89 d6                	mov    %edx,%esi
400010c5:	89 c3                	mov    %eax,%ebx
400010c7:	f7 64 24 0c          	mull   0xc(%esp)
400010cb:	39 d6                	cmp    %edx,%esi
400010cd:	72 19                	jb     400010e8 <__udivdi3+0x108>
400010cf:	89 f9                	mov    %edi,%ecx
400010d1:	d3 e5                	shl    %cl,%ebp
400010d3:	39 c5                	cmp    %eax,%ebp
400010d5:	73 04                	jae    400010db <__udivdi3+0xfb>
400010d7:	39 d6                	cmp    %edx,%esi
400010d9:	74 0d                	je     400010e8 <__udivdi3+0x108>
400010db:	89 d8                	mov    %ebx,%eax
400010dd:	31 ff                	xor    %edi,%edi
400010df:	e9 3c ff ff ff       	jmp    40001020 <__udivdi3+0x40>
400010e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400010e8:	8d 43 ff             	lea    -0x1(%ebx),%eax
400010eb:	31 ff                	xor    %edi,%edi
400010ed:	e9 2e ff ff ff       	jmp    40001020 <__udivdi3+0x40>
400010f2:	66 90                	xchg   %ax,%ax
400010f4:	66 90                	xchg   %ax,%ax
400010f6:	66 90                	xchg   %ax,%ax
400010f8:	66 90                	xchg   %ax,%ax
400010fa:	66 90                	xchg   %ax,%ax
400010fc:	66 90                	xchg   %ax,%ax
400010fe:	66 90                	xchg   %ax,%ax

40001100 <__umoddi3>:
40001100:	f3 0f 1e fb          	endbr32 
40001104:	55                   	push   %ebp
40001105:	57                   	push   %edi
40001106:	56                   	push   %esi
40001107:	53                   	push   %ebx
40001108:	83 ec 1c             	sub    $0x1c,%esp
4000110b:	8b 74 24 30          	mov    0x30(%esp),%esi
4000110f:	8b 5c 24 34          	mov    0x34(%esp),%ebx
40001113:	8b 7c 24 3c          	mov    0x3c(%esp),%edi
40001117:	8b 6c 24 38          	mov    0x38(%esp),%ebp
4000111b:	89 f0                	mov    %esi,%eax
4000111d:	89 da                	mov    %ebx,%edx
4000111f:	85 ff                	test   %edi,%edi
40001121:	75 15                	jne    40001138 <__umoddi3+0x38>
40001123:	39 dd                	cmp    %ebx,%ebp
40001125:	76 39                	jbe    40001160 <__umoddi3+0x60>
40001127:	f7 f5                	div    %ebp
40001129:	89 d0                	mov    %edx,%eax
4000112b:	31 d2                	xor    %edx,%edx
4000112d:	83 c4 1c             	add    $0x1c,%esp
40001130:	5b                   	pop    %ebx
40001131:	5e                   	pop    %esi
40001132:	5f                   	pop    %edi
40001133:	5d                   	pop    %ebp
40001134:	c3                   	ret    
40001135:	8d 76 00             	lea    0x0(%esi),%esi
40001138:	39 df                	cmp    %ebx,%edi
4000113a:	77 f1                	ja     4000112d <__umoddi3+0x2d>
4000113c:	0f bd cf             	bsr    %edi,%ecx
4000113f:	83 f1 1f             	xor    $0x1f,%ecx
40001142:	89 4c 24 04          	mov    %ecx,0x4(%esp)
40001146:	75 40                	jne    40001188 <__umoddi3+0x88>
40001148:	39 df                	cmp    %ebx,%edi
4000114a:	72 04                	jb     40001150 <__umoddi3+0x50>
4000114c:	39 f5                	cmp    %esi,%ebp
4000114e:	77 dd                	ja     4000112d <__umoddi3+0x2d>
40001150:	89 da                	mov    %ebx,%edx
40001152:	89 f0                	mov    %esi,%eax
40001154:	29 e8                	sub    %ebp,%eax
40001156:	19 fa                	sbb    %edi,%edx
40001158:	eb d3                	jmp    4000112d <__umoddi3+0x2d>
4000115a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40001160:	89 e9                	mov    %ebp,%ecx
40001162:	85 ed                	test   %ebp,%ebp
40001164:	75 0b                	jne    40001171 <__umoddi3+0x71>
40001166:	b8 01 00 00 00       	mov    $0x1,%eax
4000116b:	31 d2                	xor    %edx,%edx
4000116d:	f7 f5                	div    %ebp
4000116f:	89 c1                	mov    %eax,%ecx
40001171:	89 d8                	mov    %ebx,%eax
40001173:	31 d2                	xor    %edx,%edx
40001175:	f7 f1                	div    %ecx
40001177:	89 f0                	mov    %esi,%eax
40001179:	f7 f1                	div    %ecx
4000117b:	89 d0                	mov    %edx,%eax
4000117d:	31 d2                	xor    %edx,%edx
4000117f:	eb ac                	jmp    4000112d <__umoddi3+0x2d>
40001181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40001188:	8b 44 24 04          	mov    0x4(%esp),%eax
4000118c:	ba 20 00 00 00       	mov    $0x20,%edx
40001191:	29 c2                	sub    %eax,%edx
40001193:	89 c1                	mov    %eax,%ecx
40001195:	89 e8                	mov    %ebp,%eax
40001197:	d3 e7                	shl    %cl,%edi
40001199:	89 d1                	mov    %edx,%ecx
4000119b:	89 54 24 0c          	mov    %edx,0xc(%esp)
4000119f:	d3 e8                	shr    %cl,%eax
400011a1:	89 c1                	mov    %eax,%ecx
400011a3:	8b 44 24 04          	mov    0x4(%esp),%eax
400011a7:	09 f9                	or     %edi,%ecx
400011a9:	89 df                	mov    %ebx,%edi
400011ab:	89 4c 24 08          	mov    %ecx,0x8(%esp)
400011af:	89 c1                	mov    %eax,%ecx
400011b1:	d3 e5                	shl    %cl,%ebp
400011b3:	89 d1                	mov    %edx,%ecx
400011b5:	d3 ef                	shr    %cl,%edi
400011b7:	89 c1                	mov    %eax,%ecx
400011b9:	89 f0                	mov    %esi,%eax
400011bb:	d3 e3                	shl    %cl,%ebx
400011bd:	89 d1                	mov    %edx,%ecx
400011bf:	89 fa                	mov    %edi,%edx
400011c1:	d3 e8                	shr    %cl,%eax
400011c3:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
400011c8:	09 d8                	or     %ebx,%eax
400011ca:	f7 74 24 08          	divl   0x8(%esp)
400011ce:	89 d3                	mov    %edx,%ebx
400011d0:	d3 e6                	shl    %cl,%esi
400011d2:	f7 e5                	mul    %ebp
400011d4:	89 c7                	mov    %eax,%edi
400011d6:	89 d1                	mov    %edx,%ecx
400011d8:	39 d3                	cmp    %edx,%ebx
400011da:	72 06                	jb     400011e2 <__umoddi3+0xe2>
400011dc:	75 0e                	jne    400011ec <__umoddi3+0xec>
400011de:	39 c6                	cmp    %eax,%esi
400011e0:	73 0a                	jae    400011ec <__umoddi3+0xec>
400011e2:	29 e8                	sub    %ebp,%eax
400011e4:	1b 54 24 08          	sbb    0x8(%esp),%edx
400011e8:	89 d1                	mov    %edx,%ecx
400011ea:	89 c7                	mov    %eax,%edi
400011ec:	89 f5                	mov    %esi,%ebp
400011ee:	8b 74 24 04          	mov    0x4(%esp),%esi
400011f2:	29 fd                	sub    %edi,%ebp
400011f4:	19 cb                	sbb    %ecx,%ebx
400011f6:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
400011fb:	89 d8                	mov    %ebx,%eax
400011fd:	d3 e0                	shl    %cl,%eax
400011ff:	89 f1                	mov    %esi,%ecx
40001201:	d3 ed                	shr    %cl,%ebp
40001203:	d3 eb                	shr    %cl,%ebx
40001205:	09 e8                	or     %ebp,%eax
40001207:	89 da                	mov    %ebx,%edx
40001209:	83 c4 1c             	add    $0x1c,%esp
4000120c:	5b                   	pop    %ebx
4000120d:	5e                   	pop    %esi
4000120e:	5f                   	pop    %edi
4000120f:	5d                   	pop    %ebp
40001210:	c3                   	ret    
