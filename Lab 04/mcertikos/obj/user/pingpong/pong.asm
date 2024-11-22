
obj/user/pingpong/pong:     file format elf32-i386


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
    printf("pong started.\n");

    for (i = 0; i < 20; i++) {
4000000e:	31 f6                	xor    %esi,%esi
{
40000010:	53                   	push   %ebx
40000011:	e8 31 01 00 00       	call   40000147 <__x86.get_pc_thunk.bx>
40000016:	81 c3 ea 3f 00 00    	add    $0x3fea,%ebx
4000001c:	51                   	push   %ecx
4000001d:	83 ec 18             	sub    $0x18,%esp
    printf("pong started.\n");
40000020:	8d 83 94 e1 ff ff    	lea    -0x1e6c(%ebx),%eax
40000026:	50                   	push   %eax
40000027:	e8 74 02 00 00       	call   400002a0 <printf>
4000002c:	83 c4 10             	add    $0x10,%esp
4000002f:	eb 0f                	jmp    40000040 <main+0x40>
40000031:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for (i = 0; i < 20; i++) {
40000038:	83 c6 01             	add    $0x1,%esi
4000003b:	83 fe 14             	cmp    $0x14,%esi
4000003e:	74 15                	je     40000055 <main+0x55>
        if (i % 2 == 0)
40000040:	f7 c6 01 00 00 00    	test   $0x1,%esi
40000046:	75 f0                	jne    40000038 <main+0x38>
            consume();
40000048:	e8 53 0a 00 00       	call   40000aa0 <consume>
    for (i = 0; i < 20; i++) {
4000004d:	83 c6 01             	add    $0x1,%esi
40000050:	83 fe 14             	cmp    $0x14,%esi
40000053:	75 eb                	jne    40000040 <main+0x40>
    }

    return 0;
}
40000055:	8d 65 f4             	lea    -0xc(%ebp),%esp
40000058:	31 c0                	xor    %eax,%eax
4000005a:	59                   	pop    %ecx
4000005b:	5b                   	pop    %ebx
4000005c:	5e                   	pop    %esi
4000005d:	5d                   	pop    %ebp
4000005e:	8d 61 fc             	lea    -0x4(%ecx),%esp
40000061:	c3                   	ret    

40000062 <_start>:
_start:
	/*
	 * If there are arguments on the stack, then the current stack will not
	 * be aligned to a nice big power-of-two boundary.
	 */
	testl	$0x0fffffff, %esp
40000062:	f7 c4 ff ff ff 0f    	test   $0xfffffff,%esp
	jnz	args_exist
40000068:	75 04                	jne    4000006e <args_exist>

4000006a <noargs>:

noargs:
	/* If no arguments are on the stack, push two dummy zero. */
	pushl	$0
4000006a:	6a 00                	push   $0x0
	pushl	$0
4000006c:	6a 00                	push   $0x0

4000006e <args_exist>:

args_exist:
	/* Jump to the C part. */
	call	main
4000006e:	e8 8d ff ff ff       	call   40000000 <main>

	/* When returning, push the return value on the stack. */
	pushl	%eax
40000073:	50                   	push   %eax

40000074 <spin>:
spin:
	jmp	spin
40000074:	eb fe                	jmp    40000074 <spin>
40000076:	66 90                	xchg   %ax,%ax
40000078:	66 90                	xchg   %ax,%ax
4000007a:	66 90                	xchg   %ax,%ax
4000007c:	66 90                	xchg   %ax,%ax
4000007e:	66 90                	xchg   %ax,%ax

40000080 <debug>:
#include <proc.h>
#include <stdarg.h>
#include <stdio.h>

void debug(const char *file, int line, const char *fmt, ...)
{
40000080:	53                   	push   %ebx
40000081:	e8 c1 00 00 00       	call   40000147 <__x86.get_pc_thunk.bx>
40000086:	81 c3 7a 3f 00 00    	add    $0x3f7a,%ebx
4000008c:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[D] %s:%d: ", file, line);
4000008f:	ff 74 24 18          	push   0x18(%esp)
40000093:	ff 74 24 18          	push   0x18(%esp)
40000097:	8d 83 00 e0 ff ff    	lea    -0x2000(%ebx),%eax
4000009d:	50                   	push   %eax
4000009e:	e8 fd 01 00 00       	call   400002a0 <printf>
    vcprintf(fmt, ap);
400000a3:	58                   	pop    %eax
400000a4:	5a                   	pop    %edx
400000a5:	8d 44 24 24          	lea    0x24(%esp),%eax
400000a9:	50                   	push   %eax
400000aa:	ff 74 24 24          	push   0x24(%esp)
400000ae:	e8 8d 01 00 00       	call   40000240 <vcprintf>
    va_end(ap);
}
400000b3:	83 c4 18             	add    $0x18,%esp
400000b6:	5b                   	pop    %ebx
400000b7:	c3                   	ret    
400000b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400000bf:	90                   	nop

400000c0 <warn>:

void warn(const char *file, int line, const char *fmt, ...)
{
400000c0:	53                   	push   %ebx
400000c1:	e8 81 00 00 00       	call   40000147 <__x86.get_pc_thunk.bx>
400000c6:	81 c3 3a 3f 00 00    	add    $0x3f3a,%ebx
400000cc:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[W] %s:%d: ", file, line);
400000cf:	ff 74 24 18          	push   0x18(%esp)
400000d3:	ff 74 24 18          	push   0x18(%esp)
400000d7:	8d 83 0c e0 ff ff    	lea    -0x1ff4(%ebx),%eax
400000dd:	50                   	push   %eax
400000de:	e8 bd 01 00 00       	call   400002a0 <printf>
    vcprintf(fmt, ap);
400000e3:	58                   	pop    %eax
400000e4:	5a                   	pop    %edx
400000e5:	8d 44 24 24          	lea    0x24(%esp),%eax
400000e9:	50                   	push   %eax
400000ea:	ff 74 24 24          	push   0x24(%esp)
400000ee:	e8 4d 01 00 00       	call   40000240 <vcprintf>
    va_end(ap);
}
400000f3:	83 c4 18             	add    $0x18,%esp
400000f6:	5b                   	pop    %ebx
400000f7:	c3                   	ret    
400000f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400000ff:	90                   	nop

40000100 <panic>:

void panic(const char *file, int line, const char *fmt, ...)
{
40000100:	53                   	push   %ebx
40000101:	e8 41 00 00 00       	call   40000147 <__x86.get_pc_thunk.bx>
40000106:	81 c3 fa 3e 00 00    	add    $0x3efa,%ebx
4000010c:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[P] %s:%d: ", file, line);
4000010f:	ff 74 24 18          	push   0x18(%esp)
40000113:	ff 74 24 18          	push   0x18(%esp)
40000117:	8d 83 18 e0 ff ff    	lea    -0x1fe8(%ebx),%eax
4000011d:	50                   	push   %eax
4000011e:	e8 7d 01 00 00       	call   400002a0 <printf>
    vcprintf(fmt, ap);
40000123:	58                   	pop    %eax
40000124:	5a                   	pop    %edx
40000125:	8d 44 24 24          	lea    0x24(%esp),%eax
40000129:	50                   	push   %eax
4000012a:	ff 74 24 24          	push   0x24(%esp)
4000012e:	e8 0d 01 00 00       	call   40000240 <vcprintf>
40000133:	83 c4 10             	add    $0x10,%esp
40000136:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000013d:	8d 76 00             	lea    0x0(%esi),%esi
    va_end(ap);

    while (1)
        yield();
40000140:	e8 3b 09 00 00       	call   40000a80 <yield>
    while (1)
40000145:	eb f9                	jmp    40000140 <panic+0x40>

40000147 <__x86.get_pc_thunk.bx>:
40000147:	8b 1c 24             	mov    (%esp),%ebx
4000014a:	c3                   	ret    
4000014b:	66 90                	xchg   %ax,%ax
4000014d:	66 90                	xchg   %ax,%ax
4000014f:	90                   	nop

40000150 <atoi>:
#include <stdlib.h>

int atoi(const char *buf, int *i)
{
40000150:	55                   	push   %ebp
40000151:	57                   	push   %edi
40000152:	56                   	push   %esi
40000153:	53                   	push   %ebx
    int loc = 0;
    int numstart = 0;
    int acc = 0;
    int negative = 0;
    if (buf[loc] == '+')
40000154:	8b 44 24 14          	mov    0x14(%esp),%eax
40000158:	0f b6 00             	movzbl (%eax),%eax
4000015b:	3c 2b                	cmp    $0x2b,%al
4000015d:	0f 84 85 00 00 00    	je     400001e8 <atoi+0x98>
    int negative = 0;
40000163:	31 ff                	xor    %edi,%edi
    int loc = 0;
40000165:	31 f6                	xor    %esi,%esi
        loc++;
    else if (buf[loc] == '-') {
40000167:	3c 2d                	cmp    $0x2d,%al
40000169:	74 55                	je     400001c0 <atoi+0x70>
        negative = 1;
        loc++;
    }
    numstart = loc;
    // no grab the numbers
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000016b:	8d 50 d0             	lea    -0x30(%eax),%edx
4000016e:	80 fa 09             	cmp    $0x9,%dl
40000171:	77 67                	ja     400001da <atoi+0x8a>
40000173:	89 f2                	mov    %esi,%edx
    int acc = 0;
40000175:	31 c9                	xor    %ecx,%ecx
40000177:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000017e:	66 90                	xchg   %ax,%ax
        acc = acc * 10 + (buf[loc] - '0');
40000180:	83 e8 30             	sub    $0x30,%eax
40000183:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
        loc++;
40000186:	83 c2 01             	add    $0x1,%edx
        acc = acc * 10 + (buf[loc] - '0');
40000189:	0f be c0             	movsbl %al,%eax
4000018c:	8d 0c 48             	lea    (%eax,%ecx,2),%ecx
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000018f:	8b 44 24 14          	mov    0x14(%esp),%eax
40000193:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
40000197:	8d 68 d0             	lea    -0x30(%eax),%ebp
4000019a:	89 eb                	mov    %ebp,%ebx
4000019c:	80 fb 09             	cmp    $0x9,%bl
4000019f:	76 df                	jbe    40000180 <atoi+0x30>
    }
    if (numstart == loc) {
400001a1:	39 d6                	cmp    %edx,%esi
400001a3:	74 35                	je     400001da <atoi+0x8a>
        // no numbers have actually been scanned
        return 0;
    }
    if (negative)
        acc = -acc;
400001a5:	89 c8                	mov    %ecx,%eax
400001a7:	f7 d8                	neg    %eax
400001a9:	85 ff                	test   %edi,%edi
400001ab:	0f 45 c8             	cmovne %eax,%ecx
    *i = acc;
400001ae:	8b 44 24 18          	mov    0x18(%esp),%eax
400001b2:	89 08                	mov    %ecx,(%eax)
    return loc;
}
400001b4:	89 d0                	mov    %edx,%eax
400001b6:	5b                   	pop    %ebx
400001b7:	5e                   	pop    %esi
400001b8:	5f                   	pop    %edi
400001b9:	5d                   	pop    %ebp
400001ba:	c3                   	ret    
400001bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400001bf:	90                   	nop
    while ('0' <= buf[loc] && buf[loc] <= '9') {
400001c0:	8b 44 24 14          	mov    0x14(%esp),%eax
        negative = 1;
400001c4:	bf 01 00 00 00       	mov    $0x1,%edi
        loc++;
400001c9:	be 01 00 00 00       	mov    $0x1,%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
400001ce:	0f b6 40 01          	movzbl 0x1(%eax),%eax
400001d2:	8d 50 d0             	lea    -0x30(%eax),%edx
400001d5:	80 fa 09             	cmp    $0x9,%dl
400001d8:	76 99                	jbe    40000173 <atoi+0x23>
        return 0;
400001da:	31 d2                	xor    %edx,%edx
}
400001dc:	5b                   	pop    %ebx
400001dd:	5e                   	pop    %esi
400001de:	89 d0                	mov    %edx,%eax
400001e0:	5f                   	pop    %edi
400001e1:	5d                   	pop    %ebp
400001e2:	c3                   	ret    
400001e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400001e7:	90                   	nop
    while ('0' <= buf[loc] && buf[loc] <= '9') {
400001e8:	8b 44 24 14          	mov    0x14(%esp),%eax
    int negative = 0;
400001ec:	31 ff                	xor    %edi,%edi
        loc++;
400001ee:	be 01 00 00 00       	mov    $0x1,%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
400001f3:	0f b6 40 01          	movzbl 0x1(%eax),%eax
400001f7:	e9 6f ff ff ff       	jmp    4000016b <atoi+0x1b>
400001fc:	66 90                	xchg   %ax,%ax
400001fe:	66 90                	xchg   %ax,%ax

40000200 <putch>:
    int cnt;            // total bytes printed so far
    char buf[MAX_BUF];
};

static void putch(int ch, struct printbuf *b)
{
40000200:	53                   	push   %ebx
40000201:	8b 54 24 0c          	mov    0xc(%esp),%edx
    b->buf[b->idx++] = ch;
40000205:	0f b6 5c 24 08       	movzbl 0x8(%esp),%ebx
4000020a:	8b 02                	mov    (%edx),%eax
4000020c:	8d 48 01             	lea    0x1(%eax),%ecx
4000020f:	89 0a                	mov    %ecx,(%edx)
40000211:	88 5c 02 08          	mov    %bl,0x8(%edx,%eax,1)
    if (b->idx == MAX_BUF - 1) {
40000215:	81 f9 ff 01 00 00    	cmp    $0x1ff,%ecx
4000021b:	75 14                	jne    40000231 <putch+0x31>
        b->buf[b->idx] = 0;
4000021d:	c6 82 07 02 00 00 00 	movb   $0x0,0x207(%edx)
        puts(b->buf, b->idx);
40000224:	8d 5a 08             	lea    0x8(%edx),%ebx
#include <types.h>
#include <x86.h>

static gcc_inline void sys_puts(const char *s, size_t len)
{
    asm volatile ("int %0"
40000227:	31 c0                	xor    %eax,%eax
40000229:	cd 30                	int    $0x30
        b->idx = 0;
4000022b:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
    }
    b->cnt++;
40000231:	83 42 04 01          	addl   $0x1,0x4(%edx)
}
40000235:	5b                   	pop    %ebx
40000236:	c3                   	ret    
40000237:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000023e:	66 90                	xchg   %ax,%ax

40000240 <vcprintf>:

int vcprintf(const char *fmt, va_list ap)
{
40000240:	53                   	push   %ebx
40000241:	e8 01 ff ff ff       	call   40000147 <__x86.get_pc_thunk.bx>
40000246:	81 c3 ba 3d 00 00    	add    $0x3dba,%ebx
4000024c:	81 ec 18 02 00 00    	sub    $0x218,%esp
    struct printbuf b;

    b.idx = 0;
40000252:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
40000259:	00 
    b.cnt = 0;
4000025a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000261:	00 
    vprintfmt((void *) putch, &b, fmt, ap);
40000262:	ff b4 24 24 02 00 00 	push   0x224(%esp)
40000269:	ff b4 24 24 02 00 00 	push   0x224(%esp)
40000270:	8d 44 24 10          	lea    0x10(%esp),%eax
40000274:	50                   	push   %eax
40000275:	8d 83 00 c2 ff ff    	lea    -0x3e00(%ebx),%eax
4000027b:	50                   	push   %eax
4000027c:	e8 3f 01 00 00       	call   400003c0 <vprintfmt>

    b.buf[b.idx] = 0;
40000281:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000285:	8d 5c 24 20          	lea    0x20(%esp),%ebx
40000289:	31 c0                	xor    %eax,%eax
4000028b:	c6 44 0c 20 00       	movb   $0x0,0x20(%esp,%ecx,1)
40000290:	cd 30                	int    $0x30
    puts(b.buf, b.idx);

    return b.cnt;
}
40000292:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000296:	81 c4 28 02 00 00    	add    $0x228,%esp
4000029c:	5b                   	pop    %ebx
4000029d:	c3                   	ret    
4000029e:	66 90                	xchg   %ax,%ax

400002a0 <printf>:

int printf(const char *fmt, ...)
{
400002a0:	83 ec 14             	sub    $0x14,%esp
    va_list ap;
    int cnt;

    va_start(ap, fmt);
    cnt = vcprintf(fmt, ap);
400002a3:	8d 44 24 1c          	lea    0x1c(%esp),%eax
400002a7:	50                   	push   %eax
400002a8:	ff 74 24 1c          	push   0x1c(%esp)
400002ac:	e8 8f ff ff ff       	call   40000240 <vcprintf>
    va_end(ap);

    return cnt;
}
400002b1:	83 c4 1c             	add    $0x1c,%esp
400002b4:	c3                   	ret    
400002b5:	66 90                	xchg   %ax,%ax
400002b7:	66 90                	xchg   %ax,%ax
400002b9:	66 90                	xchg   %ax,%ax
400002bb:	66 90                	xchg   %ax,%ax
400002bd:	66 90                	xchg   %ax,%ax
400002bf:	90                   	nop

400002c0 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void *), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
400002c0:	e8 96 07 00 00       	call   40000a5b <__x86.get_pc_thunk.cx>
400002c5:	81 c1 3b 3d 00 00    	add    $0x3d3b,%ecx
400002cb:	55                   	push   %ebp
400002cc:	57                   	push   %edi
400002cd:	89 d7                	mov    %edx,%edi
400002cf:	56                   	push   %esi
400002d0:	89 c6                	mov    %eax,%esi
400002d2:	53                   	push   %ebx
400002d3:	83 ec 2c             	sub    $0x2c,%esp
400002d6:	8b 54 24 44          	mov    0x44(%esp),%edx
400002da:	8b 44 24 40          	mov    0x40(%esp),%eax
400002de:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, num / base, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (--width > 0)
400002e2:	8b 4c 24 4c          	mov    0x4c(%esp),%ecx
{
400002e6:	8b 5c 24 50          	mov    0x50(%esp),%ebx
    if (num >= base) {
400002ea:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
400002f1:	00 
{
400002f2:	89 54 24 0c          	mov    %edx,0xc(%esp)
400002f6:	8b 54 24 48          	mov    0x48(%esp),%edx
400002fa:	89 44 24 08          	mov    %eax,0x8(%esp)
    if (num >= base) {
400002fe:	8b 44 24 0c          	mov    0xc(%esp),%eax
        while (--width > 0)
40000302:	8d 69 ff             	lea    -0x1(%ecx),%ebp
    if (num >= base) {
40000305:	39 54 24 08          	cmp    %edx,0x8(%esp)
40000309:	1b 44 24 14          	sbb    0x14(%esp),%eax
4000030d:	89 54 24 10          	mov    %edx,0x10(%esp)
40000311:	73 55                	jae    40000368 <printnum+0xa8>
        while (--width > 0)
40000313:	85 ed                	test   %ebp,%ebp
40000315:	7e 18                	jle    4000032f <printnum+0x6f>
40000317:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000031e:	66 90                	xchg   %ax,%ax
            putch(padc, putdat);
40000320:	83 ec 08             	sub    $0x8,%esp
40000323:	57                   	push   %edi
40000324:	53                   	push   %ebx
40000325:	ff d6                	call   *%esi
        while (--width > 0)
40000327:	83 c4 10             	add    $0x10,%esp
4000032a:	83 ed 01             	sub    $0x1,%ebp
4000032d:	75 f1                	jne    40000320 <printnum+0x60>
    }

    // then print this (the least significant) digit
    putch("0123456789abcdef"[num % base], putdat);
4000032f:	89 7c 24 44          	mov    %edi,0x44(%esp)
40000333:	ff 74 24 14          	push   0x14(%esp)
40000337:	ff 74 24 14          	push   0x14(%esp)
4000033b:	ff 74 24 14          	push   0x14(%esp)
4000033f:	ff 74 24 14          	push   0x14(%esp)
40000343:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
40000347:	e8 a4 0d 00 00       	call   400010f0 <__umoddi3>
4000034c:	0f be 84 03 24 e0 ff 	movsbl -0x1fdc(%ebx,%eax,1),%eax
40000353:	ff 
40000354:	89 44 24 50          	mov    %eax,0x50(%esp)
}
40000358:	83 c4 3c             	add    $0x3c,%esp
    putch("0123456789abcdef"[num % base], putdat);
4000035b:	89 f0                	mov    %esi,%eax
}
4000035d:	5b                   	pop    %ebx
4000035e:	5e                   	pop    %esi
4000035f:	5f                   	pop    %edi
40000360:	5d                   	pop    %ebp
    putch("0123456789abcdef"[num % base], putdat);
40000361:	ff e0                	jmp    *%eax
40000363:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000367:	90                   	nop
        printnum(putch, putdat, num / base, base, width - 1, padc);
40000368:	83 ec 0c             	sub    $0xc,%esp
4000036b:	53                   	push   %ebx
4000036c:	55                   	push   %ebp
4000036d:	52                   	push   %edx
4000036e:	83 ec 08             	sub    $0x8,%esp
40000371:	ff 74 24 34          	push   0x34(%esp)
40000375:	ff 74 24 34          	push   0x34(%esp)
40000379:	ff 74 24 34          	push   0x34(%esp)
4000037d:	ff 74 24 34          	push   0x34(%esp)
40000381:	8b 5c 24 4c          	mov    0x4c(%esp),%ebx
40000385:	e8 46 0c 00 00       	call   40000fd0 <__udivdi3>
4000038a:	83 c4 18             	add    $0x18,%esp
4000038d:	52                   	push   %edx
4000038e:	89 fa                	mov    %edi,%edx
40000390:	50                   	push   %eax
40000391:	89 f0                	mov    %esi,%eax
40000393:	e8 28 ff ff ff       	call   400002c0 <printnum>
40000398:	83 c4 20             	add    $0x20,%esp
4000039b:	eb 92                	jmp    4000032f <printnum+0x6f>
4000039d:	8d 76 00             	lea    0x0(%esi),%esi

400003a0 <sprintputch>:
    char *ebuf;
    int cnt;
};

static void sprintputch(int ch, struct sprintbuf *b)
{
400003a0:	8b 44 24 08          	mov    0x8(%esp),%eax
    b->cnt++;
400003a4:	83 40 08 01          	addl   $0x1,0x8(%eax)
    if (b->buf < b->ebuf)
400003a8:	8b 10                	mov    (%eax),%edx
400003aa:	3b 50 04             	cmp    0x4(%eax),%edx
400003ad:	73 0b                	jae    400003ba <sprintputch+0x1a>
        *b->buf++ = ch;
400003af:	8d 4a 01             	lea    0x1(%edx),%ecx
400003b2:	89 08                	mov    %ecx,(%eax)
400003b4:	8b 44 24 04          	mov    0x4(%esp),%eax
400003b8:	88 02                	mov    %al,(%edx)
}
400003ba:	c3                   	ret    
400003bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400003bf:	90                   	nop

400003c0 <vprintfmt>:
{
400003c0:	e8 8e 06 00 00       	call   40000a53 <__x86.get_pc_thunk.ax>
400003c5:	05 3b 3c 00 00       	add    $0x3c3b,%eax
400003ca:	55                   	push   %ebp
400003cb:	57                   	push   %edi
400003cc:	56                   	push   %esi
400003cd:	53                   	push   %ebx
400003ce:	83 ec 3c             	sub    $0x3c,%esp
400003d1:	8b 74 24 50          	mov    0x50(%esp),%esi
400003d5:	8b 6c 24 54          	mov    0x54(%esp),%ebp
400003d9:	89 44 24 14          	mov    %eax,0x14(%esp)
                for (width -= strnlen(p, precision); width > 0; width--)
400003dd:	8d 80 35 e0 ff ff    	lea    -0x1fcb(%eax),%eax
400003e3:	89 44 24 24          	mov    %eax,0x24(%esp)
{
400003e7:	8b 7c 24 58          	mov    0x58(%esp),%edi
        while ((ch = *(unsigned char *) fmt++) != '%') {
400003eb:	0f b6 07             	movzbl (%edi),%eax
400003ee:	8d 5f 01             	lea    0x1(%edi),%ebx
400003f1:	83 f8 25             	cmp    $0x25,%eax
400003f4:	75 20                	jne    40000416 <vprintfmt+0x56>
400003f6:	eb 30                	jmp    40000428 <vprintfmt+0x68>
400003f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400003ff:	90                   	nop
            putch(ch, putdat);
40000400:	83 ec 08             	sub    $0x8,%esp
        while ((ch = *(unsigned char *) fmt++) != '%') {
40000403:	83 c3 01             	add    $0x1,%ebx
            putch(ch, putdat);
40000406:	55                   	push   %ebp
40000407:	50                   	push   %eax
40000408:	ff d6                	call   *%esi
        while ((ch = *(unsigned char *) fmt++) != '%') {
4000040a:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
4000040e:	83 c4 10             	add    $0x10,%esp
40000411:	83 f8 25             	cmp    $0x25,%eax
40000414:	74 12                	je     40000428 <vprintfmt+0x68>
            if (ch == '\0')
40000416:	85 c0                	test   %eax,%eax
40000418:	75 e6                	jne    40000400 <vprintfmt+0x40>
}
4000041a:	83 c4 3c             	add    $0x3c,%esp
4000041d:	5b                   	pop    %ebx
4000041e:	5e                   	pop    %esi
4000041f:	5f                   	pop    %edi
40000420:	5d                   	pop    %ebp
40000421:	c3                   	ret    
40000422:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        precision = -1;
40000428:	ba ff ff ff ff       	mov    $0xffffffff,%edx
        padc = ' ';
4000042d:	c6 44 24 18 20       	movb   $0x20,0x18(%esp)
        altflag = 0;
40000432:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
40000439:	00 
        width = -1;
4000043a:	c7 44 24 10 ff ff ff 	movl   $0xffffffff,0x10(%esp)
40000441:	ff 
        lflag = 0;
40000442:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%esp)
40000449:	00 
4000044a:	89 54 24 1c          	mov    %edx,0x1c(%esp)
4000044e:	89 74 24 50          	mov    %esi,0x50(%esp)
        switch (ch = *(unsigned char *) fmt++) {
40000452:	0f b6 0b             	movzbl (%ebx),%ecx
40000455:	8d 7b 01             	lea    0x1(%ebx),%edi
40000458:	8d 41 dd             	lea    -0x23(%ecx),%eax
4000045b:	3c 55                	cmp    $0x55,%al
4000045d:	77 19                	ja     40000478 <.L20>
4000045f:	8b 54 24 14          	mov    0x14(%esp),%edx
40000463:	0f b6 c0             	movzbl %al,%eax
40000466:	8b b4 82 3c e0 ff ff 	mov    -0x1fc4(%edx,%eax,4),%esi
4000046d:	01 d6                	add    %edx,%esi
4000046f:	ff e6                	jmp    *%esi
40000471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000478 <.L20>:
            putch('%', putdat);
40000478:	8b 74 24 50          	mov    0x50(%esp),%esi
4000047c:	83 ec 08             	sub    $0x8,%esp
            for (fmt--; fmt[-1] != '%'; fmt--)
4000047f:	89 df                	mov    %ebx,%edi
            putch('%', putdat);
40000481:	55                   	push   %ebp
40000482:	6a 25                	push   $0x25
40000484:	ff d6                	call   *%esi
            for (fmt--; fmt[-1] != '%'; fmt--)
40000486:	83 c4 10             	add    $0x10,%esp
40000489:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
4000048d:	0f 84 58 ff ff ff    	je     400003eb <vprintfmt+0x2b>
40000493:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000497:	90                   	nop
40000498:	83 ef 01             	sub    $0x1,%edi
4000049b:	80 7f ff 25          	cmpb   $0x25,-0x1(%edi)
4000049f:	75 f7                	jne    40000498 <.L20+0x20>
400004a1:	e9 45 ff ff ff       	jmp    400003eb <vprintfmt+0x2b>
400004a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400004ad:	8d 76 00             	lea    0x0(%esi),%esi

400004b0 <.L30>:
                ch = *fmt;
400004b0:	0f be 43 01          	movsbl 0x1(%ebx),%eax
                precision = precision * 10 + ch - '0';
400004b4:	8d 51 d0             	lea    -0x30(%ecx),%edx
        switch (ch = *(unsigned char *) fmt++) {
400004b7:	89 fb                	mov    %edi,%ebx
                precision = precision * 10 + ch - '0';
400004b9:	89 54 24 1c          	mov    %edx,0x1c(%esp)
                if (ch < '0' || ch > '9')
400004bd:	8d 48 d0             	lea    -0x30(%eax),%ecx
400004c0:	83 f9 09             	cmp    $0x9,%ecx
400004c3:	77 28                	ja     400004ed <.L30+0x3d>
        switch (ch = *(unsigned char *) fmt++) {
400004c5:	8b 74 24 50          	mov    0x50(%esp),%esi
400004c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            for (precision = 0;; ++fmt) {
400004d0:	83 c3 01             	add    $0x1,%ebx
                precision = precision * 10 + ch - '0';
400004d3:	8d 14 92             	lea    (%edx,%edx,4),%edx
400004d6:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
                ch = *fmt;
400004da:	0f be 03             	movsbl (%ebx),%eax
                if (ch < '0' || ch > '9')
400004dd:	8d 48 d0             	lea    -0x30(%eax),%ecx
400004e0:	83 f9 09             	cmp    $0x9,%ecx
400004e3:	76 eb                	jbe    400004d0 <.L30+0x20>
400004e5:	89 54 24 1c          	mov    %edx,0x1c(%esp)
400004e9:	89 74 24 50          	mov    %esi,0x50(%esp)
            if (width < 0)
400004ed:	8b 74 24 10          	mov    0x10(%esp),%esi
400004f1:	85 f6                	test   %esi,%esi
400004f3:	0f 89 59 ff ff ff    	jns    40000452 <vprintfmt+0x92>
                width = precision, precision = -1;
400004f9:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400004fd:	c7 44 24 1c ff ff ff 	movl   $0xffffffff,0x1c(%esp)
40000504:	ff 
40000505:	89 44 24 10          	mov    %eax,0x10(%esp)
40000509:	e9 44 ff ff ff       	jmp    40000452 <vprintfmt+0x92>

4000050e <.L35>:
            altflag = 1;
4000050e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
40000515:	00 
        switch (ch = *(unsigned char *) fmt++) {
40000516:	89 fb                	mov    %edi,%ebx
            goto reswitch;
40000518:	e9 35 ff ff ff       	jmp    40000452 <vprintfmt+0x92>

4000051d <.L34>:
            putch(ch, putdat);
4000051d:	8b 74 24 50          	mov    0x50(%esp),%esi
40000521:	83 ec 08             	sub    $0x8,%esp
40000524:	55                   	push   %ebp
40000525:	6a 25                	push   $0x25
40000527:	ff d6                	call   *%esi
            break;
40000529:	83 c4 10             	add    $0x10,%esp
4000052c:	e9 ba fe ff ff       	jmp    400003eb <vprintfmt+0x2b>

40000531 <.L33>:
            precision = va_arg(ap, int);
40000531:	8b 44 24 5c          	mov    0x5c(%esp),%eax
        switch (ch = *(unsigned char *) fmt++) {
40000535:	89 fb                	mov    %edi,%ebx
            precision = va_arg(ap, int);
40000537:	8b 00                	mov    (%eax),%eax
40000539:	89 44 24 1c          	mov    %eax,0x1c(%esp)
4000053d:	8b 44 24 5c          	mov    0x5c(%esp),%eax
40000541:	83 c0 04             	add    $0x4,%eax
40000544:	89 44 24 5c          	mov    %eax,0x5c(%esp)
            goto process_precision;
40000548:	eb a3                	jmp    400004ed <.L30+0x3d>

4000054a <.L32>:
            if (width < 0)
4000054a:	8b 4c 24 10          	mov    0x10(%esp),%ecx
4000054e:	31 c0                	xor    %eax,%eax
        switch (ch = *(unsigned char *) fmt++) {
40000550:	89 fb                	mov    %edi,%ebx
40000552:	85 c9                	test   %ecx,%ecx
40000554:	0f 49 c1             	cmovns %ecx,%eax
40000557:	89 44 24 10          	mov    %eax,0x10(%esp)
            goto reswitch;
4000055b:	e9 f2 fe ff ff       	jmp    40000452 <vprintfmt+0x92>

40000560 <.L29>:
            putch(va_arg(ap, int), putdat);
40000560:	8b 44 24 5c          	mov    0x5c(%esp),%eax
40000564:	8b 74 24 50          	mov    0x50(%esp),%esi
40000568:	83 ec 08             	sub    $0x8,%esp
4000056b:	55                   	push   %ebp
4000056c:	8d 58 04             	lea    0x4(%eax),%ebx
4000056f:	8b 44 24 68          	mov    0x68(%esp),%eax
40000573:	ff 30                	push   (%eax)
40000575:	ff d6                	call   *%esi
40000577:	89 5c 24 6c          	mov    %ebx,0x6c(%esp)
            break;
4000057b:	83 c4 10             	add    $0x10,%esp
4000057e:	e9 68 fe ff ff       	jmp    400003eb <vprintfmt+0x2b>

40000583 <.L23>:
    if (lflag >= 2)
40000583:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
40000588:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, unsigned long long);
4000058c:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
40000590:	0f 8f d7 01 00 00    	jg     4000076d <.L24+0xe0>
        return va_arg(*ap, unsigned long);
40000596:	8b 4c 24 5c          	mov    0x5c(%esp),%ecx
            precision = va_arg(ap, int);
4000059a:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
4000059d:	31 db                	xor    %ebx,%ebx
4000059f:	ba 0a 00 00 00       	mov    $0xa,%edx
400005a4:	8b 09                	mov    (%ecx),%ecx
400005a6:	89 44 24 5c          	mov    %eax,0x5c(%esp)
400005aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            printnum(putch, putdat, num, base, width, padc);
400005b0:	83 ec 0c             	sub    $0xc,%esp
400005b3:	0f be 44 24 24       	movsbl 0x24(%esp),%eax
400005b8:	50                   	push   %eax
400005b9:	89 f0                	mov    %esi,%eax
400005bb:	ff 74 24 20          	push   0x20(%esp)
400005bf:	52                   	push   %edx
400005c0:	89 ea                	mov    %ebp,%edx
400005c2:	53                   	push   %ebx
400005c3:	51                   	push   %ecx
400005c4:	e8 f7 fc ff ff       	call   400002c0 <printnum>
            break;
400005c9:	83 c4 20             	add    $0x20,%esp
400005cc:	e9 1a fe ff ff       	jmp    400003eb <vprintfmt+0x2b>

400005d1 <.L25>:
            putch('0', putdat);
400005d1:	8b 74 24 50          	mov    0x50(%esp),%esi
400005d5:	83 ec 08             	sub    $0x8,%esp
400005d8:	55                   	push   %ebp
400005d9:	6a 30                	push   $0x30
400005db:	ff d6                	call   *%esi
            putch('x', putdat);
400005dd:	59                   	pop    %ecx
400005de:	5b                   	pop    %ebx
400005df:	55                   	push   %ebp
400005e0:	6a 78                	push   $0x78
            num = (unsigned long long)
400005e2:	31 db                	xor    %ebx,%ebx
            putch('x', putdat);
400005e4:	ff d6                	call   *%esi
            num = (unsigned long long)
400005e6:	8b 44 24 6c          	mov    0x6c(%esp),%eax
            goto number;
400005ea:	ba 10 00 00 00       	mov    $0x10,%edx
            num = (unsigned long long)
400005ef:	8b 08                	mov    (%eax),%ecx
            goto number;
400005f1:	83 c4 10             	add    $0x10,%esp
                (uintptr_t) va_arg(ap, void *);
400005f4:	83 c0 04             	add    $0x4,%eax
400005f7:	89 44 24 5c          	mov    %eax,0x5c(%esp)
            goto number;
400005fb:	eb b3                	jmp    400005b0 <.L23+0x2d>

400005fd <.L21>:
    if (lflag >= 2)
400005fd:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
40000602:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, unsigned long long);
40000606:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
4000060a:	0f 8f 6e 01 00 00    	jg     4000077e <.L24+0xf1>
        return va_arg(*ap, unsigned long);
40000610:	8b 4c 24 5c          	mov    0x5c(%esp),%ecx
            precision = va_arg(ap, int);
40000614:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
40000617:	31 db                	xor    %ebx,%ebx
40000619:	ba 10 00 00 00       	mov    $0x10,%edx
4000061e:	8b 09                	mov    (%ecx),%ecx
40000620:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000624:	eb 8a                	jmp    400005b0 <.L23+0x2d>

40000626 <.L28>:
    if (lflag >= 2)
40000626:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
4000062b:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, long long);
4000062f:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
40000633:	0f 8f 5b 01 00 00    	jg     40000794 <.L24+0x107>
        return va_arg(*ap, long);
40000639:	8b 00                	mov    (%eax),%eax
4000063b:	89 c3                	mov    %eax,%ebx
4000063d:	89 c1                	mov    %eax,%ecx
4000063f:	8b 44 24 5c          	mov    0x5c(%esp),%eax
40000643:	c1 fb 1f             	sar    $0x1f,%ebx
40000646:	83 c0 04             	add    $0x4,%eax
40000649:	89 44 24 5c          	mov    %eax,0x5c(%esp)
            if ((long long) num < 0) {
4000064d:	85 db                	test   %ebx,%ebx
4000064f:	0f 88 68 01 00 00    	js     400007bd <.L31+0xc>
        return va_arg(*ap, unsigned long long);
40000655:	ba 0a 00 00 00       	mov    $0xa,%edx
4000065a:	e9 51 ff ff ff       	jmp    400005b0 <.L23+0x2d>

4000065f <.L27>:
            lflag++;
4000065f:	83 44 24 20 01       	addl   $0x1,0x20(%esp)
        switch (ch = *(unsigned char *) fmt++) {
40000664:	89 fb                	mov    %edi,%ebx
            goto reswitch;
40000666:	e9 e7 fd ff ff       	jmp    40000452 <vprintfmt+0x92>

4000066b <.L26>:
            putch('X', putdat);
4000066b:	8b 74 24 50          	mov    0x50(%esp),%esi
4000066f:	83 ec 08             	sub    $0x8,%esp
40000672:	55                   	push   %ebp
40000673:	6a 58                	push   $0x58
40000675:	ff d6                	call   *%esi
            putch('X', putdat);
40000677:	58                   	pop    %eax
40000678:	5a                   	pop    %edx
40000679:	55                   	push   %ebp
4000067a:	6a 58                	push   $0x58
4000067c:	ff d6                	call   *%esi
            putch('X', putdat);
4000067e:	59                   	pop    %ecx
4000067f:	5b                   	pop    %ebx
40000680:	55                   	push   %ebp
40000681:	6a 58                	push   $0x58
40000683:	ff d6                	call   *%esi
            break;
40000685:	83 c4 10             	add    $0x10,%esp
40000688:	e9 5e fd ff ff       	jmp    400003eb <vprintfmt+0x2b>

4000068d <.L24>:
            if ((p = va_arg(ap, char *)) == NULL)
4000068d:	8b 44 24 5c          	mov    0x5c(%esp),%eax
            if (width > 0 && padc != '-')
40000691:	8b 5c 24 10          	mov    0x10(%esp),%ebx
            if ((p = va_arg(ap, char *)) == NULL)
40000695:	8b 54 24 1c          	mov    0x1c(%esp),%edx
40000699:	8b 74 24 50          	mov    0x50(%esp),%esi
4000069d:	83 c0 04             	add    $0x4,%eax
            if (width > 0 && padc != '-')
400006a0:	80 7c 24 18 2d       	cmpb   $0x2d,0x18(%esp)
            if ((p = va_arg(ap, char *)) == NULL)
400006a5:	89 44 24 1c          	mov    %eax,0x1c(%esp)
400006a9:	8b 44 24 5c          	mov    0x5c(%esp),%eax
400006ad:	8b 08                	mov    (%eax),%ecx
            if (width > 0 && padc != '-')
400006af:	0f 95 c0             	setne  %al
400006b2:	85 db                	test   %ebx,%ebx
400006b4:	0f 9f c3             	setg   %bl
400006b7:	21 d8                	and    %ebx,%eax
            if ((p = va_arg(ap, char *)) == NULL)
400006b9:	85 c9                	test   %ecx,%ecx
400006bb:	0f 84 28 01 00 00    	je     400007e9 <.L31+0x38>
                 (ch = *p++) != '\0' && (precision < 0
400006c1:	8d 59 01             	lea    0x1(%ecx),%ebx
400006c4:	89 5c 24 20          	mov    %ebx,0x20(%esp)
            if (width > 0 && padc != '-')
400006c8:	84 c0                	test   %al,%al
400006ca:	0f 85 48 01 00 00    	jne    40000818 <.L31+0x67>
                 (ch = *p++) != '\0' && (precision < 0
400006d0:	0f be 09             	movsbl (%ecx),%ecx
400006d3:	89 c8                	mov    %ecx,%eax
400006d5:	85 c9                	test   %ecx,%ecx
400006d7:	74 67                	je     40000740 <.L24+0xb3>
400006d9:	89 74 24 50          	mov    %esi,0x50(%esp)
400006dd:	89 d6                	mov    %edx,%esi
400006df:	89 7c 24 58          	mov    %edi,0x58(%esp)
400006e3:	8b 7c 24 10          	mov    0x10(%esp),%edi
400006e7:	eb 2c                	jmp    40000715 <.L24+0x88>
400006e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                if (altflag && (ch < ' ' || ch > '~'))
400006f0:	83 e8 20             	sub    $0x20,%eax
400006f3:	83 f8 5e             	cmp    $0x5e,%eax
400006f6:	76 2e                	jbe    40000726 <.L24+0x99>
                    putch('?', putdat);
400006f8:	83 ec 08             	sub    $0x8,%esp
400006fb:	55                   	push   %ebp
400006fc:	6a 3f                	push   $0x3f
400006fe:	ff 54 24 60          	call   *0x60(%esp)
40000702:	83 c4 10             	add    $0x10,%esp
                 (ch = *p++) != '\0' && (precision < 0
40000705:	0f be 03             	movsbl (%ebx),%eax
40000708:	83 c3 01             	add    $0x1,%ebx
                                         || --precision >= 0); width--)
4000070b:	83 ef 01             	sub    $0x1,%edi
                 (ch = *p++) != '\0' && (precision < 0
4000070e:	0f be c8             	movsbl %al,%ecx
40000711:	85 c9                	test   %ecx,%ecx
40000713:	74 1f                	je     40000734 <.L24+0xa7>
40000715:	85 f6                	test   %esi,%esi
40000717:	78 05                	js     4000071e <.L24+0x91>
                                         || --precision >= 0); width--)
40000719:	83 ee 01             	sub    $0x1,%esi
4000071c:	72 16                	jb     40000734 <.L24+0xa7>
                if (altflag && (ch < ' ' || ch > '~'))
4000071e:	8b 54 24 08          	mov    0x8(%esp),%edx
40000722:	85 d2                	test   %edx,%edx
40000724:	75 ca                	jne    400006f0 <.L24+0x63>
                    putch(ch, putdat);
40000726:	83 ec 08             	sub    $0x8,%esp
40000729:	55                   	push   %ebp
4000072a:	51                   	push   %ecx
4000072b:	ff 54 24 60          	call   *0x60(%esp)
4000072f:	83 c4 10             	add    $0x10,%esp
40000732:	eb d1                	jmp    40000705 <.L24+0x78>
40000734:	89 7c 24 10          	mov    %edi,0x10(%esp)
40000738:	8b 74 24 50          	mov    0x50(%esp),%esi
4000073c:	8b 7c 24 58          	mov    0x58(%esp),%edi
            for (; width > 0; width--)
40000740:	8b 4c 24 10          	mov    0x10(%esp),%ecx
40000744:	8b 5c 24 10          	mov    0x10(%esp),%ebx
40000748:	85 c9                	test   %ecx,%ecx
4000074a:	7e 14                	jle    40000760 <.L24+0xd3>
4000074c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                putch(' ', putdat);
40000750:	83 ec 08             	sub    $0x8,%esp
40000753:	55                   	push   %ebp
40000754:	6a 20                	push   $0x20
40000756:	ff d6                	call   *%esi
            for (; width > 0; width--)
40000758:	83 c4 10             	add    $0x10,%esp
4000075b:	83 eb 01             	sub    $0x1,%ebx
4000075e:	75 f0                	jne    40000750 <.L24+0xc3>
            if ((p = va_arg(ap, char *)) == NULL)
40000760:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000764:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000768:	e9 7e fc ff ff       	jmp    400003eb <vprintfmt+0x2b>
        return va_arg(*ap, unsigned long long);
4000076d:	8b 08                	mov    (%eax),%ecx
4000076f:	8b 58 04             	mov    0x4(%eax),%ebx
40000772:	83 c0 08             	add    $0x8,%eax
40000775:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000779:	e9 d7 fe ff ff       	jmp    40000655 <.L28+0x2f>
4000077e:	8b 08                	mov    (%eax),%ecx
40000780:	8b 58 04             	mov    0x4(%eax),%ebx
40000783:	83 c0 08             	add    $0x8,%eax
40000786:	ba 10 00 00 00       	mov    $0x10,%edx
4000078b:	89 44 24 5c          	mov    %eax,0x5c(%esp)
4000078f:	e9 1c fe ff ff       	jmp    400005b0 <.L23+0x2d>
        return va_arg(*ap, long long);
40000794:	8b 08                	mov    (%eax),%ecx
40000796:	8b 58 04             	mov    0x4(%eax),%ebx
40000799:	83 c0 08             	add    $0x8,%eax
4000079c:	89 44 24 5c          	mov    %eax,0x5c(%esp)
400007a0:	e9 a8 fe ff ff       	jmp    4000064d <.L28+0x27>

400007a5 <.L61>:
            padc = '-';
400007a5:	c6 44 24 18 2d       	movb   $0x2d,0x18(%esp)
        switch (ch = *(unsigned char *) fmt++) {
400007aa:	89 fb                	mov    %edi,%ebx
400007ac:	e9 a1 fc ff ff       	jmp    40000452 <vprintfmt+0x92>

400007b1 <.L31>:
400007b1:	c6 44 24 18 30       	movb   $0x30,0x18(%esp)
400007b6:	89 fb                	mov    %edi,%ebx
400007b8:	e9 95 fc ff ff       	jmp    40000452 <vprintfmt+0x92>
400007bd:	89 4c 24 08          	mov    %ecx,0x8(%esp)
                putch('-', putdat);
400007c1:	83 ec 08             	sub    $0x8,%esp
400007c4:	89 5c 24 14          	mov    %ebx,0x14(%esp)
400007c8:	55                   	push   %ebp
400007c9:	6a 2d                	push   $0x2d
400007cb:	ff d6                	call   *%esi
                num = -(long long) num;
400007cd:	8b 4c 24 18          	mov    0x18(%esp),%ecx
400007d1:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
400007d5:	ba 0a 00 00 00       	mov    $0xa,%edx
400007da:	f7 d9                	neg    %ecx
400007dc:	83 d3 00             	adc    $0x0,%ebx
400007df:	83 c4 10             	add    $0x10,%esp
400007e2:	f7 db                	neg    %ebx
400007e4:	e9 c7 fd ff ff       	jmp    400005b0 <.L23+0x2d>
            if (width > 0 && padc != '-')
400007e9:	84 c0                	test   %al,%al
400007eb:	0f 85 9f 00 00 00    	jne    40000890 <.L31+0xdf>
                 (ch = *p++) != '\0' && (precision < 0
400007f1:	8b 44 24 14          	mov    0x14(%esp),%eax
400007f5:	b9 28 00 00 00       	mov    $0x28,%ecx
400007fa:	8d 98 36 e0 ff ff    	lea    -0x1fca(%eax),%ebx
40000800:	89 74 24 50          	mov    %esi,0x50(%esp)
40000804:	b8 28 00 00 00       	mov    $0x28,%eax
40000809:	89 d6                	mov    %edx,%esi
4000080b:	89 7c 24 58          	mov    %edi,0x58(%esp)
4000080f:	8b 7c 24 10          	mov    0x10(%esp),%edi
40000813:	e9 fd fe ff ff       	jmp    40000715 <.L24+0x88>
                for (width -= strnlen(p, precision); width > 0; width--)
40000818:	83 ec 08             	sub    $0x8,%esp
4000081b:	52                   	push   %edx
4000081c:	89 54 24 38          	mov    %edx,0x38(%esp)
40000820:	51                   	push   %ecx
40000821:	8b 5c 24 24          	mov    0x24(%esp),%ebx
40000825:	89 4c 24 38          	mov    %ecx,0x38(%esp)
40000829:	e8 12 03 00 00       	call   40000b40 <strnlen>
4000082e:	29 44 24 20          	sub    %eax,0x20(%esp)
40000832:	8b 4c 24 20          	mov    0x20(%esp),%ecx
40000836:	83 c4 10             	add    $0x10,%esp
40000839:	8b 54 24 2c          	mov    0x2c(%esp),%edx
4000083d:	85 c9                	test   %ecx,%ecx
4000083f:	8b 4c 24 28          	mov    0x28(%esp),%ecx
40000843:	7e 34                	jle    40000879 <.L31+0xc8>
                    putch(padc, putdat);
40000845:	0f be 5c 24 18       	movsbl 0x18(%esp),%ebx
4000084a:	89 4c 24 28          	mov    %ecx,0x28(%esp)
4000084e:	89 54 24 18          	mov    %edx,0x18(%esp)
40000852:	89 7c 24 58          	mov    %edi,0x58(%esp)
40000856:	8b 7c 24 10          	mov    0x10(%esp),%edi
4000085a:	83 ec 08             	sub    $0x8,%esp
4000085d:	55                   	push   %ebp
4000085e:	53                   	push   %ebx
4000085f:	ff d6                	call   *%esi
                for (width -= strnlen(p, precision); width > 0; width--)
40000861:	83 c4 10             	add    $0x10,%esp
40000864:	83 ef 01             	sub    $0x1,%edi
40000867:	75 f1                	jne    4000085a <.L31+0xa9>
40000869:	8b 54 24 18          	mov    0x18(%esp),%edx
4000086d:	8b 4c 24 28          	mov    0x28(%esp),%ecx
40000871:	89 7c 24 10          	mov    %edi,0x10(%esp)
40000875:	8b 7c 24 58          	mov    0x58(%esp),%edi
                 (ch = *p++) != '\0' && (precision < 0
40000879:	0f be 01             	movsbl (%ecx),%eax
4000087c:	8b 5c 24 20          	mov    0x20(%esp),%ebx
40000880:	0f be c8             	movsbl %al,%ecx
40000883:	85 c9                	test   %ecx,%ecx
40000885:	0f 85 4e fe ff ff    	jne    400006d9 <.L24+0x4c>
4000088b:	e9 d0 fe ff ff       	jmp    40000760 <.L24+0xd3>
                for (width -= strnlen(p, precision); width > 0; width--)
40000890:	83 ec 08             	sub    $0x8,%esp
40000893:	52                   	push   %edx
40000894:	89 54 24 34          	mov    %edx,0x34(%esp)
40000898:	ff 74 24 30          	push   0x30(%esp)
4000089c:	8b 5c 24 24          	mov    0x24(%esp),%ebx
400008a0:	e8 9b 02 00 00       	call   40000b40 <strnlen>
400008a5:	29 44 24 20          	sub    %eax,0x20(%esp)
400008a9:	8b 44 24 20          	mov    0x20(%esp),%eax
400008ad:	83 c4 10             	add    $0x10,%esp
                p = "(null)";
400008b0:	8b 54 24 24          	mov    0x24(%esp),%edx
400008b4:	89 d1                	mov    %edx,%ecx
400008b6:	83 c2 01             	add    $0x1,%edx
                for (width -= strnlen(p, precision); width > 0; width--)
400008b9:	85 c0                	test   %eax,%eax
400008bb:	89 54 24 20          	mov    %edx,0x20(%esp)
400008bf:	8b 54 24 28          	mov    0x28(%esp),%edx
400008c3:	7f 80                	jg     40000845 <.L31+0x94>
                 (ch = *p++) != '\0' && (precision < 0
400008c5:	8b 5c 24 20          	mov    0x20(%esp),%ebx
400008c9:	b9 28 00 00 00       	mov    $0x28,%ecx
400008ce:	e9 2d ff ff ff       	jmp    40000800 <.L31+0x4f>
400008d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400008da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

400008e0 <printfmt>:
{
400008e0:	83 ec 0c             	sub    $0xc,%esp
    vprintfmt(putch, putdat, fmt, ap);
400008e3:	8d 44 24 1c          	lea    0x1c(%esp),%eax
400008e7:	50                   	push   %eax
400008e8:	ff 74 24 1c          	push   0x1c(%esp)
400008ec:	ff 74 24 1c          	push   0x1c(%esp)
400008f0:	ff 74 24 1c          	push   0x1c(%esp)
400008f4:	e8 c7 fa ff ff       	call   400003c0 <vprintfmt>
}
400008f9:	83 c4 1c             	add    $0x1c,%esp
400008fc:	c3                   	ret    
400008fd:	8d 76 00             	lea    0x0(%esi),%esi

40000900 <vsprintf>:

int vsprintf(char *buf, const char *fmt, va_list ap)
{
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
40000900:	e8 4e 01 00 00       	call   40000a53 <__x86.get_pc_thunk.ax>
40000905:	05 fb 36 00 00       	add    $0x36fb,%eax
{
4000090a:	83 ec 1c             	sub    $0x1c,%esp
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
4000090d:	8b 54 24 20          	mov    0x20(%esp),%edx
40000911:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
40000918:	ff 
40000919:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000920:	00 
40000921:	89 54 24 04          	mov    %edx,0x4(%esp)

    // print the string to the buffer
    vprintfmt((void *) sprintputch, &b, fmt, ap);
40000925:	ff 74 24 28          	push   0x28(%esp)
40000929:	ff 74 24 28          	push   0x28(%esp)
4000092d:	8d 80 a0 c3 ff ff    	lea    -0x3c60(%eax),%eax
40000933:	8d 54 24 0c          	lea    0xc(%esp),%edx
40000937:	52                   	push   %edx
40000938:	50                   	push   %eax
40000939:	e8 82 fa ff ff       	call   400003c0 <vprintfmt>

    // null terminate the buffer
    *b.buf = '\0';
4000093e:	8b 44 24 14          	mov    0x14(%esp),%eax
40000942:	c6 00 00             	movb   $0x0,(%eax)

    return b.cnt;
}
40000945:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000949:	83 c4 2c             	add    $0x2c,%esp
4000094c:	c3                   	ret    
4000094d:	8d 76 00             	lea    0x0(%esi),%esi

40000950 <sprintf>:
int sprintf(char *buf, const char *fmt, ...)
{
    va_list ap;
    int rc;

    va_start(ap, fmt);
40000950:	e8 fe 00 00 00       	call   40000a53 <__x86.get_pc_thunk.ax>
40000955:	05 ab 36 00 00       	add    $0x36ab,%eax
{
4000095a:	83 ec 1c             	sub    $0x1c,%esp
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
4000095d:	8b 54 24 20          	mov    0x20(%esp),%edx
40000961:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
40000968:	ff 
40000969:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000970:	00 
40000971:	89 54 24 04          	mov    %edx,0x4(%esp)
    vprintfmt((void *) sprintputch, &b, fmt, ap);
40000975:	8d 54 24 28          	lea    0x28(%esp),%edx
40000979:	52                   	push   %edx
4000097a:	ff 74 24 28          	push   0x28(%esp)
4000097e:	8d 80 a0 c3 ff ff    	lea    -0x3c60(%eax),%eax
40000984:	8d 54 24 0c          	lea    0xc(%esp),%edx
40000988:	52                   	push   %edx
40000989:	50                   	push   %eax
4000098a:	e8 31 fa ff ff       	call   400003c0 <vprintfmt>
    *b.buf = '\0';
4000098f:	8b 44 24 14          	mov    0x14(%esp),%eax
40000993:	c6 00 00             	movb   $0x0,(%eax)
    rc = vsprintf(buf, fmt, ap);
    va_end(ap);

    return rc;
}
40000996:	8b 44 24 1c          	mov    0x1c(%esp),%eax
4000099a:	83 c4 2c             	add    $0x2c,%esp
4000099d:	c3                   	ret    
4000099e:	66 90                	xchg   %ax,%ax

400009a0 <vsnprintf>:

int vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
    struct sprintbuf b = { buf, buf + n - 1, 0 };
400009a0:	e8 b2 00 00 00       	call   40000a57 <__x86.get_pc_thunk.dx>
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

    // print the string to the buffer
    vprintfmt((void *) sprintputch, &b, fmt, ap);
400009ca:	ff 74 24 2c          	push   0x2c(%esp)
400009ce:	ff 74 24 2c          	push   0x2c(%esp)
400009d2:	8d 44 24 0c          	lea    0xc(%esp),%eax
400009d6:	50                   	push   %eax
400009d7:	8d 82 a0 c3 ff ff    	lea    -0x3c60(%edx),%eax
400009dd:	50                   	push   %eax
400009de:	e8 dd f9 ff ff       	call   400003c0 <vprintfmt>

    // null terminate the buffer
    *b.buf = '\0';
400009e3:	8b 44 24 14          	mov    0x14(%esp),%eax
400009e7:	c6 00 00             	movb   $0x0,(%eax)

    return b.cnt;
}
400009ea:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400009ee:	83 c4 2c             	add    $0x2c,%esp
400009f1:	c3                   	ret    
400009f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400009f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000a00 <snprintf>:
int snprintf(char *buf, int n, const char *fmt, ...)
{
    va_list ap;
    int rc;

    va_start(ap, fmt);
40000a00:	e8 52 00 00 00       	call   40000a57 <__x86.get_pc_thunk.dx>
40000a05:	81 c2 fb 35 00 00    	add    $0x35fb,%edx
{
40000a0b:	83 ec 1c             	sub    $0x1c,%esp
40000a0e:	8b 44 24 20          	mov    0x20(%esp),%eax
    struct sprintbuf b = { buf, buf + n - 1, 0 };
40000a12:	8b 4c 24 24          	mov    0x24(%esp),%ecx
40000a16:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000a1d:	00 
40000a1e:	89 44 24 04          	mov    %eax,0x4(%esp)
40000a22:	8d 44 08 ff          	lea    -0x1(%eax,%ecx,1),%eax
40000a26:	89 44 24 08          	mov    %eax,0x8(%esp)
    vprintfmt((void *) sprintputch, &b, fmt, ap);
40000a2a:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000a2e:	50                   	push   %eax
40000a2f:	ff 74 24 2c          	push   0x2c(%esp)
40000a33:	8d 44 24 0c          	lea    0xc(%esp),%eax
40000a37:	50                   	push   %eax
40000a38:	8d 82 a0 c3 ff ff    	lea    -0x3c60(%edx),%eax
40000a3e:	50                   	push   %eax
40000a3f:	e8 7c f9 ff ff       	call   400003c0 <vprintfmt>
    *b.buf = '\0';
40000a44:	8b 44 24 14          	mov    0x14(%esp),%eax
40000a48:	c6 00 00             	movb   $0x0,(%eax)
    rc = vsnprintf(buf, n, fmt, ap);
    va_end(ap);

    return rc;
}
40000a4b:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000a4f:	83 c4 2c             	add    $0x2c,%esp
40000a52:	c3                   	ret    

40000a53 <__x86.get_pc_thunk.ax>:
40000a53:	8b 04 24             	mov    (%esp),%eax
40000a56:	c3                   	ret    

40000a57 <__x86.get_pc_thunk.dx>:
40000a57:	8b 14 24             	mov    (%esp),%edx
40000a5a:	c3                   	ret    

40000a5b <__x86.get_pc_thunk.cx>:
40000a5b:	8b 0c 24             	mov    (%esp),%ecx
40000a5e:	c3                   	ret    
40000a5f:	90                   	nop

40000a60 <spawn>:
#include <proc.h>
#include <syscall.h>
#include <types.h>

pid_t spawn(uintptr_t exec, unsigned int quota)
{
40000a60:	53                   	push   %ebx
static gcc_inline pid_t sys_spawn(unsigned int elf_id, unsigned int quota)
{
    int errno;
    pid_t pid;

    asm volatile ("int %2"
40000a61:	b8 01 00 00 00       	mov    $0x1,%eax
40000a66:	8b 5c 24 08          	mov    0x8(%esp),%ebx
40000a6a:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000a6e:	cd 30                	int    $0x30
                    "a" (SYS_spawn),
                    "b" (elf_id),
                    "c" (quota)
                  : "cc", "memory");

    return errno ? -1 : pid;
40000a70:	85 c0                	test   %eax,%eax
40000a72:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
40000a77:	0f 44 c3             	cmove  %ebx,%eax
    return sys_spawn(exec, quota);
}
40000a7a:	5b                   	pop    %ebx
40000a7b:	c3                   	ret    
40000a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000a80 <yield>:
}

static gcc_inline void sys_yield(void)
{
    asm volatile ("int %0"
40000a80:	b8 02 00 00 00       	mov    $0x2,%eax
40000a85:	cd 30                	int    $0x30

void yield(void)
{
    sys_yield();
}
40000a87:	c3                   	ret    
40000a88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000a8f:	90                   	nop

40000a90 <produce>:
                  : "cc", "memory");
}

static gcc_inline void sys_produce(void)
{
    asm volatile ("int %0"
40000a90:	b8 03 00 00 00       	mov    $0x3,%eax
40000a95:	cd 30                	int    $0x30

void produce(void)
{
    sys_produce();
}
40000a97:	c3                   	ret    
40000a98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000a9f:	90                   	nop

40000aa0 <consume>:
                  : "cc", "memory");
}

static gcc_inline void sys_consume(void)
{
    asm volatile ("int %0"
40000aa0:	b8 04 00 00 00       	mov    $0x4,%eax
40000aa5:	cd 30                	int    $0x30

void consume(void)
{
    sys_consume();
}
40000aa7:	c3                   	ret    
40000aa8:	66 90                	xchg   %ax,%ax
40000aaa:	66 90                	xchg   %ax,%ax
40000aac:	66 90                	xchg   %ax,%ax
40000aae:	66 90                	xchg   %ax,%ax

40000ab0 <spinlock_init>:
    return result;
}

void spinlock_init(spinlock_t *lk)
{
    *lk = 0;
40000ab0:	8b 44 24 04          	mov    0x4(%esp),%eax
40000ab4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
40000aba:	c3                   	ret    
40000abb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000abf:	90                   	nop

40000ac0 <spinlock_acquire>:

void spinlock_acquire(spinlock_t *lk)
{
40000ac0:	8b 54 24 04          	mov    0x4(%esp),%edx
    asm volatile ("lock; xchgl %0, %1"
40000ac4:	b8 01 00 00 00       	mov    $0x1,%eax
40000ac9:	f0 87 02             	lock xchg %eax,(%edx)
    while (xchg(lk, 1) != 0)
40000acc:	85 c0                	test   %eax,%eax
40000ace:	74 13                	je     40000ae3 <spinlock_acquire+0x23>
    asm volatile ("lock; xchgl %0, %1"
40000ad0:	b9 01 00 00 00       	mov    $0x1,%ecx
40000ad5:	8d 76 00             	lea    0x0(%esi),%esi
        asm volatile ("pause");
40000ad8:	f3 90                	pause  
    asm volatile ("lock; xchgl %0, %1"
40000ada:	89 c8                	mov    %ecx,%eax
40000adc:	f0 87 02             	lock xchg %eax,(%edx)
    while (xchg(lk, 1) != 0)
40000adf:	85 c0                	test   %eax,%eax
40000ae1:	75 f5                	jne    40000ad8 <spinlock_acquire+0x18>
}
40000ae3:	c3                   	ret    
40000ae4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000aeb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000aef:	90                   	nop

40000af0 <spinlock_release>:

// Release the lock.
void spinlock_release(spinlock_t *lk)
{
40000af0:	8b 54 24 04          	mov    0x4(%esp),%edx
}

// Check whether this cpu is holding the lock.
bool spinlock_holding(spinlock_t *lk)
{
    return *lk;
40000af4:	8b 02                	mov    (%edx),%eax
    if (spinlock_holding(lk) == FALSE)
40000af6:	84 c0                	test   %al,%al
40000af8:	74 05                	je     40000aff <spinlock_release+0xf>
    asm volatile ("lock; xchgl %0, %1"
40000afa:	31 c0                	xor    %eax,%eax
40000afc:	f0 87 02             	lock xchg %eax,(%edx)
}
40000aff:	c3                   	ret    

40000b00 <spinlock_holding>:
    return *lk;
40000b00:	8b 44 24 04          	mov    0x4(%esp),%eax
40000b04:	8b 00                	mov    (%eax),%eax
}
40000b06:	c3                   	ret    
40000b07:	66 90                	xchg   %ax,%ax
40000b09:	66 90                	xchg   %ax,%ax
40000b0b:	66 90                	xchg   %ax,%ax
40000b0d:	66 90                	xchg   %ax,%ax
40000b0f:	90                   	nop

40000b10 <strlen>:
#include <string.h>
#include <types.h>

int strlen(const char *s)
{
40000b10:	8b 54 24 04          	mov    0x4(%esp),%edx
    int n;

    for (n = 0; *s != '\0'; s++)
40000b14:	31 c0                	xor    %eax,%eax
40000b16:	80 3a 00             	cmpb   $0x0,(%edx)
40000b19:	74 15                	je     40000b30 <strlen+0x20>
40000b1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000b1f:	90                   	nop
        n++;
40000b20:	83 c0 01             	add    $0x1,%eax
    for (n = 0; *s != '\0'; s++)
40000b23:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
40000b27:	75 f7                	jne    40000b20 <strlen+0x10>
40000b29:	c3                   	ret    
40000b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return n;
}
40000b30:	c3                   	ret    
40000b31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b3f:	90                   	nop

40000b40 <strnlen>:

int strnlen(const char *s, size_t size)
{
40000b40:	8b 54 24 08          	mov    0x8(%esp),%edx
40000b44:	8b 4c 24 04          	mov    0x4(%esp),%ecx
    int n;

    for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000b48:	31 c0                	xor    %eax,%eax
40000b4a:	85 d2                	test   %edx,%edx
40000b4c:	75 09                	jne    40000b57 <strnlen+0x17>
40000b4e:	eb 10                	jmp    40000b60 <strnlen+0x20>
        n++;
40000b50:	83 c0 01             	add    $0x1,%eax
    for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000b53:	39 d0                	cmp    %edx,%eax
40000b55:	74 09                	je     40000b60 <strnlen+0x20>
40000b57:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
40000b5b:	75 f3                	jne    40000b50 <strnlen+0x10>
40000b5d:	c3                   	ret    
40000b5e:	66 90                	xchg   %ax,%ax
    return n;
}
40000b60:	c3                   	ret    
40000b61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b6f:	90                   	nop

40000b70 <strcpy>:

char *strcpy(char *dst, const char *src)
{
40000b70:	53                   	push   %ebx
40000b71:	8b 4c 24 08          	mov    0x8(%esp),%ecx
    char *ret;

    ret = dst;
    while ((*dst++ = *src++) != '\0')
40000b75:	31 c0                	xor    %eax,%eax
{
40000b77:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40000b7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000b7f:	90                   	nop
    while ((*dst++ = *src++) != '\0')
40000b80:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
40000b84:	88 14 01             	mov    %dl,(%ecx,%eax,1)
40000b87:	83 c0 01             	add    $0x1,%eax
40000b8a:	84 d2                	test   %dl,%dl
40000b8c:	75 f2                	jne    40000b80 <strcpy+0x10>
        /* do nothing */ ;
    return ret;
}
40000b8e:	89 c8                	mov    %ecx,%eax
40000b90:	5b                   	pop    %ebx
40000b91:	c3                   	ret    
40000b92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000ba0 <strncpy>:

char *strncpy(char *dst, const char *src, size_t size)
{
40000ba0:	56                   	push   %esi
40000ba1:	53                   	push   %ebx
40000ba2:	8b 5c 24 14          	mov    0x14(%esp),%ebx
40000ba6:	8b 74 24 0c          	mov    0xc(%esp),%esi
40000baa:	8b 54 24 10          	mov    0x10(%esp),%edx
    size_t i;
    char *ret;

    ret = dst;
    for (i = 0; i < size; i++) {
40000bae:	85 db                	test   %ebx,%ebx
40000bb0:	74 21                	je     40000bd3 <strncpy+0x33>
40000bb2:	01 f3                	add    %esi,%ebx
40000bb4:	89 f0                	mov    %esi,%eax
40000bb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000bbd:	8d 76 00             	lea    0x0(%esi),%esi
        *dst++ = *src;
40000bc0:	0f b6 0a             	movzbl (%edx),%ecx
40000bc3:	83 c0 01             	add    $0x1,%eax
        // If strlen(src) < size, null-pad 'dst' out to 'size' chars
        if (*src != '\0')
            src++;
40000bc6:	80 f9 01             	cmp    $0x1,%cl
        *dst++ = *src;
40000bc9:	88 48 ff             	mov    %cl,-0x1(%eax)
            src++;
40000bcc:	83 da ff             	sbb    $0xffffffff,%edx
    for (i = 0; i < size; i++) {
40000bcf:	39 d8                	cmp    %ebx,%eax
40000bd1:	75 ed                	jne    40000bc0 <strncpy+0x20>
    }
    return ret;
}
40000bd3:	89 f0                	mov    %esi,%eax
40000bd5:	5b                   	pop    %ebx
40000bd6:	5e                   	pop    %esi
40000bd7:	c3                   	ret    
40000bd8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000bdf:	90                   	nop

40000be0 <strlcpy>:

size_t strlcpy(char *dst, const char *src, size_t size)
{
40000be0:	53                   	push   %ebx
40000be1:	8b 44 24 10          	mov    0x10(%esp),%eax
40000be5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    char *dst_in;

    dst_in = dst;
    if (size > 0) {
40000be9:	85 c0                	test   %eax,%eax
40000beb:	74 30                	je     40000c1d <strlcpy+0x3d>
        while (--size > 0 && *src != '\0')
40000bed:	8b 54 24 08          	mov    0x8(%esp),%edx
40000bf1:	83 e8 01             	sub    $0x1,%eax
40000bf4:	74 24                	je     40000c1a <strlcpy+0x3a>
40000bf6:	01 d0                	add    %edx,%eax
40000bf8:	89 c3                	mov    %eax,%ebx
40000bfa:	eb 11                	jmp    40000c0d <strlcpy+0x2d>
40000bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            *dst++ = *src++;
40000c00:	83 c2 01             	add    $0x1,%edx
40000c03:	83 c1 01             	add    $0x1,%ecx
40000c06:	88 42 ff             	mov    %al,-0x1(%edx)
        while (--size > 0 && *src != '\0')
40000c09:	39 da                	cmp    %ebx,%edx
40000c0b:	74 07                	je     40000c14 <strlcpy+0x34>
40000c0d:	0f b6 01             	movzbl (%ecx),%eax
40000c10:	84 c0                	test   %al,%al
40000c12:	75 ec                	jne    40000c00 <strlcpy+0x20>
        *dst = '\0';
    }
    return dst - dst_in;
40000c14:	89 d0                	mov    %edx,%eax
40000c16:	2b 44 24 08          	sub    0x8(%esp),%eax
        *dst = '\0';
40000c1a:	c6 02 00             	movb   $0x0,(%edx)
}
40000c1d:	5b                   	pop    %ebx
40000c1e:	c3                   	ret    
40000c1f:	90                   	nop

40000c20 <strcmp>:

int strcmp(const char *p, const char *q)
{
40000c20:	53                   	push   %ebx
40000c21:	8b 54 24 08          	mov    0x8(%esp),%edx
40000c25:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    while (*p && *p == *q)
40000c29:	0f b6 02             	movzbl (%edx),%eax
40000c2c:	84 c0                	test   %al,%al
40000c2e:	75 18                	jne    40000c48 <strcmp+0x28>
40000c30:	eb 30                	jmp    40000c62 <strcmp+0x42>
40000c32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000c38:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        p++, q++;
40000c3c:	83 c2 01             	add    $0x1,%edx
40000c3f:	8d 59 01             	lea    0x1(%ecx),%ebx
    while (*p && *p == *q)
40000c42:	84 c0                	test   %al,%al
40000c44:	74 12                	je     40000c58 <strcmp+0x38>
        p++, q++;
40000c46:	89 d9                	mov    %ebx,%ecx
    while (*p && *p == *q)
40000c48:	0f b6 19             	movzbl (%ecx),%ebx
40000c4b:	38 c3                	cmp    %al,%bl
40000c4d:	74 e9                	je     40000c38 <strcmp+0x18>
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000c4f:	29 d8                	sub    %ebx,%eax
}
40000c51:	5b                   	pop    %ebx
40000c52:	c3                   	ret    
40000c53:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000c57:	90                   	nop
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000c58:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
40000c5c:	31 c0                	xor    %eax,%eax
40000c5e:	29 d8                	sub    %ebx,%eax
}
40000c60:	5b                   	pop    %ebx
40000c61:	c3                   	ret    
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000c62:	0f b6 19             	movzbl (%ecx),%ebx
40000c65:	31 c0                	xor    %eax,%eax
40000c67:	eb e6                	jmp    40000c4f <strcmp+0x2f>
40000c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000c70 <strncmp>:

int strncmp(const char *p, const char *q, size_t n)
{
40000c70:	56                   	push   %esi
40000c71:	53                   	push   %ebx
40000c72:	8b 74 24 14          	mov    0x14(%esp),%esi
40000c76:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000c7a:	8b 44 24 10          	mov    0x10(%esp),%eax
    while (n > 0 && *p && *p == *q)
40000c7e:	85 f6                	test   %esi,%esi
40000c80:	74 2e                	je     40000cb0 <strncmp+0x40>
40000c82:	01 c6                	add    %eax,%esi
40000c84:	eb 18                	jmp    40000c9e <strncmp+0x2e>
40000c86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000c8d:	8d 76 00             	lea    0x0(%esi),%esi
40000c90:	38 da                	cmp    %bl,%dl
40000c92:	75 14                	jne    40000ca8 <strncmp+0x38>
        n--, p++, q++;
40000c94:	83 c0 01             	add    $0x1,%eax
40000c97:	83 c1 01             	add    $0x1,%ecx
    while (n > 0 && *p && *p == *q)
40000c9a:	39 f0                	cmp    %esi,%eax
40000c9c:	74 12                	je     40000cb0 <strncmp+0x40>
40000c9e:	0f b6 11             	movzbl (%ecx),%edx
40000ca1:	0f b6 18             	movzbl (%eax),%ebx
40000ca4:	84 d2                	test   %dl,%dl
40000ca6:	75 e8                	jne    40000c90 <strncmp+0x20>
    if (n == 0)
        return 0;
    else
        return (int) ((unsigned char) *p - (unsigned char) *q);
40000ca8:	0f b6 c2             	movzbl %dl,%eax
40000cab:	29 d8                	sub    %ebx,%eax
}
40000cad:	5b                   	pop    %ebx
40000cae:	5e                   	pop    %esi
40000caf:	c3                   	ret    
        return 0;
40000cb0:	31 c0                	xor    %eax,%eax
}
40000cb2:	5b                   	pop    %ebx
40000cb3:	5e                   	pop    %esi
40000cb4:	c3                   	ret    
40000cb5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000cc0 <strchr>:

char *strchr(const char *s, char c)
{
40000cc0:	8b 44 24 04          	mov    0x4(%esp),%eax
40000cc4:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
    for (; *s; s++)
40000cc9:	0f b6 10             	movzbl (%eax),%edx
40000ccc:	84 d2                	test   %dl,%dl
40000cce:	75 13                	jne    40000ce3 <strchr+0x23>
40000cd0:	eb 1e                	jmp    40000cf0 <strchr+0x30>
40000cd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000cd8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
40000cdc:	83 c0 01             	add    $0x1,%eax
40000cdf:	84 d2                	test   %dl,%dl
40000ce1:	74 0d                	je     40000cf0 <strchr+0x30>
        if (*s == c)
40000ce3:	38 d1                	cmp    %dl,%cl
40000ce5:	75 f1                	jne    40000cd8 <strchr+0x18>
            return (char *) s;
    return 0;
}
40000ce7:	c3                   	ret    
40000ce8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000cef:	90                   	nop
    return 0;
40000cf0:	31 c0                	xor    %eax,%eax
}
40000cf2:	c3                   	ret    
40000cf3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000d00 <strfind>:

char *strfind(const char *s, char c)
{
40000d00:	53                   	push   %ebx
40000d01:	8b 44 24 08          	mov    0x8(%esp),%eax
40000d05:	8b 54 24 0c          	mov    0xc(%esp),%edx
    for (; *s; s++)
40000d09:	0f b6 18             	movzbl (%eax),%ebx
        if (*s == c)
40000d0c:	38 d3                	cmp    %dl,%bl
40000d0e:	74 1f                	je     40000d2f <strfind+0x2f>
40000d10:	89 d1                	mov    %edx,%ecx
40000d12:	84 db                	test   %bl,%bl
40000d14:	75 0e                	jne    40000d24 <strfind+0x24>
40000d16:	eb 17                	jmp    40000d2f <strfind+0x2f>
40000d18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000d1f:	90                   	nop
40000d20:	84 d2                	test   %dl,%dl
40000d22:	74 0b                	je     40000d2f <strfind+0x2f>
    for (; *s; s++)
40000d24:	0f b6 50 01          	movzbl 0x1(%eax),%edx
40000d28:	83 c0 01             	add    $0x1,%eax
        if (*s == c)
40000d2b:	38 ca                	cmp    %cl,%dl
40000d2d:	75 f1                	jne    40000d20 <strfind+0x20>
            break;
    return (char *) s;
}
40000d2f:	5b                   	pop    %ebx
40000d30:	c3                   	ret    
40000d31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000d38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000d3f:	90                   	nop

40000d40 <strtol>:

long strtol(const char *s, char **endptr, int base)
{
40000d40:	55                   	push   %ebp
40000d41:	57                   	push   %edi
40000d42:	56                   	push   %esi
40000d43:	53                   	push   %ebx
40000d44:	8b 54 24 14          	mov    0x14(%esp),%edx
40000d48:	8b 74 24 18          	mov    0x18(%esp),%esi
40000d4c:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
40000d50:	0f b6 02             	movzbl (%edx),%eax
40000d53:	3c 09                	cmp    $0x9,%al
40000d55:	74 09                	je     40000d60 <strtol+0x20>
40000d57:	3c 20                	cmp    $0x20,%al
40000d59:	75 14                	jne    40000d6f <strtol+0x2f>
40000d5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000d5f:	90                   	nop
40000d60:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        s++;
40000d64:	83 c2 01             	add    $0x1,%edx
    while (*s == ' ' || *s == '\t')
40000d67:	3c 20                	cmp    $0x20,%al
40000d69:	74 f5                	je     40000d60 <strtol+0x20>
40000d6b:	3c 09                	cmp    $0x9,%al
40000d6d:	74 f1                	je     40000d60 <strtol+0x20>

    // plus/minus sign
    if (*s == '+')
40000d6f:	3c 2b                	cmp    $0x2b,%al
40000d71:	0f 84 99 00 00 00    	je     40000e10 <strtol+0xd0>
    int neg = 0;
40000d77:	31 ff                	xor    %edi,%edi
        s++;
    else if (*s == '-')
40000d79:	3c 2d                	cmp    $0x2d,%al
40000d7b:	0f 84 7f 00 00 00    	je     40000e00 <strtol+0xc0>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000d81:	0f b6 2a             	movzbl (%edx),%ebp
40000d84:	f7 c3 ef ff ff ff    	test   $0xffffffef,%ebx
40000d8a:	75 13                	jne    40000d9f <strtol+0x5f>
40000d8c:	89 e8                	mov    %ebp,%eax
40000d8e:	3c 30                	cmp    $0x30,%al
40000d90:	0f 84 8a 00 00 00    	je     40000e20 <strtol+0xe0>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
40000d96:	85 db                	test   %ebx,%ebx
40000d98:	75 05                	jne    40000d9f <strtol+0x5f>
        s++, base = 8;
    else if (base == 0)
        base = 10;
40000d9a:	bb 0a 00 00 00       	mov    $0xa,%ebx
40000d9f:	31 c9                	xor    %ecx,%ecx
40000da1:	eb 22                	jmp    40000dc5 <strtol+0x85>
40000da3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000da7:	90                   	nop
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
40000da8:	8d 45 9f             	lea    -0x61(%ebp),%eax
40000dab:	3c 19                	cmp    $0x19,%al
40000dad:	77 41                	ja     40000df0 <strtol+0xb0>
            dig = *s - 'a' + 10;
40000daf:	8d 45 a9             	lea    -0x57(%ebp),%eax
40000db2:	0f be c0             	movsbl %al,%eax
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
40000db5:	39 d8                	cmp    %ebx,%eax
40000db7:	7d 1a                	jge    40000dd3 <strtol+0x93>
            break;
        s++, val = (val * base) + dig;
40000db9:	0f af cb             	imul   %ebx,%ecx
        if (*s >= '0' && *s <= '9')
40000dbc:	0f b6 6a 01          	movzbl 0x1(%edx),%ebp
        s++, val = (val * base) + dig;
40000dc0:	83 c2 01             	add    $0x1,%edx
40000dc3:	01 c1                	add    %eax,%ecx
        if (*s >= '0' && *s <= '9')
40000dc5:	8d 45 d0             	lea    -0x30(%ebp),%eax
40000dc8:	3c 09                	cmp    $0x9,%al
40000dca:	77 dc                	ja     40000da8 <strtol+0x68>
            dig = *s - 'A' + 10;
40000dcc:	0f be c0             	movsbl %al,%eax
        if (dig >= base)
40000dcf:	39 d8                	cmp    %ebx,%eax
40000dd1:	7c e6                	jl     40000db9 <strtol+0x79>
        // we don't properly detect overflow!
    }

    if (endptr)
40000dd3:	85 f6                	test   %esi,%esi
40000dd5:	74 02                	je     40000dd9 <strtol+0x99>
        *endptr = (char *) s;
40000dd7:	89 16                	mov    %edx,(%esi)
    return (neg ? -val : val);
40000dd9:	89 c8                	mov    %ecx,%eax
}
40000ddb:	5b                   	pop    %ebx
40000ddc:	5e                   	pop    %esi
    return (neg ? -val : val);
40000ddd:	f7 d8                	neg    %eax
40000ddf:	85 ff                	test   %edi,%edi
}
40000de1:	5f                   	pop    %edi
40000de2:	5d                   	pop    %ebp
    return (neg ? -val : val);
40000de3:	0f 45 c8             	cmovne %eax,%ecx
}
40000de6:	89 c8                	mov    %ecx,%eax
40000de8:	c3                   	ret    
40000de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        else if (*s >= 'A' && *s <= 'Z')
40000df0:	8d 45 bf             	lea    -0x41(%ebp),%eax
40000df3:	3c 19                	cmp    $0x19,%al
40000df5:	77 dc                	ja     40000dd3 <strtol+0x93>
            dig = *s - 'A' + 10;
40000df7:	8d 45 c9             	lea    -0x37(%ebp),%eax
40000dfa:	0f be c0             	movsbl %al,%eax
40000dfd:	eb d0                	jmp    40000dcf <strtol+0x8f>
40000dff:	90                   	nop
        s++, neg = 1;
40000e00:	83 c2 01             	add    $0x1,%edx
40000e03:	bf 01 00 00 00       	mov    $0x1,%edi
40000e08:	e9 74 ff ff ff       	jmp    40000d81 <strtol+0x41>
40000e0d:	8d 76 00             	lea    0x0(%esi),%esi
        s++;
40000e10:	83 c2 01             	add    $0x1,%edx
    int neg = 0;
40000e13:	31 ff                	xor    %edi,%edi
40000e15:	e9 67 ff ff ff       	jmp    40000d81 <strtol+0x41>
40000e1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000e20:	0f b6 42 01          	movzbl 0x1(%edx),%eax
40000e24:	3c 78                	cmp    $0x78,%al
40000e26:	74 17                	je     40000e3f <strtol+0xff>
    else if (base == 0 && s[0] == '0')
40000e28:	85 db                	test   %ebx,%ebx
40000e2a:	0f 85 6f ff ff ff    	jne    40000d9f <strtol+0x5f>
        s++, base = 8;
40000e30:	83 c2 01             	add    $0x1,%edx
40000e33:	89 c5                	mov    %eax,%ebp
40000e35:	bb 08 00 00 00       	mov    $0x8,%ebx
40000e3a:	e9 60 ff ff ff       	jmp    40000d9f <strtol+0x5f>
        if (*s >= '0' && *s <= '9')
40000e3f:	0f b6 6a 02          	movzbl 0x2(%edx),%ebp
        s += 2, base = 16;
40000e43:	bb 10 00 00 00       	mov    $0x10,%ebx
40000e48:	83 c2 02             	add    $0x2,%edx
40000e4b:	e9 4f ff ff ff       	jmp    40000d9f <strtol+0x5f>

40000e50 <memset>:

void *memset(void *v, int c, size_t n)
{
40000e50:	57                   	push   %edi
40000e51:	56                   	push   %esi
40000e52:	53                   	push   %ebx
40000e53:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000e57:	8b 7c 24 10          	mov    0x10(%esp),%edi
    if (n == 0)
40000e5b:	85 c9                	test   %ecx,%ecx
40000e5d:	74 28                	je     40000e87 <memset+0x37>
        return v;
    if ((int) v % 4 == 0 && n % 4 == 0) {
40000e5f:	89 f8                	mov    %edi,%eax
40000e61:	09 c8                	or     %ecx,%eax
40000e63:	a8 03                	test   $0x3,%al
40000e65:	75 29                	jne    40000e90 <memset+0x40>
        c &= 0xFF;
40000e67:	0f b6 5c 24 14       	movzbl 0x14(%esp),%ebx
        c = (c << 24) | (c << 16) | (c << 8) | c;
        asm volatile ("cld; rep stosl\n"
                      :: "D" (v), "a" (c), "c" (n / 4)
40000e6c:	c1 e9 02             	shr    $0x2,%ecx
        c = (c << 24) | (c << 16) | (c << 8) | c;
40000e6f:	89 da                	mov    %ebx,%edx
40000e71:	89 de                	mov    %ebx,%esi
40000e73:	89 d8                	mov    %ebx,%eax
40000e75:	c1 e2 18             	shl    $0x18,%edx
40000e78:	c1 e6 10             	shl    $0x10,%esi
40000e7b:	09 f2                	or     %esi,%edx
40000e7d:	c1 e0 08             	shl    $0x8,%eax
40000e80:	09 da                	or     %ebx,%edx
40000e82:	09 d0                	or     %edx,%eax
        asm volatile ("cld; rep stosl\n"
40000e84:	fc                   	cld    
40000e85:	f3 ab                	rep stos %eax,%es:(%edi)
    } else
        asm volatile ("cld; rep stosb\n"
                      :: "D" (v), "a" (c), "c" (n)
                      : "cc", "memory");
    return v;
}
40000e87:	89 f8                	mov    %edi,%eax
40000e89:	5b                   	pop    %ebx
40000e8a:	5e                   	pop    %esi
40000e8b:	5f                   	pop    %edi
40000e8c:	c3                   	ret    
40000e8d:	8d 76 00             	lea    0x0(%esi),%esi
        asm volatile ("cld; rep stosb\n"
40000e90:	8b 44 24 14          	mov    0x14(%esp),%eax
40000e94:	fc                   	cld    
40000e95:	f3 aa                	rep stos %al,%es:(%edi)
}
40000e97:	89 f8                	mov    %edi,%eax
40000e99:	5b                   	pop    %ebx
40000e9a:	5e                   	pop    %esi
40000e9b:	5f                   	pop    %edi
40000e9c:	c3                   	ret    
40000e9d:	8d 76 00             	lea    0x0(%esi),%esi

40000ea0 <memmove>:

void *memmove(void *dst, const void *src, size_t n)
{
40000ea0:	57                   	push   %edi
40000ea1:	56                   	push   %esi
40000ea2:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000ea6:	8b 74 24 10          	mov    0x10(%esp),%esi
40000eaa:	8b 4c 24 14          	mov    0x14(%esp),%ecx
    const char *s;
    char *d;

    s = src;
    d = dst;
    if (s < d && s + n > d) {
40000eae:	39 c6                	cmp    %eax,%esi
40000eb0:	73 26                	jae    40000ed8 <memmove+0x38>
40000eb2:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
40000eb5:	39 c2                	cmp    %eax,%edx
40000eb7:	76 1f                	jbe    40000ed8 <memmove+0x38>
        s += n;
        d += n;
40000eb9:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
40000ebc:	89 d6                	mov    %edx,%esi
40000ebe:	09 fe                	or     %edi,%esi
40000ec0:	09 ce                	or     %ecx,%esi
40000ec2:	83 e6 03             	and    $0x3,%esi
40000ec5:	74 39                	je     40000f00 <memmove+0x60>
            asm volatile ("std; rep movsl\n"
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
                          : "cc", "memory");
        else
            asm volatile ("std; rep movsb\n"
                          :: "D" (d - 1), "S" (s - 1), "c" (n)
40000ec7:	83 ef 01             	sub    $0x1,%edi
40000eca:	8d 72 ff             	lea    -0x1(%edx),%esi
            asm volatile ("std; rep movsb\n"
40000ecd:	fd                   	std    
40000ece:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
                          : "cc", "memory");
        // Some versions of GCC rely on DF being clear
        asm volatile ("cld" ::: "cc");
40000ed0:	fc                   	cld    
            asm volatile ("cld; rep movsb\n"
                          :: "D" (d), "S" (s), "c" (n)
                          : "cc", "memory");
    }
    return dst;
}
40000ed1:	5e                   	pop    %esi
40000ed2:	5f                   	pop    %edi
40000ed3:	c3                   	ret    
40000ed4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
40000ed8:	89 f2                	mov    %esi,%edx
40000eda:	09 c2                	or     %eax,%edx
40000edc:	09 ca                	or     %ecx,%edx
40000ede:	83 e2 03             	and    $0x3,%edx
40000ee1:	74 0d                	je     40000ef0 <memmove+0x50>
            asm volatile ("cld; rep movsb\n"
40000ee3:	89 c7                	mov    %eax,%edi
40000ee5:	fc                   	cld    
40000ee6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
}
40000ee8:	5e                   	pop    %esi
40000ee9:	5f                   	pop    %edi
40000eea:	c3                   	ret    
40000eeb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000eef:	90                   	nop
                          :: "D" (d), "S" (s), "c" (n / 4)
40000ef0:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("cld; rep movsl\n"
40000ef3:	89 c7                	mov    %eax,%edi
40000ef5:	fc                   	cld    
40000ef6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000ef8:	eb ee                	jmp    40000ee8 <memmove+0x48>
40000efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
40000f00:	83 ef 04             	sub    $0x4,%edi
40000f03:	8d 72 fc             	lea    -0x4(%edx),%esi
40000f06:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("std; rep movsl\n"
40000f09:	fd                   	std    
40000f0a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000f0c:	eb c2                	jmp    40000ed0 <memmove+0x30>
40000f0e:	66 90                	xchg   %ax,%ax

40000f10 <memcpy>:

void *memcpy(void *dst, const void *src, size_t n)
{
    return memmove(dst, src, n);
40000f10:	eb 8e                	jmp    40000ea0 <memmove>
40000f12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000f20 <memcmp>:
}

int memcmp(const void *v1, const void *v2, size_t n)
{
40000f20:	56                   	push   %esi
40000f21:	53                   	push   %ebx
40000f22:	8b 74 24 14          	mov    0x14(%esp),%esi
40000f26:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000f2a:	8b 44 24 10          	mov    0x10(%esp),%eax
    const uint8_t *s1 = (const uint8_t *) v1;
    const uint8_t *s2 = (const uint8_t *) v2;

    while (n-- > 0) {
40000f2e:	85 f6                	test   %esi,%esi
40000f30:	74 2e                	je     40000f60 <memcmp+0x40>
40000f32:	01 c6                	add    %eax,%esi
40000f34:	eb 14                	jmp    40000f4a <memcmp+0x2a>
40000f36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000f3d:	8d 76 00             	lea    0x0(%esi),%esi
        if (*s1 != *s2)
            return (int) *s1 - (int) *s2;
        s1++, s2++;
40000f40:	83 c0 01             	add    $0x1,%eax
40000f43:	83 c2 01             	add    $0x1,%edx
    while (n-- > 0) {
40000f46:	39 f0                	cmp    %esi,%eax
40000f48:	74 16                	je     40000f60 <memcmp+0x40>
        if (*s1 != *s2)
40000f4a:	0f b6 0a             	movzbl (%edx),%ecx
40000f4d:	0f b6 18             	movzbl (%eax),%ebx
40000f50:	38 d9                	cmp    %bl,%cl
40000f52:	74 ec                	je     40000f40 <memcmp+0x20>
            return (int) *s1 - (int) *s2;
40000f54:	0f b6 c1             	movzbl %cl,%eax
40000f57:	29 d8                	sub    %ebx,%eax
    }

    return 0;
}
40000f59:	5b                   	pop    %ebx
40000f5a:	5e                   	pop    %esi
40000f5b:	c3                   	ret    
40000f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
40000f60:	31 c0                	xor    %eax,%eax
}
40000f62:	5b                   	pop    %ebx
40000f63:	5e                   	pop    %esi
40000f64:	c3                   	ret    
40000f65:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000f70 <memchr>:

void *memchr(const void *s, int c, size_t n)
{
40000f70:	8b 44 24 04          	mov    0x4(%esp),%eax
    const void *ends = (const char *) s + n;
40000f74:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000f78:	01 c2                	add    %eax,%edx
    for (; s < ends; s++)
40000f7a:	39 d0                	cmp    %edx,%eax
40000f7c:	73 1a                	jae    40000f98 <memchr+0x28>
        if (*(const unsigned char *) s == (unsigned char) c)
40000f7e:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
40000f83:	eb 0a                	jmp    40000f8f <memchr+0x1f>
40000f85:	8d 76 00             	lea    0x0(%esi),%esi
    for (; s < ends; s++)
40000f88:	83 c0 01             	add    $0x1,%eax
40000f8b:	39 c2                	cmp    %eax,%edx
40000f8d:	74 09                	je     40000f98 <memchr+0x28>
        if (*(const unsigned char *) s == (unsigned char) c)
40000f8f:	38 08                	cmp    %cl,(%eax)
40000f91:	75 f5                	jne    40000f88 <memchr+0x18>
            return (void *) s;
    return NULL;
}
40000f93:	c3                   	ret    
40000f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return NULL;
40000f98:	31 c0                	xor    %eax,%eax
}
40000f9a:	c3                   	ret    
40000f9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000f9f:	90                   	nop

40000fa0 <memzero>:

void *memzero(void *v, size_t n)
{
40000fa0:	57                   	push   %edi
40000fa1:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000fa5:	8b 7c 24 08          	mov    0x8(%esp),%edi
    if (n == 0)
40000fa9:	85 c9                	test   %ecx,%ecx
40000fab:	74 0f                	je     40000fbc <memzero+0x1c>
    if ((int) v % 4 == 0 && n % 4 == 0) {
40000fad:	89 f8                	mov    %edi,%eax
40000faf:	09 c8                	or     %ecx,%eax
40000fb1:	83 e0 03             	and    $0x3,%eax
40000fb4:	75 0a                	jne    40000fc0 <memzero+0x20>
                      :: "D" (v), "a" (c), "c" (n / 4)
40000fb6:	c1 e9 02             	shr    $0x2,%ecx
        asm volatile ("cld; rep stosl\n"
40000fb9:	fc                   	cld    
40000fba:	f3 ab                	rep stos %eax,%es:(%edi)
    return memset(v, 0, n);
}
40000fbc:	89 f8                	mov    %edi,%eax
40000fbe:	5f                   	pop    %edi
40000fbf:	c3                   	ret    
        asm volatile ("cld; rep stosb\n"
40000fc0:	31 c0                	xor    %eax,%eax
40000fc2:	fc                   	cld    
40000fc3:	f3 aa                	rep stos %al,%es:(%edi)
}
40000fc5:	89 f8                	mov    %edi,%eax
40000fc7:	5f                   	pop    %edi
40000fc8:	c3                   	ret    
40000fc9:	66 90                	xchg   %ax,%ax
40000fcb:	66 90                	xchg   %ax,%ax
40000fcd:	66 90                	xchg   %ax,%ax
40000fcf:	90                   	nop

40000fd0 <__udivdi3>:
40000fd0:	f3 0f 1e fb          	endbr32 
40000fd4:	55                   	push   %ebp
40000fd5:	57                   	push   %edi
40000fd6:	56                   	push   %esi
40000fd7:	53                   	push   %ebx
40000fd8:	83 ec 1c             	sub    $0x1c,%esp
40000fdb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
40000fdf:	8b 6c 24 30          	mov    0x30(%esp),%ebp
40000fe3:	8b 74 24 34          	mov    0x34(%esp),%esi
40000fe7:	8b 5c 24 38          	mov    0x38(%esp),%ebx
40000feb:	85 c0                	test   %eax,%eax
40000fed:	75 19                	jne    40001008 <__udivdi3+0x38>
40000fef:	39 f3                	cmp    %esi,%ebx
40000ff1:	76 4d                	jbe    40001040 <__udivdi3+0x70>
40000ff3:	31 ff                	xor    %edi,%edi
40000ff5:	89 e8                	mov    %ebp,%eax
40000ff7:	89 f2                	mov    %esi,%edx
40000ff9:	f7 f3                	div    %ebx
40000ffb:	89 fa                	mov    %edi,%edx
40000ffd:	83 c4 1c             	add    $0x1c,%esp
40001000:	5b                   	pop    %ebx
40001001:	5e                   	pop    %esi
40001002:	5f                   	pop    %edi
40001003:	5d                   	pop    %ebp
40001004:	c3                   	ret    
40001005:	8d 76 00             	lea    0x0(%esi),%esi
40001008:	39 f0                	cmp    %esi,%eax
4000100a:	76 14                	jbe    40001020 <__udivdi3+0x50>
4000100c:	31 ff                	xor    %edi,%edi
4000100e:	31 c0                	xor    %eax,%eax
40001010:	89 fa                	mov    %edi,%edx
40001012:	83 c4 1c             	add    $0x1c,%esp
40001015:	5b                   	pop    %ebx
40001016:	5e                   	pop    %esi
40001017:	5f                   	pop    %edi
40001018:	5d                   	pop    %ebp
40001019:	c3                   	ret    
4000101a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40001020:	0f bd f8             	bsr    %eax,%edi
40001023:	83 f7 1f             	xor    $0x1f,%edi
40001026:	75 48                	jne    40001070 <__udivdi3+0xa0>
40001028:	39 f0                	cmp    %esi,%eax
4000102a:	72 06                	jb     40001032 <__udivdi3+0x62>
4000102c:	31 c0                	xor    %eax,%eax
4000102e:	39 eb                	cmp    %ebp,%ebx
40001030:	77 de                	ja     40001010 <__udivdi3+0x40>
40001032:	b8 01 00 00 00       	mov    $0x1,%eax
40001037:	eb d7                	jmp    40001010 <__udivdi3+0x40>
40001039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40001040:	89 d9                	mov    %ebx,%ecx
40001042:	85 db                	test   %ebx,%ebx
40001044:	75 0b                	jne    40001051 <__udivdi3+0x81>
40001046:	b8 01 00 00 00       	mov    $0x1,%eax
4000104b:	31 d2                	xor    %edx,%edx
4000104d:	f7 f3                	div    %ebx
4000104f:	89 c1                	mov    %eax,%ecx
40001051:	31 d2                	xor    %edx,%edx
40001053:	89 f0                	mov    %esi,%eax
40001055:	f7 f1                	div    %ecx
40001057:	89 c6                	mov    %eax,%esi
40001059:	89 e8                	mov    %ebp,%eax
4000105b:	89 f7                	mov    %esi,%edi
4000105d:	f7 f1                	div    %ecx
4000105f:	89 fa                	mov    %edi,%edx
40001061:	83 c4 1c             	add    $0x1c,%esp
40001064:	5b                   	pop    %ebx
40001065:	5e                   	pop    %esi
40001066:	5f                   	pop    %edi
40001067:	5d                   	pop    %ebp
40001068:	c3                   	ret    
40001069:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40001070:	89 f9                	mov    %edi,%ecx
40001072:	ba 20 00 00 00       	mov    $0x20,%edx
40001077:	29 fa                	sub    %edi,%edx
40001079:	d3 e0                	shl    %cl,%eax
4000107b:	89 44 24 08          	mov    %eax,0x8(%esp)
4000107f:	89 d1                	mov    %edx,%ecx
40001081:	89 d8                	mov    %ebx,%eax
40001083:	d3 e8                	shr    %cl,%eax
40001085:	8b 4c 24 08          	mov    0x8(%esp),%ecx
40001089:	09 c1                	or     %eax,%ecx
4000108b:	89 f0                	mov    %esi,%eax
4000108d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
40001091:	89 f9                	mov    %edi,%ecx
40001093:	d3 e3                	shl    %cl,%ebx
40001095:	89 d1                	mov    %edx,%ecx
40001097:	d3 e8                	shr    %cl,%eax
40001099:	89 f9                	mov    %edi,%ecx
4000109b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
4000109f:	89 eb                	mov    %ebp,%ebx
400010a1:	d3 e6                	shl    %cl,%esi
400010a3:	89 d1                	mov    %edx,%ecx
400010a5:	d3 eb                	shr    %cl,%ebx
400010a7:	09 f3                	or     %esi,%ebx
400010a9:	89 c6                	mov    %eax,%esi
400010ab:	89 f2                	mov    %esi,%edx
400010ad:	89 d8                	mov    %ebx,%eax
400010af:	f7 74 24 08          	divl   0x8(%esp)
400010b3:	89 d6                	mov    %edx,%esi
400010b5:	89 c3                	mov    %eax,%ebx
400010b7:	f7 64 24 0c          	mull   0xc(%esp)
400010bb:	39 d6                	cmp    %edx,%esi
400010bd:	72 19                	jb     400010d8 <__udivdi3+0x108>
400010bf:	89 f9                	mov    %edi,%ecx
400010c1:	d3 e5                	shl    %cl,%ebp
400010c3:	39 c5                	cmp    %eax,%ebp
400010c5:	73 04                	jae    400010cb <__udivdi3+0xfb>
400010c7:	39 d6                	cmp    %edx,%esi
400010c9:	74 0d                	je     400010d8 <__udivdi3+0x108>
400010cb:	89 d8                	mov    %ebx,%eax
400010cd:	31 ff                	xor    %edi,%edi
400010cf:	e9 3c ff ff ff       	jmp    40001010 <__udivdi3+0x40>
400010d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400010d8:	8d 43 ff             	lea    -0x1(%ebx),%eax
400010db:	31 ff                	xor    %edi,%edi
400010dd:	e9 2e ff ff ff       	jmp    40001010 <__udivdi3+0x40>
400010e2:	66 90                	xchg   %ax,%ax
400010e4:	66 90                	xchg   %ax,%ax
400010e6:	66 90                	xchg   %ax,%ax
400010e8:	66 90                	xchg   %ax,%ax
400010ea:	66 90                	xchg   %ax,%ax
400010ec:	66 90                	xchg   %ax,%ax
400010ee:	66 90                	xchg   %ax,%ax

400010f0 <__umoddi3>:
400010f0:	f3 0f 1e fb          	endbr32 
400010f4:	55                   	push   %ebp
400010f5:	57                   	push   %edi
400010f6:	56                   	push   %esi
400010f7:	53                   	push   %ebx
400010f8:	83 ec 1c             	sub    $0x1c,%esp
400010fb:	8b 74 24 30          	mov    0x30(%esp),%esi
400010ff:	8b 5c 24 34          	mov    0x34(%esp),%ebx
40001103:	8b 7c 24 3c          	mov    0x3c(%esp),%edi
40001107:	8b 6c 24 38          	mov    0x38(%esp),%ebp
4000110b:	89 f0                	mov    %esi,%eax
4000110d:	89 da                	mov    %ebx,%edx
4000110f:	85 ff                	test   %edi,%edi
40001111:	75 15                	jne    40001128 <__umoddi3+0x38>
40001113:	39 dd                	cmp    %ebx,%ebp
40001115:	76 39                	jbe    40001150 <__umoddi3+0x60>
40001117:	f7 f5                	div    %ebp
40001119:	89 d0                	mov    %edx,%eax
4000111b:	31 d2                	xor    %edx,%edx
4000111d:	83 c4 1c             	add    $0x1c,%esp
40001120:	5b                   	pop    %ebx
40001121:	5e                   	pop    %esi
40001122:	5f                   	pop    %edi
40001123:	5d                   	pop    %ebp
40001124:	c3                   	ret    
40001125:	8d 76 00             	lea    0x0(%esi),%esi
40001128:	39 df                	cmp    %ebx,%edi
4000112a:	77 f1                	ja     4000111d <__umoddi3+0x2d>
4000112c:	0f bd cf             	bsr    %edi,%ecx
4000112f:	83 f1 1f             	xor    $0x1f,%ecx
40001132:	89 4c 24 04          	mov    %ecx,0x4(%esp)
40001136:	75 40                	jne    40001178 <__umoddi3+0x88>
40001138:	39 df                	cmp    %ebx,%edi
4000113a:	72 04                	jb     40001140 <__umoddi3+0x50>
4000113c:	39 f5                	cmp    %esi,%ebp
4000113e:	77 dd                	ja     4000111d <__umoddi3+0x2d>
40001140:	89 da                	mov    %ebx,%edx
40001142:	89 f0                	mov    %esi,%eax
40001144:	29 e8                	sub    %ebp,%eax
40001146:	19 fa                	sbb    %edi,%edx
40001148:	eb d3                	jmp    4000111d <__umoddi3+0x2d>
4000114a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40001150:	89 e9                	mov    %ebp,%ecx
40001152:	85 ed                	test   %ebp,%ebp
40001154:	75 0b                	jne    40001161 <__umoddi3+0x71>
40001156:	b8 01 00 00 00       	mov    $0x1,%eax
4000115b:	31 d2                	xor    %edx,%edx
4000115d:	f7 f5                	div    %ebp
4000115f:	89 c1                	mov    %eax,%ecx
40001161:	89 d8                	mov    %ebx,%eax
40001163:	31 d2                	xor    %edx,%edx
40001165:	f7 f1                	div    %ecx
40001167:	89 f0                	mov    %esi,%eax
40001169:	f7 f1                	div    %ecx
4000116b:	89 d0                	mov    %edx,%eax
4000116d:	31 d2                	xor    %edx,%edx
4000116f:	eb ac                	jmp    4000111d <__umoddi3+0x2d>
40001171:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40001178:	8b 44 24 04          	mov    0x4(%esp),%eax
4000117c:	ba 20 00 00 00       	mov    $0x20,%edx
40001181:	29 c2                	sub    %eax,%edx
40001183:	89 c1                	mov    %eax,%ecx
40001185:	89 e8                	mov    %ebp,%eax
40001187:	d3 e7                	shl    %cl,%edi
40001189:	89 d1                	mov    %edx,%ecx
4000118b:	89 54 24 0c          	mov    %edx,0xc(%esp)
4000118f:	d3 e8                	shr    %cl,%eax
40001191:	89 c1                	mov    %eax,%ecx
40001193:	8b 44 24 04          	mov    0x4(%esp),%eax
40001197:	09 f9                	or     %edi,%ecx
40001199:	89 df                	mov    %ebx,%edi
4000119b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
4000119f:	89 c1                	mov    %eax,%ecx
400011a1:	d3 e5                	shl    %cl,%ebp
400011a3:	89 d1                	mov    %edx,%ecx
400011a5:	d3 ef                	shr    %cl,%edi
400011a7:	89 c1                	mov    %eax,%ecx
400011a9:	89 f0                	mov    %esi,%eax
400011ab:	d3 e3                	shl    %cl,%ebx
400011ad:	89 d1                	mov    %edx,%ecx
400011af:	89 fa                	mov    %edi,%edx
400011b1:	d3 e8                	shr    %cl,%eax
400011b3:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
400011b8:	09 d8                	or     %ebx,%eax
400011ba:	f7 74 24 08          	divl   0x8(%esp)
400011be:	89 d3                	mov    %edx,%ebx
400011c0:	d3 e6                	shl    %cl,%esi
400011c2:	f7 e5                	mul    %ebp
400011c4:	89 c7                	mov    %eax,%edi
400011c6:	89 d1                	mov    %edx,%ecx
400011c8:	39 d3                	cmp    %edx,%ebx
400011ca:	72 06                	jb     400011d2 <__umoddi3+0xe2>
400011cc:	75 0e                	jne    400011dc <__umoddi3+0xec>
400011ce:	39 c6                	cmp    %eax,%esi
400011d0:	73 0a                	jae    400011dc <__umoddi3+0xec>
400011d2:	29 e8                	sub    %ebp,%eax
400011d4:	1b 54 24 08          	sbb    0x8(%esp),%edx
400011d8:	89 d1                	mov    %edx,%ecx
400011da:	89 c7                	mov    %eax,%edi
400011dc:	89 f5                	mov    %esi,%ebp
400011de:	8b 74 24 04          	mov    0x4(%esp),%esi
400011e2:	29 fd                	sub    %edi,%ebp
400011e4:	19 cb                	sbb    %ecx,%ebx
400011e6:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
400011eb:	89 d8                	mov    %ebx,%eax
400011ed:	d3 e0                	shl    %cl,%eax
400011ef:	89 f1                	mov    %esi,%ecx
400011f1:	d3 ed                	shr    %cl,%ebp
400011f3:	d3 eb                	shr    %cl,%ebx
400011f5:	09 e8                	or     %ebp,%eax
400011f7:	89 da                	mov    %ebx,%edx
400011f9:	83 c4 1c             	add    $0x1c,%esp
400011fc:	5b                   	pop    %ebx
400011fd:	5e                   	pop    %esi
400011fe:	5f                   	pop    %edi
400011ff:	5d                   	pop    %ebp
40001200:	c3                   	ret    
