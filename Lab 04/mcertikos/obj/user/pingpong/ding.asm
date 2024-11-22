
obj/user/pingpong/ding:     file format elf32-i386


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
4000000d:	53                   	push   %ebx
4000000e:	e8 04 01 00 00       	call   40000117 <__x86.get_pc_thunk.bx>
40000013:	81 c3 ed 3f 00 00    	add    $0x3fed,%ebx
40000019:	51                   	push   %ecx
    printf("ding started.\n");
4000001a:	83 ec 0c             	sub    $0xc,%esp
4000001d:	8d 83 94 e1 ff ff    	lea    -0x1e6c(%ebx),%eax
40000023:	50                   	push   %eax
40000024:	e8 47 02 00 00       	call   40000270 <printf>
    return 0;
}
40000029:	83 c4 10             	add    $0x10,%esp
4000002c:	8d 65 f8             	lea    -0x8(%ebp),%esp
4000002f:	31 c0                	xor    %eax,%eax
40000031:	59                   	pop    %ecx
40000032:	5b                   	pop    %ebx
40000033:	5d                   	pop    %ebp
40000034:	8d 61 fc             	lea    -0x4(%ecx),%esp
40000037:	c3                   	ret    

40000038 <_start>:
_start:
	/*
	 * If there are arguments on the stack, then the current stack will not
	 * be aligned to a nice big power-of-two boundary.
	 */
	testl	$0x0fffffff, %esp
40000038:	f7 c4 ff ff ff 0f    	test   $0xfffffff,%esp
	jnz	args_exist
4000003e:	75 04                	jne    40000044 <args_exist>

40000040 <noargs>:

noargs:
	/* If no arguments are on the stack, push two dummy zero. */
	pushl	$0
40000040:	6a 00                	push   $0x0
	pushl	$0
40000042:	6a 00                	push   $0x0

40000044 <args_exist>:

args_exist:
	/* Jump to the C part. */
	call	main
40000044:	e8 b7 ff ff ff       	call   40000000 <main>

	/* When returning, push the return value on the stack. */
	pushl	%eax
40000049:	50                   	push   %eax

4000004a <spin>:
spin:
	jmp	spin
4000004a:	eb fe                	jmp    4000004a <spin>
4000004c:	66 90                	xchg   %ax,%ax
4000004e:	66 90                	xchg   %ax,%ax

40000050 <debug>:
#include <proc.h>
#include <stdarg.h>
#include <stdio.h>

void debug(const char *file, int line, const char *fmt, ...)
{
40000050:	53                   	push   %ebx
40000051:	e8 c1 00 00 00       	call   40000117 <__x86.get_pc_thunk.bx>
40000056:	81 c3 aa 3f 00 00    	add    $0x3faa,%ebx
4000005c:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[D] %s:%d: ", file, line);
4000005f:	ff 74 24 18          	push   0x18(%esp)
40000063:	ff 74 24 18          	push   0x18(%esp)
40000067:	8d 83 00 e0 ff ff    	lea    -0x2000(%ebx),%eax
4000006d:	50                   	push   %eax
4000006e:	e8 fd 01 00 00       	call   40000270 <printf>
    vcprintf(fmt, ap);
40000073:	58                   	pop    %eax
40000074:	5a                   	pop    %edx
40000075:	8d 44 24 24          	lea    0x24(%esp),%eax
40000079:	50                   	push   %eax
4000007a:	ff 74 24 24          	push   0x24(%esp)
4000007e:	e8 8d 01 00 00       	call   40000210 <vcprintf>
    va_end(ap);
}
40000083:	83 c4 18             	add    $0x18,%esp
40000086:	5b                   	pop    %ebx
40000087:	c3                   	ret    
40000088:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000008f:	90                   	nop

40000090 <warn>:

void warn(const char *file, int line, const char *fmt, ...)
{
40000090:	53                   	push   %ebx
40000091:	e8 81 00 00 00       	call   40000117 <__x86.get_pc_thunk.bx>
40000096:	81 c3 6a 3f 00 00    	add    $0x3f6a,%ebx
4000009c:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[W] %s:%d: ", file, line);
4000009f:	ff 74 24 18          	push   0x18(%esp)
400000a3:	ff 74 24 18          	push   0x18(%esp)
400000a7:	8d 83 0c e0 ff ff    	lea    -0x1ff4(%ebx),%eax
400000ad:	50                   	push   %eax
400000ae:	e8 bd 01 00 00       	call   40000270 <printf>
    vcprintf(fmt, ap);
400000b3:	58                   	pop    %eax
400000b4:	5a                   	pop    %edx
400000b5:	8d 44 24 24          	lea    0x24(%esp),%eax
400000b9:	50                   	push   %eax
400000ba:	ff 74 24 24          	push   0x24(%esp)
400000be:	e8 4d 01 00 00       	call   40000210 <vcprintf>
    va_end(ap);
}
400000c3:	83 c4 18             	add    $0x18,%esp
400000c6:	5b                   	pop    %ebx
400000c7:	c3                   	ret    
400000c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400000cf:	90                   	nop

400000d0 <panic>:

void panic(const char *file, int line, const char *fmt, ...)
{
400000d0:	53                   	push   %ebx
400000d1:	e8 41 00 00 00       	call   40000117 <__x86.get_pc_thunk.bx>
400000d6:	81 c3 2a 3f 00 00    	add    $0x3f2a,%ebx
400000dc:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[P] %s:%d: ", file, line);
400000df:	ff 74 24 18          	push   0x18(%esp)
400000e3:	ff 74 24 18          	push   0x18(%esp)
400000e7:	8d 83 18 e0 ff ff    	lea    -0x1fe8(%ebx),%eax
400000ed:	50                   	push   %eax
400000ee:	e8 7d 01 00 00       	call   40000270 <printf>
    vcprintf(fmt, ap);
400000f3:	58                   	pop    %eax
400000f4:	5a                   	pop    %edx
400000f5:	8d 44 24 24          	lea    0x24(%esp),%eax
400000f9:	50                   	push   %eax
400000fa:	ff 74 24 24          	push   0x24(%esp)
400000fe:	e8 0d 01 00 00       	call   40000210 <vcprintf>
40000103:	83 c4 10             	add    $0x10,%esp
40000106:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000010d:	8d 76 00             	lea    0x0(%esi),%esi
    va_end(ap);

    while (1)
        yield();
40000110:	e8 3b 09 00 00       	call   40000a50 <yield>
    while (1)
40000115:	eb f9                	jmp    40000110 <panic+0x40>

40000117 <__x86.get_pc_thunk.bx>:
40000117:	8b 1c 24             	mov    (%esp),%ebx
4000011a:	c3                   	ret    
4000011b:	66 90                	xchg   %ax,%ax
4000011d:	66 90                	xchg   %ax,%ax
4000011f:	90                   	nop

40000120 <atoi>:
#include <stdlib.h>

int atoi(const char *buf, int *i)
{
40000120:	55                   	push   %ebp
40000121:	57                   	push   %edi
40000122:	56                   	push   %esi
40000123:	53                   	push   %ebx
    int loc = 0;
    int numstart = 0;
    int acc = 0;
    int negative = 0;
    if (buf[loc] == '+')
40000124:	8b 44 24 14          	mov    0x14(%esp),%eax
40000128:	0f b6 00             	movzbl (%eax),%eax
4000012b:	3c 2b                	cmp    $0x2b,%al
4000012d:	0f 84 85 00 00 00    	je     400001b8 <atoi+0x98>
    int negative = 0;
40000133:	31 ff                	xor    %edi,%edi
    int loc = 0;
40000135:	31 f6                	xor    %esi,%esi
        loc++;
    else if (buf[loc] == '-') {
40000137:	3c 2d                	cmp    $0x2d,%al
40000139:	74 55                	je     40000190 <atoi+0x70>
        negative = 1;
        loc++;
    }
    numstart = loc;
    // no grab the numbers
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000013b:	8d 50 d0             	lea    -0x30(%eax),%edx
4000013e:	80 fa 09             	cmp    $0x9,%dl
40000141:	77 67                	ja     400001aa <atoi+0x8a>
40000143:	89 f2                	mov    %esi,%edx
    int acc = 0;
40000145:	31 c9                	xor    %ecx,%ecx
40000147:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000014e:	66 90                	xchg   %ax,%ax
        acc = acc * 10 + (buf[loc] - '0');
40000150:	83 e8 30             	sub    $0x30,%eax
40000153:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
        loc++;
40000156:	83 c2 01             	add    $0x1,%edx
        acc = acc * 10 + (buf[loc] - '0');
40000159:	0f be c0             	movsbl %al,%eax
4000015c:	8d 0c 48             	lea    (%eax,%ecx,2),%ecx
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000015f:	8b 44 24 14          	mov    0x14(%esp),%eax
40000163:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
40000167:	8d 68 d0             	lea    -0x30(%eax),%ebp
4000016a:	89 eb                	mov    %ebp,%ebx
4000016c:	80 fb 09             	cmp    $0x9,%bl
4000016f:	76 df                	jbe    40000150 <atoi+0x30>
    }
    if (numstart == loc) {
40000171:	39 d6                	cmp    %edx,%esi
40000173:	74 35                	je     400001aa <atoi+0x8a>
        // no numbers have actually been scanned
        return 0;
    }
    if (negative)
        acc = -acc;
40000175:	89 c8                	mov    %ecx,%eax
40000177:	f7 d8                	neg    %eax
40000179:	85 ff                	test   %edi,%edi
4000017b:	0f 45 c8             	cmovne %eax,%ecx
    *i = acc;
4000017e:	8b 44 24 18          	mov    0x18(%esp),%eax
40000182:	89 08                	mov    %ecx,(%eax)
    return loc;
}
40000184:	89 d0                	mov    %edx,%eax
40000186:	5b                   	pop    %ebx
40000187:	5e                   	pop    %esi
40000188:	5f                   	pop    %edi
40000189:	5d                   	pop    %ebp
4000018a:	c3                   	ret    
4000018b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
4000018f:	90                   	nop
    while ('0' <= buf[loc] && buf[loc] <= '9') {
40000190:	8b 44 24 14          	mov    0x14(%esp),%eax
        negative = 1;
40000194:	bf 01 00 00 00       	mov    $0x1,%edi
        loc++;
40000199:	be 01 00 00 00       	mov    $0x1,%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000019e:	0f b6 40 01          	movzbl 0x1(%eax),%eax
400001a2:	8d 50 d0             	lea    -0x30(%eax),%edx
400001a5:	80 fa 09             	cmp    $0x9,%dl
400001a8:	76 99                	jbe    40000143 <atoi+0x23>
        return 0;
400001aa:	31 d2                	xor    %edx,%edx
}
400001ac:	5b                   	pop    %ebx
400001ad:	5e                   	pop    %esi
400001ae:	89 d0                	mov    %edx,%eax
400001b0:	5f                   	pop    %edi
400001b1:	5d                   	pop    %ebp
400001b2:	c3                   	ret    
400001b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400001b7:	90                   	nop
    while ('0' <= buf[loc] && buf[loc] <= '9') {
400001b8:	8b 44 24 14          	mov    0x14(%esp),%eax
    int negative = 0;
400001bc:	31 ff                	xor    %edi,%edi
        loc++;
400001be:	be 01 00 00 00       	mov    $0x1,%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
400001c3:	0f b6 40 01          	movzbl 0x1(%eax),%eax
400001c7:	e9 6f ff ff ff       	jmp    4000013b <atoi+0x1b>
400001cc:	66 90                	xchg   %ax,%ax
400001ce:	66 90                	xchg   %ax,%ax

400001d0 <putch>:
    int cnt;            // total bytes printed so far
    char buf[MAX_BUF];
};

