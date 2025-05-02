
obj/user/fstest/fstest:     file format elf32-i386


Disassembly of section .text:

40000000 <main>:

    printf("=====bigdir ok=====\n\n");
}

int main(int argc, char *argv[])
{
40000000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
40000004:	83 e4 f0             	and    $0xfffffff0,%esp
40000007:	ff 71 fc             	push   -0x4(%ecx)
4000000a:	55                   	push   %ebp
4000000b:	89 e5                	mov    %esp,%ebp
4000000d:	57                   	push   %edi
4000000e:	56                   	push   %esi
4000000f:	e8 47 2b 00 00       	call   40002b5b <__x86.get_pc_thunk.si>
40000014:	81 c6 ec 6f 00 00    	add    $0x6fec,%esi
4000001a:	53                   	push   %ebx
4000001b:	51                   	push   %ecx
4000001c:	83 ec 14             	sub    $0x14,%esp
    printf("*******usertests starting*******\n\n");
4000001f:	8d 86 68 d0 ff ff    	lea    -0x2f98(%esi),%eax
40000025:	89 f3                	mov    %esi,%ebx
static gcc_inline int sys_open(char *path, int omode)
{
    int errno;
    int fd;

    asm volatile ("int %2"
40000027:	8d be b3 cb ff ff    	lea    -0x344d(%esi),%edi
4000002d:	50                   	push   %eax
4000002e:	e8 0d 03 00 00       	call   40000340 <printf>

    printf("=====test file usertests.ran does not exists=====\n");
40000033:	8d 86 8c d0 ff ff    	lea    -0x2f74(%esi),%eax
40000039:	89 04 24             	mov    %eax,(%esp)
4000003c:	e8 ff 02 00 00       	call   40000340 <printf>
40000041:	b8 03 00 00 00       	mov    $0x3,%eax
40000046:	31 c9                	xor    %ecx,%ecx
40000048:	89 fb                	mov    %edi,%ebx
4000004a:	cd 30                	int    $0x30

    if (open("usertests.ran", O_RDONLY) >= 0) {
4000004c:	83 c4 10             	add    $0x10,%esp
4000004f:	85 db                	test   %ebx,%ebx
40000051:	78 08                	js     4000005b <main+0x5b>
40000053:	85 c0                	test   %eax,%eax
40000055:	0f 84 91 00 00 00    	je     400000ec <main+0xec>
        printf("already ran user tests (file usertests.ran exists) "
               "-- recreate certikos_disk.img\n");
        exit(1);
    }
    printf("=====test file usertests.ran does not exists: ok\n\n");
4000005b:	83 ec 0c             	sub    $0xc,%esp
4000005e:	8d 86 14 d1 ff ff    	lea    -0x2eec(%esi),%eax
40000064:	89 f3                	mov    %esi,%ebx
40000066:	50                   	push   %eax
40000067:	e8 d4 02 00 00       	call   40000340 <printf>
4000006c:	b8 03 00 00 00       	mov    $0x3,%eax
40000071:	b9 00 02 00 00       	mov    $0x200,%ecx
40000076:	89 fb                	mov    %edi,%ebx
40000078:	cd 30                	int    $0x30
                    "a" (SYS_open),
                    "b" (path),
                    "c" (omode)
                  : "cc", "memory");

    return errno ? -1 : fd;
4000007a:	83 c4 10             	add    $0x10,%esp
4000007d:	85 c0                	test   %eax,%eax
4000007f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
40000084:	0f 45 d8             	cmovne %eax,%ebx
    asm volatile ("int %2"
40000087:	b8 04 00 00 00       	mov    $0x4,%eax
4000008c:	cd 30                	int    $0x30
    close(open("usertests.ran", O_CREATE));

    smallfile();
4000008e:	e8 bd 0f 00 00       	call   40001050 <smallfile>
    linktest();
    unlinkread();
    dirfile();
    iref();
    bigdir();  // slow
    printf("*******end of tests*******\n");
40000093:	89 f3                	mov    %esi,%ebx
    bigfile1();
40000095:	e8 e6 11 00 00       	call   40001280 <bigfile1>
    createtest();
4000009a:	e8 f1 13 00 00       	call   40001490 <createtest>
    rmdot();
4000009f:	e8 ac 14 00 00       	call   40001550 <rmdot>
    fourteen();
400000a4:	e8 37 16 00 00       	call   400016e0 <fourteen>
    bigfile2();
400000a9:	e8 b2 17 00 00       	call   40001860 <bigfile2>
    subdir();
400000ae:	e8 0d 1a 00 00       	call   40001ac0 <subdir>
    linktest();
400000b3:	e8 58 21 00 00       	call   40002210 <linktest>
    unlinkread();
400000b8:	e8 c3 23 00 00       	call   40002480 <unlinkread>
    dirfile();
400000bd:	e8 be 25 00 00       	call   40002680 <dirfile>
    iref();
400000c2:	e8 e9 27 00 00       	call   400028b0 <iref>
    bigdir();  // slow
400000c7:	e8 24 29 00 00       	call   400029f0 <bigdir>
    printf("*******end of tests*******\n");
400000cc:	83 ec 0c             	sub    $0xc,%esp
400000cf:	8d 86 c1 cb ff ff    	lea    -0x343f(%esi),%eax
400000d5:	50                   	push   %eax
400000d6:	e8 65 02 00 00       	call   40000340 <printf>
    return 0;
400000db:	83 c4 10             	add    $0x10,%esp
400000de:	31 c0                	xor    %eax,%eax
}
400000e0:	8d 65 f0             	lea    -0x10(%ebp),%esp
400000e3:	59                   	pop    %ecx
400000e4:	5b                   	pop    %ebx
400000e5:	5e                   	pop    %esi
400000e6:	5f                   	pop    %edi
400000e7:	5d                   	pop    %ebp
400000e8:	8d 61 fc             	lea    -0x4(%ecx),%esp
400000eb:	c3                   	ret    
        printf("already ran user tests (file usertests.ran exists) "
400000ec:	83 ec 0c             	sub    $0xc,%esp
400000ef:	8d 86 c0 d0 ff ff    	lea    -0x2f40(%esi),%eax
400000f5:	89 f3                	mov    %esi,%ebx
400000f7:	50                   	push   %eax
400000f8:	e8 43 02 00 00       	call   40000340 <printf>
        exit(1);
400000fd:	83 c4 10             	add    $0x10,%esp
40000100:	b8 01 00 00 00       	mov    $0x1,%eax
40000105:	eb d9                	jmp    400000e0 <main+0xe0>

40000107 <_start>:
_start:
	/*
	 * If there are arguments on the stack, then the current stack will not
	 * be aligned to a nice big power-of-two boundary.
	 */
	testl	$0x0fffffff, %esp
40000107:	f7 c4 ff ff ff 0f    	test   $0xfffffff,%esp
	jnz	args_exist
4000010d:	75 04                	jne    40000113 <args_exist>

4000010f <noargs>:

noargs:
	/* If no arguments are on the stack, push two dummy zero. */
	pushl	$0
4000010f:	6a 00                	push   $0x0
	pushl	$0
40000111:	6a 00                	push   $0x0

40000113 <args_exist>:

args_exist:
	/* Jump to the C part. */
	call	main
40000113:	e8 e8 fe ff ff       	call   40000000 <main>

	/* When returning, push the return value on the stack. */
	pushl	%eax
40000118:	50                   	push   %eax

40000119 <spin>:
spin:
	jmp	spin
40000119:	eb fe                	jmp    40000119 <spin>
4000011b:	66 90                	xchg   %ax,%ax
4000011d:	66 90                	xchg   %ax,%ax
4000011f:	90                   	nop

40000120 <debug>:
#include <proc.h>
#include <stdarg.h>
#include <stdio.h>

void debug(const char *file, int line, const char *fmt, ...)
{
40000120:	53                   	push   %ebx
40000121:	e8 c1 00 00 00       	call   400001e7 <__x86.get_pc_thunk.bx>
40000126:	81 c3 da 6e 00 00    	add    $0x6eda,%ebx
4000012c:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[D] %s:%d: ", file, line);
4000012f:	ff 74 24 18          	push   0x18(%esp)
40000133:	ff 74 24 18          	push   0x18(%esp)
40000137:	8d 83 00 c0 ff ff    	lea    -0x4000(%ebx),%eax
4000013d:	50                   	push   %eax
4000013e:	e8 fd 01 00 00       	call   40000340 <printf>
    vcprintf(fmt, ap);
40000143:	58                   	pop    %eax
40000144:	5a                   	pop    %edx
40000145:	8d 44 24 24          	lea    0x24(%esp),%eax
40000149:	50                   	push   %eax
4000014a:	ff 74 24 24          	push   0x24(%esp)
4000014e:	e8 8d 01 00 00       	call   400002e0 <vcprintf>
    va_end(ap);
}
40000153:	83 c4 18             	add    $0x18,%esp
40000156:	5b                   	pop    %ebx
40000157:	c3                   	ret    
40000158:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000015f:	90                   	nop

40000160 <warn>:

void warn(const char *file, int line, const char *fmt, ...)
{
40000160:	53                   	push   %ebx
40000161:	e8 81 00 00 00       	call   400001e7 <__x86.get_pc_thunk.bx>
40000166:	81 c3 9a 6e 00 00    	add    $0x6e9a,%ebx
4000016c:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[W] %s:%d: ", file, line);
4000016f:	ff 74 24 18          	push   0x18(%esp)
40000173:	ff 74 24 18          	push   0x18(%esp)
40000177:	8d 83 0c c0 ff ff    	lea    -0x3ff4(%ebx),%eax
4000017d:	50                   	push   %eax
4000017e:	e8 bd 01 00 00       	call   40000340 <printf>
    vcprintf(fmt, ap);
40000183:	58                   	pop    %eax
40000184:	5a                   	pop    %edx
40000185:	8d 44 24 24          	lea    0x24(%esp),%eax
40000189:	50                   	push   %eax
4000018a:	ff 74 24 24          	push   0x24(%esp)
4000018e:	e8 4d 01 00 00       	call   400002e0 <vcprintf>
    va_end(ap);
}
40000193:	83 c4 18             	add    $0x18,%esp
40000196:	5b                   	pop    %ebx
40000197:	c3                   	ret    
40000198:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000019f:	90                   	nop

400001a0 <panic>:

void panic(const char *file, int line, const char *fmt, ...)
{
400001a0:	53                   	push   %ebx
400001a1:	e8 41 00 00 00       	call   400001e7 <__x86.get_pc_thunk.bx>
400001a6:	81 c3 5a 6e 00 00    	add    $0x6e5a,%ebx
400001ac:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[P] %s:%d: ", file, line);
400001af:	ff 74 24 18          	push   0x18(%esp)
400001b3:	ff 74 24 18          	push   0x18(%esp)
400001b7:	8d 83 18 c0 ff ff    	lea    -0x3fe8(%ebx),%eax
400001bd:	50                   	push   %eax
400001be:	e8 7d 01 00 00       	call   40000340 <printf>
    vcprintf(fmt, ap);
400001c3:	58                   	pop    %eax
400001c4:	5a                   	pop    %edx
400001c5:	8d 44 24 24          	lea    0x24(%esp),%eax
400001c9:	50                   	push   %eax
400001ca:	ff 74 24 24          	push   0x24(%esp)
400001ce:	e8 0d 01 00 00       	call   400002e0 <vcprintf>
400001d3:	83 c4 10             	add    $0x10,%esp
400001d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400001dd:	8d 76 00             	lea    0x0(%esi),%esi
    va_end(ap);

    while (1)
        yield();
400001e0:	e8 3b 09 00 00       	call   40000b20 <yield>
    while (1)
400001e5:	eb f9                	jmp    400001e0 <panic+0x40>

400001e7 <__x86.get_pc_thunk.bx>:
400001e7:	8b 1c 24             	mov    (%esp),%ebx
400001ea:	c3                   	ret    
400001eb:	66 90                	xchg   %ax,%ax
400001ed:	66 90                	xchg   %ax,%ax
400001ef:	90                   	nop

400001f0 <atoi>:
#include <stdlib.h>

int atoi(const char *buf, int *i)
{
400001f0:	55                   	push   %ebp
400001f1:	57                   	push   %edi
400001f2:	56                   	push   %esi
400001f3:	53                   	push   %ebx
    int loc = 0;
    int numstart = 0;
    int acc = 0;
    int negative = 0;
    if (buf[loc] == '+')
400001f4:	8b 44 24 14          	mov    0x14(%esp),%eax
400001f8:	0f b6 00             	movzbl (%eax),%eax
400001fb:	3c 2b                	cmp    $0x2b,%al
400001fd:	0f 84 85 00 00 00    	je     40000288 <atoi+0x98>
    int negative = 0;
40000203:	31 ff                	xor    %edi,%edi
    int loc = 0;
40000205:	31 f6                	xor    %esi,%esi
        loc++;
    else if (buf[loc] == '-') {
40000207:	3c 2d                	cmp    $0x2d,%al
40000209:	74 55                	je     40000260 <atoi+0x70>
        negative = 1;
        loc++;
    }
    numstart = loc;
    // no grab the numbers
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000020b:	8d 50 d0             	lea    -0x30(%eax),%edx
4000020e:	80 fa 09             	cmp    $0x9,%dl
40000211:	77 67                	ja     4000027a <atoi+0x8a>
40000213:	89 f2                	mov    %esi,%edx
    int acc = 0;
40000215:	31 c9                	xor    %ecx,%ecx
40000217:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000021e:	66 90                	xchg   %ax,%ax
        acc = acc * 10 + (buf[loc] - '0');
40000220:	83 e8 30             	sub    $0x30,%eax
40000223:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
        loc++;
40000226:	83 c2 01             	add    $0x1,%edx
        acc = acc * 10 + (buf[loc] - '0');
40000229:	0f be c0             	movsbl %al,%eax
4000022c:	8d 0c 48             	lea    (%eax,%ecx,2),%ecx
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000022f:	8b 44 24 14          	mov    0x14(%esp),%eax
40000233:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
40000237:	8d 68 d0             	lea    -0x30(%eax),%ebp
4000023a:	89 eb                	mov    %ebp,%ebx
4000023c:	80 fb 09             	cmp    $0x9,%bl
4000023f:	76 df                	jbe    40000220 <atoi+0x30>
    }
    if (numstart == loc) {
40000241:	39 d6                	cmp    %edx,%esi
40000243:	74 35                	je     4000027a <atoi+0x8a>
        // no numbers have actually been scanned
        return 0;
    }
    if (negative)
        acc = -acc;
40000245:	89 c8                	mov    %ecx,%eax
40000247:	f7 d8                	neg    %eax
40000249:	85 ff                	test   %edi,%edi
4000024b:	0f 45 c8             	cmovne %eax,%ecx
    *i = acc;
4000024e:	8b 44 24 18          	mov    0x18(%esp),%eax
40000252:	89 08                	mov    %ecx,(%eax)
    return loc;
}
40000254:	89 d0                	mov    %edx,%eax
40000256:	5b                   	pop    %ebx
40000257:	5e                   	pop    %esi
40000258:	5f                   	pop    %edi
40000259:	5d                   	pop    %ebp
4000025a:	c3                   	ret    
4000025b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
4000025f:	90                   	nop
    while ('0' <= buf[loc] && buf[loc] <= '9') {
40000260:	8b 44 24 14          	mov    0x14(%esp),%eax
        negative = 1;
40000264:	bf 01 00 00 00       	mov    $0x1,%edi
        loc++;
40000269:	be 01 00 00 00       	mov    $0x1,%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000026e:	0f b6 40 01          	movzbl 0x1(%eax),%eax
40000272:	8d 50 d0             	lea    -0x30(%eax),%edx
40000275:	80 fa 09             	cmp    $0x9,%dl
40000278:	76 99                	jbe    40000213 <atoi+0x23>
        return 0;
4000027a:	31 d2                	xor    %edx,%edx
}
4000027c:	5b                   	pop    %ebx
4000027d:	5e                   	pop    %esi
4000027e:	89 d0                	mov    %edx,%eax
40000280:	5f                   	pop    %edi
40000281:	5d                   	pop    %ebp
40000282:	c3                   	ret    
40000283:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000287:	90                   	nop
    while ('0' <= buf[loc] && buf[loc] <= '9') {
40000288:	8b 44 24 14          	mov    0x14(%esp),%eax
    int negative = 0;
4000028c:	31 ff                	xor    %edi,%edi
        loc++;
4000028e:	be 01 00 00 00       	mov    $0x1,%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
40000293:	0f b6 40 01          	movzbl 0x1(%eax),%eax
40000297:	e9 6f ff ff ff       	jmp    4000020b <atoi+0x1b>
4000029c:	66 90                	xchg   %ax,%ax
4000029e:	66 90                	xchg   %ax,%ax

400002a0 <putch>:
    int cnt;            // total bytes printed so far
    char buf[MAX_BUF];
};

static void putch(int ch, struct printbuf *b)
{
400002a0:	53                   	push   %ebx
400002a1:	8b 54 24 0c          	mov    0xc(%esp),%edx
    b->buf[b->idx++] = ch;
400002a5:	0f b6 5c 24 08       	movzbl 0x8(%esp),%ebx
400002aa:	8b 02                	mov    (%edx),%eax
400002ac:	8d 48 01             	lea    0x1(%eax),%ecx
400002af:	89 0a                	mov    %ecx,(%edx)
400002b1:	88 5c 02 08          	mov    %bl,0x8(%edx,%eax,1)
    if (b->idx == MAX_BUF - 1) {
400002b5:	81 f9 ff 01 00 00    	cmp    $0x1ff,%ecx
400002bb:	75 14                	jne    400002d1 <putch+0x31>
        b->buf[b->idx] = 0;
400002bd:	c6 82 07 02 00 00 00 	movb   $0x0,0x207(%edx)
        puts(b->buf, b->idx);
400002c4:	8d 5a 08             	lea    0x8(%edx),%ebx
    asm volatile ("int %0"
400002c7:	31 c0                	xor    %eax,%eax
400002c9:	cd 30                	int    $0x30
        b->idx = 0;
400002cb:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
    }
    b->cnt++;
400002d1:	83 42 04 01          	addl   $0x1,0x4(%edx)
}
400002d5:	5b                   	pop    %ebx
400002d6:	c3                   	ret    
400002d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400002de:	66 90                	xchg   %ax,%ax

400002e0 <vcprintf>:

int vcprintf(const char *fmt, va_list ap)
{
400002e0:	53                   	push   %ebx
400002e1:	e8 01 ff ff ff       	call   400001e7 <__x86.get_pc_thunk.bx>
400002e6:	81 c3 1a 6d 00 00    	add    $0x6d1a,%ebx
400002ec:	81 ec 18 02 00 00    	sub    $0x218,%esp
    struct printbuf b;

    b.idx = 0;
400002f2:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
400002f9:	00 
    b.cnt = 0;
400002fa:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000301:	00 
    vprintfmt((void *) putch, &b, fmt, ap);
40000302:	ff b4 24 24 02 00 00 	push   0x224(%esp)
40000309:	ff b4 24 24 02 00 00 	push   0x224(%esp)
40000310:	8d 44 24 10          	lea    0x10(%esp),%eax
40000314:	50                   	push   %eax
40000315:	8d 83 a0 92 ff ff    	lea    -0x6d60(%ebx),%eax
4000031b:	50                   	push   %eax
4000031c:	e8 3f 01 00 00       	call   40000460 <vprintfmt>

    b.buf[b.idx] = 0;
40000321:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000325:	8d 5c 24 20          	lea    0x20(%esp),%ebx
40000329:	31 c0                	xor    %eax,%eax
4000032b:	c6 44 0c 20 00       	movb   $0x0,0x20(%esp,%ecx,1)
40000330:	cd 30                	int    $0x30
    puts(b.buf, b.idx);

    return b.cnt;
}
40000332:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000336:	81 c4 28 02 00 00    	add    $0x228,%esp
4000033c:	5b                   	pop    %ebx
4000033d:	c3                   	ret    
4000033e:	66 90                	xchg   %ax,%ax

40000340 <printf>:

int printf(const char *fmt, ...)
{
40000340:	83 ec 14             	sub    $0x14,%esp
    va_list ap;
    int cnt;

    va_start(ap, fmt);
    cnt = vcprintf(fmt, ap);
40000343:	8d 44 24 1c          	lea    0x1c(%esp),%eax
40000347:	50                   	push   %eax
40000348:	ff 74 24 1c          	push   0x1c(%esp)
4000034c:	e8 8f ff ff ff       	call   400002e0 <vcprintf>
    va_end(ap);

    return cnt;
}
40000351:	83 c4 1c             	add    $0x1c,%esp
40000354:	c3                   	ret    
40000355:	66 90                	xchg   %ax,%ax
40000357:	66 90                	xchg   %ax,%ax
40000359:	66 90                	xchg   %ax,%ax
4000035b:	66 90                	xchg   %ax,%ax
4000035d:	66 90                	xchg   %ax,%ax
4000035f:	90                   	nop

40000360 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void *), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
40000360:	e8 96 07 00 00       	call   40000afb <__x86.get_pc_thunk.cx>
40000365:	81 c1 9b 6c 00 00    	add    $0x6c9b,%ecx
4000036b:	55                   	push   %ebp
4000036c:	57                   	push   %edi
4000036d:	89 d7                	mov    %edx,%edi
4000036f:	56                   	push   %esi
40000370:	89 c6                	mov    %eax,%esi
40000372:	53                   	push   %ebx
40000373:	83 ec 2c             	sub    $0x2c,%esp
40000376:	8b 54 24 44          	mov    0x44(%esp),%edx
4000037a:	8b 44 24 40          	mov    0x40(%esp),%eax
4000037e:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, num / base, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (--width > 0)
40000382:	8b 4c 24 4c          	mov    0x4c(%esp),%ecx
{
40000386:	8b 5c 24 50          	mov    0x50(%esp),%ebx
    if (num >= base) {
4000038a:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
40000391:	00 
{
40000392:	89 54 24 0c          	mov    %edx,0xc(%esp)
40000396:	8b 54 24 48          	mov    0x48(%esp),%edx
4000039a:	89 44 24 08          	mov    %eax,0x8(%esp)
    if (num >= base) {
4000039e:	8b 44 24 0c          	mov    0xc(%esp),%eax
        while (--width > 0)
400003a2:	8d 69 ff             	lea    -0x1(%ecx),%ebp
    if (num >= base) {
400003a5:	39 54 24 08          	cmp    %edx,0x8(%esp)
400003a9:	1b 44 24 14          	sbb    0x14(%esp),%eax
400003ad:	89 54 24 10          	mov    %edx,0x10(%esp)
400003b1:	73 55                	jae    40000408 <printnum+0xa8>
        while (--width > 0)
400003b3:	85 ed                	test   %ebp,%ebp
400003b5:	7e 18                	jle    400003cf <printnum+0x6f>
400003b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400003be:	66 90                	xchg   %ax,%ax
            putch(padc, putdat);
400003c0:	83 ec 08             	sub    $0x8,%esp
400003c3:	57                   	push   %edi
400003c4:	53                   	push   %ebx
400003c5:	ff d6                	call   *%esi
        while (--width > 0)
400003c7:	83 c4 10             	add    $0x10,%esp
400003ca:	83 ed 01             	sub    $0x1,%ebp
400003cd:	75 f1                	jne    400003c0 <printnum+0x60>
    }

    // then print this (the least significant) digit
    putch("0123456789abcdef"[num % base], putdat);
400003cf:	89 7c 24 44          	mov    %edi,0x44(%esp)
400003d3:	ff 74 24 14          	push   0x14(%esp)
400003d7:	ff 74 24 14          	push   0x14(%esp)
400003db:	ff 74 24 14          	push   0x14(%esp)
400003df:	ff 74 24 14          	push   0x14(%esp)
400003e3:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
400003e7:	e8 a4 28 00 00       	call   40002c90 <__umoddi3>
400003ec:	0f be 84 03 24 c0 ff 	movsbl -0x3fdc(%ebx,%eax,1),%eax
400003f3:	ff 
400003f4:	89 44 24 50          	mov    %eax,0x50(%esp)
}
400003f8:	83 c4 3c             	add    $0x3c,%esp
    putch("0123456789abcdef"[num % base], putdat);
400003fb:	89 f0                	mov    %esi,%eax
}
400003fd:	5b                   	pop    %ebx
400003fe:	5e                   	pop    %esi
400003ff:	5f                   	pop    %edi
40000400:	5d                   	pop    %ebp
    putch("0123456789abcdef"[num % base], putdat);
40000401:	ff e0                	jmp    *%eax
40000403:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000407:	90                   	nop
        printnum(putch, putdat, num / base, base, width - 1, padc);
40000408:	83 ec 0c             	sub    $0xc,%esp
4000040b:	53                   	push   %ebx
4000040c:	55                   	push   %ebp
4000040d:	52                   	push   %edx
4000040e:	83 ec 08             	sub    $0x8,%esp
40000411:	ff 74 24 34          	push   0x34(%esp)
40000415:	ff 74 24 34          	push   0x34(%esp)
40000419:	ff 74 24 34          	push   0x34(%esp)
4000041d:	ff 74 24 34          	push   0x34(%esp)
40000421:	8b 5c 24 4c          	mov    0x4c(%esp),%ebx
40000425:	e8 46 27 00 00       	call   40002b70 <__udivdi3>
4000042a:	83 c4 18             	add    $0x18,%esp
4000042d:	52                   	push   %edx
4000042e:	89 fa                	mov    %edi,%edx
40000430:	50                   	push   %eax
40000431:	89 f0                	mov    %esi,%eax
40000433:	e8 28 ff ff ff       	call   40000360 <printnum>
40000438:	83 c4 20             	add    $0x20,%esp
4000043b:	eb 92                	jmp    400003cf <printnum+0x6f>
4000043d:	8d 76 00             	lea    0x0(%esi),%esi

40000440 <sprintputch>:
    char *ebuf;
    int cnt;
};

static void sprintputch(int ch, struct sprintbuf *b)
{
40000440:	8b 44 24 08          	mov    0x8(%esp),%eax
    b->cnt++;
40000444:	83 40 08 01          	addl   $0x1,0x8(%eax)
    if (b->buf < b->ebuf)
40000448:	8b 10                	mov    (%eax),%edx
4000044a:	3b 50 04             	cmp    0x4(%eax),%edx
4000044d:	73 0b                	jae    4000045a <sprintputch+0x1a>
        *b->buf++ = ch;
4000044f:	8d 4a 01             	lea    0x1(%edx),%ecx
40000452:	89 08                	mov    %ecx,(%eax)
40000454:	8b 44 24 04          	mov    0x4(%esp),%eax
40000458:	88 02                	mov    %al,(%edx)
}
4000045a:	c3                   	ret    
4000045b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
4000045f:	90                   	nop

40000460 <vprintfmt>:
{
40000460:	e8 8e 06 00 00       	call   40000af3 <__x86.get_pc_thunk.ax>
40000465:	05 9b 6b 00 00       	add    $0x6b9b,%eax
4000046a:	55                   	push   %ebp
4000046b:	57                   	push   %edi
4000046c:	56                   	push   %esi
4000046d:	53                   	push   %ebx
4000046e:	83 ec 3c             	sub    $0x3c,%esp
40000471:	8b 74 24 50          	mov    0x50(%esp),%esi
40000475:	8b 6c 24 54          	mov    0x54(%esp),%ebp
40000479:	89 44 24 14          	mov    %eax,0x14(%esp)
                for (width -= strnlen(p, precision); width > 0; width--)
4000047d:	8d 80 35 c0 ff ff    	lea    -0x3fcb(%eax),%eax
40000483:	89 44 24 24          	mov    %eax,0x24(%esp)
{
40000487:	8b 7c 24 58          	mov    0x58(%esp),%edi
        while ((ch = *(unsigned char *) fmt++) != '%') {
4000048b:	0f b6 07             	movzbl (%edi),%eax
4000048e:	8d 5f 01             	lea    0x1(%edi),%ebx
40000491:	83 f8 25             	cmp    $0x25,%eax
40000494:	75 20                	jne    400004b6 <vprintfmt+0x56>
40000496:	eb 30                	jmp    400004c8 <vprintfmt+0x68>
40000498:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000049f:	90                   	nop
            putch(ch, putdat);
400004a0:	83 ec 08             	sub    $0x8,%esp
        while ((ch = *(unsigned char *) fmt++) != '%') {
400004a3:	83 c3 01             	add    $0x1,%ebx
            putch(ch, putdat);
400004a6:	55                   	push   %ebp
400004a7:	50                   	push   %eax
400004a8:	ff d6                	call   *%esi
        while ((ch = *(unsigned char *) fmt++) != '%') {
400004aa:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
400004ae:	83 c4 10             	add    $0x10,%esp
400004b1:	83 f8 25             	cmp    $0x25,%eax
400004b4:	74 12                	je     400004c8 <vprintfmt+0x68>
            if (ch == '\0')
400004b6:	85 c0                	test   %eax,%eax
400004b8:	75 e6                	jne    400004a0 <vprintfmt+0x40>
}
400004ba:	83 c4 3c             	add    $0x3c,%esp
400004bd:	5b                   	pop    %ebx
400004be:	5e                   	pop    %esi
400004bf:	5f                   	pop    %edi
400004c0:	5d                   	pop    %ebp
400004c1:	c3                   	ret    
400004c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        precision = -1;
400004c8:	ba ff ff ff ff       	mov    $0xffffffff,%edx
        padc = ' ';
400004cd:	c6 44 24 18 20       	movb   $0x20,0x18(%esp)
        altflag = 0;
400004d2:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
400004d9:	00 
        width = -1;
400004da:	c7 44 24 10 ff ff ff 	movl   $0xffffffff,0x10(%esp)
400004e1:	ff 
        lflag = 0;
400004e2:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%esp)
400004e9:	00 
400004ea:	89 54 24 1c          	mov    %edx,0x1c(%esp)
400004ee:	89 74 24 50          	mov    %esi,0x50(%esp)
        switch (ch = *(unsigned char *) fmt++) {
400004f2:	0f b6 0b             	movzbl (%ebx),%ecx
400004f5:	8d 7b 01             	lea    0x1(%ebx),%edi
400004f8:	8d 41 dd             	lea    -0x23(%ecx),%eax
400004fb:	3c 55                	cmp    $0x55,%al
400004fd:	77 19                	ja     40000518 <.L20>
400004ff:	8b 54 24 14          	mov    0x14(%esp),%edx
40000503:	0f b6 c0             	movzbl %al,%eax
40000506:	8b b4 82 3c c0 ff ff 	mov    -0x3fc4(%edx,%eax,4),%esi
4000050d:	01 d6                	add    %edx,%esi
4000050f:	ff e6                	jmp    *%esi
40000511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000518 <.L20>:
            putch('%', putdat);
40000518:	8b 74 24 50          	mov    0x50(%esp),%esi
4000051c:	83 ec 08             	sub    $0x8,%esp
            for (fmt--; fmt[-1] != '%'; fmt--)
4000051f:	89 df                	mov    %ebx,%edi
            putch('%', putdat);
40000521:	55                   	push   %ebp
40000522:	6a 25                	push   $0x25
40000524:	ff d6                	call   *%esi
            for (fmt--; fmt[-1] != '%'; fmt--)
40000526:	83 c4 10             	add    $0x10,%esp
40000529:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
4000052d:	0f 84 58 ff ff ff    	je     4000048b <vprintfmt+0x2b>
40000533:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000537:	90                   	nop
40000538:	83 ef 01             	sub    $0x1,%edi
4000053b:	80 7f ff 25          	cmpb   $0x25,-0x1(%edi)
4000053f:	75 f7                	jne    40000538 <.L20+0x20>
40000541:	e9 45 ff ff ff       	jmp    4000048b <vprintfmt+0x2b>
40000546:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000054d:	8d 76 00             	lea    0x0(%esi),%esi

40000550 <.L30>:
                ch = *fmt;
40000550:	0f be 43 01          	movsbl 0x1(%ebx),%eax
                precision = precision * 10 + ch - '0';
40000554:	8d 51 d0             	lea    -0x30(%ecx),%edx
        switch (ch = *(unsigned char *) fmt++) {
40000557:	89 fb                	mov    %edi,%ebx
                precision = precision * 10 + ch - '0';
40000559:	89 54 24 1c          	mov    %edx,0x1c(%esp)
                if (ch < '0' || ch > '9')
4000055d:	8d 48 d0             	lea    -0x30(%eax),%ecx
40000560:	83 f9 09             	cmp    $0x9,%ecx
40000563:	77 28                	ja     4000058d <.L30+0x3d>
        switch (ch = *(unsigned char *) fmt++) {
40000565:	8b 74 24 50          	mov    0x50(%esp),%esi
40000569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            for (precision = 0;; ++fmt) {
40000570:	83 c3 01             	add    $0x1,%ebx
                precision = precision * 10 + ch - '0';
40000573:	8d 14 92             	lea    (%edx,%edx,4),%edx
40000576:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
                ch = *fmt;
4000057a:	0f be 03             	movsbl (%ebx),%eax
                if (ch < '0' || ch > '9')
4000057d:	8d 48 d0             	lea    -0x30(%eax),%ecx
40000580:	83 f9 09             	cmp    $0x9,%ecx
40000583:	76 eb                	jbe    40000570 <.L30+0x20>
40000585:	89 54 24 1c          	mov    %edx,0x1c(%esp)
40000589:	89 74 24 50          	mov    %esi,0x50(%esp)
            if (width < 0)
4000058d:	8b 74 24 10          	mov    0x10(%esp),%esi
40000591:	85 f6                	test   %esi,%esi
40000593:	0f 89 59 ff ff ff    	jns    400004f2 <vprintfmt+0x92>
                width = precision, precision = -1;
40000599:	8b 44 24 1c          	mov    0x1c(%esp),%eax
4000059d:	c7 44 24 1c ff ff ff 	movl   $0xffffffff,0x1c(%esp)
400005a4:	ff 
400005a5:	89 44 24 10          	mov    %eax,0x10(%esp)
400005a9:	e9 44 ff ff ff       	jmp    400004f2 <vprintfmt+0x92>

400005ae <.L35>:
            altflag = 1;
400005ae:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
400005b5:	00 
        switch (ch = *(unsigned char *) fmt++) {
400005b6:	89 fb                	mov    %edi,%ebx
            goto reswitch;
400005b8:	e9 35 ff ff ff       	jmp    400004f2 <vprintfmt+0x92>

400005bd <.L34>:
            putch(ch, putdat);
400005bd:	8b 74 24 50          	mov    0x50(%esp),%esi
400005c1:	83 ec 08             	sub    $0x8,%esp
400005c4:	55                   	push   %ebp
400005c5:	6a 25                	push   $0x25
400005c7:	ff d6                	call   *%esi
            break;
400005c9:	83 c4 10             	add    $0x10,%esp
400005cc:	e9 ba fe ff ff       	jmp    4000048b <vprintfmt+0x2b>

400005d1 <.L33>:
            precision = va_arg(ap, int);
400005d1:	8b 44 24 5c          	mov    0x5c(%esp),%eax
        switch (ch = *(unsigned char *) fmt++) {
400005d5:	89 fb                	mov    %edi,%ebx
            precision = va_arg(ap, int);
400005d7:	8b 00                	mov    (%eax),%eax
400005d9:	89 44 24 1c          	mov    %eax,0x1c(%esp)
400005dd:	8b 44 24 5c          	mov    0x5c(%esp),%eax
400005e1:	83 c0 04             	add    $0x4,%eax
400005e4:	89 44 24 5c          	mov    %eax,0x5c(%esp)
            goto process_precision;
400005e8:	eb a3                	jmp    4000058d <.L30+0x3d>

400005ea <.L32>:
            if (width < 0)
400005ea:	8b 4c 24 10          	mov    0x10(%esp),%ecx
400005ee:	31 c0                	xor    %eax,%eax
        switch (ch = *(unsigned char *) fmt++) {
400005f0:	89 fb                	mov    %edi,%ebx
400005f2:	85 c9                	test   %ecx,%ecx
400005f4:	0f 49 c1             	cmovns %ecx,%eax
400005f7:	89 44 24 10          	mov    %eax,0x10(%esp)
            goto reswitch;
400005fb:	e9 f2 fe ff ff       	jmp    400004f2 <vprintfmt+0x92>

40000600 <.L29>:
            putch(va_arg(ap, int), putdat);
40000600:	8b 44 24 5c          	mov    0x5c(%esp),%eax
40000604:	8b 74 24 50          	mov    0x50(%esp),%esi
40000608:	83 ec 08             	sub    $0x8,%esp
4000060b:	55                   	push   %ebp
4000060c:	8d 58 04             	lea    0x4(%eax),%ebx
4000060f:	8b 44 24 68          	mov    0x68(%esp),%eax
40000613:	ff 30                	push   (%eax)
40000615:	ff d6                	call   *%esi
40000617:	89 5c 24 6c          	mov    %ebx,0x6c(%esp)
            break;
4000061b:	83 c4 10             	add    $0x10,%esp
4000061e:	e9 68 fe ff ff       	jmp    4000048b <vprintfmt+0x2b>

40000623 <.L23>:
    if (lflag >= 2)
40000623:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
40000628:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, unsigned long long);
4000062c:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
40000630:	0f 8f d7 01 00 00    	jg     4000080d <.L24+0xe0>
        return va_arg(*ap, unsigned long);
40000636:	8b 4c 24 5c          	mov    0x5c(%esp),%ecx
            precision = va_arg(ap, int);
4000063a:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
4000063d:	31 db                	xor    %ebx,%ebx
4000063f:	ba 0a 00 00 00       	mov    $0xa,%edx
40000644:	8b 09                	mov    (%ecx),%ecx
40000646:	89 44 24 5c          	mov    %eax,0x5c(%esp)
4000064a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            printnum(putch, putdat, num, base, width, padc);
40000650:	83 ec 0c             	sub    $0xc,%esp
40000653:	0f be 44 24 24       	movsbl 0x24(%esp),%eax
40000658:	50                   	push   %eax
40000659:	89 f0                	mov    %esi,%eax
4000065b:	ff 74 24 20          	push   0x20(%esp)
4000065f:	52                   	push   %edx
40000660:	89 ea                	mov    %ebp,%edx
40000662:	53                   	push   %ebx
40000663:	51                   	push   %ecx
40000664:	e8 f7 fc ff ff       	call   40000360 <printnum>
            break;
40000669:	83 c4 20             	add    $0x20,%esp
4000066c:	e9 1a fe ff ff       	jmp    4000048b <vprintfmt+0x2b>

40000671 <.L25>:
            putch('0', putdat);
40000671:	8b 74 24 50          	mov    0x50(%esp),%esi
40000675:	83 ec 08             	sub    $0x8,%esp
40000678:	55                   	push   %ebp
40000679:	6a 30                	push   $0x30
4000067b:	ff d6                	call   *%esi
            putch('x', putdat);
4000067d:	59                   	pop    %ecx
4000067e:	5b                   	pop    %ebx
4000067f:	55                   	push   %ebp
40000680:	6a 78                	push   $0x78
            num = (unsigned long long)
40000682:	31 db                	xor    %ebx,%ebx
            putch('x', putdat);
40000684:	ff d6                	call   *%esi
            num = (unsigned long long)
40000686:	8b 44 24 6c          	mov    0x6c(%esp),%eax
            goto number;
4000068a:	ba 10 00 00 00       	mov    $0x10,%edx
            num = (unsigned long long)
4000068f:	8b 08                	mov    (%eax),%ecx
            goto number;
40000691:	83 c4 10             	add    $0x10,%esp
                (uintptr_t) va_arg(ap, void *);
40000694:	83 c0 04             	add    $0x4,%eax
40000697:	89 44 24 5c          	mov    %eax,0x5c(%esp)
            goto number;
4000069b:	eb b3                	jmp    40000650 <.L23+0x2d>

4000069d <.L21>:
    if (lflag >= 2)
4000069d:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
400006a2:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, unsigned long long);
400006a6:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
400006aa:	0f 8f 6e 01 00 00    	jg     4000081e <.L24+0xf1>
        return va_arg(*ap, unsigned long);
400006b0:	8b 4c 24 5c          	mov    0x5c(%esp),%ecx
            precision = va_arg(ap, int);
400006b4:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
400006b7:	31 db                	xor    %ebx,%ebx
400006b9:	ba 10 00 00 00       	mov    $0x10,%edx
400006be:	8b 09                	mov    (%ecx),%ecx
400006c0:	89 44 24 5c          	mov    %eax,0x5c(%esp)
400006c4:	eb 8a                	jmp    40000650 <.L23+0x2d>

400006c6 <.L28>:
    if (lflag >= 2)
400006c6:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
400006cb:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, long long);
400006cf:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
400006d3:	0f 8f 5b 01 00 00    	jg     40000834 <.L24+0x107>
        return va_arg(*ap, long);
400006d9:	8b 00                	mov    (%eax),%eax
400006db:	89 c3                	mov    %eax,%ebx
400006dd:	89 c1                	mov    %eax,%ecx
400006df:	8b 44 24 5c          	mov    0x5c(%esp),%eax
400006e3:	c1 fb 1f             	sar    $0x1f,%ebx
400006e6:	83 c0 04             	add    $0x4,%eax
400006e9:	89 44 24 5c          	mov    %eax,0x5c(%esp)
            if ((long long) num < 0) {
400006ed:	85 db                	test   %ebx,%ebx
400006ef:	0f 88 68 01 00 00    	js     4000085d <.L31+0xc>
        return va_arg(*ap, unsigned long long);
400006f5:	ba 0a 00 00 00       	mov    $0xa,%edx
400006fa:	e9 51 ff ff ff       	jmp    40000650 <.L23+0x2d>

400006ff <.L27>:
            lflag++;
400006ff:	83 44 24 20 01       	addl   $0x1,0x20(%esp)
        switch (ch = *(unsigned char *) fmt++) {
40000704:	89 fb                	mov    %edi,%ebx
            goto reswitch;
40000706:	e9 e7 fd ff ff       	jmp    400004f2 <vprintfmt+0x92>

4000070b <.L26>:
            putch('X', putdat);
4000070b:	8b 74 24 50          	mov    0x50(%esp),%esi
4000070f:	83 ec 08             	sub    $0x8,%esp
40000712:	55                   	push   %ebp
40000713:	6a 58                	push   $0x58
40000715:	ff d6                	call   *%esi
            putch('X', putdat);
40000717:	58                   	pop    %eax
40000718:	5a                   	pop    %edx
40000719:	55                   	push   %ebp
4000071a:	6a 58                	push   $0x58
4000071c:	ff d6                	call   *%esi
            putch('X', putdat);
4000071e:	59                   	pop    %ecx
4000071f:	5b                   	pop    %ebx
40000720:	55                   	push   %ebp
40000721:	6a 58                	push   $0x58
40000723:	ff d6                	call   *%esi
            break;
40000725:	83 c4 10             	add    $0x10,%esp
40000728:	e9 5e fd ff ff       	jmp    4000048b <vprintfmt+0x2b>

4000072d <.L24>:
            if ((p = va_arg(ap, char *)) == NULL)
4000072d:	8b 44 24 5c          	mov    0x5c(%esp),%eax
            if (width > 0 && padc != '-')
40000731:	8b 5c 24 10          	mov    0x10(%esp),%ebx
            if ((p = va_arg(ap, char *)) == NULL)
40000735:	8b 54 24 1c          	mov    0x1c(%esp),%edx
40000739:	8b 74 24 50          	mov    0x50(%esp),%esi
4000073d:	83 c0 04             	add    $0x4,%eax
            if (width > 0 && padc != '-')
40000740:	80 7c 24 18 2d       	cmpb   $0x2d,0x18(%esp)
            if ((p = va_arg(ap, char *)) == NULL)
40000745:	89 44 24 1c          	mov    %eax,0x1c(%esp)
40000749:	8b 44 24 5c          	mov    0x5c(%esp),%eax
4000074d:	8b 08                	mov    (%eax),%ecx
            if (width > 0 && padc != '-')
4000074f:	0f 95 c0             	setne  %al
40000752:	85 db                	test   %ebx,%ebx
40000754:	0f 9f c3             	setg   %bl
40000757:	21 d8                	and    %ebx,%eax
            if ((p = va_arg(ap, char *)) == NULL)
40000759:	85 c9                	test   %ecx,%ecx
4000075b:	0f 84 28 01 00 00    	je     40000889 <.L31+0x38>
                 (ch = *p++) != '\0' && (precision < 0
40000761:	8d 59 01             	lea    0x1(%ecx),%ebx
40000764:	89 5c 24 20          	mov    %ebx,0x20(%esp)
            if (width > 0 && padc != '-')
40000768:	84 c0                	test   %al,%al
4000076a:	0f 85 48 01 00 00    	jne    400008b8 <.L31+0x67>
                 (ch = *p++) != '\0' && (precision < 0
40000770:	0f be 09             	movsbl (%ecx),%ecx
40000773:	89 c8                	mov    %ecx,%eax
40000775:	85 c9                	test   %ecx,%ecx
40000777:	74 67                	je     400007e0 <.L24+0xb3>
40000779:	89 74 24 50          	mov    %esi,0x50(%esp)
4000077d:	89 d6                	mov    %edx,%esi
4000077f:	89 7c 24 58          	mov    %edi,0x58(%esp)
40000783:	8b 7c 24 10          	mov    0x10(%esp),%edi
40000787:	eb 2c                	jmp    400007b5 <.L24+0x88>
40000789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                if (altflag && (ch < ' ' || ch > '~'))
40000790:	83 e8 20             	sub    $0x20,%eax
40000793:	83 f8 5e             	cmp    $0x5e,%eax
40000796:	76 2e                	jbe    400007c6 <.L24+0x99>
                    putch('?', putdat);
40000798:	83 ec 08             	sub    $0x8,%esp
4000079b:	55                   	push   %ebp
4000079c:	6a 3f                	push   $0x3f
4000079e:	ff 54 24 60          	call   *0x60(%esp)
400007a2:	83 c4 10             	add    $0x10,%esp
                 (ch = *p++) != '\0' && (precision < 0
400007a5:	0f be 03             	movsbl (%ebx),%eax
400007a8:	83 c3 01             	add    $0x1,%ebx
                                         || --precision >= 0); width--)
400007ab:	83 ef 01             	sub    $0x1,%edi
                 (ch = *p++) != '\0' && (precision < 0
400007ae:	0f be c8             	movsbl %al,%ecx
400007b1:	85 c9                	test   %ecx,%ecx
400007b3:	74 1f                	je     400007d4 <.L24+0xa7>
400007b5:	85 f6                	test   %esi,%esi
400007b7:	78 05                	js     400007be <.L24+0x91>
                                         || --precision >= 0); width--)
400007b9:	83 ee 01             	sub    $0x1,%esi
400007bc:	72 16                	jb     400007d4 <.L24+0xa7>
                if (altflag && (ch < ' ' || ch > '~'))
400007be:	8b 54 24 08          	mov    0x8(%esp),%edx
400007c2:	85 d2                	test   %edx,%edx
400007c4:	75 ca                	jne    40000790 <.L24+0x63>
                    putch(ch, putdat);
400007c6:	83 ec 08             	sub    $0x8,%esp
400007c9:	55                   	push   %ebp
400007ca:	51                   	push   %ecx
400007cb:	ff 54 24 60          	call   *0x60(%esp)
400007cf:	83 c4 10             	add    $0x10,%esp
400007d2:	eb d1                	jmp    400007a5 <.L24+0x78>
400007d4:	89 7c 24 10          	mov    %edi,0x10(%esp)
400007d8:	8b 74 24 50          	mov    0x50(%esp),%esi
400007dc:	8b 7c 24 58          	mov    0x58(%esp),%edi
            for (; width > 0; width--)
400007e0:	8b 4c 24 10          	mov    0x10(%esp),%ecx
400007e4:	8b 5c 24 10          	mov    0x10(%esp),%ebx
400007e8:	85 c9                	test   %ecx,%ecx
400007ea:	7e 14                	jle    40000800 <.L24+0xd3>
400007ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                putch(' ', putdat);
400007f0:	83 ec 08             	sub    $0x8,%esp
400007f3:	55                   	push   %ebp
400007f4:	6a 20                	push   $0x20
400007f6:	ff d6                	call   *%esi
            for (; width > 0; width--)
400007f8:	83 c4 10             	add    $0x10,%esp
400007fb:	83 eb 01             	sub    $0x1,%ebx
400007fe:	75 f0                	jne    400007f0 <.L24+0xc3>
            if ((p = va_arg(ap, char *)) == NULL)
40000800:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000804:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000808:	e9 7e fc ff ff       	jmp    4000048b <vprintfmt+0x2b>
        return va_arg(*ap, unsigned long long);
4000080d:	8b 08                	mov    (%eax),%ecx
4000080f:	8b 58 04             	mov    0x4(%eax),%ebx
40000812:	83 c0 08             	add    $0x8,%eax
40000815:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000819:	e9 d7 fe ff ff       	jmp    400006f5 <.L28+0x2f>
4000081e:	8b 08                	mov    (%eax),%ecx
40000820:	8b 58 04             	mov    0x4(%eax),%ebx
40000823:	83 c0 08             	add    $0x8,%eax
40000826:	ba 10 00 00 00       	mov    $0x10,%edx
4000082b:	89 44 24 5c          	mov    %eax,0x5c(%esp)
4000082f:	e9 1c fe ff ff       	jmp    40000650 <.L23+0x2d>
        return va_arg(*ap, long long);
40000834:	8b 08                	mov    (%eax),%ecx
40000836:	8b 58 04             	mov    0x4(%eax),%ebx
40000839:	83 c0 08             	add    $0x8,%eax
4000083c:	89 44 24 5c          	mov    %eax,0x5c(%esp)
40000840:	e9 a8 fe ff ff       	jmp    400006ed <.L28+0x27>

40000845 <.L61>:
            padc = '-';
40000845:	c6 44 24 18 2d       	movb   $0x2d,0x18(%esp)
        switch (ch = *(unsigned char *) fmt++) {
4000084a:	89 fb                	mov    %edi,%ebx
4000084c:	e9 a1 fc ff ff       	jmp    400004f2 <vprintfmt+0x92>

40000851 <.L31>:
40000851:	c6 44 24 18 30       	movb   $0x30,0x18(%esp)
40000856:	89 fb                	mov    %edi,%ebx
40000858:	e9 95 fc ff ff       	jmp    400004f2 <vprintfmt+0x92>
4000085d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
                putch('-', putdat);
40000861:	83 ec 08             	sub    $0x8,%esp
40000864:	89 5c 24 14          	mov    %ebx,0x14(%esp)
40000868:	55                   	push   %ebp
40000869:	6a 2d                	push   $0x2d
4000086b:	ff d6                	call   *%esi
                num = -(long long) num;
4000086d:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000871:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
40000875:	ba 0a 00 00 00       	mov    $0xa,%edx
4000087a:	f7 d9                	neg    %ecx
4000087c:	83 d3 00             	adc    $0x0,%ebx
4000087f:	83 c4 10             	add    $0x10,%esp
40000882:	f7 db                	neg    %ebx
40000884:	e9 c7 fd ff ff       	jmp    40000650 <.L23+0x2d>
            if (width > 0 && padc != '-')
40000889:	84 c0                	test   %al,%al
4000088b:	0f 85 9f 00 00 00    	jne    40000930 <.L31+0xdf>
                 (ch = *p++) != '\0' && (precision < 0
40000891:	8b 44 24 14          	mov    0x14(%esp),%eax
40000895:	b9 28 00 00 00       	mov    $0x28,%ecx
4000089a:	8d 98 36 c0 ff ff    	lea    -0x3fca(%eax),%ebx
400008a0:	89 74 24 50          	mov    %esi,0x50(%esp)
400008a4:	b8 28 00 00 00       	mov    $0x28,%eax
400008a9:	89 d6                	mov    %edx,%esi
400008ab:	89 7c 24 58          	mov    %edi,0x58(%esp)
400008af:	8b 7c 24 10          	mov    0x10(%esp),%edi
400008b3:	e9 fd fe ff ff       	jmp    400007b5 <.L24+0x88>
                for (width -= strnlen(p, precision); width > 0; width--)
400008b8:	83 ec 08             	sub    $0x8,%esp
400008bb:	52                   	push   %edx
400008bc:	89 54 24 38          	mov    %edx,0x38(%esp)
400008c0:	51                   	push   %ecx
400008c1:	8b 5c 24 24          	mov    0x24(%esp),%ebx
400008c5:	89 4c 24 38          	mov    %ecx,0x38(%esp)
400008c9:	e8 f2 02 00 00       	call   40000bc0 <strnlen>
400008ce:	29 44 24 20          	sub    %eax,0x20(%esp)
400008d2:	8b 4c 24 20          	mov    0x20(%esp),%ecx
400008d6:	83 c4 10             	add    $0x10,%esp
400008d9:	8b 54 24 2c          	mov    0x2c(%esp),%edx
400008dd:	85 c9                	test   %ecx,%ecx
400008df:	8b 4c 24 28          	mov    0x28(%esp),%ecx
400008e3:	7e 34                	jle    40000919 <.L31+0xc8>
                    putch(padc, putdat);
400008e5:	0f be 5c 24 18       	movsbl 0x18(%esp),%ebx
400008ea:	89 4c 24 28          	mov    %ecx,0x28(%esp)
400008ee:	89 54 24 18          	mov    %edx,0x18(%esp)
400008f2:	89 7c 24 58          	mov    %edi,0x58(%esp)
400008f6:	8b 7c 24 10          	mov    0x10(%esp),%edi
400008fa:	83 ec 08             	sub    $0x8,%esp
400008fd:	55                   	push   %ebp
400008fe:	53                   	push   %ebx
400008ff:	ff d6                	call   *%esi
                for (width -= strnlen(p, precision); width > 0; width--)
40000901:	83 c4 10             	add    $0x10,%esp
40000904:	83 ef 01             	sub    $0x1,%edi
40000907:	75 f1                	jne    400008fa <.L31+0xa9>
40000909:	8b 54 24 18          	mov    0x18(%esp),%edx
4000090d:	8b 4c 24 28          	mov    0x28(%esp),%ecx
40000911:	89 7c 24 10          	mov    %edi,0x10(%esp)
40000915:	8b 7c 24 58          	mov    0x58(%esp),%edi
                 (ch = *p++) != '\0' && (precision < 0
40000919:	0f be 01             	movsbl (%ecx),%eax
4000091c:	8b 5c 24 20          	mov    0x20(%esp),%ebx
40000920:	0f be c8             	movsbl %al,%ecx
40000923:	85 c9                	test   %ecx,%ecx
40000925:	0f 85 4e fe ff ff    	jne    40000779 <.L24+0x4c>
4000092b:	e9 d0 fe ff ff       	jmp    40000800 <.L24+0xd3>
                for (width -= strnlen(p, precision); width > 0; width--)
40000930:	83 ec 08             	sub    $0x8,%esp
40000933:	52                   	push   %edx
40000934:	89 54 24 34          	mov    %edx,0x34(%esp)
40000938:	ff 74 24 30          	push   0x30(%esp)
4000093c:	8b 5c 24 24          	mov    0x24(%esp),%ebx
40000940:	e8 7b 02 00 00       	call   40000bc0 <strnlen>
40000945:	29 44 24 20          	sub    %eax,0x20(%esp)
40000949:	8b 44 24 20          	mov    0x20(%esp),%eax
4000094d:	83 c4 10             	add    $0x10,%esp
                p = "(null)";
40000950:	8b 54 24 24          	mov    0x24(%esp),%edx
40000954:	89 d1                	mov    %edx,%ecx
40000956:	83 c2 01             	add    $0x1,%edx
                for (width -= strnlen(p, precision); width > 0; width--)
40000959:	85 c0                	test   %eax,%eax
4000095b:	89 54 24 20          	mov    %edx,0x20(%esp)
4000095f:	8b 54 24 28          	mov    0x28(%esp),%edx
40000963:	7f 80                	jg     400008e5 <.L31+0x94>
                 (ch = *p++) != '\0' && (precision < 0
40000965:	8b 5c 24 20          	mov    0x20(%esp),%ebx
40000969:	b9 28 00 00 00       	mov    $0x28,%ecx
4000096e:	e9 2d ff ff ff       	jmp    400008a0 <.L31+0x4f>
40000973:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000097a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000980 <printfmt>:
{
40000980:	83 ec 0c             	sub    $0xc,%esp
    vprintfmt(putch, putdat, fmt, ap);
40000983:	8d 44 24 1c          	lea    0x1c(%esp),%eax
40000987:	50                   	push   %eax
40000988:	ff 74 24 1c          	push   0x1c(%esp)
4000098c:	ff 74 24 1c          	push   0x1c(%esp)
40000990:	ff 74 24 1c          	push   0x1c(%esp)
40000994:	e8 c7 fa ff ff       	call   40000460 <vprintfmt>
}
40000999:	83 c4 1c             	add    $0x1c,%esp
4000099c:	c3                   	ret    
4000099d:	8d 76 00             	lea    0x0(%esi),%esi

400009a0 <vsprintf>:

int vsprintf(char *buf, const char *fmt, va_list ap)
{
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
400009a0:	e8 4e 01 00 00       	call   40000af3 <__x86.get_pc_thunk.ax>
400009a5:	05 5b 66 00 00       	add    $0x665b,%eax
{
400009aa:	83 ec 1c             	sub    $0x1c,%esp
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
400009ad:	8b 54 24 20          	mov    0x20(%esp),%edx
400009b1:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
400009b8:	ff 
400009b9:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
400009c0:	00 
400009c1:	89 54 24 04          	mov    %edx,0x4(%esp)

    // print the string to the buffer
    vprintfmt((void *) sprintputch, &b, fmt, ap);
400009c5:	ff 74 24 28          	push   0x28(%esp)
400009c9:	ff 74 24 28          	push   0x28(%esp)
400009cd:	8d 80 40 94 ff ff    	lea    -0x6bc0(%eax),%eax
400009d3:	8d 54 24 0c          	lea    0xc(%esp),%edx
400009d7:	52                   	push   %edx
400009d8:	50                   	push   %eax
400009d9:	e8 82 fa ff ff       	call   40000460 <vprintfmt>

    // null terminate the buffer
    *b.buf = '\0';
400009de:	8b 44 24 14          	mov    0x14(%esp),%eax
400009e2:	c6 00 00             	movb   $0x0,(%eax)

    return b.cnt;
}
400009e5:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400009e9:	83 c4 2c             	add    $0x2c,%esp
400009ec:	c3                   	ret    
400009ed:	8d 76 00             	lea    0x0(%esi),%esi

400009f0 <sprintf>:
int sprintf(char *buf, const char *fmt, ...)
{
    va_list ap;
    int rc;

    va_start(ap, fmt);
400009f0:	e8 fe 00 00 00       	call   40000af3 <__x86.get_pc_thunk.ax>
400009f5:	05 0b 66 00 00       	add    $0x660b,%eax
{
400009fa:	83 ec 1c             	sub    $0x1c,%esp
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
400009fd:	8b 54 24 20          	mov    0x20(%esp),%edx
40000a01:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
40000a08:	ff 
40000a09:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000a10:	00 
40000a11:	89 54 24 04          	mov    %edx,0x4(%esp)
    vprintfmt((void *) sprintputch, &b, fmt, ap);
40000a15:	8d 54 24 28          	lea    0x28(%esp),%edx
40000a19:	52                   	push   %edx
40000a1a:	ff 74 24 28          	push   0x28(%esp)
40000a1e:	8d 80 40 94 ff ff    	lea    -0x6bc0(%eax),%eax
40000a24:	8d 54 24 0c          	lea    0xc(%esp),%edx
40000a28:	52                   	push   %edx
40000a29:	50                   	push   %eax
40000a2a:	e8 31 fa ff ff       	call   40000460 <vprintfmt>
    *b.buf = '\0';
40000a2f:	8b 44 24 14          	mov    0x14(%esp),%eax
40000a33:	c6 00 00             	movb   $0x0,(%eax)
    rc = vsprintf(buf, fmt, ap);
    va_end(ap);

    return rc;
}
40000a36:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000a3a:	83 c4 2c             	add    $0x2c,%esp
40000a3d:	c3                   	ret    
40000a3e:	66 90                	xchg   %ax,%ax

40000a40 <vsnprintf>:

int vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
    struct sprintbuf b = { buf, buf + n - 1, 0 };
40000a40:	e8 b2 00 00 00       	call   40000af7 <__x86.get_pc_thunk.dx>
40000a45:	81 c2 bb 65 00 00    	add    $0x65bb,%edx
{
40000a4b:	83 ec 1c             	sub    $0x1c,%esp
40000a4e:	8b 44 24 20          	mov    0x20(%esp),%eax
    struct sprintbuf b = { buf, buf + n - 1, 0 };
40000a52:	8b 4c 24 24          	mov    0x24(%esp),%ecx
40000a56:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000a5d:	00 
40000a5e:	89 44 24 04          	mov    %eax,0x4(%esp)
40000a62:	8d 44 08 ff          	lea    -0x1(%eax,%ecx,1),%eax
40000a66:	89 44 24 08          	mov    %eax,0x8(%esp)

    // print the string to the buffer
    vprintfmt((void *) sprintputch, &b, fmt, ap);
40000a6a:	ff 74 24 2c          	push   0x2c(%esp)
40000a6e:	ff 74 24 2c          	push   0x2c(%esp)
40000a72:	8d 44 24 0c          	lea    0xc(%esp),%eax
40000a76:	50                   	push   %eax
40000a77:	8d 82 40 94 ff ff    	lea    -0x6bc0(%edx),%eax
40000a7d:	50                   	push   %eax
40000a7e:	e8 dd f9 ff ff       	call   40000460 <vprintfmt>

    // null terminate the buffer
    *b.buf = '\0';
40000a83:	8b 44 24 14          	mov    0x14(%esp),%eax
40000a87:	c6 00 00             	movb   $0x0,(%eax)

    return b.cnt;
}
40000a8a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000a8e:	83 c4 2c             	add    $0x2c,%esp
40000a91:	c3                   	ret    
40000a92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000aa0 <snprintf>:
int snprintf(char *buf, int n, const char *fmt, ...)
{
    va_list ap;
    int rc;

    va_start(ap, fmt);
40000aa0:	e8 52 00 00 00       	call   40000af7 <__x86.get_pc_thunk.dx>
40000aa5:	81 c2 5b 65 00 00    	add    $0x655b,%edx
{
40000aab:	83 ec 1c             	sub    $0x1c,%esp
40000aae:	8b 44 24 20          	mov    0x20(%esp),%eax
    struct sprintbuf b = { buf, buf + n - 1, 0 };
40000ab2:	8b 4c 24 24          	mov    0x24(%esp),%ecx
40000ab6:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000abd:	00 
40000abe:	89 44 24 04          	mov    %eax,0x4(%esp)
40000ac2:	8d 44 08 ff          	lea    -0x1(%eax,%ecx,1),%eax
40000ac6:	89 44 24 08          	mov    %eax,0x8(%esp)
    vprintfmt((void *) sprintputch, &b, fmt, ap);
40000aca:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000ace:	50                   	push   %eax
40000acf:	ff 74 24 2c          	push   0x2c(%esp)
40000ad3:	8d 44 24 0c          	lea    0xc(%esp),%eax
40000ad7:	50                   	push   %eax
40000ad8:	8d 82 40 94 ff ff    	lea    -0x6bc0(%edx),%eax
40000ade:	50                   	push   %eax
40000adf:	e8 7c f9 ff ff       	call   40000460 <vprintfmt>
    *b.buf = '\0';
40000ae4:	8b 44 24 14          	mov    0x14(%esp),%eax
40000ae8:	c6 00 00             	movb   $0x0,(%eax)
    rc = vsnprintf(buf, n, fmt, ap);
    va_end(ap);

    return rc;
}
40000aeb:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000aef:	83 c4 2c             	add    $0x2c,%esp
40000af2:	c3                   	ret    

40000af3 <__x86.get_pc_thunk.ax>:
40000af3:	8b 04 24             	mov    (%esp),%eax
40000af6:	c3                   	ret    

40000af7 <__x86.get_pc_thunk.dx>:
40000af7:	8b 14 24             	mov    (%esp),%edx
40000afa:	c3                   	ret    

40000afb <__x86.get_pc_thunk.cx>:
40000afb:	8b 0c 24             	mov    (%esp),%ecx
40000afe:	c3                   	ret    
40000aff:	90                   	nop

40000b00 <spawn>:
#include <proc.h>
#include <syscall.h>
#include <types.h>

pid_t spawn(uintptr_t exec, unsigned int quota)
{
40000b00:	53                   	push   %ebx
    asm volatile ("int %2"
40000b01:	b8 01 00 00 00       	mov    $0x1,%eax
40000b06:	8b 5c 24 08          	mov    0x8(%esp),%ebx
40000b0a:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000b0e:	cd 30                	int    $0x30
    return errno ? -1 : pid;
40000b10:	85 c0                	test   %eax,%eax
40000b12:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
40000b17:	0f 44 c3             	cmove  %ebx,%eax
    return sys_spawn(exec, quota);
}
40000b1a:	5b                   	pop    %ebx
40000b1b:	c3                   	ret    
40000b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000b20 <yield>:
    asm volatile ("int %0"
40000b20:	b8 02 00 00 00       	mov    $0x2,%eax
40000b25:	cd 30                	int    $0x30

void yield(void)
{
    sys_yield();
}
40000b27:	c3                   	ret    
40000b28:	66 90                	xchg   %ax,%ax
40000b2a:	66 90                	xchg   %ax,%ax
40000b2c:	66 90                	xchg   %ax,%ax
40000b2e:	66 90                	xchg   %ax,%ax

40000b30 <spinlock_init>:
    return result;
}

void spinlock_init(spinlock_t *lk)
{
    *lk = 0;
40000b30:	8b 44 24 04          	mov    0x4(%esp),%eax
40000b34:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
40000b3a:	c3                   	ret    
40000b3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000b3f:	90                   	nop

40000b40 <spinlock_acquire>:

void spinlock_acquire(spinlock_t *lk)
{
40000b40:	8b 54 24 04          	mov    0x4(%esp),%edx
    asm volatile ("lock; xchgl %0, %1"
40000b44:	b8 01 00 00 00       	mov    $0x1,%eax
40000b49:	f0 87 02             	lock xchg %eax,(%edx)
    while (xchg(lk, 1) != 0)
40000b4c:	85 c0                	test   %eax,%eax
40000b4e:	74 13                	je     40000b63 <spinlock_acquire+0x23>
    asm volatile ("lock; xchgl %0, %1"
40000b50:	b9 01 00 00 00       	mov    $0x1,%ecx
40000b55:	8d 76 00             	lea    0x0(%esi),%esi
        asm volatile ("pause");
40000b58:	f3 90                	pause  
    asm volatile ("lock; xchgl %0, %1"
40000b5a:	89 c8                	mov    %ecx,%eax
40000b5c:	f0 87 02             	lock xchg %eax,(%edx)
    while (xchg(lk, 1) != 0)
40000b5f:	85 c0                	test   %eax,%eax
40000b61:	75 f5                	jne    40000b58 <spinlock_acquire+0x18>
}
40000b63:	c3                   	ret    
40000b64:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000b6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000b6f:	90                   	nop

40000b70 <spinlock_release>:

// Release the lock.
void spinlock_release(spinlock_t *lk)
{
40000b70:	8b 54 24 04          	mov    0x4(%esp),%edx
}

// Check whether this cpu is holding the lock.
bool spinlock_holding(spinlock_t *lk)
{
    return *lk;
40000b74:	8b 02                	mov    (%edx),%eax
    if (spinlock_holding(lk) == FALSE)
40000b76:	84 c0                	test   %al,%al
40000b78:	74 05                	je     40000b7f <spinlock_release+0xf>
    asm volatile ("lock; xchgl %0, %1"
40000b7a:	31 c0                	xor    %eax,%eax
40000b7c:	f0 87 02             	lock xchg %eax,(%edx)
}
40000b7f:	c3                   	ret    

40000b80 <spinlock_holding>:
    return *lk;
40000b80:	8b 44 24 04          	mov    0x4(%esp),%eax
40000b84:	8b 00                	mov    (%eax),%eax
}
40000b86:	c3                   	ret    
40000b87:	66 90                	xchg   %ax,%ax
40000b89:	66 90                	xchg   %ax,%ax
40000b8b:	66 90                	xchg   %ax,%ax
40000b8d:	66 90                	xchg   %ax,%ax
40000b8f:	90                   	nop

40000b90 <strlen>:
#include <string.h>
#include <types.h>

int strlen(const char *s)
{
40000b90:	8b 54 24 04          	mov    0x4(%esp),%edx
    int n;

    for (n = 0; *s != '\0'; s++)
40000b94:	31 c0                	xor    %eax,%eax
40000b96:	80 3a 00             	cmpb   $0x0,(%edx)
40000b99:	74 15                	je     40000bb0 <strlen+0x20>
40000b9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000b9f:	90                   	nop
        n++;
40000ba0:	83 c0 01             	add    $0x1,%eax
    for (n = 0; *s != '\0'; s++)
40000ba3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
40000ba7:	75 f7                	jne    40000ba0 <strlen+0x10>
40000ba9:	c3                   	ret    
40000baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return n;
}
40000bb0:	c3                   	ret    
40000bb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000bb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000bbf:	90                   	nop

40000bc0 <strnlen>:

int strnlen(const char *s, size_t size)
{
40000bc0:	8b 54 24 08          	mov    0x8(%esp),%edx
40000bc4:	8b 4c 24 04          	mov    0x4(%esp),%ecx
    int n;

    for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000bc8:	31 c0                	xor    %eax,%eax
40000bca:	85 d2                	test   %edx,%edx
40000bcc:	75 09                	jne    40000bd7 <strnlen+0x17>
40000bce:	eb 10                	jmp    40000be0 <strnlen+0x20>
        n++;
40000bd0:	83 c0 01             	add    $0x1,%eax
    for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000bd3:	39 d0                	cmp    %edx,%eax
40000bd5:	74 09                	je     40000be0 <strnlen+0x20>
40000bd7:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
40000bdb:	75 f3                	jne    40000bd0 <strnlen+0x10>
40000bdd:	c3                   	ret    
40000bde:	66 90                	xchg   %ax,%ax
    return n;
}
40000be0:	c3                   	ret    
40000be1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000be8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000bef:	90                   	nop

40000bf0 <strcpy>:

char *strcpy(char *dst, const char *src)
{
40000bf0:	53                   	push   %ebx
40000bf1:	8b 4c 24 08          	mov    0x8(%esp),%ecx
    char *ret;

    ret = dst;
    while ((*dst++ = *src++) != '\0')
40000bf5:	31 c0                	xor    %eax,%eax
{
40000bf7:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40000bfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000bff:	90                   	nop
    while ((*dst++ = *src++) != '\0')
40000c00:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
40000c04:	88 14 01             	mov    %dl,(%ecx,%eax,1)
40000c07:	83 c0 01             	add    $0x1,%eax
40000c0a:	84 d2                	test   %dl,%dl
40000c0c:	75 f2                	jne    40000c00 <strcpy+0x10>
        /* do nothing */ ;
    return ret;
}
40000c0e:	89 c8                	mov    %ecx,%eax
40000c10:	5b                   	pop    %ebx
40000c11:	c3                   	ret    
40000c12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000c20 <strncpy>:

char *strncpy(char *dst, const char *src, size_t size)
{
40000c20:	56                   	push   %esi
40000c21:	53                   	push   %ebx
40000c22:	8b 5c 24 14          	mov    0x14(%esp),%ebx
40000c26:	8b 74 24 0c          	mov    0xc(%esp),%esi
40000c2a:	8b 54 24 10          	mov    0x10(%esp),%edx
    size_t i;
    char *ret;

    ret = dst;
    for (i = 0; i < size; i++) {
40000c2e:	85 db                	test   %ebx,%ebx
40000c30:	74 21                	je     40000c53 <strncpy+0x33>
40000c32:	01 f3                	add    %esi,%ebx
40000c34:	89 f0                	mov    %esi,%eax
40000c36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000c3d:	8d 76 00             	lea    0x0(%esi),%esi
        *dst++ = *src;
40000c40:	0f b6 0a             	movzbl (%edx),%ecx
40000c43:	83 c0 01             	add    $0x1,%eax
        // If strlen(src) < size, null-pad 'dst' out to 'size' chars
        if (*src != '\0')
            src++;
40000c46:	80 f9 01             	cmp    $0x1,%cl
        *dst++ = *src;
40000c49:	88 48 ff             	mov    %cl,-0x1(%eax)
            src++;
40000c4c:	83 da ff             	sbb    $0xffffffff,%edx
    for (i = 0; i < size; i++) {
40000c4f:	39 d8                	cmp    %ebx,%eax
40000c51:	75 ed                	jne    40000c40 <strncpy+0x20>
    }
    return ret;
}
40000c53:	89 f0                	mov    %esi,%eax
40000c55:	5b                   	pop    %ebx
40000c56:	5e                   	pop    %esi
40000c57:	c3                   	ret    
40000c58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000c5f:	90                   	nop

40000c60 <strlcpy>:

size_t strlcpy(char *dst, const char *src, size_t size)
{
40000c60:	53                   	push   %ebx
40000c61:	8b 44 24 10          	mov    0x10(%esp),%eax
40000c65:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    char *dst_in;

    dst_in = dst;
    if (size > 0) {
40000c69:	85 c0                	test   %eax,%eax
40000c6b:	74 30                	je     40000c9d <strlcpy+0x3d>
        while (--size > 0 && *src != '\0')
40000c6d:	8b 54 24 08          	mov    0x8(%esp),%edx
40000c71:	83 e8 01             	sub    $0x1,%eax
40000c74:	74 24                	je     40000c9a <strlcpy+0x3a>
40000c76:	01 d0                	add    %edx,%eax
40000c78:	89 c3                	mov    %eax,%ebx
40000c7a:	eb 11                	jmp    40000c8d <strlcpy+0x2d>
40000c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            *dst++ = *src++;
40000c80:	83 c2 01             	add    $0x1,%edx
40000c83:	83 c1 01             	add    $0x1,%ecx
40000c86:	88 42 ff             	mov    %al,-0x1(%edx)
        while (--size > 0 && *src != '\0')
40000c89:	39 da                	cmp    %ebx,%edx
40000c8b:	74 07                	je     40000c94 <strlcpy+0x34>
40000c8d:	0f b6 01             	movzbl (%ecx),%eax
40000c90:	84 c0                	test   %al,%al
40000c92:	75 ec                	jne    40000c80 <strlcpy+0x20>
        *dst = '\0';
    }
    return dst - dst_in;
40000c94:	89 d0                	mov    %edx,%eax
40000c96:	2b 44 24 08          	sub    0x8(%esp),%eax
        *dst = '\0';
40000c9a:	c6 02 00             	movb   $0x0,(%edx)
}
40000c9d:	5b                   	pop    %ebx
40000c9e:	c3                   	ret    
40000c9f:	90                   	nop

40000ca0 <strcmp>:

int strcmp(const char *p, const char *q)
{
40000ca0:	53                   	push   %ebx
40000ca1:	8b 54 24 08          	mov    0x8(%esp),%edx
40000ca5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    while (*p && *p == *q)
40000ca9:	0f b6 02             	movzbl (%edx),%eax
40000cac:	84 c0                	test   %al,%al
40000cae:	75 18                	jne    40000cc8 <strcmp+0x28>
40000cb0:	eb 30                	jmp    40000ce2 <strcmp+0x42>
40000cb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000cb8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        p++, q++;
40000cbc:	83 c2 01             	add    $0x1,%edx
40000cbf:	8d 59 01             	lea    0x1(%ecx),%ebx
    while (*p && *p == *q)
40000cc2:	84 c0                	test   %al,%al
40000cc4:	74 12                	je     40000cd8 <strcmp+0x38>
        p++, q++;
40000cc6:	89 d9                	mov    %ebx,%ecx
    while (*p && *p == *q)
40000cc8:	0f b6 19             	movzbl (%ecx),%ebx
40000ccb:	38 c3                	cmp    %al,%bl
40000ccd:	74 e9                	je     40000cb8 <strcmp+0x18>
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000ccf:	29 d8                	sub    %ebx,%eax
}
40000cd1:	5b                   	pop    %ebx
40000cd2:	c3                   	ret    
40000cd3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000cd7:	90                   	nop
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000cd8:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
40000cdc:	31 c0                	xor    %eax,%eax
40000cde:	29 d8                	sub    %ebx,%eax
}
40000ce0:	5b                   	pop    %ebx
40000ce1:	c3                   	ret    
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000ce2:	0f b6 19             	movzbl (%ecx),%ebx
40000ce5:	31 c0                	xor    %eax,%eax
40000ce7:	eb e6                	jmp    40000ccf <strcmp+0x2f>
40000ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000cf0 <strncmp>:

int strncmp(const char *p, const char *q, size_t n)
{
40000cf0:	56                   	push   %esi
40000cf1:	53                   	push   %ebx
40000cf2:	8b 74 24 14          	mov    0x14(%esp),%esi
40000cf6:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000cfa:	8b 44 24 10          	mov    0x10(%esp),%eax
    while (n > 0 && *p && *p == *q)
40000cfe:	85 f6                	test   %esi,%esi
40000d00:	74 2e                	je     40000d30 <strncmp+0x40>
40000d02:	01 c6                	add    %eax,%esi
40000d04:	eb 18                	jmp    40000d1e <strncmp+0x2e>
40000d06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000d0d:	8d 76 00             	lea    0x0(%esi),%esi
40000d10:	38 da                	cmp    %bl,%dl
40000d12:	75 14                	jne    40000d28 <strncmp+0x38>
        n--, p++, q++;
40000d14:	83 c0 01             	add    $0x1,%eax
40000d17:	83 c1 01             	add    $0x1,%ecx
    while (n > 0 && *p && *p == *q)
40000d1a:	39 f0                	cmp    %esi,%eax
40000d1c:	74 12                	je     40000d30 <strncmp+0x40>
40000d1e:	0f b6 11             	movzbl (%ecx),%edx
40000d21:	0f b6 18             	movzbl (%eax),%ebx
40000d24:	84 d2                	test   %dl,%dl
40000d26:	75 e8                	jne    40000d10 <strncmp+0x20>
    if (n == 0)
        return 0;
    else
        return (int) ((unsigned char) *p - (unsigned char) *q);
40000d28:	0f b6 c2             	movzbl %dl,%eax
40000d2b:	29 d8                	sub    %ebx,%eax
}
40000d2d:	5b                   	pop    %ebx
40000d2e:	5e                   	pop    %esi
40000d2f:	c3                   	ret    
        return 0;
40000d30:	31 c0                	xor    %eax,%eax
}
40000d32:	5b                   	pop    %ebx
40000d33:	5e                   	pop    %esi
40000d34:	c3                   	ret    
40000d35:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000d40 <strchr>:

char *strchr(const char *s, char c)
{
40000d40:	8b 44 24 04          	mov    0x4(%esp),%eax
40000d44:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
    for (; *s; s++)
40000d49:	0f b6 10             	movzbl (%eax),%edx
40000d4c:	84 d2                	test   %dl,%dl
40000d4e:	75 13                	jne    40000d63 <strchr+0x23>
40000d50:	eb 1e                	jmp    40000d70 <strchr+0x30>
40000d52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000d58:	0f b6 50 01          	movzbl 0x1(%eax),%edx
40000d5c:	83 c0 01             	add    $0x1,%eax
40000d5f:	84 d2                	test   %dl,%dl
40000d61:	74 0d                	je     40000d70 <strchr+0x30>
        if (*s == c)
40000d63:	38 d1                	cmp    %dl,%cl
40000d65:	75 f1                	jne    40000d58 <strchr+0x18>
            return (char *) s;
    return 0;
}
40000d67:	c3                   	ret    
40000d68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000d6f:	90                   	nop
    return 0;
40000d70:	31 c0                	xor    %eax,%eax
}
40000d72:	c3                   	ret    
40000d73:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000d80 <strfind>:

char *strfind(const char *s, char c)
{
40000d80:	53                   	push   %ebx
40000d81:	8b 44 24 08          	mov    0x8(%esp),%eax
40000d85:	8b 54 24 0c          	mov    0xc(%esp),%edx
    for (; *s; s++)
40000d89:	0f b6 18             	movzbl (%eax),%ebx
        if (*s == c)
40000d8c:	38 d3                	cmp    %dl,%bl
40000d8e:	74 1f                	je     40000daf <strfind+0x2f>
40000d90:	89 d1                	mov    %edx,%ecx
40000d92:	84 db                	test   %bl,%bl
40000d94:	75 0e                	jne    40000da4 <strfind+0x24>
40000d96:	eb 17                	jmp    40000daf <strfind+0x2f>
40000d98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000d9f:	90                   	nop
40000da0:	84 d2                	test   %dl,%dl
40000da2:	74 0b                	je     40000daf <strfind+0x2f>
    for (; *s; s++)
40000da4:	0f b6 50 01          	movzbl 0x1(%eax),%edx
40000da8:	83 c0 01             	add    $0x1,%eax
        if (*s == c)
40000dab:	38 ca                	cmp    %cl,%dl
40000dad:	75 f1                	jne    40000da0 <strfind+0x20>
            break;
    return (char *) s;
}
40000daf:	5b                   	pop    %ebx
40000db0:	c3                   	ret    
40000db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000db8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000dbf:	90                   	nop

40000dc0 <strtol>:

long strtol(const char *s, char **endptr, int base)
{
40000dc0:	55                   	push   %ebp
40000dc1:	57                   	push   %edi
40000dc2:	56                   	push   %esi
40000dc3:	53                   	push   %ebx
40000dc4:	8b 54 24 14          	mov    0x14(%esp),%edx
40000dc8:	8b 74 24 18          	mov    0x18(%esp),%esi
40000dcc:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
40000dd0:	0f b6 02             	movzbl (%edx),%eax
40000dd3:	3c 09                	cmp    $0x9,%al
40000dd5:	74 09                	je     40000de0 <strtol+0x20>
40000dd7:	3c 20                	cmp    $0x20,%al
40000dd9:	75 14                	jne    40000def <strtol+0x2f>
40000ddb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000ddf:	90                   	nop
40000de0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        s++;
40000de4:	83 c2 01             	add    $0x1,%edx
    while (*s == ' ' || *s == '\t')
40000de7:	3c 20                	cmp    $0x20,%al
40000de9:	74 f5                	je     40000de0 <strtol+0x20>
40000deb:	3c 09                	cmp    $0x9,%al
40000ded:	74 f1                	je     40000de0 <strtol+0x20>

    // plus/minus sign
    if (*s == '+')
40000def:	3c 2b                	cmp    $0x2b,%al
40000df1:	0f 84 99 00 00 00    	je     40000e90 <strtol+0xd0>
    int neg = 0;
40000df7:	31 ff                	xor    %edi,%edi
        s++;
    else if (*s == '-')
40000df9:	3c 2d                	cmp    $0x2d,%al
40000dfb:	0f 84 7f 00 00 00    	je     40000e80 <strtol+0xc0>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000e01:	0f b6 2a             	movzbl (%edx),%ebp
40000e04:	f7 c3 ef ff ff ff    	test   $0xffffffef,%ebx
40000e0a:	75 13                	jne    40000e1f <strtol+0x5f>
40000e0c:	89 e8                	mov    %ebp,%eax
40000e0e:	3c 30                	cmp    $0x30,%al
40000e10:	0f 84 8a 00 00 00    	je     40000ea0 <strtol+0xe0>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
40000e16:	85 db                	test   %ebx,%ebx
40000e18:	75 05                	jne    40000e1f <strtol+0x5f>
        s++, base = 8;
    else if (base == 0)
        base = 10;
40000e1a:	bb 0a 00 00 00       	mov    $0xa,%ebx
40000e1f:	31 c9                	xor    %ecx,%ecx
40000e21:	eb 22                	jmp    40000e45 <strtol+0x85>
40000e23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000e27:	90                   	nop
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
40000e28:	8d 45 9f             	lea    -0x61(%ebp),%eax
40000e2b:	3c 19                	cmp    $0x19,%al
40000e2d:	77 41                	ja     40000e70 <strtol+0xb0>
            dig = *s - 'a' + 10;
40000e2f:	8d 45 a9             	lea    -0x57(%ebp),%eax
40000e32:	0f be c0             	movsbl %al,%eax
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
40000e35:	39 d8                	cmp    %ebx,%eax
40000e37:	7d 1a                	jge    40000e53 <strtol+0x93>
            break;
        s++, val = (val * base) + dig;
40000e39:	0f af cb             	imul   %ebx,%ecx
        if (*s >= '0' && *s <= '9')
40000e3c:	0f b6 6a 01          	movzbl 0x1(%edx),%ebp
        s++, val = (val * base) + dig;
40000e40:	83 c2 01             	add    $0x1,%edx
40000e43:	01 c1                	add    %eax,%ecx
        if (*s >= '0' && *s <= '9')
40000e45:	8d 45 d0             	lea    -0x30(%ebp),%eax
40000e48:	3c 09                	cmp    $0x9,%al
40000e4a:	77 dc                	ja     40000e28 <strtol+0x68>
            dig = *s - 'A' + 10;
40000e4c:	0f be c0             	movsbl %al,%eax
        if (dig >= base)
40000e4f:	39 d8                	cmp    %ebx,%eax
40000e51:	7c e6                	jl     40000e39 <strtol+0x79>
        // we don't properly detect overflow!
    }

    if (endptr)
40000e53:	85 f6                	test   %esi,%esi
40000e55:	74 02                	je     40000e59 <strtol+0x99>
        *endptr = (char *) s;
40000e57:	89 16                	mov    %edx,(%esi)
    return (neg ? -val : val);
40000e59:	89 c8                	mov    %ecx,%eax
}
40000e5b:	5b                   	pop    %ebx
40000e5c:	5e                   	pop    %esi
    return (neg ? -val : val);
40000e5d:	f7 d8                	neg    %eax
40000e5f:	85 ff                	test   %edi,%edi
}
40000e61:	5f                   	pop    %edi
40000e62:	5d                   	pop    %ebp
    return (neg ? -val : val);
40000e63:	0f 45 c8             	cmovne %eax,%ecx
}
40000e66:	89 c8                	mov    %ecx,%eax
40000e68:	c3                   	ret    
40000e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        else if (*s >= 'A' && *s <= 'Z')
40000e70:	8d 45 bf             	lea    -0x41(%ebp),%eax
40000e73:	3c 19                	cmp    $0x19,%al
40000e75:	77 dc                	ja     40000e53 <strtol+0x93>
            dig = *s - 'A' + 10;
40000e77:	8d 45 c9             	lea    -0x37(%ebp),%eax
40000e7a:	0f be c0             	movsbl %al,%eax
40000e7d:	eb d0                	jmp    40000e4f <strtol+0x8f>
40000e7f:	90                   	nop
        s++, neg = 1;
40000e80:	83 c2 01             	add    $0x1,%edx
40000e83:	bf 01 00 00 00       	mov    $0x1,%edi
40000e88:	e9 74 ff ff ff       	jmp    40000e01 <strtol+0x41>
40000e8d:	8d 76 00             	lea    0x0(%esi),%esi
        s++;
40000e90:	83 c2 01             	add    $0x1,%edx
    int neg = 0;
40000e93:	31 ff                	xor    %edi,%edi
40000e95:	e9 67 ff ff ff       	jmp    40000e01 <strtol+0x41>
40000e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000ea0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
40000ea4:	3c 78                	cmp    $0x78,%al
40000ea6:	74 17                	je     40000ebf <strtol+0xff>
    else if (base == 0 && s[0] == '0')
40000ea8:	85 db                	test   %ebx,%ebx
40000eaa:	0f 85 6f ff ff ff    	jne    40000e1f <strtol+0x5f>
        s++, base = 8;
40000eb0:	83 c2 01             	add    $0x1,%edx
40000eb3:	89 c5                	mov    %eax,%ebp
40000eb5:	bb 08 00 00 00       	mov    $0x8,%ebx
40000eba:	e9 60 ff ff ff       	jmp    40000e1f <strtol+0x5f>
        if (*s >= '0' && *s <= '9')
40000ebf:	0f b6 6a 02          	movzbl 0x2(%edx),%ebp
        s += 2, base = 16;
40000ec3:	bb 10 00 00 00       	mov    $0x10,%ebx
40000ec8:	83 c2 02             	add    $0x2,%edx
40000ecb:	e9 4f ff ff ff       	jmp    40000e1f <strtol+0x5f>

40000ed0 <memset>:

void *memset(void *v, int c, size_t n)
{
40000ed0:	57                   	push   %edi
40000ed1:	56                   	push   %esi
40000ed2:	53                   	push   %ebx
40000ed3:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000ed7:	8b 7c 24 10          	mov    0x10(%esp),%edi
    if (n == 0)
40000edb:	85 c9                	test   %ecx,%ecx
40000edd:	74 28                	je     40000f07 <memset+0x37>
        return v;
    if ((int) v % 4 == 0 && n % 4 == 0) {
40000edf:	89 f8                	mov    %edi,%eax
40000ee1:	09 c8                	or     %ecx,%eax
40000ee3:	a8 03                	test   $0x3,%al
40000ee5:	75 29                	jne    40000f10 <memset+0x40>
        c &= 0xFF;
40000ee7:	0f b6 5c 24 14       	movzbl 0x14(%esp),%ebx
        c = (c << 24) | (c << 16) | (c << 8) | c;
        asm volatile ("cld; rep stosl\n"
                      :: "D" (v), "a" (c), "c" (n / 4)
40000eec:	c1 e9 02             	shr    $0x2,%ecx
        c = (c << 24) | (c << 16) | (c << 8) | c;
40000eef:	89 da                	mov    %ebx,%edx
40000ef1:	89 de                	mov    %ebx,%esi
40000ef3:	89 d8                	mov    %ebx,%eax
40000ef5:	c1 e2 18             	shl    $0x18,%edx
40000ef8:	c1 e6 10             	shl    $0x10,%esi
40000efb:	09 f2                	or     %esi,%edx
40000efd:	c1 e0 08             	shl    $0x8,%eax
40000f00:	09 da                	or     %ebx,%edx
40000f02:	09 d0                	or     %edx,%eax
        asm volatile ("cld; rep stosl\n"
40000f04:	fc                   	cld    
40000f05:	f3 ab                	rep stos %eax,%es:(%edi)
    } else
        asm volatile ("cld; rep stosb\n"
                      :: "D" (v), "a" (c), "c" (n)
                      : "cc", "memory");
    return v;
}
40000f07:	89 f8                	mov    %edi,%eax
40000f09:	5b                   	pop    %ebx
40000f0a:	5e                   	pop    %esi
40000f0b:	5f                   	pop    %edi
40000f0c:	c3                   	ret    
40000f0d:	8d 76 00             	lea    0x0(%esi),%esi
        asm volatile ("cld; rep stosb\n"
40000f10:	8b 44 24 14          	mov    0x14(%esp),%eax
40000f14:	fc                   	cld    
40000f15:	f3 aa                	rep stos %al,%es:(%edi)
}
40000f17:	89 f8                	mov    %edi,%eax
40000f19:	5b                   	pop    %ebx
40000f1a:	5e                   	pop    %esi
40000f1b:	5f                   	pop    %edi
40000f1c:	c3                   	ret    
40000f1d:	8d 76 00             	lea    0x0(%esi),%esi

40000f20 <memmove>:

void *memmove(void *dst, const void *src, size_t n)
{
40000f20:	57                   	push   %edi
40000f21:	56                   	push   %esi
40000f22:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000f26:	8b 74 24 10          	mov    0x10(%esp),%esi
40000f2a:	8b 4c 24 14          	mov    0x14(%esp),%ecx
    const char *s;
    char *d;

    s = src;
    d = dst;
    if (s < d && s + n > d) {
40000f2e:	39 c6                	cmp    %eax,%esi
40000f30:	73 26                	jae    40000f58 <memmove+0x38>
40000f32:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
40000f35:	39 c2                	cmp    %eax,%edx
40000f37:	76 1f                	jbe    40000f58 <memmove+0x38>
        s += n;
        d += n;
40000f39:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
40000f3c:	89 d6                	mov    %edx,%esi
40000f3e:	09 fe                	or     %edi,%esi
40000f40:	09 ce                	or     %ecx,%esi
40000f42:	83 e6 03             	and    $0x3,%esi
40000f45:	74 39                	je     40000f80 <memmove+0x60>
            asm volatile ("std; rep movsl\n"
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
                          : "cc", "memory");
        else
            asm volatile ("std; rep movsb\n"
                          :: "D" (d - 1), "S" (s - 1), "c" (n)
40000f47:	83 ef 01             	sub    $0x1,%edi
40000f4a:	8d 72 ff             	lea    -0x1(%edx),%esi
            asm volatile ("std; rep movsb\n"
40000f4d:	fd                   	std    
40000f4e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
                          : "cc", "memory");
        // Some versions of GCC rely on DF being clear
        asm volatile ("cld" ::: "cc");
40000f50:	fc                   	cld    
            asm volatile ("cld; rep movsb\n"
                          :: "D" (d), "S" (s), "c" (n)
                          : "cc", "memory");
    }
    return dst;
}
40000f51:	5e                   	pop    %esi
40000f52:	5f                   	pop    %edi
40000f53:	c3                   	ret    
40000f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
40000f58:	89 f2                	mov    %esi,%edx
40000f5a:	09 c2                	or     %eax,%edx
40000f5c:	09 ca                	or     %ecx,%edx
40000f5e:	83 e2 03             	and    $0x3,%edx
40000f61:	74 0d                	je     40000f70 <memmove+0x50>
            asm volatile ("cld; rep movsb\n"
40000f63:	89 c7                	mov    %eax,%edi
40000f65:	fc                   	cld    
40000f66:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
}
40000f68:	5e                   	pop    %esi
40000f69:	5f                   	pop    %edi
40000f6a:	c3                   	ret    
40000f6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40000f6f:	90                   	nop
                          :: "D" (d), "S" (s), "c" (n / 4)
40000f70:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("cld; rep movsl\n"
40000f73:	89 c7                	mov    %eax,%edi
40000f75:	fc                   	cld    
40000f76:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000f78:	eb ee                	jmp    40000f68 <memmove+0x48>
40000f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
40000f80:	83 ef 04             	sub    $0x4,%edi
40000f83:	8d 72 fc             	lea    -0x4(%edx),%esi
40000f86:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("std; rep movsl\n"
40000f89:	fd                   	std    
40000f8a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000f8c:	eb c2                	jmp    40000f50 <memmove+0x30>
40000f8e:	66 90                	xchg   %ax,%ax

40000f90 <memcpy>:

void *memcpy(void *dst, const void *src, size_t n)
{
    return memmove(dst, src, n);
40000f90:	eb 8e                	jmp    40000f20 <memmove>
40000f92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000fa0 <memcmp>:
}

int memcmp(const void *v1, const void *v2, size_t n)
{
40000fa0:	56                   	push   %esi
40000fa1:	53                   	push   %ebx
40000fa2:	8b 74 24 14          	mov    0x14(%esp),%esi
40000fa6:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000faa:	8b 44 24 10          	mov    0x10(%esp),%eax
    const uint8_t *s1 = (const uint8_t *) v1;
    const uint8_t *s2 = (const uint8_t *) v2;

    while (n-- > 0) {
40000fae:	85 f6                	test   %esi,%esi
40000fb0:	74 2e                	je     40000fe0 <memcmp+0x40>
40000fb2:	01 c6                	add    %eax,%esi
40000fb4:	eb 14                	jmp    40000fca <memcmp+0x2a>
40000fb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000fbd:	8d 76 00             	lea    0x0(%esi),%esi
        if (*s1 != *s2)
            return (int) *s1 - (int) *s2;
        s1++, s2++;
40000fc0:	83 c0 01             	add    $0x1,%eax
40000fc3:	83 c2 01             	add    $0x1,%edx
    while (n-- > 0) {
40000fc6:	39 f0                	cmp    %esi,%eax
40000fc8:	74 16                	je     40000fe0 <memcmp+0x40>
        if (*s1 != *s2)
40000fca:	0f b6 0a             	movzbl (%edx),%ecx
40000fcd:	0f b6 18             	movzbl (%eax),%ebx
40000fd0:	38 d9                	cmp    %bl,%cl
40000fd2:	74 ec                	je     40000fc0 <memcmp+0x20>
            return (int) *s1 - (int) *s2;
40000fd4:	0f b6 c1             	movzbl %cl,%eax
40000fd7:	29 d8                	sub    %ebx,%eax
    }

    return 0;
}
40000fd9:	5b                   	pop    %ebx
40000fda:	5e                   	pop    %esi
40000fdb:	c3                   	ret    
40000fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
40000fe0:	31 c0                	xor    %eax,%eax
}
40000fe2:	5b                   	pop    %ebx
40000fe3:	5e                   	pop    %esi
40000fe4:	c3                   	ret    
40000fe5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40000fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000ff0 <memchr>:

void *memchr(const void *s, int c, size_t n)
{
40000ff0:	8b 44 24 04          	mov    0x4(%esp),%eax
    const void *ends = (const char *) s + n;
40000ff4:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000ff8:	01 c2                	add    %eax,%edx
    for (; s < ends; s++)
40000ffa:	39 d0                	cmp    %edx,%eax
40000ffc:	73 1a                	jae    40001018 <memchr+0x28>
        if (*(const unsigned char *) s == (unsigned char) c)
40000ffe:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
40001003:	eb 0a                	jmp    4000100f <memchr+0x1f>
40001005:	8d 76 00             	lea    0x0(%esi),%esi
    for (; s < ends; s++)
40001008:	83 c0 01             	add    $0x1,%eax
4000100b:	39 c2                	cmp    %eax,%edx
4000100d:	74 09                	je     40001018 <memchr+0x28>
        if (*(const unsigned char *) s == (unsigned char) c)
4000100f:	38 08                	cmp    %cl,(%eax)
40001011:	75 f5                	jne    40001008 <memchr+0x18>
            return (void *) s;
    return NULL;
}
40001013:	c3                   	ret    
40001014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return NULL;
40001018:	31 c0                	xor    %eax,%eax
}
4000101a:	c3                   	ret    
4000101b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
4000101f:	90                   	nop

40001020 <memzero>:

void *memzero(void *v, size_t n)
{
40001020:	57                   	push   %edi
40001021:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40001025:	8b 7c 24 08          	mov    0x8(%esp),%edi
    if (n == 0)
40001029:	85 c9                	test   %ecx,%ecx
4000102b:	74 0f                	je     4000103c <memzero+0x1c>
    if ((int) v % 4 == 0 && n % 4 == 0) {
4000102d:	89 f8                	mov    %edi,%eax
4000102f:	09 c8                	or     %ecx,%eax
40001031:	83 e0 03             	and    $0x3,%eax
40001034:	75 0a                	jne    40001040 <memzero+0x20>
                      :: "D" (v), "a" (c), "c" (n / 4)
40001036:	c1 e9 02             	shr    $0x2,%ecx
        asm volatile ("cld; rep stosl\n"
40001039:	fc                   	cld    
4000103a:	f3 ab                	rep stos %eax,%es:(%edi)
    return memset(v, 0, n);
}
4000103c:	89 f8                	mov    %edi,%eax
4000103e:	5f                   	pop    %edi
4000103f:	c3                   	ret    
        asm volatile ("cld; rep stosb\n"
40001040:	31 c0                	xor    %eax,%eax
40001042:	fc                   	cld    
40001043:	f3 aa                	rep stos %al,%es:(%edi)
}
40001045:	89 f8                	mov    %edi,%eax
40001047:	5f                   	pop    %edi
40001048:	c3                   	ret    
40001049:	66 90                	xchg   %ax,%ax
4000104b:	66 90                	xchg   %ax,%ax
4000104d:	66 90                	xchg   %ax,%ax
4000104f:	90                   	nop

40001050 <smallfile>:
{
40001050:	55                   	push   %ebp
40001051:	57                   	push   %edi
40001052:	56                   	push   %esi
40001053:	e8 03 1b 00 00       	call   40002b5b <__x86.get_pc_thunk.si>
40001058:	81 c6 a8 5f 00 00    	add    $0x5fa8,%esi
4000105e:	53                   	push   %ebx
4000105f:	83 ec 28             	sub    $0x28,%esp
    printf("=====small file test=====\n");
40001062:	8d 86 94 c1 ff ff    	lea    -0x3e6c(%esi),%eax
40001068:	89 74 24 14          	mov    %esi,0x14(%esp)
4000106c:	89 f3                	mov    %esi,%ebx
4000106e:	50                   	push   %eax
4000106f:	e8 cc f2 ff ff       	call   40000340 <printf>
    asm volatile ("int %2"
40001074:	8d 9e af c1 ff ff    	lea    -0x3e51(%esi),%ebx
4000107a:	b8 03 00 00 00       	mov    $0x3,%eax
4000107f:	b9 02 02 00 00       	mov    $0x202,%ecx
40001084:	89 5c 24 1c          	mov    %ebx,0x1c(%esp)
40001088:	cd 30                	int    $0x30
    return errno ? -1 : fd;
4000108a:	83 c4 10             	add    $0x10,%esp
    if (fd >= 0) {
4000108d:	85 c0                	test   %eax,%eax
4000108f:	0f 85 9b 00 00 00    	jne    40001130 <smallfile+0xe0>
40001095:	89 df                	mov    %ebx,%edi
40001097:	85 db                	test   %ebx,%ebx
40001099:	0f 88 91 00 00 00    	js     40001130 <smallfile+0xe0>
        printf("create small succeeded; ok, fd: %d\n", fd);
4000109f:	83 ec 08             	sub    $0x8,%esp
400010a2:	8d 86 f4 cb ff ff    	lea    -0x340c(%esi),%eax
    for (i = 0; i < 100; i++) {
400010a8:	31 ed                	xor    %ebp,%ebp
        printf("create small succeeded; ok, fd: %d\n", fd);
400010aa:	53                   	push   %ebx
400010ab:	89 f3                	mov    %esi,%ebx
400010ad:	50                   	push   %eax
400010ae:	e8 8d f2 ff ff       	call   40000340 <printf>
400010b3:	83 c4 10             	add    $0x10,%esp
400010b6:	8d 86 d2 c1 ff ff    	lea    -0x3e2e(%esi),%eax
400010bc:	89 04 24             	mov    %eax,(%esp)
    asm volatile ("int %2"
400010bf:	8d 86 dd c1 ff ff    	lea    -0x3e23(%esi),%eax
400010c5:	89 44 24 04          	mov    %eax,0x4(%esp)
400010c9:	eb 27                	jmp    400010f2 <smallfile+0xa2>
400010cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
400010cf:	90                   	nop
        if (write(fd, "aaaaaaaaaa", 10) != 10) {
400010d0:	85 c0                	test   %eax,%eax
400010d2:	75 36                	jne    4000110a <smallfile+0xba>
400010d4:	8b 4c 24 04          	mov    0x4(%esp),%ecx
400010d8:	b8 06 00 00 00       	mov    $0x6,%eax
400010dd:	89 fb                	mov    %edi,%ebx
400010df:	cd 30                	int    $0x30
        if (write(fd, "bbbbbbbbbb", 10) != 10) {
400010e1:	83 fb 0a             	cmp    $0xa,%ebx
400010e4:	75 6a                	jne    40001150 <smallfile+0x100>
400010e6:	85 c0                	test   %eax,%eax
400010e8:	75 66                	jne    40001150 <smallfile+0x100>
    for (i = 0; i < 100; i++) {
400010ea:	83 c5 01             	add    $0x1,%ebp
400010ed:	83 fd 64             	cmp    $0x64,%ebp
400010f0:	74 7e                	je     40001170 <smallfile+0x120>
400010f2:	be 0a 00 00 00       	mov    $0xa,%esi
400010f7:	8b 0c 24             	mov    (%esp),%ecx
400010fa:	b8 06 00 00 00       	mov    $0x6,%eax
400010ff:	89 fb                	mov    %edi,%ebx
40001101:	89 f2                	mov    %esi,%edx
40001103:	cd 30                	int    $0x30
        if (write(fd, "aaaaaaaaaa", 10) != 10) {
40001105:	83 fb 0a             	cmp    $0xa,%ebx
40001108:	74 c6                	je     400010d0 <smallfile+0x80>
            printf("error: write aa %d new file failed\n", i);
4000110a:	83 ec 08             	sub    $0x8,%esp
4000110d:	55                   	push   %ebp
4000110e:	8b 5c 24 14          	mov    0x14(%esp),%ebx
40001112:	8d 83 18 cc ff ff    	lea    -0x33e8(%ebx),%eax
40001118:	50                   	push   %eax
40001119:	e8 22 f2 ff ff       	call   40000340 <printf>
            exit();
4000111e:	83 c4 10             	add    $0x10,%esp
}
40001121:	83 c4 1c             	add    $0x1c,%esp
40001124:	5b                   	pop    %ebx
40001125:	5e                   	pop    %esi
40001126:	5f                   	pop    %edi
40001127:	5d                   	pop    %ebp
40001128:	c3                   	ret    
40001129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf("error: create small failed!\n");
40001130:	83 ec 0c             	sub    $0xc,%esp
40001133:	8b 5c 24 14          	mov    0x14(%esp),%ebx
40001137:	8d 83 b5 c1 ff ff    	lea    -0x3e4b(%ebx),%eax
4000113d:	50                   	push   %eax
4000113e:	e8 fd f1 ff ff       	call   40000340 <printf>
        exit();
40001143:	83 c4 10             	add    $0x10,%esp
}
40001146:	83 c4 1c             	add    $0x1c,%esp
40001149:	5b                   	pop    %ebx
4000114a:	5e                   	pop    %esi
4000114b:	5f                   	pop    %edi
4000114c:	5d                   	pop    %ebp
4000114d:	c3                   	ret    
4000114e:	66 90                	xchg   %ax,%ax
            printf("error: write bb %d new file failed\n", i);
40001150:	83 ec 08             	sub    $0x8,%esp
40001153:	55                   	push   %ebp
40001154:	8b 5c 24 14          	mov    0x14(%esp),%ebx
40001158:	8d 83 3c cc ff ff    	lea    -0x33c4(%ebx),%eax
4000115e:	50                   	push   %eax
4000115f:	e8 dc f1 ff ff       	call   40000340 <printf>
            exit();
40001164:	83 c4 10             	add    $0x10,%esp
}
40001167:	83 c4 1c             	add    $0x1c,%esp
4000116a:	5b                   	pop    %ebx
4000116b:	5e                   	pop    %esi
4000116c:	5f                   	pop    %edi
4000116d:	5d                   	pop    %ebp
4000116e:	c3                   	ret    
4000116f:	90                   	nop
    printf("writes ok\n");
40001170:	83 ec 0c             	sub    $0xc,%esp
40001173:	8b 6c 24 14          	mov    0x14(%esp),%ebp
40001177:	8d 85 e8 c1 ff ff    	lea    -0x3e18(%ebp),%eax
4000117d:	89 eb                	mov    %ebp,%ebx
4000117f:	50                   	push   %eax
40001180:	e8 bb f1 ff ff       	call   40000340 <printf>
    asm volatile ("int %2"
40001185:	b8 04 00 00 00       	mov    $0x4,%eax
4000118a:	89 fb                	mov    %edi,%ebx
4000118c:	cd 30                	int    $0x30
    asm volatile ("int %2"
4000118e:	b8 03 00 00 00       	mov    $0x3,%eax
40001193:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
40001197:	31 c9                	xor    %ecx,%ecx
40001199:	cd 30                	int    $0x30
4000119b:	89 df                	mov    %ebx,%edi
    return errno ? -1 : fd;
4000119d:	83 c4 10             	add    $0x10,%esp
    if (fd >= 0) {
400011a0:	85 c0                	test   %eax,%eax
400011a2:	75 7e                	jne    40001222 <smallfile+0x1d2>
400011a4:	85 db                	test   %ebx,%ebx
400011a6:	78 7a                	js     40001222 <smallfile+0x1d2>
        printf("open small succeeded ok\n");
400011a8:	83 ec 0c             	sub    $0xc,%esp
400011ab:	8d 85 f3 c1 ff ff    	lea    -0x3e0d(%ebp),%eax
400011b1:	89 eb                	mov    %ebp,%ebx
400011b3:	50                   	push   %eax
400011b4:	e8 87 f1 ff ff       	call   40000340 <printf>
    asm volatile ("int %2"
400011b9:	b8 05 00 00 00       	mov    $0x5,%eax
400011be:	8d 8d 40 00 00 00    	lea    0x40(%ebp),%ecx
400011c4:	89 fb                	mov    %edi,%ebx
400011c6:	ba d0 07 00 00       	mov    $0x7d0,%edx
400011cb:	cd 30                	int    $0x30
    if (i == 2000) {
400011cd:	83 c4 10             	add    $0x10,%esp
400011d0:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
400011d6:	75 65                	jne    4000123d <smallfile+0x1ed>
400011d8:	85 c0                	test   %eax,%eax
400011da:	75 61                	jne    4000123d <smallfile+0x1ed>
        printf("read succeeded ok\n");
400011dc:	83 ec 0c             	sub    $0xc,%esp
400011df:	8b 6c 24 14          	mov    0x14(%esp),%ebp
400011e3:	8d 85 27 c2 ff ff    	lea    -0x3dd9(%ebp),%eax
400011e9:	89 eb                	mov    %ebp,%ebx
400011eb:	50                   	push   %eax
400011ec:	e8 4f f1 ff ff       	call   40000340 <printf>
    asm volatile ("int %2"
400011f1:	b8 04 00 00 00       	mov    $0x4,%eax
400011f6:	89 fb                	mov    %edi,%ebx
400011f8:	cd 30                	int    $0x30
    asm volatile ("int %2"
400011fa:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
400011fe:	89 f0                	mov    %esi,%eax
40001200:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40001202:	83 c4 10             	add    $0x10,%esp
40001205:	85 c0                	test   %eax,%eax
40001207:	75 4f                	jne    40001258 <smallfile+0x208>
    printf("=====small file test ok=====\n\n");
40001209:	83 ec 0c             	sub    $0xc,%esp
4000120c:	8d 85 60 cc ff ff    	lea    -0x33a0(%ebp),%eax
40001212:	89 eb                	mov    %ebp,%ebx
40001214:	50                   	push   %eax
40001215:	e8 26 f1 ff ff       	call   40000340 <printf>
4000121a:	83 c4 10             	add    $0x10,%esp
4000121d:	e9 ff fe ff ff       	jmp    40001121 <smallfile+0xd1>
        printf("error: open small failed!\n");
40001222:	83 ec 0c             	sub    $0xc,%esp
40001225:	8b 5c 24 14          	mov    0x14(%esp),%ebx
40001229:	8d 83 0c c2 ff ff    	lea    -0x3df4(%ebx),%eax
4000122f:	50                   	push   %eax
40001230:	e8 0b f1 ff ff       	call   40000340 <printf>
        exit();
40001235:	83 c4 10             	add    $0x10,%esp
40001238:	e9 e4 fe ff ff       	jmp    40001121 <smallfile+0xd1>
        printf("read failed\n");
4000123d:	83 ec 0c             	sub    $0xc,%esp
40001240:	8b 5c 24 14          	mov    0x14(%esp),%ebx
40001244:	8d 83 55 c9 ff ff    	lea    -0x36ab(%ebx),%eax
4000124a:	50                   	push   %eax
4000124b:	e8 f0 f0 ff ff       	call   40000340 <printf>
        exit();
40001250:	83 c4 10             	add    $0x10,%esp
40001253:	e9 c9 fe ff ff       	jmp    40001121 <smallfile+0xd1>
        printf("unlink small failed\n");
40001258:	83 ec 0c             	sub    $0xc,%esp
4000125b:	8b 5c 24 14          	mov    0x14(%esp),%ebx
4000125f:	8d 83 3a c2 ff ff    	lea    -0x3dc6(%ebx),%eax
40001265:	50                   	push   %eax
40001266:	e8 d5 f0 ff ff       	call   40000340 <printf>
        exit();
4000126b:	83 c4 10             	add    $0x10,%esp
4000126e:	e9 ae fe ff ff       	jmp    40001121 <smallfile+0xd1>
40001273:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000127a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40001280 <bigfile1>:
{
40001280:	55                   	push   %ebp
40001281:	e8 dd 18 00 00       	call   40002b63 <__x86.get_pc_thunk.bp>
40001286:	81 c5 7a 5d 00 00    	add    $0x5d7a,%ebp
4000128c:	57                   	push   %edi
4000128d:	56                   	push   %esi
4000128e:	53                   	push   %ebx
4000128f:	83 ec 28             	sub    $0x28,%esp
    printf("=====big files test=====\n");
40001292:	8d 85 4f c2 ff ff    	lea    -0x3db1(%ebp),%eax
40001298:	89 eb                	mov    %ebp,%ebx
4000129a:	50                   	push   %eax
4000129b:	e8 a0 f0 ff ff       	call   40000340 <printf>
    asm volatile ("int %2"
400012a0:	8d 9d d4 c2 ff ff    	lea    -0x3d2c(%ebp),%ebx
400012a6:	b8 03 00 00 00       	mov    $0x3,%eax
400012ab:	b9 02 02 00 00       	mov    $0x202,%ecx
400012b0:	89 5c 24 1c          	mov    %ebx,0x1c(%esp)
400012b4:	cd 30                	int    $0x30
    return errno ? -1 : fd;
400012b6:	83 c4 10             	add    $0x10,%esp
    if (fd < 0) {
400012b9:	85 c0                	test   %eax,%eax
400012bb:	75 6b                	jne    40001328 <bigfile1+0xa8>
400012bd:	8d 85 40 00 00 00    	lea    0x40(%ebp),%eax
400012c3:	89 df                	mov    %ebx,%edi
    for (i = 0; i < MAXFILE; i++) {
400012c5:	31 f6                	xor    %esi,%esi
    asm volatile ("int %2"
400012c7:	ba 00 02 00 00       	mov    $0x200,%edx
400012cc:	89 44 24 08          	mov    %eax,0x8(%esp)
400012d0:	8b 4c 24 08          	mov    0x8(%esp),%ecx
    if (fd < 0) {
400012d4:	85 db                	test   %ebx,%ebx
400012d6:	79 1b                	jns    400012f3 <bigfile1+0x73>
400012d8:	eb 4e                	jmp    40001328 <bigfile1+0xa8>
400012da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if (write(fd, buf, 512) != 512) {
400012e0:	81 fb 00 02 00 00    	cmp    $0x200,%ebx
400012e6:	75 1e                	jne    40001306 <bigfile1+0x86>
    for (i = 0; i < MAXFILE; i++) {
400012e8:	83 c6 01             	add    $0x1,%esi
400012eb:	81 fe 8c 00 00 00    	cmp    $0x8c,%esi
400012f1:	74 51                	je     40001344 <bigfile1+0xc4>
        ((int *) buf)[0] = i;
400012f3:	89 b5 40 00 00 00    	mov    %esi,0x40(%ebp)
400012f9:	b8 06 00 00 00       	mov    $0x6,%eax
400012fe:	89 fb                	mov    %edi,%ebx
40001300:	cd 30                	int    $0x30
        if (write(fd, buf, 512) != 512) {
40001302:	85 c0                	test   %eax,%eax
40001304:	74 da                	je     400012e0 <bigfile1+0x60>
            printf("error: write big file failed\n", i);
40001306:	83 ec 08             	sub    $0x8,%esp
40001309:	8d 85 84 c2 ff ff    	lea    -0x3d7c(%ebp),%eax
4000130f:	89 eb                	mov    %ebp,%ebx
40001311:	56                   	push   %esi
40001312:	50                   	push   %eax
40001313:	e8 28 f0 ff ff       	call   40000340 <printf>
            exit();
40001318:	83 c4 10             	add    $0x10,%esp
}
4000131b:	83 c4 1c             	add    $0x1c,%esp
4000131e:	5b                   	pop    %ebx
4000131f:	5e                   	pop    %esi
40001320:	5f                   	pop    %edi
40001321:	5d                   	pop    %ebp
40001322:	c3                   	ret    
40001323:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40001327:	90                   	nop
        printf("error: create big failed!\n");
40001328:	83 ec 0c             	sub    $0xc,%esp
4000132b:	8d 85 69 c2 ff ff    	lea    -0x3d97(%ebp),%eax
40001331:	89 eb                	mov    %ebp,%ebx
40001333:	50                   	push   %eax
40001334:	e8 07 f0 ff ff       	call   40000340 <printf>
        exit();
40001339:	83 c4 10             	add    $0x10,%esp
}
4000133c:	83 c4 1c             	add    $0x1c,%esp
4000133f:	5b                   	pop    %ebx
40001340:	5e                   	pop    %esi
40001341:	5f                   	pop    %edi
40001342:	5d                   	pop    %ebp
40001343:	c3                   	ret    
    asm volatile ("int %2"
40001344:	b8 04 00 00 00       	mov    $0x4,%eax
40001349:	89 fb                	mov    %edi,%ebx
4000134b:	cd 30                	int    $0x30
    asm volatile ("int %2"
4000134d:	b8 03 00 00 00       	mov    $0x3,%eax
40001352:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40001356:	31 c9                	xor    %ecx,%ecx
40001358:	cd 30                	int    $0x30
4000135a:	89 df                	mov    %ebx,%edi
    if (fd < 0) {
4000135c:	85 db                	test   %ebx,%ebx
4000135e:	0f 88 97 00 00 00    	js     400013fb <bigfile1+0x17b>
40001364:	85 c0                	test   %eax,%eax
40001366:	0f 85 8f 00 00 00    	jne    400013fb <bigfile1+0x17b>
    asm volatile ("int %2"
4000136c:	8b 4c 24 08          	mov    0x8(%esp),%ecx
40001370:	b8 05 00 00 00       	mov    $0x5,%eax
40001375:	cd 30                	int    $0x30
40001377:	89 da                	mov    %ebx,%edx
40001379:	89 c6                	mov    %eax,%esi
    return errno ? -1 : ret;
4000137b:	85 c0                	test   %eax,%eax
4000137d:	74 35                	je     400013b4 <bigfile1+0x134>
4000137f:	e9 90 00 00 00       	jmp    40001414 <bigfile1+0x194>
40001384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        } else if (i != 512) {
40001388:	81 fa 00 02 00 00    	cmp    $0x200,%edx
4000138e:	0f 85 85 00 00 00    	jne    40001419 <bigfile1+0x199>
        if (((int *) buf)[0] != n) {
40001394:	8b 85 40 00 00 00    	mov    0x40(%ebp),%eax
4000139a:	39 f0                	cmp    %esi,%eax
4000139c:	0f 85 91 00 00 00    	jne    40001433 <bigfile1+0x1b3>
        n++;
400013a2:	83 c6 01             	add    $0x1,%esi
    asm volatile ("int %2"
400013a5:	b8 05 00 00 00       	mov    $0x5,%eax
400013aa:	89 fb                	mov    %edi,%ebx
400013ac:	cd 30                	int    $0x30
400013ae:	89 da                	mov    %ebx,%edx
    return errno ? -1 : ret;
400013b0:	85 c0                	test   %eax,%eax
400013b2:	75 60                	jne    40001414 <bigfile1+0x194>
400013b4:	89 d0                	mov    %edx,%eax
        if (i == 0) {
400013b6:	85 d2                	test   %edx,%edx
400013b8:	75 ce                	jne    40001388 <bigfile1+0x108>
            if (n == MAXFILE - 1) {
400013ba:	81 fe 8b 00 00 00    	cmp    $0x8b,%esi
400013c0:	0f 84 88 00 00 00    	je     4000144e <bigfile1+0x1ce>
    asm volatile ("int %2"
400013c6:	b8 04 00 00 00       	mov    $0x4,%eax
400013cb:	89 fb                	mov    %edi,%ebx
400013cd:	cd 30                	int    $0x30
    asm volatile ("int %2"
400013cf:	b8 0a 00 00 00       	mov    $0xa,%eax
400013d4:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
400013d8:	cd 30                	int    $0x30
    return errno ? -1 : 0;
400013da:	85 c0                	test   %eax,%eax
400013dc:	0f 85 8a 00 00 00    	jne    4000146c <bigfile1+0x1ec>
    printf("=====big files ok=====\n\n");
400013e2:	83 ec 0c             	sub    $0xc,%esp
400013e5:	8d 85 e8 c2 ff ff    	lea    -0x3d18(%ebp),%eax
400013eb:	89 eb                	mov    %ebp,%ebx
400013ed:	50                   	push   %eax
400013ee:	e8 4d ef ff ff       	call   40000340 <printf>
400013f3:	83 c4 10             	add    $0x10,%esp
400013f6:	e9 20 ff ff ff       	jmp    4000131b <bigfile1+0x9b>
        printf("error: open big failed!\n");
400013fb:	83 ec 0c             	sub    $0xc,%esp
400013fe:	8d 85 a2 c2 ff ff    	lea    -0x3d5e(%ebp),%eax
40001404:	89 eb                	mov    %ebp,%ebx
40001406:	50                   	push   %eax
40001407:	e8 34 ef ff ff       	call   40000340 <printf>
        exit();
4000140c:	83 c4 10             	add    $0x10,%esp
4000140f:	e9 07 ff ff ff       	jmp    4000131b <bigfile1+0x9b>
    return errno ? -1 : ret;
40001414:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
            printf("read failed %d\n", i);
40001419:	83 ec 08             	sub    $0x8,%esp
4000141c:	89 eb                	mov    %ebp,%ebx
4000141e:	50                   	push   %eax
4000141f:	8d 85 d8 c2 ff ff    	lea    -0x3d28(%ebp),%eax
40001425:	50                   	push   %eax
40001426:	e8 15 ef ff ff       	call   40000340 <printf>
            exit();
4000142b:	83 c4 10             	add    $0x10,%esp
4000142e:	e9 e8 fe ff ff       	jmp    4000131b <bigfile1+0x9b>
            printf("read content of block %d is %d\n", n, ((int *) buf)[0]);
40001433:	83 ec 04             	sub    $0x4,%esp
40001436:	89 eb                	mov    %ebp,%ebx
40001438:	50                   	push   %eax
40001439:	8d 85 80 cc ff ff    	lea    -0x3380(%ebp),%eax
4000143f:	56                   	push   %esi
40001440:	50                   	push   %eax
40001441:	e8 fa ee ff ff       	call   40000340 <printf>
            exit();
40001446:	83 c4 10             	add    $0x10,%esp
40001449:	e9 cd fe ff ff       	jmp    4000131b <bigfile1+0x9b>
                printf("read only %d blocks from big", n);
4000144e:	83 ec 08             	sub    $0x8,%esp
40001451:	8d 85 bb c2 ff ff    	lea    -0x3d45(%ebp),%eax
40001457:	89 eb                	mov    %ebp,%ebx
40001459:	68 8b 00 00 00       	push   $0x8b
4000145e:	50                   	push   %eax
4000145f:	e8 dc ee ff ff       	call   40000340 <printf>
                exit();
40001464:	83 c4 10             	add    $0x10,%esp
40001467:	e9 af fe ff ff       	jmp    4000131b <bigfile1+0x9b>
        printf("unlink big failed\n");
4000146c:	83 ec 0c             	sub    $0xc,%esp
4000146f:	8d 85 01 c3 ff ff    	lea    -0x3cff(%ebp),%eax
40001475:	89 eb                	mov    %ebp,%ebx
40001477:	50                   	push   %eax
40001478:	e8 c3 ee ff ff       	call   40000340 <printf>
        exit();
4000147d:	83 c4 10             	add    $0x10,%esp
40001480:	e9 96 fe ff ff       	jmp    4000131b <bigfile1+0x9b>
40001485:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000148c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40001490 <createtest>:
{
40001490:	55                   	push   %ebp
40001491:	8d 2d 2a 00 00 00    	lea    0x2a,%ebp
40001497:	57                   	push   %edi
40001498:	e8 c2 16 00 00       	call   40002b5f <__x86.get_pc_thunk.di>
4000149d:	81 c7 63 5b 00 00    	add    $0x5b63,%edi
400014a3:	56                   	push   %esi
    name[2] = '\0';
400014a4:	be 30 00 00 00       	mov    $0x30,%esi
{
400014a9:	53                   	push   %ebx
400014aa:	83 ec 18             	sub    $0x18,%esp
    printf("=====many creates, followed by unlink test=====\n");
400014ad:	8d 87 a0 cc ff ff    	lea    -0x3360(%edi),%eax
400014b3:	89 fb                	mov    %edi,%ebx
400014b5:	50                   	push   %eax
400014b6:	e8 85 ee ff ff       	call   40000340 <printf>
    name[0] = 'a';
400014bb:	8d 97 2a 00 00 00    	lea    0x2a(%edi),%edx
    name[2] = '\0';
400014c1:	83 c4 10             	add    $0x10,%esp
    asm volatile ("int %2"
400014c4:	b9 02 02 00 00       	mov    $0x202,%ecx
    name[0] = 'a';
400014c9:	c6 87 2a 00 00 00 61 	movb   $0x61,0x2a(%edi)
400014d0:	89 d0                	mov    %edx,%eax
400014d2:	89 f2                	mov    %esi,%edx
    name[2] = '\0';
400014d4:	c6 87 2c 00 00 00 00 	movb   $0x0,0x2c(%edi)
400014db:	89 c6                	mov    %eax,%esi
400014dd:	8d 76 00             	lea    0x0(%esi),%esi
        name[1] = '0' + i;
400014e0:	88 54 3d 01          	mov    %dl,0x1(%ebp,%edi,1)
400014e4:	b8 03 00 00 00       	mov    $0x3,%eax
400014e9:	89 f3                	mov    %esi,%ebx
400014eb:	cd 30                	int    $0x30
    return errno ? -1 : fd;
400014ed:	85 c0                	test   %eax,%eax
400014ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
400014f4:	0f 45 d8             	cmovne %eax,%ebx
    asm volatile ("int %2"
400014f7:	b8 04 00 00 00       	mov    $0x4,%eax
400014fc:	cd 30                	int    $0x30
    for (i = 0; i < 52; i++) {
400014fe:	83 c2 01             	add    $0x1,%edx
40001501:	80 fa 64             	cmp    $0x64,%dl
40001504:	75 da                	jne    400014e0 <createtest+0x50>
    name[0] = 'a';
40001506:	c6 87 2a 00 00 00 61 	movb   $0x61,0x2a(%edi)
4000150d:	89 f2                	mov    %esi,%edx
    name[2] = '\0';
4000150f:	b9 30 00 00 00       	mov    $0x30,%ecx
    asm volatile ("int %2"
40001514:	be 0a 00 00 00       	mov    $0xa,%esi
40001519:	c6 87 2c 00 00 00 00 	movb   $0x0,0x2c(%edi)
        name[1] = '0' + i;
40001520:	88 4c 3d 01          	mov    %cl,0x1(%ebp,%edi,1)
40001524:	89 f0                	mov    %esi,%eax
40001526:	89 d3                	mov    %edx,%ebx
40001528:	cd 30                	int    $0x30
    for (i = 0; i < 52; i++) {
4000152a:	83 c1 01             	add    $0x1,%ecx
4000152d:	80 f9 64             	cmp    $0x64,%cl
40001530:	75 ee                	jne    40001520 <createtest+0x90>
    printf("=====many creates, followed by unlink; ok=====\n\n");
40001532:	83 ec 0c             	sub    $0xc,%esp
40001535:	8d 87 d4 cc ff ff    	lea    -0x332c(%edi),%eax
4000153b:	89 fb                	mov    %edi,%ebx
4000153d:	50                   	push   %eax
4000153e:	e8 fd ed ff ff       	call   40000340 <printf>
}
40001543:	83 c4 1c             	add    $0x1c,%esp
40001546:	5b                   	pop    %ebx
40001547:	5e                   	pop    %esi
40001548:	5f                   	pop    %edi
40001549:	5d                   	pop    %ebp
4000154a:	c3                   	ret    
4000154b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
4000154f:	90                   	nop

40001550 <rmdot>:
{
40001550:	57                   	push   %edi
40001551:	56                   	push   %esi
40001552:	e8 04 16 00 00       	call   40002b5b <__x86.get_pc_thunk.si>
40001557:	81 c6 a9 5a 00 00    	add    $0x5aa9,%esi
4000155d:	53                   	push   %ebx
    printf("=====rmdot test=====\n");
4000155e:	83 ec 0c             	sub    $0xc,%esp
40001561:	8d 86 14 c3 ff ff    	lea    -0x3cec(%esi),%eax
40001567:	89 f3                	mov    %esi,%ebx
40001569:	50                   	push   %eax
4000156a:	e8 d1 ed ff ff       	call   40000340 <printf>

static gcc_inline int sys_mkdir(char *path)
{
    int errno, ret;

    asm volatile ("int %2"
4000156f:	8d 96 2a c3 ff ff    	lea    -0x3cd6(%esi),%edx
40001575:	b8 07 00 00 00       	mov    $0x7,%eax
4000157a:	89 d3                	mov    %edx,%ebx
4000157c:	cd 30                	int    $0x30
                  : "i" (T_SYSCALL),
                    "a" (SYS_mkdir),
                    "b" (path)
                  : "cc", "memory");

    return errno ? -1 : 0;
4000157e:	83 c4 10             	add    $0x10,%esp
40001581:	85 c0                	test   %eax,%eax
40001583:	75 3b                	jne    400015c0 <rmdot+0x70>

static gcc_inline int sys_chdir(char *path)
{
    int errno, ret;

    asm volatile ("int %2"
40001585:	b9 08 00 00 00       	mov    $0x8,%ecx
4000158a:	89 d3                	mov    %edx,%ebx
4000158c:	89 c8                	mov    %ecx,%eax
4000158e:	cd 30                	int    $0x30
                  : "i" (T_SYSCALL),
                    "a" (SYS_chdir),
                    "b" (path)
                  : "cc", "memory");

    return errno ? -1 : 0;
40001590:	85 c0                	test   %eax,%eax
40001592:	75 4c                	jne    400015e0 <rmdot+0x90>
    asm volatile ("int %2"
40001594:	bf 0a 00 00 00       	mov    $0xa,%edi
40001599:	8d 9e 60 c6 ff ff    	lea    -0x39a0(%esi),%ebx
4000159f:	89 f8                	mov    %edi,%eax
400015a1:	cd 30                	int    $0x30
    return errno ? -1 : 0;
400015a3:	85 c0                	test   %eax,%eax
400015a5:	75 59                	jne    40001600 <rmdot+0xb0>
        printf("rm . worked!\n");
400015a7:	83 ec 0c             	sub    $0xc,%esp
400015aa:	8d 86 55 c3 ff ff    	lea    -0x3cab(%esi),%eax
400015b0:	89 f3                	mov    %esi,%ebx
400015b2:	50                   	push   %eax
400015b3:	e8 88 ed ff ff       	call   40000340 <printf>
        exit();
400015b8:	83 c4 10             	add    $0x10,%esp
}
400015bb:	5b                   	pop    %ebx
400015bc:	5e                   	pop    %esi
400015bd:	5f                   	pop    %edi
400015be:	c3                   	ret    
400015bf:	90                   	nop
        printf("mkdir dots failed\n");
400015c0:	83 ec 0c             	sub    $0xc,%esp
400015c3:	8d 86 2f c3 ff ff    	lea    -0x3cd1(%esi),%eax
400015c9:	89 f3                	mov    %esi,%ebx
400015cb:	50                   	push   %eax
400015cc:	e8 6f ed ff ff       	call   40000340 <printf>
        exit();
400015d1:	83 c4 10             	add    $0x10,%esp
400015d4:	eb e5                	jmp    400015bb <rmdot+0x6b>
400015d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400015dd:	8d 76 00             	lea    0x0(%esi),%esi
        printf("chdir dots failed\n");
400015e0:	83 ec 0c             	sub    $0xc,%esp
400015e3:	8d 86 42 c3 ff ff    	lea    -0x3cbe(%esi),%eax
400015e9:	89 f3                	mov    %esi,%ebx
400015eb:	50                   	push   %eax
400015ec:	e8 4f ed ff ff       	call   40000340 <printf>
        exit();
400015f1:	83 c4 10             	add    $0x10,%esp
400015f4:	eb c5                	jmp    400015bb <rmdot+0x6b>
400015f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400015fd:	8d 76 00             	lea    0x0(%esi),%esi
    asm volatile ("int %2"
40001600:	8d 9e 5f c6 ff ff    	lea    -0x39a1(%esi),%ebx
40001606:	89 f8                	mov    %edi,%eax
40001608:	cd 30                	int    $0x30
    return errno ? -1 : 0;
4000160a:	85 c0                	test   %eax,%eax
4000160c:	75 16                	jne    40001624 <rmdot+0xd4>
        printf("rm .. worked!\n");
4000160e:	83 ec 0c             	sub    $0xc,%esp
40001611:	8d 86 63 c3 ff ff    	lea    -0x3c9d(%esi),%eax
40001617:	89 f3                	mov    %esi,%ebx
40001619:	50                   	push   %eax
4000161a:	e8 21 ed ff ff       	call   40000340 <printf>
        exit();
4000161f:	83 c4 10             	add    $0x10,%esp
40001622:	eb 97                	jmp    400015bb <rmdot+0x6b>
    asm volatile ("int %2"
40001624:	8d 9e 72 c3 ff ff    	lea    -0x3c8e(%esi),%ebx
4000162a:	89 c8                	mov    %ecx,%eax
4000162c:	cd 30                	int    $0x30
    return errno ? -1 : 0;
4000162e:	85 c0                	test   %eax,%eax
40001630:	75 27                	jne    40001659 <rmdot+0x109>
    asm volatile ("int %2"
40001632:	8d 9e 74 c3 ff ff    	lea    -0x3c8c(%esi),%ebx
40001638:	89 f8                	mov    %edi,%eax
4000163a:	cd 30                	int    $0x30
    return errno ? -1 : 0;
4000163c:	85 c0                	test   %eax,%eax
4000163e:	75 32                	jne    40001672 <rmdot+0x122>
        printf("unlink dots/. worked!\n");
40001640:	83 ec 0c             	sub    $0xc,%esp
40001643:	8d 86 8d c3 ff ff    	lea    -0x3c73(%esi),%eax
40001649:	89 f3                	mov    %esi,%ebx
4000164b:	50                   	push   %eax
4000164c:	e8 ef ec ff ff       	call   40000340 <printf>
        exit();
40001651:	83 c4 10             	add    $0x10,%esp
40001654:	e9 62 ff ff ff       	jmp    400015bb <rmdot+0x6b>
        printf("chdir '/' failed\n");
40001659:	83 ec 0c             	sub    $0xc,%esp
4000165c:	8d 86 7b c3 ff ff    	lea    -0x3c85(%esi),%eax
40001662:	89 f3                	mov    %esi,%ebx
40001664:	50                   	push   %eax
40001665:	e8 d6 ec ff ff       	call   40000340 <printf>
        exit();
4000166a:	83 c4 10             	add    $0x10,%esp
4000166d:	e9 49 ff ff ff       	jmp    400015bb <rmdot+0x6b>
    asm volatile ("int %2"
40001672:	8d 9e a4 c3 ff ff    	lea    -0x3c5c(%esi),%ebx
40001678:	89 f8                	mov    %edi,%eax
4000167a:	cd 30                	int    $0x30
    return errno ? -1 : 0;
4000167c:	85 c0                	test   %eax,%eax
4000167e:	75 19                	jne    40001699 <rmdot+0x149>
        printf("unlink dots/.. worked!\n");
40001680:	83 ec 0c             	sub    $0xc,%esp
40001683:	8d 86 ac c3 ff ff    	lea    -0x3c54(%esi),%eax
40001689:	89 f3                	mov    %esi,%ebx
4000168b:	50                   	push   %eax
4000168c:	e8 af ec ff ff       	call   40000340 <printf>
        exit();
40001691:	83 c4 10             	add    $0x10,%esp
40001694:	e9 22 ff ff ff       	jmp    400015bb <rmdot+0x6b>
    asm volatile ("int %2"
40001699:	89 f8                	mov    %edi,%eax
4000169b:	89 d3                	mov    %edx,%ebx
4000169d:	cd 30                	int    $0x30
    return errno ? -1 : 0;
4000169f:	85 c0                	test   %eax,%eax
400016a1:	75 19                	jne    400016bc <rmdot+0x16c>
    printf("=====rmdot ok=====\n\n");
400016a3:	83 ec 0c             	sub    $0xc,%esp
400016a6:	8d 86 c4 c3 ff ff    	lea    -0x3c3c(%esi),%eax
400016ac:	89 f3                	mov    %esi,%ebx
400016ae:	50                   	push   %eax
400016af:	e8 8c ec ff ff       	call   40000340 <printf>
400016b4:	83 c4 10             	add    $0x10,%esp
400016b7:	e9 ff fe ff ff       	jmp    400015bb <rmdot+0x6b>
        printf("unlink dots failed!\n");
400016bc:	83 ec 0c             	sub    $0xc,%esp
400016bf:	8d 86 d9 c3 ff ff    	lea    -0x3c27(%esi),%eax
400016c5:	89 f3                	mov    %esi,%ebx
400016c7:	50                   	push   %eax
400016c8:	e8 73 ec ff ff       	call   40000340 <printf>
        exit();
400016cd:	83 c4 10             	add    $0x10,%esp
400016d0:	e9 e6 fe ff ff       	jmp    400015bb <rmdot+0x6b>
400016d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400016dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

400016e0 <fourteen>:
{
400016e0:	55                   	push   %ebp
400016e1:	57                   	push   %edi
400016e2:	56                   	push   %esi
400016e3:	e8 73 14 00 00       	call   40002b5b <__x86.get_pc_thunk.si>
400016e8:	81 c6 18 59 00 00    	add    $0x5918,%esi
400016ee:	53                   	push   %ebx
400016ef:	83 ec 28             	sub    $0x28,%esp
    printf("=====fourteen test=====\n");
400016f2:	8d 86 ee c3 ff ff    	lea    -0x3c12(%esi),%eax
400016f8:	89 f3                	mov    %esi,%ebx
400016fa:	50                   	push   %eax
400016fb:	e8 40 ec ff ff       	call   40000340 <printf>
    asm volatile ("int %2"
40001700:	ba 07 00 00 00       	mov    $0x7,%edx
40001705:	8d 9e 33 c4 ff ff    	lea    -0x3bcd(%esi),%ebx
4000170b:	89 d0                	mov    %edx,%eax
4000170d:	cd 30                	int    $0x30
    return errno ? -1 : 0;
4000170f:	83 c4 10             	add    $0x10,%esp
40001712:	85 c0                	test   %eax,%eax
40001714:	0f 85 ee 00 00 00    	jne    40001808 <fourteen+0x128>
    asm volatile ("int %2"
4000171a:	8d 9e 08 cd ff ff    	lea    -0x32f8(%esi),%ebx
40001720:	89 d0                	mov    %edx,%eax
40001722:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
40001726:	cd 30                	int    $0x30
40001728:	89 c5                	mov    %eax,%ebp
    return errno ? -1 : 0;
4000172a:	85 c0                	test   %eax,%eax
4000172c:	0f 85 f6 00 00 00    	jne    40001828 <fourteen+0x148>
    asm volatile ("int %2"
40001732:	bf 03 00 00 00       	mov    $0x3,%edi
40001737:	8d 9e 28 cd ff ff    	lea    -0x32d8(%esi),%ebx
4000173d:	b9 00 02 00 00       	mov    $0x200,%ecx
40001742:	89 f8                	mov    %edi,%eax
40001744:	cd 30                	int    $0x30
    if (fd < 0) {
40001746:	85 c0                	test   %eax,%eax
40001748:	75 56                	jne    400017a0 <fourteen+0xc0>
4000174a:	85 db                	test   %ebx,%ebx
4000174c:	78 52                	js     400017a0 <fourteen+0xc0>
    asm volatile ("int %2"
4000174e:	b8 04 00 00 00       	mov    $0x4,%eax
40001753:	cd 30                	int    $0x30
    asm volatile ("int %2"
40001755:	8d 9e c8 cd ff ff    	lea    -0x3238(%esi),%ebx
4000175b:	89 f8                	mov    %edi,%eax
4000175d:	89 e9                	mov    %ebp,%ecx
4000175f:	cd 30                	int    $0x30
    if (fd < 0) {
40001761:	85 db                	test   %ebx,%ebx
40001763:	78 5b                	js     400017c0 <fourteen+0xe0>
40001765:	85 c0                	test   %eax,%eax
40001767:	75 57                	jne    400017c0 <fourteen+0xe0>
    asm volatile ("int %2"
40001769:	b8 04 00 00 00       	mov    $0x4,%eax
4000176e:	cd 30                	int    $0x30
    asm volatile ("int %2"
40001770:	8d 9e 24 c4 ff ff    	lea    -0x3bdc(%esi),%ebx
40001776:	89 d0                	mov    %edx,%eax
40001778:	cd 30                	int    $0x30
    return errno ? -1 : 0;
4000177a:	85 c0                	test   %eax,%eax
4000177c:	75 62                	jne    400017e0 <fourteen+0x100>
        printf("mkdir 12345678901234/12345678901234 succeeded!\n");
4000177e:	83 ec 0c             	sub    $0xc,%esp
40001781:	8d 86 34 ce ff ff    	lea    -0x31cc(%esi),%eax
40001787:	89 f3                	mov    %esi,%ebx
40001789:	50                   	push   %eax
4000178a:	e8 b1 eb ff ff       	call   40000340 <printf>
        exit();
4000178f:	83 c4 10             	add    $0x10,%esp
}
40001792:	83 c4 1c             	add    $0x1c,%esp
40001795:	5b                   	pop    %ebx
40001796:	5e                   	pop    %esi
40001797:	5f                   	pop    %edi
40001798:	5d                   	pop    %ebp
40001799:	c3                   	ret    
4000179a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf
400017a0:	83 ec 0c             	sub    $0xc,%esp
400017a3:	8d 86 88 cd ff ff    	lea    -0x3278(%esi),%eax
400017a9:	89 f3                	mov    %esi,%ebx
400017ab:	50                   	push   %eax
400017ac:	e8 8f eb ff ff       	call   40000340 <printf>
        exit();
400017b1:	83 c4 10             	add    $0x10,%esp
}
400017b4:	83 c4 1c             	add    $0x1c,%esp
400017b7:	5b                   	pop    %ebx
400017b8:	5e                   	pop    %esi
400017b9:	5f                   	pop    %edi
400017ba:	5d                   	pop    %ebp
400017bb:	c3                   	ret    
400017bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf
400017c0:	83 ec 0c             	sub    $0xc,%esp
400017c3:	8d 86 f8 cd ff ff    	lea    -0x3208(%esi),%eax
400017c9:	89 f3                	mov    %esi,%ebx
400017cb:	50                   	push   %eax
400017cc:	e8 6f eb ff ff       	call   40000340 <printf>
        exit();
400017d1:	83 c4 10             	add    $0x10,%esp
}
400017d4:	83 c4 1c             	add    $0x1c,%esp
400017d7:	5b                   	pop    %ebx
400017d8:	5e                   	pop    %esi
400017d9:	5f                   	pop    %edi
400017da:	5d                   	pop    %ebp
400017db:	c3                   	ret    
400017dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    asm volatile ("int %2"
400017e0:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
400017e4:	89 d0                	mov    %edx,%eax
400017e6:	cd 30                	int    $0x30
    return errno ? -1 : 0;
400017e8:	85 c0                	test   %eax,%eax
400017ea:	75 55                	jne    40001841 <fourteen+0x161>
        printf("mkdir 12345678901234/123456789012345 succeeded!\n");
400017ec:	83 ec 0c             	sub    $0xc,%esp
400017ef:	8d 86 64 ce ff ff    	lea    -0x319c(%esi),%eax
400017f5:	89 f3                	mov    %esi,%ebx
400017f7:	50                   	push   %eax
400017f8:	e8 43 eb ff ff       	call   40000340 <printf>
        exit();
400017fd:	83 c4 10             	add    $0x10,%esp
40001800:	eb 90                	jmp    40001792 <fourteen+0xb2>
40001802:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf("mkdir 12345678901234 failed\n");
40001808:	83 ec 0c             	sub    $0xc,%esp
4000180b:	8d 86 07 c4 ff ff    	lea    -0x3bf9(%esi),%eax
40001811:	89 f3                	mov    %esi,%ebx
40001813:	50                   	push   %eax
40001814:	e8 27 eb ff ff       	call   40000340 <printf>
        exit();
40001819:	83 c4 10             	add    $0x10,%esp
4000181c:	e9 71 ff ff ff       	jmp    40001792 <fourteen+0xb2>
40001821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf("mkdir 12345678901234/123456789012345 failed\n");
40001828:	83 ec 0c             	sub    $0xc,%esp
4000182b:	8d 86 58 cd ff ff    	lea    -0x32a8(%esi),%eax
40001831:	89 f3                	mov    %esi,%ebx
40001833:	50                   	push   %eax
40001834:	e8 07 eb ff ff       	call   40000340 <printf>
        exit();
40001839:	83 c4 10             	add    $0x10,%esp
4000183c:	e9 51 ff ff ff       	jmp    40001792 <fourteen+0xb2>
    printf("=====fourteen ok=====\n\n");
40001841:	83 ec 0c             	sub    $0xc,%esp
40001844:	8d 86 42 c4 ff ff    	lea    -0x3bbe(%esi),%eax
4000184a:	89 f3                	mov    %esi,%ebx
4000184c:	50                   	push   %eax
4000184d:	e8 ee ea ff ff       	call   40000340 <printf>
40001852:	83 c4 10             	add    $0x10,%esp
40001855:	e9 38 ff ff ff       	jmp    40001792 <fourteen+0xb2>
4000185a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40001860 <bigfile2>:
{
40001860:	55                   	push   %ebp
40001861:	57                   	push   %edi
40001862:	e8 f8 12 00 00       	call   40002b5f <__x86.get_pc_thunk.di>
40001867:	81 c7 99 57 00 00    	add    $0x5799,%edi
4000186d:	56                   	push   %esi
4000186e:	53                   	push   %ebx
4000186f:	83 ec 28             	sub    $0x28,%esp
    printf("=====bigfile test=====\n");
40001872:	8d 87 5a c4 ff ff    	lea    -0x3ba6(%edi),%eax
40001878:	89 fb                	mov    %edi,%ebx
4000187a:	50                   	push   %eax
4000187b:	e8 c0 ea ff ff       	call   40000340 <printf>
    asm volatile ("int %2"
40001880:	8d 9f 80 c4 ff ff    	lea    -0x3b80(%edi),%ebx
40001886:	b8 0a 00 00 00       	mov    $0xa,%eax
4000188b:	89 5c 24 1c          	mov    %ebx,0x1c(%esp)
4000188f:	89 de                	mov    %ebx,%esi
40001891:	cd 30                	int    $0x30
    asm volatile ("int %2"
40001893:	b8 03 00 00 00       	mov    $0x3,%eax
40001898:	b9 02 02 00 00       	mov    $0x202,%ecx
4000189d:	89 f3                	mov    %esi,%ebx
4000189f:	cd 30                	int    $0x30
400018a1:	89 5c 24 14          	mov    %ebx,0x14(%esp)
    return errno ? -1 : fd;
400018a5:	83 c4 10             	add    $0x10,%esp
    if (fd < 0) {
400018a8:	85 c0                	test   %eax,%eax
400018aa:	0f 85 40 01 00 00    	jne    400019f0 <bigfile2+0x190>
    for (i = 0; i < 20; i++) {
400018b0:	31 f6                	xor    %esi,%esi
400018b2:	8d af 40 00 00 00    	lea    0x40(%edi),%ebp
    if (fd < 0) {
400018b8:	85 db                	test   %ebx,%ebx
400018ba:	0f 88 30 01 00 00    	js     400019f0 <bigfile2+0x190>
        memset(buf, i, 600);
400018c0:	83 ec 04             	sub    $0x4,%esp
400018c3:	89 fb                	mov    %edi,%ebx
400018c5:	68 58 02 00 00       	push   $0x258
400018ca:	56                   	push   %esi
400018cb:	55                   	push   %ebp
400018cc:	e8 ff f5 ff ff       	call   40000ed0 <memset>
    asm volatile ("int %2"
400018d1:	8b 5c 24 14          	mov    0x14(%esp),%ebx
400018d5:	b8 06 00 00 00       	mov    $0x6,%eax
400018da:	89 e9                	mov    %ebp,%ecx
400018dc:	ba 58 02 00 00       	mov    $0x258,%edx
400018e1:	cd 30                	int    $0x30
    return errno ? -1 : ret;
400018e3:	83 c4 10             	add    $0x10,%esp
        if (write(fd, buf, 600) != 600) {
400018e6:	85 c0                	test   %eax,%eax
400018e8:	0f 85 e2 00 00 00    	jne    400019d0 <bigfile2+0x170>
400018ee:	81 fb 58 02 00 00    	cmp    $0x258,%ebx
400018f4:	0f 85 d6 00 00 00    	jne    400019d0 <bigfile2+0x170>
    for (i = 0; i < 20; i++) {
400018fa:	83 c6 01             	add    $0x1,%esi
400018fd:	83 fe 14             	cmp    $0x14,%esi
40001900:	75 be                	jne    400018c0 <bigfile2+0x60>
    asm volatile ("int %2"
40001902:	8b 5c 24 04          	mov    0x4(%esp),%ebx
40001906:	b8 04 00 00 00       	mov    $0x4,%eax
4000190b:	cd 30                	int    $0x30
    asm volatile ("int %2"
4000190d:	b8 03 00 00 00       	mov    $0x3,%eax
40001912:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40001916:	31 c9                	xor    %ecx,%ecx
40001918:	cd 30                	int    $0x30
4000191a:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    if (fd < 0) {
4000191e:	85 db                	test   %ebx,%ebx
40001920:	0f 88 ea 00 00 00    	js     40001a10 <bigfile2+0x1b0>
40001926:	85 c0                	test   %eax,%eax
40001928:	0f 85 e2 00 00 00    	jne    40001a10 <bigfile2+0x1b0>
    asm volatile ("int %2"
4000192e:	8b 5c 24 04          	mov    0x4(%esp),%ebx
40001932:	b8 05 00 00 00       	mov    $0x5,%eax
40001937:	ba 2c 01 00 00       	mov    $0x12c,%edx
4000193c:	89 e9                	mov    %ebp,%ecx
4000193e:	cd 30                	int    $0x30
40001940:	89 44 24 08          	mov    %eax,0x8(%esp)
40001944:	89 da                	mov    %ebx,%edx
    return errno ? -1 : ret;
40001946:	85 c0                	test   %eax,%eax
40001948:	75 68                	jne    400019b2 <bigfile2+0x152>
        if (buf[0] != i / 2 || buf[299] != i / 2) {
4000194a:	8d 05 40 00 00 00    	lea    0x40,%eax
    for (i = 0;; i++) {
40001950:	31 f6                	xor    %esi,%esi
    asm volatile ("int %2"
40001952:	89 c5                	mov    %eax,%ebp
40001954:	eb 58                	jmp    400019ae <bigfile2+0x14e>
40001956:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000195d:	8d 76 00             	lea    0x0(%esi),%esi
        if (cc == 0)
40001960:	0f 84 e0 00 00 00    	je     40001a46 <bigfile2+0x1e6>
        if (cc != 300) {
40001966:	81 fa 2c 01 00 00    	cmp    $0x12c,%edx
4000196c:	0f 85 02 01 00 00    	jne    40001a74 <bigfile2+0x214>
        if (buf[0] != i / 2 || buf[299] != i / 2) {
40001972:	89 f3                	mov    %esi,%ebx
40001974:	0f be 04 2f          	movsbl (%edi,%ebp,1),%eax
40001978:	d1 fb                	sar    %ebx
4000197a:	39 d8                	cmp    %ebx,%eax
4000197c:	0f 85 ae 00 00 00    	jne    40001a30 <bigfile2+0x1d0>
40001982:	0f be 9c 2f 2b 01 00 	movsbl 0x12b(%edi,%ebp,1),%ebx
40001989:	00 
4000198a:	39 d8                	cmp    %ebx,%eax
4000198c:	0f 85 9e 00 00 00    	jne    40001a30 <bigfile2+0x1d0>
        total += cc;
40001992:	81 44 24 08 2c 01 00 	addl   $0x12c,0x8(%esp)
40001999:	00 
4000199a:	8b 5c 24 04          	mov    0x4(%esp),%ebx
    for (i = 0;; i++) {
4000199e:	83 c6 01             	add    $0x1,%esi
400019a1:	b8 05 00 00 00       	mov    $0x5,%eax
400019a6:	cd 30                	int    $0x30
400019a8:	89 da                	mov    %ebx,%edx
    return errno ? -1 : ret;
400019aa:	85 c0                	test   %eax,%eax
400019ac:	75 04                	jne    400019b2 <bigfile2+0x152>
        if (cc < 0) {
400019ae:	85 d2                	test   %edx,%edx
400019b0:	79 ae                	jns    40001960 <bigfile2+0x100>
            printf("read bigfile failed\n");
400019b2:	83 ec 0c             	sub    $0xc,%esp
400019b5:	8d 87 b3 c4 ff ff    	lea    -0x3b4d(%edi),%eax
400019bb:	89 fb                	mov    %edi,%ebx
400019bd:	50                   	push   %eax
400019be:	e8 7d e9 ff ff       	call   40000340 <printf>
            exit();
400019c3:	83 c4 10             	add    $0x10,%esp
400019c6:	eb 1c                	jmp    400019e4 <bigfile2+0x184>
400019c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400019cf:	90                   	nop
            printf("write bigfile failed\n");
400019d0:	83 ec 0c             	sub    $0xc,%esp
400019d3:	8d 87 88 c4 ff ff    	lea    -0x3b78(%edi),%eax
400019d9:	89 fb                	mov    %edi,%ebx
400019db:	50                   	push   %eax
400019dc:	e8 5f e9 ff ff       	call   40000340 <printf>
            exit();
400019e1:	83 c4 10             	add    $0x10,%esp
}
400019e4:	83 c4 1c             	add    $0x1c,%esp
400019e7:	5b                   	pop    %ebx
400019e8:	5e                   	pop    %esi
400019e9:	5f                   	pop    %edi
400019ea:	5d                   	pop    %ebp
400019eb:	c3                   	ret    
400019ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf("cannot create bigfile");
400019f0:	83 ec 0c             	sub    $0xc,%esp
400019f3:	8d 87 72 c4 ff ff    	lea    -0x3b8e(%edi),%eax
400019f9:	89 fb                	mov    %edi,%ebx
400019fb:	50                   	push   %eax
400019fc:	e8 3f e9 ff ff       	call   40000340 <printf>
        exit();
40001a01:	83 c4 10             	add    $0x10,%esp
}
40001a04:	83 c4 1c             	add    $0x1c,%esp
40001a07:	5b                   	pop    %ebx
40001a08:	5e                   	pop    %esi
40001a09:	5f                   	pop    %edi
40001a0a:	5d                   	pop    %ebp
40001a0b:	c3                   	ret    
40001a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf("cannot open bigfile\n");
40001a10:	83 ec 0c             	sub    $0xc,%esp
40001a13:	8d 87 9e c4 ff ff    	lea    -0x3b62(%edi),%eax
40001a19:	89 fb                	mov    %edi,%ebx
40001a1b:	50                   	push   %eax
40001a1c:	e8 1f e9 ff ff       	call   40000340 <printf>
        exit();
40001a21:	83 c4 10             	add    $0x10,%esp
40001a24:	eb be                	jmp    400019e4 <bigfile2+0x184>
40001a26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40001a2d:	8d 76 00             	lea    0x0(%esi),%esi
            printf("read bigfile wrong data\n");
40001a30:	83 ec 0c             	sub    $0xc,%esp
40001a33:	8d 87 dc c4 ff ff    	lea    -0x3b24(%edi),%eax
40001a39:	89 fb                	mov    %edi,%ebx
40001a3b:	50                   	push   %eax
40001a3c:	e8 ff e8 ff ff       	call   40000340 <printf>
            exit();
40001a41:	83 c4 10             	add    $0x10,%esp
40001a44:	eb 9e                	jmp    400019e4 <bigfile2+0x184>
    asm volatile ("int %2"
40001a46:	8b 5c 24 04          	mov    0x4(%esp),%ebx
40001a4a:	b8 04 00 00 00       	mov    $0x4,%eax
40001a4f:	cd 30                	int    $0x30
    if (total != 20 * 600) {
40001a51:	81 7c 24 08 e0 2e 00 	cmpl   $0x2ee0,0x8(%esp)
40001a58:	00 
40001a59:	74 32                	je     40001a8d <bigfile2+0x22d>
        printf("read bigfile wrong total\n");
40001a5b:	83 ec 0c             	sub    $0xc,%esp
40001a5e:	8d 87 f5 c4 ff ff    	lea    -0x3b0b(%edi),%eax
40001a64:	89 fb                	mov    %edi,%ebx
40001a66:	50                   	push   %eax
40001a67:	e8 d4 e8 ff ff       	call   40000340 <printf>
        exit();
40001a6c:	83 c4 10             	add    $0x10,%esp
40001a6f:	e9 70 ff ff ff       	jmp    400019e4 <bigfile2+0x184>
            printf("short read bigfile\n");
40001a74:	83 ec 0c             	sub    $0xc,%esp
40001a77:	8d 87 c8 c4 ff ff    	lea    -0x3b38(%edi),%eax
40001a7d:	89 fb                	mov    %edi,%ebx
40001a7f:	50                   	push   %eax
40001a80:	e8 bb e8 ff ff       	call   40000340 <printf>
            exit();
40001a85:	83 c4 10             	add    $0x10,%esp
40001a88:	e9 57 ff ff ff       	jmp    400019e4 <bigfile2+0x184>
    asm volatile ("int %2"
40001a8d:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40001a91:	b8 0a 00 00 00       	mov    $0xa,%eax
40001a96:	cd 30                	int    $0x30
    printf("=====bigfile test ok=====\n\n");
40001a98:	83 ec 0c             	sub    $0xc,%esp
40001a9b:	8d 87 0f c5 ff ff    	lea    -0x3af1(%edi),%eax
40001aa1:	89 fb                	mov    %edi,%ebx
40001aa3:	50                   	push   %eax
40001aa4:	e8 97 e8 ff ff       	call   40000340 <printf>
40001aa9:	83 c4 10             	add    $0x10,%esp
40001aac:	e9 33 ff ff ff       	jmp    400019e4 <bigfile2+0x184>
40001ab1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40001ab8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40001abf:	90                   	nop

40001ac0 <subdir>:
{
40001ac0:	55                   	push   %ebp
40001ac1:	57                   	push   %edi
40001ac2:	56                   	push   %esi
40001ac3:	e8 93 10 00 00       	call   40002b5b <__x86.get_pc_thunk.si>
40001ac8:	81 c6 38 55 00 00    	add    $0x5538,%esi
40001ace:	53                   	push   %ebx
40001acf:	83 ec 38             	sub    $0x38,%esp
    printf("=====subdir test=====\n");
40001ad2:	8d 86 2b c5 ff ff    	lea    -0x3ad5(%esi),%eax
40001ad8:	89 f3                	mov    %esi,%ebx
40001ada:	8d ae bd c5 ff ff    	lea    -0x3a43(%esi),%ebp
40001ae0:	50                   	push   %eax
40001ae1:	e8 5a e8 ff ff       	call   40000340 <printf>
40001ae6:	b8 0a 00 00 00       	mov    $0xa,%eax
40001aeb:	89 eb                	mov    %ebp,%ebx
40001aed:	cd 30                	int    $0x30
    asm volatile ("int %2"
40001aef:	8d 9e 40 c6 ff ff    	lea    -0x39c0(%esi),%ebx
40001af5:	b8 07 00 00 00       	mov    $0x7,%eax
40001afa:	89 5c 24 18          	mov    %ebx,0x18(%esp)
40001afe:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40001b00:	83 c4 10             	add    $0x10,%esp
40001b03:	85 c0                	test   %eax,%eax
40001b05:	0f 85 85 00 00 00    	jne    40001b90 <subdir+0xd0>
    asm volatile ("int %2"
40001b0b:	8d 9e 78 c5 ff ff    	lea    -0x3a88(%esi),%ebx
40001b11:	b8 03 00 00 00       	mov    $0x3,%eax
40001b16:	b9 02 02 00 00       	mov    $0x202,%ecx
40001b1b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
40001b1f:	cd 30                	int    $0x30
40001b21:	89 df                	mov    %ebx,%edi
    if (fd < 0) {
40001b23:	85 db                	test   %ebx,%ebx
40001b25:	78 49                	js     40001b70 <subdir+0xb0>
40001b27:	85 c0                	test   %eax,%eax
40001b29:	75 45                	jne    40001b70 <subdir+0xb0>
    asm volatile ("int %2"
40001b2b:	ba 02 00 00 00       	mov    $0x2,%edx
40001b30:	b8 06 00 00 00       	mov    $0x6,%eax
40001b35:	89 e9                	mov    %ebp,%ecx
40001b37:	cd 30                	int    $0x30
    asm volatile ("int %2"
40001b39:	bd 04 00 00 00       	mov    $0x4,%ebp
40001b3e:	89 fb                	mov    %edi,%ebx
40001b40:	89 e8                	mov    %ebp,%eax
40001b42:	cd 30                	int    $0x30
    asm volatile ("int %2"
40001b44:	b8 0a 00 00 00       	mov    $0xa,%eax
40001b49:	8b 5c 24 08          	mov    0x8(%esp),%ebx
40001b4d:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40001b4f:	85 c0                	test   %eax,%eax
40001b51:	75 5d                	jne    40001bb0 <subdir+0xf0>
        printf("unlink dd (non-empty dir) succeeded!\n");
40001b53:	83 ec 0c             	sub    $0xc,%esp
40001b56:	8d 86 98 ce ff ff    	lea    -0x3168(%esi),%eax
40001b5c:	89 f3                	mov    %esi,%ebx
40001b5e:	50                   	push   %eax
40001b5f:	e8 dc e7 ff ff       	call   40000340 <printf>
        exit();
40001b64:	83 c4 10             	add    $0x10,%esp
}
40001b67:	83 c4 2c             	add    $0x2c,%esp
40001b6a:	5b                   	pop    %ebx
40001b6b:	5e                   	pop    %esi
40001b6c:	5f                   	pop    %edi
40001b6d:	5d                   	pop    %ebp
40001b6e:	c3                   	ret    
40001b6f:	90                   	nop
        printf("create dd/ff failed\n");
40001b70:	83 ec 0c             	sub    $0xc,%esp
40001b73:	8d 86 5a c5 ff ff    	lea    -0x3aa6(%esi),%eax
40001b79:	89 f3                	mov    %esi,%ebx
40001b7b:	50                   	push   %eax
40001b7c:	e8 bf e7 ff ff       	call   40000340 <printf>
        exit();
40001b81:	83 c4 10             	add    $0x10,%esp
}
40001b84:	83 c4 2c             	add    $0x2c,%esp
40001b87:	5b                   	pop    %ebx
40001b88:	5e                   	pop    %esi
40001b89:	5f                   	pop    %edi
40001b8a:	5d                   	pop    %ebp
40001b8b:	c3                   	ret    
40001b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf("subdir mkdir dd failed\n");
40001b90:	83 ec 0c             	sub    $0xc,%esp
40001b93:	8d 86 42 c5 ff ff    	lea    -0x3abe(%esi),%eax
40001b99:	89 f3                	mov    %esi,%ebx
40001b9b:	50                   	push   %eax
40001b9c:	e8 9f e7 ff ff       	call   40000340 <printf>
        exit();
40001ba1:	83 c4 10             	add    $0x10,%esp
40001ba4:	eb c1                	jmp    40001b67 <subdir+0xa7>
40001ba6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40001bad:	8d 76 00             	lea    0x0(%esi),%esi
    asm volatile ("int %2"
40001bb0:	8d 9e 6f c5 ff ff    	lea    -0x3a91(%esi),%ebx
40001bb6:	b8 07 00 00 00       	mov    $0x7,%eax
40001bbb:	89 5c 24 18          	mov    %ebx,0x18(%esp)
40001bbf:	cd 30                	int    $0x30
40001bc1:	89 44 24 10          	mov    %eax,0x10(%esp)
    return errno ? -1 : 0;
40001bc5:	85 c0                	test   %eax,%eax
40001bc7:	0f 85 e0 02 00 00    	jne    40001ead <subdir+0x3ed>
    asm volatile ("int %2"
40001bcd:	8d 9e 75 c5 ff ff    	lea    -0x3a8b(%esi),%ebx
40001bd3:	b8 03 00 00 00       	mov    $0x3,%eax
40001bd8:	b9 02 02 00 00       	mov    $0x202,%ecx
40001bdd:	89 5c 24 14          	mov    %ebx,0x14(%esp)
40001be1:	cd 30                	int    $0x30
40001be3:	89 df                	mov    %ebx,%edi
    if (fd < 0) {
40001be5:	85 c0                	test   %eax,%eax
40001be7:	0f 85 5c 02 00 00    	jne    40001e49 <subdir+0x389>
40001bed:	85 db                	test   %ebx,%ebx
40001bef:	0f 88 54 02 00 00    	js     40001e49 <subdir+0x389>
    asm volatile ("int %2"
40001bf5:	8d 8e b1 c5 ff ff    	lea    -0x3a4f(%esi),%ecx
40001bfb:	b8 06 00 00 00       	mov    $0x6,%eax
40001c00:	cd 30                	int    $0x30
    asm volatile ("int %2"
40001c02:	89 e8                	mov    %ebp,%eax
40001c04:	89 fb                	mov    %edi,%ebx
40001c06:	cd 30                	int    $0x30
    asm volatile ("int %2"
40001c08:	b8 03 00 00 00       	mov    $0x3,%eax
40001c0d:	8b 4c 24 10          	mov    0x10(%esp),%ecx
40001c11:	8d 9e b4 c5 ff ff    	lea    -0x3a4c(%esi),%ebx
40001c17:	cd 30                	int    $0x30
40001c19:	89 dd                	mov    %ebx,%ebp
    if (fd < 0) {
40001c1b:	85 db                	test   %ebx,%ebx
40001c1d:	0f 88 3f 02 00 00    	js     40001e62 <subdir+0x3a2>
40001c23:	85 c0                	test   %eax,%eax
40001c25:	0f 85 37 02 00 00    	jne    40001e62 <subdir+0x3a2>
    asm volatile ("int %2"
40001c2b:	8d be 40 00 00 00    	lea    0x40(%esi),%edi
40001c31:	b8 05 00 00 00       	mov    $0x5,%eax
40001c36:	ba 00 20 00 00       	mov    $0x2000,%edx
40001c3b:	89 f9                	mov    %edi,%ecx
40001c3d:	cd 30                	int    $0x30
    if (cc != 2 || buf[0] != 'f') {
40001c3f:	83 fb 02             	cmp    $0x2,%ebx
40001c42:	0f 85 e8 01 00 00    	jne    40001e30 <subdir+0x370>
40001c48:	85 c0                	test   %eax,%eax
40001c4a:	0f 85 e0 01 00 00    	jne    40001e30 <subdir+0x370>
40001c50:	80 be 40 00 00 00 66 	cmpb   $0x66,0x40(%esi)
40001c57:	0f 85 d3 01 00 00    	jne    40001e30 <subdir+0x370>
    asm volatile ("int %2"
40001c5d:	b8 04 00 00 00       	mov    $0x4,%eax
40001c62:	89 eb                	mov    %ebp,%ebx
40001c64:	cd 30                	int    $0x30
    asm volatile ("int %2"
40001c66:	8d 8e f4 c5 ff ff    	lea    -0x3a0c(%esi),%ecx
40001c6c:	8b 5c 24 14          	mov    0x14(%esp),%ebx
40001c70:	b8 09 00 00 00       	mov    $0x9,%eax
40001c75:	89 4c 24 10          	mov    %ecx,0x10(%esp)
40001c79:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40001c7b:	85 c0                	test   %eax,%eax
40001c7d:	0f 85 c0 02 00 00    	jne    40001f43 <subdir+0x483>
    asm volatile ("int %2"
40001c83:	8b 5c 24 14          	mov    0x14(%esp),%ebx
40001c87:	b8 0a 00 00 00       	mov    $0xa,%eax
40001c8c:	cd 30                	int    $0x30
40001c8e:	89 c1                	mov    %eax,%ecx
    return errno ? -1 : 0;
40001c90:	85 c0                	test   %eax,%eax
40001c92:	0f 85 42 03 00 00    	jne    40001fda <subdir+0x51a>
    asm volatile ("int %2"
40001c98:	8b 5c 24 14          	mov    0x14(%esp),%ebx
40001c9c:	b8 03 00 00 00       	mov    $0x3,%eax
40001ca1:	cd 30                	int    $0x30
    if (open("dd/dd/ff", O_RDONLY) >= 0) {
40001ca3:	85 db                	test   %ebx,%ebx
40001ca5:	78 08                	js     40001caf <subdir+0x1ef>
40001ca7:	85 c0                	test   %eax,%eax
40001ca9:	0f 84 cc 01 00 00    	je     40001e7b <subdir+0x3bb>
    asm volatile ("int %2"
40001caf:	ba 08 00 00 00       	mov    $0x8,%edx
40001cb4:	8b 5c 24 08          	mov    0x8(%esp),%ebx
40001cb8:	89 d0                	mov    %edx,%eax
40001cba:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40001cbc:	85 c0                	test   %eax,%eax
40001cbe:	0f 85 48 03 00 00    	jne    4000200c <subdir+0x54c>
    asm volatile ("int %2"
40001cc4:	8d 9e 17 c6 ff ff    	lea    -0x39e9(%esi),%ebx
40001cca:	89 d0                	mov    %edx,%eax
40001ccc:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40001cce:	85 c0                	test   %eax,%eax
40001cd0:	0f 85 1d 03 00 00    	jne    40001ff3 <subdir+0x533>
    asm volatile ("int %2"
40001cd6:	8d 9e 34 c6 ff ff    	lea    -0x39cc(%esi),%ebx
40001cdc:	89 d0                	mov    %edx,%eax
40001cde:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40001ce0:	85 c0                	test   %eax,%eax
40001ce2:	0f 85 0b 03 00 00    	jne    40001ff3 <subdir+0x533>
    asm volatile ("int %2"
40001ce8:	8d 9e 5d c6 ff ff    	lea    -0x39a3(%esi),%ebx
40001cee:	89 d0                	mov    %edx,%eax
40001cf0:	cd 30                	int    $0x30
40001cf2:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    return errno ? -1 : 0;
40001cf6:	89 c1                	mov    %eax,%ecx
40001cf8:	85 c0                	test   %eax,%eax
40001cfa:	0f 85 25 03 00 00    	jne    40002025 <subdir+0x565>
    asm volatile ("int %2"
40001d00:	8b 5c 24 10          	mov    0x10(%esp),%ebx
40001d04:	b8 03 00 00 00       	mov    $0x3,%eax
40001d09:	cd 30                	int    $0x30
40001d0b:	89 dd                	mov    %ebx,%ebp
    if (fd < 0) {
40001d0d:	85 db                	test   %ebx,%ebx
40001d0f:	0f 88 b1 01 00 00    	js     40001ec6 <subdir+0x406>
40001d15:	85 c0                	test   %eax,%eax
40001d17:	0f 85 a9 01 00 00    	jne    40001ec6 <subdir+0x406>
    asm volatile ("int %2"
40001d1d:	b8 05 00 00 00       	mov    $0x5,%eax
40001d22:	ba 00 20 00 00       	mov    $0x2000,%edx
40001d27:	89 f9                	mov    %edi,%ecx
40001d29:	cd 30                	int    $0x30
    if (read(fd, buf, sizeof(buf)) != 2) {
40001d2b:	83 fb 02             	cmp    $0x2,%ebx
40001d2e:	0f 85 60 01 00 00    	jne    40001e94 <subdir+0x3d4>
40001d34:	85 c0                	test   %eax,%eax
40001d36:	0f 85 58 01 00 00    	jne    40001e94 <subdir+0x3d4>
    asm volatile ("int %2"
40001d3c:	b8 04 00 00 00       	mov    $0x4,%eax
40001d41:	89 eb                	mov    %ebp,%ebx
40001d43:	cd 30                	int    $0x30
    asm volatile ("int %2"
40001d45:	b8 03 00 00 00       	mov    $0x3,%eax
40001d4a:	8b 5c 24 14          	mov    0x14(%esp),%ebx
40001d4e:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
40001d52:	cd 30                	int    $0x30
    if (open("dd/dd/ff", O_RDONLY) >= 0) {
40001d54:	85 db                	test   %ebx,%ebx
40001d56:	78 08                	js     40001d60 <subdir+0x2a0>
40001d58:	85 c0                	test   %eax,%eax
40001d5a:	0f 84 7f 01 00 00    	je     40001edf <subdir+0x41f>
40001d60:	8d ae a8 c6 ff ff    	lea    -0x3958(%esi),%ebp
40001d66:	b8 03 00 00 00       	mov    $0x3,%eax
40001d6b:	b9 02 02 00 00       	mov    $0x202,%ecx
40001d70:	89 eb                	mov    %ebp,%ebx
40001d72:	cd 30                	int    $0x30
    if (open("dd/ff/ff", O_CREATE | O_RDWR) >= 0) {
40001d74:	85 db                	test   %ebx,%ebx
40001d76:	78 08                	js     40001d80 <subdir+0x2c0>
40001d78:	85 c0                	test   %eax,%eax
40001d7a:	0f 84 78 01 00 00    	je     40001ef8 <subdir+0x438>
40001d80:	8d be cd c6 ff ff    	lea    -0x3933(%esi),%edi
40001d86:	b8 03 00 00 00       	mov    $0x3,%eax
40001d8b:	b9 02 02 00 00       	mov    $0x202,%ecx
40001d90:	89 fb                	mov    %edi,%ebx
40001d92:	cd 30                	int    $0x30
    if (open("dd/xx/ff", O_CREATE | O_RDWR) >= 0) {
40001d94:	85 db                	test   %ebx,%ebx
40001d96:	78 08                	js     40001da0 <subdir+0x2e0>
40001d98:	85 c0                	test   %eax,%eax
40001d9a:	0f 84 71 01 00 00    	je     40001f11 <subdir+0x451>
40001da0:	8b 5c 24 08          	mov    0x8(%esp),%ebx
40001da4:	b8 03 00 00 00       	mov    $0x3,%eax
40001da9:	b9 00 02 00 00       	mov    $0x200,%ecx
40001dae:	cd 30                	int    $0x30
    if (open("dd", O_CREATE) >= 0) {
40001db0:	85 db                	test   %ebx,%ebx
40001db2:	78 08                	js     40001dbc <subdir+0x2fc>
40001db4:	85 c0                	test   %eax,%eax
40001db6:	0f 84 6e 01 00 00    	je     40001f2a <subdir+0x46a>
40001dbc:	8b 5c 24 08          	mov    0x8(%esp),%ebx
40001dc0:	b8 03 00 00 00       	mov    $0x3,%eax
40001dc5:	b9 02 00 00 00       	mov    $0x2,%ecx
40001dca:	cd 30                	int    $0x30
    if (open("dd", O_RDWR) >= 0) {
40001dcc:	85 db                	test   %ebx,%ebx
40001dce:	78 08                	js     40001dd8 <subdir+0x318>
40001dd0:	85 c0                	test   %eax,%eax
40001dd2:	0f 84 a7 01 00 00    	je     40001f7f <subdir+0x4bf>
40001dd8:	8b 5c 24 08          	mov    0x8(%esp),%ebx
40001ddc:	b8 03 00 00 00       	mov    $0x3,%eax
40001de1:	b9 01 00 00 00       	mov    $0x1,%ecx
40001de6:	cd 30                	int    $0x30
    if (open("dd", O_WRONLY) >= 0) {
40001de8:	85 db                	test   %ebx,%ebx
40001dea:	78 08                	js     40001df4 <subdir+0x334>
40001dec:	85 c0                	test   %eax,%eax
40001dee:	0f 84 a4 01 00 00    	je     40001f98 <subdir+0x4d8>
    asm volatile ("int %2"
40001df4:	ba 09 00 00 00       	mov    $0x9,%edx
40001df9:	8d 8e 3c c7 ff ff    	lea    -0x38c4(%esi),%ecx
40001dff:	89 eb                	mov    %ebp,%ebx
40001e01:	89 d0                	mov    %edx,%eax
40001e03:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40001e05:	85 c0                	test   %eax,%eax
40001e07:	0f 85 4f 01 00 00    	jne    40001f5c <subdir+0x49c>
        printf("link dd/ff/ff dd/dd/xx succeeded!\n");
40001e0d:	83 ec 0c             	sub    $0xc,%esp
40001e10:	8d 86 30 cf ff ff    	lea    -0x30d0(%esi),%eax
40001e16:	89 f3                	mov    %esi,%ebx
40001e18:	50                   	push   %eax
40001e19:	e8 22 e5 ff ff       	call   40000340 <printf>
        exit();
40001e1e:	83 c4 10             	add    $0x10,%esp
40001e21:	e9 41 fd ff ff       	jmp    40001b67 <subdir+0xa7>
40001e26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40001e2d:	8d 76 00             	lea    0x0(%esi),%esi
        printf("dd/dd/../ff wrong content\n");
40001e30:	83 ec 0c             	sub    $0xc,%esp
40001e33:	8d 86 d9 c5 ff ff    	lea    -0x3a27(%esi),%eax
40001e39:	89 f3                	mov    %esi,%ebx
40001e3b:	50                   	push   %eax
40001e3c:	e8 ff e4 ff ff       	call   40000340 <printf>
        exit();
40001e41:	83 c4 10             	add    $0x10,%esp
40001e44:	e9 1e fd ff ff       	jmp    40001b67 <subdir+0xa7>
        printf("create dd/dd/ff failed\n");
40001e49:	83 ec 0c             	sub    $0xc,%esp
40001e4c:	8d 86 99 c5 ff ff    	lea    -0x3a67(%esi),%eax
40001e52:	89 f3                	mov    %esi,%ebx
40001e54:	50                   	push   %eax
40001e55:	e8 e6 e4 ff ff       	call   40000340 <printf>
        exit();
40001e5a:	83 c4 10             	add    $0x10,%esp
40001e5d:	e9 05 fd ff ff       	jmp    40001b67 <subdir+0xa7>
        printf("open dd/dd/../ff failed\n");
40001e62:	83 ec 0c             	sub    $0xc,%esp
40001e65:	8d 86 c0 c5 ff ff    	lea    -0x3a40(%esi),%eax
40001e6b:	89 f3                	mov    %esi,%ebx
40001e6d:	50                   	push   %eax
40001e6e:	e8 cd e4 ff ff       	call   40000340 <printf>
        exit();
40001e73:	83 c4 10             	add    $0x10,%esp
40001e76:	e9 ec fc ff ff       	jmp    40001b67 <subdir+0xa7>
        printf("open (unlinked) dd/dd/ff succeeded\n");
40001e7b:	83 ec 0c             	sub    $0xc,%esp
40001e7e:	8d 86 e4 ce ff ff    	lea    -0x311c(%esi),%eax
40001e84:	89 f3                	mov    %esi,%ebx
40001e86:	50                   	push   %eax
40001e87:	e8 b4 e4 ff ff       	call   40000340 <printf>
        exit();
40001e8c:	83 c4 10             	add    $0x10,%esp
40001e8f:	e9 d3 fc ff ff       	jmp    40001b67 <subdir+0xa7>
        printf("read dd/dd/ffff wrong len\n");
40001e94:	83 ec 0c             	sub    $0xc,%esp
40001e97:	8d 86 8d c6 ff ff    	lea    -0x3973(%esi),%eax
40001e9d:	89 f3                	mov    %esi,%ebx
40001e9f:	50                   	push   %eax
40001ea0:	e8 9b e4 ff ff       	call   40000340 <printf>
        exit();
40001ea5:	83 c4 10             	add    $0x10,%esp
40001ea8:	e9 ba fc ff ff       	jmp    40001b67 <subdir+0xa7>
        printf("subdir mkdir dd/dd failed\n");
40001ead:	83 ec 0c             	sub    $0xc,%esp
40001eb0:	8d 86 7e c5 ff ff    	lea    -0x3a82(%esi),%eax
40001eb6:	89 f3                	mov    %esi,%ebx
40001eb8:	50                   	push   %eax
40001eb9:	e8 82 e4 ff ff       	call   40000340 <printf>
        exit();
40001ebe:	83 c4 10             	add    $0x10,%esp
40001ec1:	e9 a1 fc ff ff       	jmp    40001b67 <subdir+0xa7>
        printf("open dd/dd/ffff failed\n");
40001ec6:	83 ec 0c             	sub    $0xc,%esp
40001ec9:	8d 86 75 c6 ff ff    	lea    -0x398b(%esi),%eax
40001ecf:	89 f3                	mov    %esi,%ebx
40001ed1:	50                   	push   %eax
40001ed2:	e8 69 e4 ff ff       	call   40000340 <printf>
        exit();
40001ed7:	83 c4 10             	add    $0x10,%esp
40001eda:	e9 88 fc ff ff       	jmp    40001b67 <subdir+0xa7>
        printf("open (unlinked) dd/dd/ff succeeded!\n");
40001edf:	83 ec 0c             	sub    $0xc,%esp
40001ee2:	8d 86 08 cf ff ff    	lea    -0x30f8(%esi),%eax
40001ee8:	89 f3                	mov    %esi,%ebx
40001eea:	50                   	push   %eax
40001eeb:	e8 50 e4 ff ff       	call   40000340 <printf>
        exit();
40001ef0:	83 c4 10             	add    $0x10,%esp
40001ef3:	e9 6f fc ff ff       	jmp    40001b67 <subdir+0xa7>
        printf("create dd/ff/ff succeeded!\n");
40001ef8:	83 ec 0c             	sub    $0xc,%esp
40001efb:	8d 86 b1 c6 ff ff    	lea    -0x394f(%esi),%eax
40001f01:	89 f3                	mov    %esi,%ebx
40001f03:	50                   	push   %eax
40001f04:	e8 37 e4 ff ff       	call   40000340 <printf>
        exit();
40001f09:	83 c4 10             	add    $0x10,%esp
40001f0c:	e9 56 fc ff ff       	jmp    40001b67 <subdir+0xa7>
        printf("create dd/xx/ff succeeded!\n");
40001f11:	83 ec 0c             	sub    $0xc,%esp
40001f14:	8d 86 d6 c6 ff ff    	lea    -0x392a(%esi),%eax
40001f1a:	89 f3                	mov    %esi,%ebx
40001f1c:	50                   	push   %eax
40001f1d:	e8 1e e4 ff ff       	call   40000340 <printf>
        exit();
40001f22:	83 c4 10             	add    $0x10,%esp
40001f25:	e9 3d fc ff ff       	jmp    40001b67 <subdir+0xa7>
        printf("create dd succeeded!\n");
40001f2a:	83 ec 0c             	sub    $0xc,%esp
40001f2d:	8d 86 f2 c6 ff ff    	lea    -0x390e(%esi),%eax
40001f33:	89 f3                	mov    %esi,%ebx
40001f35:	50                   	push   %eax
40001f36:	e8 05 e4 ff ff       	call   40000340 <printf>
        exit();
40001f3b:	83 c4 10             	add    $0x10,%esp
40001f3e:	e9 24 fc ff ff       	jmp    40001b67 <subdir+0xa7>
        printf("link dd/dd/ff dd/dd/ffff failed\n");
40001f43:	83 ec 0c             	sub    $0xc,%esp
40001f46:	8d 86 c0 ce ff ff    	lea    -0x3140(%esi),%eax
40001f4c:	89 f3                	mov    %esi,%ebx
40001f4e:	50                   	push   %eax
40001f4f:	e8 ec e3 ff ff       	call   40000340 <printf>
        exit();
40001f54:	83 c4 10             	add    $0x10,%esp
40001f57:	e9 0b fc ff ff       	jmp    40001b67 <subdir+0xa7>
    asm volatile ("int %2"
40001f5c:	89 d0                	mov    %edx,%eax
40001f5e:	89 fb                	mov    %edi,%ebx
40001f60:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40001f62:	85 c0                	test   %eax,%eax
40001f64:	75 4b                	jne    40001fb1 <subdir+0x4f1>
        printf("link dd/xx/ff dd/dd/xx succeeded!\n");
40001f66:	83 ec 0c             	sub    $0xc,%esp
40001f69:	8d 86 54 cf ff ff    	lea    -0x30ac(%esi),%eax
40001f6f:	89 f3                	mov    %esi,%ebx
40001f71:	50                   	push   %eax
40001f72:	e8 c9 e3 ff ff       	call   40000340 <printf>
        exit();
40001f77:	83 c4 10             	add    $0x10,%esp
40001f7a:	e9 e8 fb ff ff       	jmp    40001b67 <subdir+0xa7>
        printf("open dd rdwr succeeded!\n");
40001f7f:	83 ec 0c             	sub    $0xc,%esp
40001f82:	8d 86 08 c7 ff ff    	lea    -0x38f8(%esi),%eax
40001f88:	89 f3                	mov    %esi,%ebx
40001f8a:	50                   	push   %eax
40001f8b:	e8 b0 e3 ff ff       	call   40000340 <printf>
        exit();
40001f90:	83 c4 10             	add    $0x10,%esp
40001f93:	e9 cf fb ff ff       	jmp    40001b67 <subdir+0xa7>
        printf("open dd wronly succeeded!\n");
40001f98:	83 ec 0c             	sub    $0xc,%esp
40001f9b:	8d 86 21 c7 ff ff    	lea    -0x38df(%esi),%eax
40001fa1:	89 f3                	mov    %esi,%ebx
40001fa3:	50                   	push   %eax
40001fa4:	e8 97 e3 ff ff       	call   40000340 <printf>
        exit();
40001fa9:	83 c4 10             	add    $0x10,%esp
40001fac:	e9 b6 fb ff ff       	jmp    40001b67 <subdir+0xa7>
    asm volatile ("int %2"
40001fb1:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40001fb5:	8b 4c 24 10          	mov    0x10(%esp),%ecx
40001fb9:	89 d0                	mov    %edx,%eax
40001fbb:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40001fbd:	85 c0                	test   %eax,%eax
40001fbf:	75 7d                	jne    4000203e <subdir+0x57e>
        printf("link dd/ff dd/dd/ffff succeeded!\n");
40001fc1:	83 ec 0c             	sub    $0xc,%esp
40001fc4:	8d 86 78 cf ff ff    	lea    -0x3088(%esi),%eax
40001fca:	89 f3                	mov    %esi,%ebx
40001fcc:	50                   	push   %eax
40001fcd:	e8 6e e3 ff ff       	call   40000340 <printf>
        exit();
40001fd2:	83 c4 10             	add    $0x10,%esp
40001fd5:	e9 8d fb ff ff       	jmp    40001b67 <subdir+0xa7>
        printf("unlink dd/dd/ff failed\n");
40001fda:	83 ec 0c             	sub    $0xc,%esp
40001fdd:	8d 86 ff c5 ff ff    	lea    -0x3a01(%esi),%eax
40001fe3:	89 f3                	mov    %esi,%ebx
40001fe5:	50                   	push   %eax
40001fe6:	e8 55 e3 ff ff       	call   40000340 <printf>
        exit();
40001feb:	83 c4 10             	add    $0x10,%esp
40001fee:	e9 74 fb ff ff       	jmp    40001b67 <subdir+0xa7>
        printf("chdir dd/../../dd failed\n");
40001ff3:	83 ec 0c             	sub    $0xc,%esp
40001ff6:	8d 86 43 c6 ff ff    	lea    -0x39bd(%esi),%eax
40001ffc:	89 f3                	mov    %esi,%ebx
40001ffe:	50                   	push   %eax
40001fff:	e8 3c e3 ff ff       	call   40000340 <printf>
        exit();
40002004:	83 c4 10             	add    $0x10,%esp
40002007:	e9 5b fb ff ff       	jmp    40001b67 <subdir+0xa7>
        printf("chdir dd failed\n");
4000200c:	83 ec 0c             	sub    $0xc,%esp
4000200f:	8d 86 23 c6 ff ff    	lea    -0x39dd(%esi),%eax
40002015:	89 f3                	mov    %esi,%ebx
40002017:	50                   	push   %eax
40002018:	e8 23 e3 ff ff       	call   40000340 <printf>
        exit();
4000201d:	83 c4 10             	add    $0x10,%esp
40002020:	e9 42 fb ff ff       	jmp    40001b67 <subdir+0xa7>
        printf("chdir ./.. failed\n");
40002025:	83 ec 0c             	sub    $0xc,%esp
40002028:	8d 86 62 c6 ff ff    	lea    -0x399e(%esi),%eax
4000202e:	89 f3                	mov    %esi,%ebx
40002030:	50                   	push   %eax
40002031:	e8 0a e3 ff ff       	call   40000340 <printf>
        exit();
40002036:	83 c4 10             	add    $0x10,%esp
40002039:	e9 29 fb ff ff       	jmp    40001b67 <subdir+0xa7>
    asm volatile ("int %2"
4000203e:	ba 07 00 00 00       	mov    $0x7,%edx
40002043:	89 eb                	mov    %ebp,%ebx
40002045:	89 d0                	mov    %edx,%eax
40002047:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40002049:	85 c0                	test   %eax,%eax
4000204b:	75 19                	jne    40002066 <subdir+0x5a6>
        printf("mkdir dd/ff/ff succeeded!\n");
4000204d:	83 ec 0c             	sub    $0xc,%esp
40002050:	8d 86 45 c7 ff ff    	lea    -0x38bb(%esi),%eax
40002056:	89 f3                	mov    %esi,%ebx
40002058:	50                   	push   %eax
40002059:	e8 e2 e2 ff ff       	call   40000340 <printf>
        exit();
4000205e:	83 c4 10             	add    $0x10,%esp
40002061:	e9 01 fb ff ff       	jmp    40001b67 <subdir+0xa7>
    asm volatile ("int %2"
40002066:	89 d0                	mov    %edx,%eax
40002068:	89 fb                	mov    %edi,%ebx
4000206a:	cd 30                	int    $0x30
    return errno ? -1 : 0;
4000206c:	85 c0                	test   %eax,%eax
4000206e:	75 19                	jne    40002089 <subdir+0x5c9>
        printf("mkdir dd/xx/ff succeeded!\n");
40002070:	83 ec 0c             	sub    $0xc,%esp
40002073:	8d 86 60 c7 ff ff    	lea    -0x38a0(%esi),%eax
40002079:	89 f3                	mov    %esi,%ebx
4000207b:	50                   	push   %eax
4000207c:	e8 bf e2 ff ff       	call   40000340 <printf>
        exit();
40002081:	83 c4 10             	add    $0x10,%esp
40002084:	e9 de fa ff ff       	jmp    40001b67 <subdir+0xa7>
    asm volatile ("int %2"
40002089:	8b 5c 24 10          	mov    0x10(%esp),%ebx
4000208d:	89 d0                	mov    %edx,%eax
4000208f:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40002091:	85 c0                	test   %eax,%eax
40002093:	75 19                	jne    400020ae <subdir+0x5ee>
        printf("mkdir dd/dd/ffff succeeded!\n");
40002095:	83 ec 0c             	sub    $0xc,%esp
40002098:	8d 86 7b c7 ff ff    	lea    -0x3885(%esi),%eax
4000209e:	89 f3                	mov    %esi,%ebx
400020a0:	50                   	push   %eax
400020a1:	e8 9a e2 ff ff       	call   40000340 <printf>
        exit();
400020a6:	83 c4 10             	add    $0x10,%esp
400020a9:	e9 b9 fa ff ff       	jmp    40001b67 <subdir+0xa7>
    asm volatile ("int %2"
400020ae:	ba 0a 00 00 00       	mov    $0xa,%edx
400020b3:	89 fb                	mov    %edi,%ebx
400020b5:	89 d0                	mov    %edx,%eax
400020b7:	cd 30                	int    $0x30
    return errno ? -1 : 0;
400020b9:	85 c0                	test   %eax,%eax
400020bb:	75 19                	jne    400020d6 <subdir+0x616>
        printf("unlink dd/xx/ff succeeded!\n");
400020bd:	83 ec 0c             	sub    $0xc,%esp
400020c0:	8d 86 98 c7 ff ff    	lea    -0x3868(%esi),%eax
400020c6:	89 f3                	mov    %esi,%ebx
400020c8:	50                   	push   %eax
400020c9:	e8 72 e2 ff ff       	call   40000340 <printf>
        exit();
400020ce:	83 c4 10             	add    $0x10,%esp
400020d1:	e9 91 fa ff ff       	jmp    40001b67 <subdir+0xa7>
    asm volatile ("int %2"
400020d6:	89 d0                	mov    %edx,%eax
400020d8:	89 eb                	mov    %ebp,%ebx
400020da:	cd 30                	int    $0x30
    return errno ? -1 : 0;
400020dc:	85 c0                	test   %eax,%eax
400020de:	75 19                	jne    400020f9 <subdir+0x639>
        printf("unlink dd/ff/ff succeeded!\n");
400020e0:	83 ec 0c             	sub    $0xc,%esp
400020e3:	8d 86 b4 c7 ff ff    	lea    -0x384c(%esi),%eax
400020e9:	89 f3                	mov    %esi,%ebx
400020eb:	50                   	push   %eax
400020ec:	e8 4f e2 ff ff       	call   40000340 <printf>
        exit();
400020f1:	83 c4 10             	add    $0x10,%esp
400020f4:	e9 6e fa ff ff       	jmp    40001b67 <subdir+0xa7>
    asm volatile ("int %2"
400020f9:	ba 08 00 00 00       	mov    $0x8,%edx
400020fe:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40002102:	89 d0                	mov    %edx,%eax
40002104:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40002106:	85 c0                	test   %eax,%eax
40002108:	75 19                	jne    40002123 <subdir+0x663>
        printf("chdir dd/ff succeeded!\n");
4000210a:	83 ec 0c             	sub    $0xc,%esp
4000210d:	8d 86 d0 c7 ff ff    	lea    -0x3830(%esi),%eax
40002113:	89 f3                	mov    %esi,%ebx
40002115:	50                   	push   %eax
40002116:	e8 25 e2 ff ff       	call   40000340 <printf>
        exit();
4000211b:	83 c4 10             	add    $0x10,%esp
4000211e:	e9 44 fa ff ff       	jmp    40001b67 <subdir+0xa7>
    asm volatile ("int %2"
40002123:	8d 9e 3f c7 ff ff    	lea    -0x38c1(%esi),%ebx
40002129:	89 d0                	mov    %edx,%eax
4000212b:	cd 30                	int    $0x30
    return errno ? -1 : 0;
4000212d:	85 c0                	test   %eax,%eax
4000212f:	75 19                	jne    4000214a <subdir+0x68a>
        printf("chdir dd/xx succeeded!\n");
40002131:	83 ec 0c             	sub    $0xc,%esp
40002134:	8d 86 e8 c7 ff ff    	lea    -0x3818(%esi),%eax
4000213a:	89 f3                	mov    %esi,%ebx
4000213c:	50                   	push   %eax
4000213d:	e8 fe e1 ff ff       	call   40000340 <printf>
        exit();
40002142:	83 c4 10             	add    $0x10,%esp
40002145:	e9 1d fa ff ff       	jmp    40001b67 <subdir+0xa7>
    asm volatile ("int %2"
4000214a:	ba 0a 00 00 00       	mov    $0xa,%edx
4000214f:	8b 5c 24 10          	mov    0x10(%esp),%ebx
40002153:	89 d0                	mov    %edx,%eax
40002155:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40002157:	85 c0                	test   %eax,%eax
40002159:	0f 85 7b fe ff ff    	jne    40001fda <subdir+0x51a>
    asm volatile ("int %2"
4000215f:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40002163:	89 d0                	mov    %edx,%eax
40002165:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40002167:	85 c0                	test   %eax,%eax
40002169:	75 25                	jne    40002190 <subdir+0x6d0>
    asm volatile ("int %2"
4000216b:	8b 5c 24 08          	mov    0x8(%esp),%ebx
4000216f:	89 d0                	mov    %edx,%eax
40002171:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40002173:	85 c0                	test   %eax,%eax
40002175:	75 32                	jne    400021a9 <subdir+0x6e9>
        printf("unlink non-empty dd succeeded!\n");
40002177:	83 ec 0c             	sub    $0xc,%esp
4000217a:	8d 86 9c cf ff ff    	lea    -0x3064(%esi),%eax
40002180:	89 f3                	mov    %esi,%ebx
40002182:	50                   	push   %eax
40002183:	e8 b8 e1 ff ff       	call   40000340 <printf>
        exit();
40002188:	83 c4 10             	add    $0x10,%esp
4000218b:	e9 d7 f9 ff ff       	jmp    40001b67 <subdir+0xa7>
        printf("unlink dd/ff failed\n");
40002190:	83 ec 0c             	sub    $0xc,%esp
40002193:	8d 86 00 c8 ff ff    	lea    -0x3800(%esi),%eax
40002199:	89 f3                	mov    %esi,%ebx
4000219b:	50                   	push   %eax
4000219c:	e8 9f e1 ff ff       	call   40000340 <printf>
        exit();
400021a1:	83 c4 10             	add    $0x10,%esp
400021a4:	e9 be f9 ff ff       	jmp    40001b67 <subdir+0xa7>
    asm volatile ("int %2"
400021a9:	8b 5c 24 18          	mov    0x18(%esp),%ebx
400021ad:	89 d0                	mov    %edx,%eax
400021af:	cd 30                	int    $0x30
    return errno ? -1 : 0;
400021b1:	85 c0                	test   %eax,%eax
400021b3:	75 25                	jne    400021da <subdir+0x71a>
    asm volatile ("int %2"
400021b5:	8b 5c 24 08          	mov    0x8(%esp),%ebx
400021b9:	89 d0                	mov    %edx,%eax
400021bb:	cd 30                	int    $0x30
    return errno ? -1 : 0;
400021bd:	85 c0                	test   %eax,%eax
400021bf:	75 32                	jne    400021f3 <subdir+0x733>
    printf("=====subdir ok=====\n\n");
400021c1:	83 ec 0c             	sub    $0xc,%esp
400021c4:	8d 86 2a c8 ff ff    	lea    -0x37d6(%esi),%eax
400021ca:	89 f3                	mov    %esi,%ebx
400021cc:	50                   	push   %eax
400021cd:	e8 6e e1 ff ff       	call   40000340 <printf>
400021d2:	83 c4 10             	add    $0x10,%esp
400021d5:	e9 8d f9 ff ff       	jmp    40001b67 <subdir+0xa7>
        printf("unlink dd/dd failed\n");
400021da:	83 ec 0c             	sub    $0xc,%esp
400021dd:	8d 86 15 c8 ff ff    	lea    -0x37eb(%esi),%eax
400021e3:	89 f3                	mov    %esi,%ebx
400021e5:	50                   	push   %eax
400021e6:	e8 55 e1 ff ff       	call   40000340 <printf>
        exit();
400021eb:	83 c4 10             	add    $0x10,%esp
400021ee:	e9 74 f9 ff ff       	jmp    40001b67 <subdir+0xa7>
        printf("unlink dd failed\n");
400021f3:	83 ec 0c             	sub    $0xc,%esp
400021f6:	8d 86 40 c8 ff ff    	lea    -0x37c0(%esi),%eax
400021fc:	89 f3                	mov    %esi,%ebx
400021fe:	50                   	push   %eax
400021ff:	e8 3c e1 ff ff       	call   40000340 <printf>
        exit();
40002204:	83 c4 10             	add    $0x10,%esp
40002207:	e9 5b f9 ff ff       	jmp    40001b67 <subdir+0xa7>
4000220c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40002210 <linktest>:
{
40002210:	55                   	push   %ebp
    asm volatile ("int %2"
40002211:	bd 0a 00 00 00       	mov    $0xa,%ebp
40002216:	57                   	push   %edi
40002217:	56                   	push   %esi
40002218:	e8 3e 09 00 00       	call   40002b5b <__x86.get_pc_thunk.si>
4000221d:	81 c6 e3 4d 00 00    	add    $0x4de3,%esi
40002223:	53                   	push   %ebx
40002224:	83 ec 28             	sub    $0x28,%esp
    printf("=====linktest=====\n");
40002227:	8d 86 52 c8 ff ff    	lea    -0x37ae(%esi),%eax
4000222d:	89 f3                	mov    %esi,%ebx
4000222f:	8d be 66 c8 ff ff    	lea    -0x379a(%esi),%edi
40002235:	50                   	push   %eax
40002236:	e8 05 e1 ff ff       	call   40000340 <printf>
4000223b:	89 e8                	mov    %ebp,%eax
4000223d:	89 fb                	mov    %edi,%ebx
4000223f:	cd 30                	int    $0x30
40002241:	8d 9e 6a c8 ff ff    	lea    -0x3796(%esi),%ebx
40002247:	89 e8                	mov    %ebp,%eax
40002249:	89 5c 24 1c          	mov    %ebx,0x1c(%esp)
4000224d:	cd 30                	int    $0x30
    asm volatile ("int %2"
4000224f:	b9 02 02 00 00       	mov    $0x202,%ecx
40002254:	b8 03 00 00 00       	mov    $0x3,%eax
40002259:	89 fb                	mov    %edi,%ebx
4000225b:	cd 30                	int    $0x30
4000225d:	89 5c 24 18          	mov    %ebx,0x18(%esp)
    if (fd < 0) {
40002261:	83 c4 10             	add    $0x10,%esp
40002264:	85 db                	test   %ebx,%ebx
40002266:	0f 88 04 01 00 00    	js     40002370 <linktest+0x160>
4000226c:	85 c0                	test   %eax,%eax
4000226e:	0f 85 fc 00 00 00    	jne    40002370 <linktest+0x160>
    asm volatile ("int %2"
40002274:	8b 5c 24 08          	mov    0x8(%esp),%ebx
40002278:	b8 06 00 00 00       	mov    $0x6,%eax
4000227d:	8d 8e 81 c8 ff ff    	lea    -0x377f(%esi),%ecx
40002283:	ba 05 00 00 00       	mov    $0x5,%edx
40002288:	cd 30                	int    $0x30
    if (write(fd, "hello", 5) != 5) {
4000228a:	83 fb 05             	cmp    $0x5,%ebx
4000228d:	0f 85 bd 00 00 00    	jne    40002350 <linktest+0x140>
40002293:	85 c0                	test   %eax,%eax
40002295:	0f 85 b5 00 00 00    	jne    40002350 <linktest+0x140>
    asm volatile ("int %2"
4000229b:	8b 5c 24 08          	mov    0x8(%esp),%ebx
4000229f:	b8 04 00 00 00       	mov    $0x4,%eax
400022a4:	cd 30                	int    $0x30
    asm volatile ("int %2"
400022a6:	b8 09 00 00 00       	mov    $0x9,%eax
400022ab:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
400022af:	89 fb                	mov    %edi,%ebx
400022b1:	cd 30                	int    $0x30
400022b3:	89 c1                	mov    %eax,%ecx
    return errno ? -1 : 0;
400022b5:	85 c0                	test   %eax,%eax
400022b7:	0f 85 2c 01 00 00    	jne    400023e9 <linktest+0x1d9>
    asm volatile ("int %2"
400022bd:	89 e8                	mov    %ebp,%eax
400022bf:	89 fb                	mov    %edi,%ebx
400022c1:	cd 30                	int    $0x30
    asm volatile ("int %2"
400022c3:	b8 03 00 00 00       	mov    $0x3,%eax
400022c8:	89 fb                	mov    %edi,%ebx
400022ca:	cd 30                	int    $0x30
    if (open("lf1", 0) >= 0) {
400022cc:	85 db                	test   %ebx,%ebx
400022ce:	78 08                	js     400022d8 <linktest+0xc8>
400022d0:	85 c0                	test   %eax,%eax
400022d2:	0f 84 b8 00 00 00    	je     40002390 <linktest+0x180>
400022d8:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
400022dc:	b8 03 00 00 00       	mov    $0x3,%eax
400022e1:	31 c9                	xor    %ecx,%ecx
400022e3:	cd 30                	int    $0x30
400022e5:	89 dd                	mov    %ebx,%ebp
    if (fd < 0) {
400022e7:	85 db                	test   %ebx,%ebx
400022e9:	0f 88 c1 00 00 00    	js     400023b0 <linktest+0x1a0>
400022ef:	85 c0                	test   %eax,%eax
400022f1:	0f 85 b9 00 00 00    	jne    400023b0 <linktest+0x1a0>
    asm volatile ("int %2"
400022f7:	b8 05 00 00 00       	mov    $0x5,%eax
400022fc:	8d 8e 40 00 00 00    	lea    0x40(%esi),%ecx
40002302:	ba 00 20 00 00       	mov    $0x2000,%edx
40002307:	cd 30                	int    $0x30
    if (read(fd, buf, sizeof(buf)) != 5) {
40002309:	83 fb 05             	cmp    $0x5,%ebx
4000230c:	0f 85 be 00 00 00    	jne    400023d0 <linktest+0x1c0>
40002312:	85 c0                	test   %eax,%eax
40002314:	0f 85 b6 00 00 00    	jne    400023d0 <linktest+0x1c0>
    asm volatile ("int %2"
4000231a:	b8 04 00 00 00       	mov    $0x4,%eax
4000231f:	89 eb                	mov    %ebp,%ebx
40002321:	cd 30                	int    $0x30
    asm volatile ("int %2"
40002323:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40002327:	ba 09 00 00 00       	mov    $0x9,%edx
4000232c:	89 d0                	mov    %edx,%eax
4000232e:	89 d9                	mov    %ebx,%ecx
40002330:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40002332:	85 c0                	test   %eax,%eax
40002334:	0f 85 c8 00 00 00    	jne    40002402 <linktest+0x1f2>
        printf("link lf2 lf2 succeeded! oops\n");
4000233a:	83 ec 0c             	sub    $0xc,%esp
4000233d:	8d 86 d0 c8 ff ff    	lea    -0x3730(%esi),%eax
40002343:	89 f3                	mov    %esi,%ebx
40002345:	50                   	push   %eax
40002346:	e8 f5 df ff ff       	call   40000340 <printf>
        exit();
4000234b:	83 c4 10             	add    $0x10,%esp
4000234e:	eb 14                	jmp    40002364 <linktest+0x154>
        printf("write lf1 failed\n");
40002350:	83 ec 0c             	sub    $0xc,%esp
40002353:	8d 86 87 c8 ff ff    	lea    -0x3779(%esi),%eax
40002359:	89 f3                	mov    %esi,%ebx
4000235b:	50                   	push   %eax
4000235c:	e8 df df ff ff       	call   40000340 <printf>
        exit();
40002361:	83 c4 10             	add    $0x10,%esp
}
40002364:	83 c4 1c             	add    $0x1c,%esp
40002367:	5b                   	pop    %ebx
40002368:	5e                   	pop    %esi
40002369:	5f                   	pop    %edi
4000236a:	5d                   	pop    %ebp
4000236b:	c3                   	ret    
4000236c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf("create lf1 failed\n");
40002370:	83 ec 0c             	sub    $0xc,%esp
40002373:	8d 86 6e c8 ff ff    	lea    -0x3792(%esi),%eax
40002379:	89 f3                	mov    %esi,%ebx
4000237b:	50                   	push   %eax
4000237c:	e8 bf df ff ff       	call   40000340 <printf>
        exit();
40002381:	83 c4 10             	add    $0x10,%esp
}
40002384:	83 c4 1c             	add    $0x1c,%esp
40002387:	5b                   	pop    %ebx
40002388:	5e                   	pop    %esi
40002389:	5f                   	pop    %edi
4000238a:	5d                   	pop    %ebp
4000238b:	c3                   	ret    
4000238c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf("unlinked lf1 but it is still there!\n");
40002390:	83 ec 0c             	sub    $0xc,%esp
40002393:	8d 86 bc cf ff ff    	lea    -0x3044(%esi),%eax
40002399:	89 f3                	mov    %esi,%ebx
4000239b:	50                   	push   %eax
4000239c:	e8 9f df ff ff       	call   40000340 <printf>
        exit();
400023a1:	83 c4 10             	add    $0x10,%esp
400023a4:	eb be                	jmp    40002364 <linktest+0x154>
400023a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400023ad:	8d 76 00             	lea    0x0(%esi),%esi
        printf("open lf2 failed\n");
400023b0:	83 ec 0c             	sub    $0xc,%esp
400023b3:	8d 86 ae c8 ff ff    	lea    -0x3752(%esi),%eax
400023b9:	89 f3                	mov    %esi,%ebx
400023bb:	50                   	push   %eax
400023bc:	e8 7f df ff ff       	call   40000340 <printf>
        exit();
400023c1:	83 c4 10             	add    $0x10,%esp
400023c4:	eb 9e                	jmp    40002364 <linktest+0x154>
400023c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400023cd:	8d 76 00             	lea    0x0(%esi),%esi
        printf("read lf2 failed\n");
400023d0:	83 ec 0c             	sub    $0xc,%esp
400023d3:	8d 86 bf c8 ff ff    	lea    -0x3741(%esi),%eax
400023d9:	89 f3                	mov    %esi,%ebx
400023db:	50                   	push   %eax
400023dc:	e8 5f df ff ff       	call   40000340 <printf>
        exit();
400023e1:	83 c4 10             	add    $0x10,%esp
400023e4:	e9 7b ff ff ff       	jmp    40002364 <linktest+0x154>
        printf("link lf1 lf2 failed\n");
400023e9:	83 ec 0c             	sub    $0xc,%esp
400023ec:	8d 86 99 c8 ff ff    	lea    -0x3767(%esi),%eax
400023f2:	89 f3                	mov    %esi,%ebx
400023f4:	50                   	push   %eax
400023f5:	e8 46 df ff ff       	call   40000340 <printf>
        exit();
400023fa:	83 c4 10             	add    $0x10,%esp
400023fd:	e9 62 ff ff ff       	jmp    40002364 <linktest+0x154>
    asm volatile ("int %2"
40002402:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40002406:	b8 0a 00 00 00       	mov    $0xa,%eax
4000240b:	cd 30                	int    $0x30
    asm volatile ("int %2"
4000240d:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40002411:	89 d0                	mov    %edx,%eax
40002413:	89 f9                	mov    %edi,%ecx
40002415:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40002417:	85 c0                	test   %eax,%eax
40002419:	75 19                	jne    40002434 <linktest+0x224>
        printf("link non-existant succeeded! oops\n");
4000241b:	83 ec 0c             	sub    $0xc,%esp
4000241e:	8d 86 e4 cf ff ff    	lea    -0x301c(%esi),%eax
40002424:	89 f3                	mov    %esi,%ebx
40002426:	50                   	push   %eax
40002427:	e8 14 df ff ff       	call   40000340 <printf>
        exit();
4000242c:	83 c4 10             	add    $0x10,%esp
4000242f:	e9 30 ff ff ff       	jmp    40002364 <linktest+0x154>
    asm volatile ("int %2"
40002434:	8d 9e 60 c6 ff ff    	lea    -0x39a0(%esi),%ebx
4000243a:	89 d0                	mov    %edx,%eax
4000243c:	cd 30                	int    $0x30
    return errno ? -1 : 0;
4000243e:	85 c0                	test   %eax,%eax
40002440:	75 19                	jne    4000245b <linktest+0x24b>
        printf("link . lf1 succeeded! oops\n");
40002442:	83 ec 0c             	sub    $0xc,%esp
40002445:	8d 86 ee c8 ff ff    	lea    -0x3712(%esi),%eax
4000244b:	89 f3                	mov    %esi,%ebx
4000244d:	50                   	push   %eax
4000244e:	e8 ed de ff ff       	call   40000340 <printf>
        exit();
40002453:	83 c4 10             	add    $0x10,%esp
40002456:	e9 09 ff ff ff       	jmp    40002364 <linktest+0x154>
    printf("=====linktest ok=====\n\n");
4000245b:	83 ec 0c             	sub    $0xc,%esp
4000245e:	8d 86 0a c9 ff ff    	lea    -0x36f6(%esi),%eax
40002464:	89 f3                	mov    %esi,%ebx
40002466:	50                   	push   %eax
40002467:	e8 d4 de ff ff       	call   40000340 <printf>
4000246c:	83 c4 10             	add    $0x10,%esp
4000246f:	e9 f0 fe ff ff       	jmp    40002364 <linktest+0x154>
40002474:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000247b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
4000247f:	90                   	nop

40002480 <unlinkread>:
{
40002480:	55                   	push   %ebp
40002481:	57                   	push   %edi
40002482:	56                   	push   %esi
40002483:	e8 d3 06 00 00       	call   40002b5b <__x86.get_pc_thunk.si>
40002488:	81 c6 78 4b 00 00    	add    $0x4b78,%esi
4000248e:	53                   	push   %ebx
4000248f:	83 ec 28             	sub    $0x28,%esp
    printf("=====unlinkread test=====\n");
40002492:	8d 86 22 c9 ff ff    	lea    -0x36de(%esi),%eax
40002498:	89 f3                	mov    %esi,%ebx
    asm volatile ("int %2"
4000249a:	8d be 3d c9 ff ff    	lea    -0x36c3(%esi),%edi
400024a0:	50                   	push   %eax
400024a1:	e8 9a de ff ff       	call   40000340 <printf>
400024a6:	b8 03 00 00 00       	mov    $0x3,%eax
400024ab:	89 fb                	mov    %edi,%ebx
400024ad:	b9 02 02 00 00       	mov    $0x202,%ecx
400024b2:	cd 30                	int    $0x30
    if (fd < 0) {
400024b4:	83 c4 10             	add    $0x10,%esp
400024b7:	85 db                	test   %ebx,%ebx
400024b9:	0f 88 21 01 00 00    	js     400025e0 <unlinkread+0x160>
400024bf:	85 c0                	test   %eax,%eax
400024c1:	0f 85 19 01 00 00    	jne    400025e0 <unlinkread+0x160>
400024c7:	89 dd                	mov    %ebx,%ebp
    asm volatile ("int %2"
400024c9:	8d 8e 81 c8 ff ff    	lea    -0x377f(%esi),%ecx
400024cf:	b8 06 00 00 00       	mov    $0x6,%eax
400024d4:	ba 05 00 00 00       	mov    $0x5,%edx
400024d9:	cd 30                	int    $0x30
    asm volatile ("int %2"
400024db:	b8 04 00 00 00       	mov    $0x4,%eax
400024e0:	89 eb                	mov    %ebp,%ebx
400024e2:	cd 30                	int    $0x30
    asm volatile ("int %2"
400024e4:	b9 02 00 00 00       	mov    $0x2,%ecx
400024e9:	b8 03 00 00 00       	mov    $0x3,%eax
400024ee:	89 fb                	mov    %edi,%ebx
400024f0:	cd 30                	int    $0x30
400024f2:	89 dd                	mov    %ebx,%ebp
    if (fd < 0) {
400024f4:	85 db                	test   %ebx,%ebx
400024f6:	0f 88 04 01 00 00    	js     40002600 <unlinkread+0x180>
400024fc:	85 c0                	test   %eax,%eax
400024fe:	0f 85 fc 00 00 00    	jne    40002600 <unlinkread+0x180>
    asm volatile ("int %2"
40002504:	b8 0a 00 00 00       	mov    $0xa,%eax
40002509:	89 fb                	mov    %edi,%ebx
4000250b:	cd 30                	int    $0x30
    return errno ? -1 : 0;
4000250d:	85 c0                	test   %eax,%eax
4000250f:	0f 85 4b 01 00 00    	jne    40002660 <unlinkread+0x1e0>
    asm volatile ("int %2"
40002515:	b8 03 00 00 00       	mov    $0x3,%eax
4000251a:	89 fb                	mov    %edi,%ebx
4000251c:	b9 02 02 00 00       	mov    $0x202,%ecx
40002521:	cd 30                	int    $0x30
    return errno ? -1 : fd;
40002523:	85 c0                	test   %eax,%eax
40002525:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    asm volatile ("int %2"
4000252a:	8d 8e 94 c9 ff ff    	lea    -0x366c(%esi),%ecx
40002530:	ba 03 00 00 00       	mov    $0x3,%edx
    return errno ? -1 : fd;
40002535:	0f 44 c3             	cmove  %ebx,%eax
40002538:	89 c3                	mov    %eax,%ebx
    asm volatile ("int %2"
4000253a:	b8 06 00 00 00       	mov    $0x6,%eax
4000253f:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
40002543:	cd 30                	int    $0x30
    asm volatile ("int %2"
40002545:	b8 04 00 00 00       	mov    $0x4,%eax
4000254a:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
4000254e:	cd 30                	int    $0x30
    asm volatile ("int %2"
40002550:	ba 00 20 00 00       	mov    $0x2000,%edx
40002555:	8d 8e 40 00 00 00    	lea    0x40(%esi),%ecx
4000255b:	b8 05 00 00 00       	mov    $0x5,%eax
40002560:	89 eb                	mov    %ebp,%ebx
40002562:	cd 30                	int    $0x30
    if (read(fd, buf, sizeof(buf)) != 5) {
40002564:	83 fb 05             	cmp    $0x5,%ebx
40002567:	75 57                	jne    400025c0 <unlinkread+0x140>
40002569:	85 c0                	test   %eax,%eax
4000256b:	75 53                	jne    400025c0 <unlinkread+0x140>
    if (buf[0] != 'h') {
4000256d:	80 be 40 00 00 00 68 	cmpb   $0x68,0x40(%esi)
40002574:	0f 85 a6 00 00 00    	jne    40002620 <unlinkread+0x1a0>
    asm volatile ("int %2"
4000257a:	ba 0a 00 00 00       	mov    $0xa,%edx
4000257f:	b8 06 00 00 00       	mov    $0x6,%eax
40002584:	89 eb                	mov    %ebp,%ebx
40002586:	cd 30                	int    $0x30
    if (write(fd, buf, 10) != 10) {
40002588:	83 fb 0a             	cmp    $0xa,%ebx
4000258b:	0f 85 af 00 00 00    	jne    40002640 <unlinkread+0x1c0>
40002591:	85 c0                	test   %eax,%eax
40002593:	0f 85 a7 00 00 00    	jne    40002640 <unlinkread+0x1c0>
    asm volatile ("int %2"
40002599:	b8 04 00 00 00       	mov    $0x4,%eax
4000259e:	89 eb                	mov    %ebp,%ebx
400025a0:	cd 30                	int    $0x30
    asm volatile ("int %2"
400025a2:	89 d0                	mov    %edx,%eax
400025a4:	89 fb                	mov    %edi,%ebx
400025a6:	cd 30                	int    $0x30
    printf("=====unlinkread ok=====\n\n");
400025a8:	83 ec 0c             	sub    $0xc,%esp
400025ab:	8d 86 df c9 ff ff    	lea    -0x3621(%esi),%eax
400025b1:	89 f3                	mov    %esi,%ebx
400025b3:	50                   	push   %eax
400025b4:	e8 87 dd ff ff       	call   40000340 <printf>
400025b9:	83 c4 10             	add    $0x10,%esp
400025bc:	eb 16                	jmp    400025d4 <unlinkread+0x154>
400025be:	66 90                	xchg   %ax,%ax
        printf("unlinkread read failed");
400025c0:	83 ec 0c             	sub    $0xc,%esp
400025c3:	8d 86 98 c9 ff ff    	lea    -0x3668(%esi),%eax
400025c9:	89 f3                	mov    %esi,%ebx
400025cb:	50                   	push   %eax
400025cc:	e8 6f dd ff ff       	call   40000340 <printf>
        exit();
400025d1:	83 c4 10             	add    $0x10,%esp
}
400025d4:	83 c4 1c             	add    $0x1c,%esp
400025d7:	5b                   	pop    %ebx
400025d8:	5e                   	pop    %esi
400025d9:	5f                   	pop    %edi
400025da:	5d                   	pop    %ebp
400025db:	c3                   	ret    
400025dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf("create unlinkread failed\n");
400025e0:	83 ec 0c             	sub    $0xc,%esp
400025e3:	8d 86 48 c9 ff ff    	lea    -0x36b8(%esi),%eax
400025e9:	89 f3                	mov    %esi,%ebx
400025eb:	50                   	push   %eax
400025ec:	e8 4f dd ff ff       	call   40000340 <printf>
        exit();
400025f1:	83 c4 10             	add    $0x10,%esp
}
400025f4:	83 c4 1c             	add    $0x1c,%esp
400025f7:	5b                   	pop    %ebx
400025f8:	5e                   	pop    %esi
400025f9:	5f                   	pop    %edi
400025fa:	5d                   	pop    %ebp
400025fb:	c3                   	ret    
400025fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf("open unlinkread failed\n");
40002600:	83 ec 0c             	sub    $0xc,%esp
40002603:	8d 86 62 c9 ff ff    	lea    -0x369e(%esi),%eax
40002609:	89 f3                	mov    %esi,%ebx
4000260b:	50                   	push   %eax
4000260c:	e8 2f dd ff ff       	call   40000340 <printf>
        exit();
40002611:	83 c4 10             	add    $0x10,%esp
}
40002614:	83 c4 1c             	add    $0x1c,%esp
40002617:	5b                   	pop    %ebx
40002618:	5e                   	pop    %esi
40002619:	5f                   	pop    %edi
4000261a:	5d                   	pop    %ebp
4000261b:	c3                   	ret    
4000261c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf("unlinkread wrong data\n");
40002620:	83 ec 0c             	sub    $0xc,%esp
40002623:	8d 86 af c9 ff ff    	lea    -0x3651(%esi),%eax
40002629:	89 f3                	mov    %esi,%ebx
4000262b:	50                   	push   %eax
4000262c:	e8 0f dd ff ff       	call   40000340 <printf>
        exit();
40002631:	83 c4 10             	add    $0x10,%esp
40002634:	eb 9e                	jmp    400025d4 <unlinkread+0x154>
40002636:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
4000263d:	8d 76 00             	lea    0x0(%esi),%esi
        printf("unlinkread write failed\n");
40002640:	83 ec 0c             	sub    $0xc,%esp
40002643:	8d 86 c6 c9 ff ff    	lea    -0x363a(%esi),%eax
40002649:	89 f3                	mov    %esi,%ebx
4000264b:	50                   	push   %eax
4000264c:	e8 ef dc ff ff       	call   40000340 <printf>
        exit();
40002651:	83 c4 10             	add    $0x10,%esp
}
40002654:	83 c4 1c             	add    $0x1c,%esp
40002657:	5b                   	pop    %ebx
40002658:	5e                   	pop    %esi
40002659:	5f                   	pop    %edi
4000265a:	5d                   	pop    %ebp
4000265b:	c3                   	ret    
4000265c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf("unlink unlinkread failed\n");
40002660:	83 ec 0c             	sub    $0xc,%esp
40002663:	8d 86 7a c9 ff ff    	lea    -0x3686(%esi),%eax
40002669:	89 f3                	mov    %esi,%ebx
4000266b:	50                   	push   %eax
4000266c:	e8 cf dc ff ff       	call   40000340 <printf>
        exit();
40002671:	83 c4 10             	add    $0x10,%esp
40002674:	e9 5b ff ff ff       	jmp    400025d4 <unlinkread+0x154>
40002679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40002680 <dirfile>:
{
40002680:	55                   	push   %ebp
40002681:	57                   	push   %edi
    asm volatile ("int %2"
40002682:	bf 03 00 00 00       	mov    $0x3,%edi
40002687:	56                   	push   %esi
40002688:	e8 ce 04 00 00       	call   40002b5b <__x86.get_pc_thunk.si>
4000268d:	81 c6 73 49 00 00    	add    $0x4973,%esi
40002693:	53                   	push   %ebx
40002694:	83 ec 18             	sub    $0x18,%esp
    printf("=====dir vs file=====\n");
40002697:	8d 86 f9 c9 ff ff    	lea    -0x3607(%esi),%eax
4000269d:	89 f3                	mov    %esi,%ebx
4000269f:	50                   	push   %eax
400026a0:	e8 9b dc ff ff       	call   40000340 <printf>
400026a5:	8d 96 10 ca ff ff    	lea    -0x35f0(%esi),%edx
400026ab:	b9 00 02 00 00       	mov    $0x200,%ecx
400026b0:	89 f8                	mov    %edi,%eax
400026b2:	89 d3                	mov    %edx,%ebx
400026b4:	cd 30                	int    $0x30
    return errno ? -1 : fd;
400026b6:	83 c4 10             	add    $0x10,%esp
    if (fd < 0) {
400026b9:	85 c0                	test   %eax,%eax
400026bb:	75 3b                	jne    400026f8 <dirfile+0x78>
400026bd:	85 db                	test   %ebx,%ebx
400026bf:	78 37                	js     400026f8 <dirfile+0x78>
    asm volatile ("int %2"
400026c1:	b8 04 00 00 00       	mov    $0x4,%eax
400026c6:	cd 30                	int    $0x30
    asm volatile ("int %2"
400026c8:	b8 08 00 00 00       	mov    $0x8,%eax
400026cd:	89 d3                	mov    %edx,%ebx
400026cf:	cd 30                	int    $0x30
    return errno ? -1 : 0;
400026d1:	85 c0                	test   %eax,%eax
400026d3:	75 43                	jne    40002718 <dirfile+0x98>
        printf("chdir dirfile succeeded!\n");
400026d5:	83 ec 0c             	sub    $0xc,%esp
400026d8:	8d 86 2f ca ff ff    	lea    -0x35d1(%esi),%eax
400026de:	89 f3                	mov    %esi,%ebx
400026e0:	50                   	push   %eax
400026e1:	e8 5a dc ff ff       	call   40000340 <printf>
        exit();
400026e6:	83 c4 10             	add    $0x10,%esp
}
400026e9:	83 c4 0c             	add    $0xc,%esp
400026ec:	5b                   	pop    %ebx
400026ed:	5e                   	pop    %esi
400026ee:	5f                   	pop    %edi
400026ef:	5d                   	pop    %ebp
400026f0:	c3                   	ret    
400026f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf("create dirfile failed\n");
400026f8:	83 ec 0c             	sub    $0xc,%esp
400026fb:	8d 86 18 ca ff ff    	lea    -0x35e8(%esi),%eax
40002701:	89 f3                	mov    %esi,%ebx
40002703:	50                   	push   %eax
40002704:	e8 37 dc ff ff       	call   40000340 <printf>
        exit();
40002709:	83 c4 10             	add    $0x10,%esp
}
4000270c:	83 c4 0c             	add    $0xc,%esp
4000270f:	5b                   	pop    %ebx
40002710:	5e                   	pop    %esi
40002711:	5f                   	pop    %edi
40002712:	5d                   	pop    %ebp
40002713:	c3                   	ret    
40002714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    asm volatile ("int %2"
40002718:	8d ae 49 ca ff ff    	lea    -0x35b7(%esi),%ebp
4000271e:	31 c9                	xor    %ecx,%ecx
40002720:	89 f8                	mov    %edi,%eax
40002722:	89 eb                	mov    %ebp,%ebx
40002724:	cd 30                	int    $0x30
    if (fd >= 0) {
40002726:	85 db                	test   %ebx,%ebx
40002728:	78 04                	js     4000272e <dirfile+0xae>
4000272a:	85 c0                	test   %eax,%eax
4000272c:	74 39                	je     40002767 <dirfile+0xe7>
4000272e:	b8 03 00 00 00       	mov    $0x3,%eax
40002733:	b9 00 02 00 00       	mov    $0x200,%ecx
40002738:	89 eb                	mov    %ebp,%ebx
4000273a:	cd 30                	int    $0x30
    if (fd >= 0) {
4000273c:	85 db                	test   %ebx,%ebx
4000273e:	78 04                	js     40002744 <dirfile+0xc4>
40002740:	85 c0                	test   %eax,%eax
40002742:	74 23                	je     40002767 <dirfile+0xe7>
    asm volatile ("int %2"
40002744:	b8 07 00 00 00       	mov    $0x7,%eax
40002749:	89 eb                	mov    %ebp,%ebx
4000274b:	cd 30                	int    $0x30
    return errno ? -1 : 0;
4000274d:	85 c0                	test   %eax,%eax
4000274f:	75 2f                	jne    40002780 <dirfile+0x100>
        printf("mkdir dirfile/xx succeeded!\n");
40002751:	83 ec 0c             	sub    $0xc,%esp
40002754:	8d 86 72 ca ff ff    	lea    -0x358e(%esi),%eax
4000275a:	89 f3                	mov    %esi,%ebx
4000275c:	50                   	push   %eax
4000275d:	e8 de db ff ff       	call   40000340 <printf>
        exit();
40002762:	83 c4 10             	add    $0x10,%esp
40002765:	eb 82                	jmp    400026e9 <dirfile+0x69>
        printf("create dirfile/xx succeeded!\n");
40002767:	83 ec 0c             	sub    $0xc,%esp
4000276a:	8d 86 54 ca ff ff    	lea    -0x35ac(%esi),%eax
40002770:	89 f3                	mov    %esi,%ebx
40002772:	50                   	push   %eax
40002773:	e8 c8 db ff ff       	call   40000340 <printf>
        exit();
40002778:	83 c4 10             	add    $0x10,%esp
4000277b:	e9 69 ff ff ff       	jmp    400026e9 <dirfile+0x69>
    asm volatile ("int %2"
40002780:	bf 0a 00 00 00       	mov    $0xa,%edi
40002785:	89 eb                	mov    %ebp,%ebx
40002787:	89 f8                	mov    %edi,%eax
40002789:	cd 30                	int    $0x30
    return errno ? -1 : 0;
4000278b:	85 c0                	test   %eax,%eax
4000278d:	75 19                	jne    400027a8 <dirfile+0x128>
        printf("unlink dirfile/xx succeeded!\n");
4000278f:	83 ec 0c             	sub    $0xc,%esp
40002792:	8d 86 8f ca ff ff    	lea    -0x3571(%esi),%eax
40002798:	89 f3                	mov    %esi,%ebx
4000279a:	50                   	push   %eax
4000279b:	e8 a0 db ff ff       	call   40000340 <printf>
        exit();
400027a0:	83 c4 10             	add    $0x10,%esp
400027a3:	e9 41 ff ff ff       	jmp    400026e9 <dirfile+0x69>
    asm volatile ("int %2"
400027a8:	b8 09 00 00 00       	mov    $0x9,%eax
400027ad:	8d 9e ad ca ff ff    	lea    -0x3553(%esi),%ebx
400027b3:	89 e9                	mov    %ebp,%ecx
400027b5:	cd 30                	int    $0x30
    return errno ? -1 : 0;
400027b7:	85 c0                	test   %eax,%eax
400027b9:	75 19                	jne    400027d4 <dirfile+0x154>
        printf("link to dirfile/xx succeeded!\n");
400027bb:	83 ec 0c             	sub    $0xc,%esp
400027be:	8d 86 08 d0 ff ff    	lea    -0x2ff8(%esi),%eax
400027c4:	89 f3                	mov    %esi,%ebx
400027c6:	50                   	push   %eax
400027c7:	e8 74 db ff ff       	call   40000340 <printf>
        exit();
400027cc:	83 c4 10             	add    $0x10,%esp
400027cf:	e9 15 ff ff ff       	jmp    400026e9 <dirfile+0x69>
    asm volatile ("int %2"
400027d4:	89 f8                	mov    %edi,%eax
400027d6:	89 d3                	mov    %edx,%ebx
400027d8:	cd 30                	int    $0x30
    return errno ? -1 : 0;
400027da:	85 c0                	test   %eax,%eax
400027dc:	0f 85 8e 00 00 00    	jne    40002870 <dirfile+0x1f0>
    asm volatile ("int %2"
400027e2:	8d 96 60 c6 ff ff    	lea    -0x39a0(%esi),%edx
400027e8:	b8 03 00 00 00       	mov    $0x3,%eax
400027ed:	b9 02 00 00 00       	mov    $0x2,%ecx
400027f2:	89 d3                	mov    %edx,%ebx
400027f4:	cd 30                	int    $0x30
    if (fd >= 0) {
400027f6:	85 db                	test   %ebx,%ebx
400027f8:	78 08                	js     40002802 <dirfile+0x182>
400027fa:	85 c0                	test   %eax,%eax
400027fc:	0f 84 87 00 00 00    	je     40002889 <dirfile+0x209>
40002802:	b8 03 00 00 00       	mov    $0x3,%eax
40002807:	31 c9                	xor    %ecx,%ecx
40002809:	89 d3                	mov    %edx,%ebx
4000280b:	cd 30                	int    $0x30
    return errno ? -1 : fd;
4000280d:	85 c0                	test   %eax,%eax
4000280f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    asm volatile ("int %2"
40002814:	8d 8e 43 c7 ff ff    	lea    -0x38bd(%esi),%ecx
4000281a:	ba 01 00 00 00       	mov    $0x1,%edx
    return errno ? -1 : fd;
4000281f:	0f 44 c3             	cmove  %ebx,%eax
40002822:	89 c7                	mov    %eax,%edi
    asm volatile ("int %2"
40002824:	b8 06 00 00 00       	mov    $0x6,%eax
40002829:	89 fb                	mov    %edi,%ebx
4000282b:	cd 30                	int    $0x30
    return errno ? -1 : ret;
4000282d:	85 c0                	test   %eax,%eax
4000282f:	75 04                	jne    40002835 <dirfile+0x1b5>
    if (write(fd, "x", 1) > 0) {
40002831:	85 db                	test   %ebx,%ebx
40002833:	7f 22                	jg     40002857 <dirfile+0x1d7>
    asm volatile ("int %2"
40002835:	b8 04 00 00 00       	mov    $0x4,%eax
4000283a:	89 fb                	mov    %edi,%ebx
4000283c:	cd 30                	int    $0x30
    printf("=====dir vs file OK=====\n\n");
4000283e:	83 ec 0c             	sub    $0xc,%esp
40002841:	8d 86 e0 ca ff ff    	lea    -0x3520(%esi),%eax
40002847:	89 f3                	mov    %esi,%ebx
40002849:	50                   	push   %eax
4000284a:	e8 f1 da ff ff       	call   40000340 <printf>
4000284f:	83 c4 10             	add    $0x10,%esp
40002852:	e9 92 fe ff ff       	jmp    400026e9 <dirfile+0x69>
        printf("write . succeeded!\n");
40002857:	83 ec 0c             	sub    $0xc,%esp
4000285a:	8d 86 cc ca ff ff    	lea    -0x3534(%esi),%eax
40002860:	89 f3                	mov    %esi,%ebx
40002862:	50                   	push   %eax
40002863:	e8 d8 da ff ff       	call   40000340 <printf>
        exit();
40002868:	83 c4 10             	add    $0x10,%esp
4000286b:	e9 79 fe ff ff       	jmp    400026e9 <dirfile+0x69>
        printf("unlink dirfile failed!\n");
40002870:	83 ec 0c             	sub    $0xc,%esp
40002873:	8d 86 b4 ca ff ff    	lea    -0x354c(%esi),%eax
40002879:	89 f3                	mov    %esi,%ebx
4000287b:	50                   	push   %eax
4000287c:	e8 bf da ff ff       	call   40000340 <printf>
        exit();
40002881:	83 c4 10             	add    $0x10,%esp
40002884:	e9 60 fe ff ff       	jmp    400026e9 <dirfile+0x69>
        printf("open . for writing succeeded!\n");
40002889:	83 ec 0c             	sub    $0xc,%esp
4000288c:	8d 86 28 d0 ff ff    	lea    -0x2fd8(%esi),%eax
40002892:	89 f3                	mov    %esi,%ebx
40002894:	50                   	push   %eax
40002895:	e8 a6 da ff ff       	call   40000340 <printf>
        exit();
4000289a:	83 c4 10             	add    $0x10,%esp
4000289d:	e9 47 fe ff ff       	jmp    400026e9 <dirfile+0x69>
400028a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
400028a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

400028b0 <iref>:
{
400028b0:	55                   	push   %ebp
    printf("=====empty file name=====\n");
400028b1:	bd 33 00 00 00       	mov    $0x33,%ebp
{
400028b6:	57                   	push   %edi
400028b7:	e8 a3 02 00 00       	call   40002b5f <__x86.get_pc_thunk.di>
400028bc:	81 c7 44 47 00 00    	add    $0x4744,%edi
400028c2:	56                   	push   %esi
400028c3:	53                   	push   %ebx
400028c4:	83 ec 28             	sub    $0x28,%esp
    printf("=====empty file name=====\n");
400028c7:	8d 87 fb ca ff ff    	lea    -0x3505(%edi),%eax
400028cd:	89 fb                	mov    %edi,%ebx
400028cf:	50                   	push   %eax
400028d0:	e8 6b da ff ff       	call   40000340 <printf>
400028d5:	83 c4 10             	add    $0x10,%esp
400028d8:	8d 87 16 cb ff ff    	lea    -0x34ea(%edi),%eax
    asm volatile ("int %2"
400028de:	8d 97 fa ca ff ff    	lea    -0x3506(%edi),%edx
400028e4:	89 44 24 08          	mov    %eax,0x8(%esp)
    asm volatile ("int %2"
400028e8:	8d 87 ad ca ff ff    	lea    -0x3553(%edi),%eax
400028ee:	89 44 24 0c          	mov    %eax,0xc(%esp)
400028f2:	eb 78                	jmp    4000296c <iref+0xbc>
400028f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    asm volatile ("int %2"
400028f8:	8b 5c 24 08          	mov    0x8(%esp),%ebx
400028fc:	b8 08 00 00 00       	mov    $0x8,%eax
40002901:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40002903:	85 c0                	test   %eax,%eax
40002905:	0f 85 c5 00 00 00    	jne    400029d0 <iref+0x120>
    asm volatile ("int %2"
4000290b:	89 c8                	mov    %ecx,%eax
4000290d:	89 d3                	mov    %edx,%ebx
4000290f:	cd 30                	int    $0x30
    asm volatile ("int %2"
40002911:	b8 09 00 00 00       	mov    $0x9,%eax
40002916:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
4000291a:	89 d1                	mov    %edx,%ecx
4000291c:	cd 30                	int    $0x30
    asm volatile ("int %2"
4000291e:	b8 03 00 00 00       	mov    $0x3,%eax
40002923:	b9 00 02 00 00       	mov    $0x200,%ecx
40002928:	89 d3                	mov    %edx,%ebx
4000292a:	cd 30                	int    $0x30
        if (fd >= 0)
4000292c:	85 c0                	test   %eax,%eax
4000292e:	75 0b                	jne    4000293b <iref+0x8b>
40002930:	85 db                	test   %ebx,%ebx
40002932:	78 07                	js     4000293b <iref+0x8b>
    asm volatile ("int %2"
40002934:	b8 04 00 00 00       	mov    $0x4,%eax
40002939:	cd 30                	int    $0x30
    asm volatile ("int %2"
4000293b:	8d b7 42 c7 ff ff    	lea    -0x38be(%edi),%esi
40002941:	b8 03 00 00 00       	mov    $0x3,%eax
40002946:	b9 00 02 00 00       	mov    $0x200,%ecx
4000294b:	89 f3                	mov    %esi,%ebx
4000294d:	cd 30                	int    $0x30
        if (fd >= 0)
4000294f:	85 c0                	test   %eax,%eax
40002951:	75 0b                	jne    4000295e <iref+0xae>
40002953:	85 db                	test   %ebx,%ebx
40002955:	78 07                	js     4000295e <iref+0xae>
    asm volatile ("int %2"
40002957:	b8 04 00 00 00       	mov    $0x4,%eax
4000295c:	cd 30                	int    $0x30
    asm volatile ("int %2"
4000295e:	b8 0a 00 00 00       	mov    $0xa,%eax
40002963:	89 f3                	mov    %esi,%ebx
40002965:	cd 30                	int    $0x30
    for (i = 0; i < 50 + 1; i++) {
40002967:	83 ed 01             	sub    $0x1,%ebp
4000296a:	74 34                	je     400029a0 <iref+0xf0>
    asm volatile ("int %2"
4000296c:	b9 07 00 00 00       	mov    $0x7,%ecx
40002971:	8b 5c 24 08          	mov    0x8(%esp),%ebx
40002975:	89 c8                	mov    %ecx,%eax
40002977:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40002979:	85 c0                	test   %eax,%eax
4000297b:	0f 84 77 ff ff ff    	je     400028f8 <iref+0x48>
            printf("mkdir irefd failed\n");
40002981:	83 ec 0c             	sub    $0xc,%esp
40002984:	8d 87 1c cb ff ff    	lea    -0x34e4(%edi),%eax
4000298a:	89 fb                	mov    %edi,%ebx
4000298c:	50                   	push   %eax
4000298d:	e8 ae d9 ff ff       	call   40000340 <printf>
            exit();
40002992:	83 c4 10             	add    $0x10,%esp
}
40002995:	83 c4 1c             	add    $0x1c,%esp
40002998:	5b                   	pop    %ebx
40002999:	5e                   	pop    %esi
4000299a:	5f                   	pop    %edi
4000299b:	5d                   	pop    %ebp
4000299c:	c3                   	ret    
4000299d:	8d 76 00             	lea    0x0(%esi),%esi
    asm volatile ("int %2"
400029a0:	b8 08 00 00 00       	mov    $0x8,%eax
400029a5:	8d 9f 72 c3 ff ff    	lea    -0x3c8e(%edi),%ebx
400029ab:	cd 30                	int    $0x30
    printf("=====empty file name OK=====\n\n");
400029ad:	83 ec 0c             	sub    $0xc,%esp
400029b0:	8d 87 48 d0 ff ff    	lea    -0x2fb8(%edi),%eax
400029b6:	89 fb                	mov    %edi,%ebx
400029b8:	50                   	push   %eax
400029b9:	e8 82 d9 ff ff       	call   40000340 <printf>
400029be:	83 c4 10             	add    $0x10,%esp
}
400029c1:	83 c4 1c             	add    $0x1c,%esp
400029c4:	5b                   	pop    %ebx
400029c5:	5e                   	pop    %esi
400029c6:	5f                   	pop    %edi
400029c7:	5d                   	pop    %ebp
400029c8:	c3                   	ret    
400029c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            printf("chdir irefd failed\n");
400029d0:	83 ec 0c             	sub    $0xc,%esp
400029d3:	8d 87 30 cb ff ff    	lea    -0x34d0(%edi),%eax
400029d9:	89 fb                	mov    %edi,%ebx
400029db:	50                   	push   %eax
400029dc:	e8 5f d9 ff ff       	call   40000340 <printf>
            exit();
400029e1:	83 c4 10             	add    $0x10,%esp
}
400029e4:	83 c4 1c             	add    $0x1c,%esp
400029e7:	5b                   	pop    %ebx
400029e8:	5e                   	pop    %esi
400029e9:	5f                   	pop    %edi
400029ea:	5d                   	pop    %ebp
400029eb:	c3                   	ret    
400029ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

400029f0 <bigdir>:
{
400029f0:	55                   	push   %ebp
400029f1:	57                   	push   %edi
400029f2:	56                   	push   %esi
400029f3:	e8 63 01 00 00       	call   40002b5b <__x86.get_pc_thunk.si>
400029f8:	81 c6 08 46 00 00    	add    $0x4608,%esi
400029fe:	53                   	push   %ebx
400029ff:	83 ec 28             	sub    $0x28,%esp
    printf("=====bigdir test=====\n");
40002a02:	8d 86 44 cb ff ff    	lea    -0x34bc(%esi),%eax
40002a08:	89 f3                	mov    %esi,%ebx
40002a0a:	50                   	push   %eax
40002a0b:	e8 30 d9 ff ff       	call   40000340 <printf>
    asm volatile ("int %2"
40002a10:	8d 9e 5b cb ff ff    	lea    -0x34a5(%esi),%ebx
40002a16:	b8 0a 00 00 00       	mov    $0xa,%eax
40002a1b:	89 5c 24 1c          	mov    %ebx,0x1c(%esp)
40002a1f:	cd 30                	int    $0x30
    asm volatile ("int %2"
40002a21:	b8 03 00 00 00       	mov    $0x3,%eax
40002a26:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
40002a2a:	b9 00 02 00 00       	mov    $0x200,%ecx
40002a2f:	cd 30                	int    $0x30
    return errno ? -1 : fd;
40002a31:	83 c4 10             	add    $0x10,%esp
    if (fd < 0) {
40002a34:	85 c0                	test   %eax,%eax
40002a36:	0f 85 7c 00 00 00    	jne    40002ab8 <bigdir+0xc8>
40002a3c:	85 db                	test   %ebx,%ebx
40002a3e:	78 78                	js     40002ab8 <bigdir+0xc8>
    asm volatile ("int %2"
40002a40:	b8 04 00 00 00       	mov    $0x4,%eax
40002a45:	cd 30                	int    $0x30
40002a47:	31 ed                	xor    %ebp,%ebp
    asm volatile ("int %2"
40002a49:	8b 54 24 0c          	mov    0xc(%esp),%edx
40002a4d:	8d 3d 20 00 00 00    	lea    0x20,%edi
40002a53:	8d 8e 20 00 00 00    	lea    0x20(%esi),%ecx
40002a59:	eb 10                	jmp    40002a6b <bigdir+0x7b>
40002a5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40002a5f:	90                   	nop
    for (i = 0; i < 500; i++) {
40002a60:	83 c5 01             	add    $0x1,%ebp
40002a63:	81 fd f4 01 00 00    	cmp    $0x1f4,%ebp
40002a69:	74 69                	je     40002ad4 <bigdir+0xe4>
        namel[1] = '0' + (i / 64);
40002a6b:	89 e8                	mov    %ebp,%eax
        namel[0] = 'x';
40002a6d:	c6 04 37 78          	movb   $0x78,(%edi,%esi,1)
40002a71:	89 d3                	mov    %edx,%ebx
        namel[1] = '0' + (i / 64);
40002a73:	c1 f8 06             	sar    $0x6,%eax
        namel[3] = '\0';
40002a76:	c6 44 37 03 00       	movb   $0x0,0x3(%edi,%esi,1)
        namel[1] = '0' + (i / 64);
40002a7b:	83 c0 30             	add    $0x30,%eax
40002a7e:	88 44 37 01          	mov    %al,0x1(%edi,%esi,1)
        namel[2] = '0' + (i % 64);
40002a82:	89 e8                	mov    %ebp,%eax
40002a84:	83 e0 3f             	and    $0x3f,%eax
40002a87:	83 c0 30             	add    $0x30,%eax
40002a8a:	88 44 37 02          	mov    %al,0x2(%edi,%esi,1)
40002a8e:	b8 09 00 00 00       	mov    $0x9,%eax
40002a93:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40002a95:	85 c0                	test   %eax,%eax
40002a97:	74 c7                	je     40002a60 <bigdir+0x70>
            printf("bigdir link failed\n");
40002a99:	83 ec 0c             	sub    $0xc,%esp
40002a9c:	8d 86 74 cb ff ff    	lea    -0x348c(%esi),%eax
40002aa2:	89 f3                	mov    %esi,%ebx
40002aa4:	50                   	push   %eax
40002aa5:	e8 96 d8 ff ff       	call   40000340 <printf>
            exit();
40002aaa:	83 c4 10             	add    $0x10,%esp
}
40002aad:	83 c4 1c             	add    $0x1c,%esp
40002ab0:	5b                   	pop    %ebx
40002ab1:	5e                   	pop    %esi
40002ab2:	5f                   	pop    %edi
40002ab3:	5d                   	pop    %ebp
40002ab4:	c3                   	ret    
40002ab5:	8d 76 00             	lea    0x0(%esi),%esi
        printf("bigdir create failed\n");
40002ab8:	83 ec 0c             	sub    $0xc,%esp
40002abb:	8d 86 5e cb ff ff    	lea    -0x34a2(%esi),%eax
40002ac1:	89 f3                	mov    %esi,%ebx
40002ac3:	50                   	push   %eax
40002ac4:	e8 77 d8 ff ff       	call   40000340 <printf>
        exit();
40002ac9:	83 c4 10             	add    $0x10,%esp
}
40002acc:	83 c4 1c             	add    $0x1c,%esp
40002acf:	5b                   	pop    %ebx
40002ad0:	5e                   	pop    %esi
40002ad1:	5f                   	pop    %edi
40002ad2:	5d                   	pop    %ebp
40002ad3:	c3                   	ret    
40002ad4:	89 c2                	mov    %eax,%edx
    asm volatile ("int %2"
40002ad6:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40002ada:	b8 0a 00 00 00       	mov    $0xa,%eax
40002adf:	cd 30                	int    $0x30
40002ae1:	bd 0a 00 00 00       	mov    $0xa,%ebp
40002ae6:	eb 13                	jmp    40002afb <bigdir+0x10b>
40002ae8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40002aef:	90                   	nop
    for (i = 0; i < 500; i++) {
40002af0:	83 c2 01             	add    $0x1,%edx
40002af3:	81 fa f4 01 00 00    	cmp    $0x1f4,%edx
40002af9:	74 47                	je     40002b42 <bigdir+0x152>
        namel[1] = '0' + (i / 64);
40002afb:	89 d0                	mov    %edx,%eax
        namel[0] = 'x';
40002afd:	c6 04 37 78          	movb   $0x78,(%edi,%esi,1)
40002b01:	89 cb                	mov    %ecx,%ebx
        namel[1] = '0' + (i / 64);
40002b03:	c1 f8 06             	sar    $0x6,%eax
        namel[3] = '\0';
40002b06:	c6 44 37 03 00       	movb   $0x0,0x3(%edi,%esi,1)
        namel[1] = '0' + (i / 64);
40002b0b:	83 c0 30             	add    $0x30,%eax
40002b0e:	88 44 37 01          	mov    %al,0x1(%edi,%esi,1)
        namel[2] = '0' + (i % 64);
40002b12:	89 d0                	mov    %edx,%eax
40002b14:	83 e0 3f             	and    $0x3f,%eax
40002b17:	83 c0 30             	add    $0x30,%eax
40002b1a:	88 44 37 02          	mov    %al,0x2(%edi,%esi,1)
40002b1e:	89 e8                	mov    %ebp,%eax
40002b20:	cd 30                	int    $0x30
    return errno ? -1 : 0;
40002b22:	85 c0                	test   %eax,%eax
40002b24:	74 ca                	je     40002af0 <bigdir+0x100>
            printf("bigdir unlink failed");
40002b26:	83 ec 0c             	sub    $0xc,%esp
40002b29:	8d 86 88 cb ff ff    	lea    -0x3478(%esi),%eax
40002b2f:	89 f3                	mov    %esi,%ebx
40002b31:	50                   	push   %eax
40002b32:	e8 09 d8 ff ff       	call   40000340 <printf>
            exit();
40002b37:	83 c4 10             	add    $0x10,%esp
}
40002b3a:	83 c4 1c             	add    $0x1c,%esp
40002b3d:	5b                   	pop    %ebx
40002b3e:	5e                   	pop    %esi
40002b3f:	5f                   	pop    %edi
40002b40:	5d                   	pop    %ebp
40002b41:	c3                   	ret    
    printf("=====bigdir ok=====\n\n");
40002b42:	83 ec 0c             	sub    $0xc,%esp
40002b45:	8d 86 9d cb ff ff    	lea    -0x3463(%esi),%eax
40002b4b:	89 f3                	mov    %esi,%ebx
40002b4d:	50                   	push   %eax
40002b4e:	e8 ed d7 ff ff       	call   40000340 <printf>
40002b53:	83 c4 10             	add    $0x10,%esp
40002b56:	e9 52 ff ff ff       	jmp    40002aad <bigdir+0xbd>

40002b5b <__x86.get_pc_thunk.si>:
40002b5b:	8b 34 24             	mov    (%esp),%esi
40002b5e:	c3                   	ret    

40002b5f <__x86.get_pc_thunk.di>:
40002b5f:	8b 3c 24             	mov    (%esp),%edi
40002b62:	c3                   	ret    

40002b63 <__x86.get_pc_thunk.bp>:
40002b63:	8b 2c 24             	mov    (%esp),%ebp
40002b66:	c3                   	ret    
40002b67:	66 90                	xchg   %ax,%ax
40002b69:	66 90                	xchg   %ax,%ax
40002b6b:	66 90                	xchg   %ax,%ax
40002b6d:	66 90                	xchg   %ax,%ax
40002b6f:	90                   	nop

40002b70 <__udivdi3>:
40002b70:	f3 0f 1e fb          	endbr32 
40002b74:	55                   	push   %ebp
40002b75:	57                   	push   %edi
40002b76:	56                   	push   %esi
40002b77:	53                   	push   %ebx
40002b78:	83 ec 1c             	sub    $0x1c,%esp
40002b7b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
40002b7f:	8b 6c 24 30          	mov    0x30(%esp),%ebp
40002b83:	8b 74 24 34          	mov    0x34(%esp),%esi
40002b87:	8b 5c 24 38          	mov    0x38(%esp),%ebx
40002b8b:	85 c0                	test   %eax,%eax
40002b8d:	75 19                	jne    40002ba8 <__udivdi3+0x38>
40002b8f:	39 f3                	cmp    %esi,%ebx
40002b91:	76 4d                	jbe    40002be0 <__udivdi3+0x70>
40002b93:	31 ff                	xor    %edi,%edi
40002b95:	89 e8                	mov    %ebp,%eax
40002b97:	89 f2                	mov    %esi,%edx
40002b99:	f7 f3                	div    %ebx
40002b9b:	89 fa                	mov    %edi,%edx
40002b9d:	83 c4 1c             	add    $0x1c,%esp
40002ba0:	5b                   	pop    %ebx
40002ba1:	5e                   	pop    %esi
40002ba2:	5f                   	pop    %edi
40002ba3:	5d                   	pop    %ebp
40002ba4:	c3                   	ret    
40002ba5:	8d 76 00             	lea    0x0(%esi),%esi
40002ba8:	39 f0                	cmp    %esi,%eax
40002baa:	76 14                	jbe    40002bc0 <__udivdi3+0x50>
40002bac:	31 ff                	xor    %edi,%edi
40002bae:	31 c0                	xor    %eax,%eax
40002bb0:	89 fa                	mov    %edi,%edx
40002bb2:	83 c4 1c             	add    $0x1c,%esp
40002bb5:	5b                   	pop    %ebx
40002bb6:	5e                   	pop    %esi
40002bb7:	5f                   	pop    %edi
40002bb8:	5d                   	pop    %ebp
40002bb9:	c3                   	ret    
40002bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40002bc0:	0f bd f8             	bsr    %eax,%edi
40002bc3:	83 f7 1f             	xor    $0x1f,%edi
40002bc6:	75 48                	jne    40002c10 <__udivdi3+0xa0>
40002bc8:	39 f0                	cmp    %esi,%eax
40002bca:	72 06                	jb     40002bd2 <__udivdi3+0x62>
40002bcc:	31 c0                	xor    %eax,%eax
40002bce:	39 eb                	cmp    %ebp,%ebx
40002bd0:	77 de                	ja     40002bb0 <__udivdi3+0x40>
40002bd2:	b8 01 00 00 00       	mov    $0x1,%eax
40002bd7:	eb d7                	jmp    40002bb0 <__udivdi3+0x40>
40002bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40002be0:	89 d9                	mov    %ebx,%ecx
40002be2:	85 db                	test   %ebx,%ebx
40002be4:	75 0b                	jne    40002bf1 <__udivdi3+0x81>
40002be6:	b8 01 00 00 00       	mov    $0x1,%eax
40002beb:	31 d2                	xor    %edx,%edx
40002bed:	f7 f3                	div    %ebx
40002bef:	89 c1                	mov    %eax,%ecx
40002bf1:	31 d2                	xor    %edx,%edx
40002bf3:	89 f0                	mov    %esi,%eax
40002bf5:	f7 f1                	div    %ecx
40002bf7:	89 c6                	mov    %eax,%esi
40002bf9:	89 e8                	mov    %ebp,%eax
40002bfb:	89 f7                	mov    %esi,%edi
40002bfd:	f7 f1                	div    %ecx
40002bff:	89 fa                	mov    %edi,%edx
40002c01:	83 c4 1c             	add    $0x1c,%esp
40002c04:	5b                   	pop    %ebx
40002c05:	5e                   	pop    %esi
40002c06:	5f                   	pop    %edi
40002c07:	5d                   	pop    %ebp
40002c08:	c3                   	ret    
40002c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40002c10:	89 f9                	mov    %edi,%ecx
40002c12:	ba 20 00 00 00       	mov    $0x20,%edx
40002c17:	29 fa                	sub    %edi,%edx
40002c19:	d3 e0                	shl    %cl,%eax
40002c1b:	89 44 24 08          	mov    %eax,0x8(%esp)
40002c1f:	89 d1                	mov    %edx,%ecx
40002c21:	89 d8                	mov    %ebx,%eax
40002c23:	d3 e8                	shr    %cl,%eax
40002c25:	8b 4c 24 08          	mov    0x8(%esp),%ecx
40002c29:	09 c1                	or     %eax,%ecx
40002c2b:	89 f0                	mov    %esi,%eax
40002c2d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
40002c31:	89 f9                	mov    %edi,%ecx
40002c33:	d3 e3                	shl    %cl,%ebx
40002c35:	89 d1                	mov    %edx,%ecx
40002c37:	d3 e8                	shr    %cl,%eax
40002c39:	89 f9                	mov    %edi,%ecx
40002c3b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
40002c3f:	89 eb                	mov    %ebp,%ebx
40002c41:	d3 e6                	shl    %cl,%esi
40002c43:	89 d1                	mov    %edx,%ecx
40002c45:	d3 eb                	shr    %cl,%ebx
40002c47:	09 f3                	or     %esi,%ebx
40002c49:	89 c6                	mov    %eax,%esi
40002c4b:	89 f2                	mov    %esi,%edx
40002c4d:	89 d8                	mov    %ebx,%eax
40002c4f:	f7 74 24 08          	divl   0x8(%esp)
40002c53:	89 d6                	mov    %edx,%esi
40002c55:	89 c3                	mov    %eax,%ebx
40002c57:	f7 64 24 0c          	mull   0xc(%esp)
40002c5b:	39 d6                	cmp    %edx,%esi
40002c5d:	72 19                	jb     40002c78 <__udivdi3+0x108>
40002c5f:	89 f9                	mov    %edi,%ecx
40002c61:	d3 e5                	shl    %cl,%ebp
40002c63:	39 c5                	cmp    %eax,%ebp
40002c65:	73 04                	jae    40002c6b <__udivdi3+0xfb>
40002c67:	39 d6                	cmp    %edx,%esi
40002c69:	74 0d                	je     40002c78 <__udivdi3+0x108>
40002c6b:	89 d8                	mov    %ebx,%eax
40002c6d:	31 ff                	xor    %edi,%edi
40002c6f:	e9 3c ff ff ff       	jmp    40002bb0 <__udivdi3+0x40>
40002c74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
40002c78:	8d 43 ff             	lea    -0x1(%ebx),%eax
40002c7b:	31 ff                	xor    %edi,%edi
40002c7d:	e9 2e ff ff ff       	jmp    40002bb0 <__udivdi3+0x40>
40002c82:	66 90                	xchg   %ax,%ax
40002c84:	66 90                	xchg   %ax,%ax
40002c86:	66 90                	xchg   %ax,%ax
40002c88:	66 90                	xchg   %ax,%ax
40002c8a:	66 90                	xchg   %ax,%ax
40002c8c:	66 90                	xchg   %ax,%ax
40002c8e:	66 90                	xchg   %ax,%ax

40002c90 <__umoddi3>:
40002c90:	f3 0f 1e fb          	endbr32 
40002c94:	55                   	push   %ebp
40002c95:	57                   	push   %edi
40002c96:	56                   	push   %esi
40002c97:	53                   	push   %ebx
40002c98:	83 ec 1c             	sub    $0x1c,%esp
40002c9b:	8b 74 24 30          	mov    0x30(%esp),%esi
40002c9f:	8b 5c 24 34          	mov    0x34(%esp),%ebx
40002ca3:	8b 7c 24 3c          	mov    0x3c(%esp),%edi
40002ca7:	8b 6c 24 38          	mov    0x38(%esp),%ebp
40002cab:	89 f0                	mov    %esi,%eax
40002cad:	89 da                	mov    %ebx,%edx
40002caf:	85 ff                	test   %edi,%edi
40002cb1:	75 15                	jne    40002cc8 <__umoddi3+0x38>
40002cb3:	39 dd                	cmp    %ebx,%ebp
40002cb5:	76 39                	jbe    40002cf0 <__umoddi3+0x60>
40002cb7:	f7 f5                	div    %ebp
40002cb9:	89 d0                	mov    %edx,%eax
40002cbb:	31 d2                	xor    %edx,%edx
40002cbd:	83 c4 1c             	add    $0x1c,%esp
40002cc0:	5b                   	pop    %ebx
40002cc1:	5e                   	pop    %esi
40002cc2:	5f                   	pop    %edi
40002cc3:	5d                   	pop    %ebp
40002cc4:	c3                   	ret    
40002cc5:	8d 76 00             	lea    0x0(%esi),%esi
40002cc8:	39 df                	cmp    %ebx,%edi
40002cca:	77 f1                	ja     40002cbd <__umoddi3+0x2d>
40002ccc:	0f bd cf             	bsr    %edi,%ecx
40002ccf:	83 f1 1f             	xor    $0x1f,%ecx
40002cd2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
40002cd6:	75 40                	jne    40002d18 <__umoddi3+0x88>
40002cd8:	39 df                	cmp    %ebx,%edi
40002cda:	72 04                	jb     40002ce0 <__umoddi3+0x50>
40002cdc:	39 f5                	cmp    %esi,%ebp
40002cde:	77 dd                	ja     40002cbd <__umoddi3+0x2d>
40002ce0:	89 da                	mov    %ebx,%edx
40002ce2:	89 f0                	mov    %esi,%eax
40002ce4:	29 e8                	sub    %ebp,%eax
40002ce6:	19 fa                	sbb    %edi,%edx
40002ce8:	eb d3                	jmp    40002cbd <__umoddi3+0x2d>
40002cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40002cf0:	89 e9                	mov    %ebp,%ecx
40002cf2:	85 ed                	test   %ebp,%ebp
40002cf4:	75 0b                	jne    40002d01 <__umoddi3+0x71>
40002cf6:	b8 01 00 00 00       	mov    $0x1,%eax
40002cfb:	31 d2                	xor    %edx,%edx
40002cfd:	f7 f5                	div    %ebp
40002cff:	89 c1                	mov    %eax,%ecx
40002d01:	89 d8                	mov    %ebx,%eax
40002d03:	31 d2                	xor    %edx,%edx
40002d05:	f7 f1                	div    %ecx
40002d07:	89 f0                	mov    %esi,%eax
40002d09:	f7 f1                	div    %ecx
40002d0b:	89 d0                	mov    %edx,%eax
40002d0d:	31 d2                	xor    %edx,%edx
40002d0f:	eb ac                	jmp    40002cbd <__umoddi3+0x2d>
40002d11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40002d18:	8b 44 24 04          	mov    0x4(%esp),%eax
40002d1c:	ba 20 00 00 00       	mov    $0x20,%edx
40002d21:	29 c2                	sub    %eax,%edx
40002d23:	89 c1                	mov    %eax,%ecx
40002d25:	89 e8                	mov    %ebp,%eax
40002d27:	d3 e7                	shl    %cl,%edi
40002d29:	89 d1                	mov    %edx,%ecx
40002d2b:	89 54 24 0c          	mov    %edx,0xc(%esp)
40002d2f:	d3 e8                	shr    %cl,%eax
40002d31:	89 c1                	mov    %eax,%ecx
40002d33:	8b 44 24 04          	mov    0x4(%esp),%eax
40002d37:	09 f9                	or     %edi,%ecx
40002d39:	89 df                	mov    %ebx,%edi
40002d3b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
40002d3f:	89 c1                	mov    %eax,%ecx
40002d41:	d3 e5                	shl    %cl,%ebp
40002d43:	89 d1                	mov    %edx,%ecx
40002d45:	d3 ef                	shr    %cl,%edi
40002d47:	89 c1                	mov    %eax,%ecx
40002d49:	89 f0                	mov    %esi,%eax
40002d4b:	d3 e3                	shl    %cl,%ebx
40002d4d:	89 d1                	mov    %edx,%ecx
40002d4f:	89 fa                	mov    %edi,%edx
40002d51:	d3 e8                	shr    %cl,%eax
40002d53:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
40002d58:	09 d8                	or     %ebx,%eax
40002d5a:	f7 74 24 08          	divl   0x8(%esp)
40002d5e:	89 d3                	mov    %edx,%ebx
40002d60:	d3 e6                	shl    %cl,%esi
40002d62:	f7 e5                	mul    %ebp
40002d64:	89 c7                	mov    %eax,%edi
40002d66:	89 d1                	mov    %edx,%ecx
40002d68:	39 d3                	cmp    %edx,%ebx
40002d6a:	72 06                	jb     40002d72 <__umoddi3+0xe2>
40002d6c:	75 0e                	jne    40002d7c <__umoddi3+0xec>
40002d6e:	39 c6                	cmp    %eax,%esi
40002d70:	73 0a                	jae    40002d7c <__umoddi3+0xec>
40002d72:	29 e8                	sub    %ebp,%eax
40002d74:	1b 54 24 08          	sbb    0x8(%esp),%edx
40002d78:	89 d1                	mov    %edx,%ecx
40002d7a:	89 c7                	mov    %eax,%edi
40002d7c:	89 f5                	mov    %esi,%ebp
40002d7e:	8b 74 24 04          	mov    0x4(%esp),%esi
40002d82:	29 fd                	sub    %edi,%ebp
40002d84:	19 cb                	sbb    %ecx,%ebx
40002d86:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
40002d8b:	89 d8                	mov    %ebx,%eax
40002d8d:	d3 e0                	shl    %cl,%eax
40002d8f:	89 f1                	mov    %esi,%ecx
40002d91:	d3 ed                	shr    %cl,%ebp
40002d93:	d3 eb                	shr    %cl,%ebx
40002d95:	09 e8                	or     %ebp,%eax
40002d97:	89 da                	mov    %ebx,%edx
40002d99:	83 c4 1c             	add    $0x1c,%esp
40002d9c:	5b                   	pop    %ebx
40002d9d:	5e                   	pop    %esi
40002d9e:	5f                   	pop    %edi
40002d9f:	5d                   	pop    %ebp
40002da0:	c3                   	ret    