static void putch(int ch, struct printbuf *b)
{
400001d0:	53                   	push   %ebx
400001d1:	8b 54 24 0c          	mov    0xc(%esp),%edx
    b->buf[b->idx++] = ch;
400001d5:	0f b6 5c 24 08       	movzbl 0x8(%esp),%ebx
400001da:	8b 02                	mov    (%edx),%eax
400001dc:	8d 48 01             	lea    0x1(%eax),%ecx
400001df:	89 0a                	mov    %ecx,(%edx)
400001e1:	88 5c 02 08          	mov    %bl,0x8(%edx,%eax,1)
    if (b->idx == MAX_BUF - 1) {
400001e5:	81 f9 ff 01 00 00    	cmp    $0x1ff,%ecx
400001eb:	75 14                	jne    40000201 <putch+0x31>
        b->buf[b->idx] = 0;
400001ed:	c6 82 07 02 00 00 00 	movb   $0x0,0x207(%edx)
        puts(b->buf, b->idx);
400001f4:	8d 5a 08             	lea    0x8(%edx),%ebx
#include <types.h>
#include <x86.h>

static gcc_inline void sys_puts(const char *s, size_t len)
{
    asm volatile ("int %0"
400001f7:	31 c0                	xor    %eax,%eax
400001f9:	cd 30                	int    $0x30
        b->idx = 0;
400001fb:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
    }
    b->cnt++;
40000201:	83 42 04 01          	addl   $0x1,0x4(%edx)
}
40000205:	5b                   	pop    %ebx
40000206:	c3                   	ret    
40000207:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000020e:	66 90                	xchg   %ax,%ax

40000210 <vcprintf>:

int vcprintf(const char *fmt, va_list ap)
{
40000210:	53                   	push   %ebx
40000211:	e8 01 ff ff ff       	call   40000117 <__x86.get_pc_thunk.bx>
40000216:	81 c3 ea 3d 00 00    	add    $0x3dea,%ebx
4000021c:	81 ec 18 02 00 00    	sub    $0x218,%esp
    struct printbuf b;

    b.idx = 0;
40000222:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
40000229:	00 
    b.cnt = 0;
4000022a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000231:	00 
    vprintfmt((void *) putch, &b, fmt, ap);
40000232:	ff b4 24 24 02 00 00 	push   0x224(%esp)
40000239:	ff b4 24 24 02 00 00 	push   0x224(%esp)
40000240:	8d 44 24 10          	lea    0x10(%esp),%eax
40000244:	50                   	push   %eax
40000245:	8d 83 d0 c1 ff ff    	lea    -0x3e30(%ebx),%eax
4000024b:	50                   	push   %eax
4000024c:	e8 3f 01 00 00       	call   40000390 <vprintfmt>

    b.buf[b.idx] = 0;
40000251:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000255:	8d 5c 24 20          	lea    0x20(%esp),%ebx
40000259:	31 c0                	xor    %eax,%eax
4000025b:	c6 44 0c 20 00       	movb   $0x0,0x20(%esp,%ecx,1)
40000260:	cd 30                	int    $0x30
    puts(b.buf, b.idx);

    return b.cnt;
}
40000262:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000266:	81 c4 28 02 00 00    	add    $0x228,%esp
4000026c:	5b                   	pop    %ebx
4000026d:	c3                   	ret    
4000026e:	66 90                	xchg   %ax,%ax

40000270 <printf>:

int printf(const char *fmt, ...)
{
40000270:	83 ec 14             	sub    $0x14,%esp
    va_list ap;
    int cnt;

    va_start(ap, fmt);
    cnt = vcprintf(fmt, ap);
40000273:	8d 44 24 1c          	lea    0x1c(%esp),%eax
40000277:	50                   	push   %eax
40000278:	ff 74 24 1c          	push   0x1c(%esp)
4000027c:	e8 8f ff ff ff       	call   40000210 <vcprintf>
    va_end(ap);

    return cnt;
}
40000281:	83 c4 1c             	add    $0x1c,%esp
40000284:	c3                   	ret    
40000285:	66 90                	xchg   %ax,%ax
40000287:	66 90                	xchg   %ax,%ax
40000289:	66 90                	xchg   %ax,%ax
4000028b:	66 90                	xchg   %ax,%ax
4000028d:	66 90                	xchg   %ax,%ax
4000028f:	90                   	nop

40000290 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void *), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
40000290:	e8 96 07 00 00       	call   40000a2b <__x86.get_pc_thunk.cx>
40000295:	81 c1 6b 3d 00 00    	add    $0x3d6b,%ecx
4000029b:	55                   	push   %ebp
4000029c:	57                   	push   %edi
4000029d:	89 d7                	mov    %edx,%edi
4000029f:	56                   	push   %esi
400002a0:	89 c6                	mov    %eax,%esi
400002a2:	53                   	push   %ebx
400002a3:	83 ec 2c             	sub    $0x2c,%esp
400002a6:	8b 54 24 44          	mov    0x44(%esp),%edx
400002aa:	8b 44 24 40          	mov    0x40(%esp),%eax
400002ae:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, num / base, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (--width > 0)
400002b2:	8b 4c 24 4c          	mov    0x4c(%esp),%ecx
{
400002b6:	8b 5c 24 50          	mov    0x50(%esp),%ebx
    if (num >= base) {
400002ba:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
400002c1:	00 
{
400002c2:	89 54 24 0c          	mov    %edx,0xc(%esp)
400002c6:	8b 54 24 48          	mov    0x48(%esp),%edx
400002ca:	89 44 24 08          	mov    %eax,0x8(%esp)
    if (num >= base) {
400002ce:	8b 44 24 0c          	mov    0xc(%esp),%eax
        while (--width > 0)
400002d2:	8d 69 ff             	lea    -0x1(%ecx),%ebp
    if (num >= base) {
400002d5:	39 54 24 08          	cmp    %edx,0x8(%esp)
400002d9:	1b 44 24 14          	sbb    0x14(%esp),%eax
400002dd:	89 54 24 10          	mov    %edx,0x10(%esp)
400002e1:	73 55                	jae    40000338 <printnum+0xa8>
        while (--width > 0)
400002e3:	85 ed                	test   %ebp,%ebp
400002e5:	7e 18                	jle    400002ff <printnum+0x6f>
400002e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400002ee:	66 90                	xchg   %ax,%ax
            putch(padc, putdat);
400002f0:	83 ec 08             	sub    $0x8,%esp
400002f3:	57                   	push   %edi
400002f4:	53                   	push   %ebx
400002f5:	ff d6                	call   *%esi
        while (--width > 0)
400002f7:	83 c4 10             	add    $0x10,%esp
400002fa:	83 ed 01             	sub    $0x1,%ebp
400002fd:	75 f1                	jne    400002f0 <printnum+0x60>
    }

    // then print this (the least significant) digit
    putch("0123456789abcdef"[num % base], putdat);
400002ff:	89 7c 24 44          	mov    %edi,0x44(%esp)
40000303:	ff 74 24 14          	push   0x14(%esp)
40000307:	ff 74 24 14          	push   0x14(%esp)
4000030b:	ff 74 24 14          	push   0x14(%esp)
4000030f:	ff 74 24 14          	push   0x14(%esp)
40000313:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
40000317:	e8 a4 0d 00 00       	call   400010c0 <__umoddi3>
4000031c:	0f be 84 03 24 e0 ff 	movsbl -0x1fdc(%ebx,%eax,1),%eax
40000323:	ff 
40000324:	89 44 24 50          	mov    %eax,0x50(%esp)
}
40000328:	83 c4 3c             	add    $0x3c,%esp
    putch("0123456789abcdef"[num % base], putdat);
4000032b:	89 f0                	mov    %esi,%eax
}
4000032d:	5b                   	pop    %ebx
4000032e:	5e                   	pop    %esi
4000032f:	5f                   	pop    %edi
40000330:	5d                   	pop    %ebp
    putch("0123456789abcdef"[num % base], putdat);
40000331:	ff e0                	jmp    *%eax
40000333:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000337:	90                   	nop
        printnum(putch, putdat, num / base, base, width - 1, padc);
40000338:	83 ec 0c             	sub    $0xc,%esp
4000033b:	53                   	push   %ebx
4000033c:	55                   	push   %ebp
4000033d:	52                   	push   %edx
4000033e:	83 ec 08             	sub    $0x8,%esp
40000341:	ff 74 24 34          	push   0x34(%esp)
40000345:	ff 74 24 34          	push   0x34(%esp)
40000349:	ff 74 24 34          	push   0x34(%esp)
4000034d:	ff 74 24 34          	push   0x34(%esp)
40000351:	8b 5c 24 4c          	mov    0x4c(%esp),%ebx
40000355:	e8 46 0c 00 00       	call   40000fa0 <__udivdi3>
4000035a:	83 c4 18             	add    $0x18,%esp
4000035d:	52                   	push   %edx
4000035e:	89 fa                	mov    %edi,%edx
40000360:	50                   	push   %eax
40000361:	89 f0                	mov    %esi,%eax
40000363:	e8 28 ff ff ff       	call   40000290 <printnum>
40000368:	83 c4 20             	add    $0x20,%esp
4000036b:	eb 92                	jmp    400002ff <printnum+0x6f>
4000036d:	8d 76 00             	lea    0x0(%esi),%esi

40000370 <sprintputch>:
    char *ebuf;
    int cnt;
};

static void sprintputch(int ch, struct sprintbuf *b)
{
40000370:	8b 44 24 08          	mov    0x8(%esp),%eax
    b->cnt++;
40000374:	83 40 08 01          	addl   $0x1,0x8(%eax)
    if (b->buf < b->ebuf)
40000378:	8b 10                	mov    (%eax),%edx
4000037a:	3b 50 04             	cmp    0x4(%eax),%edx
4000037d:	73 0b                	jae    4000038a <sprintputch+0x1a>
        *b->buf++ = ch;
4000037f:	8d 4a 01             	lea    0x1(%edx),%ecx
40000382:	89 08                	mov    %ecx,(%eax)
40000384:	8b 44 24 04          	mov    0x4(%esp),%eax
40000388:	88 02                	mov    %al,(%edx)
}
4000038a:	c3                   	ret    
4000038b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
4000038f:	90                   	nop

40000390 <vprintfmt>:
{
40000390:	e8 8e 06 00 00       	call   40000a23 <__x86.get_pc_thunk.ax>
40000395:	05 6b 3c 00 00       	add    $0x3c6b,%eax
4000039a:	55                   	push   %ebp
4000039b:	57                   	push   %edi
4000039c:	56                   	push   %esi
4000039d:	53                   	push   %ebx
4000039e:	83 ec 3c             	sub    $0x3c,%esp
400003a1:	8b 74 24 50          	mov    0x50(%esp),%esi
400003a5:	8b 6c 24 54          	mov    0x54(%esp),%ebp
400003a9:	89 44 24 14          	mov    %eax,0x14(%esp)
                for (width -= strnlen(p, precision); width > 0; width--)
400003ad:	8d 80 35 e0 ff ff    	lea    -0x1fcb(%eax),%eax
400003b3:	89 44 24 24          	mov    %eax,0x24(%esp)
{
400003b7:	8b 7c 24 58          	mov    0x58(%esp),%edi
        while ((ch = *(unsigned char *) fmt++) != '%') {
400003bb:	0f b6 07             	movzbl (%edi),%eax
400003be:	8d 5f 01             	lea    0x1(%edi),%ebx
400003c1:	83 f8 25             	cmp    $0x25,%eax
400003c4:	75 20                	jne    400003e6 <vprintfmt+0x56>
400003c6:	eb 30                	jmp    400003f8 <vprintfmt+0x68>
400003c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400003cf:	90                   	nop
            putch(ch, putdat);
400003d0:	83 ec 08             	sub    $0x8,%esp
        while ((ch = *(unsigned char *) fmt++) != '%') {
400003d3:	83 c3 01             	add    $0x1,%ebx
            putch(ch, putdat);
400003d6:	55                   	push   %ebp
400003d7:	50                   	push   %eax
400003d8:	ff d6                	call   *%esi
        while ((ch = *(unsigned char *) fmt++) != '%') {
400003da:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
400003de:	83 c4 10             	add    $0x10,%esp
400003e1:	83 f8 25             	cmp    $0x25,%eax
400003e4:	74 12                	je     400003f8 <vprintfmt+0x68>
            if (ch == '\0')
400003e6:	85 c0                	test   %eax,%eax
400003e8:	75 e6                	jne    400003d0 <vprintfmt+0x40>
}
400003ea:	83 c4 3c             	add    $0x3c,%esp
400003ed:	5b                   	pop    %ebx
400003ee:	5e                   	pop    %esi
400003ef:	5f                   	pop    %edi
400003f0:	5d                   	pop    %ebp
400003f1:	c3                   	ret    
400003f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        precision = -1;
400003f8:	ba ff ff ff ff       	mov    $0xffffffff,%edx
        padc = ' ';
400003fd:	c6 44 24 18 20       	movb   $0x20,0x18(%esp)
        altflag = 0;
40000402:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
40000409:	00 
        width = -1;
4000040a:	c7 44 24 10 ff ff ff 	movl   $0xffffffff,0x10(%esp)
40000411:	ff 
        lflag = 0;
40000412:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%esp)
40000419:	00 
4000041a:	89 54 24 1c          	mov    %edx,0x1c(%esp)
4000041e:	89 74 24 50          	mov    %esi,0x50(%esp)
        switch (ch = *(unsigned char *) fmt++) {
40000422:	0f b6 0b             	movzbl (%ebx),%ecx
40000425:	8d 7b 01             	lea    0x1(%ebx),%edi
40000428:	8d 41 dd             	lea    -0x23(%ecx),%eax
4000042b:	3c 55                	cmp    $0x55,%al
4000042d:	77 19                	ja     40000448 <.L20>
4000042f:	8b 54 24 14          	mov    0x14(%esp),%edx
40000433:	0f b6 c0             	movzbl %al,%eax
40000436:	8b b4 82 3c e0 ff ff 	mov    -0x1fc4(%edx,%eax,4),%esi
4000043d:	01 d6                	add    %edx,%esi
4000043f:	ff e6                	jmp    *%esi
40000441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000448 <.L20>:
            putch('%', putdat);
40000448:	8b 74 24 50          	mov    0x50(%esp),%esi
4000044c:	83 ec 08             	sub    $0x8,%esp
            for (fmt--; fmt[-1] != '%'; fmt--)
4000044f:	89 df                	mov    %ebx,%edi
            putch('%', putdat);
40000451:	55                   	push   %ebp
40000452:	6a 25                	push   $0x25
40000454:	ff d6                	call   *%esi
            for (fmt--; fmt[-1] != '%'; fmt--)
40000456:	83 c4 10             	add    $0x10,%esp
40000459:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
4000045d:	0f 84 58 ff ff ff    	je     400003bb <vprintfmt+0x2b>
40000463:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000467:	90                   	nop
40000468:	83 ef 01             	sub    $0x1,%edi
4000046b:	80 7f ff 25          	cmpb   $0x25,-0x1(%edi)
4000046f:	75 f7                	jne    40000468 <.L20+0x20>
40000471:	e9 45 ff ff ff       	jmp    400003bb <vprintfmt+0x2b>
40000476:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000047d:	8d 76 00             	lea    0x0(%esi),%esi

40000480 <.L30>:
                ch = *fmt;
40000480:	0f be 43 01          	movsbl 0x1(%ebx),%eax
                precision = precision * 10 + ch - '0';
40000484:	8d 51 d0             	lea    -0x30(%ecx),%edx
        switch (ch = *(unsigned char *) fmt++) {
40000487:	89 fb                	mov    %edi,%ebx
                precision = precision * 10 + ch - '0';
40000489:	89 54 24 1c          	mov    %edx,0x1c(%esp)
                if (ch < '0' || ch > '9')
4000048d:	8d 48 d0             	lea    -0x30(%eax),%ecx
40000490:	83 f9 09             	cmp    $0x9,%ecx
40000493:	77 28                	ja     400004bd <.L30+0x3d>
        switch (ch = *(unsigned char *) fmt++) {
40000495:	8b 74 24 50          	mov    0x50(%esp),%esi
40000499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            for (precision = 0;; ++fmt) {
400004a0:	83 c3 01             	add    $0x1,%ebx
                precision = precision * 10 + ch - '0';
400004a3:	8d 14 92             	lea    (%edx,%edx,4),%edx
400004a6:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
                ch = *fmt;
400004aa:	0f be 03             	movsbl (%ebx),%eax
                if (ch < '0' || ch > '9')
400004ad:	8d 48 d0             	lea    -0x30(%eax),%ecx
400004b0:	83 f9 09             	cmp    $0x9,%ecx
400004b3:	76 eb                	jbe    400004a0 <.L30+0x20>
400004b5:	89 54 24 1c          	mov    %edx,0x1c(%esp)
400004b9:	89 74 24 50          	mov    %esi,0x50(%esp)
            if (width < 0)
400004bd:	8b 74 24 10          	mov    0x10(%esp),%esi
400004c1:	85 f6                	test   %esi,%esi
400004c3:	0f 89 59 ff ff ff    	jns    40000422 <vprintfmt+0x92>
                width = precision, precision = -1;
400004c9:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400004cd:	c7 44 24 1c ff ff ff 	movl   $0xffffffff,0x1c(%esp)
400004d4:	ff 
400004d5:	89 44 24 10          	mov    %eax,0x10(%esp)
400004d9:	e9 44 ff ff ff       	jmp    40000422 <vprintfmt+0x92>

400004de <.L35>:
            altflag = 1;
400004de:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
400004e5:	00 
        switch (ch = *(unsigned char *) fmt++) {
400004e6:	89 fb                	mov    %edi,%ebx
            goto reswitch;
400004e8:	e9 35 ff ff ff       	jmp    40000422 <vprintfmt+0x92>

400004ed <.L34>:
            putch(ch, putdat);
400004ed:	8b 74 24 50          	mov    0x50(%esp),%esi
400004f1:	83 ec 08             	sub    $0x8,%esp
400004f4:	55                   	push   %ebp
400004f5:	6a 25                	push   $0x25
400004f7:	ff d6                	call   *%esi
            break;
400004f9:	83 c4 10             	add    $0x10,%esp
400004fc:	e9 ba fe ff ff       	jmp    400003bb <vprintfmt+0x2b>

40000501 <.L33>:
            precision = va_arg(ap, int);
40000501:	8b 44 24 5c          	mov    0x5c(%esp),%eax
        switch (ch = *(unsigned char *) fmt++) {
40000505:	89 fb                	mov    %edi,%ebx
            precision = va_arg(ap, int);
40000507:	8b 00                	mov    (%eax),%eax
40000509:	89 44 24 1c          	mov    %eax,0x1c(%esp)
4000050d:	8b 44 24 5c          	mov    0x5c(%esp),%eax
40000511:	83 c0 04             	add    $0x4,%eax
40000514:	89 44 24 5c          	mov    %eax,0x5c(%esp)
            goto process_precision;
40000518:	eb a3                	jmp    400004bd <.L30+0x3d>

4000051a <.L32>:
            if (width < 0)
4000051a:	8b 4c 24 10          	mov    0x10(%esp),%ecx
4000051e:	31 c0                	xor    %eax,%eax
        switch (ch = *(unsigned char *) fmt++) {
40000520:	89 fb                	mov    %edi,%ebx
40000522:	85 c9                	test   %ecx,%ecx
40000524:	0f 49 c1             	cmovns %ecx,%eax
40000527:	89 44 24 10          	mov    %eax,0x10(%esp)
            goto reswitch;
4000052b:	e9 f2 fe ff ff       	jmp    40000422 <vprintfmt+0x92>

40000530 <.L29>:
            putch(va_arg(ap, int), putdat);
40000530:	8b 44 24 5c          	mov    0x5c(%esp),%eax
40000534:	8b 74 24 50          	mov    0x50(%esp),%esi
40000538:	83 ec 08             	sub    $0x8,%esp
4000053b:	55                   	push   %ebp
4000053c:	8d 58 04             	lea    0x4(%eax),%ebx
4000053f:	8b 44 24 68          	mov    0x68(%esp),%eax
40000543:	ff 30                	push   (%eax)
40000545:	ff d6                	call   *%esi
40000547:	89 5c 24 6c          	mov    %ebx,0x6c(%esp)
            break;
4000054b:	83 c4 10             	add    $0x10,%esp
4000054e:	e9 68 fe ff ff       	jmp    400003bb <vprintfmt+0x2b>

40000553 <.L23>:
    if (lflag >= 2)
40000553:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
40000558:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, unsigned long long);
4000055c:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
40000560:	0f 8f d7 01 00 00    	jg     4000073d <.L24+0xe0>
        return va_arg(*ap, unsigned long);
40000566:	8b 4c 24 5c          	mov    0x5c(%esp),%ecx
            precision = va_arg(ap, int);
4000056a:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
4000056d:	31 db                	xor    %ebx,%ebx
4000056f:	ba 0a 00 00 00       	mov    $0xa,%edx
40000574:	8b 09                	mov    (%ecx),%ecx
40000576:	89 44 24 5c          	mov    %eax,0x5c(%esp)
4000057a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            printnum(putch, putdat, num, base, width, padc);
40000580:	83 ec 0c             	sub    $0xc,%esp
40000583:	0f be 44 24 24       	movsbl 0x24(%esp),%eax
40000588:	50                   	push   %eax
40000589:	89 f0                	mov    %esi,%eax
4000058b:	ff 74 24 20          	push   0x20(%esp)
4000058f:	52                   	push   %edx
40000590:	89 ea                	mov    %ebp,%edx
40000592:	53                   	push   %ebx
40000593:	51                   	push   %ecx
40000594:	e8 f7 fc ff ff       	call   40000290 <printnum>
            break;
40000599:	83 c4 20             	add    $0x20,%esp
4000059c:	e9 1a fe ff ff       	jmp    400003bb <vprintfmt+0x2b>

400005a1 <.L25>:
            putch('0', putdat);
400005a1:	8b 74 24 50          	mov    0x50(%esp),%esi
400005a5:	83 ec 08             	sub    $0x8,%esp
400005a8:	55                   	push   %ebp
400005a9:	6a 30                	push   $0x30
400005ab:	ff d6                	call   *%esi
            putch('x', putdat);
400005ad:	59                   	pop    %ecx
400005ae:	5b                   	pop    %ebx
400005af:	55                   	push   %ebp
400005b0:	6a 78                	push   $0x78
            num = (unsigned long long)
400005b2:	31 db                	xor    %ebx,%ebx
            putch('x', putdat);
400005b4:	ff d6                	call   *%esi
            num = (unsigned long long)
400005b6:	8b 44 24 6c          	mov    0x6c(%esp),%eax
            goto number;
400005ba:	ba 10 00 00 00       	mov    $0x10,%edx
            num = (unsigned long long)
400005bf:	8b 08                	mov    (%eax),%ecx
            goto number;
400005c1:	83 c4 10             	add    $0x10,%esp
                (uintptr_t) va_arg(ap, void *);
400005c4:	83 c0 04             	add    $0x4,%eax
400005c7:	89 44 24 5c          	mov    %eax,0x5c(%esp)
            goto number;
400005cb:	eb b3                	jmp    40000580 <.L23+0x2d>

400005cd <.L21>:
    if (lflag >= 2)
400005cd:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
400005d2:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, unsigned long long);
400005d6:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
400005da:	0f 8f 6e 01 00 00    	jg     4000074e <.L24+0xf1>
        return va_arg(*ap, unsigned long);
400005e0:	8b 4c 24 5c          	mov    0x5c(%esp),%ecx
            precision = va_arg(ap, int);
400005e4:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
400005e7:	31 db                	xor    %ebx,%ebx
400005e9:	ba 10 00 00 00       	mov    $0x10,%edx
400005ee:	8b 09                	mov    (%ecx),%ecx
400005f0:	89 44 24 5c          	mov    %eax,0x5c(%esp)
400005f4:	eb 8a                	jmp    40000580 <.L23+0x2d>

400005f6 <.L28>:
    if (lflag >= 2)
400005f6:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
400005fb:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, long long);
400005ff:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
40000603:	0f 8f 5b 01 00 00    	jg     40000764 <.L24+0x107>
        return va_arg(*ap, long);
40000609:	8b 00                	mov    (%eax),%eax
4000060b:	89 c3                	mov    %eax,%ebx
4000060d:	89 c1                	mov    %eax,%ecx
4000060f:	8b 44 24 5c          	mov    0x5c(%esp),%eax
40000613:	c1 fb 1f             	sar    $0x1f,%ebx
40000616:	83 c0 04             	add    $0x4,%eax
40000619:	89 44 24 5c          	mov    %eax,0x5c(%esp)
            if ((long long) num < 0) {
4000061d:	85 db                	test   %ebx,%ebx
4000061f:	0f 88 68 01 00 00    	js     4000078d <.L31+0xc>
        return va_arg(*ap, unsigned long long);
40000625:	ba 0a 00 00 00       	mov    $0xa,%edx
4000062a:	e9 51 ff ff ff       	jmp    40000580 <.L23+0x2d>

4000062f <.L27>:
            lflag++;
4000062f:	83 44 24 20 01       	addl   $0x1,0x20(%esp)
        switch (ch = *(unsigned char *) fmt++) {
40000634:	89 fb                	mov    %edi,%ebx
            goto reswitch;
40000636:	e9 e7 fd ff ff       	jmp    40000422 <vprintfmt+0x92>

4000063b <.L26>:
            putch('X', putdat);
4000063b:	8b 74 24 50          	mov    0x50(%esp),%esi
4000063f:	83 ec 08             	sub    $0x8,%esp
40000642:	55                   	push   %ebp
40000643:	6a 58                	push   $0x58
40000645:	ff d6                	call   *%esi
            putch('X', putdat);
40000647:	58                   	pop    %eax
40000648:	5a                   	pop    %edx
40000649:	55                   	push   %ebp
4000064a:	6a 58                	push   $0x58
4000064c:	ff d6                	call   *%esi
            putch('X', putdat);
4000064e:	59                   	pop    %ecx
4000064f:	5b                   	pop    %ebx
40000650:	55                   	push   %ebp
40000651:	6a 58                	push   $0x58
40000653:	ff d6                	call   *%esi
            break;
40000655:	83 c4 10             	add    $0x10,%esp
40000658:	e9 5e fd ff ff       	jmp    400003bb <vprintfmt+0x2b>

4000065d <.L24>:
            if ((p = va_arg(ap, char *)) == NULL)
4000065d:	8b 44 24 5c          	mov    0x5c(%esp),%eax
            if (width > 0 && padc != '-')
40000661:	8b 5c 24 10          	mov    0x10(%esp),%ebx
            if ((p = va_arg(ap, char *)) == NULL)
40000665:	8b 54 24 1c          	mov    0x1c(%esp),%edx
40000669:	8b 74 24 50          	mov    0x50(%esp),%esi
4000066d:	83 c0 04             	add    $0x4,%eax
            if (width > 0 && padc != '-')
40000670:	80 7c 24 18 2d       	cmpb   $0x2d,0x18(%esp)
            if ((p = va_arg(ap, char *)) == NULL)
40000675:	89 44 24 1c          	mov    %eax,0x1c(%esp)
40000679:	8b 44 24 5c          	mov    0x5c(%esp),%eax
4000067d:	8b 08                	mov    (%eax),%ecx
            if (width > 0 && padc != '-')
4000067f:	0f 95 c0             	setne  %al
40000682:	85 db                	test   %ebx,%ebx
40000684:	0f 9f c3             	setg   %bl
40000687:	21 d8                	and    %ebx,%eax
            if ((p = va_arg(ap, char *)) == NULL)
40000689:	85 c9                	test   %ecx,%ecx
4000068b:	0f 84 28 01 00 00    	je     400007b9 <.L31+0x38>
                 (ch = *p++) != '\0' && (precision < 0
40000691:	8d 59 01             	lea    0x1(%ecx),%ebx
40000694:	89 5c 24 20          	mov    %ebx,0x20(%esp)
            if (width > 0 && padc != '-')
40000698:	84 c0                	test   %al,%al
4000069a:	0f 85 48 01 00 00    	jne    400007e8 <.L31+0x67>
                 (ch = *p++) != '\0' && (precision < 0
400006a0:	0f be 09             	movsbl (%ecx),%ecx
400006a3:	89 c8                	mov    %ecx,%eax
400006a5:	85 c9                	test   %ecx,%ecx
400006a7:	74 67                	je     40000710 <.L24+0xb3>
400006a9:	89 74 24 50          	mov    %esi,0x50(%esp)
400006ad:	89 d6                	mov    %edx,%esi
400006af:	89 7c 24 58          	mov    %edi,0x58(%esp)
400006b3:	8b 7c 24 10          	mov    0x10(%esp),%edi
400006b7:	eb 2c                	jmp    400006e5 <.L24+0x88>
400006b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                if (altflag && (ch < ' ' || ch > '~'))
400006c0:	83 e8 20             	sub    $0x20,%eax
400006c3:	83 f8 5e             	cmp    $0x5e,%eax
400006c6:	76 2e                	jbe    400006f6 <.L24+0x99>
                    putch('?', putdat);
400006c8:	83 ec 08             	sub    $0x8,%esp
400006cb:	55                   	push   %ebp
400006cc:	6a 3f                	push   $0x3f
400006ce:	ff 54 24 60          	call   *0x60(%esp)
400006d2:	83 c4 10             	add    $0x10,%esp
                 (ch = *p++) != '\0' && (precision < 0
400006d5:	0f be 03             	movsbl (%ebx),%eax
400006d8:	83 c3 01             	add    $0x1,%ebx
                                         || --precision >= 0); width--)
400006db:	83 ef 01             	sub    $0x1,%edi
                 (ch = *p++) != '\0' && (precision < 0
400006de:	0f be c8             	movsbl %al,%ecx
400006e1:	85 c9                	test   %ecx,%ecx
400006e3:	74 1f                	je     40000704 <.L24+0xa7>
400006e5:	85 f6                	test   %esi,%esi
400006e7:	78 05                	js     400006ee <.L24+0x91>
                                         || --precision >= 0); width--)
400006e9:	83 ee 01             	sub    $0x1,%esi
400006ec:	72 16                	jb     40000704 <.L24+0xa7>
                if (altflag && (ch < ' ' || ch > '~'))
400006ee:	8b 54 24 08          	mov    0x8(%esp),%edx
400006f2:	85 d2                	test   %edx,%edx
400006f4:	75 ca                	jne    400006c0 <.L24+0x63>
                    putch(ch, putdat);
400006f6:	83 ec 08             	sub    $0x8,%esp
400006f9:	55                   	push   %ebp
400006fa:	51                   	push   %ecx
400006fb:	ff 54 24 60          	call   *0x60(%esp)
400006ff:	83 c4 10             	add    $0x10,%esp
40000702:	eb d1                	jmp    400006d5 <.L24+0x78>
40000704:	89 7c 24 10          	mov    %edi,0x10(%esp)
40000708:	8b 74 24 50          	mov    0x50(%esp),%esi
4000070c:	8b 7c 24 58          	mov    0x58(%esp),%edi
            for (; width > 0; width--)
40000710:	8b 4c 24 10          	mov    0x10(%esp),%ecx
40000714:	8b 5c 24 10          	mov    0x10(%esp),%ebx
40000718:	85 c9                	test   %ecx,%ecx
4000071a:	7e 14                	jle    40000730 <.L24+0xd3>
4000071c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                putch(' ', putdat);
40000720:	83 ec 08             	sub    $0x8,%esp
40000723:	55                   	push   %ebp
40000724:	6a 20                	push   $0x20
40000726:	ff d6                	call   *%esi
            for (; width > 0; width--)
40000728:	83 c4 10             	add    $0x10,%esp
4000072b:	83 eb 01             	sub    $0x1,%ebx
4000072e:	75 f0                	jne    40000720 <.L24+0xc3>
            if ((p = va_arg(ap, char *)) == NULL)
40000730:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000734:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000738:	e9 7e fc ff ff       	jmp    400003bb <vprintfmt+0x2b>
        return va_arg(*ap, unsigned long long);
4000073d:	8b 08                	mov    (%eax),%ecx
4000073f:	8b 58 04             	mov    0x4(%eax),%ebx
40000742:	83 c0 08             	add    $0x8,%eax
40000745:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000749:	e9 d7 fe ff ff       	jmp    40000625 <.L28+0x2f>
4000074e:	8b 08                	mov    (%eax),%ecx
40000750:	8b 58 04             	mov    0x4(%eax),%ebx
40000753:	83 c0 08             	add    $0x8,%eax
40000756:	ba 10 00 00 00       	mov    $0x10,%edx
4000075b:	89 44 24 5c          	mov    %eax,0x5c(%esp)
4000075f:	e9 1c fe ff ff       	jmp    40000580 <.L23+0x2d>
        return va_arg(*ap, long long);
40000764:	8b 08                	mov    (%eax),%ecx
40000766:	8b 58 04             	mov    0x4(%eax),%ebx
40000769:	83 c0 08             	add    $0x8,%eax
4000076c:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000770:	e9 a8 fe ff ff       	jmp    4000061d <.L28+0x27>

40000775 <.L61>:
            padc = '-';
40000775:	c6 44 24 18 2d       	movb   $0x2d,0x18(%esp)
        switch (ch = *(unsigned char *) fmt++) {
4000077a:	89 fb                	mov    %edi,%ebx
4000077c:	e9 a1 fc ff ff       	jmp    40000422 <vprintfmt+0x92>

40000781 <.L31>:
40000781:	c6 44 24 18 30       	movb   $0x30,0x18(%esp)
40000786:	89 fb                	mov    %edi,%ebx
40000788:	e9 95 fc ff ff       	jmp    40000422 <vprintfmt+0x92>
4000078d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
                putch('-', putdat);
40000791:	83 ec 08             	sub    $0x8,%esp
40000794:	89 5c 24 14          	mov    %ebx,0x14(%esp)
40000798:	55                   	push   %ebp
40000799:	6a 2d                	push   $0x2d
4000079b:	ff d6                	call   *%esi
                num = -(long long) num;
4000079d:	8b 4c 24 18          	mov    0x18(%esp),%ecx
400007a1:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
400007a5:	ba 0a 00 00 00       	mov    $0xa,%edx
400007aa:	f7 d9                	neg    %ecx
400007ac:	83 d3 00             	adc    $0x0,%ebx
400007af:	83 c4 10             	add    $0x10,%esp
400007b2:	f7 db                	neg    %ebx
400007b4:	e9 c7 fd ff ff       	jmp    40000580 <.L23+0x2d>
            if (width > 0 && padc != '-')
400007b9:	84 c0                	test   %al,%al
400007bb:	0f 85 9f 00 00 00    	jne    40000860 <.L31+0xdf>
                 (ch = *p++) != '\0' && (precision < 0
400007c1:	8b 44 24 14          	mov    0x14(%esp),%eax
400007c5:	b9 28 00 00 00       	mov    $0x28,%ecx
400007ca:	8d 98 36 e0 ff ff    	lea    -0x1fca(%eax),%ebx
400007d0:	89 74 24 50          	mov    %esi,0x50(%esp)
400007d4:	b8 28 00 00 00       	mov    $0x28,%eax
400007d9:	89 d6                	mov    %edx,%esi
400007db:	89 7c 24 58          	mov    %edi,0x58(%esp)
400007df:	8b 7c 24 10          	mov    0x10(%esp),%edi
400007e3:	e9 fd fe ff ff       	jmp    400006e5 <.L24+0x88>
                for (width -= strnlen(p, precision); width > 0; width--)
400007e8:	83 ec 08             	sub    $0x8,%esp
400007eb:	52                   	push   %edx
400007ec:	89 54 24 38          	mov    %edx,0x38(%esp)
400007f0:	51                   	push   %ecx
400007f1:	8b 5c 24 24          	mov    0x24(%esp),%ebx
400007f5:	89 4c 24 38          	mov    %ecx,0x38(%esp)
400007f9:	e8 12 03 00 00       	call   40000b10 <strnlen>
400007fe:	29 44 24 20          	sub    %eax,0x20(%esp)
40000802:	8b 4c 24 20          	mov    0x20(%esp),%ecx
40000806:	83 c4 10             	add    $0x10,%esp
40000809:	8b 54 24 2c          	mov    0x2c(%esp),%edx
4000080d:	85 c9                	test   %ecx,%ecx
4000080f:	8b 4c 24 28          	mov    0x28(%esp),%ecx
40000813:	7e 34                	jle    40000849 <.L31+0xc8>
                    putch(padc, putdat);
40000815:	0f be 5c 24 18       	movsbl 0x18(%esp),%ebx
4000081a:	89 4c 24 28          	mov    %ecx,0x28(%esp)
4000081e:	89 54 24 18          	mov    %edx,0x18(%esp)
40000822:	89 7c 24 58          	mov    %edi,0x58(%esp)
40000826:	8b 7c 24 10          	mov    0x10(%esp),%edi
4000082a:	83 ec 08             	sub    $0x8,%esp
4000082d:	55                   	push   %ebp
4000082e:	53                   	push   %ebx
4000082f:	ff d6                	call   *%esi
                for (width -= strnlen(p, precision); width > 0; width--)
40000831:	83 c4 10             	add    $0x10,%esp
40000834:	83 ef 01             	sub    $0x1,%edi
40000837:	75 f1                	jne    4000082a <.L31+0xa9>
40000839:	8b 54 24 18          	mov    0x18(%esp),%edx
4000083d:	8b 4c 24 28          	mov    0x28(%esp),%ecx
40000841:	89 7c 24 10          	mov    %edi,0x10(%esp)
40000845:	8b 7c 24 58          	mov    0x58(%esp),%edi
                 (ch = *p++) != '\0' && (precision < 0
40000849:	0f be 01             	movsbl (%ecx),%eax
4000084c:	8b 5c 24 20          	mov    0x20(%esp),%ebx
40000850:	0f be c8             	movsbl %al,%ecx
40000853:	85 c9                	test   %ecx,%ecx
40000855:	0f 85 4e fe ff ff    	jne    400006a9 <.L24+0x4c>
4000085b:	e9 d0 fe ff ff       	jmp    40000730 <.L24+0xd3>
                for (width -= strnlen(p, precision); width > 0; width--)
40000860:	83 ec 08             	sub    $0x8,%esp
40000863:	52                   	push   %edx
40000864:	89 54 24 34          	mov    %edx,0x34(%esp)
40000868:	ff 74 24 30          	push   0x30(%esp)
4000086c:	8b 5c 24 24          	mov    0x24(%esp),%ebx
40000870:	e8 9b 02 00 00       	call   40000b10 <strnlen>
40000875:	29 44 24 20          	sub    %eax,0x20(%esp)
40000879:	8b 44 24 20          	mov    0x20(%esp),%eax
4000087d:	83 c4 10             	add    $0x10,%esp
                p = "(null)";
40000880:	8b 54 24 24          	mov    0x24(%esp),%edx
40000884:	89 d1                	mov    %edx,%ecx
40000886:	83 c2 01             	add    $0x1,%edx
                for (width -= strnlen(p, precision); width > 0; width--)
40000889:	85 c0                	test   %eax,%eax
4000088b:	89 54 24 20          	mov    %edx,0x20(%esp)
4000088f:	8b 54 24 28          	mov    0x28(%esp),%edx
40000893:	7f 80                	jg     40000815 <.L31+0x94>
                 (ch = *p++) != '\0' && (precision < 0
40000895:	8b 5c 24 20          	mov    0x20(%esp),%ebx
40000899:	b9 28 00 00 00       	mov    $0x28,%ecx
4000089e:	e9 2d ff ff ff       	jmp    400007d0 <.L31+0x4f>
400008a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400008aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

400008b0 <printfmt>:
{
400008b0:	83 ec 0c             	sub    $0xc,%esp
    vprintfmt(putch, putdat, fmt, ap);
400008b3:	8d 44 24 1c          	lea    0x1c(%esp),%eax
400008b7:	50                   	push   %eax
400008b8:	ff 74 24 1c          	push   0x1c(%esp)
400008bc:	ff 74 24 1c          	push   0x1c(%esp)
400008c0:	ff 74 24 1c          	push   0x1c(%esp)
400008c4:	e8 c7 fa ff ff       	call   40000390 <vprintfmt>
}
400008c9:	83 c4 1c             	add    $0x1c,%esp
400008cc:	c3                   	ret    
400008cd:	8d 76 00             	lea    0x0(%esi),%esi

400008d0 <vsprintf>:

int vsprintf(char *buf, const char *fmt, va_list ap)
{
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
400008d0:	e8 4e 01 00 00       	call   40000a23 <__x86.get_pc_thunk.ax>
400008d5:	05 2b 37 00 00       	add    $0x372b,%eax
{
400008da:	83 ec 1c             	sub    $0x1c,%esp
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
400008dd:	8b 54 24 20          	mov    0x20(%esp),%edx
400008e1:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
400008e8:	ff 
400008e9:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
400008f0:	00 
400008f1:	89 54 24 04          	mov    %edx,0x4(%esp)

    // print the string to the buffer
    vprintfmt((void *) sprintputch, &b, fmt, ap);
400008f5:	ff 74 24 28          	push   0x28(%esp)
400008f9:	ff 74 24 28          	push   0x28(%esp)
400008fd:	8d 80 70 c3 ff ff    	lea    -0x3c90(%eax),%eax
40000903:	8d 54 24 0c          	lea    0xc(%esp),%edx
40000907:	52                   	push   %edx
40000908:	50                   	push   %eax
40000909:	e8 82 fa ff ff       	call   40000390 <vprintfmt>

    // null terminate the buffer
    *b.buf = '\0';
4000090e:	8b 44 24 14          	mov    0x14(%esp),%eax
40000912:	c6 00 00             	movb   $0x0,(%eax)

    return b.cnt;
}
40000915:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000919:	83 c4 2c             	add    $0x2c,%esp
4000091c:	c3                   	ret    
4000091d:	8d 76 00             	lea    0x0(%esi),%esi

40000920 <sprintf>:
int sprintf(char *buf, const char *fmt, ...)
{
    va_list ap;
    int rc;

    va_start(ap, fmt);
40000920:	e8 fe 00 00 00       	call   40000a23 <__x86.get_pc_thunk.ax>
40000925:	05 db 36 00 00       	add    $0x36db,%eax
{
4000092a:	83 ec 1c             	sub    $0x1c,%esp
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
4000092d:	8b 54 24 20          	mov    0x20(%esp),%edx
40000931:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
40000938:	ff 
40000939:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000940:	00 
40000941:	89 54 24 04          	mov    %edx,0x4(%esp)
    vprintfmt((void *) sprintputch, &b, fmt, ap);
40000945:	8d 54 24 28          	lea    0x28(%esp),%edx
40000949:	52                   	push   %edx
4000094a:	ff 74 24 28          	push   0x28(%esp)
4000094e:	8d 80 70 c3 ff ff    	lea    -0x3c90(%eax),%eax
40000954:	8d 54 24 0c          	lea    0xc(%esp),%edx
40000958:	52                   	push   %edx
40000959:	50                   	push   %eax
4000095a:	e8 31 fa ff ff       	call   40000390 <vprintfmt>
    *b.buf = '\0';
4000095f:	8b 44 24 14          	mov    0x14(%esp),%eax
40000963:	c6 00 00             	movb   $0x0,(%eax)
    rc = vsprintf(buf, fmt, ap);
    va_end(ap);

    return rc;
}
40000966:	8b 44 24 1c          	mov    0x1c(%esp),%eax
4000096a:	83 c4 2c             	add    $0x2c,%esp
4000096d:	c3                   	ret    
4000096e:	66 90                	xchg   %ax,%ax

40000970 <vsnprintf>:

int vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
    struct sprintbuf b = { buf, buf + n - 1, 0 };
40000970:	e8 b2 00 00 00       	call   40000a27 <__x86.get_pc_thunk.dx>
40000975:	81 c2 8b 36 00 00    	add    $0x368b,%edx
{
4000097b:	83 ec 1c             	sub    $0x1c,%esp
4000097e:	8b 44 24 20          	mov    0x20(%esp),%eax
    struct sprintbuf b = { buf, buf + n - 1, 0 };
40000982:	8b 4c 24 24          	mov    0x24(%esp),%ecx
40000986:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
4000098d:	00 
4000098e:	89 44 24 04          	mov    %eax,0x4(%esp)
40000992:	8d 44 08 ff          	lea    -0x1(%eax,%ecx,1),%eax
40000996:	89 44 24 08          	mov    %eax,0x8(%esp)

    // print the string to the buffer
    vprintfmt((void *) sprintputch, &b, fmt, ap);
4000099a:	ff 74 24 2c          	push   0x2c(%esp)
4000099e:	ff 74 24 2c          	push   0x2c(%esp)
400009a2:	8d 44 24 0c          	lea    0xc(%esp),%eax
400009a6:	50                   	push   %eax
400009a7:	8d 82 70 c3 ff ff    	lea    -0x3c90(%edx),%eax
400009ad:	50                   	push   %eax
400009ae:	e8 dd f9 ff ff       	call   40000390 <vprintfmt>

    // null terminate the buffer
    *b.buf = '\0';
400009b3:	8b 44 24 14          	mov    0x14(%esp),%eax
400009b7:	c6 00 00             	movb   $0x0,(%eax)

    return b.cnt;
}
400009ba:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400009be:	83 c4 2c             	add    $0x2c,%esp
400009c1:	c3                   	ret    
400009c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400009c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

400009d0 <snprintf>:
int snprintf(char *buf, int n, const char *fmt, ...)
{
    va_list ap;
    int rc;

    va_start(ap, fmt);
400009d0:	e8 52 00 00 00       	call   40000a27 <__x86.get_pc_thunk.dx>
400009d5:	81 c2 2b 36 00 00    	add    $0x362b,%edx
{
400009db:	83 ec 1c             	sub    $0x1c,%esp
400009de:	8b 44 24 20          	mov    0x20(%esp),%eax
    struct sprintbuf b = { buf, buf + n - 1, 0 };
400009e2:	8b 4c 24 24          	mov    0x24(%esp),%ecx
400009e6:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
400009ed:	00 
400009ee:	89 44 24 04          	mov    %eax,0x4(%esp)
400009f2:	8d 44 08 ff          	lea    -0x1(%eax,%ecx,1),%eax
400009f6:	89 44 24 08          	mov    %eax,0x8(%esp)
    vprintfmt((void *) sprintputch, &b, fmt, ap);
400009fa:	8d 44 24 2c          	lea    0x2c(%esp),%eax
400009fe:	50                   	push   %eax
400009ff:	ff 74 24 2c          	push   0x2c(%esp)
40000a03:	8d 44 24 0c          	lea    0xc(%esp),%eax
40000a07:	50                   	push   %eax
40000a08:	8d 82 70 c3 ff ff    	lea    -0x3c90(%edx),%eax
40000a0e:	50                   	push   %eax
40000a0f:	e8 7c f9 ff ff       	call   40000390 <vprintfmt>
    *b.buf = '\0';
40000a14:	8b 44 24 14          	mov    0x14(%esp),%eax
40000a18:	c6 00 00             	movb   $0x0,(%eax)
    rc = vsnprintf(buf, n, fmt, ap);
    va_end(ap);

    return rc;
}
40000a1b:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000a1f:	83 c4 2c             	add    $0x2c,%esp
40000a22:	c3                   	ret    

40000a23 <__x86.get_pc_thunk.ax>:
40000a23:	8b 04 24             	mov    (%esp),%eax
40000a26:	c3                   	ret    

40000a27 <__x86.get_pc_thunk.dx>:
40000a27:	8b 14 24             	mov    (%esp),%edx
40000a2a:	c3                   	ret    

40000a2b <__x86.get_pc_thunk.cx>:
40000a2b:	8b 0c 24             	mov    (%esp),%ecx
40000a2e:	c3                   	ret    
40000a2f:	90                   	nop

40000a30 <spawn>:
#include <proc.h>
#include <syscall.h>
#include <types.h>

pid_t spawn(uintptr_t exec, unsigned int quota)
{
40000a30:	53                   	push   %ebx
static gcc_inline pid_t sys_spawn(unsigned int elf_id, unsigned int quota)
{
    int errno;
    pid_t pid;

    asm volatile ("int %2"
40000a31:	b8 01 00 00 00       	mov    $0x1,%eax
40000a36:	8b 5c 24 08          	mov    0x8(%esp),%ebx
40000a3a:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000a3e:	cd 30                	int    $0x30
                    "a" (SYS_spawn),
                    "b" (elf_id),
                    "c" (quota)
                  : "cc", "memory");

    return errno ? -1 : pid;
40000a40:	85 c0                	test   %eax,%eax
40000a42:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
40000a47:	0f 44 c3             	cmove  %ebx,%eax
    return sys_spawn(exec, quota);
}
40000a4a:	5b                   	pop    %ebx
40000a4b:	c3                   	ret    
40000a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000a50 <yield>:
}

static gcc_inline void sys_yield(void)
{
    asm volatile ("int %0"
40000a50:	b8 02 00 00 00       	mov    $0x2,%eax
40000a55:	cd 30                	int    $0x30

void yield(void)
{
    sys_yield();
}
40000a57:	c3                   	ret    
40000a58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000a5f:	90                   	nop

40000a60 <produce>:
                  : "cc", "memory");
}

static gcc_inline void sys_produce(void)
{
    asm volatile ("int %0"
40000a60:	b8 03 00 00 00       	mov    $0x3,%eax
40000a65:	cd 30                	int    $0x30

void produce(void)
{
    sys_produce();
}
40000a67:	c3                   	ret    
40000a68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000a6f:	90                   	nop

40000a70 <consume>:
                  : "cc", "memory");
}

static gcc_inline void sys_consume(void)
{
    asm volatile ("int %0"
40000a70:	b8 04 00 00 00       	mov    $0x4,%eax
40000a75:	cd 30                	int    $0x30

void consume(void)
{
    sys_consume();
}
40000a77:	c3                   	ret    
40000a78:	66 90                	xchg   %ax,%ax
40000a7a:	66 90                	xchg   %ax,%ax
40000a7c:	66 90                	xchg   %ax,%ax
40000a7e:	66 90                	xchg   %ax,%ax

40000a80 <spinlock_init>:
    return result;
}

void spinlock_init(spinlock_t *lk)
{
    *lk = 0;
40000a80:	8b 44 24 04          	mov    0x4(%esp),%eax
40000a84:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
40000a8a:	c3                   	ret    
40000a8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000a8f:	90                   	nop

40000a90 <spinlock_acquire>:

void spinlock_acquire(spinlock_t *lk)
{
40000a90:	8b 54 24 04          	mov    0x4(%esp),%edx
    asm volatile ("lock; xchgl %0, %1"
40000a94:	b8 01 00 00 00       	mov    $0x1,%eax
40000a99:	f0 87 02             	lock xchg %eax,(%edx)
    while (xchg(lk, 1) != 0)
40000a9c:	85 c0                	test   %eax,%eax
40000a9e:	74 13                	je     40000ab3 <spinlock_acquire+0x23>
    asm volatile ("lock; xchgl %0, %1"
40000aa0:	b9 01 00 00 00       	mov    $0x1,%ecx
40000aa5:	8d 76 00             	lea    0x0(%esi),%esi
        asm volatile ("pause");
40000aa8:	f3 90                	pause  
    asm volatile ("lock; xchgl %0, %1"
40000aaa:	89 c8                	mov    %ecx,%eax
40000aac:	f0 87 02             	lock xchg %eax,(%edx)
    while (xchg(lk, 1) != 0)
40000aaf:	85 c0                	test   %eax,%eax
40000ab1:	75 f5                	jne    40000aa8 <spinlock_acquire+0x18>
}
40000ab3:	c3                   	ret    
40000ab4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000abb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000abf:	90                   	nop

40000ac0 <spinlock_release>:

// Release the lock.
void spinlock_release(spinlock_t *lk)
{
40000ac0:	8b 54 24 04          	mov    0x4(%esp),%edx
}

// Check whether this cpu is holding the lock.
bool spinlock_holding(spinlock_t *lk)
{
    return *lk;
40000ac4:	8b 02                	mov    (%edx),%eax
    if (spinlock_holding(lk) == FALSE)
40000ac6:	84 c0                	test   %al,%al
40000ac8:	74 05                	je     40000acf <spinlock_release+0xf>
    asm volatile ("lock; xchgl %0, %1"
40000aca:	31 c0                	xor    %eax,%eax
40000acc:	f0 87 02             	lock xchg %eax,(%edx)
}
40000acf:	c3                   	ret    

40000ad0 <spinlock_holding>:
    return *lk;
40000ad0:	8b 44 24 04          	mov    0x4(%esp),%eax
40000ad4:	8b 00                	mov    (%eax),%eax
}
40000ad6:	c3                   	ret    
40000ad7:	66 90                	xchg   %ax,%ax
40000ad9:	66 90                	xchg   %ax,%ax
40000adb:	66 90                	xchg   %ax,%ax
40000add:	66 90                	xchg   %ax,%ax
40000adf:	90                   	nop

40000ae0 <strlen>:
#include <string.h>
#include <types.h>

int strlen(const char *s)
{
40000ae0:	8b 54 24 04          	mov    0x4(%esp),%edx
    int n;

    for (n = 0; *s != '\0'; s++)
40000ae4:	31 c0                	xor    %eax,%eax
40000ae6:	80 3a 00             	cmpb   $0x0,(%edx)
40000ae9:	74 15                	je     40000b00 <strlen+0x20>
40000aeb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000aef:	90                   	nop
        n++;
40000af0:	83 c0 01             	add    $0x1,%eax
    for (n = 0; *s != '\0'; s++)
40000af3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
40000af7:	75 f7                	jne    40000af0 <strlen+0x10>
40000af9:	c3                   	ret    
40000afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return n;
}
40000b00:	c3                   	ret    
40000b01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b0f:	90                   	nop

40000b10 <strnlen>:

int strnlen(const char *s, size_t size)
{
40000b10:	8b 54 24 08          	mov    0x8(%esp),%edx
40000b14:	8b 4c 24 04          	mov    0x4(%esp),%ecx
    int n;

    for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000b18:	31 c0                	xor    %eax,%eax
40000b1a:	85 d2                	test   %edx,%edx
40000b1c:	75 09                	jne    40000b27 <strnlen+0x17>
40000b1e:	eb 10                	jmp    40000b30 <strnlen+0x20>
        n++;
40000b20:	83 c0 01             	add    $0x1,%eax
    for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000b23:	39 d0                	cmp    %edx,%eax
40000b25:	74 09                	je     40000b30 <strnlen+0x20>
40000b27:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
40000b2b:	75 f3                	jne    40000b20 <strnlen+0x10>
40000b2d:	c3                   	ret    
40000b2e:	66 90                	xchg   %ax,%ax
    return n;
}
40000b30:	c3                   	ret    
40000b31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b3f:	90                   	nop

40000b40 <strcpy>:

char *strcpy(char *dst, const char *src)
{
40000b40:	53                   	push   %ebx
40000b41:	8b 4c 24 08          	mov    0x8(%esp),%ecx
    char *ret;

    ret = dst;
    while ((*dst++ = *src++) != '\0')
40000b45:	31 c0                	xor    %eax,%eax
{
40000b47:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40000b4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000b4f:	90                   	nop
    while ((*dst++ = *src++) != '\0')
40000b50:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
40000b54:	88 14 01             	mov    %dl,(%ecx,%eax,1)
40000b57:	83 c0 01             	add    $0x1,%eax
40000b5a:	84 d2                	test   %dl,%dl
40000b5c:	75 f2                	jne    40000b50 <strcpy+0x10>
        /* do nothing */ ;
    return ret;
}
40000b5e:	89 c8                	mov    %ecx,%eax
40000b60:	5b                   	pop    %ebx
40000b61:	c3                   	ret    
40000b62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000b70 <strncpy>:

char *strncpy(char *dst, const char *src, size_t size)
{
40000b70:	56                   	push   %esi
40000b71:	53                   	push   %ebx
40000b72:	8b 5c 24 14          	mov    0x14(%esp),%ebx
40000b76:	8b 74 24 0c          	mov    0xc(%esp),%esi
40000b7a:	8b 54 24 10          	mov    0x10(%esp),%edx
    size_t i;
    char *ret;

    ret = dst;
    for (i = 0; i < size; i++) {
40000b7e:	85 db                	test   %ebx,%ebx
40000b80:	74 21                	je     40000ba3 <strncpy+0x33>
40000b82:	01 f3                	add    %esi,%ebx
40000b84:	89 f0                	mov    %esi,%eax
40000b86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b8d:	8d 76 00             	lea    0x0(%esi),%esi
        *dst++ = *src;
40000b90:	0f b6 0a             	movzbl (%edx),%ecx
40000b93:	83 c0 01             	add    $0x1,%eax
        // If strlen(src) < size, null-pad 'dst' out to 'size' chars
        if (*src != '\0')
            src++;
40000b96:	80 f9 01             	cmp    $0x1,%cl
        *dst++ = *src;
40000b99:	88 48 ff             	mov    %cl,-0x1(%eax)
            src++;
40000b9c:	83 da ff             	sbb    $0xffffffff,%edx
    for (i = 0; i < size; i++) {
40000b9f:	39 d8                	cmp    %ebx,%eax
40000ba1:	75 ed                	jne    40000b90 <strncpy+0x20>
    }
    return ret;
}
40000ba3:	89 f0                	mov    %esi,%eax
40000ba5:	5b                   	pop    %ebx
40000ba6:	5e                   	pop    %esi
40000ba7:	c3                   	ret    
40000ba8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000baf:	90                   	nop

40000bb0 <strlcpy>:

size_t strlcpy(char *dst, const char *src, size_t size)
{
40000bb0:	53                   	push   %ebx
40000bb1:	8b 44 24 10          	mov    0x10(%esp),%eax
40000bb5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    char *dst_in;

    dst_in = dst;
    if (size > 0) {
40000bb9:	85 c0                	test   %eax,%eax
40000bbb:	74 30                	je     40000bed <strlcpy+0x3d>
        while (--size > 0 && *src != '\0')
40000bbd:	8b 54 24 08          	mov    0x8(%esp),%edx
40000bc1:	83 e8 01             	sub    $0x1,%eax
40000bc4:	74 24                	je     40000bea <strlcpy+0x3a>
40000bc6:	01 d0                	add    %edx,%eax
40000bc8:	89 c3                	mov    %eax,%ebx
40000bca:	eb 11                	jmp    40000bdd <strlcpy+0x2d>
40000bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            *dst++ = *src++;
40000bd0:	83 c2 01             	add    $0x1,%edx
40000bd3:	83 c1 01             	add    $0x1,%ecx
40000bd6:	88 42 ff             	mov    %al,-0x1(%edx)
        while (--size > 0 && *src != '\0')
40000bd9:	39 da                	cmp    %ebx,%edx
40000bdb:	74 07                	je     40000be4 <strlcpy+0x34>
40000bdd:	0f b6 01             	movzbl (%ecx),%eax
40000be0:	84 c0                	test   %al,%al
40000be2:	75 ec                	jne    40000bd0 <strlcpy+0x20>
        *dst = '\0';
    }
    return dst - dst_in;
40000be4:	89 d0                	mov    %edx,%eax
40000be6:	2b 44 24 08          	sub    0x8(%esp),%eax
        *dst = '\0';
40000bea:	c6 02 00             	movb   $0x0,(%edx)
}
40000bed:	5b                   	pop    %ebx
40000bee:	c3                   	ret    
40000bef:	90                   	nop

40000bf0 <strcmp>:

int strcmp(const char *p, const char *q)
{
40000bf0:	53                   	push   %ebx
40000bf1:	8b 54 24 08          	mov    0x8(%esp),%edx
40000bf5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    while (*p && *p == *q)
40000bf9:	0f b6 02             	movzbl (%edx),%eax
40000bfc:	84 c0                	test   %al,%al
40000bfe:	75 18                	jne    40000c18 <strcmp+0x28>
40000c00:	eb 30                	jmp    40000c32 <strcmp+0x42>
40000c02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000c08:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        p++, q++;
40000c0c:	83 c2 01             	add    $0x1,%edx
40000c0f:	8d 59 01             	lea    0x1(%ecx),%ebx
    while (*p && *p == *q)
40000c12:	84 c0                	test   %al,%al
40000c14:	74 12                	je     40000c28 <strcmp+0x38>
        p++, q++;
40000c16:	89 d9                	mov    %ebx,%ecx
    while (*p && *p == *q)
40000c18:	0f b6 19             	movzbl (%ecx),%ebx
40000c1b:	38 c3                	cmp    %al,%bl
40000c1d:	74 e9                	je     40000c08 <strcmp+0x18>
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000c1f:	29 d8                	sub    %ebx,%eax
}
40000c21:	5b                   	pop    %ebx
40000c22:	c3                   	ret    
40000c23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000c27:	90                   	nop
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000c28:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
40000c2c:	31 c0                	xor    %eax,%eax
40000c2e:	29 d8                	sub    %ebx,%eax
}
40000c30:	5b                   	pop    %ebx
40000c31:	c3                   	ret    
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000c32:	0f b6 19             	movzbl (%ecx),%ebx
40000c35:	31 c0                	xor    %eax,%eax
40000c37:	eb e6                	jmp    40000c1f <strcmp+0x2f>
40000c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000c40 <strncmp>:

int strncmp(const char *p, const char *q, size_t n)
{
40000c40:	56                   	push   %esi
40000c41:	53                   	push   %ebx
40000c42:	8b 74 24 14          	mov    0x14(%esp),%esi
40000c46:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000c4a:	8b 44 24 10          	mov    0x10(%esp),%eax
    while (n > 0 && *p && *p == *q)
40000c4e:	85 f6                	test   %esi,%esi
40000c50:	74 2e                	je     40000c80 <strncmp+0x40>
40000c52:	01 c6                	add    %eax,%esi
40000c54:	eb 18                	jmp    40000c6e <strncmp+0x2e>
40000c56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000c5d:	8d 76 00             	lea    0x0(%esi),%esi
40000c60:	38 da                	cmp    %bl,%dl
40000c62:	75 14                	jne    40000c78 <strncmp+0x38>
        n--, p++, q++;
40000c64:	83 c0 01             	add    $0x1,%eax
40000c67:	83 c1 01             	add    $0x1,%ecx
    while (n > 0 && *p && *p == *q)
40000c6a:	39 f0                	cmp    %esi,%eax
40000c6c:	74 12                	je     40000c80 <strncmp+0x40>
40000c6e:	0f b6 11             	movzbl (%ecx),%edx
40000c71:	0f b6 18             	movzbl (%eax),%ebx
40000c74:	84 d2                	test   %dl,%dl
40000c76:	75 e8                	jne    40000c60 <strncmp+0x20>
    if (n == 0)
        return 0;
    else
        return (int) ((unsigned char) *p - (unsigned char) *q);
40000c78:	0f b6 c2             	movzbl %dl,%eax
40000c7b:	29 d8                	sub    %ebx,%eax
}
40000c7d:	5b                   	pop    %ebx
40000c7e:	5e                   	pop    %esi
40000c7f:	c3                   	ret    
        return 0;
40000c80:	31 c0                	xor    %eax,%eax
}
40000c82:	5b                   	pop    %ebx
40000c83:	5e                   	pop    %esi
40000c84:	c3                   	ret    
40000c85:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000c90 <strchr>:

char *strchr(const char *s, char c)
{
40000c90:	8b 44 24 04          	mov    0x4(%esp),%eax
40000c94:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
    for (; *s; s++)
40000c99:	0f b6 10             	movzbl (%eax),%edx
40000c9c:	84 d2                	test   %dl,%dl
40000c9e:	75 13                	jne    40000cb3 <strchr+0x23>
40000ca0:	eb 1e                	jmp    40000cc0 <strchr+0x30>
40000ca2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000ca8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
40000cac:	83 c0 01             	add    $0x1,%eax
40000caf:	84 d2                	test   %dl,%dl
40000cb1:	74 0d                	je     40000cc0 <strchr+0x30>
        if (*s == c)
40000cb3:	38 d1                	cmp    %dl,%cl
40000cb5:	75 f1                	jne    40000ca8 <strchr+0x18>
            return (char *) s;
    return 0;
}
40000cb7:	c3                   	ret    
40000cb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000cbf:	90                   	nop
    return 0;
40000cc0:	31 c0                	xor    %eax,%eax
}
40000cc2:	c3                   	ret    
40000cc3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000cd0 <strfind>:

char *strfind(const char *s, char c)
{
40000cd0:	53                   	push   %ebx
40000cd1:	8b 44 24 08          	mov    0x8(%esp),%eax
40000cd5:	8b 54 24 0c          	mov    0xc(%esp),%edx
    for (; *s; s++)
40000cd9:	0f b6 18             	movzbl (%eax),%ebx
        if (*s == c)
40000cdc:	38 d3                	cmp    %dl,%bl
40000cde:	74 1f                	je     40000cff <strfind+0x2f>
40000ce0:	89 d1                	mov    %edx,%ecx
40000ce2:	84 db                	test   %bl,%bl
40000ce4:	75 0e                	jne    40000cf4 <strfind+0x24>
40000ce6:	eb 17                	jmp    40000cff <strfind+0x2f>
40000ce8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000cef:	90                   	nop
40000cf0:	84 d2                	test   %dl,%dl
40000cf2:	74 0b                	je     40000cff <strfind+0x2f>
    for (; *s; s++)
40000cf4:	0f b6 50 01          	movzbl 0x1(%eax),%edx
40000cf8:	83 c0 01             	add    $0x1,%eax
        if (*s == c)
40000cfb:	38 ca                	cmp    %cl,%dl
40000cfd:	75 f1                	jne    40000cf0 <strfind+0x20>
            break;
    return (char *) s;
}
40000cff:	5b                   	pop    %ebx
40000d00:	c3                   	ret    
40000d01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000d08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000d0f:	90                   	nop

40000d10 <strtol>:

long strtol(const char *s, char **endptr, int base)
{
40000d10:	55                   	push   %ebp
40000d11:	57                   	push   %edi
40000d12:	56                   	push   %esi
40000d13:	53                   	push   %ebx
40000d14:	8b 54 24 14          	mov    0x14(%esp),%edx
40000d18:	8b 74 24 18          	mov    0x18(%esp),%esi
40000d1c:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
40000d20:	0f b6 02             	movzbl (%edx),%eax
40000d23:	3c 09                	cmp    $0x9,%al
40000d25:	74 09                	je     40000d30 <strtol+0x20>
40000d27:	3c 20                	cmp    $0x20,%al
40000d29:	75 14                	jne    40000d3f <strtol+0x2f>
40000d2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000d2f:	90                   	nop
40000d30:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        s++;
40000d34:	83 c2 01             	add    $0x1,%edx
    while (*s == ' ' || *s == '\t')
40000d37:	3c 20                	cmp    $0x20,%al
40000d39:	74 f5                	je     40000d30 <strtol+0x20>
40000d3b:	3c 09                	cmp    $0x9,%al
40000d3d:	74 f1                	je     40000d30 <strtol+0x20>

    // plus/minus sign
    if (*s == '+')
40000d3f:	3c 2b                	cmp    $0x2b,%al
40000d41:	0f 84 99 00 00 00    	je     40000de0 <strtol+0xd0>
    int neg = 0;
40000d47:	31 ff                	xor    %edi,%edi
        s++;
    else if (*s == '-')
40000d49:	3c 2d                	cmp    $0x2d,%al
40000d4b:	0f 84 7f 00 00 00    	je     40000dd0 <strtol+0xc0>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000d51:	0f b6 2a             	movzbl (%edx),%ebp
40000d54:	f7 c3 ef ff ff ff    	test   $0xffffffef,%ebx
40000d5a:	75 13                	jne    40000d6f <strtol+0x5f>
40000d5c:	89 e8                	mov    %ebp,%eax
40000d5e:	3c 30                	cmp    $0x30,%al
40000d60:	0f 84 8a 00 00 00    	je     40000df0 <strtol+0xe0>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
40000d66:	85 db                	test   %ebx,%ebx
40000d68:	75 05                	jne    40000d6f <strtol+0x5f>
        s++, base = 8;
    else if (base == 0)
        base = 10;
40000d6a:	bb 0a 00 00 00       	mov    $0xa,%ebx
40000d6f:	31 c9                	xor    %ecx,%ecx
40000d71:	eb 22                	jmp    40000d95 <strtol+0x85>
40000d73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000d77:	90                   	nop
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
40000d78:	8d 45 9f             	lea    -0x61(%ebp),%eax
40000d7b:	3c 19                	cmp    $0x19,%al
40000d7d:	77 41                	ja     40000dc0 <strtol+0xb0>
            dig = *s - 'a' + 10;
40000d7f:	8d 45 a9             	lea    -0x57(%ebp),%eax
40000d82:	0f be c0             	movsbl %al,%eax
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
40000d85:	39 d8                	cmp    %ebx,%eax
40000d87:	7d 1a                	jge    40000da3 <strtol+0x93>
            break;
        s++, val = (val * base) + dig;
40000d89:	0f af cb             	imul   %ebx,%ecx
        if (*s >= '0' && *s <= '9')
40000d8c:	0f b6 6a 01          	movzbl 0x1(%edx),%ebp
        s++, val = (val * base) + dig;
40000d90:	83 c2 01             	add    $0x1,%edx
40000d93:	01 c1                	add    %eax,%ecx
        if (*s >= '0' && *s <= '9')
40000d95:	8d 45 d0             	lea    -0x30(%ebp),%eax
40000d98:	3c 09                	cmp    $0x9,%al
40000d9a:	77 dc                	ja     40000d78 <strtol+0x68>
            dig = *s - 'A' + 10;
40000d9c:	0f be c0             	movsbl %al,%eax
        if (dig >= base)
40000d9f:	39 d8                	cmp    %ebx,%eax
40000da1:	7c e6                	jl     40000d89 <strtol+0x79>
        // we don't properly detect overflow!
    }

    if (endptr)
40000da3:	85 f6                	test   %esi,%esi
40000da5:	74 02                	je     40000da9 <strtol+0x99>
        *endptr = (char *) s;
40000da7:	89 16                	mov    %edx,(%esi)
    return (neg ? -val : val);
40000da9:	89 c8                	mov    %ecx,%eax
}
40000dab:	5b                   	pop    %ebx
40000dac:	5e                   	pop    %esi
    return (neg ? -val : val);
40000dad:	f7 d8                	neg    %eax
40000daf:	85 ff                	test   %edi,%edi
}
40000db1:	5f                   	pop    %edi
40000db2:	5d                   	pop    %ebp
    return (neg ? -val : val);
40000db3:	0f 45 c8             	cmovne %eax,%ecx
}
40000db6:	89 c8                	mov    %ecx,%eax
40000db8:	c3                   	ret    
40000db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        else if (*s >= 'A' && *s <= 'Z')
40000dc0:	8d 45 bf             	lea    -0x41(%ebp),%eax
40000dc3:	3c 19                	cmp    $0x19,%al
40000dc5:	77 dc                	ja     40000da3 <strtol+0x93>
            dig = *s - 'A' + 10;
40000dc7:	8d 45 c9             	lea    -0x37(%ebp),%eax
40000dca:	0f be c0             	movsbl %al,%eax
40000dcd:	eb d0                	jmp    40000d9f <strtol+0x8f>
40000dcf:	90                   	nop
        s++, neg = 1;
40000dd0:	83 c2 01             	add    $0x1,%edx
40000dd3:	bf 01 00 00 00       	mov    $0x1,%edi
40000dd8:	e9 74 ff ff ff       	jmp    40000d51 <strtol+0x41>
40000ddd:	8d 76 00             	lea    0x0(%esi),%esi
        s++;
40000de0:	83 c2 01             	add    $0x1,%edx
    int neg = 0;
40000de3:	31 ff                	xor    %edi,%edi
40000de5:	e9 67 ff ff ff       	jmp    40000d51 <strtol+0x41>
40000dea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000df0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
40000df4:	3c 78                	cmp    $0x78,%al
40000df6:	74 17                	je     40000e0f <strtol+0xff>
    else if (base == 0 && s[0] == '0')
40000df8:	85 db                	test   %ebx,%ebx
40000dfa:	0f 85 6f ff ff ff    	jne    40000d6f <strtol+0x5f>
        s++, base = 8;
40000e00:	83 c2 01             	add    $0x1,%edx
40000e03:	89 c5                	mov    %eax,%ebp
40000e05:	bb 08 00 00 00       	mov    $0x8,%ebx
40000e0a:	e9 60 ff ff ff       	jmp    40000d6f <strtol+0x5f>
        if (*s >= '0' && *s <= '9')
40000e0f:	0f b6 6a 02          	movzbl 0x2(%edx),%ebp
        s += 2, base = 16;
40000e13:	bb 10 00 00 00       	mov    $0x10,%ebx
40000e18:	83 c2 02             	add    $0x2,%edx
40000e1b:	e9 4f ff ff ff       	jmp    40000d6f <strtol+0x5f>

40000e20 <memset>:

void *memset(void *v, int c, size_t n)
{
40000e20:	57                   	push   %edi
40000e21:	56                   	push   %esi
40000e22:	53                   	push   %ebx
40000e23:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000e27:	8b 7c 24 10          	mov    0x10(%esp),%edi
    if (n == 0)
40000e2b:	85 c9                	test   %ecx,%ecx
40000e2d:	74 28                	je     40000e57 <memset+0x37>
        return v;
    if ((int) v % 4 == 0 && n % 4 == 0) {
40000e2f:	89 f8                	mov    %edi,%eax
40000e31:	09 c8                	or     %ecx,%eax
40000e33:	a8 03                	test   $0x3,%al
40000e35:	75 29                	jne    40000e60 <memset+0x40>
        c &= 0xFF;
40000e37:	0f b6 5c 24 14       	movzbl 0x14(%esp),%ebx
        c = (c << 24) | (c << 16) | (c << 8) | c;
        asm volatile ("cld; rep stosl\n"
                      :: "D" (v), "a" (c), "c" (n / 4)
40000e3c:	c1 e9 02             	shr    $0x2,%ecx
        c = (c << 24) | (c << 16) | (c << 8) | c;
40000e3f:	89 da                	mov    %ebx,%edx
40000e41:	89 de                	mov    %ebx,%esi
40000e43:	89 d8                	mov    %ebx,%eax
40000e45:	c1 e2 18             	shl    $0x18,%edx
40000e48:	c1 e6 10             	shl    $0x10,%esi
40000e4b:	09 f2                	or     %esi,%edx
40000e4d:	c1 e0 08             	shl    $0x8,%eax
40000e50:	09 da                	or     %ebx,%edx
40000e52:	09 d0                	or     %edx,%eax
        asm volatile ("cld; rep stosl\n"
40000e54:	fc                   	cld    
40000e55:	f3 ab                	rep stos %eax,%es:(%edi)
    } else
        asm volatile ("cld; rep stosb\n"
                      :: "D" (v), "a" (c), "c" (n)
                      : "cc", "memory");
    return v;
}
40000e57:	89 f8                	mov    %edi,%eax
40000e59:	5b                   	pop    %ebx
40000e5a:	5e                   	pop    %esi
40000e5b:	5f                   	pop    %edi
40000e5c:	c3                   	ret    
40000e5d:	8d 76 00             	lea    0x0(%esi),%esi
        asm volatile ("cld; rep stosb\n"
40000e60:	8b 44 24 14          	mov    0x14(%esp),%eax
40000e64:	fc                   	cld    
40000e65:	f3 aa                	rep stos %al,%es:(%edi)
}
40000e67:	89 f8                	mov    %edi,%eax
40000e69:	5b                   	pop    %ebx
40000e6a:	5e                   	pop    %esi
40000e6b:	5f                   	pop    %edi
40000e6c:	c3                   	ret    
40000e6d:	8d 76 00             	lea    0x0(%esi),%esi

40000e70 <memmove>:

void *memmove(void *dst, const void *src, size_t n)
{
40000e70:	57                   	push   %edi
40000e71:	56                   	push   %esi
40000e72:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000e76:	8b 74 24 10          	mov    0x10(%esp),%esi
40000e7a:	8b 4c 24 14          	mov    0x14(%esp),%ecx
    const char *s;
    char *d;

    s = src;
    d = dst;
    if (s < d && s + n > d) {
40000e7e:	39 c6                	cmp    %eax,%esi
40000e80:	73 26                	jae    40000ea8 <memmove+0x38>
40000e82:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
40000e85:	39 c2                	cmp    %eax,%edx
40000e87:	76 1f                	jbe    40000ea8 <memmove+0x38>
        s += n;
        d += n;
40000e89:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
40000e8c:	89 d6                	mov    %edx,%esi
40000e8e:	09 fe                	or     %edi,%esi
40000e90:	09 ce                	or     %ecx,%esi
40000e92:	83 e6 03             	and    $0x3,%esi
40000e95:	74 39                	je     40000ed0 <memmove+0x60>
            asm volatile ("std; rep movsl\n"
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
                          : "cc", "memory");
        else
            asm volatile ("std; rep movsb\n"
                          :: "D" (d - 1), "S" (s - 1), "c" (n)
40000e97:	83 ef 01             	sub    $0x1,%edi
40000e9a:	8d 72 ff             	lea    -0x1(%edx),%esi
            asm volatile ("std; rep movsb\n"
40000e9d:	fd                   	std    
40000e9e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
                          : "cc", "memory");
        // Some versions of GCC rely on DF being clear
        asm volatile ("cld" ::: "cc");
40000ea0:	fc                   	cld    
            asm volatile ("cld; rep movsb\n"
                          :: "D" (d), "S" (s), "c" (n)
                          : "cc", "memory");
    }
    return dst;
}
40000ea1:	5e                   	pop    %esi
40000ea2:	5f                   	pop    %edi
40000ea3:	c3                   	ret    
40000ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
40000ea8:	89 f2                	mov    %esi,%edx
40000eaa:	09 c2                	or     %eax,%edx
40000eac:	09 ca                	or     %ecx,%edx
40000eae:	83 e2 03             	and    $0x3,%edx
40000eb1:	74 0d                	je     40000ec0 <memmove+0x50>
            asm volatile ("cld; rep movsb\n"
40000eb3:	89 c7                	mov    %eax,%edi
40000eb5:	fc                   	cld    
40000eb6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
}
40000eb8:	5e                   	pop    %esi
40000eb9:	5f                   	pop    %edi
40000eba:	c3                   	ret    
40000ebb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000ebf:	90                   	nop
                          :: "D" (d), "S" (s), "c" (n / 4)
40000ec0:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("cld; rep movsl\n"
40000ec3:	89 c7                	mov    %eax,%edi
40000ec5:	fc                   	cld    
40000ec6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000ec8:	eb ee                	jmp    40000eb8 <memmove+0x48>
40000eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
40000ed0:	83 ef 04             	sub    $0x4,%edi
40000ed3:	8d 72 fc             	lea    -0x4(%edx),%esi
40000ed6:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("std; rep movsl\n"
40000ed9:	fd                   	std    
40000eda:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000edc:	eb c2                	jmp    40000ea0 <memmove+0x30>
40000ede:	66 90                	xchg   %ax,%ax

40000ee0 <memcpy>:

void *memcpy(void *dst, const void *src, size_t n)
{
    return memmove(dst, src, n);
40000ee0:	eb 8e                	jmp    40000e70 <memmove>
40000ee2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000ef0 <memcmp>:
}

int memcmp(const void *v1, const void *v2, size_t n)
{
40000ef0:	56                   	push   %esi
40000ef1:	53                   	push   %ebx
40000ef2:	8b 74 24 14          	mov    0x14(%esp),%esi
40000ef6:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000efa:	8b 44 24 10          	mov    0x10(%esp),%eax
    const uint8_t *s1 = (const uint8_t *) v1;
    const uint8_t *s2 = (const uint8_t *) v2;

    while (n-- > 0) {
40000efe:	85 f6                	test   %esi,%esi
40000f00:	74 2e                	je     40000f30 <memcmp+0x40>
40000f02:	01 c6                	add    %eax,%esi
40000f04:	eb 14                	jmp    40000f1a <memcmp+0x2a>
40000f06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000f0d:	8d 76 00             	lea    0x0(%esi),%esi
        if (*s1 != *s2)
            return (int) *s1 - (int) *s2;
        s1++, s2++;
40000f10:	83 c0 01             	add    $0x1,%eax
40000f13:	83 c2 01             	add    $0x1,%edx
    while (n-- > 0) {
40000f16:	39 f0                	cmp    %esi,%eax
40000f18:	74 16                	je     40000f30 <memcmp+0x40>
        if (*s1 != *s2)
40000f1a:	0f b6 0a             	movzbl (%edx),%ecx
40000f1d:	0f b6 18             	movzbl (%eax),%ebx
40000f20:	38 d9                	cmp    %bl,%cl
40000f22:	74 ec                	je     40000f10 <memcmp+0x20>
            return (int) *s1 - (int) *s2;
40000f24:	0f b6 c1             	movzbl %cl,%eax
40000f27:	29 d8                	sub    %ebx,%eax
    }

    return 0;
}
40000f29:	5b                   	pop    %ebx
40000f2a:	5e                   	pop    %esi
40000f2b:	c3                   	ret    
40000f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
40000f30:	31 c0                	xor    %eax,%eax
}
40000f32:	5b                   	pop    %ebx
40000f33:	5e                   	pop    %esi
40000f34:	c3                   	ret    
40000f35:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000f40 <memchr>:

void *memchr(const void *s, int c, size_t n)
{
40000f40:	8b 44 24 04          	mov    0x4(%esp),%eax
    const void *ends = (const char *) s + n;
40000f44:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000f48:	01 c2                	add    %eax,%edx
    for (; s < ends; s++)
40000f4a:	39 d0                	cmp    %edx,%eax
40000f4c:	73 1a                	jae    40000f68 <memchr+0x28>
        if (*(const unsigned char *) s == (unsigned char) c)
40000f4e:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
40000f53:	eb 0a                	jmp    40000f5f <memchr+0x1f>
40000f55:	8d 76 00             	lea    0x0(%esi),%esi
    for (; s < ends; s++)
40000f58:	83 c0 01             	add    $0x1,%eax
40000f5b:	39 c2                	cmp    %eax,%edx
40000f5d:	74 09                	je     40000f68 <memchr+0x28>
        if (*(const unsigned char *) s == (unsigned char) c)
40000f5f:	38 08                	cmp    %cl,(%eax)
40000f61:	75 f5                	jne    40000f58 <memchr+0x18>
            return (void *) s;
    return NULL;
}
40000f63:	c3                   	ret    
40000f64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return NULL;
40000f68:	31 c0                	xor    %eax,%eax
}
40000f6a:	c3                   	ret    
40000f6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000f6f:	90                   	nop

40000f70 <memzero>:

void *memzero(void *v, size_t n)
{
40000f70:	57                   	push   %edi
40000f71:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000f75:	8b 7c 24 08          	mov    0x8(%esp),%edi
    if (n == 0)
40000f79:	85 c9                	test   %ecx,%ecx
40000f7b:	74 0f                	je     40000f8c <memzero+0x1c>
    if ((int) v % 4 == 0 && n % 4 == 0) {
40000f7d:	89 f8                	mov    %edi,%eax
40000f7f:	09 c8                	or     %ecx,%eax
40000f81:	83 e0 03             	and    $0x3,%eax
40000f84:	75 0a                	jne    40000f90 <memzero+0x20>
                      :: "D" (v), "a" (c), "c" (n / 4)
40000f86:	c1 e9 02             	shr    $0x2,%ecx
        asm volatile ("cld; rep stosl\n"
40000f89:	fc                   	cld    
40000f8a:	f3 ab                	rep stos %eax,%es:(%edi)
    return memset(v, 0, n);
}
40000f8c:	89 f8                	mov    %edi,%eax
40000f8e:	5f                   	pop    %edi
40000f8f:	c3                   	ret    
        asm volatile ("cld; rep stosb\n"
40000f90:	31 c0                	xor    %eax,%eax
40000f92:	fc                   	cld    
40000f93:	f3 aa                	rep stos %al,%es:(%edi)
}
40000f95:	89 f8                	mov    %edi,%eax
40000f97:	5f                   	pop    %edi
40000f98:	c3                   	ret    
40000f99:	66 90                	xchg   %ax,%ax
40000f9b:	66 90                	xchg   %ax,%ax
40000f9d:	66 90                	xchg   %ax,%ax
40000f9f:	90                   	nop

40000fa0 <__udivdi3>:
40000fa0:	f3 0f 1e fb          	endbr32 
40000fa4:	55                   	push   %ebp
40000fa5:	57                   	push   %edi
40000fa6:	56                   	push   %esi
40000fa7:	53                   	push   %ebx
40000fa8:	83 ec 1c             	sub    $0x1c,%esp
40000fab:	8b 44 24 3c          	mov    0x3c(%esp),%eax
40000faf:	8b 6c 24 30          	mov    0x30(%esp),%ebp
40000fb3:	8b 74 24 34          	mov    0x34(%esp),%esi
40000fb7:	8b 5c 24 38          	mov    0x38(%esp),%ebx
40000fbb:	85 c0                	test   %eax,%eax
40000fbd:	75 19                	jne    40000fd8 <__udivdi3+0x38>
40000fbf:	39 f3                	cmp    %esi,%ebx
40000fc1:	76 4d                	jbe    40001010 <__udivdi3+0x70>
40000fc3:	31 ff                	xor    %edi,%edi
40000fc5:	89 e8                	mov    %ebp,%eax
40000fc7:	89 f2                	mov    %esi,%edx
40000fc9:	f7 f3                	div    %ebx
40000fcb:	89 fa                	mov    %edi,%edx
40000fcd:	83 c4 1c             	add    $0x1c,%esp
40000fd0:	5b                   	pop    %ebx
40000fd1:	5e                   	pop    %esi
40000fd2:	5f                   	pop    %edi
40000fd3:	5d                   	pop    %ebp
40000fd4:	c3                   	ret    
40000fd5:	8d 76 00             	lea    0x0(%esi),%esi
40000fd8:	39 f0                	cmp    %esi,%eax
40000fda:	76 14                	jbe    40000ff0 <__udivdi3+0x50>
40000fdc:	31 ff                	xor    %edi,%edi
40000fde:	31 c0                	xor    %eax,%eax
40000fe0:	89 fa                	mov    %edi,%edx
40000fe2:	83 c4 1c             	add    $0x1c,%esp
40000fe5:	5b                   	pop    %ebx
40000fe6:	5e                   	pop    %esi
40000fe7:	5f                   	pop    %edi
40000fe8:	5d                   	pop    %ebp
40000fe9:	c3                   	ret    
40000fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000ff0:	0f bd f8             	bsr    %eax,%edi
40000ff3:	83 f7 1f             	xor    $0x1f,%edi
40000ff6:	75 48                	jne    40001040 <__udivdi3+0xa0>
40000ff8:	39 f0                	cmp    %esi,%eax
40000ffa:	72 06                	jb     40001002 <__udivdi3+0x62>
40000ffc:	31 c0                	xor    %eax,%eax
40000ffe:	39 eb                	cmp    %ebp,%ebx
40001000:	77 de                	ja     40000fe0 <__udivdi3+0x40>
40001002:	b8 01 00 00 00       	mov    $0x1,%eax
40001007:	eb d7                	jmp    40000fe0 <__udivdi3+0x40>
40001009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40001010:	89 d9                	mov    %ebx,%ecx
40001012:	85 db                	test   %ebx,%ebx
40001014:	75 0b                	jne    40001021 <__udivdi3+0x81>
40001016:	b8 01 00 00 00       	mov    $0x1,%eax
4000101b:	31 d2                	xor    %edx,%edx
4000101d:	f7 f3                	div    %ebx
4000101f:	89 c1                	mov    %eax,%ecx
40001021:	31 d2                	xor    %edx,%edx
40001023:	89 f0                	mov    %esi,%eax
40001025:	f7 f1                	div    %ecx
40001027:	89 c6                	mov    %eax,%esi
40001029:	89 e8                	mov    %ebp,%eax
4000102b:	89 f7                	mov    %esi,%edi
4000102d:	f7 f1                	div    %ecx
4000102f:	89 fa                	mov    %edi,%edx
40001031:	83 c4 1c             	add    $0x1c,%esp
40001034:	5b                   	pop    %ebx
40001035:	5e                   	pop    %esi
40001036:	5f                   	pop    %edi
40001037:	5d                   	pop    %ebp
40001038:	c3                   	ret    
40001039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40001040:	89 f9                	mov    %edi,%ecx
40001042:	ba 20 00 00 00       	mov    $0x20,%edx
40001047:	29 fa                	sub    %edi,%edx
40001049:	d3 e0                	shl    %cl,%eax
4000104b:	89 44 24 08          	mov    %eax,0x8(%esp)
4000104f:	89 d1                	mov    %edx,%ecx
40001051:	89 d8                	mov    %ebx,%eax
40001053:	d3 e8                	shr    %cl,%eax
40001055:	8b 4c 24 08          	mov    0x8(%esp),%ecx
40001059:	09 c1                	or     %eax,%ecx
4000105b:	89 f0                	mov    %esi,%eax
4000105d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
40001061:	89 f9                	mov    %edi,%ecx
40001063:	d3 e3                	shl    %cl,%ebx
40001065:	89 d1                	mov    %edx,%ecx
40001067:	d3 e8                	shr    %cl,%eax
40001069:	89 f9                	mov    %edi,%ecx
4000106b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
4000106f:	89 eb                	mov    %ebp,%ebx
40001071:	d3 e6                	shl    %cl,%esi
40001073:	89 d1                	mov    %edx,%ecx
40001075:	d3 eb                	shr    %cl,%ebx
40001077:	09 f3                	or     %esi,%ebx
40001079:	89 c6                	mov    %eax,%esi
4000107b:	89 f2                	mov    %esi,%edx
4000107d:	89 d8                	mov    %ebx,%eax
4000107f:	f7 74 24 08          	divl   0x8(%esp)
40001083:	89 d6                	mov    %edx,%esi
40001085:	89 c3                	mov    %eax,%ebx
40001087:	f7 64 24 0c          	mull   0xc(%esp)
4000108b:	39 d6                	cmp    %edx,%esi
4000108d:	72 19                	jb     400010a8 <__udivdi3+0x108>
4000108f:	89 f9                	mov    %edi,%ecx
40001091:	d3 e5                	shl    %cl,%ebp
40001093:	39 c5                	cmp    %eax,%ebp
40001095:	73 04                	jae    4000109b <__udivdi3+0xfb>
40001097:	39 d6                	cmp    %edx,%esi
40001099:	74 0d                	je     400010a8 <__udivdi3+0x108>
4000109b:	89 d8                	mov    %ebx,%eax
4000109d:	31 ff                	xor    %edi,%edi
4000109f:	e9 3c ff ff ff       	jmp    40000fe0 <__udivdi3+0x40>
400010a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400010a8:	8d 43 ff             	lea    -0x1(%ebx),%eax
400010ab:	31 ff                	xor    %edi,%edi
400010ad:	e9 2e ff ff ff       	jmp    40000fe0 <__udivdi3+0x40>
400010b2:	66 90                	xchg   %ax,%ax
400010b4:	66 90                	xchg   %ax,%ax
400010b6:	66 90                	xchg   %ax,%ax
400010b8:	66 90                	xchg   %ax,%ax
400010ba:	66 90                	xchg   %ax,%ax
400010bc:	66 90                	xchg   %ax,%ax
400010be:	66 90                	xchg   %ax,%ax

400010c0 <__umoddi3>:
400010c0:	f3 0f 1e fb          	endbr32 
400010c4:	55                   	push   %ebp
400010c5:	57                   	push   %edi
400010c6:	56                   	push   %esi
400010c7:	53                   	push   %ebx
400010c8:	83 ec 1c             	sub    $0x1c,%esp
400010cb:	8b 74 24 30          	mov    0x30(%esp),%esi
400010cf:	8b 5c 24 34          	mov    0x34(%esp),%ebx
400010d3:	8b 7c 24 3c          	mov    0x3c(%esp),%edi
400010d7:	8b 6c 24 38          	mov    0x38(%esp),%ebp
400010db:	89 f0                	mov    %esi,%eax
400010dd:	89 da                	mov    %ebx,%edx
400010df:	85 ff                	test   %edi,%edi
400010e1:	75 15                	jne    400010f8 <__umoddi3+0x38>
400010e3:	39 dd                	cmp    %ebx,%ebp
400010e5:	76 39                	jbe    40001120 <__umoddi3+0x60>
400010e7:	f7 f5                	div    %ebp
400010e9:	89 d0                	mov    %edx,%eax
400010eb:	31 d2                	xor    %edx,%edx
400010ed:	83 c4 1c             	add    $0x1c,%esp
400010f0:	5b                   	pop    %ebx
400010f1:	5e                   	pop    %esi
400010f2:	5f                   	pop    %edi
400010f3:	5d                   	pop    %ebp
400010f4:	c3                   	ret    
400010f5:	8d 76 00             	lea    0x0(%esi),%esi
400010f8:	39 df                	cmp    %ebx,%edi
400010fa:	77 f1                	ja     400010ed <__umoddi3+0x2d>
400010fc:	0f bd cf             	bsr    %edi,%ecx
400010ff:	83 f1 1f             	xor    $0x1f,%ecx
40001102:	89 4c 24 04          	mov    %ecx,0x4(%esp)
40001106:	75 40                	jne    40001148 <__umoddi3+0x88>
40001108:	39 df                	cmp    %ebx,%edi
4000110a:	72 04                	jb     40001110 <__umoddi3+0x50>
4000110c:	39 f5                	cmp    %esi,%ebp
4000110e:	77 dd                	ja     400010ed <__umoddi3+0x2d>
40001110:	89 da                	mov    %ebx,%edx
40001112:	89 f0                	mov    %esi,%eax
40001114:	29 e8                	sub    %ebp,%eax
40001116:	19 fa                	sbb    %edi,%edx
40001118:	eb d3                	jmp    400010ed <__umoddi3+0x2d>
4000111a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40001120:	89 e9                	mov    %ebp,%ecx
40001122:	85 ed                	test   %ebp,%ebp
40001124:	75 0b                	jne    40001131 <__umoddi3+0x71>
40001126:	b8 01 00 00 00       	mov    $0x1,%eax
4000112b:	31 d2                	xor    %edx,%edx
4000112d:	f7 f5                	div    %ebp
4000112f:	89 c1                	mov    %eax,%ecx
40001131:	89 d8                	mov    %ebx,%eax
40001133:	31 d2                	xor    %edx,%edx
40001135:	f7 f1                	div    %ecx
40001137:	89 f0                	mov    %esi,%eax
40001139:	f7 f1                	div    %ecx
4000113b:	89 d0                	mov    %edx,%eax
4000113d:	31 d2                	xor    %edx,%edx
4000113f:	eb ac                	jmp    400010ed <__umoddi3+0x2d>
40001141:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40001148:	8b 44 24 04          	mov    0x4(%esp),%eax
4000114c:	ba 20 00 00 00       	mov    $0x20,%edx
40001151:	29 c2                	sub    %eax,%edx
40001153:	89 c1                	mov    %eax,%ecx
40001155:	89 e8                	mov    %ebp,%eax
40001157:	d3 e7                	shl    %cl,%edi
40001159:	89 d1                	mov    %edx,%ecx
4000115b:	89 54 24 0c          	mov    %edx,0xc(%esp)
4000115f:	d3 e8                	shr    %cl,%eax
40001161:	89 c1                	mov    %eax,%ecx
40001163:	8b 44 24 04          	mov    0x4(%esp),%eax
40001167:	09 f9                	or     %edi,%ecx
40001169:	89 df                	mov    %ebx,%edi
4000116b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
4000116f:	89 c1                	mov    %eax,%ecx
40001171:	d3 e5                	shl    %cl,%ebp
40001173:	89 d1                	mov    %edx,%ecx
40001175:	d3 ef                	shr    %cl,%edi
40001177:	89 c1                	mov    %eax,%ecx
40001179:	89 f0                	mov    %esi,%eax
4000117b:	d3 e3                	shl    %cl,%ebx
4000117d:	89 d1                	mov    %edx,%ecx
4000117f:	89 fa                	mov    %edi,%edx
40001181:	d3 e8                	shr    %cl,%eax
40001183:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
40001188:	09 d8                	or     %ebx,%eax
4000118a:	f7 74 24 08          	divl   0x8(%esp)
4000118e:	89 d3                	mov    %edx,%ebx
40001190:	d3 e6                	shl    %cl,%esi
40001192:	f7 e5                	mul    %ebp
40001194:	89 c7                	mov    %eax,%edi
40001196:	89 d1                	mov    %edx,%ecx
40001198:	39 d3                	cmp    %edx,%ebx
4000119a:	72 06                	jb     400011a2 <__umoddi3+0xe2>
4000119c:	75 0e                	jne    400011ac <__umoddi3+0xec>
4000119e:	39 c6                	cmp    %eax,%esi
400011a0:	73 0a                	jae    400011ac <__umoddi3+0xec>
400011a2:	29 e8                	sub    %ebp,%eax
400011a4:	1b 54 24 08          	sbb    0x8(%esp),%edx
400011a8:	89 d1                	mov    %edx,%ecx
400011aa:	89 c7                	mov    %eax,%edi
400011ac:	89 f5                	mov    %esi,%ebp
400011ae:	8b 74 24 04          	mov    0x4(%esp),%esi
400011b2:	29 fd                	sub    %edi,%ebp
400011b4:	19 cb                	sbb    %ecx,%ebx
400011b6:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
400011bb:	89 d8                	mov    %ebx,%eax
400011bd:	d3 e0                	shl    %cl,%eax
400011bf:	89 f1                	mov    %esi,%ecx
400011c1:	d3 ed                	shr    %cl,%ebp
400011c3:	d3 eb                	shr    %cl,%ebx
400011c5:	09 e8                	or     %ebp,%eax
400011c7:	89 da                	mov    %ebx,%edx
400011c9:	83 c4 1c             	add    $0x1c,%esp
400011cc:	5b                   	pop    %ebx
400011cd:	5e                   	pop    %esi
400011ce:	5f                   	pop    %edi
400011cf:	5d                   	pop    %ebp
400011d0:	c3                   	ret    
