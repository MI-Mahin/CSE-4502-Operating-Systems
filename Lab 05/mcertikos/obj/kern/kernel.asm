
obj/kern/kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <pmmap_init.cold>:
  100000:	80 7c 24 1f 00       	cmpb   $0x0,0x1f(%esp)
  100005:	8b 7c 24 10          	mov    0x10(%esp),%edi
    SLIST_INIT(&pmmap_sublist[PMMAP_NVS]);

    /*
     * Copy memory map information from multiboot information mbi to pmmap.
     */
    while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100009:	74 06                	je     100011 <pmmap_init.cold+0x11>
  10000b:	89 bd 78 a6 03 00    	mov    %edi,0x3a678(%ebp)
  100011:	80 7c 24 04 00       	cmpb   $0x0,0x4(%esp)
  100016:	74 0a                	je     100022 <pmmap_init.cold+0x22>
  100018:	c7 85 7c a6 03 00 80 	movl   $0x80,0x3a67c(%ebp)
  10001f:	00 00 00 
        KERN_PANIC("More than 128 E820 entries.\n");
  100022:	50                   	push   %eax
  100023:	8d 85 ca 73 ff ff    	lea    -0x8c36(%ebp),%eax
  100029:	89 eb                	mov    %ebp,%ebx
  10002b:	50                   	push   %eax
  10002c:	8d 85 e7 73 ff ff    	lea    -0x8c19(%ebp),%eax
  100032:	6a 3c                	push   $0x3c
  100034:	50                   	push   %eax
  100035:	e8 d6 46 00 00       	call   104710 <debug_panic>
    free_slot->start = start;
  10003a:	c7 05 00 00 00 00 00 	movl   $0x0,0x0
  100041:	00 00 00 
  100044:	0f 0b                	ud2    
  100046:	66 90                	xchg   %ax,%ax
  100048:	66 90                	xchg   %ax,%ax
  10004a:	66 90                	xchg   %ax,%ax
  10004c:	66 90                	xchg   %ax,%ax
  10004e:	66 90                	xchg   %ax,%ax

00100050 <video_init>:
    unsigned pos;

    /* Get a pointer to the memory-mapped text display buffer. */
    cp = (uint16_t *) CGA_BUF;
    was = *cp;
    *cp = (uint16_t) 0xA55A;
  100050:	b9 5a a5 ff ff       	mov    $0xffffa55a,%ecx
{
  100055:	57                   	push   %edi
  100056:	56                   	push   %esi
  100057:	53                   	push   %ebx
    was = *cp;
  100058:	0f b7 15 00 80 0b 00 	movzwl 0xb8000,%edx
    *cp = (uint16_t) 0xA55A;
  10005f:	e8 25 03 00 00       	call   100389 <__x86.get_pc_thunk.bx>
  100064:	81 c3 9c 3f 01 00    	add    $0x13f9c,%ebx
  10006a:	66 89 0d 00 80 0b 00 	mov    %cx,0xb8000
    if (*cp != 0xA55A) {
  100071:	0f b7 05 00 80 0b 00 	movzwl 0xb8000,%eax
  100078:	66 3d 5a a5          	cmp    $0xa55a,%ax
  10007c:	0f 84 96 00 00 00    	je     100118 <video_init+0xc8>
        cp = (uint16_t *) MONO_BUF;
        addr_6845 = MONO_BASE;
        dprintf("addr_6845:%x\n", addr_6845);
  100082:	83 ec 08             	sub    $0x8,%esp
  100085:	8d 83 00 70 ff ff    	lea    -0x9000(%ebx),%eax
        cp = (uint16_t *) MONO_BUF;
  10008b:	bf 00 00 0b 00       	mov    $0xb0000,%edi
        addr_6845 = MONO_BASE;
  100090:	c7 83 0c a0 03 00 b4 	movl   $0x3b4,0x3a00c(%ebx)
  100097:	03 00 00 
        dprintf("addr_6845:%x\n", addr_6845);
  10009a:	68 b4 03 00 00       	push   $0x3b4
  10009f:	50                   	push   %eax
  1000a0:	e8 bb 48 00 00       	call   104960 <dprintf>
  1000a5:	83 c4 10             	add    $0x10,%esp
        addr_6845 = CGA_BASE;
        dprintf("addr_6845:%x\n", addr_6845);
    }

    /* Extract cursor location */
    outb(addr_6845, 14);
  1000a8:	83 ec 08             	sub    $0x8,%esp
  1000ab:	6a 0e                	push   $0xe
  1000ad:	ff b3 0c a0 03 00    	push   0x3a00c(%ebx)
  1000b3:	e8 98 54 00 00       	call   105550 <outb>
    pos = inb(addr_6845 + 1) << 8;
  1000b8:	8b 83 0c a0 03 00    	mov    0x3a00c(%ebx),%eax
  1000be:	83 c0 01             	add    $0x1,%eax
  1000c1:	89 04 24             	mov    %eax,(%esp)
  1000c4:	e8 57 54 00 00       	call   105520 <inb>
  1000c9:	0f b6 f0             	movzbl %al,%esi
    outb(addr_6845, 15);
  1000cc:	58                   	pop    %eax
  1000cd:	5a                   	pop    %edx
  1000ce:	6a 0f                	push   $0xf
  1000d0:	ff b3 0c a0 03 00    	push   0x3a00c(%ebx)
    pos = inb(addr_6845 + 1) << 8;
  1000d6:	c1 e6 08             	shl    $0x8,%esi
    outb(addr_6845, 15);
  1000d9:	e8 72 54 00 00       	call   105550 <outb>
    pos |= inb(addr_6845 + 1);
  1000de:	8b 83 0c a0 03 00    	mov    0x3a00c(%ebx),%eax
  1000e4:	83 c0 01             	add    $0x1,%eax
  1000e7:	89 04 24             	mov    %eax,(%esp)
  1000ea:	e8 31 54 00 00       	call   105520 <inb>

    terminal.crt_buf = (uint16_t *) cp;
    terminal.crt_pos = pos;
    terminal.active_console = 0;
}
  1000ef:	83 c4 10             	add    $0x10,%esp
    terminal.crt_buf = (uint16_t *) cp;
  1000f2:	89 bb 00 a0 03 00    	mov    %edi,0x3a000(%ebx)
    terminal.active_console = 0;
  1000f8:	c7 83 08 a0 03 00 00 	movl   $0x0,0x3a008(%ebx)
  1000ff:	00 00 00 
    pos |= inb(addr_6845 + 1);
  100102:	0f b6 c0             	movzbl %al,%eax
  100105:	09 f0                	or     %esi,%eax
    terminal.crt_pos = pos;
  100107:	66 89 83 04 a0 03 00 	mov    %ax,0x3a004(%ebx)
}
  10010e:	5b                   	pop    %ebx
  10010f:	5e                   	pop    %esi
  100110:	5f                   	pop    %edi
  100111:	c3                   	ret    
  100112:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        dprintf("addr_6845:%x\n", addr_6845);
  100118:	83 ec 08             	sub    $0x8,%esp
  10011b:	8d 83 00 70 ff ff    	lea    -0x9000(%ebx),%eax
    cp = (uint16_t *) CGA_BUF;
  100121:	bf 00 80 0b 00       	mov    $0xb8000,%edi
        *cp = was;
  100126:	66 89 15 00 80 0b 00 	mov    %dx,0xb8000
        dprintf("addr_6845:%x\n", addr_6845);
  10012d:	68 d4 03 00 00       	push   $0x3d4
  100132:	50                   	push   %eax
        addr_6845 = CGA_BASE;
  100133:	c7 83 0c a0 03 00 d4 	movl   $0x3d4,0x3a00c(%ebx)
  10013a:	03 00 00 
        dprintf("addr_6845:%x\n", addr_6845);
  10013d:	e8 1e 48 00 00       	call   104960 <dprintf>
  100142:	83 c4 10             	add    $0x10,%esp
  100145:	e9 5e ff ff ff       	jmp    1000a8 <video_init+0x58>
  10014a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100150 <video_putc>:

void video_putc(int c)
{
  100150:	56                   	push   %esi
  100151:	53                   	push   %ebx
  100152:	e8 32 02 00 00       	call   100389 <__x86.get_pc_thunk.bx>
  100157:	81 c3 a9 3e 01 00    	add    $0x13ea9,%ebx
  10015d:	83 ec 04             	sub    $0x4,%esp
  100160:	8b 54 24 10          	mov    0x10(%esp),%edx
    // if no attribute given, then use black on white
    if (!(c & ~0xFF))
        c |= 0x0700;
  100164:	89 d0                	mov    %edx,%eax
  100166:	80 cc 07             	or     $0x7,%ah
  100169:	f7 c2 00 ff ff ff    	test   $0xffffff00,%edx
  10016f:	0f 44 d0             	cmove  %eax,%edx

    switch (c & 0xff) {
  100172:	0f b6 c2             	movzbl %dl,%eax
  100175:	83 f8 0a             	cmp    $0xa,%eax
  100178:	0f 84 93 01 00 00    	je     100311 <video_putc+0x1c1>
  10017e:	0f 8f bc 00 00 00    	jg     100240 <video_putc+0xf0>
  100184:	83 f8 08             	cmp    $0x8,%eax
  100187:	0f 84 53 01 00 00    	je     1002e0 <video_putc+0x190>
  10018d:	83 f8 09             	cmp    $0x9,%eax
  100190:	0f 85 2a 01 00 00    	jne    1002c0 <video_putc+0x170>
        /* fallthru */
    case '\r':
        terminal.crt_pos -= (terminal.crt_pos % CRT_COLS);
        break;
    case '\t':
        video_putc(' ');
  100196:	83 ec 0c             	sub    $0xc,%esp
  100199:	6a 20                	push   $0x20
  10019b:	e8 b0 ff ff ff       	call   100150 <video_putc>
        video_putc(' ');
  1001a0:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1001a7:	e8 a4 ff ff ff       	call   100150 <video_putc>
        video_putc(' ');
  1001ac:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1001b3:	e8 98 ff ff ff       	call   100150 <video_putc>
        video_putc(' ');
  1001b8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1001bf:	e8 8c ff ff ff       	call   100150 <video_putc>
        video_putc(' ');
  1001c4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1001cb:	e8 80 ff ff ff       	call   100150 <video_putc>
    default:
        terminal.crt_buf[terminal.crt_pos++] = c;  /* write the character */
        break;
    }

    if (terminal.crt_pos >= CRT_SIZE) {
  1001d0:	0f b7 83 04 a0 03 00 	movzwl 0x3a004(%ebx),%eax
        break;
  1001d7:	83 c4 10             	add    $0x10,%esp
    if (terminal.crt_pos >= CRT_SIZE) {
  1001da:	66 3d cf 07          	cmp    $0x7cf,%ax
  1001de:	0f 87 8b 00 00 00    	ja     10026f <video_putc+0x11f>
            terminal.crt_buf[i] = 0x0700 | ' ';
        terminal.crt_pos -= CRT_COLS;
    }

    /* move that little blinky thing */
    outb(addr_6845, 14);
  1001e4:	83 ec 08             	sub    $0x8,%esp
  1001e7:	6a 0e                	push   $0xe
  1001e9:	ff b3 0c a0 03 00    	push   0x3a00c(%ebx)
  1001ef:	e8 5c 53 00 00       	call   105550 <outb>
    outb(addr_6845 + 1, terminal.crt_pos >> 8);
  1001f4:	58                   	pop    %eax
  1001f5:	0f b6 83 05 a0 03 00 	movzbl 0x3a005(%ebx),%eax
  1001fc:	5a                   	pop    %edx
  1001fd:	50                   	push   %eax
  1001fe:	8b 83 0c a0 03 00    	mov    0x3a00c(%ebx),%eax
  100204:	83 c0 01             	add    $0x1,%eax
  100207:	50                   	push   %eax
  100208:	e8 43 53 00 00       	call   105550 <outb>
    outb(addr_6845, 15);
  10020d:	59                   	pop    %ecx
  10020e:	5e                   	pop    %esi
  10020f:	6a 0f                	push   $0xf
  100211:	ff b3 0c a0 03 00    	push   0x3a00c(%ebx)
  100217:	e8 34 53 00 00       	call   105550 <outb>
    outb(addr_6845 + 1, terminal.crt_pos);
  10021c:	58                   	pop    %eax
  10021d:	0f b6 83 04 a0 03 00 	movzbl 0x3a004(%ebx),%eax
  100224:	5a                   	pop    %edx
  100225:	50                   	push   %eax
  100226:	8b 83 0c a0 03 00    	mov    0x3a00c(%ebx),%eax
  10022c:	83 c0 01             	add    $0x1,%eax
  10022f:	50                   	push   %eax
  100230:	e8 1b 53 00 00       	call   105550 <outb>
}
  100235:	83 c4 14             	add    $0x14,%esp
  100238:	5b                   	pop    %ebx
  100239:	5e                   	pop    %esi
  10023a:	c3                   	ret    
  10023b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10023f:	90                   	nop
    switch (c & 0xff) {
  100240:	83 f8 0d             	cmp    $0xd,%eax
  100243:	75 7b                	jne    1002c0 <video_putc+0x170>
        if (terminal.crt_pos > 0) {
  100245:	0f b7 83 04 a0 03 00 	movzwl 0x3a004(%ebx),%eax
        terminal.crt_pos -= (terminal.crt_pos % CRT_COLS);
  10024c:	0f b7 c0             	movzwl %ax,%eax
  10024f:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  100255:	c1 e8 16             	shr    $0x16,%eax
  100258:	8d 04 80             	lea    (%eax,%eax,4),%eax
  10025b:	c1 e0 04             	shl    $0x4,%eax
  10025e:	66 89 83 04 a0 03 00 	mov    %ax,0x3a004(%ebx)
    if (terminal.crt_pos >= CRT_SIZE) {
  100265:	66 3d cf 07          	cmp    $0x7cf,%ax
  100269:	0f 86 75 ff ff ff    	jbe    1001e4 <video_putc+0x94>
        memmove(terminal.crt_buf, terminal.crt_buf + CRT_COLS,
  10026f:	8b 83 00 a0 03 00    	mov    0x3a000(%ebx),%eax
  100275:	83 ec 04             	sub    $0x4,%esp
  100278:	68 00 0f 00 00       	push   $0xf00
  10027d:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  100283:	52                   	push   %edx
  100284:	50                   	push   %eax
  100285:	e8 16 41 00 00       	call   1043a0 <memmove>
            terminal.crt_buf[i] = 0x0700 | ' ';
  10028a:	8b 93 00 a0 03 00    	mov    0x3a000(%ebx),%edx
  100290:	83 c4 10             	add    $0x10,%esp
  100293:	8d 82 00 0f 00 00    	lea    0xf00(%edx),%eax
  100299:	81 c2 a0 0f 00 00    	add    $0xfa0,%edx
  10029f:	90                   	nop
  1002a0:	b9 20 07 00 00       	mov    $0x720,%ecx
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i++)
  1002a5:	83 c0 02             	add    $0x2,%eax
            terminal.crt_buf[i] = 0x0700 | ' ';
  1002a8:	66 89 48 fe          	mov    %cx,-0x2(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i++)
  1002ac:	39 c2                	cmp    %eax,%edx
  1002ae:	75 f0                	jne    1002a0 <video_putc+0x150>
        terminal.crt_pos -= CRT_COLS;
  1002b0:	66 83 ab 04 a0 03 00 	subw   $0x50,0x3a004(%ebx)
  1002b7:	50 
  1002b8:	e9 27 ff ff ff       	jmp    1001e4 <video_putc+0x94>
  1002bd:	8d 76 00             	lea    0x0(%esi),%esi
        terminal.crt_buf[terminal.crt_pos++] = c;  /* write the character */
  1002c0:	0f b7 8b 04 a0 03 00 	movzwl 0x3a004(%ebx),%ecx
  1002c7:	8b b3 00 a0 03 00    	mov    0x3a000(%ebx),%esi
  1002cd:	8d 41 01             	lea    0x1(%ecx),%eax
  1002d0:	66 89 14 4e          	mov    %dx,(%esi,%ecx,2)
  1002d4:	66 89 83 04 a0 03 00 	mov    %ax,0x3a004(%ebx)
        break;
  1002db:	e9 fa fe ff ff       	jmp    1001da <video_putc+0x8a>
        if (terminal.crt_pos > 0) {
  1002e0:	0f b7 83 04 a0 03 00 	movzwl 0x3a004(%ebx),%eax
  1002e7:	66 85 c0             	test   %ax,%ax
  1002ea:	0f 84 f4 fe ff ff    	je     1001e4 <video_putc+0x94>
            terminal.crt_pos--;
  1002f0:	83 e8 01             	sub    $0x1,%eax
            terminal.crt_buf[terminal.crt_pos] = (c & ~0xff) | ' ';
  1002f3:	8b 8b 00 a0 03 00    	mov    0x3a000(%ebx),%ecx
  1002f9:	30 d2                	xor    %dl,%dl
  1002fb:	0f b7 f0             	movzwl %ax,%esi
  1002fe:	83 ca 20             	or     $0x20,%edx
            terminal.crt_pos--;
  100301:	66 89 83 04 a0 03 00 	mov    %ax,0x3a004(%ebx)
            terminal.crt_buf[terminal.crt_pos] = (c & ~0xff) | ' ';
  100308:	66 89 14 71          	mov    %dx,(%ecx,%esi,2)
  10030c:	e9 c9 fe ff ff       	jmp    1001da <video_putc+0x8a>
        terminal.crt_pos += CRT_COLS;
  100311:	0f b7 83 04 a0 03 00 	movzwl 0x3a004(%ebx),%eax
  100318:	83 c0 50             	add    $0x50,%eax
  10031b:	e9 2c ff ff ff       	jmp    10024c <video_putc+0xfc>

00100320 <video_set_cursor>:

void video_set_cursor(int x, int y)
{
    terminal.crt_pos = x * CRT_COLS + y;
  100320:	e8 60 00 00 00       	call   100385 <__x86.get_pc_thunk.dx>
  100325:	81 c2 db 3c 01 00    	add    $0x13cdb,%edx
{
  10032b:	8b 44 24 04          	mov    0x4(%esp),%eax
    terminal.crt_pos = x * CRT_COLS + y;
  10032f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  100332:	c1 e0 04             	shl    $0x4,%eax
  100335:	66 03 44 24 08       	add    0x8(%esp),%ax
  10033a:	66 89 82 04 a0 03 00 	mov    %ax,0x3a004(%edx)
}
  100341:	c3                   	ret    
  100342:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100350 <video_clear_screen>:

void video_clear_screen()
{
    int i;
    for (i = 0; i < CRT_SIZE; i++) {
  100350:	e8 2c 00 00 00       	call   100381 <__x86.get_pc_thunk.ax>
  100355:	05 ab 3c 01 00       	add    $0x13cab,%eax
  10035a:	8b 80 00 a0 03 00    	mov    0x3a000(%eax),%eax
  100360:	8d 90 a0 0f 00 00    	lea    0xfa0(%eax),%edx
  100366:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10036d:	8d 76 00             	lea    0x0(%esi),%esi
        terminal.crt_buf[i] = ' ';
  100370:	b9 20 00 00 00       	mov    $0x20,%ecx
    for (i = 0; i < CRT_SIZE; i++) {
  100375:	83 c0 02             	add    $0x2,%eax
        terminal.crt_buf[i] = ' ';
  100378:	66 89 48 fe          	mov    %cx,-0x2(%eax)
    for (i = 0; i < CRT_SIZE; i++) {
  10037c:	39 d0                	cmp    %edx,%eax
  10037e:	75 f0                	jne    100370 <video_clear_screen+0x20>
    }
}
  100380:	c3                   	ret    

00100381 <__x86.get_pc_thunk.ax>:
  100381:	8b 04 24             	mov    (%esp),%eax
  100384:	c3                   	ret    

00100385 <__x86.get_pc_thunk.dx>:
  100385:	8b 14 24             	mov    (%esp),%edx
  100388:	c3                   	ret    

00100389 <__x86.get_pc_thunk.bx>:
  100389:	8b 1c 24             	mov    (%esp),%ebx
  10038c:	c3                   	ret    
  10038d:	66 90                	xchg   %ax,%ax
  10038f:	90                   	nop

00100390 <cons_init>:
    char buf[CONSOLE_BUFFER_SIZE];
    uint32_t rpos, wpos;
} cons;

void cons_init()
{
  100390:	53                   	push   %ebx
  100391:	e8 f3 ff ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  100396:	81 c3 6a 3c 01 00    	add    $0x13c6a,%ebx
  10039c:	83 ec 0c             	sub    $0xc,%esp
    memset(&cons, 0x0, sizeof(cons));
  10039f:	68 08 02 00 00       	push   $0x208
  1003a4:	6a 00                	push   $0x0
  1003a6:	8d 83 20 a0 03 00    	lea    0x3a020(%ebx),%eax
  1003ac:	50                   	push   %eax
  1003ad:	e8 9e 3f 00 00       	call   104350 <memset>
    serial_init();
  1003b2:	e8 19 04 00 00       	call   1007d0 <serial_init>
    video_init();
  1003b7:	e8 94 fc ff ff       	call   100050 <video_init>
    spinlock_init(&cons_lk);
  1003bc:	8d 83 28 a2 03 00    	lea    0x3a228(%ebx),%eax
  1003c2:	89 04 24             	mov    %eax,(%esp)
  1003c5:	e8 16 5a 00 00       	call   105de0 <spinlock_init>
}
  1003ca:	83 c4 18             	add    $0x18,%esp
  1003cd:	5b                   	pop    %ebx
  1003ce:	c3                   	ret    
  1003cf:	90                   	nop

001003d0 <cons_intr>:

void cons_intr(int (*proc)(void))
{
  1003d0:	55                   	push   %ebp
  1003d1:	57                   	push   %edi
  1003d2:	56                   	push   %esi

    spinlock_acquire(&cons_lk);
    while ((c = (*proc)()) != -1) {
        if (c == 0)
            continue;
        cons.buf[cons.wpos++] = c;
  1003d3:	8d 35 20 a0 03 00    	lea    0x3a020,%esi
{
  1003d9:	53                   	push   %ebx
  1003da:	e8 aa ff ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1003df:	81 c3 21 3c 01 00    	add    $0x13c21,%ebx
  1003e5:	83 ec 28             	sub    $0x28,%esp
  1003e8:	8b 7c 24 3c          	mov    0x3c(%esp),%edi
    spinlock_acquire(&cons_lk);
  1003ec:	8d 83 28 a2 03 00    	lea    0x3a228(%ebx),%eax
        cons.buf[cons.wpos++] = c;
  1003f2:	8d 2c 33             	lea    (%ebx,%esi,1),%ebp
    spinlock_acquire(&cons_lk);
  1003f5:	89 44 24 18          	mov    %eax,0x18(%esp)
  1003f9:	50                   	push   %eax
  1003fa:	e8 71 5a 00 00       	call   105e70 <spinlock_acquire>
    while ((c = (*proc)()) != -1) {
  1003ff:	83 c4 10             	add    $0x10,%esp
  100402:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100408:	ff d7                	call   *%edi
  10040a:	83 f8 ff             	cmp    $0xffffffff,%eax
  10040d:	74 33                	je     100442 <cons_intr+0x72>
        if (c == 0)
  10040f:	85 c0                	test   %eax,%eax
  100411:	74 f5                	je     100408 <cons_intr+0x38>
        cons.buf[cons.wpos++] = c;
  100413:	8b 8c 33 04 02 00 00 	mov    0x204(%ebx,%esi,1),%ecx
  10041a:	8d 51 01             	lea    0x1(%ecx),%edx
  10041d:	88 44 0d 00          	mov    %al,0x0(%ebp,%ecx,1)
  100421:	89 94 33 04 02 00 00 	mov    %edx,0x204(%ebx,%esi,1)
        if (cons.wpos == CONSOLE_BUFFER_SIZE)
  100428:	81 fa 00 02 00 00    	cmp    $0x200,%edx
  10042e:	75 d8                	jne    100408 <cons_intr+0x38>
            cons.wpos = 0;
  100430:	c7 84 1e 04 02 00 00 	movl   $0x0,0x204(%esi,%ebx,1)
  100437:	00 00 00 00 
    while ((c = (*proc)()) != -1) {
  10043b:	ff d7                	call   *%edi
  10043d:	83 f8 ff             	cmp    $0xffffffff,%eax
  100440:	75 cd                	jne    10040f <cons_intr+0x3f>
    }
    spinlock_release(&cons_lk);
  100442:	83 ec 0c             	sub    $0xc,%esp
  100445:	ff 74 24 18          	push   0x18(%esp)
  100449:	e8 a2 5a 00 00       	call   105ef0 <spinlock_release>
}
  10044e:	83 c4 2c             	add    $0x2c,%esp
  100451:	5b                   	pop    %ebx
  100452:	5e                   	pop    %esi
  100453:	5f                   	pop    %edi
  100454:	5d                   	pop    %ebp
  100455:	c3                   	ret    
  100456:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10045d:	8d 76 00             	lea    0x0(%esi),%esi

00100460 <cons_getc>:

char cons_getc(void)
{
  100460:	57                   	push   %edi
  100461:	56                   	push   %esi
  100462:	53                   	push   %ebx
  100463:	e8 21 ff ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  100468:	81 c3 98 3b 01 00    	add    $0x13b98,%ebx
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  10046e:	e8 5d 02 00 00       	call   1006d0 <serial_intr>
    keyboard_intr();
    spinlock_acquire(&cons_lk);
  100473:	8d b3 28 a2 03 00    	lea    0x3a228(%ebx),%esi
    keyboard_intr();
  100479:	e8 c2 05 00 00       	call   100a40 <keyboard_intr>
    spinlock_acquire(&cons_lk);
  10047e:	83 ec 0c             	sub    $0xc,%esp
  100481:	56                   	push   %esi
  100482:	e8 e9 59 00 00       	call   105e70 <spinlock_acquire>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  100487:	8b 83 20 a2 03 00    	mov    0x3a220(%ebx),%eax
  10048d:	83 c4 10             	add    $0x10,%esp
  100490:	3b 83 24 a2 03 00    	cmp    0x3a224(%ebx),%eax
  100496:	74 38                	je     1004d0 <cons_getc+0x70>
        c = cons.buf[cons.rpos++];
  100498:	0f b6 bc 03 20 a0 03 	movzbl 0x3a020(%ebx,%eax,1),%edi
  10049f:	00 
        if (cons.rpos == CONSOLE_BUFFER_SIZE)
            cons.rpos = 0;
  1004a0:	3d ff 01 00 00       	cmp    $0x1ff,%eax
        c = cons.buf[cons.rpos++];
  1004a5:	8d 50 01             	lea    0x1(%eax),%edx
            cons.rpos = 0;
  1004a8:	b8 00 00 00 00       	mov    $0x0,%eax
  1004ad:	0f 44 d0             	cmove  %eax,%edx
        spinlock_release(&cons_lk);
  1004b0:	83 ec 0c             	sub    $0xc,%esp
  1004b3:	56                   	push   %esi
  1004b4:	89 93 20 a2 03 00    	mov    %edx,0x3a220(%ebx)
  1004ba:	e8 31 5a 00 00       	call   105ef0 <spinlock_release>
        return c;
  1004bf:	83 c4 10             	add    $0x10,%esp
    }
    spinlock_release(&cons_lk);
    return 0;
}
  1004c2:	89 f8                	mov    %edi,%eax
  1004c4:	5b                   	pop    %ebx
  1004c5:	5e                   	pop    %esi
  1004c6:	5f                   	pop    %edi
  1004c7:	c3                   	ret    
  1004c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1004cf:	90                   	nop
    spinlock_release(&cons_lk);
  1004d0:	83 ec 0c             	sub    $0xc,%esp
    return 0;
  1004d3:	31 ff                	xor    %edi,%edi
    spinlock_release(&cons_lk);
  1004d5:	56                   	push   %esi
  1004d6:	e8 15 5a 00 00       	call   105ef0 <spinlock_release>
    return 0;
  1004db:	83 c4 10             	add    $0x10,%esp
}
  1004de:	89 f8                	mov    %edi,%eax
  1004e0:	5b                   	pop    %ebx
  1004e1:	5e                   	pop    %esi
  1004e2:	5f                   	pop    %edi
  1004e3:	c3                   	ret    
  1004e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1004eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1004ef:	90                   	nop

001004f0 <cons_putc>:

void cons_putc(char c)
{
  1004f0:	56                   	push   %esi
  1004f1:	53                   	push   %ebx
  1004f2:	e8 92 fe ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1004f7:	81 c3 09 3b 01 00    	add    $0x13b09,%ebx
  1004fd:	83 ec 10             	sub    $0x10,%esp
    serial_putc(c);
  100500:	0f be 74 24 1c       	movsbl 0x1c(%esp),%esi
  100505:	56                   	push   %esi
  100506:	e8 05 02 00 00       	call   100710 <serial_putc>
    video_putc(c);
  10050b:	89 34 24             	mov    %esi,(%esp)
  10050e:	e8 3d fc ff ff       	call   100150 <video_putc>
}
  100513:	83 c4 14             	add    $0x14,%esp
  100516:	5b                   	pop    %ebx
  100517:	5e                   	pop    %esi
  100518:	c3                   	ret    
  100519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100520 <getchar>:

char getchar(void)
{
  100520:	83 ec 0c             	sub    $0xc,%esp
    char c;

    while ((c = cons_getc()) == 0)
  100523:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100527:	90                   	nop
  100528:	e8 33 ff ff ff       	call   100460 <cons_getc>
  10052d:	84 c0                	test   %al,%al
  10052f:	74 f7                	je     100528 <getchar+0x8>
        /* do nothing */ ;
    return c;
}
  100531:	83 c4 0c             	add    $0xc,%esp
  100534:	c3                   	ret    
  100535:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10053c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00100540 <putchar>:
  100540:	56                   	push   %esi
  100541:	53                   	push   %ebx
  100542:	e8 42 fe ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  100547:	81 c3 b9 3a 01 00    	add    $0x13ab9,%ebx
  10054d:	83 ec 10             	sub    $0x10,%esp
  100550:	0f be 74 24 1c       	movsbl 0x1c(%esp),%esi
  100555:	56                   	push   %esi
  100556:	e8 b5 01 00 00       	call   100710 <serial_putc>
  10055b:	89 34 24             	mov    %esi,(%esp)
  10055e:	e8 ed fb ff ff       	call   100150 <video_putc>
  100563:	83 c4 14             	add    $0x14,%esp
  100566:	5b                   	pop    %ebx
  100567:	5e                   	pop    %esi
  100568:	c3                   	ret    
  100569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100570 <readline>:
{
    cons_putc(c);
}

char *readline(const char *prompt)
{
  100570:	55                   	push   %ebp
  100571:	57                   	push   %edi
  100572:	56                   	push   %esi
  100573:	53                   	push   %ebx
  100574:	e8 10 fe ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  100579:	81 c3 87 3a 01 00    	add    $0x13a87,%ebx
  10057f:	83 ec 1c             	sub    $0x1c,%esp
  100582:	8b 44 24 30          	mov    0x30(%esp),%eax
    int i;
    char c;

    if (prompt != NULL)
  100586:	85 c0                	test   %eax,%eax
  100588:	74 13                	je     10059d <readline+0x2d>
        dprintf("%s", prompt);
  10058a:	83 ec 08             	sub    $0x8,%esp
  10058d:	50                   	push   %eax
  10058e:	8d 83 0e 70 ff ff    	lea    -0x8ff2(%ebx),%eax
  100594:	50                   	push   %eax
  100595:	e8 c6 43 00 00       	call   104960 <dprintf>
  10059a:	83 c4 10             	add    $0x10,%esp
        } else if ((c == '\b' || c == '\x7f') && i > 0) {
            putchar('\b');
            i--;
        } else if (c >= ' ' && i < BUFLEN - 1) {
            putchar(c);
            linebuf[i++] = c;
  10059d:	31 f6                	xor    %esi,%esi
  10059f:	8d bb 40 a2 03 00    	lea    0x3a240(%ebx),%edi
  1005a5:	8d 76 00             	lea    0x0(%esi),%esi
    while ((c = cons_getc()) == 0)
  1005a8:	e8 b3 fe ff ff       	call   100460 <cons_getc>
  1005ad:	84 c0                	test   %al,%al
  1005af:	74 f7                	je     1005a8 <readline+0x38>
        if (c < 0) {
  1005b1:	0f 88 a2 00 00 00    	js     100659 <readline+0xe9>
        } else if ((c == '\b' || c == '\x7f') && i > 0) {
  1005b7:	3c 08                	cmp    $0x8,%al
  1005b9:	0f 94 c2             	sete   %dl
  1005bc:	3c 7f                	cmp    $0x7f,%al
  1005be:	0f 94 c1             	sete   %cl
  1005c1:	08 ca                	or     %cl,%dl
  1005c3:	74 04                	je     1005c9 <readline+0x59>
  1005c5:	85 f6                	test   %esi,%esi
  1005c7:	75 6f                	jne    100638 <readline+0xc8>
        } else if (c >= ' ' && i < BUFLEN - 1) {
  1005c9:	3c 1f                	cmp    $0x1f,%al
  1005cb:	7e 33                	jle    100600 <readline+0x90>
  1005cd:	81 fe fe 03 00 00    	cmp    $0x3fe,%esi
  1005d3:	7f 2b                	jg     100600 <readline+0x90>
            putchar(c);
  1005d5:	88 44 24 0f          	mov    %al,0xf(%esp)
  1005d9:	0f be e8             	movsbl %al,%ebp
    serial_putc(c);
  1005dc:	83 ec 0c             	sub    $0xc,%esp
  1005df:	55                   	push   %ebp
  1005e0:	e8 2b 01 00 00       	call   100710 <serial_putc>
    video_putc(c);
  1005e5:	89 2c 24             	mov    %ebp,(%esp)
  1005e8:	e8 63 fb ff ff       	call   100150 <video_putc>
            linebuf[i++] = c;
  1005ed:	0f b6 44 24 1f       	movzbl 0x1f(%esp),%eax
  1005f2:	83 c4 10             	add    $0x10,%esp
  1005f5:	88 04 37             	mov    %al,(%edi,%esi,1)
  1005f8:	83 c6 01             	add    $0x1,%esi
  1005fb:	eb ab                	jmp    1005a8 <readline+0x38>
  1005fd:	8d 76 00             	lea    0x0(%esi),%esi
        } else if (c == '\n' || c == '\r') {
  100600:	3c 0a                	cmp    $0xa,%al
  100602:	74 04                	je     100608 <readline+0x98>
  100604:	3c 0d                	cmp    $0xd,%al
  100606:	75 a0                	jne    1005a8 <readline+0x38>
    serial_putc(c);
  100608:	83 ec 0c             	sub    $0xc,%esp
  10060b:	6a 0a                	push   $0xa
  10060d:	e8 fe 00 00 00       	call   100710 <serial_putc>
    video_putc(c);
  100612:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  100619:	e8 32 fb ff ff       	call   100150 <video_putc>
            putchar('\n');
            linebuf[i] = 0;
  10061e:	8d 83 40 a2 03 00    	lea    0x3a240(%ebx),%eax
            return linebuf;
  100624:	83 c4 10             	add    $0x10,%esp
            linebuf[i] = 0;
  100627:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
        }
    }
}
  10062b:	83 c4 1c             	add    $0x1c,%esp
  10062e:	5b                   	pop    %ebx
  10062f:	5e                   	pop    %esi
  100630:	5f                   	pop    %edi
  100631:	5d                   	pop    %ebp
  100632:	c3                   	ret    
  100633:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100637:	90                   	nop
    serial_putc(c);
  100638:	83 ec 0c             	sub    $0xc,%esp
            i--;
  10063b:	83 ee 01             	sub    $0x1,%esi
    serial_putc(c);
  10063e:	6a 08                	push   $0x8
  100640:	e8 cb 00 00 00       	call   100710 <serial_putc>
    video_putc(c);
  100645:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10064c:	e8 ff fa ff ff       	call   100150 <video_putc>
            i--;
  100651:	83 c4 10             	add    $0x10,%esp
  100654:	e9 4f ff ff ff       	jmp    1005a8 <readline+0x38>
            dprintf("read error: %e\n", c);
  100659:	83 ec 08             	sub    $0x8,%esp
  10065c:	0f be c0             	movsbl %al,%eax
  10065f:	50                   	push   %eax
  100660:	8d 83 11 70 ff ff    	lea    -0x8fef(%ebx),%eax
  100666:	50                   	push   %eax
  100667:	e8 f4 42 00 00       	call   104960 <dprintf>
            return NULL;
  10066c:	83 c4 10             	add    $0x10,%esp
  10066f:	31 c0                	xor    %eax,%eax
}
  100671:	83 c4 1c             	add    $0x1c,%esp
  100674:	5b                   	pop    %ebx
  100675:	5e                   	pop    %esi
  100676:	5f                   	pop    %edi
  100677:	5d                   	pop    %ebp
  100678:	c3                   	ret    
  100679:	66 90                	xchg   %ax,%ax
  10067b:	66 90                	xchg   %ax,%ax
  10067d:	66 90                	xchg   %ax,%ax
  10067f:	90                   	nop

00100680 <serial_proc_data>:
    inb(0x84);
    inb(0x84);
}

static int serial_proc_data(void)
{
  100680:	53                   	push   %ebx
  100681:	e8 03 fd ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  100686:	81 c3 7a 39 01 00    	add    $0x1397a,%ebx
  10068c:	83 ec 14             	sub    $0x14,%esp
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA))
  10068f:	68 fd 03 00 00       	push   $0x3fd
  100694:	e8 87 4e 00 00       	call   105520 <inb>
  100699:	83 c4 10             	add    $0x10,%esp
  10069c:	a8 01                	test   $0x1,%al
  10069e:	74 20                	je     1006c0 <serial_proc_data+0x40>
        return -1;
    return inb(COM1 + COM_RX);
  1006a0:	83 ec 0c             	sub    $0xc,%esp
  1006a3:	68 f8 03 00 00       	push   $0x3f8
  1006a8:	e8 73 4e 00 00       	call   105520 <inb>
  1006ad:	83 c4 10             	add    $0x10,%esp
  1006b0:	0f b6 c0             	movzbl %al,%eax
}
  1006b3:	83 c4 08             	add    $0x8,%esp
  1006b6:	5b                   	pop    %ebx
  1006b7:	c3                   	ret    
  1006b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1006bf:	90                   	nop
        return -1;
  1006c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1006c5:	eb ec                	jmp    1006b3 <serial_proc_data+0x33>
  1006c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1006ce:	66 90                	xchg   %ax,%ax

001006d0 <serial_intr>:

void serial_intr(void)
{
  1006d0:	53                   	push   %ebx
  1006d1:	e8 b3 fc ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1006d6:	81 c3 2a 39 01 00    	add    $0x1392a,%ebx
  1006dc:	83 ec 08             	sub    $0x8,%esp
    if (serial_exists)
  1006df:	80 bb 40 a6 03 00 00 	cmpb   $0x0,0x3a640(%ebx)
  1006e6:	75 08                	jne    1006f0 <serial_intr+0x20>
        cons_intr(serial_proc_data);
}
  1006e8:	83 c4 08             	add    $0x8,%esp
  1006eb:	5b                   	pop    %ebx
  1006ec:	c3                   	ret    
  1006ed:	8d 76 00             	lea    0x0(%esi),%esi
        cons_intr(serial_proc_data);
  1006f0:	83 ec 0c             	sub    $0xc,%esp
  1006f3:	8d 83 80 c6 fe ff    	lea    -0x13980(%ebx),%eax
  1006f9:	50                   	push   %eax
  1006fa:	e8 d1 fc ff ff       	call   1003d0 <cons_intr>
  1006ff:	83 c4 10             	add    $0x10,%esp
}
  100702:	83 c4 08             	add    $0x8,%esp
  100705:	5b                   	pop    %ebx
  100706:	c3                   	ret    
  100707:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10070e:	66 90                	xchg   %ax,%ax

00100710 <serial_putc>:
    } else
        return 0;
}

void serial_putc(char c)
{
  100710:	57                   	push   %edi
  100711:	56                   	push   %esi
    if (!serial_exists)
        return;

    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i++)
  100712:	31 f6                	xor    %esi,%esi
{
  100714:	53                   	push   %ebx
  100715:	8b 7c 24 10          	mov    0x10(%esp),%edi
  100719:	e8 6b fc ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10071e:	81 c3 e2 38 01 00    	add    $0x138e2,%ebx
    if (!serial_exists)
  100724:	80 bb 40 a6 03 00 00 	cmpb   $0x0,0x3a640(%ebx)
  10072b:	75 42                	jne    10076f <serial_putc+0x5f>
  10072d:	eb 6e                	jmp    10079d <serial_putc+0x8d>
  10072f:	90                   	nop
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i++)
  100730:	81 fe 00 32 00 00    	cmp    $0x3200,%esi
  100736:	74 4b                	je     100783 <serial_putc+0x73>
    inb(0x84);
  100738:	83 ec 0c             	sub    $0xc,%esp
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i++)
  10073b:	83 c6 01             	add    $0x1,%esi
    inb(0x84);
  10073e:	68 84 00 00 00       	push   $0x84
  100743:	e8 d8 4d 00 00       	call   105520 <inb>
    inb(0x84);
  100748:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  10074f:	e8 cc 4d 00 00       	call   105520 <inb>
    inb(0x84);
  100754:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  10075b:	e8 c0 4d 00 00       	call   105520 <inb>
    inb(0x84);
  100760:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  100767:	e8 b4 4d 00 00       	call   105520 <inb>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i++)
  10076c:	83 c4 10             	add    $0x10,%esp
  10076f:	83 ec 0c             	sub    $0xc,%esp
  100772:	68 fd 03 00 00       	push   $0x3fd
  100777:	e8 a4 4d 00 00       	call   105520 <inb>
  10077c:	83 c4 10             	add    $0x10,%esp
  10077f:	a8 20                	test   $0x20,%al
  100781:	74 ad                	je     100730 <serial_putc+0x20>
    if (c == nl) {
  100783:	89 f8                	mov    %edi,%eax
  100785:	3c 0a                	cmp    $0xa,%al
  100787:	74 1f                	je     1007a8 <serial_putc+0x98>
        delay();

    if (!serial_reformatnewline(c, COM1 + COM_TX))
        outb(COM1 + COM_TX, c);
  100789:	83 ec 08             	sub    $0x8,%esp
  10078c:	0f b6 f8             	movzbl %al,%edi
  10078f:	57                   	push   %edi
  100790:	68 f8 03 00 00       	push   $0x3f8
  100795:	e8 b6 4d 00 00       	call   105550 <outb>
  10079a:	83 c4 10             	add    $0x10,%esp
}
  10079d:	5b                   	pop    %ebx
  10079e:	5e                   	pop    %esi
  10079f:	5f                   	pop    %edi
  1007a0:	c3                   	ret    
  1007a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        outb(p, cr);
  1007a8:	83 ec 08             	sub    $0x8,%esp
  1007ab:	6a 0d                	push   $0xd
  1007ad:	68 f8 03 00 00       	push   $0x3f8
  1007b2:	e8 99 4d 00 00       	call   105550 <outb>
        outb(p, nl);
  1007b7:	58                   	pop    %eax
  1007b8:	5a                   	pop    %edx
  1007b9:	6a 0a                	push   $0xa
  1007bb:	68 f8 03 00 00       	push   $0x3f8
  1007c0:	e8 8b 4d 00 00       	call   105550 <outb>
  1007c5:	83 c4 10             	add    $0x10,%esp
}
  1007c8:	5b                   	pop    %ebx
  1007c9:	5e                   	pop    %esi
  1007ca:	5f                   	pop    %edi
  1007cb:	c3                   	ret    
  1007cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001007d0 <serial_init>:

void serial_init(void)
{
  1007d0:	53                   	push   %ebx
  1007d1:	e8 b3 fb ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1007d6:	81 c3 2a 38 01 00    	add    $0x1382a,%ebx
  1007dc:	83 ec 10             	sub    $0x10,%esp
    /* turn off interrupt */
    outb(COM1 + COM_IER, 0);
  1007df:	6a 00                	push   $0x0
  1007e1:	68 f9 03 00 00       	push   $0x3f9
  1007e6:	e8 65 4d 00 00       	call   105550 <outb>

    /* set DLAB */
    outb(COM1 + COM_LCR, COM_LCR_DLAB);
  1007eb:	58                   	pop    %eax
  1007ec:	5a                   	pop    %edx
  1007ed:	68 80 00 00 00       	push   $0x80
  1007f2:	68 fb 03 00 00       	push   $0x3fb
  1007f7:	e8 54 4d 00 00       	call   105550 <outb>

    /* set baud rate */
    outb(COM1 + COM_DLL, 0x0001 & 0xff);
  1007fc:	59                   	pop    %ecx
  1007fd:	58                   	pop    %eax
  1007fe:	6a 01                	push   $0x1
  100800:	68 f8 03 00 00       	push   $0x3f8
  100805:	e8 46 4d 00 00       	call   105550 <outb>
    outb(COM1 + COM_DLM, 0x0001 >> 8);
  10080a:	58                   	pop    %eax
  10080b:	5a                   	pop    %edx
  10080c:	6a 00                	push   $0x0
  10080e:	68 f9 03 00 00       	push   $0x3f9
  100813:	e8 38 4d 00 00       	call   105550 <outb>

    /* Set the line status. */
    outb(COM1 + COM_LCR, COM_LCR_WLEN8 & ~COM_LCR_DLAB);
  100818:	59                   	pop    %ecx
  100819:	58                   	pop    %eax
  10081a:	6a 03                	push   $0x3
  10081c:	68 fb 03 00 00       	push   $0x3fb
  100821:	e8 2a 4d 00 00       	call   105550 <outb>

    /* Enable the FIFO. */
    outb(COM1 + COM_FCR, 0xc7);
  100826:	58                   	pop    %eax
  100827:	5a                   	pop    %edx
  100828:	68 c7 00 00 00       	push   $0xc7
  10082d:	68 fa 03 00 00       	push   $0x3fa
  100832:	e8 19 4d 00 00       	call   105550 <outb>

    /* Turn on DTR, RTS, and OUT2. */
    outb(COM1 + COM_MCR, 0x0b);
  100837:	59                   	pop    %ecx
  100838:	58                   	pop    %eax
  100839:	6a 0b                	push   $0xb
  10083b:	68 fc 03 00 00       	push   $0x3fc
  100840:	e8 0b 4d 00 00       	call   105550 <outb>

    // Clear any preexisting overrun indications and interrupts
    // Serial COM1 doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  100845:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
  10084c:	e8 cf 4c 00 00       	call   105520 <inb>
    (void) inb(COM1 + COM_IIR);
  100851:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  100858:	3c ff                	cmp    $0xff,%al
  10085a:	0f 95 83 40 a6 03 00 	setne  0x3a640(%ebx)
    (void) inb(COM1 + COM_IIR);
  100861:	e8 ba 4c 00 00       	call   105520 <inb>
    (void) inb(COM1 + COM_RX);
  100866:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
  10086d:	e8 ae 4c 00 00       	call   105520 <inb>
}
  100872:	83 c4 18             	add    $0x18,%esp
  100875:	5b                   	pop    %ebx
  100876:	c3                   	ret    
  100877:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10087e:	66 90                	xchg   %ax,%ax

00100880 <serial_intenable>:

void serial_intenable(void)
{
  100880:	53                   	push   %ebx
  100881:	e8 03 fb ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  100886:	81 c3 7a 37 01 00    	add    $0x1377a,%ebx
  10088c:	83 ec 08             	sub    $0x8,%esp
    if (serial_exists) {
  10088f:	80 bb 40 a6 03 00 00 	cmpb   $0x0,0x3a640(%ebx)
  100896:	75 08                	jne    1008a0 <serial_intenable+0x20>
        outb(COM1 + COM_IER, 1);
        serial_intr();
    }
}
  100898:	83 c4 08             	add    $0x8,%esp
  10089b:	5b                   	pop    %ebx
  10089c:	c3                   	ret    
  10089d:	8d 76 00             	lea    0x0(%esi),%esi
        outb(COM1 + COM_IER, 1);
  1008a0:	83 ec 08             	sub    $0x8,%esp
  1008a3:	6a 01                	push   $0x1
  1008a5:	68 f9 03 00 00       	push   $0x3f9
  1008aa:	e8 a1 4c 00 00       	call   105550 <outb>
    if (serial_exists)
  1008af:	83 c4 10             	add    $0x10,%esp
  1008b2:	80 bb 40 a6 03 00 00 	cmpb   $0x0,0x3a640(%ebx)
  1008b9:	74 dd                	je     100898 <serial_intenable+0x18>
        cons_intr(serial_proc_data);
  1008bb:	83 ec 0c             	sub    $0xc,%esp
  1008be:	8d 83 80 c6 fe ff    	lea    -0x13980(%ebx),%eax
  1008c4:	50                   	push   %eax
  1008c5:	e8 06 fb ff ff       	call   1003d0 <cons_intr>
  1008ca:	83 c4 10             	add    $0x10,%esp
}
  1008cd:	83 c4 08             	add    $0x8,%esp
  1008d0:	5b                   	pop    %ebx
  1008d1:	c3                   	ret    
  1008d2:	66 90                	xchg   %ax,%ax
  1008d4:	66 90                	xchg   %ax,%ax
  1008d6:	66 90                	xchg   %ax,%ax
  1008d8:	66 90                	xchg   %ax,%ax
  1008da:	66 90                	xchg   %ax,%ax
  1008dc:	66 90                	xchg   %ax,%ax
  1008de:	66 90                	xchg   %ax,%ax

001008e0 <kbd_proc_data>:
/*
 * Get data from the keyboard. If we finish a character, return it. Else 0.
 * Return -1 if no data.
 */
static int kbd_proc_data(void)
{
  1008e0:	56                   	push   %esi
  1008e1:	53                   	push   %ebx
  1008e2:	e8 a2 fa ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1008e7:	81 c3 19 37 01 00    	add    $0x13719,%ebx
  1008ed:	83 ec 10             	sub    $0x10,%esp
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0)
  1008f0:	6a 64                	push   $0x64
  1008f2:	e8 29 4c 00 00       	call   105520 <inb>
  1008f7:	83 c4 10             	add    $0x10,%esp
  1008fa:	a8 01                	test   $0x1,%al
  1008fc:	0f 84 2e 01 00 00    	je     100a30 <kbd_proc_data+0x150>
        return -1;

    data = inb(KBDATAP);
  100902:	83 ec 0c             	sub    $0xc,%esp
  100905:	6a 60                	push   $0x60
  100907:	e8 14 4c 00 00       	call   105520 <inb>

    if (data == 0xE0) {
  10090c:	83 c4 10             	add    $0x10,%esp
  10090f:	3c e0                	cmp    $0xe0,%al
  100911:	0f 84 89 00 00 00    	je     1009a0 <kbd_proc_data+0xc0>
        // E0 escape character
        shift |= E0ESC;
  100917:	8b 8b 44 a6 03 00    	mov    0x3a644(%ebx),%ecx
        return 0;
    } else if (data & 0x80) {
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  10091d:	89 ca                	mov    %ecx,%edx
  10091f:	83 e2 40             	and    $0x40,%edx
    } else if (data & 0x80) {
  100922:	84 c0                	test   %al,%al
  100924:	0f 88 8e 00 00 00    	js     1009b8 <kbd_proc_data+0xd8>
        shift &= ~(shiftcode[data] | E0ESC);
        return 0;
    } else if (shift & E0ESC) {
  10092a:	85 d2                	test   %edx,%edx
  10092c:	74 06                	je     100934 <kbd_proc_data+0x54>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  10092e:	83 c8 80             	or     $0xffffff80,%eax
        shift &= ~E0ESC;
  100931:	83 e1 bf             	and    $0xffffffbf,%ecx
    }

    shift |= shiftcode[data];
  100934:	0f b6 c0             	movzbl %al,%eax
  100937:	0f b6 94 03 40 71 ff 	movzbl -0x8ec0(%ebx,%eax,1),%edx
  10093e:	ff 
  10093f:	09 ca                	or     %ecx,%edx
    shift ^= togglecode[data];
  100941:	0f b6 8c 03 40 70 ff 	movzbl -0x8fc0(%ebx,%eax,1),%ecx
  100948:	ff 
  100949:	31 ca                	xor    %ecx,%edx

    c = charcode[shift & (CTL | SHIFT)][data];
  10094b:	89 d1                	mov    %edx,%ecx
    shift ^= togglecode[data];
  10094d:	89 93 44 a6 03 00    	mov    %edx,0x3a644(%ebx)
    c = charcode[shift & (CTL | SHIFT)][data];
  100953:	83 e1 03             	and    $0x3,%ecx
  100956:	8b 8c 8b d8 ff ff ff 	mov    -0x28(%ebx,%ecx,4),%ecx
  10095d:	0f b6 34 01          	movzbl (%ecx,%eax,1),%esi
    if (shift & CAPSLOCK) {
  100961:	f6 c2 08             	test   $0x8,%dl
  100964:	75 22                	jne    100988 <kbd_proc_data+0xa8>
        else if ('A' <= c && c <= 'Z')
            c += 'a' - 'A';
    }
    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  100966:	f7 d2                	not    %edx
  100968:	83 e2 06             	and    $0x6,%edx
  10096b:	75 0c                	jne    100979 <kbd_proc_data+0x99>
  10096d:	81 fe e9 00 00 00    	cmp    $0xe9,%esi
  100973:	0f 84 8f 00 00 00    	je     100a08 <kbd_proc_data+0x128>
        dprintf("Rebooting!\n");
        outb(0x92, 0x3);  // courtesy of Chris Frost
    }

    return c;
}
  100979:	83 c4 04             	add    $0x4,%esp
  10097c:	89 f0                	mov    %esi,%eax
  10097e:	5b                   	pop    %ebx
  10097f:	5e                   	pop    %esi
  100980:	c3                   	ret    
  100981:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if ('a' <= c && c <= 'z')
  100988:	8d 46 9f             	lea    -0x61(%esi),%eax
  10098b:	83 f8 19             	cmp    $0x19,%eax
  10098e:	77 60                	ja     1009f0 <kbd_proc_data+0x110>
            c += 'A' - 'a';
  100990:	83 ee 20             	sub    $0x20,%esi
}
  100993:	83 c4 04             	add    $0x4,%esp
  100996:	89 f0                	mov    %esi,%eax
  100998:	5b                   	pop    %ebx
  100999:	5e                   	pop    %esi
  10099a:	c3                   	ret    
  10099b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10099f:	90                   	nop
        shift |= E0ESC;
  1009a0:	83 8b 44 a6 03 00 40 	orl    $0x40,0x3a644(%ebx)
        return 0;
  1009a7:	31 f6                	xor    %esi,%esi
}
  1009a9:	83 c4 04             	add    $0x4,%esp
  1009ac:	89 f0                	mov    %esi,%eax
  1009ae:	5b                   	pop    %ebx
  1009af:	5e                   	pop    %esi
  1009b0:	c3                   	ret    
  1009b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        data = (shift & E0ESC ? data : data & 0x7F);
  1009b8:	89 c6                	mov    %eax,%esi
  1009ba:	83 e6 7f             	and    $0x7f,%esi
  1009bd:	85 d2                	test   %edx,%edx
  1009bf:	0f 44 c6             	cmove  %esi,%eax
        return 0;
  1009c2:	31 f6                	xor    %esi,%esi
        shift &= ~(shiftcode[data] | E0ESC);
  1009c4:	0f b6 c0             	movzbl %al,%eax
  1009c7:	0f b6 84 03 40 71 ff 	movzbl -0x8ec0(%ebx,%eax,1),%eax
  1009ce:	ff 
  1009cf:	83 c8 40             	or     $0x40,%eax
  1009d2:	0f b6 c0             	movzbl %al,%eax
  1009d5:	f7 d0                	not    %eax
  1009d7:	21 c8                	and    %ecx,%eax
  1009d9:	89 83 44 a6 03 00    	mov    %eax,0x3a644(%ebx)
}
  1009df:	83 c4 04             	add    $0x4,%esp
  1009e2:	89 f0                	mov    %esi,%eax
  1009e4:	5b                   	pop    %ebx
  1009e5:	5e                   	pop    %esi
  1009e6:	c3                   	ret    
  1009e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1009ee:	66 90                	xchg   %ax,%ax
        else if ('A' <= c && c <= 'Z')
  1009f0:	8d 4e bf             	lea    -0x41(%esi),%ecx
            c += 'a' - 'A';
  1009f3:	8d 46 20             	lea    0x20(%esi),%eax
  1009f6:	83 f9 1a             	cmp    $0x1a,%ecx
  1009f9:	0f 42 f0             	cmovb  %eax,%esi
  1009fc:	e9 65 ff ff ff       	jmp    100966 <kbd_proc_data+0x86>
  100a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        dprintf("Rebooting!\n");
  100a08:	83 ec 0c             	sub    $0xc,%esp
  100a0b:	8d 83 21 70 ff ff    	lea    -0x8fdf(%ebx),%eax
  100a11:	50                   	push   %eax
  100a12:	e8 49 3f 00 00       	call   104960 <dprintf>
        outb(0x92, 0x3);  // courtesy of Chris Frost
  100a17:	58                   	pop    %eax
  100a18:	5a                   	pop    %edx
  100a19:	6a 03                	push   $0x3
  100a1b:	68 92 00 00 00       	push   $0x92
  100a20:	e8 2b 4b 00 00       	call   105550 <outb>
  100a25:	83 c4 10             	add    $0x10,%esp
  100a28:	e9 4c ff ff ff       	jmp    100979 <kbd_proc_data+0x99>
  100a2d:	8d 76 00             	lea    0x0(%esi),%esi
        return -1;
  100a30:	be ff ff ff ff       	mov    $0xffffffff,%esi
  100a35:	e9 3f ff ff ff       	jmp    100979 <kbd_proc_data+0x99>
  100a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100a40 <keyboard_intr>:

void keyboard_intr(void)
{
  100a40:	53                   	push   %ebx
  100a41:	e8 43 f9 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  100a46:	81 c3 ba 35 01 00    	add    $0x135ba,%ebx
  100a4c:	83 ec 14             	sub    $0x14,%esp
    cons_intr(kbd_proc_data);
  100a4f:	8d 83 e0 c8 fe ff    	lea    -0x13720(%ebx),%eax
  100a55:	50                   	push   %eax
  100a56:	e8 75 f9 ff ff       	call   1003d0 <cons_intr>
}
  100a5b:	83 c4 18             	add    $0x18,%esp
  100a5e:	5b                   	pop    %ebx
  100a5f:	c3                   	ret    

00100a60 <devinit>:
void bufcache_init(void);
void inode_init(void);
void file_init(void);

void devinit(uintptr_t mbi_addr)
{
  100a60:	56                   	push   %esi
  100a61:	53                   	push   %ebx
  100a62:	e8 22 f9 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  100a67:	81 c3 99 35 01 00    	add    $0x13599,%ebx
  100a6d:	83 ec 10             	sub    $0x10,%esp
  100a70:	8b 74 24 1c          	mov    0x1c(%esp),%esi
    seg_init(0);
  100a74:	6a 00                	push   $0x0
  100a76:	e8 75 45 00 00       	call   104ff0 <seg_init>

    enable_sse();
  100a7b:	e8 50 49 00 00       	call   1053d0 <enable_sse>

    cons_init();
  100a80:	e8 0b f9 ff ff       	call   100390 <cons_init>

    debug_init();
  100a85:	e8 86 3b 00 00       	call   104610 <debug_init>
    KERN_INFO("[BSP KERN] cons initialized.\n");
  100a8a:	8d 83 40 72 ff ff    	lea    -0x8dc0(%ebx),%eax
  100a90:	89 04 24             	mov    %eax,(%esp)
  100a93:	e8 d8 3b 00 00       	call   104670 <debug_info>
    KERN_INFO("[BSP KERN] devinit mbi_addr: %d\n", mbi_addr);
  100a98:	58                   	pop    %eax
  100a99:	8d 83 10 73 ff ff    	lea    -0x8cf0(%ebx),%eax
  100a9f:	5a                   	pop    %edx
  100aa0:	56                   	push   %esi
  100aa1:	50                   	push   %eax
  100aa2:	e8 c9 3b 00 00       	call   104670 <debug_info>

    /* pcpu init codes */
    pcpu_init();
  100aa7:	e8 54 58 00 00       	call   106300 <pcpu_init>
    KERN_INFO("[BSP KERN] PCPU initialized\n");
  100aac:	8d 83 5e 72 ff ff    	lea    -0x8da2(%ebx),%eax
  100ab2:	89 04 24             	mov    %eax,(%esp)
  100ab5:	e8 b6 3b 00 00       	call   104670 <debug_info>

    tsc_init();
  100aba:	e8 a1 11 00 00       	call   101c60 <tsc_init>
    KERN_INFO("[BSP KERN] TSC initialized\n");
  100abf:	8d 83 7b 72 ff ff    	lea    -0x8d85(%ebx),%eax
  100ac5:	89 04 24             	mov    %eax,(%esp)
  100ac8:	e8 a3 3b 00 00       	call   104670 <debug_info>

    intr_init();
  100acd:	e8 ee 06 00 00       	call   1011c0 <intr_init>
    KERN_INFO("[BSP KERN] INTR initialized\n");
  100ad2:	8d 83 97 72 ff ff    	lea    -0x8d69(%ebx),%eax
  100ad8:	89 04 24             	mov    %eax,(%esp)
  100adb:	e8 90 3b 00 00       	call   104670 <debug_info>

    trap_init(0);
  100ae0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100ae7:	e8 54 7c 00 00       	call   108740 <trap_init>

    pmmap_init(mbi_addr);
  100aec:	89 34 24             	mov    %esi,(%esp)
  100aef:	e8 5c 01 00 00       	call   100c50 <pmmap_init>

    bufcache_init();  // buffer cache
  100af4:	e8 f7 7e 00 00       	call   1089f0 <bufcache_init>
    file_init();      // file table
  100af9:	e8 92 93 00 00       	call   109e90 <file_init>
    inode_init();     // inode cache
  100afe:	e8 1d 89 00 00       	call   109420 <inode_init>
    ide_init();
  100b03:	e8 38 33 00 00       	call   103e40 <ide_init>
    KERN_INFO("[BSP KERN] IDE disk driver initialized\n");
  100b08:	8d 83 34 73 ff ff    	lea    -0x8ccc(%ebx),%eax
  100b0e:	89 04 24             	mov    %eax,(%esp)
  100b11:	e8 5a 3b 00 00       	call   104670 <debug_info>
}
  100b16:	83 c4 14             	add    $0x14,%esp
  100b19:	5b                   	pop    %ebx
  100b1a:	5e                   	pop    %esi
  100b1b:	c3                   	ret    
  100b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00100b20 <devinit_ap>:

void devinit_ap(void)
{
  100b20:	56                   	push   %esi
  100b21:	53                   	push   %ebx
  100b22:	e8 62 f8 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  100b27:	81 c3 d9 34 01 00    	add    $0x134d9,%ebx
  100b2d:	83 ec 04             	sub    $0x4,%esp
    /* Figure out the current (booting) kernel stack) */
    struct kstack *ks = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  100b30:	e8 cb 47 00 00       	call   105300 <read_esp>

    KERN_ASSERT(ks != NULL);
  100b35:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  100b3a:	89 c6                	mov    %eax,%esi
  100b3c:	74 6a                	je     100ba8 <devinit_ap+0x88>
    KERN_ASSERT(1 <= ks->cpu_idx && ks->cpu_idx < 8);
  100b3e:	8b 86 1c 01 00 00    	mov    0x11c(%esi),%eax
  100b44:	8d 50 ff             	lea    -0x1(%eax),%edx
  100b47:	83 fa 06             	cmp    $0x6,%edx
  100b4a:	0f 87 89 00 00 00    	ja     100bd9 <devinit_ap+0xb9>

    /* kernel stack for this cpu initialized */
    seg_init(ks->cpu_idx);
  100b50:	83 ec 0c             	sub    $0xc,%esp
  100b53:	50                   	push   %eax
  100b54:	e8 97 44 00 00       	call   104ff0 <seg_init>

    pcpu_init();
  100b59:	e8 a2 57 00 00       	call   106300 <pcpu_init>
    KERN_INFO("[AP%d KERN] PCPU initialized\n", ks->cpu_idx);
  100b5e:	58                   	pop    %eax
  100b5f:	8d 83 ef 72 ff ff    	lea    -0x8d11(%ebx),%eax
  100b65:	5a                   	pop    %edx
  100b66:	ff b6 1c 01 00 00    	push   0x11c(%esi)
  100b6c:	50                   	push   %eax
  100b6d:	e8 fe 3a 00 00       	call   104670 <debug_info>

    intr_init();
  100b72:	e8 49 06 00 00       	call   1011c0 <intr_init>
    KERN_INFO("[AP%d KERN] INTR initialized.\n", ks->cpu_idx);
  100b77:	59                   	pop    %ecx
  100b78:	58                   	pop    %eax
  100b79:	8d 83 80 73 ff ff    	lea    -0x8c80(%ebx),%eax
  100b7f:	ff b6 1c 01 00 00    	push   0x11c(%esi)
  100b85:	50                   	push   %eax
  100b86:	e8 e5 3a 00 00       	call   104670 <debug_info>

    trap_init(ks->cpu_idx);
  100b8b:	58                   	pop    %eax
  100b8c:	ff b6 1c 01 00 00    	push   0x11c(%esi)
  100b92:	e8 a9 7b 00 00       	call   108740 <trap_init>

    paging_init_ap();
  100b97:	e8 64 66 00 00       	call   107200 <paging_init_ap>
}
  100b9c:	83 c4 14             	add    $0x14,%esp
  100b9f:	5b                   	pop    %ebx
  100ba0:	5e                   	pop    %esi
  100ba1:	c3                   	ret    
  100ba2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    KERN_ASSERT(ks != NULL);
  100ba8:	8d 83 b4 72 ff ff    	lea    -0x8d4c(%ebx),%eax
  100bae:	50                   	push   %eax
  100baf:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  100bb5:	50                   	push   %eax
  100bb6:	8d 83 dc 72 ff ff    	lea    -0x8d24(%ebx),%eax
  100bbc:	6a 3d                	push   $0x3d
  100bbe:	50                   	push   %eax
  100bbf:	e8 4c 3b 00 00       	call   104710 <debug_panic>
    KERN_ASSERT(1 <= ks->cpu_idx && ks->cpu_idx < 8);
  100bc4:	8b 86 1c 01 00 00    	mov    0x11c(%esi),%eax
    KERN_ASSERT(ks != NULL);
  100bca:	83 c4 10             	add    $0x10,%esp
    KERN_ASSERT(1 <= ks->cpu_idx && ks->cpu_idx < 8);
  100bcd:	8d 50 ff             	lea    -0x1(%eax),%edx
  100bd0:	83 fa 06             	cmp    $0x6,%edx
  100bd3:	0f 86 77 ff ff ff    	jbe    100b50 <devinit_ap+0x30>
  100bd9:	8d 83 5c 73 ff ff    	lea    -0x8ca4(%ebx),%eax
  100bdf:	50                   	push   %eax
  100be0:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  100be6:	50                   	push   %eax
  100be7:	8d 83 dc 72 ff ff    	lea    -0x8d24(%ebx),%eax
  100bed:	6a 3e                	push   $0x3e
  100bef:	50                   	push   %eax
  100bf0:	e8 1b 3b 00 00       	call   104710 <debug_panic>
    seg_init(ks->cpu_idx);
  100bf5:	8b 86 1c 01 00 00    	mov    0x11c(%esi),%eax
  100bfb:	83 c4 10             	add    $0x10,%esp
  100bfe:	e9 4d ff ff ff       	jmp    100b50 <devinit_ap+0x30>
  100c03:	66 90                	xchg   %ax,%ax
  100c05:	66 90                	xchg   %ax,%ax
  100c07:	66 90                	xchg   %ax,%ax
  100c09:	66 90                	xchg   %ax,%ax
  100c0b:	66 90                	xchg   %ax,%ax
  100c0d:	66 90                	xchg   %ax,%ax
  100c0f:	90                   	nop

00100c10 <pmmap_alloc_slot>:
    if (unlikely(pmmap_slots_next_free == 128))
  100c10:	e8 70 f7 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  100c15:	81 c2 eb 33 01 00    	add    $0x133eb,%edx
  100c1b:	8b 82 7c a6 03 00    	mov    0x3a67c(%edx),%eax
  100c21:	3d 80 00 00 00       	cmp    $0x80,%eax
  100c26:	74 18                	je     100c40 <pmmap_alloc_slot+0x30>
    return &pmmap_slots[pmmap_slots_next_free++];
  100c28:	8d 48 01             	lea    0x1(%eax),%ecx
  100c2b:	8d 04 80             	lea    (%eax,%eax,4),%eax
  100c2e:	89 8a 7c a6 03 00    	mov    %ecx,0x3a67c(%edx)
  100c34:	8d 84 82 80 a6 03 00 	lea    0x3a680(%edx,%eax,4),%eax
  100c3b:	c3                   	ret    
  100c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return NULL;
  100c40:	31 c0                	xor    %eax,%eax
}
  100c42:	c3                   	ret    
  100c43:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100c50 <pmmap_init>:
{
  100c50:	55                   	push   %ebp
  100c51:	e8 63 05 00 00       	call   1011b9 <__x86.get_pc_thunk.bp>
  100c56:	81 c5 aa 33 01 00    	add    $0x133aa,%ebp
  100c5c:	57                   	push   %edi
  100c5d:	56                   	push   %esi
  100c5e:	53                   	push   %ebx
  100c5f:	83 ec 48             	sub    $0x48,%esp
    KERN_INFO("\n");
  100c62:	8d 85 35 87 ff ff    	lea    -0x78cb(%ebp),%eax
{
  100c68:	8b 74 24 5c          	mov    0x5c(%esp),%esi
    KERN_INFO("\n");
  100c6c:	89 eb                	mov    %ebp,%ebx
  100c6e:	50                   	push   %eax
  100c6f:	e8 fc 39 00 00       	call   104670 <debug_info>
    while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100c74:	8b 5e 2c             	mov    0x2c(%esi),%ebx
    mboot_mmap_t *p = (mboot_mmap_t *) mbi->mmap_addr;
  100c77:	8b 46 30             	mov    0x30(%esi),%eax
    SLIST_INIT(&pmmap_list);
  100c7a:	c7 85 78 a6 03 00 00 	movl   $0x0,0x3a678(%ebp)
  100c81:	00 00 00 
    SLIST_INIT(&pmmap_sublist[PMMAP_USABLE]);
  100c84:	c7 85 68 a6 03 00 00 	movl   $0x0,0x3a668(%ebp)
  100c8b:	00 00 00 
    while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100c8e:	89 5c 24 24          	mov    %ebx,0x24(%esp)
  100c92:	83 c4 10             	add    $0x10,%esp
    SLIST_INIT(&pmmap_sublist[PMMAP_RESV]);
  100c95:	c7 85 6c a6 03 00 00 	movl   $0x0,0x3a66c(%ebp)
  100c9c:	00 00 00 
    SLIST_INIT(&pmmap_sublist[PMMAP_ACPI]);
  100c9f:	c7 85 70 a6 03 00 00 	movl   $0x0,0x3a670(%ebp)
  100ca6:	00 00 00 
    SLIST_INIT(&pmmap_sublist[PMMAP_NVS]);
  100ca9:	c7 85 74 a6 03 00 00 	movl   $0x0,0x3a674(%ebp)
  100cb0:	00 00 00 
    while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100cb3:	85 db                	test   %ebx,%ebx
  100cb5:	0f 84 9f 02 00 00    	je     100f5a <pmmap_init+0x30a>
  100cbb:	ba e8 ff ff ff       	mov    $0xffffffe8,%edx
  100cc0:	31 ff                	xor    %edi,%edi
  100cc2:	c6 44 24 1f 00       	movb   $0x0,0x1f(%esp)
  100cc7:	8d 58 18             	lea    0x18(%eax),%ebx
  100cca:	29 c2                	sub    %eax,%edx
  100ccc:	89 7c 24 10          	mov    %edi,0x10(%esp)
  100cd0:	8b b5 7c a6 03 00    	mov    0x3a67c(%ebp),%esi
  100cd6:	c6 44 24 04 00       	movb   $0x0,0x4(%esp)
  100cdb:	89 54 24 18          	mov    %edx,0x18(%esp)
  100cdf:	90                   	nop
        uintptr_t start, end;
        uint32_t type;

        if (p->base_addr_high != 0)  /* ignore address above 4G */
  100ce0:	8b 78 08             	mov    0x8(%eax),%edi
  100ce3:	85 ff                	test   %edi,%edi
  100ce5:	0f 85 b8 00 00 00    	jne    100da3 <pmmap_init+0x153>
            goto next;
        else
            start = p->base_addr_low;

        if (p->length_high != 0 || p->length_low >= 0xffffffff - start)
  100ceb:	8b 48 10             	mov    0x10(%eax),%ecx
            start = p->base_addr_low;
  100cee:	8b 50 04             	mov    0x4(%eax),%edx
            end = 0xffffffff;
  100cf1:	c7 04 24 ff ff ff ff 	movl   $0xffffffff,(%esp)
        if (p->length_high != 0 || p->length_low >= 0xffffffff - start)
  100cf8:	85 c9                	test   %ecx,%ecx
  100cfa:	75 13                	jne    100d0f <pmmap_init+0xbf>
        else
            end = start + p->length_low;
  100cfc:	8b 78 0c             	mov    0xc(%eax),%edi
  100cff:	89 d1                	mov    %edx,%ecx
  100d01:	f7 d1                	not    %ecx
  100d03:	01 d7                	add    %edx,%edi
  100d05:	39 48 0c             	cmp    %ecx,0xc(%eax)
  100d08:	0f 43 3c 24          	cmovae (%esp),%edi
  100d0c:	89 3c 24             	mov    %edi,(%esp)

        type = p->type;
  100d0f:	8b 78 14             	mov    0x14(%eax),%edi
    if (unlikely(pmmap_slots_next_free == 128))
  100d12:	81 fe 80 00 00 00    	cmp    $0x80,%esi
  100d18:	0f 84 e2 f2 ff ff    	je     100000 <pmmap_init.cold>
    return &pmmap_slots[pmmap_slots_next_free++];
  100d1e:	8d 46 01             	lea    0x1(%esi),%eax
  100d21:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d25:	8d 04 b6             	lea    (%esi,%esi,4),%eax
  100d28:	c1 e0 02             	shl    $0x2,%eax
  100d2b:	8d 8c 05 80 a6 03 00 	lea    0x3a680(%ebp,%eax,1),%ecx
    free_slot->end = end;
  100d32:	8d 84 05 80 a6 03 00 	lea    0x3a680(%ebp,%eax,1),%eax
    return &pmmap_slots[pmmap_slots_next_free++];
  100d39:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    free_slot->start = start;
  100d3d:	89 11                	mov    %edx,(%ecx)
    free_slot->end = end;
  100d3f:	8d 0d 80 a6 03 00    	lea    0x3a680,%ecx
  100d45:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100d49:	8b 0c 24             	mov    (%esp),%ecx
    free_slot->type = type;
  100d4c:	89 78 08             	mov    %edi,0x8(%eax)
    free_slot->end = end;
  100d4f:	89 48 04             	mov    %ecx,0x4(%eax)
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100d52:	8b 44 24 10          	mov    0x10(%esp),%eax
  100d56:	85 c0                	test   %eax,%eax
  100d58:	0f 84 22 02 00 00    	je     100f80 <pmmap_init+0x330>
    last_slot = NULL;
  100d5e:	31 ff                	xor    %edi,%edi
  100d60:	eb 11                	jmp    100d73 <pmmap_init+0x123>
  100d62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100d68:	8b 48 0c             	mov    0xc(%eax),%ecx
  100d6b:	89 c7                	mov    %eax,%edi
  100d6d:	85 c9                	test   %ecx,%ecx
  100d6f:	74 13                	je     100d84 <pmmap_init+0x134>
  100d71:	89 c8                	mov    %ecx,%eax
        if (start < slot->start)
  100d73:	3b 10                	cmp    (%eax),%edx
  100d75:	73 f1                	jae    100d68 <pmmap_init+0x118>
    if (last_slot == NULL) {
  100d77:	85 ff                	test   %edi,%edi
  100d79:	0f 84 01 02 00 00    	je     100f80 <pmmap_init+0x330>
        SLIST_INSERT_AFTER(last_slot, free_slot, next);
  100d7f:	8b 4f 0c             	mov    0xc(%edi),%ecx
  100d82:	89 f8                	mov    %edi,%eax
  100d84:	8d 14 b6             	lea    (%esi,%esi,4),%edx
  100d87:	8b 74 24 0c          	mov    0xc(%esp),%esi
  100d8b:	8d 54 95 00          	lea    0x0(%ebp,%edx,4),%edx
  100d8f:	89 4c 16 0c          	mov    %ecx,0xc(%esi,%edx,1)
  100d93:	8b 74 24 08          	mov    0x8(%esp),%esi
  100d97:	89 70 0c             	mov    %esi,0xc(%eax)
    return &pmmap_slots[pmmap_slots_next_free++];
  100d9a:	8b 74 24 04          	mov    0x4(%esp),%esi
        SLIST_INSERT_AFTER(last_slot, free_slot, next);
  100d9e:	c6 44 24 04 01       	movb   $0x1,0x4(%esp)
    while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100da3:	8b 7c 24 18          	mov    0x18(%esp),%edi

        pmmap_insert(start, end, type);

      next:
        p = (mboot_mmap_t *) (((uint32_t) p) + sizeof(mboot_mmap_t) /* p->size */);
  100da7:	89 d8                	mov    %ebx,%eax
    while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100da9:	83 c3 18             	add    $0x18,%ebx
  100dac:	8d 14 1f             	lea    (%edi,%ebx,1),%edx
  100daf:	39 54 24 14          	cmp    %edx,0x14(%esp)
  100db3:	0f 87 27 ff ff ff    	ja     100ce0 <pmmap_init+0x90>
  100db9:	80 7c 24 1f 00       	cmpb   $0x0,0x1f(%esp)
  100dbe:	8b 7c 24 10          	mov    0x10(%esp),%edi
  100dc2:	0f 84 48 02 00 00    	je     101010 <pmmap_init+0x3c0>
  100dc8:	80 7c 24 04 00       	cmpb   $0x0,0x4(%esp)
  100dcd:	89 bd 78 a6 03 00    	mov    %edi,0x3a678(%ebp)
  100dd3:	0f 85 44 02 00 00    	jne    10101d <pmmap_init+0x3cd>
    struct pmmap *last_slot[4] = { NULL, NULL, NULL, NULL };
  100dd9:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%esp)
  100de0:	00 
  100de1:	c7 44 24 24 00 00 00 	movl   $0x0,0x24(%esp)
  100de8:	00 
  100de9:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
  100df0:	00 
  100df1:	c7 44 24 2c 00 00 00 	movl   $0x0,0x2c(%esp)
  100df8:	00 
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100df9:	85 ff                	test   %edi,%edi
  100dfb:	0f 84 59 01 00 00    	je     100f5a <pmmap_init+0x30a>
        if ((next_slot = SLIST_NEXT(slot, next)) == NULL)
  100e01:	8b 47 0c             	mov    0xc(%edi),%eax
  100e04:	85 c0                	test   %eax,%eax
  100e06:	74 2a                	je     100e32 <pmmap_init+0x1e2>
  100e08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100e0f:	90                   	nop
        if (slot->start <= next_slot->start &&
  100e10:	8b 10                	mov    (%eax),%edx
  100e12:	39 17                	cmp    %edx,(%edi)
  100e14:	77 13                	ja     100e29 <pmmap_init+0x1d9>
            slot->end >= next_slot->start &&
  100e16:	8b 4f 04             	mov    0x4(%edi),%ecx
        if (slot->start <= next_slot->start &&
  100e19:	39 ca                	cmp    %ecx,%edx
  100e1b:	77 0c                	ja     100e29 <pmmap_init+0x1d9>
            slot->end >= next_slot->start &&
  100e1d:	8b 58 08             	mov    0x8(%eax),%ebx
  100e20:	39 5f 08             	cmp    %ebx,0x8(%edi)
  100e23:	0f 84 b2 01 00 00    	je     100fdb <pmmap_init+0x38b>
    while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100e29:	89 c7                	mov    %eax,%edi
        if ((next_slot = SLIST_NEXT(slot, next)) == NULL)
  100e2b:	8b 47 0c             	mov    0xc(%edi),%eax
  100e2e:	85 c0                	test   %eax,%eax
  100e30:	75 de                	jne    100e10 <pmmap_init+0x1c0>
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100e32:	8b b5 78 a6 03 00    	mov    0x3a678(%ebp),%esi
  100e38:	85 f6                	test   %esi,%esi
  100e3a:	0f 84 1a 01 00 00    	je     100f5a <pmmap_init+0x30a>
            SLIST_INSERT_HEAD(&pmmap_sublist[sublist_nr], slot, type_next);
  100e40:	8d bd 68 a6 03 00    	lea    0x3a668(%ebp),%edi
  100e46:	eb 1c                	jmp    100e64 <pmmap_init+0x214>
  100e48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100e4f:	90                   	nop
            SLIST_INSERT_AFTER(last_slot[sublist_nr], slot, type_next);
  100e50:	8b 4a 10             	mov    0x10(%edx),%ecx
        last_slot[sublist_nr] = slot;
  100e53:	89 74 84 20          	mov    %esi,0x20(%esp,%eax,4)
            SLIST_INSERT_AFTER(last_slot[sublist_nr], slot, type_next);
  100e57:	89 4e 10             	mov    %ecx,0x10(%esi)
  100e5a:	89 72 10             	mov    %esi,0x10(%edx)
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100e5d:	8b 76 0c             	mov    0xc(%esi),%esi
  100e60:	85 f6                	test   %esi,%esi
  100e62:	74 35                	je     100e99 <pmmap_init+0x249>
        sublist_nr = PMMAP_SUBLIST_NR(slot->type);
  100e64:	8b 56 08             	mov    0x8(%esi),%edx
  100e67:	31 c0                	xor    %eax,%eax
  100e69:	83 fa 01             	cmp    $0x1,%edx
  100e6c:	74 0f                	je     100e7d <pmmap_init+0x22d>
  100e6e:	8d 42 fe             	lea    -0x2(%edx),%eax
  100e71:	83 f8 02             	cmp    $0x2,%eax
  100e74:	0f 87 36 01 00 00    	ja     100fb0 <pmmap_init+0x360>
  100e7a:	8d 42 ff             	lea    -0x1(%edx),%eax
        if (last_slot[sublist_nr] != NULL)
  100e7d:	8b 54 84 20          	mov    0x20(%esp,%eax,4),%edx
  100e81:	85 d2                	test   %edx,%edx
  100e83:	75 cb                	jne    100e50 <pmmap_init+0x200>
            SLIST_INSERT_HEAD(&pmmap_sublist[sublist_nr], slot, type_next);
  100e85:	8b 14 87             	mov    (%edi,%eax,4),%edx
        last_slot[sublist_nr] = slot;
  100e88:	89 74 84 20          	mov    %esi,0x20(%esp,%eax,4)
            SLIST_INSERT_HEAD(&pmmap_sublist[sublist_nr], slot, type_next);
  100e8c:	89 34 87             	mov    %esi,(%edi,%eax,4)
  100e8f:	89 56 10             	mov    %edx,0x10(%esi)
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100e92:	8b 76 0c             	mov    0xc(%esi),%esi
  100e95:	85 f6                	test   %esi,%esi
  100e97:	75 cb                	jne    100e64 <pmmap_init+0x214>
    if (last_slot[PMMAP_USABLE] != NULL)
  100e99:	8b 44 24 20          	mov    0x20(%esp),%eax
  100e9d:	85 c0                	test   %eax,%eax
  100e9f:	74 09                	je     100eaa <pmmap_init+0x25a>
        max_usable_memory = last_slot[PMMAP_USABLE]->end;
  100ea1:	8b 40 04             	mov    0x4(%eax),%eax
  100ea4:	89 85 64 a6 03 00    	mov    %eax,0x3a664(%ebp)
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100eaa:	8b bd 78 a6 03 00    	mov    0x3a678(%ebp),%edi
  100eb0:	85 ff                	test   %edi,%edi
  100eb2:	0f 84 a2 00 00 00    	je     100f5a <pmmap_init+0x30a>
        KERN_INFO("BIOS-e820: 0x%08x - 0x%08x (%s)\n",
  100eb8:	8d 85 9f 73 ff ff    	lea    -0x8c61(%ebp),%eax
  100ebe:	8d b5 0c 74 ff ff    	lea    -0x8bf4(%ebp),%esi
  100ec4:	89 04 24             	mov    %eax,(%esp)
  100ec7:	8d 85 b7 73 ff ff    	lea    -0x8c49(%ebp),%eax
  100ecd:	89 44 24 04          	mov    %eax,0x4(%esp)
  100ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100ed8:	8b 57 08             	mov    0x8(%edi),%edx
  100edb:	8b 04 24             	mov    (%esp),%eax
  100ede:	83 fa 01             	cmp    $0x1,%edx
  100ee1:	74 26                	je     100f09 <pmmap_init+0x2b9>
  100ee3:	8b 44 24 04          	mov    0x4(%esp),%eax
  100ee7:	83 fa 03             	cmp    $0x3,%edx
  100eea:	74 1d                	je     100f09 <pmmap_init+0x2b9>
  100eec:	8d 85 c1 73 ff ff    	lea    -0x8c3f(%ebp),%eax
  100ef2:	83 fa 04             	cmp    $0x4,%edx
  100ef5:	74 12                	je     100f09 <pmmap_init+0x2b9>
  100ef7:	83 fa 02             	cmp    $0x2,%edx
  100efa:	8d 85 a6 73 ff ff    	lea    -0x8c5a(%ebp),%eax
  100f00:	8d 95 ae 73 ff ff    	lea    -0x8c52(%ebp),%edx
  100f06:	0f 44 c2             	cmove  %edx,%eax
  100f09:	8b 0f                	mov    (%edi),%ecx
  100f0b:	8b 57 04             	mov    0x4(%edi),%edx
  100f0e:	39 d1                	cmp    %edx,%ecx
  100f10:	74 0a                	je     100f1c <pmmap_init+0x2cc>
  100f12:	31 db                	xor    %ebx,%ebx
  100f14:	83 fa ff             	cmp    $0xffffffff,%edx
  100f17:	0f 95 c3             	setne  %bl
  100f1a:	29 da                	sub    %ebx,%edx
  100f1c:	50                   	push   %eax
  100f1d:	89 eb                	mov    %ebp,%ebx
  100f1f:	52                   	push   %edx
  100f20:	51                   	push   %ecx
  100f21:	56                   	push   %esi
  100f22:	e8 49 37 00 00       	call   104670 <debug_info>
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100f27:	8b 7f 0c             	mov    0xc(%edi),%edi
  100f2a:	83 c4 10             	add    $0x10,%esp
  100f2d:	85 ff                	test   %edi,%edi
  100f2f:	75 a7                	jne    100ed8 <pmmap_init+0x288>
    pmmap_merge();
    pmmap_dump();

    /* count the number of pmmap entries */
    struct pmmap *slot;
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100f31:	8b 95 78 a6 03 00    	mov    0x3a678(%ebp),%edx
  100f37:	85 d2                	test   %edx,%edx
  100f39:	74 1f                	je     100f5a <pmmap_init+0x30a>
  100f3b:	8b 85 60 a6 03 00    	mov    0x3a660(%ebp),%eax
  100f41:	83 c0 01             	add    $0x1,%eax
  100f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100f48:	8b 52 0c             	mov    0xc(%edx),%edx
        pmmap_nentries++;
  100f4b:	89 c1                	mov    %eax,%ecx
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100f4d:	83 c0 01             	add    $0x1,%eax
  100f50:	85 d2                	test   %edx,%edx
  100f52:	75 f4                	jne    100f48 <pmmap_init+0x2f8>
  100f54:	89 8d 60 a6 03 00    	mov    %ecx,0x3a660(%ebp)
    }

    /* Calculate the maximum page number */
    mem_npages = rounddown(max_usable_memory, PAGESIZE) / PAGESIZE;
  100f5a:	83 ec 08             	sub    $0x8,%esp
  100f5d:	89 eb                	mov    %ebp,%ebx
  100f5f:	68 00 10 00 00       	push   $0x1000
  100f64:	ff b5 64 a6 03 00    	push   0x3a664(%ebp)
  100f6a:	e8 51 43 00 00       	call   1052c0 <rounddown>
}
  100f6f:	83 c4 4c             	add    $0x4c,%esp
  100f72:	5b                   	pop    %ebx
  100f73:	5e                   	pop    %esi
  100f74:	5f                   	pop    %edi
  100f75:	5d                   	pop    %ebp
  100f76:	c3                   	ret    
  100f77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100f7e:	66 90                	xchg   %ax,%ax
        SLIST_INSERT_HEAD(&pmmap_list, free_slot, next);
  100f80:	8b 7c 24 10          	mov    0x10(%esp),%edi
  100f84:	8d 04 b6             	lea    (%esi,%esi,4),%eax
  100f87:	8b 74 24 0c          	mov    0xc(%esp),%esi
  100f8b:	c6 44 24 1f 01       	movb   $0x1,0x1f(%esp)
  100f90:	8d 44 85 00          	lea    0x0(%ebp,%eax,4),%eax
  100f94:	89 7c 06 0c          	mov    %edi,0xc(%esi,%eax,1)
  100f98:	8b 44 24 08          	mov    0x8(%esp),%eax
    return &pmmap_slots[pmmap_slots_next_free++];
  100f9c:	8b 74 24 04          	mov    0x4(%esp),%esi
  100fa0:	c6 44 24 04 01       	movb   $0x1,0x4(%esp)
        SLIST_INSERT_HEAD(&pmmap_list, free_slot, next);
  100fa5:	89 44 24 10          	mov    %eax,0x10(%esp)
  100fa9:	e9 f5 fd ff ff       	jmp    100da3 <pmmap_init+0x153>
  100fae:	66 90                	xchg   %ax,%ax
        KERN_ASSERT(sublist_nr != -1);
  100fb0:	8d 85 f8 73 ff ff    	lea    -0x8c08(%ebp),%eax
  100fb6:	89 eb                	mov    %ebp,%ebx
  100fb8:	50                   	push   %eax
  100fb9:	8d 85 bf 72 ff ff    	lea    -0x8d41(%ebp),%eax
  100fbf:	50                   	push   %eax
  100fc0:	8d 85 e7 73 ff ff    	lea    -0x8c19(%ebp),%eax
  100fc6:	6a 6b                	push   $0x6b
  100fc8:	50                   	push   %eax
  100fc9:	e8 42 37 00 00       	call   104710 <debug_panic>
  100fce:	83 c4 10             	add    $0x10,%esp
        sublist_nr = PMMAP_SUBLIST_NR(slot->type);
  100fd1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100fd6:	e9 a2 fe ff ff       	jmp    100e7d <pmmap_init+0x22d>
            slot->end = max(slot->end, next_slot->end);
  100fdb:	83 ec 08             	sub    $0x8,%esp
  100fde:	ff 70 04             	push   0x4(%eax)
  100fe1:	89 eb                	mov    %ebp,%ebx
  100fe3:	51                   	push   %ecx
  100fe4:	e8 b7 42 00 00       	call   1052a0 <max>
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100fe9:	83 c4 10             	add    $0x10,%esp
            slot->end = max(slot->end, next_slot->end);
  100fec:	89 47 04             	mov    %eax,0x4(%edi)
            SLIST_REMOVE_AFTER(slot, next);
  100fef:	8b 47 0c             	mov    0xc(%edi),%eax
  100ff2:	8b 40 0c             	mov    0xc(%eax),%eax
  100ff5:	89 47 0c             	mov    %eax,0xc(%edi)
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100ff8:	85 c0                	test   %eax,%eax
  100ffa:	0f 84 32 fe ff ff    	je     100e32 <pmmap_init+0x1e2>
    while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  101000:	89 c7                	mov    %eax,%edi
  101002:	e9 24 fe ff ff       	jmp    100e2b <pmmap_init+0x1db>
  101007:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10100e:	66 90                	xchg   %ax,%ax
  101010:	31 ff                	xor    %edi,%edi
  101012:	80 7c 24 04 00       	cmpb   $0x0,0x4(%esp)
  101017:	0f 84 3d ff ff ff    	je     100f5a <pmmap_init+0x30a>
  10101d:	89 b5 7c a6 03 00    	mov    %esi,0x3a67c(%ebp)
  101023:	e9 b1 fd ff ff       	jmp    100dd9 <pmmap_init+0x189>
  101028:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10102f:	90                   	nop

00101030 <get_size>:

int get_size(void)
{
    return pmmap_nentries;
  101030:	e8 4c f3 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  101035:	05 cb 2f 01 00       	add    $0x12fcb,%eax
  10103a:	8b 80 60 a6 03 00    	mov    0x3a660(%eax),%eax
}
  101040:	c3                   	ret    
  101041:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101048:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10104f:	90                   	nop

00101050 <get_mms>:

uint32_t get_mms(int idx)
{
  101050:	53                   	push   %ebx
  101051:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  101055:	e8 2f f3 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10105a:	81 c3 a6 2f 01 00    	add    $0x12fa6,%ebx
    int i = 0;
    struct pmmap *slot = NULL;

    SLIST_FOREACH(slot, &pmmap_list, next) {
  101060:	8b 83 78 a6 03 00    	mov    0x3a678(%ebx),%eax
  101066:	85 c0                	test   %eax,%eax
  101068:	74 1c                	je     101086 <get_mms+0x36>
    int i = 0;
  10106a:	31 d2                	xor    %edx,%edx
        if (i == idx)
  10106c:	85 c9                	test   %ecx,%ecx
  10106e:	75 0c                	jne    10107c <get_mms+0x2c>
  101070:	eb 1e                	jmp    101090 <get_mms+0x40>
  101072:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101078:	39 d1                	cmp    %edx,%ecx
  10107a:	74 14                	je     101090 <get_mms+0x40>
    SLIST_FOREACH(slot, &pmmap_list, next) {
  10107c:	8b 40 0c             	mov    0xc(%eax),%eax
            break;
        i++;
  10107f:	83 c2 01             	add    $0x1,%edx
    SLIST_FOREACH(slot, &pmmap_list, next) {
  101082:	85 c0                	test   %eax,%eax
  101084:	75 f2                	jne    101078 <get_mms+0x28>
    }

    if (slot == NULL || i == pmmap_nentries)
        return 0;
  101086:	31 c9                	xor    %ecx,%ecx

    return slot->start;
}
  101088:	89 c8                	mov    %ecx,%eax
  10108a:	5b                   	pop    %ebx
  10108b:	c3                   	ret    
  10108c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return 0;
  101090:	31 c9                	xor    %ecx,%ecx
    if (slot == NULL || i == pmmap_nentries)
  101092:	39 93 60 a6 03 00    	cmp    %edx,0x3a660(%ebx)
  101098:	74 ee                	je     101088 <get_mms+0x38>
    return slot->start;
  10109a:	8b 08                	mov    (%eax),%ecx
}
  10109c:	5b                   	pop    %ebx
  10109d:	89 c8                	mov    %ecx,%eax
  10109f:	c3                   	ret    

001010a0 <get_mml>:

uint32_t get_mml(int idx)
{
  1010a0:	53                   	push   %ebx
  1010a1:	8b 44 24 08          	mov    0x8(%esp),%eax
  1010a5:	e8 df f2 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1010aa:	81 c3 56 2f 01 00    	add    $0x12f56,%ebx
    int i = 0;
    struct pmmap *slot = NULL;

    SLIST_FOREACH(slot, &pmmap_list, next) {
  1010b0:	8b 93 78 a6 03 00    	mov    0x3a678(%ebx),%edx
  1010b6:	85 d2                	test   %edx,%edx
  1010b8:	74 1c                	je     1010d6 <get_mml+0x36>
    int i = 0;
  1010ba:	31 c9                	xor    %ecx,%ecx
        if (i == idx)
  1010bc:	85 c0                	test   %eax,%eax
  1010be:	75 0c                	jne    1010cc <get_mml+0x2c>
  1010c0:	eb 1e                	jmp    1010e0 <get_mml+0x40>
  1010c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1010c8:	39 c8                	cmp    %ecx,%eax
  1010ca:	74 14                	je     1010e0 <get_mml+0x40>
    SLIST_FOREACH(slot, &pmmap_list, next) {
  1010cc:	8b 52 0c             	mov    0xc(%edx),%edx
            break;
        i++;
  1010cf:	83 c1 01             	add    $0x1,%ecx
    SLIST_FOREACH(slot, &pmmap_list, next) {
  1010d2:	85 d2                	test   %edx,%edx
  1010d4:	75 f2                	jne    1010c8 <get_mml+0x28>
    }

    if (slot == NULL || i == pmmap_nentries)
        return 0;
  1010d6:	31 c0                	xor    %eax,%eax

    return slot->end - slot->start;
}
  1010d8:	5b                   	pop    %ebx
  1010d9:	c3                   	ret    
  1010da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return 0;
  1010e0:	31 c0                	xor    %eax,%eax
    if (slot == NULL || i == pmmap_nentries)
  1010e2:	39 8b 60 a6 03 00    	cmp    %ecx,0x3a660(%ebx)
  1010e8:	74 ee                	je     1010d8 <get_mml+0x38>
    return slot->end - slot->start;
  1010ea:	8b 42 04             	mov    0x4(%edx),%eax
}
  1010ed:	5b                   	pop    %ebx
    return slot->end - slot->start;
  1010ee:	2b 02                	sub    (%edx),%eax
}
  1010f0:	c3                   	ret    
  1010f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1010f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1010ff:	90                   	nop

00101100 <is_usable>:

int is_usable(int idx)
{
  101100:	53                   	push   %ebx
  101101:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  101105:	e8 7f f2 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10110a:	81 c3 f6 2e 01 00    	add    $0x12ef6,%ebx
    int i = 0;
    struct pmmap *slot = NULL;

    SLIST_FOREACH(slot, &pmmap_list, next) {
  101110:	8b 83 78 a6 03 00    	mov    0x3a678(%ebx),%eax
  101116:	85 c0                	test   %eax,%eax
  101118:	74 1c                	je     101136 <is_usable+0x36>
    int i = 0;
  10111a:	31 d2                	xor    %edx,%edx
        if (i == idx)
  10111c:	85 c9                	test   %ecx,%ecx
  10111e:	75 0c                	jne    10112c <is_usable+0x2c>
  101120:	eb 1e                	jmp    101140 <is_usable+0x40>
  101122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101128:	39 d1                	cmp    %edx,%ecx
  10112a:	74 14                	je     101140 <is_usable+0x40>
    SLIST_FOREACH(slot, &pmmap_list, next) {
  10112c:	8b 40 0c             	mov    0xc(%eax),%eax
            break;
        i++;
  10112f:	83 c2 01             	add    $0x1,%edx
    SLIST_FOREACH(slot, &pmmap_list, next) {
  101132:	85 c0                	test   %eax,%eax
  101134:	75 f2                	jne    101128 <is_usable+0x28>
    }

    if (slot == NULL || i == pmmap_nentries)
        return 0;
  101136:	31 c9                	xor    %ecx,%ecx

    return slot->type == MEM_RAM;
}
  101138:	89 c8                	mov    %ecx,%eax
  10113a:	5b                   	pop    %ebx
  10113b:	c3                   	ret    
  10113c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return 0;
  101140:	31 c9                	xor    %ecx,%ecx
    if (slot == NULL || i == pmmap_nentries)
  101142:	39 93 60 a6 03 00    	cmp    %edx,0x3a660(%ebx)
  101148:	74 ee                	je     101138 <is_usable+0x38>
    return slot->type == MEM_RAM;
  10114a:	31 c9                	xor    %ecx,%ecx
  10114c:	83 78 08 01          	cmpl   $0x1,0x8(%eax)
}
  101150:	5b                   	pop    %ebx
    return slot->type == MEM_RAM;
  101151:	0f 94 c1             	sete   %cl
}
  101154:	89 c8                	mov    %ecx,%eax
  101156:	c3                   	ret    
  101157:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10115e:	66 90                	xchg   %ax,%ax

00101160 <set_cr3>:

void set_cr3(unsigned int **pdir)
{
  101160:	53                   	push   %ebx
  101161:	e8 23 f2 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101166:	81 c3 9a 2e 01 00    	add    $0x12e9a,%ebx
  10116c:	83 ec 14             	sub    $0x14,%esp
    lcr3((uint32_t) pdir);
  10116f:	ff 74 24 1c          	push   0x1c(%esp)
  101173:	e8 78 43 00 00       	call   1054f0 <lcr3>
}
  101178:	83 c4 18             	add    $0x18,%esp
  10117b:	5b                   	pop    %ebx
  10117c:	c3                   	ret    
  10117d:	8d 76 00             	lea    0x0(%esi),%esi

00101180 <enable_paging>:

void enable_paging(void)
{
  101180:	53                   	push   %ebx
  101181:	e8 03 f2 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101186:	81 c3 7a 2e 01 00    	add    $0x12e7a,%ebx
  10118c:	83 ec 08             	sub    $0x8,%esp
    /* enable global pages (Sec 4.10.2.4, Intel ASDM Vol3) */
    uint32_t cr4 = rcr4();
  10118f:	e8 7c 43 00 00       	call   105510 <rcr4>
    cr4 |= CR4_PGE;
    lcr4(cr4);
  101194:	83 ec 0c             	sub    $0xc,%esp
    cr4 |= CR4_PGE;
  101197:	0c 80                	or     $0x80,%al
    lcr4(cr4);
  101199:	50                   	push   %eax
  10119a:	e8 61 43 00 00       	call   105500 <lcr4>

    /* turn on paging */
    uint32_t cr0 = rcr0();
  10119f:	e8 2c 43 00 00       	call   1054d0 <rcr0>
    cr0 |= CR0_PE | CR0_PG | CR0_AM | CR0_WP | CR0_NE | CR0_MP;
    cr0 &= ~(CR0_EM | CR0_TS);
  1011a4:	83 e0 f3             	and    $0xfffffff3,%eax
  1011a7:	0d 23 00 05 80       	or     $0x80050023,%eax
    lcr0(cr0);
  1011ac:	89 04 24             	mov    %eax,(%esp)
  1011af:	e8 0c 43 00 00       	call   1054c0 <lcr0>
}
  1011b4:	83 c4 18             	add    $0x18,%esp
  1011b7:	5b                   	pop    %ebx
  1011b8:	c3                   	ret    

001011b9 <__x86.get_pc_thunk.bp>:
  1011b9:	8b 2c 24             	mov    (%esp),%ebp
  1011bc:	c3                   	ret    
  1011bd:	66 90                	xchg   %ax,%ax
  1011bf:	90                   	nop

001011c0 <intr_init>:
{
    asm volatile ("lidt %0" :: "m" (idt_pd));
}

void intr_init(void)
{
  1011c0:	55                   	push   %ebp
  1011c1:	57                   	push   %edi
  1011c2:	56                   	push   %esi
  1011c3:	53                   	push   %ebx
  1011c4:	e8 c0 f1 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1011c9:	81 c3 37 2e 01 00    	add    $0x12e37,%ebx
  1011cf:	83 ec 38             	sub    $0x38,%esp
    uint32_t dummy, edx;

    cpuid(0x00000001, &dummy, &dummy, &dummy, &edx);
  1011d2:	8d 44 24 28          	lea    0x28(%esp),%eax
  1011d6:	50                   	push   %eax
  1011d7:	8d 44 24 28          	lea    0x28(%esp),%eax
  1011db:	50                   	push   %eax
  1011dc:	50                   	push   %eax
  1011dd:	50                   	push   %eax
  1011de:	6a 01                	push   $0x1
  1011e0:	e8 0b 42 00 00       	call   1053f0 <cpuid>
    using_apic = (edx & CPUID_FEATURE_APIC) ? TRUE : FALSE;
  1011e5:	8b 44 24 3c          	mov    0x3c(%esp),%eax
    KERN_ASSERT(using_apic == TRUE);
  1011e9:	83 c4 20             	add    $0x20,%esp
    using_apic = (edx & CPUID_FEATURE_APIC) ? TRUE : FALSE;
  1011ec:	c1 e8 09             	shr    $0x9,%eax
  1011ef:	83 e0 01             	and    $0x1,%eax
  1011f2:	88 83 80 b8 03 00    	mov    %al,0x3b880(%ebx)
    KERN_ASSERT(using_apic == TRUE);
  1011f8:	0f b6 83 80 b8 03 00 	movzbl 0x3b880(%ebx),%eax
  1011ff:	3c 01                	cmp    $0x1,%al
  101201:	74 1f                	je     101222 <intr_init+0x62>
  101203:	8d 83 2d 74 ff ff    	lea    -0x8bd3(%ebx),%eax
  101209:	50                   	push   %eax
  10120a:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  101210:	50                   	push   %eax
  101211:	8d 83 40 74 ff ff    	lea    -0x8bc0(%ebx),%eax
  101217:	6a 63                	push   $0x63
  101219:	50                   	push   %eax
  10121a:	e8 f1 34 00 00       	call   104710 <debug_panic>
  10121f:	83 c4 10             	add    $0x10,%esp

    if (pcpu_onboot())
  101222:	e8 29 28 00 00       	call   103a50 <pcpu_onboot>
  101227:	84 c0                	test   %al,%al
  101229:	75 25                	jne    101250 <intr_init+0x90>
            intr_init_idt();
        }
    }

    /* all processors */
    if (using_apic)
  10122b:	0f b6 83 80 b8 03 00 	movzbl 0x3b880(%ebx),%eax
  101232:	84 c0                	test   %al,%al
  101234:	0f 85 46 05 00 00    	jne    101780 <intr_init+0x5c0>
    asm volatile ("lidt %0" :: "m" (idt_pd));
  10123a:	0f 01 9b 20 03 00 00 	lidtl  0x320(%ebx)
    {
        lapic_init();
    }
    intr_install_idt();
}
  101241:	83 c4 2c             	add    $0x2c,%esp
  101244:	5b                   	pop    %ebx
  101245:	5e                   	pop    %esi
  101246:	5f                   	pop    %edi
  101247:	5d                   	pop    %ebp
  101248:	c3                   	ret    
  101249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        pic_init();
  101250:	e8 3b 07 00 00       	call   101990 <pic_init>
        if (using_apic)
  101255:	0f b6 83 80 b8 03 00 	movzbl 0x3b880(%ebx),%eax
  10125c:	84 c0                	test   %al,%al
  10125e:	74 cb                	je     10122b <intr_init+0x6b>
            ioapic_init();
  101260:	e8 5b 18 00 00       	call   102ac0 <ioapic_init>
        SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);
  101265:	c7 c0 de 21 10 00    	mov    $0x1021de,%eax
  10126b:	8d 0d 80 b0 03 00    	lea    0x3b080,%ecx
  101271:	89 c6                	mov    %eax,%esi
  101273:	89 44 24 0c          	mov    %eax,0xc(%esp)
  101277:	89 c7                	mov    %eax,%edi
    for (i = 0; i < sizeof(idt) / sizeof(idt[0]); i++)
  101279:	31 c0                	xor    %eax,%eax
        SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);
  10127b:	c1 ee 10             	shr    $0x10,%esi
  10127e:	89 74 24 08          	mov    %esi,0x8(%esp)
  101282:	89 f5                	mov    %esi,%ebp
  101284:	8d b3 80 b0 03 00    	lea    0x3b080(%ebx),%esi
  10128a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101290:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  101297:	66 89 3c c6          	mov    %di,(%esi,%eax,8)
    for (i = 0; i < sizeof(idt) / sizeof(idt[0]); i++)
  10129b:	83 c0 01             	add    $0x1,%eax
        SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);
  10129e:	c7 84 13 82 b0 03 00 	movl   $0x8e000008,0x3b082(%ebx,%edx,1)
  1012a5:	08 00 00 8e 
  1012a9:	01 da                	add    %ebx,%edx
  1012ab:	66 89 6c 11 06       	mov    %bp,0x6(%ecx,%edx,1)
    for (i = 0; i < sizeof(idt) / sizeof(idt[0]); i++)
  1012b0:	3d 00 01 00 00       	cmp    $0x100,%eax
  1012b5:	75 d9                	jne    101290 <intr_init+0xd0>
    SETGATE(idt[T_DIVIDE],                  0, CPU_GDT_KCODE, &Xdivide,         0);
  1012b7:	c7 c0 d0 20 10 00    	mov    $0x1020d0,%eax
    SETGATE(idt[T_FPERR],                   0, CPU_GDT_KCODE, &Xfperr,          0);
  1012bd:	ba 08 00 00 00       	mov    $0x8,%edx
    SETGATE(idt[T_DIVIDE],                  0, CPU_GDT_KCODE, &Xdivide,         0);
  1012c2:	c7 83 82 b0 03 00 08 	movl   $0x8e000008,0x3b082(%ebx)
  1012c9:	00 00 8e 
    SETGATE(idt[T_FPERR],                   0, CPU_GDT_KCODE, &Xfperr,          0);
  1012cc:	be 00 8e ff ff       	mov    $0xffff8e00,%esi
    SETGATE(idt[T_DEBUG],                   0, CPU_GDT_KCODE, &Xdebug,          0);
  1012d1:	c7 83 8a b0 03 00 08 	movl   $0x8e000008,0x3b08a(%ebx)
  1012d8:	00 00 8e 
    SETGATE(idt[T_DIVIDE],                  0, CPU_GDT_KCODE, &Xdivide,         0);
  1012db:	66 89 04 19          	mov    %ax,(%ecx,%ebx,1)
  1012df:	c1 e8 10             	shr    $0x10,%eax
  1012e2:	66 89 44 19 06       	mov    %ax,0x6(%ecx,%ebx,1)
    SETGATE(idt[T_DEBUG],                   0, CPU_GDT_KCODE, &Xdebug,          0);
  1012e7:	c7 c0 da 20 10 00    	mov    $0x1020da,%eax
    SETGATE(idt[T_NMI],                     0, CPU_GDT_KCODE, &Xnmi,            0);
  1012ed:	c7 83 92 b0 03 00 08 	movl   $0x8e000008,0x3b092(%ebx)
  1012f4:	00 00 8e 
    SETGATE(idt[T_DEBUG],                   0, CPU_GDT_KCODE, &Xdebug,          0);
  1012f7:	66 89 44 19 08       	mov    %ax,0x8(%ecx,%ebx,1)
  1012fc:	c1 e8 10             	shr    $0x10,%eax
  1012ff:	66 89 44 19 0e       	mov    %ax,0xe(%ecx,%ebx,1)
    SETGATE(idt[T_NMI],                     0, CPU_GDT_KCODE, &Xnmi,            0);
  101304:	c7 c0 e4 20 10 00    	mov    $0x1020e4,%eax
    SETGATE(idt[T_BRKPT],                   0, CPU_GDT_KCODE, &Xbrkpt,          3);
  10130a:	c7 83 9a b0 03 00 08 	movl   $0xee000008,0x3b09a(%ebx)
  101311:	00 00 ee 
    SETGATE(idt[T_NMI],                     0, CPU_GDT_KCODE, &Xnmi,            0);
  101314:	66 89 44 19 10       	mov    %ax,0x10(%ecx,%ebx,1)
  101319:	c1 e8 10             	shr    $0x10,%eax
  10131c:	66 89 44 19 16       	mov    %ax,0x16(%ecx,%ebx,1)
    SETGATE(idt[T_BRKPT],                   0, CPU_GDT_KCODE, &Xbrkpt,          3);
  101321:	c7 c0 ee 20 10 00    	mov    $0x1020ee,%eax
    SETGATE(idt[T_OFLOW],                   0, CPU_GDT_KCODE, &Xoflow,          3);
  101327:	c7 83 a2 b0 03 00 08 	movl   $0xee000008,0x3b0a2(%ebx)
  10132e:	00 00 ee 
    SETGATE(idt[T_BRKPT],                   0, CPU_GDT_KCODE, &Xbrkpt,          3);
  101331:	66 89 44 19 18       	mov    %ax,0x18(%ecx,%ebx,1)
  101336:	c1 e8 10             	shr    $0x10,%eax
  101339:	66 89 44 19 1e       	mov    %ax,0x1e(%ecx,%ebx,1)
    SETGATE(idt[T_OFLOW],                   0, CPU_GDT_KCODE, &Xoflow,          3);
  10133e:	c7 c0 f8 20 10 00    	mov    $0x1020f8,%eax
    SETGATE(idt[T_BOUND],                   0, CPU_GDT_KCODE, &Xbound,          0);
  101344:	c7 83 aa b0 03 00 08 	movl   $0x8e000008,0x3b0aa(%ebx)
  10134b:	00 00 8e 
    SETGATE(idt[T_OFLOW],                   0, CPU_GDT_KCODE, &Xoflow,          3);
  10134e:	66 89 44 19 20       	mov    %ax,0x20(%ecx,%ebx,1)
  101353:	c1 e8 10             	shr    $0x10,%eax
  101356:	66 89 44 19 26       	mov    %ax,0x26(%ecx,%ebx,1)
    SETGATE(idt[T_BOUND],                   0, CPU_GDT_KCODE, &Xbound,          0);
  10135b:	c7 c0 02 21 10 00    	mov    $0x102102,%eax
    SETGATE(idt[T_ILLOP],                   0, CPU_GDT_KCODE, &Xillop,          0);
  101361:	c7 83 b2 b0 03 00 08 	movl   $0x8e000008,0x3b0b2(%ebx)
  101368:	00 00 8e 
    SETGATE(idt[T_BOUND],                   0, CPU_GDT_KCODE, &Xbound,          0);
  10136b:	66 89 44 19 28       	mov    %ax,0x28(%ecx,%ebx,1)
  101370:	c1 e8 10             	shr    $0x10,%eax
  101373:	66 89 44 19 2e       	mov    %ax,0x2e(%ecx,%ebx,1)
    SETGATE(idt[T_ILLOP],                   0, CPU_GDT_KCODE, &Xillop,          0);
  101378:	c7 c0 0c 21 10 00    	mov    $0x10210c,%eax
    SETGATE(idt[T_DEVICE],                  0, CPU_GDT_KCODE, &Xdevice,         0);
  10137e:	c7 83 ba b0 03 00 08 	movl   $0x8e000008,0x3b0ba(%ebx)
  101385:	00 00 8e 
    SETGATE(idt[T_ILLOP],                   0, CPU_GDT_KCODE, &Xillop,          0);
  101388:	66 89 44 19 30       	mov    %ax,0x30(%ecx,%ebx,1)
  10138d:	c1 e8 10             	shr    $0x10,%eax
  101390:	66 89 44 19 36       	mov    %ax,0x36(%ecx,%ebx,1)
    SETGATE(idt[T_DEVICE],                  0, CPU_GDT_KCODE, &Xdevice,         0);
  101395:	c7 c0 16 21 10 00    	mov    $0x102116,%eax
  10139b:	66 89 44 19 38       	mov    %ax,0x38(%ecx,%ebx,1)
  1013a0:	c1 e8 10             	shr    $0x10,%eax
  1013a3:	66 89 44 19 3e       	mov    %ax,0x3e(%ecx,%ebx,1)
    SETGATE(idt[T_DBLFLT],                  0, CPU_GDT_KCODE, &Xdblflt,         0);
  1013a8:	c7 c0 20 21 10 00    	mov    $0x102120,%eax
    SETGATE(idt[T_FPERR],                   0, CPU_GDT_KCODE, &Xfperr,          0);
  1013ae:	66 89 94 19 82 00 00 	mov    %dx,0x82(%ecx,%ebx,1)
  1013b5:	00 
    SETGATE(idt[T_DBLFLT],                  0, CPU_GDT_KCODE, &Xdblflt,         0);
  1013b6:	66 89 44 19 40       	mov    %ax,0x40(%ecx,%ebx,1)
  1013bb:	c1 e8 10             	shr    $0x10,%eax
  1013be:	66 89 44 19 46       	mov    %ax,0x46(%ecx,%ebx,1)
    SETGATE(idt[T_TSS],                     0, CPU_GDT_KCODE, &Xtss,            0);
  1013c3:	c7 c0 32 21 10 00    	mov    $0x102132,%eax
    SETGATE(idt[T_DBLFLT],                  0, CPU_GDT_KCODE, &Xdblflt,         0);
  1013c9:	c7 83 c2 b0 03 00 08 	movl   $0x8e000008,0x3b0c2(%ebx)
  1013d0:	00 00 8e 
    SETGATE(idt[T_TSS],                     0, CPU_GDT_KCODE, &Xtss,            0);
  1013d3:	66 89 44 19 50       	mov    %ax,0x50(%ecx,%ebx,1)
  1013d8:	c1 e8 10             	shr    $0x10,%eax
  1013db:	66 89 44 19 56       	mov    %ax,0x56(%ecx,%ebx,1)
    SETGATE(idt[T_SEGNP],                   0, CPU_GDT_KCODE, &Xsegnp,          0);
  1013e0:	c7 c0 3a 21 10 00    	mov    $0x10213a,%eax
    SETGATE(idt[T_TSS],                     0, CPU_GDT_KCODE, &Xtss,            0);
  1013e6:	c7 83 d2 b0 03 00 08 	movl   $0x8e000008,0x3b0d2(%ebx)
  1013ed:	00 00 8e 
    SETGATE(idt[T_SEGNP],                   0, CPU_GDT_KCODE, &Xsegnp,          0);
  1013f0:	66 89 44 19 58       	mov    %ax,0x58(%ecx,%ebx,1)
  1013f5:	c1 e8 10             	shr    $0x10,%eax
  1013f8:	66 89 44 19 5e       	mov    %ax,0x5e(%ecx,%ebx,1)
    SETGATE(idt[T_STACK],                   0, CPU_GDT_KCODE, &Xstack,          0);
  1013fd:	c7 c0 42 21 10 00    	mov    $0x102142,%eax
    SETGATE(idt[T_SEGNP],                   0, CPU_GDT_KCODE, &Xsegnp,          0);
  101403:	c7 83 da b0 03 00 08 	movl   $0x8e000008,0x3b0da(%ebx)
  10140a:	00 00 8e 
    SETGATE(idt[T_STACK],                   0, CPU_GDT_KCODE, &Xstack,          0);
  10140d:	66 89 44 19 60       	mov    %ax,0x60(%ecx,%ebx,1)
  101412:	c1 e8 10             	shr    $0x10,%eax
  101415:	66 89 44 19 66       	mov    %ax,0x66(%ecx,%ebx,1)
    SETGATE(idt[T_GPFLT],                   0, CPU_GDT_KCODE, &Xgpflt,          0);
  10141a:	c7 c0 4a 21 10 00    	mov    $0x10214a,%eax
    SETGATE(idt[T_STACK],                   0, CPU_GDT_KCODE, &Xstack,          0);
  101420:	c7 83 e2 b0 03 00 08 	movl   $0x8e000008,0x3b0e2(%ebx)
  101427:	00 00 8e 
    SETGATE(idt[T_GPFLT],                   0, CPU_GDT_KCODE, &Xgpflt,          0);
  10142a:	66 89 44 19 68       	mov    %ax,0x68(%ecx,%ebx,1)
  10142f:	c1 e8 10             	shr    $0x10,%eax
  101432:	66 89 44 19 6e       	mov    %ax,0x6e(%ecx,%ebx,1)
    SETGATE(idt[T_PGFLT],                   0, CPU_GDT_KCODE, &Xpgflt,          0);
  101437:	c7 c0 52 21 10 00    	mov    $0x102152,%eax
    SETGATE(idt[T_GPFLT],                   0, CPU_GDT_KCODE, &Xgpflt,          0);
  10143d:	c7 83 ea b0 03 00 08 	movl   $0x8e000008,0x3b0ea(%ebx)
  101444:	00 00 8e 
    SETGATE(idt[T_PGFLT],                   0, CPU_GDT_KCODE, &Xpgflt,          0);
  101447:	66 89 44 19 70       	mov    %ax,0x70(%ecx,%ebx,1)
  10144c:	c1 e8 10             	shr    $0x10,%eax
  10144f:	66 89 44 19 76       	mov    %ax,0x76(%ecx,%ebx,1)
    SETGATE(idt[T_FPERR],                   0, CPU_GDT_KCODE, &Xfperr,          0);
  101454:	c7 c0 64 21 10 00    	mov    $0x102164,%eax
    SETGATE(idt[T_PGFLT],                   0, CPU_GDT_KCODE, &Xpgflt,          0);
  10145a:	c7 83 f2 b0 03 00 08 	movl   $0x8e000008,0x3b0f2(%ebx)
  101461:	00 00 8e 
    SETGATE(idt[T_FPERR],                   0, CPU_GDT_KCODE, &Xfperr,          0);
  101464:	66 89 84 19 80 00 00 	mov    %ax,0x80(%ecx,%ebx,1)
  10146b:	00 
  10146c:	c1 e8 10             	shr    $0x10,%eax
  10146f:	66 89 84 19 86 00 00 	mov    %ax,0x86(%ecx,%ebx,1)
  101476:	00 
    SETGATE(idt[T_ALIGN],                   0, CPU_GDT_KCODE, &Xalign,          0);
  101477:	c7 c0 6e 21 10 00    	mov    $0x10216e,%eax
    SETGATE(idt[T_FPERR],                   0, CPU_GDT_KCODE, &Xfperr,          0);
  10147d:	66 89 b3 04 b1 03 00 	mov    %si,0x3b104(%ebx)
    SETGATE(idt[T_ALIGN],                   0, CPU_GDT_KCODE, &Xalign,          0);
  101484:	66 89 84 19 88 00 00 	mov    %ax,0x88(%ecx,%ebx,1)
  10148b:	00 
  10148c:	c1 e8 10             	shr    $0x10,%eax
  10148f:	c7 83 0a b1 03 00 08 	movl   $0x8e000008,0x3b10a(%ebx)
  101496:	00 00 8e 
  101499:	66 89 84 19 8e 00 00 	mov    %ax,0x8e(%ecx,%ebx,1)
  1014a0:	00 
    SETGATE(idt[T_MCHK],                    0, CPU_GDT_KCODE, &Xmchk,           0);
  1014a1:	c7 c0 72 21 10 00    	mov    $0x102172,%eax
  1014a7:	c7 83 12 b1 03 00 08 	movl   $0x8e000008,0x3b112(%ebx)
  1014ae:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL13],     0, CPU_GDT_KCODE, &Xirq_serial1,    0);
  1014b1:	c7 c2 90 21 10 00    	mov    $0x102190,%edx
    SETGATE(idt[T_MCHK],                    0, CPU_GDT_KCODE, &Xmchk,           0);
  1014b7:	66 89 84 19 90 00 00 	mov    %ax,0x90(%ecx,%ebx,1)
  1014be:	00 
  1014bf:	c1 e8 10             	shr    $0x10,%eax
  1014c2:	66 89 84 19 96 00 00 	mov    %ax,0x96(%ecx,%ebx,1)
  1014c9:	00 
    SETGATE(idt[T_IRQ0 + IRQ_TIMER],        0, CPU_GDT_KCODE, &Xirq_timer,      0);
  1014ca:	c7 c0 78 21 10 00    	mov    $0x102178,%eax
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL13],     0, CPU_GDT_KCODE, &Xirq_serial1,    0);
  1014d0:	66 89 94 19 20 01 00 	mov    %dx,0x120(%ecx,%ebx,1)
  1014d7:	00 
  1014d8:	c1 ea 10             	shr    $0x10,%edx
    SETGATE(idt[T_IRQ0 + IRQ_TIMER],        0, CPU_GDT_KCODE, &Xirq_timer,      0);
  1014db:	66 89 84 19 00 01 00 	mov    %ax,0x100(%ecx,%ebx,1)
  1014e2:	00 
  1014e3:	c1 e8 10             	shr    $0x10,%eax
  1014e6:	66 89 84 19 06 01 00 	mov    %ax,0x106(%ecx,%ebx,1)
  1014ed:	00 
    SETGATE(idt[T_IRQ0 + IRQ_KBD],          0, CPU_GDT_KCODE, &Xirq_kbd,        0);
  1014ee:	c7 c0 7e 21 10 00    	mov    $0x10217e,%eax
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL13],     0, CPU_GDT_KCODE, &Xirq_serial1,    0);
  1014f4:	66 89 94 19 26 01 00 	mov    %dx,0x126(%ecx,%ebx,1)
  1014fb:	00 
    SETGATE(idt[T_IRQ0 + IRQ_KBD],          0, CPU_GDT_KCODE, &Xirq_kbd,        0);
  1014fc:	66 89 84 19 08 01 00 	mov    %ax,0x108(%ecx,%ebx,1)
  101503:	00 
  101504:	c1 e8 10             	shr    $0x10,%eax
  101507:	66 89 84 19 0e 01 00 	mov    %ax,0x10e(%ecx,%ebx,1)
  10150e:	00 
    SETGATE(idt[T_IRQ0 + IRQ_SLAVE],        0, CPU_GDT_KCODE, &Xirq_slave,      0);
  10150f:	c7 c0 84 21 10 00    	mov    $0x102184,%eax
    SETGATE(idt[T_IRQ0 + IRQ_TIMER],        0, CPU_GDT_KCODE, &Xirq_timer,      0);
  101515:	c7 83 82 b1 03 00 08 	movl   $0x8e000008,0x3b182(%ebx)
  10151c:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_SLAVE],        0, CPU_GDT_KCODE, &Xirq_slave,      0);
  10151f:	66 89 84 19 10 01 00 	mov    %ax,0x110(%ecx,%ebx,1)
  101526:	00 
  101527:	c1 e8 10             	shr    $0x10,%eax
  10152a:	66 89 84 19 16 01 00 	mov    %ax,0x116(%ecx,%ebx,1)
  101531:	00 
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL24],     0, CPU_GDT_KCODE, &Xirq_serial2,    0);
  101532:	c7 c0 8a 21 10 00    	mov    $0x10218a,%eax
    SETGATE(idt[T_IRQ0 + IRQ_KBD],          0, CPU_GDT_KCODE, &Xirq_kbd,        0);
  101538:	c7 83 8a b1 03 00 08 	movl   $0x8e000008,0x3b18a(%ebx)
  10153f:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL24],     0, CPU_GDT_KCODE, &Xirq_serial2,    0);
  101542:	66 89 84 19 18 01 00 	mov    %ax,0x118(%ecx,%ebx,1)
  101549:	00 
  10154a:	c1 e8 10             	shr    $0x10,%eax
  10154d:	66 89 84 19 1e 01 00 	mov    %ax,0x11e(%ecx,%ebx,1)
  101554:	00 
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL13],     0, CPU_GDT_KCODE, &Xirq_serial1,    0);
  101555:	8b 83 a2 b1 03 00    	mov    0x3b1a2(%ebx),%eax
    SETGATE(idt[T_IRQ0 + IRQ_SLAVE],        0, CPU_GDT_KCODE, &Xirq_slave,      0);
  10155b:	c7 83 92 b1 03 00 08 	movl   $0x8e000008,0x3b192(%ebx)
  101562:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL24],     0, CPU_GDT_KCODE, &Xirq_serial2,    0);
  101565:	c7 83 9a b1 03 00 08 	movl   $0x8e000008,0x3b19a(%ebx)
  10156c:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL13],     0, CPU_GDT_KCODE, &Xirq_serial1,    0);
  10156f:	25 00 00 e0 ff       	and    $0xffe00000,%eax
    SETGATE(idt[T_IRQ0 + IRQ_LPT2],         0, CPU_GDT_KCODE, &Xirq_lpt,        0);
  101574:	c7 83 aa b1 03 00 08 	movl   $0x8e000008,0x3b1aa(%ebx)
  10157b:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL13],     0, CPU_GDT_KCODE, &Xirq_serial1,    0);
  10157e:	83 c8 08             	or     $0x8,%eax
  101581:	89 83 a2 b1 03 00    	mov    %eax,0x3b1a2(%ebx)
  101587:	0f b7 83 a4 b1 03 00 	movzwl 0x3b1a4(%ebx),%eax
  10158e:	83 e0 1f             	and    $0x1f,%eax
  101591:	66 0d 00 8e          	or     $0x8e00,%ax
  101595:	66 89 83 a4 b1 03 00 	mov    %ax,0x3b1a4(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_LPT2],         0, CPU_GDT_KCODE, &Xirq_lpt,        0);
  10159c:	c7 c0 96 21 10 00    	mov    $0x102196,%eax
  1015a2:	66 89 84 19 28 01 00 	mov    %ax,0x128(%ecx,%ebx,1)
  1015a9:	00 
  1015aa:	c1 e8 10             	shr    $0x10,%eax
  1015ad:	66 89 84 19 2e 01 00 	mov    %ax,0x12e(%ecx,%ebx,1)
  1015b4:	00 
    SETGATE(idt[T_IRQ0 + IRQ_FLOPPY],       0, CPU_GDT_KCODE, &Xirq_floppy,     0);
  1015b5:	c7 c0 9c 21 10 00    	mov    $0x10219c,%eax
  1015bb:	66 89 84 19 30 01 00 	mov    %ax,0x130(%ecx,%ebx,1)
  1015c2:	00 
  1015c3:	c1 e8 10             	shr    $0x10,%eax
    SETGATE(idt[T_IRQ0 + 11],               0, CPU_GDT_KCODE, &Xirq11,          0);
  1015c6:	c7 c2 ba 21 10 00    	mov    $0x1021ba,%edx
    SETGATE(idt[T_IRQ0 + IRQ_FLOPPY],       0, CPU_GDT_KCODE, &Xirq_floppy,     0);
  1015cc:	66 89 84 19 36 01 00 	mov    %ax,0x136(%ecx,%ebx,1)
  1015d3:	00 
    SETGATE(idt[T_IRQ0 + IRQ_SPURIOUS],     0, CPU_GDT_KCODE, &Xirq_spurious,   0);
  1015d4:	c7 c0 a2 21 10 00    	mov    $0x1021a2,%eax
    SETGATE(idt[T_IRQ0 + 11],               0, CPU_GDT_KCODE, &Xirq11,          0);
  1015da:	66 89 94 19 58 01 00 	mov    %dx,0x158(%ecx,%ebx,1)
  1015e1:	00 
    SETGATE(idt[T_IRQ0 + IRQ_SPURIOUS],     0, CPU_GDT_KCODE, &Xirq_spurious,   0);
  1015e2:	66 89 84 19 38 01 00 	mov    %ax,0x138(%ecx,%ebx,1)
  1015e9:	00 
  1015ea:	c1 e8 10             	shr    $0x10,%eax
  1015ed:	66 89 84 19 3e 01 00 	mov    %ax,0x13e(%ecx,%ebx,1)
  1015f4:	00 
    SETGATE(idt[T_IRQ0 + IRQ_RTC],          0, CPU_GDT_KCODE, &Xirq_rtc,        0);
  1015f5:	c7 c0 a8 21 10 00    	mov    $0x1021a8,%eax
    SETGATE(idt[T_IRQ0 + IRQ_FLOPPY],       0, CPU_GDT_KCODE, &Xirq_floppy,     0);
  1015fb:	c7 83 b2 b1 03 00 08 	movl   $0x8e000008,0x3b1b2(%ebx)
  101602:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_RTC],          0, CPU_GDT_KCODE, &Xirq_rtc,        0);
  101605:	66 89 84 19 40 01 00 	mov    %ax,0x140(%ecx,%ebx,1)
  10160c:	00 
  10160d:	c1 e8 10             	shr    $0x10,%eax
  101610:	66 89 84 19 46 01 00 	mov    %ax,0x146(%ecx,%ebx,1)
  101617:	00 
    SETGATE(idt[T_IRQ0 + 9],                0, CPU_GDT_KCODE, &Xirq9,           0);
  101618:	c7 c0 ae 21 10 00    	mov    $0x1021ae,%eax
    SETGATE(idt[T_IRQ0 + IRQ_SPURIOUS],     0, CPU_GDT_KCODE, &Xirq_spurious,   0);
  10161e:	c7 83 ba b1 03 00 08 	movl   $0x8e000008,0x3b1ba(%ebx)
  101625:	00 00 8e 
    SETGATE(idt[T_IRQ0 + 9],                0, CPU_GDT_KCODE, &Xirq9,           0);
  101628:	66 89 84 19 48 01 00 	mov    %ax,0x148(%ecx,%ebx,1)
  10162f:	00 
  101630:	c1 e8 10             	shr    $0x10,%eax
  101633:	66 89 84 19 4e 01 00 	mov    %ax,0x14e(%ecx,%ebx,1)
  10163a:	00 
    SETGATE(idt[T_IRQ0 + 10],               0, CPU_GDT_KCODE, &Xirq10,          0);
  10163b:	c7 c0 b4 21 10 00    	mov    $0x1021b4,%eax
    SETGATE(idt[T_IRQ0 + IRQ_RTC],          0, CPU_GDT_KCODE, &Xirq_rtc,        0);
  101641:	c7 83 c2 b1 03 00 08 	movl   $0x8e000008,0x3b1c2(%ebx)
  101648:	00 00 8e 
    SETGATE(idt[T_IRQ0 + 10],               0, CPU_GDT_KCODE, &Xirq10,          0);
  10164b:	66 89 84 19 50 01 00 	mov    %ax,0x150(%ecx,%ebx,1)
  101652:	00 
  101653:	c1 e8 10             	shr    $0x10,%eax
  101656:	66 89 84 19 56 01 00 	mov    %ax,0x156(%ecx,%ebx,1)
  10165d:	00 
    SETGATE(idt[T_IRQ0 + 11],               0, CPU_GDT_KCODE, &Xirq11,          0);
  10165e:	8b 83 da b1 03 00    	mov    0x3b1da(%ebx),%eax
    SETGATE(idt[T_IRQ0 + 9],                0, CPU_GDT_KCODE, &Xirq9,           0);
  101664:	c7 83 ca b1 03 00 08 	movl   $0x8e000008,0x3b1ca(%ebx)
  10166b:	00 00 8e 
    SETGATE(idt[T_IRQ0 + 10],               0, CPU_GDT_KCODE, &Xirq10,          0);
  10166e:	c7 83 d2 b1 03 00 08 	movl   $0x8e000008,0x3b1d2(%ebx)
  101675:	00 00 8e 
    SETGATE(idt[T_IRQ0 + 11],               0, CPU_GDT_KCODE, &Xirq11,          0);
  101678:	25 00 00 00 ff       	and    $0xff000000,%eax
  10167d:	c1 ea 10             	shr    $0x10,%edx
  101680:	83 c8 08             	or     $0x8,%eax
  101683:	66 89 94 19 5e 01 00 	mov    %dx,0x15e(%ecx,%ebx,1)
  10168a:	00 
  10168b:	89 83 da b1 03 00    	mov    %eax,0x3b1da(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_MOUSE],        0, CPU_GDT_KCODE, &Xirq_mouse,      0);
  101691:	c7 c0 c0 21 10 00    	mov    $0x1021c0,%eax
    SETGATE(idt[T_IRQ0 + 11],               0, CPU_GDT_KCODE, &Xirq11,          0);
  101697:	c6 83 dd b1 03 00 8e 	movb   $0x8e,0x3b1dd(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_MOUSE],        0, CPU_GDT_KCODE, &Xirq_mouse,      0);
  10169e:	66 89 84 19 60 01 00 	mov    %ax,0x160(%ecx,%ebx,1)
  1016a5:	00 
  1016a6:	c1 e8 10             	shr    $0x10,%eax
  1016a9:	66 89 84 19 66 01 00 	mov    %ax,0x166(%ecx,%ebx,1)
  1016b0:	00 
    SETGATE(idt[T_IRQ0 + IRQ_COPROCESSOR],  0, CPU_GDT_KCODE, &Xirq_coproc,     0);
  1016b1:	c7 c0 c6 21 10 00    	mov    $0x1021c6,%eax
    SETGATE(idt[T_IRQ0 + IRQ_MOUSE],        0, CPU_GDT_KCODE, &Xirq_mouse,      0);
  1016b7:	c7 83 e2 b1 03 00 08 	movl   $0x8e000008,0x3b1e2(%ebx)
  1016be:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_COPROCESSOR],  0, CPU_GDT_KCODE, &Xirq_coproc,     0);
  1016c1:	66 89 84 19 68 01 00 	mov    %ax,0x168(%ecx,%ebx,1)
  1016c8:	00 
  1016c9:	c1 e8 10             	shr    $0x10,%eax
  1016cc:	c7 83 ea b1 03 00 08 	movl   $0x8e000008,0x3b1ea(%ebx)
  1016d3:	00 00 8e 
  1016d6:	66 89 84 19 6e 01 00 	mov    %ax,0x16e(%ecx,%ebx,1)
  1016dd:	00 
    SETGATE(idt[T_IRQ0 + IRQ_IDE1],         0, CPU_GDT_KCODE, &Xirq_ide1,       0);
  1016de:	c7 c0 cc 21 10 00    	mov    $0x1021cc,%eax
  1016e4:	c7 83 f2 b1 03 00 08 	movl   $0x8e000008,0x3b1f2(%ebx)
  1016eb:	00 00 8e 
  1016ee:	66 89 84 19 70 01 00 	mov    %ax,0x170(%ecx,%ebx,1)
  1016f5:	00 
  1016f6:	c1 e8 10             	shr    $0x10,%eax
  1016f9:	66 89 84 19 76 01 00 	mov    %ax,0x176(%ecx,%ebx,1)
  101700:	00 
    SETGATE(idt[T_IRQ0 + IRQ_IDE2],         0, CPU_GDT_KCODE, &Xirq_ide2,       0);
  101701:	c7 c0 d2 21 10 00    	mov    $0x1021d2,%eax
  101707:	c7 83 fa b1 03 00 08 	movl   $0x8e000008,0x3b1fa(%ebx)
  10170e:	00 00 8e 
  101711:	66 89 84 19 78 01 00 	mov    %ax,0x178(%ecx,%ebx,1)
  101718:	00 
  101719:	c1 e8 10             	shr    $0x10,%eax
  10171c:	66 89 84 19 7e 01 00 	mov    %ax,0x17e(%ecx,%ebx,1)
  101723:	00 
    SETGATE(idt[T_SYSCALL], 0, CPU_GDT_KCODE, &Xsyscall, 3);
  101724:	c7 c0 d8 21 10 00    	mov    $0x1021d8,%eax
  10172a:	c7 83 02 b2 03 00 08 	movl   $0xee000008,0x3b202(%ebx)
  101731:	00 00 ee 
  101734:	66 89 84 19 80 01 00 	mov    %ax,0x180(%ecx,%ebx,1)
  10173b:	00 
  10173c:	c1 e8 10             	shr    $0x10,%eax
  10173f:	66 89 84 19 86 01 00 	mov    %ax,0x186(%ecx,%ebx,1)
  101746:	00 
    SETGATE(idt[T_DEFAULT], 0, CPU_GDT_KCODE, &Xdefault, 0);
  101747:	0f b7 44 24 0c       	movzwl 0xc(%esp),%eax
  10174c:	c7 83 72 b8 03 00 08 	movl   $0x8e000008,0x3b872(%ebx)
  101753:	00 00 8e 
  101756:	66 89 84 19 f0 07 00 	mov    %ax,0x7f0(%ecx,%ebx,1)
  10175d:	00 
  10175e:	0f b7 44 24 08       	movzwl 0x8(%esp),%eax
  101763:	66 89 84 19 f6 07 00 	mov    %ax,0x7f6(%ecx,%ebx,1)
  10176a:	00 
    if (using_apic)
  10176b:	0f b6 83 80 b8 03 00 	movzbl 0x3b880(%ebx),%eax
  101772:	84 c0                	test   %al,%al
  101774:	0f 84 c0 fa ff ff    	je     10123a <intr_init+0x7a>
  10177a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        lapic_init();
  101780:	e8 db 0d 00 00       	call   102560 <lapic_init>
  101785:	e9 b0 fa ff ff       	jmp    10123a <intr_init+0x7a>
  10178a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00101790 <intr_enable>:

void intr_enable(uint8_t irq, int cpunum)
{
  101790:	57                   	push   %edi
  101791:	56                   	push   %esi
  101792:	53                   	push   %ebx
  101793:	8b 7c 24 14          	mov    0x14(%esp),%edi
  101797:	e8 ed eb ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10179c:	81 c3 64 28 01 00    	add    $0x12864,%ebx
  1017a2:	8b 74 24 10          	mov    0x10(%esp),%esi
    KERN_ASSERT(cpunum == 0xff || (0 <= cpunum && cpunum < pcpu_ncpu()));
  1017a6:	81 ff ff 00 00 00    	cmp    $0xff,%edi
  1017ac:	74 12                	je     1017c0 <intr_enable+0x30>
  1017ae:	85 ff                	test   %edi,%edi
  1017b0:	78 3e                	js     1017f0 <intr_enable+0x60>
  1017b2:	e8 59 22 00 00       	call   103a10 <pcpu_ncpu>
  1017b7:	39 f8                	cmp    %edi,%eax
  1017b9:	76 35                	jbe    1017f0 <intr_enable+0x60>
  1017bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1017bf:	90                   	nop

    if (irq >= 24)
  1017c0:	89 f0                	mov    %esi,%eax
  1017c2:	3c 17                	cmp    $0x17,%al
  1017c4:	77 26                	ja     1017ec <intr_enable+0x5c>
        return;

    if (using_apic == TRUE) {
  1017c6:	0f b6 83 80 b8 03 00 	movzbl 0x3b880(%ebx),%eax
  1017cd:	3c 01                	cmp    $0x1,%al
  1017cf:	74 47                	je     101818 <intr_enable+0x88>
        ioapic_enable(irq, (cpunum == 0xff) ?  0xff : pcpu_cpu_lapicid(cpunum), 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
  1017d1:	89 f0                	mov    %esi,%eax
  1017d3:	3c 0f                	cmp    $0xf,%al
  1017d5:	0f 87 7d 00 00 00    	ja     101858 <intr_enable+0xc8>
        pic_enable(irq);
  1017db:	89 f0                	mov    %esi,%eax
  1017dd:	83 ec 0c             	sub    $0xc,%esp
  1017e0:	0f b6 f0             	movzbl %al,%esi
  1017e3:	56                   	push   %esi
  1017e4:	e8 e7 02 00 00       	call   101ad0 <pic_enable>
  1017e9:	83 c4 10             	add    $0x10,%esp
    }
}
  1017ec:	5b                   	pop    %ebx
  1017ed:	5e                   	pop    %esi
  1017ee:	5f                   	pop    %edi
  1017ef:	c3                   	ret    
    KERN_ASSERT(cpunum == 0xff || (0 <= cpunum && cpunum < pcpu_ncpu()));
  1017f0:	8d 83 5c 74 ff ff    	lea    -0x8ba4(%ebx),%eax
  1017f6:	50                   	push   %eax
  1017f7:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  1017fd:	50                   	push   %eax
  1017fe:	8d 83 40 74 ff ff    	lea    -0x8bc0(%ebx),%eax
  101804:	6a 7a                	push   $0x7a
  101806:	50                   	push   %eax
  101807:	e8 04 2f 00 00       	call   104710 <debug_panic>
  10180c:	83 c4 10             	add    $0x10,%esp
  10180f:	eb af                	jmp    1017c0 <intr_enable+0x30>
  101811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        ioapic_enable(irq, (cpunum == 0xff) ?  0xff : pcpu_cpu_lapicid(cpunum), 0, 0);
  101818:	81 ff ff 00 00 00    	cmp    $0xff,%edi
  10181e:	75 20                	jne    101840 <intr_enable+0xb0>
  101820:	89 f0                	mov    %esi,%eax
  101822:	6a 00                	push   $0x0
  101824:	0f b6 f0             	movzbl %al,%esi
  101827:	6a 00                	push   $0x0
  101829:	57                   	push   %edi
  10182a:	56                   	push   %esi
  10182b:	e8 d0 13 00 00       	call   102c00 <ioapic_enable>
  101830:	83 c4 10             	add    $0x10,%esp
}
  101833:	5b                   	pop    %ebx
  101834:	5e                   	pop    %esi
  101835:	5f                   	pop    %edi
  101836:	c3                   	ret    
  101837:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10183e:	66 90                	xchg   %ax,%ax
        ioapic_enable(irq, (cpunum == 0xff) ?  0xff : pcpu_cpu_lapicid(cpunum), 0, 0);
  101840:	83 ec 0c             	sub    $0xc,%esp
  101843:	57                   	push   %edi
  101844:	e8 57 22 00 00       	call   103aa0 <pcpu_cpu_lapicid>
  101849:	83 c4 10             	add    $0x10,%esp
  10184c:	0f b6 f8             	movzbl %al,%edi
  10184f:	eb cf                	jmp    101820 <intr_enable+0x90>
  101851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        KERN_ASSERT(irq < 16);
  101858:	8d 83 50 74 ff ff    	lea    -0x8bb0(%ebx),%eax
  10185e:	50                   	push   %eax
  10185f:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  101865:	50                   	push   %eax
  101866:	8d 83 40 74 ff ff    	lea    -0x8bc0(%ebx),%eax
  10186c:	68 82 00 00 00       	push   $0x82
  101871:	50                   	push   %eax
  101872:	e8 99 2e 00 00       	call   104710 <debug_panic>
  101877:	83 c4 10             	add    $0x10,%esp
  10187a:	e9 5c ff ff ff       	jmp    1017db <intr_enable+0x4b>
  10187f:	90                   	nop

00101880 <intr_enable_lapicid>:

void intr_enable_lapicid(uint8_t irq, int lapic_id)
{
  101880:	56                   	push   %esi
  101881:	53                   	push   %ebx
  101882:	e8 02 eb ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101887:	81 c3 79 27 01 00    	add    $0x12779,%ebx
  10188d:	83 ec 04             	sub    $0x4,%esp
  101890:	8b 44 24 10          	mov    0x10(%esp),%eax
    if (irq > 24)
  101894:	3c 18                	cmp    $0x18,%al
  101896:	77 1f                	ja     1018b7 <intr_enable_lapicid+0x37>
        return;

    if (using_apic == TRUE) {
  101898:	0f b6 93 80 b8 03 00 	movzbl 0x3b880(%ebx),%edx
        ioapic_enable(irq, (lapic_id == 0xff) ?  0xff : lapic_id, 0, 0);
  10189f:	0f b6 f0             	movzbl %al,%esi
    if (using_apic == TRUE) {
  1018a2:	80 fa 01             	cmp    $0x1,%dl
  1018a5:	74 41                	je     1018e8 <intr_enable_lapicid+0x68>
    } else {
        KERN_ASSERT(irq < 16);
  1018a7:	3c 0f                	cmp    $0xf,%al
  1018a9:	77 15                	ja     1018c0 <intr_enable_lapicid+0x40>
        pic_enable(irq);
  1018ab:	83 ec 0c             	sub    $0xc,%esp
  1018ae:	56                   	push   %esi
  1018af:	e8 1c 02 00 00       	call   101ad0 <pic_enable>
  1018b4:	83 c4 10             	add    $0x10,%esp
    }
}
  1018b7:	83 c4 04             	add    $0x4,%esp
  1018ba:	5b                   	pop    %ebx
  1018bb:	5e                   	pop    %esi
  1018bc:	c3                   	ret    
  1018bd:	8d 76 00             	lea    0x0(%esi),%esi
        KERN_ASSERT(irq < 16);
  1018c0:	8d 83 50 74 ff ff    	lea    -0x8bb0(%ebx),%eax
  1018c6:	50                   	push   %eax
  1018c7:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  1018cd:	50                   	push   %eax
  1018ce:	8d 83 40 74 ff ff    	lea    -0x8bc0(%ebx),%eax
  1018d4:	68 8f 00 00 00       	push   $0x8f
  1018d9:	50                   	push   %eax
  1018da:	e8 31 2e 00 00       	call   104710 <debug_panic>
  1018df:	83 c4 10             	add    $0x10,%esp
  1018e2:	eb c7                	jmp    1018ab <intr_enable_lapicid+0x2b>
  1018e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        ioapic_enable(irq, (lapic_id == 0xff) ?  0xff : lapic_id, 0, 0);
  1018e8:	6a 00                	push   $0x0
  1018ea:	6a 00                	push   $0x0
  1018ec:	0f b6 44 24 1c       	movzbl 0x1c(%esp),%eax
  1018f1:	50                   	push   %eax
  1018f2:	56                   	push   %esi
  1018f3:	e8 08 13 00 00       	call   102c00 <ioapic_enable>
  1018f8:	83 c4 10             	add    $0x10,%esp
}
  1018fb:	83 c4 04             	add    $0x4,%esp
  1018fe:	5b                   	pop    %ebx
  1018ff:	5e                   	pop    %esi
  101900:	c3                   	ret    
  101901:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101908:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10190f:	90                   	nop

00101910 <intr_eoi>:

void intr_eoi(void)
{
  101910:	53                   	push   %ebx
  101911:	e8 73 ea ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101916:	81 c3 ea 26 01 00    	add    $0x126ea,%ebx
  10191c:	83 ec 08             	sub    $0x8,%esp
    if (using_apic == TRUE)
  10191f:	0f b6 83 80 b8 03 00 	movzbl 0x3b880(%ebx),%eax
  101926:	3c 01                	cmp    $0x1,%al
  101928:	74 0e                	je     101938 <intr_eoi+0x28>
        lapic_eoi();
    else
        pic_eoi();
  10192a:	e8 f1 01 00 00       	call   101b20 <pic_eoi>
}
  10192f:	83 c4 08             	add    $0x8,%esp
  101932:	5b                   	pop    %ebx
  101933:	c3                   	ret    
  101934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        lapic_eoi();
  101938:	e8 13 0f 00 00       	call   102850 <lapic_eoi>
}
  10193d:	83 c4 08             	add    $0x8,%esp
  101940:	5b                   	pop    %ebx
  101941:	c3                   	ret    
  101942:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101950 <intr_local_enable>:

void intr_local_enable(void)
{
  101950:	53                   	push   %ebx
  101951:	e8 33 ea ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101956:	81 c3 aa 26 01 00    	add    $0x126aa,%ebx
  10195c:	83 ec 08             	sub    $0x8,%esp
    sti();
  10195f:	e8 dc 39 00 00       	call   105340 <sti>
}
  101964:	83 c4 08             	add    $0x8,%esp
  101967:	5b                   	pop    %ebx
  101968:	c3                   	ret    
  101969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101970 <intr_local_disable>:

void intr_local_disable(void)
{
  101970:	53                   	push   %ebx
  101971:	e8 13 ea ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101976:	81 c3 8a 26 01 00    	add    $0x1268a,%ebx
  10197c:	83 ec 08             	sub    $0x8,%esp
    cli();
  10197f:	e8 ac 39 00 00       	call   105330 <cli>
}
  101984:	83 c4 08             	add    $0x8,%esp
  101987:	5b                   	pop    %ebx
  101988:	c3                   	ret    
  101989:	66 90                	xchg   %ax,%ax
  10198b:	66 90                	xchg   %ax,%ax
  10198d:	66 90                	xchg   %ax,%ax
  10198f:	90                   	nop

00101990 <pic_init>:
static uint16_t irqmask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool pic_inited = FALSE;

/* Initialize the 8259A interrupt controllers. */
void pic_init(void)
{
  101990:	53                   	push   %ebx
  101991:	e8 f3 e9 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101996:	81 c3 6a 26 01 00    	add    $0x1266a,%ebx
  10199c:	83 ec 08             	sub    $0x8,%esp
    if (pic_inited == TRUE)  // only do once on bootstrap CPU
  10199f:	80 bb 81 b8 03 00 01 	cmpb   $0x1,0x3b881(%ebx)
  1019a6:	0f 84 df 00 00 00    	je     101a8b <pic_init+0xfb>
        return;
    pic_inited = TRUE;

    /* mask all interrupts */
    outb(IO_PIC1 + 1, 0xff);
  1019ac:	83 ec 08             	sub    $0x8,%esp
    pic_inited = TRUE;
  1019af:	c6 83 81 b8 03 00 01 	movb   $0x1,0x3b881(%ebx)
    outb(IO_PIC1 + 1, 0xff);
  1019b6:	68 ff 00 00 00       	push   $0xff
  1019bb:	6a 21                	push   $0x21
  1019bd:	e8 8e 3b 00 00       	call   105550 <outb>
    outb(IO_PIC2 + 1, 0xff);
  1019c2:	58                   	pop    %eax
  1019c3:	5a                   	pop    %edx
  1019c4:	68 ff 00 00 00       	push   $0xff
  1019c9:	68 a1 00 00 00       	push   $0xa1
  1019ce:	e8 7d 3b 00 00       	call   105550 <outb>

    // ICW1:  0001g0hi
    //    g:  0 = edge triggering, 1 = level triggering
    //    h:  0 = cascaded PICs, 1 = master only
    //    i:  0 = no ICW4, 1 = ICW4 required
    outb(IO_PIC1, 0x11);
  1019d3:	59                   	pop    %ecx
  1019d4:	58                   	pop    %eax
  1019d5:	6a 11                	push   $0x11
  1019d7:	6a 20                	push   $0x20
  1019d9:	e8 72 3b 00 00       	call   105550 <outb>

    // ICW2:  Vector offset
    outb(IO_PIC1 + 1, T_IRQ0);
  1019de:	58                   	pop    %eax
  1019df:	5a                   	pop    %edx
  1019e0:	6a 20                	push   $0x20
  1019e2:	6a 21                	push   $0x21
  1019e4:	e8 67 3b 00 00       	call   105550 <outb>

    // ICW3:  bit mask of IR lines connected to slave PICs (master PIC),
    //        3-bit No of IR line at which slave connects to master (slave PIC).
    outb(IO_PIC1 + 1, 1 << IRQ_SLAVE);
  1019e9:	59                   	pop    %ecx
  1019ea:	58                   	pop    %eax
  1019eb:	6a 04                	push   $0x4
  1019ed:	6a 21                	push   $0x21
  1019ef:	e8 5c 3b 00 00       	call   105550 <outb>
    //    m:  0 = slave PIC, 1 = master PIC
    //        (ignored when b is 0, as the master/slave role
    //        can be hardwired).
    //    a:  1 = Automatic EOI mode
    //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
    outb(IO_PIC1 + 1, 0x1);
  1019f4:	58                   	pop    %eax
  1019f5:	5a                   	pop    %edx
  1019f6:	6a 01                	push   $0x1
  1019f8:	6a 21                	push   $0x21
  1019fa:	e8 51 3b 00 00       	call   105550 <outb>

    // Set up slave (8259A-2)
    outb(IO_PIC2, 0x11);            // ICW1
  1019ff:	59                   	pop    %ecx
  101a00:	58                   	pop    %eax
  101a01:	6a 11                	push   $0x11
  101a03:	68 a0 00 00 00       	push   $0xa0
  101a08:	e8 43 3b 00 00       	call   105550 <outb>
    outb(IO_PIC2 + 1, T_IRQ0 + 8);  // ICW2
  101a0d:	58                   	pop    %eax
  101a0e:	5a                   	pop    %edx
  101a0f:	6a 28                	push   $0x28
  101a11:	68 a1 00 00 00       	push   $0xa1
  101a16:	e8 35 3b 00 00       	call   105550 <outb>
    outb(IO_PIC2 + 1, IRQ_SLAVE);   // ICW3
  101a1b:	59                   	pop    %ecx
  101a1c:	58                   	pop    %eax
  101a1d:	6a 02                	push   $0x2
  101a1f:	68 a1 00 00 00       	push   $0xa1
  101a24:	e8 27 3b 00 00       	call   105550 <outb>
    // NB Automatic EOI mode doesn't tend to work on the slave.
    // Linux source code says it's "to be investigated".
    outb(IO_PIC2 + 1, 0x01);        // ICW4
  101a29:	58                   	pop    %eax
  101a2a:	5a                   	pop    %edx
  101a2b:	6a 01                	push   $0x1
  101a2d:	68 a1 00 00 00       	push   $0xa1
  101a32:	e8 19 3b 00 00       	call   105550 <outb>

    // OCW3:  0ef01prs
    //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
    //    p:  0 = no polling, 1 = polling mode
    //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
    outb(IO_PIC1, 0x68);  /* clear specific mask */
  101a37:	59                   	pop    %ecx
  101a38:	58                   	pop    %eax
  101a39:	6a 68                	push   $0x68
  101a3b:	6a 20                	push   $0x20
  101a3d:	e8 0e 3b 00 00       	call   105550 <outb>
    outb(IO_PIC1, 0x0a);  /* read IRR by default */
  101a42:	58                   	pop    %eax
  101a43:	5a                   	pop    %edx
  101a44:	6a 0a                	push   $0xa
  101a46:	6a 20                	push   $0x20
  101a48:	e8 03 3b 00 00       	call   105550 <outb>

    outb(IO_PIC2, 0x68);  /* OCW3 */
  101a4d:	59                   	pop    %ecx
  101a4e:	58                   	pop    %eax
  101a4f:	6a 68                	push   $0x68
  101a51:	68 a0 00 00 00       	push   $0xa0
  101a56:	e8 f5 3a 00 00       	call   105550 <outb>
    outb(IO_PIC2, 0x0a);  /* OCW3 */
  101a5b:	58                   	pop    %eax
  101a5c:	5a                   	pop    %edx
  101a5d:	6a 0a                	push   $0xa
  101a5f:	68 a0 00 00 00       	push   $0xa0
  101a64:	e8 e7 3a 00 00       	call   105550 <outb>

    // mask all interrupts
    outb(IO_PIC1 + 1, 0xFF);
  101a69:	59                   	pop    %ecx
  101a6a:	58                   	pop    %eax
  101a6b:	68 ff 00 00 00       	push   $0xff
  101a70:	6a 21                	push   $0x21
  101a72:	e8 d9 3a 00 00       	call   105550 <outb>
    outb(IO_PIC2 + 1, 0xFF);
  101a77:	58                   	pop    %eax
  101a78:	5a                   	pop    %edx
  101a79:	68 ff 00 00 00       	push   $0xff
  101a7e:	68 a1 00 00 00       	push   $0xa1
  101a83:	e8 c8 3a 00 00       	call   105550 <outb>
  101a88:	83 c4 10             	add    $0x10,%esp
}
  101a8b:	83 c4 08             	add    $0x8,%esp
  101a8e:	5b                   	pop    %ebx
  101a8f:	c3                   	ret    

00101a90 <pic_setmask>:

void pic_setmask(uint16_t mask)
{
  101a90:	56                   	push   %esi
  101a91:	53                   	push   %ebx
  101a92:	e8 f2 e8 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101a97:	81 c3 69 25 01 00    	add    $0x12569,%ebx
  101a9d:	83 ec 0c             	sub    $0xc,%esp
  101aa0:	8b 74 24 18          	mov    0x18(%esp),%esi
    irqmask = mask;
    outb(IO_PIC1 + 1, (char) mask);
  101aa4:	89 f0                	mov    %esi,%eax
  101aa6:	0f b6 c0             	movzbl %al,%eax
    irqmask = mask;
  101aa9:	66 89 b3 26 03 00 00 	mov    %si,0x326(%ebx)
    outb(IO_PIC1 + 1, (char) mask);
  101ab0:	50                   	push   %eax
  101ab1:	6a 21                	push   $0x21
  101ab3:	e8 98 3a 00 00       	call   105550 <outb>
    outb(IO_PIC2 + 1, (char) (mask >> 8));
  101ab8:	58                   	pop    %eax
  101ab9:	89 f0                	mov    %esi,%eax
  101abb:	5a                   	pop    %edx
  101abc:	0f b6 f4             	movzbl %ah,%esi
  101abf:	56                   	push   %esi
  101ac0:	68 a1 00 00 00       	push   $0xa1
  101ac5:	e8 86 3a 00 00       	call   105550 <outb>
}
  101aca:	83 c4 14             	add    $0x14,%esp
  101acd:	5b                   	pop    %ebx
  101ace:	5e                   	pop    %esi
  101acf:	c3                   	ret    

00101ad0 <pic_enable>:

void pic_enable(int irq)
{
  101ad0:	56                   	push   %esi
  101ad1:	53                   	push   %ebx
  101ad2:	e8 b2 e8 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101ad7:	81 c3 29 25 01 00    	add    $0x12529,%ebx
  101add:	83 ec 0c             	sub    $0xc,%esp
    pic_setmask(irqmask & ~(1 << irq));
  101ae0:	8b 44 24 18          	mov    0x18(%esp),%eax
  101ae4:	0f b7 b3 26 03 00 00 	movzwl 0x326(%ebx),%esi
  101aeb:	0f b3 c6             	btr    %eax,%esi
    outb(IO_PIC1 + 1, (char) mask);
  101aee:	89 f0                	mov    %esi,%eax
    irqmask = mask;
  101af0:	66 89 b3 26 03 00 00 	mov    %si,0x326(%ebx)
    outb(IO_PIC2 + 1, (char) (mask >> 8));
  101af7:	66 c1 ee 08          	shr    $0x8,%si
    outb(IO_PIC1 + 1, (char) mask);
  101afb:	0f b6 c0             	movzbl %al,%eax
    outb(IO_PIC2 + 1, (char) (mask >> 8));
  101afe:	0f b7 f6             	movzwl %si,%esi
    outb(IO_PIC1 + 1, (char) mask);
  101b01:	50                   	push   %eax
  101b02:	6a 21                	push   $0x21
  101b04:	e8 47 3a 00 00       	call   105550 <outb>
    outb(IO_PIC2 + 1, (char) (mask >> 8));
  101b09:	58                   	pop    %eax
  101b0a:	5a                   	pop    %edx
  101b0b:	56                   	push   %esi
  101b0c:	68 a1 00 00 00       	push   $0xa1
  101b11:	e8 3a 3a 00 00       	call   105550 <outb>
}
  101b16:	83 c4 14             	add    $0x14,%esp
  101b19:	5b                   	pop    %ebx
  101b1a:	5e                   	pop    %esi
  101b1b:	c3                   	ret    
  101b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101b20 <pic_eoi>:

void pic_eoi(void)
{
  101b20:	53                   	push   %ebx
  101b21:	e8 63 e8 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101b26:	81 c3 da 24 01 00    	add    $0x124da,%ebx
  101b2c:	83 ec 10             	sub    $0x10,%esp
    // OCW2: rse00xxx
    //   r: rotate
    //   s: specific
    //   e: end-of-interrupt
    // xxx: specific interrupt line
    outb(IO_PIC1, 0x20);
  101b2f:	6a 20                	push   $0x20
  101b31:	6a 20                	push   $0x20
  101b33:	e8 18 3a 00 00       	call   105550 <outb>
    outb(IO_PIC2, 0x20);
  101b38:	58                   	pop    %eax
  101b39:	5a                   	pop    %edx
  101b3a:	6a 20                	push   $0x20
  101b3c:	68 a0 00 00 00       	push   $0xa0
  101b41:	e8 0a 3a 00 00       	call   105550 <outb>
}
  101b46:	83 c4 18             	add    $0x18,%esp
  101b49:	5b                   	pop    %ebx
  101b4a:	c3                   	ret    
  101b4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101b4f:	90                   	nop

00101b50 <pic_reset>:

void pic_reset(void)
{
  101b50:	53                   	push   %ebx
  101b51:	e8 33 e8 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101b56:	81 c3 aa 24 01 00    	add    $0x124aa,%ebx
  101b5c:	83 ec 10             	sub    $0x10,%esp
    // mask all interrupts
    outb(IO_PIC1 + 1, 0x00);
  101b5f:	6a 00                	push   $0x0
  101b61:	6a 21                	push   $0x21
  101b63:	e8 e8 39 00 00       	call   105550 <outb>
    outb(IO_PIC2 + 1, 0x00);
  101b68:	58                   	pop    %eax
  101b69:	5a                   	pop    %edx
  101b6a:	6a 00                	push   $0x0
  101b6c:	68 a1 00 00 00       	push   $0xa1
  101b71:	e8 da 39 00 00       	call   105550 <outb>

    // ICW1:  0001g0hi
    //    g:  0 = edge triggering, 1 = level triggering
    //    h:  0 = cascaded PICs, 1 = master only
    //    i:  0 = no ICW4, 1 = ICW4 required
    outb(IO_PIC1, 0x11);
  101b76:	59                   	pop    %ecx
  101b77:	58                   	pop    %eax
  101b78:	6a 11                	push   $0x11
  101b7a:	6a 20                	push   $0x20
  101b7c:	e8 cf 39 00 00       	call   105550 <outb>

    // ICW2:  Vector offset
    outb(IO_PIC1 + 1, T_IRQ0);
  101b81:	58                   	pop    %eax
  101b82:	5a                   	pop    %edx
  101b83:	6a 20                	push   $0x20
  101b85:	6a 21                	push   $0x21
  101b87:	e8 c4 39 00 00       	call   105550 <outb>

    // ICW3:  bit mask of IR lines connected to slave PICs (master PIC),
    //        3-bit No of IR line at which slave connects to master(slave PIC).
    outb(IO_PIC1 + 1, 1 << IRQ_SLAVE);
  101b8c:	59                   	pop    %ecx
  101b8d:	58                   	pop    %eax
  101b8e:	6a 04                	push   $0x4
  101b90:	6a 21                	push   $0x21
  101b92:	e8 b9 39 00 00       	call   105550 <outb>
    //    m:  0 = slave PIC, 1 = master PIC
    //        (ignored when b is 0, as the master/slave role
    //        can be hardwired).
    //    a:  1 = Automatic EOI mode
    //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
    outb(IO_PIC1 + 1, 0x3);
  101b97:	58                   	pop    %eax
  101b98:	5a                   	pop    %edx
  101b99:	6a 03                	push   $0x3
  101b9b:	6a 21                	push   $0x21
  101b9d:	e8 ae 39 00 00       	call   105550 <outb>

    // Set up slave (8259A-2)
    outb(IO_PIC2, 0x11);            // ICW1
  101ba2:	59                   	pop    %ecx
  101ba3:	58                   	pop    %eax
  101ba4:	6a 11                	push   $0x11
  101ba6:	68 a0 00 00 00       	push   $0xa0
  101bab:	e8 a0 39 00 00       	call   105550 <outb>
    outb(IO_PIC2 + 1, T_IRQ0 + 8);  // ICW2
  101bb0:	58                   	pop    %eax
  101bb1:	5a                   	pop    %edx
  101bb2:	6a 28                	push   $0x28
  101bb4:	68 a1 00 00 00       	push   $0xa1
  101bb9:	e8 92 39 00 00       	call   105550 <outb>
    outb(IO_PIC2 + 1, IRQ_SLAVE);   // ICW3
  101bbe:	59                   	pop    %ecx
  101bbf:	58                   	pop    %eax
  101bc0:	6a 02                	push   $0x2
  101bc2:	68 a1 00 00 00       	push   $0xa1
  101bc7:	e8 84 39 00 00       	call   105550 <outb>
    // NB Automatic EOI mode doesn't tend to work on the slave.
    // Linux source code says it's "to be investigated".
    outb(IO_PIC2 + 1, 0x01);        // ICW4
  101bcc:	58                   	pop    %eax
  101bcd:	5a                   	pop    %edx
  101bce:	6a 01                	push   $0x1
  101bd0:	68 a1 00 00 00       	push   $0xa1
  101bd5:	e8 76 39 00 00       	call   105550 <outb>

    // OCW3:  0ef01prs
    //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
    //    p:  0 = no polling, 1 = polling mode
    //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
    outb(IO_PIC1, 0x68);  /* clear specific mask */
  101bda:	59                   	pop    %ecx
  101bdb:	58                   	pop    %eax
  101bdc:	6a 68                	push   $0x68
  101bde:	6a 20                	push   $0x20
  101be0:	e8 6b 39 00 00       	call   105550 <outb>
    outb(IO_PIC1, 0x0a);  /* read IRR by default */
  101be5:	58                   	pop    %eax
  101be6:	5a                   	pop    %edx
  101be7:	6a 0a                	push   $0xa
  101be9:	6a 20                	push   $0x20
  101beb:	e8 60 39 00 00       	call   105550 <outb>

    outb(IO_PIC2, 0x68);  /* OCW3 */
  101bf0:	59                   	pop    %ecx
  101bf1:	58                   	pop    %eax
  101bf2:	6a 68                	push   $0x68
  101bf4:	68 a0 00 00 00       	push   $0xa0
  101bf9:	e8 52 39 00 00       	call   105550 <outb>
    outb(IO_PIC2, 0x0a);  /* OCW3 */
  101bfe:	58                   	pop    %eax
  101bff:	5a                   	pop    %edx
  101c00:	6a 0a                	push   $0xa
  101c02:	68 a0 00 00 00       	push   $0xa0
  101c07:	e8 44 39 00 00       	call   105550 <outb>
}
  101c0c:	83 c4 18             	add    $0x18,%esp
  101c0f:	5b                   	pop    %ebx
  101c10:	c3                   	ret    
  101c11:	66 90                	xchg   %ax,%ax
  101c13:	66 90                	xchg   %ax,%ax
  101c15:	66 90                	xchg   %ax,%ax
  101c17:	66 90                	xchg   %ax,%ax
  101c19:	66 90                	xchg   %ax,%ax
  101c1b:	66 90                	xchg   %ax,%ax
  101c1d:	66 90                	xchg   %ax,%ax
  101c1f:	90                   	nop

00101c20 <timer_hw_init>:
#define TIMER_16BIT   0x30  /* r/w counter 16 bits, LSB first */

// Initialize the programmable interval timer.

void timer_hw_init(void)
{
  101c20:	53                   	push   %ebx
  101c21:	e8 63 e7 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101c26:	81 c3 da 23 01 00    	add    $0x123da,%ebx
  101c2c:	83 ec 10             	sub    $0x10,%esp
    outb(PIT_CONTROL, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  101c2f:	6a 34                	push   $0x34
  101c31:	6a 43                	push   $0x43
  101c33:	e8 18 39 00 00       	call   105550 <outb>
    outb(PIT_CHANNEL0, LOW8(LATCH));
  101c38:	58                   	pop    %eax
  101c39:	5a                   	pop    %edx
  101c3a:	68 9c 00 00 00       	push   $0x9c
  101c3f:	6a 40                	push   $0x40
  101c41:	e8 0a 39 00 00       	call   105550 <outb>
    outb(PIT_CHANNEL0, HIGH8(LATCH));
  101c46:	59                   	pop    %ecx
  101c47:	58                   	pop    %eax
  101c48:	6a 2e                	push   $0x2e
  101c4a:	6a 40                	push   $0x40
  101c4c:	e8 ff 38 00 00       	call   105550 <outb>
}
  101c51:	83 c4 18             	add    $0x18,%esp
  101c54:	5b                   	pop    %ebx
  101c55:	c3                   	ret    
  101c56:	66 90                	xchg   %ax,%ax
  101c58:	66 90                	xchg   %ax,%ax
  101c5a:	66 90                	xchg   %ax,%ax
  101c5c:	66 90                	xchg   %ax,%ax
  101c5e:	66 90                	xchg   %ax,%ax

00101c60 <tsc_init>:
    delta = t2 - t1;
    return delta / ms;
}

int tsc_init(void)
{
  101c60:	55                   	push   %ebp
  101c61:	57                   	push   %edi
  101c62:	56                   	push   %esi
  101c63:	53                   	push   %ebx
  101c64:	e8 20 e7 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101c69:	81 c3 97 23 01 00    	add    $0x12397,%ebx
  101c6f:	83 ec 4c             	sub    $0x4c,%esp
    uint64_t ret;
    int i;

    timer_hw_init();
  101c72:	e8 a9 ff ff ff       	call   101c20 <timer_hw_init>

    tsc_per_ms = 0;
  101c77:	c7 83 88 b8 03 00 00 	movl   $0x0,0x3b888(%ebx)
  101c7e:	00 00 00 
  101c81:	c7 83 8c b8 03 00 00 	movl   $0x0,0x3b88c(%ebx)
  101c88:	00 00 00 

    if (detect_kvm())
  101c8b:	e8 a0 24 00 00       	call   104130 <detect_kvm>
  101c90:	89 44 24 3c          	mov    %eax,0x3c(%esp)
  101c94:	85 c0                	test   %eax,%eax
  101c96:	0f 85 c1 02 00 00    	jne    101f5d <tsc_init+0x2fd>
  101c9c:	8d 83 b8 74 ff ff    	lea    -0x8b48(%ebx),%eax

    /*
     * XXX: If TSC calibration fails frequently, try to increase the
     *      upper bound of loop condition, e.g. alternating 3 to 10.
     */
    for (i = 0; i < 10; i++) {
  101ca2:	c7 44 24 24 00 00 00 	movl   $0x0,0x24(%esp)
  101ca9:	00 
  101caa:	89 44 24 34          	mov    %eax,0x34(%esp)
  101cae:	8d 83 dd 74 ff ff    	lea    -0x8b23(%ebx),%eax
  101cb4:	89 44 24 30          	mov    %eax,0x30(%esp)
        ret = tsc_calibrate(CAL_LATCH, CAL_MS, CAL_PIT_LOOPS);
        if (ret != ~(uint64_t) 0x0)
            break;
        KERN_DEBUG("[%d] Retry to calibrate TSC.\n", i + 1);
  101cb8:	8d 83 05 75 ff ff    	lea    -0x8afb(%ebx),%eax
  101cbe:	89 44 24 38          	mov    %eax,0x38(%esp)
  101cc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    outb(0x61, (inb(0x61) & ~0x02) | 0x01);
  101cc8:	83 ec 0c             	sub    $0xc,%esp
  101ccb:	6a 61                	push   $0x61
  101ccd:	e8 4e 38 00 00       	call   105520 <inb>
  101cd2:	5e                   	pop    %esi
  101cd3:	5f                   	pop    %edi
  101cd4:	25 fc 00 00 00       	and    $0xfc,%eax
  101cd9:	83 c8 01             	or     $0x1,%eax
  101cdc:	50                   	push   %eax
  101cdd:	6a 61                	push   $0x61
  101cdf:	e8 6c 38 00 00       	call   105550 <outb>
    outb(0x43, 0xb0);
  101ce4:	5d                   	pop    %ebp
  101ce5:	58                   	pop    %eax
  101ce6:	68 b0 00 00 00       	push   $0xb0
  101ceb:	6a 43                	push   $0x43
    pitcnt = 0;
  101ced:	31 ed                	xor    %ebp,%ebp
    outb(0x43, 0xb0);
  101cef:	e8 5c 38 00 00       	call   105550 <outb>
    outb(0x42, latch & 0xff);
  101cf4:	58                   	pop    %eax
  101cf5:	5a                   	pop    %edx
  101cf6:	68 9b 00 00 00       	push   $0x9b
  101cfb:	6a 42                	push   $0x42
  101cfd:	e8 4e 38 00 00       	call   105550 <outb>
    outb(0x42, latch >> 8);
  101d02:	59                   	pop    %ecx
  101d03:	5e                   	pop    %esi
  101d04:	6a 2e                	push   $0x2e
  101d06:	6a 42                	push   $0x42
  101d08:	e8 43 38 00 00       	call   105550 <outb>
    tsc = t1 = t2 = rdtsc();
  101d0d:	e8 ae 36 00 00       	call   1053c0 <rdtsc>
  101d12:	89 44 24 38          	mov    %eax,0x38(%esp)
  101d16:	89 54 24 3c          	mov    %edx,0x3c(%esp)
    while ((inb(0x61) & 0x20) == 0) {
  101d1a:	83 c4 10             	add    $0x10,%esp
    tsc = t1 = t2 = rdtsc();
  101d1d:	89 44 24 18          	mov    %eax,0x18(%esp)
  101d21:	89 54 24 1c          	mov    %edx,0x1c(%esp)
    tscmax = 0;
  101d25:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  101d2c:	00 
  101d2d:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  101d34:	00 
    tscmin = ~(uint64_t) 0x0;
  101d35:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
  101d3c:	ff 
  101d3d:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  101d44:	ff 
    while ((inb(0x61) & 0x20) == 0) {
  101d45:	eb 63                	jmp    101daa <tsc_init+0x14a>
  101d47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101d4e:	66 90                	xchg   %ax,%ax
        t2 = rdtsc();
  101d50:	e8 6b 36 00 00       	call   1053c0 <rdtsc>
        delta = t2 - tsc;
  101d55:	89 c6                	mov    %eax,%esi
  101d57:	89 d7                	mov    %edx,%edi
  101d59:	2b 74 24 18          	sub    0x18(%esp),%esi
  101d5d:	1b 7c 24 1c          	sbb    0x1c(%esp),%edi
        if (delta < tscmin)
  101d61:	89 f9                	mov    %edi,%ecx
  101d63:	3b 74 24 08          	cmp    0x8(%esp),%esi
  101d67:	1b 4c 24 0c          	sbb    0xc(%esp),%ecx
        tsc = t2;
  101d6b:	89 44 24 18          	mov    %eax,0x18(%esp)
  101d6f:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  101d73:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  101d77:	0f 42 ce             	cmovb  %esi,%ecx
  101d7a:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  101d7e:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  101d82:	0f 42 cf             	cmovb  %edi,%ecx
  101d85:	39 74 24 10          	cmp    %esi,0x10(%esp)
  101d89:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
        if (delta > tscmax)
  101d8d:	8b 4c 24 14          	mov    0x14(%esp),%ecx
  101d91:	19 f9                	sbb    %edi,%ecx
  101d93:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  101d97:	0f 43 7c 24 14       	cmovae 0x14(%esp),%edi
  101d9c:	0f 42 ce             	cmovb  %esi,%ecx
  101d9f:	89 7c 24 14          	mov    %edi,0x14(%esp)
        pitcnt++;
  101da3:	83 c5 01             	add    $0x1,%ebp
  101da6:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    while ((inb(0x61) & 0x20) == 0) {
  101daa:	83 ec 0c             	sub    $0xc,%esp
  101dad:	6a 61                	push   $0x61
  101daf:	e8 6c 37 00 00       	call   105520 <inb>
  101db4:	83 c4 10             	add    $0x10,%esp
  101db7:	a8 20                	test   $0x20,%al
  101db9:	74 95                	je     101d50 <tsc_init+0xf0>
    KERN_DEBUG("pitcnt=%u, tscmin=%llu, tscmax=%llu\n",
  101dbb:	8b 74 24 10          	mov    0x10(%esp),%esi
  101dbf:	8b 7c 24 14          	mov    0x14(%esp),%edi
  101dc3:	57                   	push   %edi
  101dc4:	56                   	push   %esi
  101dc5:	ff 74 24 14          	push   0x14(%esp)
  101dc9:	ff 74 24 14          	push   0x14(%esp)
  101dcd:	55                   	push   %ebp
  101dce:	ff 74 24 48          	push   0x48(%esp)
  101dd2:	6a 39                	push   $0x39
  101dd4:	ff 74 24 4c          	push   0x4c(%esp)
  101dd8:	e8 d3 28 00 00       	call   1046b0 <debug_normal>
    if (pitcnt < loopmin || tscmax > 10 * tscmin)
  101ddd:	83 c4 20             	add    $0x20,%esp
  101de0:	81 fd e7 03 00 00    	cmp    $0x3e7,%ebp
  101de6:	0f 8e f4 00 00 00    	jle    101ee0 <tsc_init+0x280>
  101dec:	6b 4c 24 0c 0a       	imul   $0xa,0xc(%esp),%ecx
  101df1:	b8 0a 00 00 00       	mov    $0xa,%eax
  101df6:	f7 64 24 08          	mull   0x8(%esp)
  101dfa:	01 ca                	add    %ecx,%edx
  101dfc:	39 f0                	cmp    %esi,%eax
  101dfe:	89 d0                	mov    %edx,%eax
  101e00:	19 f8                	sbb    %edi,%eax
  101e02:	0f 82 d8 00 00 00    	jb     101ee0 <tsc_init+0x280>
    delta = t2 - t1;
  101e08:	8b 44 24 18          	mov    0x18(%esp),%eax
  101e0c:	8b 54 24 1c          	mov    0x1c(%esp),%edx
    return delta / ms;
  101e10:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    delta = t2 - t1;
  101e15:	2b 44 24 28          	sub    0x28(%esp),%eax
  101e19:	1b 54 24 2c          	sbb    0x2c(%esp),%edx
    return delta / ms;
  101e1d:	89 54 24 0c          	mov    %edx,0xc(%esp)
  101e21:	89 c6                	mov    %eax,%esi
  101e23:	03 74 24 0c          	add    0xc(%esp),%esi
  101e27:	83 d6 00             	adc    $0x0,%esi
  101e2a:	89 44 24 08          	mov    %eax,0x8(%esp)
  101e2e:	89 f0                	mov    %esi,%eax
  101e30:	f7 e1                	mul    %ecx
  101e32:	8b 44 24 08          	mov    0x8(%esp),%eax
  101e36:	89 d7                	mov    %edx,%edi
  101e38:	83 e2 fc             	and    $0xfffffffc,%edx
  101e3b:	c1 ef 02             	shr    $0x2,%edi
  101e3e:	01 fa                	add    %edi,%edx
  101e40:	31 ff                	xor    %edi,%edi
  101e42:	29 d6                	sub    %edx,%esi
  101e44:	8b 54 24 0c          	mov    0xc(%esp),%edx
  101e48:	29 f0                	sub    %esi,%eax
  101e4a:	19 fa                	sbb    %edi,%edx

        timer_hw_init();
        return 1;
    } else {
        tsc_per_ms = ret;
        KERN_DEBUG("TSC freq = %u.%03u MHz.\n",tsc_per_ms / 1000, tsc_per_ms % 1000);
  101e4c:	83 ec 10             	sub    $0x10,%esp
    return delta / ms;
  101e4f:	69 f2 cd cc cc cc    	imul   $0xcccccccd,%edx,%esi
        KERN_DEBUG("TSC freq = %u.%03u MHz.\n",tsc_per_ms / 1000, tsc_per_ms % 1000);
  101e55:	6a 00                	push   $0x0
    return delta / ms;
  101e57:	69 d0 cc cc cc cc    	imul   $0xcccccccc,%eax,%edx
        KERN_DEBUG("TSC freq = %u.%03u MHz.\n",tsc_per_ms / 1000, tsc_per_ms % 1000);
  101e5d:	68 e8 03 00 00       	push   $0x3e8
    return delta / ms;
  101e62:	01 d6                	add    %edx,%esi
  101e64:	f7 e1                	mul    %ecx
  101e66:	01 f2                	add    %esi,%edx
  101e68:	0f ac d0 01          	shrd   $0x1,%edx,%eax
  101e6c:	d1 ea                	shr    %edx
        tsc_per_ms = ret;
  101e6e:	89 83 88 b8 03 00    	mov    %eax,0x3b888(%ebx)
  101e74:	89 93 8c b8 03 00    	mov    %edx,0x3b88c(%ebx)
        KERN_DEBUG("TSC freq = %u.%03u MHz.\n",tsc_per_ms / 1000, tsc_per_ms % 1000);
  101e7a:	8b 83 88 b8 03 00    	mov    0x3b888(%ebx),%eax
  101e80:	8b 93 8c b8 03 00    	mov    0x3b88c(%ebx),%edx
  101e86:	8b b3 88 b8 03 00    	mov    0x3b888(%ebx),%esi
  101e8c:	8b bb 8c b8 03 00    	mov    0x3b88c(%ebx),%edi
  101e92:	52                   	push   %edx
  101e93:	50                   	push   %eax
  101e94:	e8 67 8e 00 00       	call   10ad00 <__umoddi3>
  101e99:	83 c4 1c             	add    $0x1c,%esp
  101e9c:	52                   	push   %edx
  101e9d:	50                   	push   %eax
  101e9e:	83 ec 04             	sub    $0x4,%esp
  101ea1:	6a 00                	push   $0x0
  101ea3:	68 e8 03 00 00       	push   $0x3e8
  101ea8:	57                   	push   %edi
  101ea9:	56                   	push   %esi
  101eaa:	e8 31 8d 00 00       	call   10abe0 <__udivdi3>
  101eaf:	83 c4 14             	add    $0x14,%esp
  101eb2:	52                   	push   %edx
  101eb3:	50                   	push   %eax
  101eb4:	8d 83 ec 74 ff ff    	lea    -0x8b14(%ebx),%eax
  101eba:	50                   	push   %eax
  101ebb:	6a 68                	push   $0x68
  101ebd:	ff 74 24 4c          	push   0x4c(%esp)
  101ec1:	e8 ea 27 00 00       	call   1046b0 <debug_normal>

        timer_hw_init();
  101ec6:	83 c4 20             	add    $0x20,%esp
  101ec9:	e8 52 fd ff ff       	call   101c20 <timer_hw_init>
        return 0;
    }
}
  101ece:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  101ed2:	83 c4 4c             	add    $0x4c,%esp
  101ed5:	5b                   	pop    %ebx
  101ed6:	5e                   	pop    %esi
  101ed7:	5f                   	pop    %edi
  101ed8:	5d                   	pop    %ebp
  101ed9:	c3                   	ret    
  101eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        KERN_DEBUG("[%d] Retry to calibrate TSC.\n", i + 1);
  101ee0:	83 44 24 24 01       	addl   $0x1,0x24(%esp)
  101ee5:	8b 7c 24 24          	mov    0x24(%esp),%edi
  101ee9:	57                   	push   %edi
  101eea:	ff 74 24 3c          	push   0x3c(%esp)
  101eee:	6a 5c                	push   $0x5c
  101ef0:	ff 74 24 3c          	push   0x3c(%esp)
  101ef4:	e8 b7 27 00 00       	call   1046b0 <debug_normal>
    for (i = 0; i < 10; i++) {
  101ef9:	83 c4 10             	add    $0x10,%esp
  101efc:	83 ff 0a             	cmp    $0xa,%edi
  101eff:	0f 85 c3 fd ff ff    	jne    101cc8 <tsc_init+0x68>
        KERN_DEBUG("TSC calibration failed.\n");
  101f05:	83 ec 04             	sub    $0x4,%esp
  101f08:	8d 83 23 75 ff ff    	lea    -0x8add(%ebx),%eax
  101f0e:	50                   	push   %eax
  101f0f:	6a 60                	push   $0x60
  101f11:	8b 7c 24 3c          	mov    0x3c(%esp),%edi
  101f15:	57                   	push   %edi
  101f16:	e8 95 27 00 00       	call   1046b0 <debug_normal>
        KERN_DEBUG("Assume TSC freq = 1 GHz.\n");
  101f1b:	83 c4 0c             	add    $0xc,%esp
  101f1e:	8d 83 3c 75 ff ff    	lea    -0x8ac4(%ebx),%eax
  101f24:	50                   	push   %eax
  101f25:	6a 61                	push   $0x61
  101f27:	57                   	push   %edi
  101f28:	e8 83 27 00 00       	call   1046b0 <debug_normal>
        tsc_per_ms = 1000000;
  101f2d:	c7 83 88 b8 03 00 40 	movl   $0xf4240,0x3b888(%ebx)
  101f34:	42 0f 00 
  101f37:	c7 83 8c b8 03 00 00 	movl   $0x0,0x3b88c(%ebx)
  101f3e:	00 00 00 
        timer_hw_init();
  101f41:	e8 da fc ff ff       	call   101c20 <timer_hw_init>
        return 1;
  101f46:	83 c4 10             	add    $0x10,%esp
  101f49:	c7 44 24 3c 01 00 00 	movl   $0x1,0x3c(%esp)
  101f50:	00 
}
  101f51:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  101f55:	83 c4 4c             	add    $0x4c,%esp
  101f58:	5b                   	pop    %ebx
  101f59:	5e                   	pop    %esi
  101f5a:	5f                   	pop    %edi
  101f5b:	5d                   	pop    %ebp
  101f5c:	c3                   	ret    
		tsc_per_ms = kvm_get_tsc_hz() / 1000llu;
  101f5d:	e8 0e 23 00 00       	call   104270 <kvm_get_tsc_hz>
  101f62:	6a 00                	push   $0x0
  101f64:	68 e8 03 00 00       	push   $0x3e8
  101f69:	52                   	push   %edx
  101f6a:	50                   	push   %eax
  101f6b:	e8 70 8c 00 00       	call   10abe0 <__udivdi3>
		KERN_INFO ("TSC read from KVM: %u.%03u MHz.\n",
  101f70:	6a 00                	push   $0x0
		tsc_per_ms = kvm_get_tsc_hz() / 1000llu;
  101f72:	89 83 88 b8 03 00    	mov    %eax,0x3b888(%ebx)
  101f78:	89 93 8c b8 03 00    	mov    %edx,0x3b88c(%ebx)
		KERN_INFO ("TSC read from KVM: %u.%03u MHz.\n",
  101f7e:	8b 83 88 b8 03 00    	mov    0x3b888(%ebx),%eax
  101f84:	8b 93 8c b8 03 00    	mov    0x3b88c(%ebx),%edx
  101f8a:	68 e8 03 00 00       	push   $0x3e8
  101f8f:	8b b3 88 b8 03 00    	mov    0x3b888(%ebx),%esi
  101f95:	8b bb 8c b8 03 00    	mov    0x3b88c(%ebx),%edi
  101f9b:	52                   	push   %edx
  101f9c:	50                   	push   %eax
  101f9d:	e8 5e 8d 00 00       	call   10ad00 <__umoddi3>
  101fa2:	83 c4 14             	add    $0x14,%esp
  101fa5:	52                   	push   %edx
  101fa6:	50                   	push   %eax
  101fa7:	83 ec 0c             	sub    $0xc,%esp
  101faa:	6a 00                	push   $0x0
  101fac:	68 e8 03 00 00       	push   $0x3e8
  101fb1:	57                   	push   %edi
  101fb2:	56                   	push   %esi
  101fb3:	e8 28 8c 00 00       	call   10abe0 <__udivdi3>
  101fb8:	83 c4 1c             	add    $0x1c,%esp
  101fbb:	52                   	push   %edx
  101fbc:	50                   	push   %eax
  101fbd:	8d 83 94 74 ff ff    	lea    -0x8b6c(%ebx),%eax
  101fc3:	50                   	push   %eax
  101fc4:	e8 a7 26 00 00       	call   104670 <debug_info>
		return (0);
  101fc9:	83 c4 20             	add    $0x20,%esp
  101fcc:	c7 44 24 3c 00 00 00 	movl   $0x0,0x3c(%esp)
  101fd3:	00 
}
  101fd4:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  101fd8:	83 c4 4c             	add    $0x4c,%esp
  101fdb:	5b                   	pop    %ebx
  101fdc:	5e                   	pop    %esi
  101fdd:	5f                   	pop    %edi
  101fde:	5d                   	pop    %ebp
  101fdf:	c3                   	ret    

00101fe0 <delay>:

/*
 * Wait for ms millisecond.
 */
void delay(uint32_t ms)
{
  101fe0:	55                   	push   %ebp
  101fe1:	57                   	push   %edi
  101fe2:	56                   	push   %esi
  101fe3:	53                   	push   %ebx
  101fe4:	e8 a0 e3 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101fe9:	81 c3 17 20 01 00    	add    $0x12017,%ebx
  101fef:	83 ec 1c             	sub    $0x1c,%esp
  101ff2:	8b 44 24 30          	mov    0x30(%esp),%eax
    volatile uint64_t ticks = tsc_per_ms * ms;
  101ff6:	8b b3 88 b8 03 00    	mov    0x3b888(%ebx),%esi
  101ffc:	8b 8b 8c b8 03 00    	mov    0x3b88c(%ebx),%ecx
  102002:	0f af c8             	imul   %eax,%ecx
  102005:	f7 e6                	mul    %esi
  102007:	01 ca                	add    %ecx,%edx
  102009:	89 04 24             	mov    %eax,(%esp)
  10200c:	89 54 24 04          	mov    %edx,0x4(%esp)
    volatile uint64_t start = rdtsc();
  102010:	e8 ab 33 00 00       	call   1053c0 <rdtsc>
  102015:	89 44 24 08          	mov    %eax,0x8(%esp)
  102019:	89 54 24 0c          	mov    %edx,0xc(%esp)
    while (rdtsc() < start + ticks);
  10201d:	8d 76 00             	lea    0x0(%esi),%esi
  102020:	e8 9b 33 00 00       	call   1053c0 <rdtsc>
  102025:	89 c1                	mov    %eax,%ecx
  102027:	89 d5                	mov    %edx,%ebp
  102029:	8b 44 24 08          	mov    0x8(%esp),%eax
  10202d:	8b 54 24 0c          	mov    0xc(%esp),%edx
  102031:	8b 34 24             	mov    (%esp),%esi
  102034:	8b 7c 24 04          	mov    0x4(%esp),%edi
  102038:	01 f0                	add    %esi,%eax
  10203a:	11 fa                	adc    %edi,%edx
  10203c:	39 c1                	cmp    %eax,%ecx
  10203e:	19 d5                	sbb    %edx,%ebp
  102040:	72 de                	jb     102020 <delay+0x40>
}
  102042:	83 c4 1c             	add    $0x1c,%esp
  102045:	5b                   	pop    %ebx
  102046:	5e                   	pop    %esi
  102047:	5f                   	pop    %edi
  102048:	5d                   	pop    %ebp
  102049:	c3                   	ret    
  10204a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102050 <udelay>:

/*
 * Wait for us microsecond.
 */
void udelay(uint32_t us)
{
  102050:	55                   	push   %ebp
  102051:	57                   	push   %edi
  102052:	56                   	push   %esi
  102053:	53                   	push   %ebx
  102054:	e8 30 e3 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102059:	81 c3 a7 1f 01 00    	add    $0x11fa7,%ebx
  10205f:	83 ec 1c             	sub    $0x1c,%esp
  102062:	8b 74 24 30          	mov    0x30(%esp),%esi
    volatile uint64_t ticks = tsc_per_ms / 1000 * us;
  102066:	6a 00                	push   $0x0
  102068:	68 e8 03 00 00       	push   $0x3e8
  10206d:	8b 83 88 b8 03 00    	mov    0x3b888(%ebx),%eax
  102073:	8b 93 8c b8 03 00    	mov    0x3b88c(%ebx),%edx
  102079:	52                   	push   %edx
  10207a:	50                   	push   %eax
  10207b:	e8 60 8b 00 00       	call   10abe0 <__udivdi3>
  102080:	83 c4 10             	add    $0x10,%esp
  102083:	89 d1                	mov    %edx,%ecx
  102085:	f7 e6                	mul    %esi
  102087:	0f af ce             	imul   %esi,%ecx
  10208a:	89 04 24             	mov    %eax,(%esp)
  10208d:	01 ca                	add    %ecx,%edx
  10208f:	89 54 24 04          	mov    %edx,0x4(%esp)
    volatile uint64_t start = rdtsc();
  102093:	e8 28 33 00 00       	call   1053c0 <rdtsc>
  102098:	89 44 24 08          	mov    %eax,0x8(%esp)
  10209c:	89 54 24 0c          	mov    %edx,0xc(%esp)
    while (rdtsc() < start + ticks);
  1020a0:	e8 1b 33 00 00       	call   1053c0 <rdtsc>
  1020a5:	89 c1                	mov    %eax,%ecx
  1020a7:	89 d5                	mov    %edx,%ebp
  1020a9:	8b 44 24 08          	mov    0x8(%esp),%eax
  1020ad:	8b 54 24 0c          	mov    0xc(%esp),%edx
  1020b1:	8b 34 24             	mov    (%esp),%esi
  1020b4:	8b 7c 24 04          	mov    0x4(%esp),%edi
  1020b8:	01 f0                	add    %esi,%eax
  1020ba:	11 fa                	adc    %edi,%edx
  1020bc:	39 c1                	cmp    %eax,%ecx
  1020be:	19 d5                	sbb    %edx,%ebp
  1020c0:	72 de                	jb     1020a0 <udelay+0x50>
}
  1020c2:	83 c4 1c             	add    $0x1c,%esp
  1020c5:	5b                   	pop    %ebx
  1020c6:	5e                   	pop    %esi
  1020c7:	5f                   	pop    %edi
  1020c8:	5d                   	pop    %ebp
  1020c9:	c3                   	ret    
  1020ca:	66 90                	xchg   %ax,%ax
  1020cc:	66 90                	xchg   %ax,%ax
  1020ce:	66 90                	xchg   %ax,%ax

001020d0 <Xdivide>:
	jmp	_alltraps

.text

/* exceptions  */
TRAPHANDLER_NOEC(Xdivide,	T_DIVIDE)
  1020d0:	6a 00                	push   $0x0
  1020d2:	6a 00                	push   $0x0
  1020d4:	e9 17 01 00 00       	jmp    1021f0 <_alltraps>
  1020d9:	90                   	nop

001020da <Xdebug>:
TRAPHANDLER_NOEC(Xdebug,	T_DEBUG)
  1020da:	6a 00                	push   $0x0
  1020dc:	6a 01                	push   $0x1
  1020de:	e9 0d 01 00 00       	jmp    1021f0 <_alltraps>
  1020e3:	90                   	nop

001020e4 <Xnmi>:
TRAPHANDLER_NOEC(Xnmi,		T_NMI)
  1020e4:	6a 00                	push   $0x0
  1020e6:	6a 02                	push   $0x2
  1020e8:	e9 03 01 00 00       	jmp    1021f0 <_alltraps>
  1020ed:	90                   	nop

001020ee <Xbrkpt>:
TRAPHANDLER_NOEC(Xbrkpt,	T_BRKPT)
  1020ee:	6a 00                	push   $0x0
  1020f0:	6a 03                	push   $0x3
  1020f2:	e9 f9 00 00 00       	jmp    1021f0 <_alltraps>
  1020f7:	90                   	nop

001020f8 <Xoflow>:
TRAPHANDLER_NOEC(Xoflow,	T_OFLOW)
  1020f8:	6a 00                	push   $0x0
  1020fa:	6a 04                	push   $0x4
  1020fc:	e9 ef 00 00 00       	jmp    1021f0 <_alltraps>
  102101:	90                   	nop

00102102 <Xbound>:
TRAPHANDLER_NOEC(Xbound,	T_BOUND)
  102102:	6a 00                	push   $0x0
  102104:	6a 05                	push   $0x5
  102106:	e9 e5 00 00 00       	jmp    1021f0 <_alltraps>
  10210b:	90                   	nop

0010210c <Xillop>:
TRAPHANDLER_NOEC(Xillop,	T_ILLOP)
  10210c:	6a 00                	push   $0x0
  10210e:	6a 06                	push   $0x6
  102110:	e9 db 00 00 00       	jmp    1021f0 <_alltraps>
  102115:	90                   	nop

00102116 <Xdevice>:
TRAPHANDLER_NOEC(Xdevice,	T_DEVICE)
  102116:	6a 00                	push   $0x0
  102118:	6a 07                	push   $0x7
  10211a:	e9 d1 00 00 00       	jmp    1021f0 <_alltraps>
  10211f:	90                   	nop

00102120 <Xdblflt>:
TRAPHANDLER     (Xdblflt,	T_DBLFLT)
  102120:	6a 08                	push   $0x8
  102122:	e9 c9 00 00 00       	jmp    1021f0 <_alltraps>
  102127:	90                   	nop

00102128 <Xcoproc>:
TRAPHANDLER_NOEC(Xcoproc,	T_COPROC)
  102128:	6a 00                	push   $0x0
  10212a:	6a 09                	push   $0x9
  10212c:	e9 bf 00 00 00       	jmp    1021f0 <_alltraps>
  102131:	90                   	nop

00102132 <Xtss>:
TRAPHANDLER     (Xtss,		T_TSS)
  102132:	6a 0a                	push   $0xa
  102134:	e9 b7 00 00 00       	jmp    1021f0 <_alltraps>
  102139:	90                   	nop

0010213a <Xsegnp>:
TRAPHANDLER     (Xsegnp,	T_SEGNP)
  10213a:	6a 0b                	push   $0xb
  10213c:	e9 af 00 00 00       	jmp    1021f0 <_alltraps>
  102141:	90                   	nop

00102142 <Xstack>:
TRAPHANDLER     (Xstack,	T_STACK)
  102142:	6a 0c                	push   $0xc
  102144:	e9 a7 00 00 00       	jmp    1021f0 <_alltraps>
  102149:	90                   	nop

0010214a <Xgpflt>:
TRAPHANDLER     (Xgpflt,	T_GPFLT)
  10214a:	6a 0d                	push   $0xd
  10214c:	e9 9f 00 00 00       	jmp    1021f0 <_alltraps>
  102151:	90                   	nop

00102152 <Xpgflt>:
TRAPHANDLER     (Xpgflt,	T_PGFLT)
  102152:	6a 0e                	push   $0xe
  102154:	e9 97 00 00 00       	jmp    1021f0 <_alltraps>
  102159:	90                   	nop

0010215a <Xres>:
TRAPHANDLER_NOEC(Xres,		T_RES)
  10215a:	6a 00                	push   $0x0
  10215c:	6a 0f                	push   $0xf
  10215e:	e9 8d 00 00 00       	jmp    1021f0 <_alltraps>
  102163:	90                   	nop

00102164 <Xfperr>:
TRAPHANDLER_NOEC(Xfperr,	T_FPERR)
  102164:	6a 00                	push   $0x0
  102166:	6a 10                	push   $0x10
  102168:	e9 83 00 00 00       	jmp    1021f0 <_alltraps>
  10216d:	90                   	nop

0010216e <Xalign>:
TRAPHANDLER     (Xalign,	T_ALIGN)
  10216e:	6a 11                	push   $0x11
  102170:	eb 7e                	jmp    1021f0 <_alltraps>

00102172 <Xmchk>:
TRAPHANDLER_NOEC(Xmchk,		T_MCHK)
  102172:	6a 00                	push   $0x0
  102174:	6a 12                	push   $0x12
  102176:	eb 78                	jmp    1021f0 <_alltraps>

00102178 <Xirq_timer>:

/* ISA interrupts  */
TRAPHANDLER_NOEC(Xirq_timer,	T_IRQ0 + IRQ_TIMER)
  102178:	6a 00                	push   $0x0
  10217a:	6a 20                	push   $0x20
  10217c:	eb 72                	jmp    1021f0 <_alltraps>

0010217e <Xirq_kbd>:
TRAPHANDLER_NOEC(Xirq_kbd,	T_IRQ0 + IRQ_KBD)
  10217e:	6a 00                	push   $0x0
  102180:	6a 21                	push   $0x21
  102182:	eb 6c                	jmp    1021f0 <_alltraps>

00102184 <Xirq_slave>:
TRAPHANDLER_NOEC(Xirq_slave,	T_IRQ0 + IRQ_SLAVE)
  102184:	6a 00                	push   $0x0
  102186:	6a 22                	push   $0x22
  102188:	eb 66                	jmp    1021f0 <_alltraps>

0010218a <Xirq_serial2>:
TRAPHANDLER_NOEC(Xirq_serial2,	T_IRQ0 + IRQ_SERIAL24)
  10218a:	6a 00                	push   $0x0
  10218c:	6a 23                	push   $0x23
  10218e:	eb 60                	jmp    1021f0 <_alltraps>

00102190 <Xirq_serial1>:
TRAPHANDLER_NOEC(Xirq_serial1,	T_IRQ0 + IRQ_SERIAL13)
  102190:	6a 00                	push   $0x0
  102192:	6a 24                	push   $0x24
  102194:	eb 5a                	jmp    1021f0 <_alltraps>

00102196 <Xirq_lpt>:
TRAPHANDLER_NOEC(Xirq_lpt,	T_IRQ0 + IRQ_LPT2)
  102196:	6a 00                	push   $0x0
  102198:	6a 25                	push   $0x25
  10219a:	eb 54                	jmp    1021f0 <_alltraps>

0010219c <Xirq_floppy>:
TRAPHANDLER_NOEC(Xirq_floppy,	T_IRQ0 + IRQ_FLOPPY)
  10219c:	6a 00                	push   $0x0
  10219e:	6a 26                	push   $0x26
  1021a0:	eb 4e                	jmp    1021f0 <_alltraps>

001021a2 <Xirq_spurious>:
TRAPHANDLER_NOEC(Xirq_spurious,	T_IRQ0 + IRQ_SPURIOUS)
  1021a2:	6a 00                	push   $0x0
  1021a4:	6a 27                	push   $0x27
  1021a6:	eb 48                	jmp    1021f0 <_alltraps>

001021a8 <Xirq_rtc>:
TRAPHANDLER_NOEC(Xirq_rtc,	T_IRQ0 + IRQ_RTC)
  1021a8:	6a 00                	push   $0x0
  1021aa:	6a 28                	push   $0x28
  1021ac:	eb 42                	jmp    1021f0 <_alltraps>

001021ae <Xirq9>:
TRAPHANDLER_NOEC(Xirq9,		T_IRQ0 + 9)
  1021ae:	6a 00                	push   $0x0
  1021b0:	6a 29                	push   $0x29
  1021b2:	eb 3c                	jmp    1021f0 <_alltraps>

001021b4 <Xirq10>:
TRAPHANDLER_NOEC(Xirq10,	T_IRQ0 + 10)
  1021b4:	6a 00                	push   $0x0
  1021b6:	6a 2a                	push   $0x2a
  1021b8:	eb 36                	jmp    1021f0 <_alltraps>

001021ba <Xirq11>:
TRAPHANDLER_NOEC(Xirq11,	T_IRQ0 + 11)
  1021ba:	6a 00                	push   $0x0
  1021bc:	6a 2b                	push   $0x2b
  1021be:	eb 30                	jmp    1021f0 <_alltraps>

001021c0 <Xirq_mouse>:
TRAPHANDLER_NOEC(Xirq_mouse,	T_IRQ0 + IRQ_MOUSE)
  1021c0:	6a 00                	push   $0x0
  1021c2:	6a 2c                	push   $0x2c
  1021c4:	eb 2a                	jmp    1021f0 <_alltraps>

001021c6 <Xirq_coproc>:
TRAPHANDLER_NOEC(Xirq_coproc,	T_IRQ0 + IRQ_COPROCESSOR)
  1021c6:	6a 00                	push   $0x0
  1021c8:	6a 2d                	push   $0x2d
  1021ca:	eb 24                	jmp    1021f0 <_alltraps>

001021cc <Xirq_ide1>:
TRAPHANDLER_NOEC(Xirq_ide1,	T_IRQ0 + IRQ_IDE1)
  1021cc:	6a 00                	push   $0x0
  1021ce:	6a 2e                	push   $0x2e
  1021d0:	eb 1e                	jmp    1021f0 <_alltraps>

001021d2 <Xirq_ide2>:
TRAPHANDLER_NOEC(Xirq_ide2,	T_IRQ0 + IRQ_IDE2)
  1021d2:	6a 00                	push   $0x0
  1021d4:	6a 2f                	push   $0x2f
  1021d6:	eb 18                	jmp    1021f0 <_alltraps>

001021d8 <Xsyscall>:

/* syscall */
TRAPHANDLER_NOEC(Xsyscall,	T_SYSCALL)
  1021d8:	6a 00                	push   $0x0
  1021da:	6a 30                	push   $0x30
  1021dc:	eb 12                	jmp    1021f0 <_alltraps>

001021de <Xdefault>:

/* default ? */
TRAPHANDLER     (Xdefault,	T_DEFAULT)
  1021de:	68 fe 00 00 00       	push   $0xfe
  1021e3:	eb 0b                	jmp    1021f0 <_alltraps>
  1021e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1021ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001021f0 <_alltraps>:

	.globl _alltraps
	.type _alltraps, @function
	.p2align 4, 0x90	/* 16-byte alignment, nop filled */
_alltraps:
	cli			# make sure there is no nested trap
  1021f0:	fa                   	cli    
	cld
  1021f1:	fc                   	cld    

	pushl	%ds		# build context
  1021f2:	1e                   	push   %ds
	pushl	%es
  1021f3:	06                   	push   %es
	pushal
  1021f4:	60                   	pusha  

	movl	$CPU_GDT_KDATA, %eax	# load kernel's data segment
  1021f5:	b8 10 00 00 00       	mov    $0x10,%eax
	movw	%ax, %ds
  1021fa:	8e d8                	mov    %eax,%ds
	movw	%ax, %es
  1021fc:	8e c0                	mov    %eax,%es

	pushl	%esp		# pass pointer to this trapframe
  1021fe:	54                   	push   %esp

	call	trap		# and call trap (does not return)
  1021ff:	e8 2c 63 00 00       	call   108530 <trap>

1:	hlt			# should never get here; just spin...
  102204:	f4                   	hlt    
  102205:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10220c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102210 <trap_return>:
//
	.globl trap_return
	.type trap_return, @function
	.p2align 4, 0x90	/* 16-byte alignment, nop filled */
trap_return:
	movl	4(%esp), %esp	// reset stack pointer to point to trap frame
  102210:	8b 64 24 04          	mov    0x4(%esp),%esp
	popal			// restore general-purpose registers except esp
  102214:	61                   	popa   
	popl	%es		// restore data segment registers
  102215:	07                   	pop    %es
	popl	%ds
  102216:	1f                   	pop    %ds
	addl	$8, %esp	// skip tf_trapno and tf_errcode
  102217:	83 c4 08             	add    $0x8,%esp
	iret			// return from trap handler
  10221a:	cf                   	iret   
  10221b:	66 90                	xchg   %ax,%ax
  10221d:	66 90                	xchg   %ax,%ax
  10221f:	90                   	nop

00102220 <acpi_probe_rsdp>:

    return NULL;
}

acpi_rsdp_t *acpi_probe_rsdp(void)
{
  102220:	57                   	push   %edi
  102221:	56                   	push   %esi
  102222:	53                   	push   %ebx
    uint8_t *bda;
    uint32_t p;
    acpi_rsdp_t *rsdp;

    bda = (uint8_t *) 0x400;
    if ((p = ((bda[0x0F] << 8) | bda[0x0E]) << 4)) {
  102223:	0f b6 05 0f 04 00 00 	movzbl 0x40f,%eax
  10222a:	0f b6 15 0e 04 00 00 	movzbl 0x40e,%edx
  102231:	c1 e0 08             	shl    $0x8,%eax
  102234:	09 d0                	or     %edx,%eax
  102236:	c1 e0 04             	shl    $0x4,%eax
  102239:	74 4d                	je     102288 <acpi_probe_rsdp+0x68>
        if (*(uint32_t *) p == ACPI_RSDP_SIG1 &&
  10223b:	81 38 52 53 44 20    	cmpl   $0x20445352,(%eax)
    e = addr + length;
  102241:	8d 88 00 04 00 00    	lea    0x400(%eax),%ecx
        if (*(uint32_t *) p == ACPI_RSDP_SIG1 &&
  102247:	74 16                	je     10225f <acpi_probe_rsdp+0x3f>
  102249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for (p = addr; p < e; p += 16) {
  102250:	83 c0 10             	add    $0x10,%eax
  102253:	39 c1                	cmp    %eax,%ecx
  102255:	76 31                	jbe    102288 <acpi_probe_rsdp+0x68>
        if (*(uint32_t *) p == ACPI_RSDP_SIG1 &&
  102257:	81 38 52 53 44 20    	cmpl   $0x20445352,(%eax)
  10225d:	75 f1                	jne    102250 <acpi_probe_rsdp+0x30>
  10225f:	81 78 04 50 54 52 20 	cmpl   $0x20525450,0x4(%eax)
  102266:	75 e8                	jne    102250 <acpi_probe_rsdp+0x30>
  102268:	89 c2                	mov    %eax,%edx
    sum = 0;
  10226a:	31 db                	xor    %ebx,%ebx
  10226c:	8d 70 24             	lea    0x24(%eax),%esi
  10226f:	90                   	nop
        sum += addr[i];
  102270:	0f b6 3a             	movzbl (%edx),%edi
    for (i = 0; i < len; i++) {
  102273:	83 c2 01             	add    $0x1,%edx
        sum += addr[i];
  102276:	01 fb                	add    %edi,%ebx
    for (i = 0; i < len; i++) {
  102278:	39 d6                	cmp    %edx,%esi
  10227a:	75 f4                	jne    102270 <acpi_probe_rsdp+0x50>
            *(uint32_t *) (p + 4) == ACPI_RSDP_SIG2 &&
  10227c:	84 db                	test   %bl,%bl
  10227e:	75 d0                	jne    102250 <acpi_probe_rsdp+0x30>
        if ((rsdp = acpi_probe_rsdp_aux((uint8_t *) p, 1024)))
            return rsdp;
    }

    return acpi_probe_rsdp_aux((uint8_t *) 0xE0000, 0x1FFFF);
}
  102280:	5b                   	pop    %ebx
  102281:	5e                   	pop    %esi
  102282:	5f                   	pop    %edi
  102283:	c3                   	ret    
  102284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102288:	b8 00 00 0e 00       	mov    $0xe0000,%eax
  10228d:	eb 0b                	jmp    10229a <acpi_probe_rsdp+0x7a>
  10228f:	90                   	nop
    for (p = addr; p < e; p += 16) {
  102290:	83 c0 10             	add    $0x10,%eax
  102293:	3d 00 00 10 00       	cmp    $0x100000,%eax
  102298:	74 38                	je     1022d2 <acpi_probe_rsdp+0xb2>
        if (*(uint32_t *) p == ACPI_RSDP_SIG1 &&
  10229a:	81 38 52 53 44 20    	cmpl   $0x20445352,(%eax)
  1022a0:	75 ee                	jne    102290 <acpi_probe_rsdp+0x70>
  1022a2:	81 78 04 50 54 52 20 	cmpl   $0x20525450,0x4(%eax)
  1022a9:	75 e5                	jne    102290 <acpi_probe_rsdp+0x70>
  1022ab:	89 c2                	mov    %eax,%edx
    sum = 0;
  1022ad:	31 c9                	xor    %ecx,%ecx
  1022af:	8d 70 24             	lea    0x24(%eax),%esi
  1022b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        sum += addr[i];
  1022b8:	0f b6 1a             	movzbl (%edx),%ebx
    for (i = 0; i < len; i++) {
  1022bb:	83 c2 01             	add    $0x1,%edx
        sum += addr[i];
  1022be:	01 d9                	add    %ebx,%ecx
    for (i = 0; i < len; i++) {
  1022c0:	39 f2                	cmp    %esi,%edx
  1022c2:	75 f4                	jne    1022b8 <acpi_probe_rsdp+0x98>
            *(uint32_t *) (p + 4) == ACPI_RSDP_SIG2 &&
  1022c4:	84 c9                	test   %cl,%cl
  1022c6:	74 b8                	je     102280 <acpi_probe_rsdp+0x60>
    for (p = addr; p < e; p += 16) {
  1022c8:	83 c0 10             	add    $0x10,%eax
  1022cb:	3d 00 00 10 00       	cmp    $0x100000,%eax
  1022d0:	75 c8                	jne    10229a <acpi_probe_rsdp+0x7a>
}
  1022d2:	5b                   	pop    %ebx
    return NULL;
  1022d3:	31 c0                	xor    %eax,%eax
}
  1022d5:	5e                   	pop    %esi
  1022d6:	5f                   	pop    %edi
  1022d7:	c3                   	ret    
  1022d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1022df:	90                   	nop

001022e0 <acpi_probe_rsdt>:

acpi_rsdt_t *acpi_probe_rsdt(acpi_rsdp_t *rsdp)
{
  1022e0:	56                   	push   %esi
  1022e1:	53                   	push   %ebx
  1022e2:	e8 a2 e0 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1022e7:	81 c3 19 1d 01 00    	add    $0x11d19,%ebx
  1022ed:	83 ec 04             	sub    $0x4,%esp
  1022f0:	8b 74 24 10          	mov    0x10(%esp),%esi
    KERN_ASSERT(rsdp != NULL);
  1022f4:	85 f6                	test   %esi,%esi
  1022f6:	74 50                	je     102348 <acpi_probe_rsdt+0x68>

    acpi_rsdt_t *rsdt = (acpi_rsdt_t *) (rsdp->rsdt_addr);
  1022f8:	8b 5e 10             	mov    0x10(%esi),%ebx
  1022fb:	89 d8                	mov    %ebx,%eax
    if (rsdt == NULL)
  1022fd:	85 db                	test   %ebx,%ebx
  1022ff:	74 2a                	je     10232b <acpi_probe_rsdt+0x4b>
        return NULL;
    if (rsdt->sig == ACPI_RSDT_SIG && sum((uint8_t *) rsdt, rsdt->length) == 0) {
  102301:	81 3b 52 53 44 54    	cmpl   $0x54445352,(%ebx)
  102307:	75 2f                	jne    102338 <acpi_probe_rsdt+0x58>
  102309:	8b 73 04             	mov    0x4(%ebx),%esi
    for (i = 0; i < len; i++) {
  10230c:	85 f6                	test   %esi,%esi
  10230e:	7e 1b                	jle    10232b <acpi_probe_rsdt+0x4b>
  102310:	01 de                	add    %ebx,%esi
    sum = 0;
  102312:	31 d2                	xor    %edx,%edx
  102314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        sum += addr[i];
  102318:	0f b6 08             	movzbl (%eax),%ecx
    for (i = 0; i < len; i++) {
  10231b:	83 c0 01             	add    $0x1,%eax
        sum += addr[i];
  10231e:	01 ca                	add    %ecx,%edx
    for (i = 0; i < len; i++) {
  102320:	39 c6                	cmp    %eax,%esi
  102322:	75 f4                	jne    102318 <acpi_probe_rsdt+0x38>
        return NULL;
  102324:	31 c0                	xor    %eax,%eax
  102326:	84 d2                	test   %dl,%dl
  102328:	0f 45 d8             	cmovne %eax,%ebx
        return rsdt;
    }

    return NULL;
}
  10232b:	83 c4 04             	add    $0x4,%esp
  10232e:	89 d8                	mov    %ebx,%eax
  102330:	5b                   	pop    %ebx
  102331:	5e                   	pop    %esi
  102332:	c3                   	ret    
  102333:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102337:	90                   	nop
        return NULL;
  102338:	31 db                	xor    %ebx,%ebx
}
  10233a:	83 c4 04             	add    $0x4,%esp
  10233d:	89 d8                	mov    %ebx,%eax
  10233f:	5b                   	pop    %ebx
  102340:	5e                   	pop    %esi
  102341:	c3                   	ret    
  102342:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    KERN_ASSERT(rsdp != NULL);
  102348:	8d 83 56 75 ff ff    	lea    -0x8aaa(%ebx),%eax
  10234e:	50                   	push   %eax
  10234f:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  102355:	50                   	push   %eax
  102356:	8d 83 63 75 ff ff    	lea    -0x8a9d(%ebx),%eax
  10235c:	6a 33                	push   $0x33
  10235e:	50                   	push   %eax
  10235f:	e8 ac 23 00 00       	call   104710 <debug_panic>
  102364:	83 c4 10             	add    $0x10,%esp
  102367:	eb 8f                	jmp    1022f8 <acpi_probe_rsdt+0x18>
  102369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102370 <acpi_probe_rsdt_ent>:

acpi_sdt_hdr_t *acpi_probe_rsdt_ent(acpi_rsdt_t *rsdt, const uint32_t sig)
{
  102370:	55                   	push   %ebp
  102371:	57                   	push   %edi
  102372:	56                   	push   %esi
  102373:	53                   	push   %ebx
  102374:	e8 10 e0 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102379:	81 c3 87 1c 01 00    	add    $0x11c87,%ebx
  10237f:	83 ec 1c             	sub    $0x1c,%esp
  102382:	8b 74 24 30          	mov    0x30(%esp),%esi
    KERN_ASSERT(rsdt != NULL);
  102386:	85 f6                	test   %esi,%esi
  102388:	74 62                	je     1023ec <acpi_probe_rsdt_ent+0x7c>

    uint8_t *p = (uint8_t *) &rsdt->ent[0];
    uint8_t *e = (uint8_t *) rsdt + rsdt->length;
  10238a:	8b 7e 04             	mov    0x4(%esi),%edi
    uint8_t *p = (uint8_t *) &rsdt->ent[0];
  10238d:	8d 56 24             	lea    0x24(%esi),%edx
    uint8_t *e = (uint8_t *) rsdt + rsdt->length;
  102390:	01 f7                	add    %esi,%edi

    int i;
    for (i = 0; p < e; i++) {
  102392:	39 d7                	cmp    %edx,%edi
  102394:	76 4a                	jbe    1023e0 <acpi_probe_rsdt_ent+0x70>
  102396:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  10239a:	8b 7c 24 34          	mov    0x34(%esp),%edi
  10239e:	eb 09                	jmp    1023a9 <acpi_probe_rsdt_ent+0x39>
  1023a0:	83 c2 04             	add    $0x4,%edx
  1023a3:	39 54 24 0c          	cmp    %edx,0xc(%esp)
  1023a7:	76 37                	jbe    1023e0 <acpi_probe_rsdt_ent+0x70>
        acpi_sdt_hdr_t *hdr = (acpi_sdt_hdr_t *) (rsdt->ent[i]);
  1023a9:	8b 02                	mov    (%edx),%eax
  1023ab:	89 c5                	mov    %eax,%ebp
        if (hdr->sig == sig && sum((uint8_t *) hdr, hdr->length) == 0) {
  1023ad:	39 38                	cmp    %edi,(%eax)
  1023af:	75 ef                	jne    1023a0 <acpi_probe_rsdt_ent+0x30>
  1023b1:	8b 70 04             	mov    0x4(%eax),%esi
    for (i = 0; i < len; i++) {
  1023b4:	85 f6                	test   %esi,%esi
  1023b6:	7e 18                	jle    1023d0 <acpi_probe_rsdt_ent+0x60>
  1023b8:	01 c6                	add    %eax,%esi
    sum = 0;
  1023ba:	31 c9                	xor    %ecx,%ecx
  1023bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        sum += addr[i];
  1023c0:	0f b6 18             	movzbl (%eax),%ebx
    for (i = 0; i < len; i++) {
  1023c3:	83 c0 01             	add    $0x1,%eax
        sum += addr[i];
  1023c6:	01 d9                	add    %ebx,%ecx
    for (i = 0; i < len; i++) {
  1023c8:	39 c6                	cmp    %eax,%esi
  1023ca:	75 f4                	jne    1023c0 <acpi_probe_rsdt_ent+0x50>
        if (hdr->sig == sig && sum((uint8_t *) hdr, hdr->length) == 0) {
  1023cc:	84 c9                	test   %cl,%cl
  1023ce:	75 d0                	jne    1023a0 <acpi_probe_rsdt_ent+0x30>
        }
        p = (uint8_t *) &rsdt->ent[i + 1];
    }

    return NULL;
}
  1023d0:	83 c4 1c             	add    $0x1c,%esp
  1023d3:	89 e8                	mov    %ebp,%eax
  1023d5:	5b                   	pop    %ebx
  1023d6:	5e                   	pop    %esi
  1023d7:	5f                   	pop    %edi
  1023d8:	5d                   	pop    %ebp
  1023d9:	c3                   	ret    
  1023da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1023e0:	83 c4 1c             	add    $0x1c,%esp
    return NULL;
  1023e3:	31 ed                	xor    %ebp,%ebp
}
  1023e5:	5b                   	pop    %ebx
  1023e6:	89 e8                	mov    %ebp,%eax
  1023e8:	5e                   	pop    %esi
  1023e9:	5f                   	pop    %edi
  1023ea:	5d                   	pop    %ebp
  1023eb:	c3                   	ret    
    KERN_ASSERT(rsdt != NULL);
  1023ec:	8d 83 73 75 ff ff    	lea    -0x8a8d(%ebx),%eax
  1023f2:	50                   	push   %eax
  1023f3:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  1023f9:	50                   	push   %eax
  1023fa:	8d 83 63 75 ff ff    	lea    -0x8a9d(%ebx),%eax
  102400:	6a 41                	push   $0x41
  102402:	50                   	push   %eax
  102403:	e8 08 23 00 00       	call   104710 <debug_panic>
  102408:	83 c4 10             	add    $0x10,%esp
  10240b:	e9 7a ff ff ff       	jmp    10238a <acpi_probe_rsdt_ent+0x1a>

00102410 <acpi_probe_xsdt>:

acpi_xsdt_t *acpi_probe_xsdt(acpi_rsdp_t *rsdp)
{
  102410:	56                   	push   %esi
  102411:	53                   	push   %ebx
  102412:	e8 72 df ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102417:	81 c3 e9 1b 01 00    	add    $0x11be9,%ebx
  10241d:	83 ec 04             	sub    $0x4,%esp
  102420:	8b 74 24 10          	mov    0x10(%esp),%esi
    KERN_ASSERT(rsdp != NULL);
  102424:	85 f6                	test   %esi,%esi
  102426:	74 50                	je     102478 <acpi_probe_xsdt+0x68>

    acpi_xsdt_t *xsdt = (acpi_xsdt_t *) (uintptr_t) rsdp->xsdt_addr;
  102428:	8b 5e 18             	mov    0x18(%esi),%ebx
  10242b:	89 d8                	mov    %ebx,%eax
    if (xsdt == NULL)
  10242d:	85 db                	test   %ebx,%ebx
  10242f:	74 2a                	je     10245b <acpi_probe_xsdt+0x4b>
        return NULL;
    if (xsdt->sig == ACPI_XSDT_SIG && sum((uint8_t *) xsdt, xsdt->length) == 0) {
  102431:	81 3b 58 53 44 54    	cmpl   $0x54445358,(%ebx)
  102437:	75 2f                	jne    102468 <acpi_probe_xsdt+0x58>
  102439:	8b 73 04             	mov    0x4(%ebx),%esi
    for (i = 0; i < len; i++) {
  10243c:	85 f6                	test   %esi,%esi
  10243e:	7e 1b                	jle    10245b <acpi_probe_xsdt+0x4b>
  102440:	01 de                	add    %ebx,%esi
    sum = 0;
  102442:	31 d2                	xor    %edx,%edx
  102444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        sum += addr[i];
  102448:	0f b6 08             	movzbl (%eax),%ecx
    for (i = 0; i < len; i++) {
  10244b:	83 c0 01             	add    $0x1,%eax
        sum += addr[i];
  10244e:	01 ca                	add    %ecx,%edx
    for (i = 0; i < len; i++) {
  102450:	39 c6                	cmp    %eax,%esi
  102452:	75 f4                	jne    102448 <acpi_probe_xsdt+0x38>
        return NULL;
  102454:	31 c0                	xor    %eax,%eax
  102456:	84 d2                	test   %dl,%dl
  102458:	0f 45 d8             	cmovne %eax,%ebx
        return xsdt;
    }

    return NULL;
}
  10245b:	83 c4 04             	add    $0x4,%esp
  10245e:	89 d8                	mov    %ebx,%eax
  102460:	5b                   	pop    %ebx
  102461:	5e                   	pop    %esi
  102462:	c3                   	ret    
  102463:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102467:	90                   	nop
        return NULL;
  102468:	31 db                	xor    %ebx,%ebx
}
  10246a:	83 c4 04             	add    $0x4,%esp
  10246d:	89 d8                	mov    %ebx,%eax
  10246f:	5b                   	pop    %ebx
  102470:	5e                   	pop    %esi
  102471:	c3                   	ret    
  102472:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    KERN_ASSERT(rsdp != NULL);
  102478:	8d 83 56 75 ff ff    	lea    -0x8aaa(%ebx),%eax
  10247e:	50                   	push   %eax
  10247f:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  102485:	50                   	push   %eax
  102486:	8d 83 63 75 ff ff    	lea    -0x8a9d(%ebx),%eax
  10248c:	6a 54                	push   $0x54
  10248e:	50                   	push   %eax
  10248f:	e8 7c 22 00 00       	call   104710 <debug_panic>
  102494:	83 c4 10             	add    $0x10,%esp
  102497:	eb 8f                	jmp    102428 <acpi_probe_xsdt+0x18>
  102499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001024a0 <acpi_probe_xsdt_ent>:

acpi_sdt_hdr_t *acpi_probe_xsdt_ent(acpi_xsdt_t *xsdt, const uint32_t sig)
{
  1024a0:	55                   	push   %ebp
  1024a1:	57                   	push   %edi
  1024a2:	56                   	push   %esi
  1024a3:	53                   	push   %ebx
  1024a4:	e8 e0 de ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1024a9:	81 c3 57 1b 01 00    	add    $0x11b57,%ebx
  1024af:	83 ec 1c             	sub    $0x1c,%esp
  1024b2:	8b 74 24 30          	mov    0x30(%esp),%esi
    KERN_ASSERT(xsdt != NULL);
  1024b6:	85 f6                	test   %esi,%esi
  1024b8:	74 62                	je     10251c <acpi_probe_xsdt_ent+0x7c>

    uint8_t *p = (uint8_t *) &xsdt->ent[0];
    uint8_t *e = (uint8_t *) xsdt + xsdt->length;
  1024ba:	8b 7e 04             	mov    0x4(%esi),%edi
    uint8_t *p = (uint8_t *) &xsdt->ent[0];
  1024bd:	8d 56 24             	lea    0x24(%esi),%edx
    uint8_t *e = (uint8_t *) xsdt + xsdt->length;
  1024c0:	01 f7                	add    %esi,%edi

    int i;
    for (i = 0; p < e; i++) {
  1024c2:	39 d7                	cmp    %edx,%edi
  1024c4:	76 4a                	jbe    102510 <acpi_probe_xsdt_ent+0x70>
  1024c6:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  1024ca:	8b 7c 24 34          	mov    0x34(%esp),%edi
  1024ce:	eb 09                	jmp    1024d9 <acpi_probe_xsdt_ent+0x39>
  1024d0:	83 c2 08             	add    $0x8,%edx
  1024d3:	39 54 24 0c          	cmp    %edx,0xc(%esp)
  1024d7:	76 37                	jbe    102510 <acpi_probe_xsdt_ent+0x70>
        acpi_sdt_hdr_t *hdr = (acpi_sdt_hdr_t *) (uintptr_t) xsdt->ent[i];
  1024d9:	8b 02                	mov    (%edx),%eax
  1024db:	89 c5                	mov    %eax,%ebp
        if (hdr->sig == sig && sum((uint8_t *) hdr, hdr->length) == 0) {
  1024dd:	39 38                	cmp    %edi,(%eax)
  1024df:	75 ef                	jne    1024d0 <acpi_probe_xsdt_ent+0x30>
  1024e1:	8b 70 04             	mov    0x4(%eax),%esi
    for (i = 0; i < len; i++) {
  1024e4:	85 f6                	test   %esi,%esi
  1024e6:	7e 18                	jle    102500 <acpi_probe_xsdt_ent+0x60>
  1024e8:	01 c6                	add    %eax,%esi
    sum = 0;
  1024ea:	31 c9                	xor    %ecx,%ecx
  1024ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        sum += addr[i];
  1024f0:	0f b6 18             	movzbl (%eax),%ebx
    for (i = 0; i < len; i++) {
  1024f3:	83 c0 01             	add    $0x1,%eax
        sum += addr[i];
  1024f6:	01 d9                	add    %ebx,%ecx
    for (i = 0; i < len; i++) {
  1024f8:	39 c6                	cmp    %eax,%esi
  1024fa:	75 f4                	jne    1024f0 <acpi_probe_xsdt_ent+0x50>
        if (hdr->sig == sig && sum((uint8_t *) hdr, hdr->length) == 0) {
  1024fc:	84 c9                	test   %cl,%cl
  1024fe:	75 d0                	jne    1024d0 <acpi_probe_xsdt_ent+0x30>
        }
        p = (uint8_t *) &xsdt->ent[i + 1];
    }

    return NULL;
}
  102500:	83 c4 1c             	add    $0x1c,%esp
  102503:	89 e8                	mov    %ebp,%eax
  102505:	5b                   	pop    %ebx
  102506:	5e                   	pop    %esi
  102507:	5f                   	pop    %edi
  102508:	5d                   	pop    %ebp
  102509:	c3                   	ret    
  10250a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102510:	83 c4 1c             	add    $0x1c,%esp
    return NULL;
  102513:	31 ed                	xor    %ebp,%ebp
}
  102515:	5b                   	pop    %ebx
  102516:	89 e8                	mov    %ebp,%eax
  102518:	5e                   	pop    %esi
  102519:	5f                   	pop    %edi
  10251a:	5d                   	pop    %ebp
  10251b:	c3                   	ret    
    KERN_ASSERT(xsdt != NULL);
  10251c:	8d 83 80 75 ff ff    	lea    -0x8a80(%ebx),%eax
  102522:	50                   	push   %eax
  102523:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  102529:	50                   	push   %eax
  10252a:	8d 83 63 75 ff ff    	lea    -0x8a9d(%ebx),%eax
  102530:	6a 62                	push   $0x62
  102532:	50                   	push   %eax
  102533:	e8 d8 21 00 00       	call   104710 <debug_panic>
  102538:	83 c4 10             	add    $0x10,%esp
  10253b:	e9 7a ff ff ff       	jmp    1024ba <acpi_probe_xsdt_ent+0x1a>

00102540 <lapic_register>:
{
}

void lapic_register(uintptr_t lapic_addr)
{
    lapic = (lapic_t *) lapic_addr;
  102540:	e8 3c de ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  102545:	05 bb 1a 01 00       	add    $0x11abb,%eax
  10254a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10254e:	89 90 90 b8 03 00    	mov    %edx,0x3b890(%eax)
}
  102554:	c3                   	ret    
  102555:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10255c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102560 <lapic_init>:

/*
 * Initialize local APIC.
 */
void lapic_init()
{
  102560:	55                   	push   %ebp
  102561:	57                   	push   %edi
  102562:	56                   	push   %esi
  102563:	53                   	push   %ebx
  102564:	e8 20 de ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102569:	81 c3 97 1a 01 00    	add    $0x11a97,%ebx
  10256f:	83 ec 2c             	sub    $0x2c,%esp
    if (!lapic)
  102572:	8b 83 90 b8 03 00    	mov    0x3b890(%ebx),%eax
  102578:	8d 93 96 75 ff ff    	lea    -0x8a6a(%ebx),%edx
  10257e:	89 54 24 10          	mov    %edx,0x10(%esp)
  102582:	85 c0                	test   %eax,%eax
  102584:	0f 84 9b 02 00 00    	je     102825 <lapic_init+0x2c5>
    lapic[index] = value;
  10258a:	c7 80 f0 00 00 00 27 	movl   $0x127,0xf0(%eax)
  102591:	01 00 00 
    lapic[LAPIC_ID];
  102594:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102597:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
  10259e:	00 00 00 
    lapic[LAPIC_ID];
  1025a1:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  1025a4:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
  1025ab:	00 02 00 
    lapic[LAPIC_ID];
  1025ae:	8b 50 20             	mov    0x20(%eax),%edx
    int i;
    for (i = 0; i < 5; i++) {
        lapic_ticks_per_ms = lapic_calibrate_timer(CAL_LATCH, CAL_MS, CAL_PIT_LOOPS);
        if (lapic_ticks_per_ms != ~(uint32_t) 0x0)
            break;
        KERN_DEBUG("[%d] Retry to calibrate internal timer of LAPIC.\n", i);
  1025b1:	8d 93 ec 75 ff ff    	lea    -0x8a14(%ebx),%edx
    for (i = 0; i < 5; i++) {
  1025b7:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1025be:	00 
        KERN_DEBUG("[%d] Retry to calibrate internal timer of LAPIC.\n", i);
  1025bf:	89 54 24 1c          	mov    %edx,0x1c(%esp)
    lapic[index] = value;
  1025c3:	c7 80 80 03 00 00 ff 	movl   $0xffffffff,0x380(%eax)
  1025ca:	ff ff ff 
    outb(0x61, (inb(0x61) & ~0x02) | 0x01);
  1025cd:	83 ec 0c             	sub    $0xc,%esp
    lapic[LAPIC_ID];
  1025d0:	8b 40 20             	mov    0x20(%eax),%eax
    outb(0x61, (inb(0x61) & ~0x02) | 0x01);
  1025d3:	6a 61                	push   $0x61
  1025d5:	e8 46 2f 00 00       	call   105520 <inb>
  1025da:	5a                   	pop    %edx
  1025db:	59                   	pop    %ecx
  1025dc:	25 fc 00 00 00       	and    $0xfc,%eax
  1025e1:	83 c8 01             	or     $0x1,%eax
  1025e4:	50                   	push   %eax
  1025e5:	6a 61                	push   $0x61
  1025e7:	e8 64 2f 00 00       	call   105550 <outb>
    outb(0x43, 0xb0);
  1025ec:	5e                   	pop    %esi
  1025ed:	5f                   	pop    %edi
  1025ee:	68 b0 00 00 00       	push   $0xb0
  1025f3:	6a 43                	push   $0x43
    timermin = ~(uint32_t) 0x0;
  1025f5:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    outb(0x43, 0xb0);
  1025fa:	e8 51 2f 00 00       	call   105550 <outb>
    outb(0x42, latch & 0xff);
  1025ff:	5d                   	pop    %ebp
  102600:	58                   	pop    %eax
  102601:	68 9b 00 00 00       	push   $0x9b
  102606:	6a 42                	push   $0x42
    timermax = 0;
  102608:	31 ed                	xor    %ebp,%ebp
    outb(0x42, latch & 0xff);
  10260a:	e8 41 2f 00 00       	call   105550 <outb>
    outb(0x42, latch >> 8);
  10260f:	58                   	pop    %eax
  102610:	5a                   	pop    %edx
  102611:	6a 2e                	push   $0x2e
  102613:	6a 42                	push   $0x42
  102615:	e8 36 2f 00 00       	call   105550 <outb>
    return lapic[index];
  10261a:	8b 83 90 b8 03 00    	mov    0x3b890(%ebx),%eax
  102620:	8b 80 90 03 00 00    	mov    0x390(%eax),%eax
  102626:	89 44 24 28          	mov    %eax,0x28(%esp)
  10262a:	89 c6                	mov    %eax,%esi
  10262c:	89 e8                	mov    %ebp,%eax
    while ((inb(0x61) & 0x20) == 0) {
  10262e:	83 c4 10             	add    $0x10,%esp
  102631:	89 fd                	mov    %edi,%ebp
  102633:	89 c7                	mov    %eax,%edi
    pitcnt = 0;
  102635:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  10263c:	00 
    while ((inb(0x61) & 0x20) == 0) {
  10263d:	eb 20                	jmp    10265f <lapic_init+0xff>
  10263f:	90                   	nop
    return lapic[index];
  102640:	8b 83 90 b8 03 00    	mov    0x3b890(%ebx),%eax
  102646:	8b 80 90 03 00 00    	mov    0x390(%eax),%eax
        delta = timer - timer2;
  10264c:	29 c6                	sub    %eax,%esi
        if (delta < timermin)
  10264e:	39 f5                	cmp    %esi,%ebp
  102650:	0f 47 ee             	cmova  %esi,%ebp
        if (delta > timermax)
  102653:	39 f7                	cmp    %esi,%edi
  102655:	0f 42 fe             	cmovb  %esi,%edi
        pitcnt++;
  102658:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)
        timer = timer2;
  10265d:	89 c6                	mov    %eax,%esi
    while ((inb(0x61) & 0x20) == 0) {
  10265f:	83 ec 0c             	sub    $0xc,%esp
  102662:	6a 61                	push   $0x61
  102664:	e8 b7 2e 00 00       	call   105520 <inb>
  102669:	83 c4 10             	add    $0x10,%esp
  10266c:	a8 20                	test   $0x20,%al
  10266e:	74 d0                	je     102640 <lapic_init+0xe0>
    if (pitcnt < loopmin || timermax > 10 * timermin)
  102670:	89 f8                	mov    %edi,%eax
  102672:	81 7c 24 0c e7 03 00 	cmpl   $0x3e7,0xc(%esp)
  102679:	00 
  10267a:	89 ef                	mov    %ebp,%edi
  10267c:	89 c5                	mov    %eax,%ebp
  10267e:	0f 8e 3c 01 00 00    	jle    1027c0 <lapic_init+0x260>
  102684:	8d 04 bf             	lea    (%edi,%edi,4),%eax
  102687:	01 c0                	add    %eax,%eax
  102689:	39 c5                	cmp    %eax,%ebp
  10268b:	0f 87 2f 01 00 00    	ja     1027c0 <lapic_init+0x260>
    delta = timer1 - timer2;
  102691:	8b 54 24 18          	mov    0x18(%esp),%edx
    return delta / ms;
  102695:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    if (lapic_ticks_per_ms == ~(uint32_t) 0x0) {
        KERN_WARN("Failed to calibrate internal timer of LAPIC.\n");
        KERN_DEBUG("Assume LAPIC timer freq = 0.5 GHz.\n");
        lapic_ticks_per_ms = 500000;
    } else
        KERN_DEBUG("LAPIC timer freq = %llu Hz.\n",
  10269a:	83 ec 0c             	sub    $0xc,%esp
    delta = timer1 - timer2;
  10269d:	29 f2                	sub    %esi,%edx
    return delta / ms;
  10269f:	89 d0                	mov    %edx,%eax
  1026a1:	f7 e1                	mul    %ecx
        KERN_DEBUG("LAPIC timer freq = %llu Hz.\n",
  1026a3:	b8 e8 03 00 00       	mov    $0x3e8,%eax
    return delta / ms;
  1026a8:	c1 ea 03             	shr    $0x3,%edx
  1026ab:	89 d6                	mov    %edx,%esi
        KERN_DEBUG("LAPIC timer freq = %llu Hz.\n",
  1026ad:	f7 e2                	mul    %edx
  1026af:	52                   	push   %edx
  1026b0:	50                   	push   %eax
  1026b1:	8d 83 a7 75 ff ff    	lea    -0x8a59(%ebx),%eax
  1026b7:	50                   	push   %eax
  1026b8:	6a 7d                	push   $0x7d
  1026ba:	ff 74 24 2c          	push   0x2c(%esp)
  1026be:	e8 ed 1f 00 00       	call   1046b0 <debug_normal>
                   (uint64_t) lapic_ticks_per_ms * 1000);

    uint32_t ticr = lapic_ticks_per_ms * 1000 / LAPIC_TIMER_INTR_FREQ;
  1026c3:	69 d6 e8 03 00 00    	imul   $0x3e8,%esi,%edx
  1026c9:	b9 d3 4d 62 10       	mov    $0x10624dd3,%ecx
  1026ce:	83 c4 20             	add    $0x20,%esp
  1026d1:	89 d0                	mov    %edx,%eax
  1026d3:	f7 e1                	mul    %ecx
  1026d5:	c1 ea 06             	shr    $0x6,%edx
  1026d8:	89 d6                	mov    %edx,%esi
    KERN_DEBUG("Set LAPIC TICR = %x.\n", ticr);
  1026da:	8d 83 c4 75 ff ff    	lea    -0x8a3c(%ebx),%eax
  1026e0:	56                   	push   %esi
  1026e1:	50                   	push   %eax
  1026e2:	68 81 00 00 00       	push   $0x81
  1026e7:	ff 74 24 1c          	push   0x1c(%esp)
  1026eb:	e8 c0 1f 00 00       	call   1046b0 <debug_normal>
    lapic[index] = value;
  1026f0:	8b 83 90 b8 03 00    	mov    0x3b890(%ebx),%eax
    lapic_write(LAPIC_LINT0, LAPIC_LINT_MASKED);
    lapic_write(LAPIC_LINT1, LAPIC_LINT_MASKED);

    // Disable performance counter overflow interrupts
    // on machines that provide that interrupt entry.
    if (((lapic_read(LAPIC_VER) >> 16) & 0xFF) >= 4)
  1026f6:	83 c4 10             	add    $0x10,%esp
    lapic[index] = value;
  1026f9:	89 b0 80 03 00 00    	mov    %esi,0x380(%eax)
    lapic[LAPIC_ID];
  1026ff:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102702:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
  102709:	00 01 00 
    lapic[LAPIC_ID];
  10270c:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  10270f:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
  102716:	00 01 00 
    lapic[LAPIC_ID];
  102719:	8b 50 20             	mov    0x20(%eax),%edx
    return lapic[index];
  10271c:	8b 50 30             	mov    0x30(%eax),%edx
    if (((lapic_read(LAPIC_VER) >> 16) & 0xFF) >= 4)
  10271f:	c1 ea 10             	shr    $0x10,%edx
  102722:	81 e2 fc 00 00 00    	and    $0xfc,%edx
  102728:	74 0d                	je     102737 <lapic_init+0x1d7>
    lapic[index] = value;
  10272a:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
  102731:	00 01 00 
    lapic[LAPIC_ID];
  102734:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102737:	c7 80 e0 00 00 00 00 	movl   $0xf0000000,0xe0(%eax)
  10273e:	00 00 f0 
    lapic[LAPIC_ID];
  102741:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102744:	c7 80 d0 00 00 00 00 	movl   $0x0,0xd0(%eax)
  10274b:	00 00 00 
    lapic[LAPIC_ID];
  10274e:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102751:	c7 80 70 03 00 00 32 	movl   $0x32,0x370(%eax)
  102758:	00 00 00 
    lapic[LAPIC_ID];
  10275b:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  10275e:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  102765:	00 00 00 
    lapic[LAPIC_ID];
  102768:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  10276b:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  102772:	00 00 00 
    lapic[LAPIC_ID];
  102775:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102778:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  10277f:	00 00 00 
    lapic[LAPIC_ID];
  102782:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102785:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
  10278c:	00 00 00 
    lapic[LAPIC_ID];
  10278f:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102792:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
  102799:	85 08 00 
    lapic[LAPIC_ID];
  10279c:	8b 50 20             	mov    0x20(%eax),%edx
  10279f:	90                   	nop
    return lapic[index];
  1027a0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx

    // Send an Init Level De-Assert to synchronise arbitration ID's.
    lapic_write(LAPIC_ICRHI, 0);
    lapic_write(LAPIC_ICRLO,
                LAPIC_ICRLO_BCAST | LAPIC_ICRLO_INIT | LAPIC_ICRLO_LEVEL);
    while (lapic_read(LAPIC_ICRLO) & LAPIC_ICRLO_DELIVS);
  1027a6:	80 e6 10             	and    $0x10,%dh
  1027a9:	75 f5                	jne    1027a0 <lapic_init+0x240>
    lapic[index] = value;
  1027ab:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
  1027b2:	00 00 00 
    lapic[LAPIC_ID];
  1027b5:	8b 40 20             	mov    0x20(%eax),%eax

    // Enable interrupts on the APIC (but not on the processor).
    lapic_write(LAPIC_TPR, 0);
}
  1027b8:	83 c4 2c             	add    $0x2c,%esp
  1027bb:	5b                   	pop    %ebx
  1027bc:	5e                   	pop    %esi
  1027bd:	5f                   	pop    %edi
  1027be:	5d                   	pop    %ebp
  1027bf:	c3                   	ret    
        KERN_DEBUG("[%d] Retry to calibrate internal timer of LAPIC.\n", i);
  1027c0:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1027c4:	57                   	push   %edi
  1027c5:	ff 74 24 20          	push   0x20(%esp)
  1027c9:	6a 75                	push   $0x75
  1027cb:	ff 74 24 1c          	push   0x1c(%esp)
  1027cf:	e8 dc 1e 00 00       	call   1046b0 <debug_normal>
    for (i = 0; i < 5; i++) {
  1027d4:	89 f8                	mov    %edi,%eax
  1027d6:	83 c0 01             	add    $0x1,%eax
  1027d9:	89 44 24 24          	mov    %eax,0x24(%esp)
  1027dd:	83 c4 10             	add    $0x10,%esp
  1027e0:	83 f8 05             	cmp    $0x5,%eax
  1027e3:	74 0b                	je     1027f0 <lapic_init+0x290>
    lapic[index] = value;
  1027e5:	8b 83 90 b8 03 00    	mov    0x3b890(%ebx),%eax
  1027eb:	e9 d3 fd ff ff       	jmp    1025c3 <lapic_init+0x63>
        KERN_WARN("Failed to calibrate internal timer of LAPIC.\n");
  1027f0:	83 ec 04             	sub    $0x4,%esp
  1027f3:	8d 83 20 76 ff ff    	lea    -0x89e0(%ebx),%eax
  1027f9:	be 20 a1 07 00       	mov    $0x7a120,%esi
  1027fe:	50                   	push   %eax
  1027ff:	6a 79                	push   $0x79
  102801:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
  102805:	57                   	push   %edi
  102806:	e8 f5 1f 00 00       	call   104800 <debug_warn>
        KERN_DEBUG("Assume LAPIC timer freq = 0.5 GHz.\n");
  10280b:	83 c4 0c             	add    $0xc,%esp
  10280e:	8d 83 50 76 ff ff    	lea    -0x89b0(%ebx),%eax
  102814:	50                   	push   %eax
  102815:	6a 7a                	push   $0x7a
  102817:	57                   	push   %edi
  102818:	e8 93 1e 00 00       	call   1046b0 <debug_normal>
        lapic_ticks_per_ms = 500000;
  10281d:	83 c4 10             	add    $0x10,%esp
  102820:	e9 b5 fe ff ff       	jmp    1026da <lapic_init+0x17a>
        KERN_PANIC("NO LAPIC");
  102825:	83 ec 04             	sub    $0x4,%esp
  102828:	8d 83 8d 75 ff ff    	lea    -0x8a73(%ebx),%eax
  10282e:	50                   	push   %eax
  10282f:	6a 62                	push   $0x62
  102831:	ff 74 24 1c          	push   0x1c(%esp)
  102835:	e8 d6 1e 00 00       	call   104710 <debug_panic>
    lapic[index] = value;
  10283a:	8b 83 90 b8 03 00    	mov    0x3b890(%ebx),%eax
  102840:	83 c4 10             	add    $0x10,%esp
  102843:	e9 42 fd ff ff       	jmp    10258a <lapic_init+0x2a>
  102848:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10284f:	90                   	nop

00102850 <lapic_eoi>:
/*
 * Acknowledge the end of interrupts.
 */
void lapic_eoi(void)
{
    if (lapic)
  102850:	e8 2c db ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  102855:	05 ab 17 01 00       	add    $0x117ab,%eax
  10285a:	8b 80 90 b8 03 00    	mov    0x3b890(%eax),%eax
  102860:	85 c0                	test   %eax,%eax
  102862:	74 0d                	je     102871 <lapic_eoi+0x21>
    lapic[index] = value;
  102864:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  10286b:	00 00 00 
    lapic[LAPIC_ID];
  10286e:	8b 40 20             	mov    0x20(%eax),%eax
        lapic_write(LAPIC_EOI, 0);
}
  102871:	c3                   	ret    
  102872:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102880 <lapic_startcpu>:
/*
 * Start additional processor running bootstrap code at addr.
 * See Appendix B of MultiProcessor Specification.
 */
void lapic_startcpu(lapicid_t apicid, uintptr_t addr)
{
  102880:	57                   	push   %edi
  102881:	56                   	push   %esi
  102882:	53                   	push   %ebx
  102883:	8b 74 24 14          	mov    0x14(%esp),%esi
  102887:	e8 fd da ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10288c:	81 c3 74 17 01 00    	add    $0x11774,%ebx
  102892:	8b 7c 24 10          	mov    0x10(%esp),%edi
    uint16_t *wrv;

    // "The BSP must initialize CMOS shutdown code to 0AH
    // and the warm reset vector (DWORD based at 40:67) to point at
    // the AP startup code prior to the [universal startup algorithm]."
    outb(IO_RTC, 0xF);                      // offset 0xF is shutdown code
  102896:	83 ec 08             	sub    $0x8,%esp
    wrv[0] = 0;
    wrv[1] = addr >> 4;

    // "Universal startup algorithm."
    // Send INIT (level-triggered) interrupt to reset other CPU.
    lapic_write(LAPIC_ICRHI, apicid << 24);
  102899:	c1 e7 18             	shl    $0x18,%edi
    outb(IO_RTC, 0xF);                      // offset 0xF is shutdown code
  10289c:	6a 0f                	push   $0xf
  10289e:	6a 70                	push   $0x70
  1028a0:	e8 ab 2c 00 00       	call   105550 <outb>
    outb(IO_RTC + 1, 0x0A);
  1028a5:	58                   	pop    %eax
  1028a6:	5a                   	pop    %edx
  1028a7:	6a 0a                	push   $0xa
  1028a9:	6a 71                	push   $0x71
  1028ab:	e8 a0 2c 00 00       	call   105550 <outb>
    wrv[1] = addr >> 4;
  1028b0:	89 f0                	mov    %esi,%eax
    // when it is in the halted state due to an INIT. So the second
    // should be ignored, but it is part of the official Intel algorithm.
    // Bochs complains about the second one. Too bad for Bochs.
    for (i = 0; i < 2; i++) {
        lapic_write(LAPIC_ICRHI, apicid << 24);
        lapic_write(LAPIC_ICRLO, LAPIC_ICRLO_STARTUP | (addr >> 12));
  1028b2:	c1 ee 0c             	shr    $0xc,%esi
        microdelay(200);
    }
}
  1028b5:	83 c4 10             	add    $0x10,%esp
    wrv[1] = addr >> 4;
  1028b8:	c1 e8 04             	shr    $0x4,%eax
        lapic_write(LAPIC_ICRLO, LAPIC_ICRLO_STARTUP | (addr >> 12));
  1028bb:	81 ce 00 06 00 00    	or     $0x600,%esi
    wrv[0] = 0;
  1028c1:	31 c9                	xor    %ecx,%ecx
    wrv[1] = addr >> 4;
  1028c3:	66 a3 69 04 00 00    	mov    %ax,0x469
    lapic[index] = value;
  1028c9:	8b 83 90 b8 03 00    	mov    0x3b890(%ebx),%eax
    wrv[0] = 0;
  1028cf:	66 89 0d 67 04 00 00 	mov    %cx,0x467
    lapic[index] = value;
  1028d6:	89 b8 10 03 00 00    	mov    %edi,0x310(%eax)
    lapic[LAPIC_ID];
  1028dc:	8b 48 20             	mov    0x20(%eax),%ecx
    lapic[index] = value;
  1028df:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
  1028e6:	c5 00 00 
    lapic[LAPIC_ID];
  1028e9:	8b 48 20             	mov    0x20(%eax),%ecx
    lapic[index] = value;
  1028ec:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
  1028f3:	85 00 00 
    lapic[LAPIC_ID];
  1028f6:	8b 48 20             	mov    0x20(%eax),%ecx
    lapic[index] = value;
  1028f9:	89 b8 10 03 00 00    	mov    %edi,0x310(%eax)
    lapic[LAPIC_ID];
  1028ff:	8b 48 20             	mov    0x20(%eax),%ecx
    lapic[index] = value;
  102902:	89 b0 00 03 00 00    	mov    %esi,0x300(%eax)
    lapic[LAPIC_ID];
  102908:	8b 48 20             	mov    0x20(%eax),%ecx
    lapic[index] = value;
  10290b:	89 b8 10 03 00 00    	mov    %edi,0x310(%eax)
    lapic[LAPIC_ID];
  102911:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102914:	89 b0 00 03 00 00    	mov    %esi,0x300(%eax)
}
  10291a:	5b                   	pop    %ebx
    lapic[LAPIC_ID];
  10291b:	8b 40 20             	mov    0x20(%eax),%eax
}
  10291e:	5e                   	pop    %esi
  10291f:	5f                   	pop    %edi
  102920:	c3                   	ret    
  102921:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102928:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10292f:	90                   	nop

00102930 <lapic_read_debug>:
    return lapic[index];
  102930:	e8 4c da ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  102935:	05 cb 16 01 00       	add    $0x116cb,%eax
  10293a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10293e:	8b 80 90 b8 03 00    	mov    0x3b890(%eax),%eax
  102944:	8d 04 90             	lea    (%eax,%edx,4),%eax
  102947:	8b 00                	mov    (%eax),%eax

uint32_t lapic_read_debug(int index)
{
    return lapic_read(index);
}
  102949:	c3                   	ret    
  10294a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102950 <lapic_send_ipi>:
/*
 * Send an IPI.
 */
void lapic_send_ipi(lapicid_t apicid, uint8_t vector,
                    uint32_t deliver_mode, uint32_t shorthand_mode)
{
  102950:	55                   	push   %ebp
  102951:	57                   	push   %edi
  102952:	56                   	push   %esi
  102953:	53                   	push   %ebx
  102954:	e8 30 da ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102959:	81 c3 a7 16 01 00    	add    $0x116a7,%ebx
  10295f:	83 ec 0c             	sub    $0xc,%esp
    KERN_ASSERT(deliver_mode != LAPIC_ICRLO_INIT &&
  102962:	8b 44 24 28          	mov    0x28(%esp),%eax
{
  102966:	8b 6c 24 20          	mov    0x20(%esp),%ebp
  10296a:	8b 74 24 24          	mov    0x24(%esp),%esi
  10296e:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
    KERN_ASSERT(deliver_mode != LAPIC_ICRLO_INIT &&
  102972:	2d 00 05 00 00       	sub    $0x500,%eax
  102977:	a9 ff fe ff ff       	test   $0xfffffeff,%eax
  10297c:	74 5a                	je     1029d8 <lapic_send_ipi+0x88>
                deliver_mode != LAPIC_ICRLO_STARTUP);
    KERN_ASSERT(vector >= T_IPI0);
  10297e:	89 f0                	mov    %esi,%eax
  102980:	3c 3e                	cmp    $0x3e,%al
  102982:	77 11                	ja     102995 <lapic_send_ipi+0x45>
  102984:	eb 7a                	jmp    102a00 <lapic_send_ipi+0xb0>
  102986:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10298d:	8d 76 00             	lea    0x0(%esi),%esi

    while (lapic_read(LAPIC_ICRLO) & LAPIC_ICRLO_DELIVS)
        pause();
  102990:	e8 eb 29 00 00       	call   105380 <pause>
    return lapic[index];
  102995:	8b 83 90 b8 03 00    	mov    0x3b890(%ebx),%eax
  10299b:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
    while (lapic_read(LAPIC_ICRLO) & LAPIC_ICRLO_DELIVS)
  1029a1:	80 e6 10             	and    $0x10,%dh
  1029a4:	75 ea                	jne    102990 <lapic_send_ipi+0x40>

    if (shorthand_mode == LAPIC_ICRLO_NOBCAST)
  1029a6:	85 ff                	test   %edi,%edi
  1029a8:	75 0c                	jne    1029b6 <lapic_send_ipi+0x66>
        lapic_write(LAPIC_ICRHI,
  1029aa:	c1 e5 18             	shl    $0x18,%ebp
    lapic[index] = value;
  1029ad:	89 a8 10 03 00 00    	mov    %ebp,0x310(%eax)
    lapic[LAPIC_ID];
  1029b3:	8b 50 20             	mov    0x20(%eax),%edx
                    (apicid << LAPIC_ICRHI_DEST_SHIFT) & LAPIC_ICRHI_DEST_MASK);

    lapic_write(LAPIC_ICRLO,
                shorthand_mode |  /* LAPIC_ICRLO_LEVEL | */
                deliver_mode | (vector & LAPIC_ICRLO_VECTOR));
  1029b6:	89 f1                	mov    %esi,%ecx
  1029b8:	0f b6 f1             	movzbl %cl,%esi
  1029bb:	09 fe                	or     %edi,%esi
  1029bd:	0b 74 24 28          	or     0x28(%esp),%esi
    lapic[index] = value;
  1029c1:	89 b0 00 03 00 00    	mov    %esi,0x300(%eax)
    lapic[LAPIC_ID];
  1029c7:	8b 40 20             	mov    0x20(%eax),%eax
}
  1029ca:	83 c4 0c             	add    $0xc,%esp
  1029cd:	5b                   	pop    %ebx
  1029ce:	5e                   	pop    %esi
  1029cf:	5f                   	pop    %edi
  1029d0:	5d                   	pop    %ebp
  1029d1:	c3                   	ret    
  1029d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    KERN_ASSERT(deliver_mode != LAPIC_ICRLO_INIT &&
  1029d8:	8d 83 74 76 ff ff    	lea    -0x898c(%ebx),%eax
  1029de:	50                   	push   %eax
  1029df:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  1029e5:	50                   	push   %eax
  1029e6:	8d 83 96 75 ff ff    	lea    -0x8a6a(%ebx),%eax
  1029ec:	68 e4 00 00 00       	push   $0xe4
  1029f1:	50                   	push   %eax
  1029f2:	e8 19 1d 00 00       	call   104710 <debug_panic>
    KERN_ASSERT(vector >= T_IPI0);
  1029f7:	89 f0                	mov    %esi,%eax
    KERN_ASSERT(deliver_mode != LAPIC_ICRLO_INIT &&
  1029f9:	83 c4 10             	add    $0x10,%esp
    KERN_ASSERT(vector >= T_IPI0);
  1029fc:	3c 3e                	cmp    $0x3e,%al
  1029fe:	77 95                	ja     102995 <lapic_send_ipi+0x45>
  102a00:	8d 83 da 75 ff ff    	lea    -0x8a26(%ebx),%eax
  102a06:	50                   	push   %eax
  102a07:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  102a0d:	50                   	push   %eax
  102a0e:	8d 83 96 75 ff ff    	lea    -0x8a6a(%ebx),%eax
  102a14:	68 e6 00 00 00       	push   $0xe6
  102a19:	50                   	push   %eax
  102a1a:	e8 f1 1c 00 00       	call   104710 <debug_panic>
  102a1f:	83 c4 10             	add    $0x10,%esp
    return lapic[index];
  102a22:	e9 6e ff ff ff       	jmp    102995 <lapic_send_ipi+0x45>
  102a27:	66 90                	xchg   %ax,%ax
  102a29:	66 90                	xchg   %ax,%ax
  102a2b:	66 90                	xchg   %ax,%ax
  102a2d:	66 90                	xchg   %ax,%ax
  102a2f:	90                   	nop

00102a30 <ioapic_register>:
    base->reg = reg;
    base->data = data;
}

void ioapic_register(uintptr_t addr, lapicid_t id, int g)
{
  102a30:	53                   	push   %ebx
  102a31:	e8 53 d9 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102a36:	81 c3 ca 15 01 00    	add    $0x115ca,%ebx
  102a3c:	83 ec 08             	sub    $0x8,%esp
  102a3f:	8b 54 24 14          	mov    0x14(%esp),%edx
    if (ioapic_num >= MAX_IOAPIC) {
  102a43:	8b 83 a0 b8 03 00    	mov    0x3b8a0(%ebx),%eax
  102a49:	83 f8 0f             	cmp    $0xf,%eax
  102a4c:	7f 4a                	jg     102a98 <ioapic_register+0x68>
        KERN_WARN("CertiKOS cannot manipulate more than %d IOAPICs.\n", MAX_IOAPIC);
        return;
    }

    ioapics[ioapic_num] = (ioapic_t *) addr;
  102a4e:	8b 83 a0 b8 03 00    	mov    0x3b8a0(%ebx),%eax
  102a54:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  102a58:	89 8c 83 20 b9 03 00 	mov    %ecx,0x3b920(%ebx,%eax,4)
    ioapicid[ioapic_num] = id;
  102a5f:	8b 83 a0 b8 03 00    	mov    0x3b8a0(%ebx),%eax
    gsi[ioapic_num] = g;
  102a65:	8b 4c 24 18          	mov    0x18(%esp),%ecx
    ioapicid[ioapic_num] = id;
  102a69:	88 94 03 00 b9 03 00 	mov    %dl,0x3b900(%ebx,%eax,1)
    gsi[ioapic_num] = g;
  102a70:	8b 93 a0 b8 03 00    	mov    0x3b8a0(%ebx),%edx
  102a76:	8d 83 c0 b8 03 00    	lea    0x3b8c0(%ebx),%eax
  102a7c:	89 0c 90             	mov    %ecx,(%eax,%edx,4)

    ioapic_num++;
  102a7f:	8b 83 a0 b8 03 00    	mov    0x3b8a0(%ebx),%eax
  102a85:	83 c0 01             	add    $0x1,%eax
  102a88:	89 83 a0 b8 03 00    	mov    %eax,0x3b8a0(%ebx)
}
  102a8e:	83 c4 08             	add    $0x8,%esp
  102a91:	5b                   	pop    %ebx
  102a92:	c3                   	ret    
  102a93:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102a97:	90                   	nop
        KERN_WARN("CertiKOS cannot manipulate more than %d IOAPICs.\n", MAX_IOAPIC);
  102a98:	8d 83 bc 76 ff ff    	lea    -0x8944(%ebx),%eax
  102a9e:	6a 10                	push   $0x10
  102aa0:	50                   	push   %eax
  102aa1:	8d 83 35 77 ff ff    	lea    -0x88cb(%ebx),%eax
  102aa7:	6a 1f                	push   $0x1f
  102aa9:	50                   	push   %eax
  102aaa:	e8 51 1d 00 00       	call   104800 <debug_warn>
        return;
  102aaf:	83 c4 10             	add    $0x10,%esp
}
  102ab2:	83 c4 08             	add    $0x8,%esp
  102ab5:	5b                   	pop    %ebx
  102ab6:	c3                   	ret    
  102ab7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102abe:	66 90                	xchg   %ax,%ax

00102ac0 <ioapic_init>:

void ioapic_init(void)
{
  102ac0:	55                   	push   %ebp
  102ac1:	57                   	push   %edi
  102ac2:	56                   	push   %esi
  102ac3:	53                   	push   %ebx
  102ac4:	e8 c0 d8 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102ac9:	81 c3 37 15 01 00    	add    $0x11537,%ebx
  102acf:	83 ec 1c             	sub    $0x1c,%esp
    int i;
    for (i = 0; i < ioapic_num; i++) {
  102ad2:	8b 83 a0 b8 03 00    	mov    0x3b8a0(%ebx),%eax
  102ad8:	89 1c 24             	mov    %ebx,(%esp)
  102adb:	85 c0                	test   %eax,%eax
  102add:	0f 8e e7 00 00 00    	jle    102bca <ioapic_init+0x10a>
  102ae3:	89 d8                	mov    %ebx,%eax
  102ae5:	8d 9b 00 b9 03 00    	lea    0x3b900(%ebx),%ebx
  102aeb:	31 ff                	xor    %edi,%edi
  102aed:	89 5c 24 04          	mov    %ebx,0x4(%esp)
        volatile ioapic_t *ioapic = ioapics[i];
        KERN_ASSERT(ioapic != NULL);
  102af1:	8d 98 47 77 ff ff    	lea    -0x88b9(%eax),%ebx
  102af7:	8d 80 bf 72 ff ff    	lea    -0x8d41(%eax),%eax
  102afd:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  102b01:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102b05:	8d 76 00             	lea    0x0(%esi),%esi
        volatile ioapic_t *ioapic = ioapics[i];
  102b08:	8b 04 24             	mov    (%esp),%eax
  102b0b:	8b b4 b8 20 b9 03 00 	mov    0x3b920(%eax,%edi,4),%esi
        KERN_ASSERT(ioapic != NULL);
  102b12:	85 f6                	test   %esi,%esi
  102b14:	0f 84 be 00 00 00    	je     102bd8 <ioapic_init+0x118>
    base->reg = reg;
  102b1a:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
    return base->data;
  102b20:	8b 46 10             	mov    0x10(%esi),%eax

        lapicid_t id = ioapic_read(ioapic, IOAPIC_ID) >> 24;
        if (id == 0) {
  102b23:	c1 e8 18             	shr    $0x18,%eax
  102b26:	75 18                	jne    102b40 <ioapic_init+0x80>
            // I/O APIC ID not initialized yet - have to do it ourselves.
            ioapic_write(ioapic, IOAPIC_ID, ioapicid[i] << 24);
  102b28:	8b 5c 24 04          	mov    0x4(%esp),%ebx
  102b2c:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
    base->reg = reg;
  102b30:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
            ioapic_write(ioapic, IOAPIC_ID, ioapicid[i] << 24);
  102b36:	c1 e0 18             	shl    $0x18,%eax
    base->data = data;
  102b39:	89 46 10             	mov    %eax,0x10(%esi)
            id = ioapicid[i];
  102b3c:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
        }

        if (id != ioapicid[i])
  102b40:	8b 5c 24 04          	mov    0x4(%esp),%ebx
  102b44:	0f b6 14 3b          	movzbl (%ebx,%edi,1),%edx
  102b48:	38 c2                	cmp    %al,%dl
  102b4a:	74 28                	je     102b74 <ioapic_init+0xb4>
            KERN_WARN("ioapic_init: id %d != ioapicid %d\n", id, ioapicid[i]);
  102b4c:	0f b6 14 3b          	movzbl (%ebx,%edi,1),%edx
  102b50:	83 ec 0c             	sub    $0xc,%esp
  102b53:	0f b6 c0             	movzbl %al,%eax
  102b56:	52                   	push   %edx
  102b57:	50                   	push   %eax
  102b58:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  102b5c:	8d 83 f0 76 ff ff    	lea    -0x8910(%ebx),%eax
  102b62:	50                   	push   %eax
  102b63:	8d 83 35 77 ff ff    	lea    -0x88cb(%ebx),%eax
  102b69:	6a 39                	push   $0x39
  102b6b:	50                   	push   %eax
  102b6c:	e8 8f 1c 00 00       	call   104800 <debug_warn>
  102b71:	83 c4 20             	add    $0x20,%esp
    base->reg = reg;
  102b74:	c7 06 01 00 00 00    	movl   $0x1,(%esi)
    return base->data;
  102b7a:	8b 6e 10             	mov    0x10(%esi),%ebp

        int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;
  102b7d:	c1 ed 10             	shr    $0x10,%ebp
  102b80:	89 e8                	mov    %ebp,%eax
  102b82:	0f b6 e8             	movzbl %al,%ebp
  102b85:	b8 20 00 00 00       	mov    $0x20,%eax
  102b8a:	83 c5 21             	add    $0x21,%ebp
  102b8d:	8d 76 00             	lea    0x0(%esi),%esi

        // Mark all interrupts edge-triggered, active high, disabled,
        // and not routed to any CPUs.
        int j;
        for (j = 0; j <= maxintr; j++) {
            ioapic_write(ioapic, IOAPIC_TABLE + 2 * j,
  102b90:	8d 14 00             	lea    (%eax,%eax,1),%edx
                         IOAPIC_INT_DISABLED | (T_IRQ0 + j));
  102b93:	89 c1                	mov    %eax,%ecx
        for (j = 0; j <= maxintr; j++) {
  102b95:	83 c0 01             	add    $0x1,%eax
  102b98:	8d 5a d0             	lea    -0x30(%edx),%ebx
                         IOAPIC_INT_DISABLED | (T_IRQ0 + j));
  102b9b:	81 c9 00 00 01 00    	or     $0x10000,%ecx
    base->reg = reg;
  102ba1:	83 ea 2f             	sub    $0x2f,%edx
  102ba4:	89 1e                	mov    %ebx,(%esi)
    base->data = data;
  102ba6:	89 4e 10             	mov    %ecx,0x10(%esi)
    base->reg = reg;
  102ba9:	89 16                	mov    %edx,(%esi)
    base->data = data;
  102bab:	c7 46 10 00 00 00 00 	movl   $0x0,0x10(%esi)
        for (j = 0; j <= maxintr; j++) {
  102bb2:	39 c5                	cmp    %eax,%ebp
  102bb4:	75 da                	jne    102b90 <ioapic_init+0xd0>
    for (i = 0; i < ioapic_num; i++) {
  102bb6:	8b 04 24             	mov    (%esp),%eax
  102bb9:	83 c7 01             	add    $0x1,%edi
  102bbc:	8b 80 a0 b8 03 00    	mov    0x3b8a0(%eax),%eax
  102bc2:	39 f8                	cmp    %edi,%eax
  102bc4:	0f 8f 3e ff ff ff    	jg     102b08 <ioapic_init+0x48>
            ioapic_write(ioapic, IOAPIC_TABLE + 2 * j + 1, 0);
        }
    }
}
  102bca:	83 c4 1c             	add    $0x1c,%esp
  102bcd:	5b                   	pop    %ebx
  102bce:	5e                   	pop    %esi
  102bcf:	5f                   	pop    %edi
  102bd0:	5d                   	pop    %ebp
  102bd1:	c3                   	ret    
  102bd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        KERN_ASSERT(ioapic != NULL);
  102bd8:	ff 74 24 08          	push   0x8(%esp)
  102bdc:	ff 74 24 10          	push   0x10(%esp)
  102be0:	6a 2f                	push   $0x2f
  102be2:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  102be6:	8d 83 35 77 ff ff    	lea    -0x88cb(%ebx),%eax
  102bec:	50                   	push   %eax
  102bed:	e8 1e 1b 00 00       	call   104710 <debug_panic>
  102bf2:	83 c4 10             	add    $0x10,%esp
  102bf5:	e9 20 ff ff ff       	jmp    102b1a <ioapic_init+0x5a>
  102bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102c00 <ioapic_enable>:

void ioapic_enable(uint8_t irq, lapicid_t apicid, bool trigger_mode, bool polarity)
{
  102c00:	55                   	push   %ebp
  102c01:	57                   	push   %edi
  102c02:	56                   	push   %esi
  102c03:	53                   	push   %ebx
  102c04:	e8 80 d7 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102c09:	81 c3 f7 13 01 00    	add    $0x113f7,%ebx
  102c0f:	83 ec 2c             	sub    $0x2c,%esp
  102c12:	8b 44 24 44          	mov    0x44(%esp),%eax
  102c16:	8b 4c 24 40          	mov    0x40(%esp),%ecx
  102c1a:	89 44 24 10          	mov    %eax,0x10(%esp)
  102c1e:	8b 44 24 48          	mov    0x48(%esp),%eax
  102c22:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
  102c26:	89 44 24 14          	mov    %eax,0x14(%esp)
  102c2a:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  102c2e:	89 44 24 18          	mov    %eax,0x18(%esp)
    // Mark interrupt edge-triggered, active high,
    // enabled, and routed to the given APIC ID,
    int i;
    for (i = 0; i < ioapic_num; i++) {
  102c32:	8b 83 a0 b8 03 00    	mov    0x3b8a0(%ebx),%eax
  102c38:	85 c0                	test   %eax,%eax
  102c3a:	0f 8e d8 00 00 00    	jle    102d18 <ioapic_enable+0x118>
            break;
        }
    }

    if (i == ioapic_num)
        KERN_PANIC("Cannot enable IRQ %d on IOAPIC.\n", irq);
  102c40:	0f b6 c9             	movzbl %cl,%ecx
    for (i = 0; i < ioapic_num; i++) {
  102c43:	31 c0                	xor    %eax,%eax
  102c45:	8d b3 c0 b8 03 00    	lea    0x3b8c0(%ebx),%esi
  102c4b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  102c4f:	90                   	nop
        ioapic_t *ioapic = ioapics[i];
  102c50:	8b 94 83 20 b9 03 00 	mov    0x3b920(%ebx,%eax,4),%edx
    base->reg = reg;
  102c57:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
    return base->data;
  102c5d:	8b 7a 10             	mov    0x10(%edx),%edi
        if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
  102c60:	8b 2c 86             	mov    (%esi,%eax,4),%ebp
  102c63:	3b 6c 24 0c          	cmp    0xc(%esp),%ebp
  102c67:	7f 13                	jg     102c7c <ioapic_enable+0x7c>
        int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;
  102c69:	c1 ef 10             	shr    $0x10,%edi
        if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
  102c6c:	8b 2c 86             	mov    (%esi,%eax,4),%ebp
        int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;
  102c6f:	89 f9                	mov    %edi,%ecx
  102c71:	0f b6 f9             	movzbl %cl,%edi
        if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
  102c74:	01 ef                	add    %ebp,%edi
  102c76:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  102c7a:	7d 24                	jge    102ca0 <ioapic_enable+0xa0>
    for (i = 0; i < ioapic_num; i++) {
  102c7c:	8b 93 a0 b8 03 00    	mov    0x3b8a0(%ebx),%edx
  102c82:	83 c0 01             	add    $0x1,%eax
  102c85:	39 c2                	cmp    %eax,%edx
  102c87:	7f c7                	jg     102c50 <ioapic_enable+0x50>
    if (i == ioapic_num)
  102c89:	8b 93 a0 b8 03 00    	mov    0x3b8a0(%ebx),%edx
  102c8f:	39 c2                	cmp    %eax,%edx
  102c91:	74 5f                	je     102cf2 <ioapic_enable+0xf2>
}
  102c93:	83 c4 2c             	add    $0x2c,%esp
  102c96:	5b                   	pop    %ebx
  102c97:	5e                   	pop    %esi
  102c98:	5f                   	pop    %edi
  102c99:	5d                   	pop    %ebp
  102c9a:	c3                   	ret    
  102c9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102c9f:	90                   	nop
                         ((trigger_mode << 15) | (polarity << 13) | (T_IRQ0 + irq)));
  102ca0:	0f b6 6c 24 14       	movzbl 0x14(%esp),%ebp
  102ca5:	0f b6 7c 24 18       	movzbl 0x18(%esp),%edi
  102caa:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  102cae:	c1 e5 0f             	shl    $0xf,%ebp
  102cb1:	c1 e7 0d             	shl    $0xd,%edi
  102cb4:	09 ef                	or     %ebp,%edi
  102cb6:	8d 69 20             	lea    0x20(%ecx),%ebp
  102cb9:	09 fd                	or     %edi,%ebp
                         IOAPIC_TABLE + 2 * (irq - gsi[i]),
  102cbb:	8b 3c 86             	mov    (%esi,%eax,4),%edi
                         ((trigger_mode << 15) | (polarity << 13) | (T_IRQ0 + irq)));
  102cbe:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
                         IOAPIC_TABLE + 2 * (irq - gsi[i]),
  102cc2:	89 cd                	mov    %ecx,%ebp
  102cc4:	29 fd                	sub    %edi,%ebp
            ioapic_write(ioapic,
  102cc6:	8d 7c 2d 10          	lea    0x10(%ebp,%ebp,1),%edi
    base->reg = reg;
  102cca:	89 3a                	mov    %edi,(%edx)
    base->data = data;
  102ccc:	8b 7c 24 0c          	mov    0xc(%esp),%edi
  102cd0:	89 7a 10             	mov    %edi,0x10(%edx)
                         IOAPIC_TABLE + 2 * (irq - gsi[i]) + 1,
  102cd3:	8b 34 86             	mov    (%esi,%eax,4),%esi
                         apicid << 24);
  102cd6:	8b 7c 24 10          	mov    0x10(%esp),%edi
                         IOAPIC_TABLE + 2 * (irq - gsi[i]) + 1,
  102cda:	29 f1                	sub    %esi,%ecx
                         apicid << 24);
  102cdc:	c1 e7 18             	shl    $0x18,%edi
            ioapic_write(ioapic,
  102cdf:	8d 4c 09 11          	lea    0x11(%ecx,%ecx,1),%ecx
    base->reg = reg;
  102ce3:	89 0a                	mov    %ecx,(%edx)
    base->data = data;
  102ce5:	89 7a 10             	mov    %edi,0x10(%edx)
    if (i == ioapic_num)
  102ce8:	8b 93 a0 b8 03 00    	mov    0x3b8a0(%ebx),%edx
  102cee:	39 c2                	cmp    %eax,%edx
  102cf0:	75 a1                	jne    102c93 <ioapic_enable+0x93>
        KERN_PANIC("Cannot enable IRQ %d on IOAPIC.\n", irq);
  102cf2:	0f b6 44 24 1c       	movzbl 0x1c(%esp),%eax
  102cf7:	50                   	push   %eax
  102cf8:	8d 83 14 77 ff ff    	lea    -0x88ec(%ebx),%eax
  102cfe:	50                   	push   %eax
  102cff:	8d 83 35 77 ff ff    	lea    -0x88cb(%ebx),%eax
  102d05:	6a 5d                	push   $0x5d
  102d07:	50                   	push   %eax
  102d08:	e8 03 1a 00 00       	call   104710 <debug_panic>
  102d0d:	83 c4 10             	add    $0x10,%esp
}
  102d10:	83 c4 2c             	add    $0x2c,%esp
  102d13:	5b                   	pop    %ebx
  102d14:	5e                   	pop    %esi
  102d15:	5f                   	pop    %edi
  102d16:	5d                   	pop    %ebp
  102d17:	c3                   	ret    
    for (i = 0; i < ioapic_num; i++) {
  102d18:	31 c0                	xor    %eax,%eax
  102d1a:	e9 6a ff ff ff       	jmp    102c89 <ioapic_enable+0x89>
  102d1f:	90                   	nop

00102d20 <ioapic_number>:

int ioapic_number(void)
{
    return ioapic_num;
  102d20:	e8 5c d6 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  102d25:	05 db 12 01 00       	add    $0x112db,%eax
  102d2a:	8b 80 a0 b8 03 00    	mov    0x3b8a0(%eax),%eax
}
  102d30:	c3                   	ret    
  102d31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102d38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102d3f:	90                   	nop

00102d40 <ioapic_get>:

ioapic_t *ioapic_get(uint32_t idx)
{
    if (idx >= ioapic_num)
  102d40:	e8 3c d6 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  102d45:	05 bb 12 01 00       	add    $0x112bb,%eax
{
  102d4a:	8b 54 24 04          	mov    0x4(%esp),%edx
    if (idx >= ioapic_num)
  102d4e:	8b 88 a0 b8 03 00    	mov    0x3b8a0(%eax),%ecx
  102d54:	39 d1                	cmp    %edx,%ecx
  102d56:	76 08                	jbe    102d60 <ioapic_get+0x20>
        return NULL;
    return ioapics[idx];
  102d58:	8b 84 90 20 b9 03 00 	mov    0x3b920(%eax,%edx,4),%eax
  102d5f:	c3                   	ret    
        return NULL;
  102d60:	31 c0                	xor    %eax,%eax
}
  102d62:	c3                   	ret    
  102d63:	66 90                	xchg   %ax,%ax
  102d65:	66 90                	xchg   %ax,%ax
  102d67:	66 90                	xchg   %ax,%ax
  102d69:	66 90                	xchg   %ax,%ax
  102d6b:	66 90                	xchg   %ax,%ax
  102d6d:	66 90                	xchg   %ax,%ax
  102d6f:	90                   	nop

00102d70 <mpsearch1>:
    return sum;
}

/* Look for an MP structure in the len bytes at addr. */
static struct mp *mpsearch1(uint8_t *addr, int len)
{
  102d70:	55                   	push   %ebp
  102d71:	57                   	push   %edi
  102d72:	56                   	push   %esi
  102d73:	89 c6                	mov    %eax,%esi
    uint8_t *e, *p;

    e = addr + len;
  102d75:	01 d0                	add    %edx,%eax
{
  102d77:	53                   	push   %ebx
  102d78:	e8 0c d6 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102d7d:	81 c3 83 12 01 00    	add    $0x11283,%ebx
  102d83:	83 ec 1c             	sub    $0x1c,%esp
    e = addr + len;
  102d86:	89 44 24 0c          	mov    %eax,0xc(%esp)
    for (p = addr; p < e; p += sizeof(struct mp))
  102d8a:	39 c6                	cmp    %eax,%esi
  102d8c:	73 5a                	jae    102de8 <mpsearch1+0x78>
  102d8e:	8d bb 56 77 ff ff    	lea    -0x88aa(%ebx),%edi
  102d94:	eb 12                	jmp    102da8 <mpsearch1+0x38>
  102d96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102d9d:	8d 76 00             	lea    0x0(%esi),%esi
  102da0:	89 ee                	mov    %ebp,%esi
  102da2:	39 6c 24 0c          	cmp    %ebp,0xc(%esp)
  102da6:	76 40                	jbe    102de8 <mpsearch1+0x78>
        if (memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102da8:	83 ec 04             	sub    $0x4,%esp
  102dab:	8d 6e 10             	lea    0x10(%esi),%ebp
  102dae:	6a 04                	push   $0x4
  102db0:	57                   	push   %edi
  102db1:	56                   	push   %esi
  102db2:	e8 a9 17 00 00       	call   104560 <memcmp>
  102db7:	83 c4 10             	add    $0x10,%esp
  102dba:	89 c2                	mov    %eax,%edx
  102dbc:	85 c0                	test   %eax,%eax
  102dbe:	75 e0                	jne    102da0 <mpsearch1+0x30>
  102dc0:	89 f0                	mov    %esi,%eax
  102dc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        sum += addr[i];
  102dc8:	0f b6 08             	movzbl (%eax),%ecx
    for (i = 0; i < len; i++)
  102dcb:	83 c0 01             	add    $0x1,%eax
        sum += addr[i];
  102dce:	01 ca                	add    %ecx,%edx
    for (i = 0; i < len; i++)
  102dd0:	39 e8                	cmp    %ebp,%eax
  102dd2:	75 f4                	jne    102dc8 <mpsearch1+0x58>
        if (memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102dd4:	84 d2                	test   %dl,%dl
  102dd6:	75 c8                	jne    102da0 <mpsearch1+0x30>
            return (struct mp *) p;
    return 0;
}
  102dd8:	83 c4 1c             	add    $0x1c,%esp
  102ddb:	89 f0                	mov    %esi,%eax
  102ddd:	5b                   	pop    %ebx
  102dde:	5e                   	pop    %esi
  102ddf:	5f                   	pop    %edi
  102de0:	5d                   	pop    %ebp
  102de1:	c3                   	ret    
  102de2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102de8:	83 c4 1c             	add    $0x1c,%esp
    return 0;
  102deb:	31 c0                	xor    %eax,%eax
}
  102ded:	5b                   	pop    %ebx
  102dee:	5e                   	pop    %esi
  102def:	5f                   	pop    %edi
  102df0:	5d                   	pop    %ebp
  102df1:	c3                   	ret    
  102df2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102e00 <pcpu_mp_init>:

/*
 * Multiple processors initialization method using ACPI
 */
bool pcpu_mp_init(void)
{
  102e00:	55                   	push   %ebp
  102e01:	57                   	push   %edi
  102e02:	56                   	push   %esi
  102e03:	53                   	push   %ebx
  102e04:	e8 80 d5 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102e09:	81 c3 f7 11 01 00    	add    $0x111f7,%ebx
  102e0f:	83 ec 2c             	sub    $0x2c,%esp
    acpi_xsdt_t *xsdt;
    acpi_madt_t *madt;
    uint32_t ap_idx = 1;
    bool found_bsp = FALSE;

    if (mp_inited == TRUE)
  102e12:	80 bb 61 b9 03 00 01 	cmpb   $0x1,0x3b961(%ebx)
  102e19:	0f 84 8a 01 00 00    	je     102fa9 <pcpu_mp_init+0x1a9>
        return TRUE;

    KERN_INFO("\n");
  102e1f:	83 ec 0c             	sub    $0xc,%esp
  102e22:	8d 83 35 87 ff ff    	lea    -0x78cb(%ebx),%eax
  102e28:	50                   	push   %eax
  102e29:	e8 42 18 00 00       	call   104670 <debug_info>

    if ((rsdp = acpi_probe_rsdp()) == NULL) {
  102e2e:	e8 ed f3 ff ff       	call   102220 <acpi_probe_rsdp>
  102e33:	83 c4 10             	add    $0x10,%esp
  102e36:	89 c6                	mov    %eax,%esi
  102e38:	85 c0                	test   %eax,%eax
  102e3a:	0f 84 90 02 00 00    	je     1030d0 <pcpu_mp_init+0x2d0>
        KERN_DEBUG("Not found RSDP.\n");
        goto fallback;
    }

    xsdt = NULL;
    if ((xsdt = acpi_probe_xsdt(rsdp)) == NULL &&
  102e40:	83 ec 0c             	sub    $0xc,%esp
  102e43:	50                   	push   %eax
  102e44:	e8 c7 f5 ff ff       	call   102410 <acpi_probe_xsdt>
  102e49:	83 c4 10             	add    $0x10,%esp
  102e4c:	85 c0                	test   %eax,%eax
  102e4e:	0f 84 1c 02 00 00    	je     103070 <pcpu_mp_init+0x270>
        goto fallback;
    }

    if ((madt =
         (xsdt != NULL) ?
         (acpi_madt_t *) acpi_probe_xsdt_ent(xsdt, ACPI_MADT_SIG) :
  102e54:	83 ec 08             	sub    $0x8,%esp
  102e57:	68 41 50 49 43       	push   $0x43495041
  102e5c:	50                   	push   %eax
  102e5d:	e8 3e f6 ff ff       	call   1024a0 <acpi_probe_xsdt_ent>
  102e62:	83 c4 10             	add    $0x10,%esp
  102e65:	89 c7                	mov    %eax,%edi
    if ((madt =
  102e67:	85 ff                	test   %edi,%edi
  102e69:	0f 84 59 04 00 00    	je     1032c8 <pcpu_mp_init+0x4c8>
        KERN_DEBUG("Not found MADT.\n");
        goto fallback;
    }

    ismp = TRUE;
    lapic_register(madt->lapic_addr);
  102e6f:	83 ec 0c             	sub    $0xc,%esp
  102e72:	ff 77 24             	push   0x24(%edi)
    ncpu = 0;

    p = (uint8_t *) madt->ent;
  102e75:	8d 6f 2c             	lea    0x2c(%edi),%ebp
    ismp = TRUE;
  102e78:	c6 83 60 b9 03 00 01 	movb   $0x1,0x3b960(%ebx)
    lapic_register(madt->lapic_addr);
  102e7f:	e8 bc f6 ff ff       	call   102540 <lapic_register>
    e = (uint8_t *) madt + madt->length;
  102e84:	8b 77 04             	mov    0x4(%edi),%esi

    while (p < e) {
  102e87:	83 c4 10             	add    $0x10,%esp
    ncpu = 0;
  102e8a:	c7 83 64 b9 03 00 00 	movl   $0x0,0x3b964(%ebx)
  102e91:	00 00 00 
    e = (uint8_t *) madt + madt->length;
  102e94:	01 fe                	add    %edi,%esi
    while (p < e) {
  102e96:	39 f5                	cmp    %esi,%ebp
  102e98:	0f 83 99 00 00 00    	jae    102f37 <pcpu_mp_init+0x137>

            if (!(lapic_ent->flags & ACPI_APIC_ENABLED)) {
                break;
            }

            KERN_INFO("\tCPU%d: APIC id = %x, ", ncpu, lapic_ent->lapic_id);
  102e9e:	8d 83 90 77 ff ff    	lea    -0x8870(%ebx),%eax
    bool found_bsp = FALSE;
  102ea4:	31 c9                	xor    %ecx,%ecx
            if (!found_bsp) {
                found_bsp = TRUE;
                KERN_INFO("BSP\n");
                pcpu_mp_init_cpu(0, lapic_ent->lapic_id, TRUE);
            } else {
                KERN_INFO("AP\n");
  102ea6:	89 7c 24 14          	mov    %edi,0x14(%esp)
  102eaa:	89 ef                	mov    %ebp,%edi
            KERN_INFO("\tCPU%d: APIC id = %x, ", ncpu, lapic_ent->lapic_id);
  102eac:	89 44 24 10          	mov    %eax,0x10(%esp)
                KERN_INFO("AP\n");
  102eb0:	8d 83 ac 77 ff ff    	lea    -0x8854(%ebx),%eax
  102eb6:	89 cd                	mov    %ecx,%ebp
    uint32_t ap_idx = 1;
  102eb8:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
  102ebf:	00 
                KERN_INFO("AP\n");
  102ec0:	89 44 24 18          	mov    %eax,0x18(%esp)
  102ec4:	eb 27                	jmp    102eed <pcpu_mp_init+0xed>
  102ec6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102ecd:	8d 76 00             	lea    0x0(%esi),%esi

            ioapic_register(ioapic_ent->ioapic_addr, ioapic_ent->ioapic_id,
                            ioapic_ent->gsi);
            break;
        default:
            KERN_INFO("\tUnhandled ACPI entry (type=%x)\n", hdr->type);
  102ed0:	83 ec 08             	sub    $0x8,%esp
  102ed3:	50                   	push   %eax
  102ed4:	8d 83 60 78 ff ff    	lea    -0x87a0(%ebx),%eax
  102eda:	50                   	push   %eax
  102edb:	e8 90 17 00 00       	call   104670 <debug_info>
            break;
  102ee0:	83 c4 10             	add    $0x10,%esp
        }

        p += hdr->length;
  102ee3:	0f b6 47 01          	movzbl 0x1(%edi),%eax
  102ee7:	01 c7                	add    %eax,%edi
    while (p < e) {
  102ee9:	39 fe                	cmp    %edi,%esi
  102eeb:	76 46                	jbe    102f33 <pcpu_mp_init+0x133>
        switch (hdr->type) {
  102eed:	0f b6 07             	movzbl (%edi),%eax
  102ef0:	84 c0                	test   %al,%al
  102ef2:	0f 84 c8 00 00 00    	je     102fc0 <pcpu_mp_init+0x1c0>
  102ef8:	3c 01                	cmp    $0x1,%al
  102efa:	75 d4                	jne    102ed0 <pcpu_mp_init+0xd0>
            KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
  102efc:	83 ec 04             	sub    $0x4,%esp
  102eff:	ff 77 04             	push   0x4(%edi)
  102f02:	0f b6 47 02          	movzbl 0x2(%edi),%eax
  102f06:	50                   	push   %eax
  102f07:	8d 83 3c 78 ff ff    	lea    -0x87c4(%ebx),%eax
  102f0d:	50                   	push   %eax
  102f0e:	e8 5d 17 00 00       	call   104670 <debug_info>
            ioapic_register(ioapic_ent->ioapic_addr, ioapic_ent->ioapic_id,
  102f13:	83 c4 0c             	add    $0xc,%esp
  102f16:	ff 77 08             	push   0x8(%edi)
  102f19:	0f b6 47 02          	movzbl 0x2(%edi),%eax
  102f1d:	50                   	push   %eax
  102f1e:	ff 77 04             	push   0x4(%edi)
  102f21:	e8 0a fb ff ff       	call   102a30 <ioapic_register>
        p += hdr->length;
  102f26:	0f b6 47 01          	movzbl 0x1(%edi),%eax
            break;
  102f2a:	83 c4 10             	add    $0x10,%esp
        p += hdr->length;
  102f2d:	01 c7                	add    %eax,%edi
    while (p < e) {
  102f2f:	39 fe                	cmp    %edi,%esi
  102f31:	77 ba                	ja     102eed <pcpu_mp_init+0xed>
  102f33:	8b 7c 24 14          	mov    0x14(%esp),%edi
    /*
     * Force NMI and 8259 signals to APIC when PIC mode
     * is not implemented.
     *
     */
    if ((madt->flags & APIC_MADT_PCAT_COMPAT) == 0) {
  102f37:	f6 47 28 01          	testb  $0x1,0x28(%edi)
  102f3b:	0f 84 5f 01 00 00    	je     1030a0 <pcpu_mp_init+0x2a0>
    }

    /*
     * Copy AP boot code to 0x8000.
     */
    memmove((uint8_t *) 0x8000,
  102f41:	83 ec 04             	sub    $0x4,%esp
  102f44:	ff b3 e8 ff ff ff    	push   -0x18(%ebx)
  102f4a:	ff b3 fc ff ff ff    	push   -0x4(%ebx)
  102f50:	68 00 80 00 00       	push   $0x8000
  102f55:	e8 46 14 00 00       	call   1043a0 <memmove>
            _binary___obj_kern_init_boot_ap_start,
            (size_t) _binary___obj_kern_init_boot_ap_size);

    mp_inited = TRUE;
    return TRUE;
  102f5a:	83 c4 10             	add    $0x10,%esp
  102f5d:	b8 01 00 00 00       	mov    $0x1,%eax
    mp_inited = TRUE;
  102f62:	c6 83 61 b9 03 00 01 	movb   $0x1,0x3b961(%ebx)
        ismp = 0;
        ncpu = 1;
        return FALSE;
    } else
        return TRUE;
}
  102f69:	83 c4 2c             	add    $0x2c,%esp
  102f6c:	5b                   	pop    %ebx
  102f6d:	5e                   	pop    %esi
  102f6e:	5f                   	pop    %edi
  102f6f:	5d                   	pop    %ebp
  102f70:	c3                   	ret    
  102f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102f78:	8b 7c 24 18          	mov    0x18(%esp),%edi
    if (mp->imcrp) {
  102f7c:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
  102f80:	0f 85 51 04 00 00    	jne    1033d7 <pcpu_mp_init+0x5d7>
    memcpy((uint8_t *) 0x8000,
  102f86:	83 ec 04             	sub    $0x4,%esp
  102f89:	ff b3 e8 ff ff ff    	push   -0x18(%ebx)
  102f8f:	ff b3 fc ff ff ff    	push   -0x4(%ebx)
  102f95:	68 00 80 00 00       	push   $0x8000
  102f9a:	e8 71 14 00 00       	call   104410 <memcpy>
    mp_inited = TRUE;
  102f9f:	c6 83 61 b9 03 00 01 	movb   $0x1,0x3b961(%ebx)
  102fa6:	83 c4 10             	add    $0x10,%esp
}
  102fa9:	83 c4 2c             	add    $0x2c,%esp
        return TRUE;
  102fac:	b8 01 00 00 00       	mov    $0x1,%eax
}
  102fb1:	5b                   	pop    %ebx
  102fb2:	5e                   	pop    %esi
  102fb3:	5f                   	pop    %edi
  102fb4:	5d                   	pop    %ebp
  102fb5:	c3                   	ret    
  102fb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102fbd:	8d 76 00             	lea    0x0(%esi),%esi
            if (!(lapic_ent->flags & ACPI_APIC_ENABLED)) {
  102fc0:	f6 47 04 01          	testb  $0x1,0x4(%edi)
  102fc4:	0f 84 19 ff ff ff    	je     102ee3 <pcpu_mp_init+0xe3>
            KERN_INFO("\tCPU%d: APIC id = %x, ", ncpu, lapic_ent->lapic_id);
  102fca:	0f b6 47 03          	movzbl 0x3(%edi),%eax
  102fce:	83 ec 04             	sub    $0x4,%esp
  102fd1:	50                   	push   %eax
  102fd2:	ff b3 64 b9 03 00    	push   0x3b964(%ebx)
  102fd8:	ff 74 24 1c          	push   0x1c(%esp)
  102fdc:	e8 8f 16 00 00       	call   104670 <debug_info>
            if (!found_bsp) {
  102fe1:	89 e8                	mov    %ebp,%eax
  102fe3:	83 c4 10             	add    $0x10,%esp
  102fe6:	84 c0                	test   %al,%al
  102fe8:	74 4e                	je     103038 <pcpu_mp_init+0x238>
                KERN_INFO("AP\n");
  102fea:	83 ec 0c             	sub    $0xc,%esp
  102fed:	ff 74 24 24          	push   0x24(%esp)
  102ff1:	e8 7a 16 00 00       	call   104670 <debug_info>
    if (idx >= NUM_CPUS)
  102ff6:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  102ffa:	83 c4 10             	add    $0x10,%esp
  102ffd:	83 f8 07             	cmp    $0x7,%eax
  103000:	77 1b                	ja     10301d <pcpu_mp_init+0x21d>
    struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);
  103002:	83 ec 0c             	sub    $0xc,%esp
                pcpu_mp_init_cpu(ap_idx, lapic_ent->lapic_id, FALSE);
  103005:	0f b6 6f 03          	movzbl 0x3(%edi),%ebp
    struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);
  103009:	50                   	push   %eax
  10300a:	e8 b1 32 00 00       	call   1062c0 <get_pcpu_arch_info_pointer>
    info->lapicid = lapic_id;
  10300f:	89 e9                	mov    %ebp,%ecx
    info->bsp = is_bsp;
  103011:	83 c4 10             	add    $0x10,%esp
    info->lapicid = lapic_id;
  103014:	0f b6 c9             	movzbl %cl,%ecx
    info->bsp = is_bsp;
  103017:	c6 40 04 00          	movb   $0x0,0x4(%eax)
    info->lapicid = lapic_id;
  10301b:	89 08                	mov    %ecx,(%eax)
                ap_idx++;
  10301d:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)
            ncpu++;
  103022:	83 83 64 b9 03 00 01 	addl   $0x1,0x3b964(%ebx)
            break;
  103029:	bd 01 00 00 00       	mov    $0x1,%ebp
  10302e:	e9 b0 fe ff ff       	jmp    102ee3 <pcpu_mp_init+0xe3>
  103033:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103037:	90                   	nop
                KERN_INFO("BSP\n");
  103038:	83 ec 0c             	sub    $0xc,%esp
  10303b:	8d 83 a7 77 ff ff    	lea    -0x8859(%ebx),%eax
  103041:	50                   	push   %eax
  103042:	e8 29 16 00 00       	call   104670 <debug_info>
                pcpu_mp_init_cpu(0, lapic_ent->lapic_id, TRUE);
  103047:	0f b6 6f 03          	movzbl 0x3(%edi),%ebp
    struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);
  10304b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  103052:	e8 69 32 00 00       	call   1062c0 <get_pcpu_arch_info_pointer>
    info->bsp = is_bsp;
  103057:	83 c4 10             	add    $0x10,%esp
    info->lapicid = lapic_id;
  10305a:	89 e9                	mov    %ebp,%ecx
    info->bsp = is_bsp;
  10305c:	c6 40 04 01          	movb   $0x1,0x4(%eax)
    info->lapicid = lapic_id;
  103060:	0f b6 e9             	movzbl %cl,%ebp
  103063:	89 28                	mov    %ebp,(%eax)
    info->bsp = is_bsp;
  103065:	eb bb                	jmp    103022 <pcpu_mp_init+0x222>
  103067:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10306e:	66 90                	xchg   %ax,%ax
        (rsdt = acpi_probe_rsdt(rsdp)) == NULL) {
  103070:	83 ec 0c             	sub    $0xc,%esp
  103073:	56                   	push   %esi
  103074:	e8 67 f2 ff ff       	call   1022e0 <acpi_probe_rsdt>
    if ((xsdt = acpi_probe_xsdt(rsdp)) == NULL &&
  103079:	83 c4 10             	add    $0x10,%esp
  10307c:	85 c0                	test   %eax,%eax
  10307e:	0f 84 83 03 00 00    	je     103407 <pcpu_mp_init+0x607>
         (acpi_madt_t *) acpi_probe_rsdt_ent(rsdt, ACPI_MADT_SIG)) == NULL) {
  103084:	83 ec 08             	sub    $0x8,%esp
  103087:	68 41 50 49 43       	push   $0x43495041
  10308c:	50                   	push   %eax
  10308d:	e8 de f2 ff ff       	call   102370 <acpi_probe_rsdt_ent>
  103092:	83 c4 10             	add    $0x10,%esp
  103095:	89 c7                	mov    %eax,%edi
  103097:	e9 cb fd ff ff       	jmp    102e67 <pcpu_mp_init+0x67>
  10309c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        outb(0x22, 0x70);
  1030a0:	83 ec 08             	sub    $0x8,%esp
  1030a3:	6a 70                	push   $0x70
  1030a5:	6a 22                	push   $0x22
  1030a7:	e8 a4 24 00 00       	call   105550 <outb>
        outb(0x23, inb(0x23) | 1);
  1030ac:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
  1030b3:	e8 68 24 00 00       	call   105520 <inb>
  1030b8:	5e                   	pop    %esi
  1030b9:	5f                   	pop    %edi
  1030ba:	83 c8 01             	or     $0x1,%eax
  1030bd:	0f b6 c0             	movzbl %al,%eax
  1030c0:	50                   	push   %eax
  1030c1:	6a 23                	push   $0x23
  1030c3:	e8 88 24 00 00       	call   105550 <outb>
  1030c8:	83 c4 10             	add    $0x10,%esp
  1030cb:	e9 71 fe ff ff       	jmp    102f41 <pcpu_mp_init+0x141>
        KERN_DEBUG("Not found RSDP.\n");
  1030d0:	83 ec 04             	sub    $0x4,%esp
  1030d3:	8d 83 5b 77 ff ff    	lea    -0x88a5(%ebx),%eax
  1030d9:	50                   	push   %eax
  1030da:	68 4f 01 00 00       	push   $0x14f
        KERN_DEBUG("Not found MADT.\n");
  1030df:	8d 83 6c 77 ff ff    	lea    -0x8894(%ebx),%eax
  1030e5:	89 44 24 18          	mov    %eax,0x18(%esp)
  1030e9:	50                   	push   %eax
  1030ea:	e8 c1 15 00 00       	call   1046b0 <debug_normal>
        goto fallback;
  1030ef:	83 c4 10             	add    $0x10,%esp
    KERN_DEBUG("Use the fallback multiprocessor initialization.\n");
  1030f2:	8d 83 84 78 ff ff    	lea    -0x877c(%ebx),%eax
  1030f8:	83 ec 04             	sub    $0x4,%esp
  1030fb:	50                   	push   %eax
  1030fc:	68 ac 01 00 00       	push   $0x1ac
  103101:	ff 74 24 18          	push   0x18(%esp)
  103105:	e8 a6 15 00 00       	call   1046b0 <debug_normal>
    if (mp_inited == TRUE)
  10310a:	83 c4 10             	add    $0x10,%esp
  10310d:	80 bb 61 b9 03 00 01 	cmpb   $0x1,0x3b961(%ebx)
  103114:	0f 84 8f fe ff ff    	je     102fa9 <pcpu_mp_init+0x1a9>
    if ((p = ((bda[0x0F] << 8) | bda[0x0E]) << 4)) {
  10311a:	0f b6 05 0f 04 00 00 	movzbl 0x40f,%eax
  103121:	0f b6 15 0e 04 00 00 	movzbl 0x40e,%edx
  103128:	c1 e0 08             	shl    $0x8,%eax
  10312b:	09 d0                	or     %edx,%eax
  10312d:	c1 e0 04             	shl    $0x4,%eax
  103130:	75 1b                	jne    10314d <pcpu_mp_init+0x34d>
        p = ((bda[0x14] << 8) | bda[0x13]) * 1024;
  103132:	0f b6 05 14 04 00 00 	movzbl 0x414,%eax
  103139:	0f b6 15 13 04 00 00 	movzbl 0x413,%edx
  103140:	c1 e0 08             	shl    $0x8,%eax
  103143:	09 d0                	or     %edx,%eax
  103145:	c1 e0 0a             	shl    $0xa,%eax
        if ((mp = mpsearch1((uint8_t *) p - 1024, 1024)))
  103148:	2d 00 04 00 00       	sub    $0x400,%eax
        if ((mp = mpsearch1((uint8_t *) p, 1024)))
  10314d:	ba 00 04 00 00       	mov    $0x400,%edx
  103152:	e8 19 fc ff ff       	call   102d70 <mpsearch1>
  103157:	89 c7                	mov    %eax,%edi
  103159:	85 c0                	test   %eax,%eax
  10315b:	0f 84 ef 01 00 00    	je     103350 <pcpu_mp_init+0x550>
    if ((mp = mpsearch()) == 0 || mp->physaddr == 0)
  103161:	8b 77 04             	mov    0x4(%edi),%esi
  103164:	85 f6                	test   %esi,%esi
  103166:	0f 84 e4 00 00 00    	je     103250 <pcpu_mp_init+0x450>
    if (memcmp(conf, "PCMP", 4) != 0)
  10316c:	83 ec 04             	sub    $0x4,%esp
  10316f:	8d 83 b0 77 ff ff    	lea    -0x8850(%ebx),%eax
  103175:	6a 04                	push   $0x4
  103177:	50                   	push   %eax
  103178:	56                   	push   %esi
  103179:	e8 e2 13 00 00       	call   104560 <memcmp>
  10317e:	83 c4 10             	add    $0x10,%esp
  103181:	89 c2                	mov    %eax,%edx
  103183:	85 c0                	test   %eax,%eax
  103185:	0f 85 c5 00 00 00    	jne    103250 <pcpu_mp_init+0x450>
    if (conf->version != 1 && conf->version != 4)
  10318b:	0f b6 46 06          	movzbl 0x6(%esi),%eax
  10318f:	3c 01                	cmp    $0x1,%al
  103191:	74 08                	je     10319b <pcpu_mp_init+0x39b>
  103193:	3c 04                	cmp    $0x4,%al
  103195:	0f 85 b5 00 00 00    	jne    103250 <pcpu_mp_init+0x450>
    if (sum((uint8_t *) conf, conf->length) != 0)
  10319b:	0f b7 6e 04          	movzwl 0x4(%esi),%ebp
    for (i = 0; i < len; i++)
  10319f:	66 85 ed             	test   %bp,%bp
  1031a2:	74 20                	je     1031c4 <pcpu_mp_init+0x3c4>
  1031a4:	89 f0                	mov    %esi,%eax
  1031a6:	01 f5                	add    %esi,%ebp
  1031a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1031af:	90                   	nop
        sum += addr[i];
  1031b0:	0f b6 08             	movzbl (%eax),%ecx
    for (i = 0; i < len; i++)
  1031b3:	83 c0 01             	add    $0x1,%eax
        sum += addr[i];
  1031b6:	01 ca                	add    %ecx,%edx
    for (i = 0; i < len; i++)
  1031b8:	39 c5                	cmp    %eax,%ebp
  1031ba:	75 f4                	jne    1031b0 <pcpu_mp_init+0x3b0>
    if (sum((uint8_t *) conf, conf->length) != 0)
  1031bc:	84 d2                	test   %dl,%dl
  1031be:	0f 85 8c 00 00 00    	jne    103250 <pcpu_mp_init+0x450>
    lapic_register((uintptr_t) conf->lapicaddr);
  1031c4:	83 ec 0c             	sub    $0xc,%esp
  1031c7:	ff 76 24             	push   0x24(%esi)
    for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length; p < e;) {
  1031ca:	8d 6e 2c             	lea    0x2c(%esi),%ebp
    ismp = 1;
  1031cd:	c6 83 60 b9 03 00 01 	movb   $0x1,0x3b960(%ebx)
    ncpu = 0;
  1031d4:	c7 83 64 b9 03 00 00 	movl   $0x0,0x3b964(%ebx)
  1031db:	00 00 00 
    lapic_register((uintptr_t) conf->lapicaddr);
  1031de:	e8 5d f3 ff ff       	call   102540 <lapic_register>
    for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length; p < e;) {
  1031e3:	0f b7 56 04          	movzwl 0x4(%esi),%edx
  1031e7:	83 c4 10             	add    $0x10,%esp
  1031ea:	01 d6                	add    %edx,%esi
  1031ec:	39 f5                	cmp    %esi,%ebp
  1031ee:	0f 83 88 fd ff ff    	jae    102f7c <pcpu_mp_init+0x17c>
            KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
  1031f4:	8d 83 3c 78 ff ff    	lea    -0x87c4(%ebx),%eax
            KERN_WARN("mpinit: unknown config type %x\n", *p);
  1031fa:	89 7c 24 18          	mov    %edi,0x18(%esp)
  1031fe:	89 ef                	mov    %ebp,%edi
            KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
  103200:	89 44 24 10          	mov    %eax,0x10(%esp)
            KERN_WARN("mpinit: unknown config type %x\n", *p);
  103204:	8d 83 b8 78 ff ff    	lea    -0x8748(%ebx),%eax
    uint32_t ap_idx = 1;
  10320a:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  103211:	00 
            KERN_WARN("mpinit: unknown config type %x\n", *p);
  103212:	89 44 24 14          	mov    %eax,0x14(%esp)
  103216:	eb 13                	jmp    10322b <pcpu_mp_init+0x42b>
  103218:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10321f:	90                   	nop
            p += 8;
  103220:	83 c7 08             	add    $0x8,%edi
    for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length; p < e;) {
  103223:	39 fe                	cmp    %edi,%esi
  103225:	0f 86 4d fd ff ff    	jbe    102f78 <pcpu_mp_init+0x178>
        switch (*p) {
  10322b:	0f b6 17             	movzbl (%edi),%edx
  10322e:	80 fa 02             	cmp    $0x2,%dl
  103231:	74 5d                	je     103290 <pcpu_mp_init+0x490>
  103233:	77 3b                	ja     103270 <pcpu_mp_init+0x470>
  103235:	84 d2                	test   %dl,%dl
  103237:	75 e7                	jne    103220 <pcpu_mp_init+0x420>
            p += sizeof(struct mpproc);
  103239:	8d 6f 14             	lea    0x14(%edi),%ebp
            if (!(proc->flags & MPENAB))
  10323c:	f6 47 03 01          	testb  $0x1,0x3(%edi)
  103240:	0f 85 9a 00 00 00    	jne    1032e0 <pcpu_mp_init+0x4e0>
            p += sizeof(struct mpproc);
  103246:	89 ef                	mov    %ebp,%edi
  103248:	eb d9                	jmp    103223 <pcpu_mp_init+0x423>
  10324a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        ismp = 0;
  103250:	c6 83 60 b9 03 00 00 	movb   $0x0,0x3b960(%ebx)
        return FALSE;
  103257:	31 c0                	xor    %eax,%eax
        ncpu = 1;
  103259:	c7 83 64 b9 03 00 01 	movl   $0x1,0x3b964(%ebx)
  103260:	00 00 00 
}
  103263:	83 c4 2c             	add    $0x2c,%esp
  103266:	5b                   	pop    %ebx
  103267:	5e                   	pop    %esi
  103268:	5f                   	pop    %edi
  103269:	5d                   	pop    %ebp
  10326a:	c3                   	ret    
  10326b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10326f:	90                   	nop
        switch (*p) {
  103270:	8d 4a fd             	lea    -0x3(%edx),%ecx
  103273:	80 f9 01             	cmp    $0x1,%cl
  103276:	76 a8                	jbe    103220 <pcpu_mp_init+0x420>
            KERN_WARN("mpinit: unknown config type %x\n", *p);
  103278:	52                   	push   %edx
  103279:	ff 74 24 18          	push   0x18(%esp)
  10327d:	68 28 01 00 00       	push   $0x128
  103282:	ff 74 24 18          	push   0x18(%esp)
  103286:	e8 75 15 00 00       	call   104800 <debug_warn>
  10328b:	83 c4 10             	add    $0x10,%esp
  10328e:	eb 93                	jmp    103223 <pcpu_mp_init+0x423>
            KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
  103290:	83 ec 04             	sub    $0x4,%esp
  103293:	ff 77 04             	push   0x4(%edi)
  103296:	0f b6 57 01          	movzbl 0x1(%edi),%edx
            p += sizeof(struct mpioapic);
  10329a:	8d 6f 08             	lea    0x8(%edi),%ebp
            KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
  10329d:	52                   	push   %edx
  10329e:	ff 74 24 1c          	push   0x1c(%esp)
  1032a2:	e8 c9 13 00 00       	call   104670 <debug_info>
            ioapic_register((uintptr_t) mpio->addr, mpio->apicno, 0);
  1032a7:	83 c4 0c             	add    $0xc,%esp
  1032aa:	6a 00                	push   $0x0
  1032ac:	0f b6 57 01          	movzbl 0x1(%edi),%edx
  1032b0:	52                   	push   %edx
  1032b1:	ff 77 04             	push   0x4(%edi)
            p += sizeof(struct mpioapic);
  1032b4:	89 ef                	mov    %ebp,%edi
            ioapic_register((uintptr_t) mpio->addr, mpio->apicno, 0);
  1032b6:	e8 75 f7 ff ff       	call   102a30 <ioapic_register>
            continue;
  1032bb:	83 c4 10             	add    $0x10,%esp
  1032be:	e9 60 ff ff ff       	jmp    103223 <pcpu_mp_init+0x423>
  1032c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1032c7:	90                   	nop
        KERN_DEBUG("Not found MADT.\n");
  1032c8:	83 ec 04             	sub    $0x4,%esp
  1032cb:	8d 83 7f 77 ff ff    	lea    -0x8881(%ebx),%eax
  1032d1:	50                   	push   %eax
  1032d2:	68 5e 01 00 00       	push   $0x15e
  1032d7:	e9 03 fe ff ff       	jmp    1030df <pcpu_mp_init+0x2df>
  1032dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            KERN_INFO("\tCPU%d: APIC id = %x, ", ncpu, proc->apicid);
  1032e0:	0f b6 4f 01          	movzbl 0x1(%edi),%ecx
  1032e4:	83 ec 04             	sub    $0x4,%esp
  1032e7:	51                   	push   %ecx
  1032e8:	8d 8b 90 77 ff ff    	lea    -0x8870(%ebx),%ecx
  1032ee:	ff b3 64 b9 03 00    	push   0x3b964(%ebx)
  1032f4:	51                   	push   %ecx
  1032f5:	e8 76 13 00 00       	call   104670 <debug_info>
            if (proc->flags & MPBOOT) {
  1032fa:	83 c4 10             	add    $0x10,%esp
  1032fd:	f6 47 03 02          	testb  $0x2,0x3(%edi)
  103301:	0f 85 9e 00 00 00    	jne    1033a5 <pcpu_mp_init+0x5a5>
                KERN_INFO("AP.\n");
  103307:	83 ec 0c             	sub    $0xc,%esp
  10330a:	8d 8b bb 77 ff ff    	lea    -0x8845(%ebx),%ecx
  103310:	51                   	push   %ecx
  103311:	e8 5a 13 00 00       	call   104670 <debug_info>
    if (idx >= NUM_CPUS)
  103316:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  10331a:	83 c4 10             	add    $0x10,%esp
  10331d:	83 f8 07             	cmp    $0x7,%eax
  103320:	77 1b                	ja     10333d <pcpu_mp_init+0x53d>
    struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);
  103322:	83 ec 0c             	sub    $0xc,%esp
                pcpu_mp_init_cpu(ap_idx, proc->apicid, FALSE);
  103325:	0f b6 7f 01          	movzbl 0x1(%edi),%edi
    struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);
  103329:	50                   	push   %eax
  10332a:	e8 91 2f 00 00       	call   1062c0 <get_pcpu_arch_info_pointer>
    info->lapicid = lapic_id;
  10332f:	89 f9                	mov    %edi,%ecx
    info->bsp = is_bsp;
  103331:	83 c4 10             	add    $0x10,%esp
    info->lapicid = lapic_id;
  103334:	0f b6 d1             	movzbl %cl,%edx
    info->bsp = is_bsp;
  103337:	c6 40 04 00          	movb   $0x0,0x4(%eax)
    info->lapicid = lapic_id;
  10333b:	89 10                	mov    %edx,(%eax)
                ap_idx++;
  10333d:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
            ncpu++;
  103342:	83 83 64 b9 03 00 01 	addl   $0x1,0x3b964(%ebx)
            p += sizeof(struct mpproc);
  103349:	89 ef                	mov    %ebp,%edi
            continue;
  10334b:	e9 d3 fe ff ff       	jmp    103223 <pcpu_mp_init+0x423>
            break;
  103350:	bf 00 00 0f 00       	mov    $0xf0000,%edi
  103355:	8d b3 56 77 ff ff    	lea    -0x88aa(%ebx),%esi
  10335b:	eb 11                	jmp    10336e <pcpu_mp_init+0x56e>
  10335d:	8d 76 00             	lea    0x0(%esi),%esi
    for (p = addr; p < e; p += sizeof(struct mp))
  103360:	89 ef                	mov    %ebp,%edi
  103362:	81 fd 00 00 10 00    	cmp    $0x100000,%ebp
  103368:	0f 84 e2 fe ff ff    	je     103250 <pcpu_mp_init+0x450>
        if (memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  10336e:	83 ec 04             	sub    $0x4,%esp
  103371:	8d 6f 10             	lea    0x10(%edi),%ebp
  103374:	6a 04                	push   $0x4
  103376:	56                   	push   %esi
  103377:	57                   	push   %edi
  103378:	e8 e3 11 00 00       	call   104560 <memcmp>
  10337d:	83 c4 10             	add    $0x10,%esp
  103380:	85 c0                	test   %eax,%eax
  103382:	75 dc                	jne    103360 <pcpu_mp_init+0x560>
  103384:	89 fa                	mov    %edi,%edx
  103386:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10338d:	8d 76 00             	lea    0x0(%esi),%esi
        sum += addr[i];
  103390:	0f b6 0a             	movzbl (%edx),%ecx
    for (i = 0; i < len; i++)
  103393:	83 c2 01             	add    $0x1,%edx
        sum += addr[i];
  103396:	01 c8                	add    %ecx,%eax
    for (i = 0; i < len; i++)
  103398:	39 d5                	cmp    %edx,%ebp
  10339a:	75 f4                	jne    103390 <pcpu_mp_init+0x590>
        if (memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  10339c:	84 c0                	test   %al,%al
  10339e:	75 c0                	jne    103360 <pcpu_mp_init+0x560>
  1033a0:	e9 bc fd ff ff       	jmp    103161 <pcpu_mp_init+0x361>
                KERN_INFO("BSP.\n");
  1033a5:	83 ec 0c             	sub    $0xc,%esp
  1033a8:	8d 8b b5 77 ff ff    	lea    -0x884b(%ebx),%ecx
  1033ae:	51                   	push   %ecx
  1033af:	e8 bc 12 00 00       	call   104670 <debug_info>
                pcpu_mp_init_cpu(0, proc->apicid, TRUE);
  1033b4:	0f b6 7f 01          	movzbl 0x1(%edi),%edi
    struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);
  1033b8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1033bf:	e8 fc 2e 00 00       	call   1062c0 <get_pcpu_arch_info_pointer>
    info->bsp = is_bsp;
  1033c4:	83 c4 10             	add    $0x10,%esp
    info->lapicid = lapic_id;
  1033c7:	89 f9                	mov    %edi,%ecx
    info->bsp = is_bsp;
  1033c9:	c6 40 04 01          	movb   $0x1,0x4(%eax)
    info->lapicid = lapic_id;
  1033cd:	0f b6 d1             	movzbl %cl,%edx
  1033d0:	89 10                	mov    %edx,(%eax)
    info->bsp = is_bsp;
  1033d2:	e9 6b ff ff ff       	jmp    103342 <pcpu_mp_init+0x542>
        outb(0x22, 0x70);
  1033d7:	83 ec 08             	sub    $0x8,%esp
  1033da:	6a 70                	push   $0x70
  1033dc:	6a 22                	push   $0x22
  1033de:	e8 6d 21 00 00       	call   105550 <outb>
        outb(0x23, inb(0x23) | 1);
  1033e3:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
  1033ea:	e8 31 21 00 00       	call   105520 <inb>
  1033ef:	5a                   	pop    %edx
  1033f0:	59                   	pop    %ecx
  1033f1:	83 c8 01             	or     $0x1,%eax
  1033f4:	0f b6 c0             	movzbl %al,%eax
  1033f7:	50                   	push   %eax
  1033f8:	6a 23                	push   $0x23
  1033fa:	e8 51 21 00 00       	call   105550 <outb>
  1033ff:	83 c4 10             	add    $0x10,%esp
  103402:	e9 7f fb ff ff       	jmp    102f86 <pcpu_mp_init+0x186>
        KERN_DEBUG("Not found either RSDT or XSDT.\n");
  103407:	83 ec 04             	sub    $0x4,%esp
  10340a:	8d 83 1c 78 ff ff    	lea    -0x87e4(%ebx),%eax
  103410:	50                   	push   %eax
  103411:	68 56 01 00 00       	push   $0x156
  103416:	e9 c4 fc ff ff       	jmp    1030df <pcpu_mp_init+0x2df>
  10341b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10341f:	90                   	nop

00103420 <pcpu_boot_ap>:

int pcpu_boot_ap(uint32_t cpu_idx, void (*f)(void), uintptr_t stack_addr)
{
  103420:	57                   	push   %edi
  103421:	56                   	push   %esi
  103422:	53                   	push   %ebx
  103423:	8b 74 24 10          	mov    0x10(%esp),%esi
  103427:	e8 5d cf ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10342c:	81 c3 d4 0b 01 00    	add    $0x10bd4,%ebx
  103432:	8b 7c 24 14          	mov    0x14(%esp),%edi
    KERN_ASSERT(cpu_idx > 0 && cpu_idx < pcpu_ncpu());
  103436:	85 f6                	test   %esi,%esi
  103438:	74 6e                	je     1034a8 <pcpu_boot_ap+0x88>
  10343a:	3b b3 64 b9 03 00    	cmp    0x3b964(%ebx),%esi
  103440:	73 66                	jae    1034a8 <pcpu_boot_ap+0x88>
    KERN_ASSERT(get_pcpu_inited_info(cpu_idx) == TRUE);
  103442:	83 ec 0c             	sub    $0xc,%esp
  103445:	56                   	push   %esi
  103446:	e8 95 2e 00 00       	call   1062e0 <get_pcpu_inited_info>
  10344b:	83 c4 10             	add    $0x10,%esp
  10344e:	3c 01                	cmp    $0x1,%al
  103450:	74 22                	je     103474 <pcpu_boot_ap+0x54>
  103452:	8d 83 00 79 ff ff    	lea    -0x8700(%ebx),%eax
  103458:	50                   	push   %eax
  103459:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  10345f:	50                   	push   %eax
  103460:	8d 83 6c 77 ff ff    	lea    -0x8894(%ebx),%eax
  103466:	68 b8 01 00 00       	push   $0x1b8
  10346b:	50                   	push   %eax
  10346c:	e8 9f 12 00 00       	call   104710 <debug_panic>
  103471:	83 c4 10             	add    $0x10,%esp
    KERN_ASSERT(f != NULL);
  103474:	85 ff                	test   %edi,%edi
  103476:	0f 84 54 01 00 00    	je     1035d0 <pcpu_boot_ap+0x1b0>
    return ismp;
}

bool pcpu_onboot(void)
{
    int cpu_idx = get_pcpu_idx();
  10347c:	e8 ff 2c 00 00       	call   106180 <get_pcpu_idx>
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103481:	83 ec 0c             	sub    $0xc,%esp
  103484:	50                   	push   %eax
  103485:	e8 36 2e 00 00       	call   1062c0 <get_pcpu_arch_info_pointer>
    return (mp_inited == TRUE) ? arch_info->bsp : (get_pcpu_idx() == 0);
  10348a:	83 c4 10             	add    $0x10,%esp
  10348d:	80 bb 61 b9 03 00 01 	cmpb   $0x1,0x3b961(%ebx)
  103494:	75 3a                	jne    1034d0 <pcpu_boot_ap+0xb0>
    if (pcpu_onboot() == FALSE)
  103496:	80 78 04 00          	cmpb   $0x0,0x4(%eax)
  10349a:	75 3d                	jne    1034d9 <pcpu_boot_ap+0xb9>
}
  10349c:	5b                   	pop    %ebx
        return 1;
  10349d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  1034a2:	5e                   	pop    %esi
  1034a3:	5f                   	pop    %edi
  1034a4:	c3                   	ret    
  1034a5:	8d 76 00             	lea    0x0(%esi),%esi
    KERN_ASSERT(cpu_idx > 0 && cpu_idx < pcpu_ncpu());
  1034a8:	8d 83 d8 78 ff ff    	lea    -0x8728(%ebx),%eax
  1034ae:	50                   	push   %eax
  1034af:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  1034b5:	50                   	push   %eax
  1034b6:	8d 83 6c 77 ff ff    	lea    -0x8894(%ebx),%eax
  1034bc:	68 b7 01 00 00       	push   $0x1b7
  1034c1:	50                   	push   %eax
  1034c2:	e8 49 12 00 00       	call   104710 <debug_panic>
  1034c7:	83 c4 10             	add    $0x10,%esp
  1034ca:	e9 73 ff ff ff       	jmp    103442 <pcpu_boot_ap+0x22>
  1034cf:	90                   	nop
    return (mp_inited == TRUE) ? arch_info->bsp : (get_pcpu_idx() == 0);
  1034d0:	e8 ab 2c 00 00       	call   106180 <get_pcpu_idx>
    if (pcpu_onboot() == FALSE)
  1034d5:	85 c0                	test   %eax,%eax
  1034d7:	75 c3                	jne    10349c <pcpu_boot_ap+0x7c>
    if (get_pcpu_boot_info(cpu_idx) == TRUE)
  1034d9:	83 ec 0c             	sub    $0xc,%esp
  1034dc:	56                   	push   %esi
  1034dd:	e8 4e 2d 00 00       	call   106230 <get_pcpu_boot_info>
  1034e2:	83 c4 10             	add    $0x10,%esp
  1034e5:	3c 01                	cmp    $0x1,%al
  1034e7:	74 7c                	je     103565 <pcpu_boot_ap+0x145>
    *(uintptr_t *) (boot - 4) = stack_addr + PAGE_SIZE;
  1034e9:	8b 44 24 18          	mov    0x18(%esp),%eax
}

lapicid_t pcpu_cpu_lapicid(int cpu_idx)
{
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  1034ed:	83 ec 0c             	sub    $0xc,%esp
    *(uintptr_t *) (boot - 8) = (uintptr_t) f;
  1034f0:	89 3d f8 7f 00 00    	mov    %edi,0x7ff8
    *(uintptr_t *) (boot - 4) = stack_addr + PAGE_SIZE;
  1034f6:	05 00 10 00 00       	add    $0x1000,%eax
  1034fb:	a3 fc 7f 00 00       	mov    %eax,0x7ffc
    *(uintptr_t *) (boot - 12) = (uintptr_t) kern_init_ap;
  103500:	c7 c0 50 64 10 00    	mov    $0x106450,%eax
  103506:	a3 f4 7f 00 00       	mov    %eax,0x7ff4
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  10350b:	56                   	push   %esi
  10350c:	e8 af 2d 00 00       	call   1062c0 <get_pcpu_arch_info_pointer>
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < ncpu);
  103511:	83 c4 10             	add    $0x10,%esp
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103514:	89 c7                	mov    %eax,%edi
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < ncpu);
  103516:	85 f6                	test   %esi,%esi
  103518:	0f 88 82 00 00 00    	js     1035a0 <pcpu_boot_ap+0x180>
  10351e:	3b b3 64 b9 03 00    	cmp    0x3b964(%ebx),%esi
  103524:	73 7a                	jae    1035a0 <pcpu_boot_ap+0x180>
    lapic_startcpu(pcpu_cpu_lapicid(cpu_idx), (uintptr_t) boot);
  103526:	83 ec 08             	sub    $0x8,%esp
  103529:	68 00 80 00 00       	push   $0x8000
  10352e:	0f b6 07             	movzbl (%edi),%eax
  103531:	50                   	push   %eax
  103532:	e8 49 f3 ff ff       	call   102880 <lapic_startcpu>
    while (get_pcpu_boot_info(cpu_idx) == FALSE)
  103537:	83 c4 10             	add    $0x10,%esp
  10353a:	eb 09                	jmp    103545 <pcpu_boot_ap+0x125>
  10353c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        pause();
  103540:	e8 3b 1e 00 00       	call   105380 <pause>
    while (get_pcpu_boot_info(cpu_idx) == FALSE)
  103545:	83 ec 0c             	sub    $0xc,%esp
  103548:	56                   	push   %esi
  103549:	e8 e2 2c 00 00       	call   106230 <get_pcpu_boot_info>
  10354e:	83 c4 10             	add    $0x10,%esp
  103551:	84 c0                	test   %al,%al
  103553:	74 eb                	je     103540 <pcpu_boot_ap+0x120>
    KERN_ASSERT(get_pcpu_boot_info(cpu_idx) == TRUE);
  103555:	83 ec 0c             	sub    $0xc,%esp
  103558:	56                   	push   %esi
  103559:	e8 d2 2c 00 00       	call   106230 <get_pcpu_boot_info>
  10355e:	83 c4 10             	add    $0x10,%esp
  103561:	3c 01                	cmp    $0x1,%al
  103563:	75 0b                	jne    103570 <pcpu_boot_ap+0x150>
    return 0;
  103565:	31 c0                	xor    %eax,%eax
}
  103567:	5b                   	pop    %ebx
  103568:	5e                   	pop    %esi
  103569:	5f                   	pop    %edi
  10356a:	c3                   	ret    
  10356b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10356f:	90                   	nop
    KERN_ASSERT(get_pcpu_boot_info(cpu_idx) == TRUE);
  103570:	8d 83 48 79 ff ff    	lea    -0x86b8(%ebx),%eax
  103576:	50                   	push   %eax
  103577:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  10357d:	50                   	push   %eax
  10357e:	8d 83 6c 77 ff ff    	lea    -0x8894(%ebx),%eax
  103584:	68 cd 01 00 00       	push   $0x1cd
  103589:	50                   	push   %eax
  10358a:	e8 81 11 00 00       	call   104710 <debug_panic>
  10358f:	83 c4 10             	add    $0x10,%esp
    return 0;
  103592:	31 c0                	xor    %eax,%eax
  103594:	eb d1                	jmp    103567 <pcpu_boot_ap+0x147>
  103596:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10359d:	8d 76 00             	lea    0x0(%esi),%esi
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < ncpu);
  1035a0:	8d 83 28 79 ff ff    	lea    -0x86d8(%ebx),%eax
  1035a6:	50                   	push   %eax
  1035a7:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  1035ad:	50                   	push   %eax
  1035ae:	8d 83 6c 77 ff ff    	lea    -0x8894(%ebx),%eax
  1035b4:	68 ea 01 00 00       	push   $0x1ea
  1035b9:	50                   	push   %eax
  1035ba:	e8 51 11 00 00       	call   104710 <debug_panic>
  1035bf:	83 c4 10             	add    $0x10,%esp
  1035c2:	e9 5f ff ff ff       	jmp    103526 <pcpu_boot_ap+0x106>
  1035c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1035ce:	66 90                	xchg   %ax,%ax
    KERN_ASSERT(f != NULL);
  1035d0:	8d 83 c0 77 ff ff    	lea    -0x8840(%ebx),%eax
  1035d6:	50                   	push   %eax
  1035d7:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  1035dd:	50                   	push   %eax
  1035de:	8d 83 6c 77 ff ff    	lea    -0x8894(%ebx),%eax
  1035e4:	68 b9 01 00 00       	push   $0x1b9
  1035e9:	50                   	push   %eax
  1035ea:	e8 21 11 00 00       	call   104710 <debug_panic>
  1035ef:	83 c4 10             	add    $0x10,%esp
  1035f2:	e9 85 fe ff ff       	jmp    10347c <pcpu_boot_ap+0x5c>
  1035f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1035fe:	66 90                	xchg   %ax,%ax

00103600 <pcpu_init_cpu>:
{
  103600:	55                   	push   %ebp
  103601:	57                   	push   %edi
  103602:	56                   	push   %esi
  103603:	53                   	push   %ebx
  103604:	e8 80 cd ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  103609:	81 c3 f7 09 01 00    	add    $0x109f7,%ebx
  10360f:	83 ec 4c             	sub    $0x4c,%esp
    int cpu_idx = get_pcpu_idx();
  103612:	e8 69 2b 00 00       	call   106180 <get_pcpu_idx>
    struct pcpuinfo *cpuinfo = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103617:	83 ec 0c             	sub    $0xc,%esp
  10361a:	50                   	push   %eax
  10361b:	e8 a0 2c 00 00       	call   1062c0 <get_pcpu_arch_info_pointer>
    uint32_t *regs[4] = { &eax, &ebx, &ecx, &edx };
  103620:	8d 6c 24 34          	lea    0x34(%esp),%ebp
  103624:	8d 4c 24 3c          	lea    0x3c(%esp),%ecx
    struct pcpuinfo *cpuinfo = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103628:	89 c6                	mov    %eax,%esi
    uint32_t *regs[4] = { &eax, &ebx, &ecx, &edx };
  10362a:	8d 44 24 38          	lea    0x38(%esp),%eax
  10362e:	89 4c 24 18          	mov    %ecx,0x18(%esp)
  103632:	89 44 24 14          	mov    %eax,0x14(%esp)
  103636:	89 44 24 48          	mov    %eax,0x48(%esp)
  10363a:	89 4c 24 4c          	mov    %ecx,0x4c(%esp)
    cpuid(0x0, &eax, &ebx, &ecx, &edx);
  10363e:	89 0c 24             	mov    %ecx,(%esp)
    uint32_t *regs[4] = { &eax, &ebx, &ecx, &edx };
  103641:	89 6c 24 44          	mov    %ebp,0x44(%esp)
    cpuid(0x0, &eax, &ebx, &ecx, &edx);
  103645:	50                   	push   %eax
  103646:	55                   	push   %ebp
  103647:	8d 44 24 38          	lea    0x38(%esp),%eax
  10364b:	89 44 24 18          	mov    %eax,0x18(%esp)
  10364f:	50                   	push   %eax
  103650:	6a 00                	push   $0x0
  103652:	e8 99 1d 00 00       	call   1053f0 <cpuid>
    cpuinfo->cpuid_high = eax;
  103657:	8b 44 24 40          	mov    0x40(%esp),%eax
    cpuinfo->vendor[12] = '\0';
  10365b:	c6 46 18 00          	movb   $0x0,0x18(%esi)
    cpuinfo->cpuid_high = eax;
  10365f:	89 46 08             	mov    %eax,0x8(%esi)
    ((uint32_t *) cpuinfo->vendor)[0] = ebx;
  103662:	8b 44 24 44          	mov    0x44(%esp),%eax
  103666:	89 46 0c             	mov    %eax,0xc(%esi)
    ((uint32_t *) cpuinfo->vendor)[1] = edx;
  103669:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  10366d:	89 46 10             	mov    %eax,0x10(%esi)
    ((uint32_t *) cpuinfo->vendor)[2] = ecx;
  103670:	8b 44 24 48          	mov    0x48(%esp),%eax
  103674:	89 46 14             	mov    %eax,0x14(%esi)
    if (strncmp(cpuinfo->vendor, "GenuineIntel", 20) == 0)
  103677:	8d 46 0c             	lea    0xc(%esi),%eax
  10367a:	89 44 24 30          	mov    %eax,0x30(%esp)
  10367e:	89 c7                	mov    %eax,%edi
  103680:	83 c4 1c             	add    $0x1c,%esp
  103683:	8d 83 ff 77 ff ff    	lea    -0x8801(%ebx),%eax
  103689:	6a 14                	push   $0x14
  10368b:	50                   	push   %eax
  10368c:	57                   	push   %edi
  10368d:	e8 8e 0d 00 00       	call   104420 <strncmp>
  103692:	83 c4 10             	add    $0x10,%esp
  103695:	89 c2                	mov    %eax,%edx
  103697:	b8 01 00 00 00       	mov    $0x1,%eax
  10369c:	85 d2                	test   %edx,%edx
  10369e:	0f 85 dc 02 00 00    	jne    103980 <pcpu_init_cpu+0x380>
    cpuid(0x1, &eax, &ebx, &ecx, &edx);
  1036a4:	83 ec 0c             	sub    $0xc,%esp
        cpuinfo->cpu_vendor = INTEL;
  1036a7:	89 46 20             	mov    %eax,0x20(%esi)
    cpuid(0x1, &eax, &ebx, &ecx, &edx);
  1036aa:	ff 74 24 14          	push   0x14(%esp)
  1036ae:	ff 74 24 14          	push   0x14(%esp)
  1036b2:	55                   	push   %ebp
  1036b3:	ff 74 24 18          	push   0x18(%esp)
  1036b7:	6a 01                	push   $0x1
  1036b9:	e8 32 1d 00 00       	call   1053f0 <cpuid>
    cpuinfo->family = (eax >> 8) & 0xf;
  1036be:	8b 44 24 40          	mov    0x40(%esp),%eax
  1036c2:	89 c2                	mov    %eax,%edx
  1036c4:	c1 ea 08             	shr    $0x8,%edx
  1036c7:	83 e2 0f             	and    $0xf,%edx
  1036ca:	88 56 24             	mov    %dl,0x24(%esi)
    cpuinfo->model = (eax >> 4) & 0xf;
  1036cd:	89 c2                	mov    %eax,%edx
  1036cf:	c0 ea 04             	shr    $0x4,%dl
  1036d2:	88 56 25             	mov    %dl,0x25(%esi)
    cpuinfo->step = eax & 0xf;
  1036d5:	89 c2                	mov    %eax,%edx
  1036d7:	83 e2 0f             	and    $0xf,%edx
  1036da:	88 56 26             	mov    %dl,0x26(%esi)
    cpuinfo->ext_family = (eax >> 20) & 0xff;
  1036dd:	89 c2                	mov    %eax,%edx
    cpuinfo->ext_model = (eax >> 16) & 0xff;
  1036df:	c1 e8 10             	shr    $0x10,%eax
  1036e2:	88 46 28             	mov    %al,0x28(%esi)
    cpuinfo->brand_idx = ebx & 0xff;
  1036e5:	8b 44 24 44          	mov    0x44(%esp),%eax
    cpuinfo->ext_family = (eax >> 20) & 0xff;
  1036e9:	c1 ea 14             	shr    $0x14,%edx
  1036ec:	88 56 27             	mov    %dl,0x27(%esi)
    cpuinfo->brand_idx = ebx & 0xff;
  1036ef:	89 46 29             	mov    %eax,0x29(%esi)
    cpuinfo->feature1 = ecx;
  1036f2:	8b 44 24 48          	mov    0x48(%esp),%eax
  1036f6:	89 46 30             	mov    %eax,0x30(%esi)
    cpuinfo->feature2 = edx;
  1036f9:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    switch (cpuinfo->cpu_vendor) {
  1036fd:	83 c4 20             	add    $0x20,%esp
    cpuinfo->feature2 = edx;
  103700:	89 46 34             	mov    %eax,0x34(%esi)
    switch (cpuinfo->cpu_vendor) {
  103703:	8b 46 20             	mov    0x20(%esi),%eax
  103706:	83 f8 01             	cmp    $0x1,%eax
  103709:	0f 84 31 01 00 00    	je     103840 <pcpu_init_cpu+0x240>
  10370f:	83 f8 02             	cmp    $0x2,%eax
  103712:	0f 84 d0 01 00 00    	je     1038e8 <pcpu_init_cpu+0x2e8>
        cpuinfo->l1_cache_size = 0;
  103718:	c7 46 38 00 00 00 00 	movl   $0x0,0x38(%esi)
        cpuinfo->l1_cache_line_size = 0;
  10371f:	c7 46 3c 00 00 00 00 	movl   $0x0,0x3c(%esi)
    cpuid(0x80000000, &eax, &ebx, &ecx, &edx);
  103726:	83 ec 0c             	sub    $0xc,%esp
  103729:	ff 74 24 14          	push   0x14(%esp)
  10372d:	ff 74 24 14          	push   0x14(%esp)
  103731:	55                   	push   %ebp
  103732:	ff 74 24 18          	push   0x18(%esp)
  103736:	68 00 00 00 80       	push   $0x80000000
  10373b:	e8 b0 1c 00 00       	call   1053f0 <cpuid>
    cpuinfo->cpuid_exthigh = eax;
  103740:	8b 44 24 40          	mov    0x40(%esp),%eax
    pcpu_print_cpuinfo(get_pcpu_idx(), cpuinfo);
  103744:	83 c4 20             	add    $0x20,%esp
    cpuinfo->cpuid_exthigh = eax;
  103747:	89 46 40             	mov    %eax,0x40(%esi)
    pcpu_print_cpuinfo(get_pcpu_idx(), cpuinfo);
  10374a:	e8 31 2a 00 00       	call   106180 <get_pcpu_idx>
    KERN_INFO("CPU%d: %s, FAMILY %d(%d), MODEL %d(%d), STEP %d, "
  10374f:	8b 56 30             	mov    0x30(%esi),%edx
  103752:	8d 8b ca 77 ff ff    	lea    -0x8836(%ebx),%ecx
  103758:	8b 7e 38             	mov    0x38(%esi),%edi
    pcpu_print_cpuinfo(get_pcpu_idx(), cpuinfo);
  10375b:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    KERN_INFO("CPU%d: %s, FAMILY %d(%d), MODEL %d(%d), STEP %d, "
  10375f:	8d 83 36 87 ff ff    	lea    -0x78ca(%ebx),%eax
  103765:	f7 c2 00 00 80 00    	test   $0x800000,%edx
  10376b:	89 3c 24             	mov    %edi,(%esp)
  10376e:	0f 44 c8             	cmove  %eax,%ecx
  103771:	f7 c2 00 00 10 00    	test   $0x100000,%edx
  103777:	89 4c 24 18          	mov    %ecx,0x18(%esp)
  10377b:	8d 8b d3 77 ff ff    	lea    -0x882d(%ebx),%ecx
  103781:	89 cf                	mov    %ecx,%edi
  103783:	8d 8b db 77 ff ff    	lea    -0x8825(%ebx),%ecx
  103789:	0f 44 f8             	cmove  %eax,%edi
  10378c:	f7 c2 00 00 08 00    	test   $0x80000,%edx
  103792:	0f 44 c8             	cmove  %eax,%ecx
  103795:	f6 c6 02             	test   $0x2,%dh
  103798:	89 7c 24 14          	mov    %edi,0x14(%esp)
  10379c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1037a0:	8d 8b e3 77 ff ff    	lea    -0x881d(%ebx),%ecx
  1037a6:	89 cd                	mov    %ecx,%ebp
  1037a8:	8d 8b eb 77 ff ff    	lea    -0x8815(%ebx),%ecx
  1037ae:	0f 44 e8             	cmove  %eax,%ebp
  1037b1:	89 cf                	mov    %ecx,%edi
  1037b3:	f6 c2 01             	test   $0x1,%dl
  1037b6:	8b 4e 34             	mov    0x34(%esi),%ecx
  1037b9:	0f 44 f8             	cmove  %eax,%edi
  1037bc:	89 6c 24 08          	mov    %ebp,0x8(%esp)
  1037c0:	f7 c1 00 00 00 04    	test   $0x4000000,%ecx
  1037c6:	8d ab f2 77 ff ff    	lea    -0x880e(%ebx),%ebp
  1037cc:	0f 44 e8             	cmove  %eax,%ebp
  1037cf:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1037d3:	f7 c1 00 00 00 02    	test   $0x2000000,%ecx
  1037d9:	8d bb f9 77 ff ff    	lea    -0x8807(%ebx),%edi
  1037df:	0f 44 f8             	cmove  %eax,%edi
  1037e2:	83 ec 04             	sub    $0x4,%esp
  1037e5:	ff 76 3c             	push   0x3c(%esi)
  1037e8:	ff 74 24 08          	push   0x8(%esp)
  1037ec:	ff 74 24 24          	push   0x24(%esp)
  1037f0:	ff 74 24 24          	push   0x24(%esp)
  1037f4:	ff 74 24 20          	push   0x20(%esp)
  1037f8:	ff 74 24 20          	push   0x20(%esp)
  1037fc:	ff 74 24 20          	push   0x20(%esp)
  103800:	55                   	push   %ebp
  103801:	57                   	push   %edi
  103802:	51                   	push   %ecx
  103803:	52                   	push   %edx
  103804:	0f b6 46 26          	movzbl 0x26(%esi),%eax
  103808:	50                   	push   %eax
  103809:	0f b6 46 28          	movzbl 0x28(%esi),%eax
  10380d:	50                   	push   %eax
  10380e:	0f b6 46 25          	movzbl 0x25(%esi),%eax
  103812:	50                   	push   %eax
  103813:	0f b6 46 27          	movzbl 0x27(%esi),%eax
  103817:	50                   	push   %eax
  103818:	0f b6 46 24          	movzbl 0x24(%esi),%eax
  10381c:	50                   	push   %eax
  10381d:	8d 83 6c 79 ff ff    	lea    -0x8694(%ebx),%eax
  103823:	ff 74 24 54          	push   0x54(%esp)
  103827:	ff 74 24 64          	push   0x64(%esp)
  10382b:	50                   	push   %eax
  10382c:	e8 3f 0e 00 00       	call   104670 <debug_info>
}
  103831:	81 c4 9c 00 00 00    	add    $0x9c,%esp
  103837:	5b                   	pop    %ebx
  103838:	5e                   	pop    %esi
  103839:	5f                   	pop    %edi
  10383a:	5d                   	pop    %ebp
  10383b:	c3                   	ret    
  10383c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cpuid(0x00000002, &eax, &ebx, &ecx, &edx);
  103840:	83 ec 0c             	sub    $0xc,%esp
  103843:	ff 74 24 14          	push   0x14(%esp)
  103847:	ff 74 24 14          	push   0x14(%esp)
  10384b:	55                   	push   %ebp
  10384c:	ff 74 24 18          	push   0x18(%esp)
  103850:	6a 02                	push   $0x2
  103852:	e8 99 1b 00 00       	call   1053f0 <cpuid>
        i = eax & 0x000000ff;
  103857:	0f b6 44 24 40       	movzbl 0x40(%esp),%eax
        while (i--)
  10385c:	83 c4 20             	add    $0x20,%esp
  10385f:	8d 78 ff             	lea    -0x1(%eax),%edi
  103862:	85 c0                	test   %eax,%eax
  103864:	74 2d                	je     103893 <pcpu_init_cpu+0x293>
  103866:	89 74 24 0c          	mov    %esi,0xc(%esp)
  10386a:	89 fe                	mov    %edi,%esi
  10386c:	8b 7c 24 08          	mov    0x8(%esp),%edi
            cpuid(0x00000002, &eax, &ebx, &ecx, &edx);
  103870:	83 ec 0c             	sub    $0xc,%esp
        while (i--)
  103873:	83 ee 01             	sub    $0x1,%esi
            cpuid(0x00000002, &eax, &ebx, &ecx, &edx);
  103876:	57                   	push   %edi
  103877:	ff 74 24 14          	push   0x14(%esp)
  10387b:	55                   	push   %ebp
  10387c:	ff 74 24 18          	push   0x18(%esp)
  103880:	6a 02                	push   $0x2
  103882:	e8 69 1b 00 00       	call   1053f0 <cpuid>
        while (i--)
  103887:	83 c4 20             	add    $0x20,%esp
  10388a:	83 fe ff             	cmp    $0xffffffff,%esi
  10388d:	75 e1                	jne    103870 <pcpu_init_cpu+0x270>
  10388f:	8b 74 24 0c          	mov    0xc(%esp),%esi
  103893:	8d 44 24 30          	lea    0x30(%esp),%eax
  103897:	89 6c 24 18          	mov    %ebp,0x18(%esp)
  10389b:	8d 8b 00 7a ff ff    	lea    -0x8600(%ebx),%ecx
  1038a1:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1038a5:	8d 44 24 40          	lea    0x40(%esp),%eax
  1038a9:	89 44 24 14          	mov    %eax,0x14(%esp)
  1038ad:	8d 44 24 20          	lea    0x20(%esp),%eax
            for (j = 0; j < 4; j++) {
  1038b1:	8d 68 04             	lea    0x4(%eax),%ebp
                cpuinfo->l1_cache_size = intel_cache_info[desc[j]][0];
  1038b4:	0f b6 10             	movzbl (%eax),%edx
            for (j = 0; j < 4; j++) {
  1038b7:	83 c0 01             	add    $0x1,%eax
                cpuinfo->l1_cache_size = intel_cache_info[desc[j]][0];
  1038ba:	8b 14 d1             	mov    (%ecx,%edx,8),%edx
  1038bd:	89 56 38             	mov    %edx,0x38(%esi)
                cpuinfo->l1_cache_line_size = intel_cache_info[desc[j]][1];
  1038c0:	0f b6 78 ff          	movzbl -0x1(%eax),%edi
  1038c4:	8b 7c f9 04          	mov    0x4(%ecx,%edi,8),%edi
  1038c8:	89 7e 3c             	mov    %edi,0x3c(%esi)
            for (j = 0; j < 4; j++) {
  1038cb:	39 c5                	cmp    %eax,%ebp
  1038cd:	75 e5                	jne    1038b4 <pcpu_init_cpu+0x2b4>
        for (i = 0; i < 4; i++) {
  1038cf:	83 44 24 0c 04       	addl   $0x4,0xc(%esp)
  1038d4:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1038d8:	39 44 24 14          	cmp    %eax,0x14(%esp)
  1038dc:	74 42                	je     103920 <pcpu_init_cpu+0x320>
            desc = (uint8_t *) regs[i];
  1038de:	8b 00                	mov    (%eax),%eax
  1038e0:	eb cf                	jmp    1038b1 <pcpu_init_cpu+0x2b1>
  1038e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cpuid(0x80000005, &eax, &ebx, &ecx, &edx);
  1038e8:	83 ec 0c             	sub    $0xc,%esp
  1038eb:	ff 74 24 14          	push   0x14(%esp)
  1038ef:	ff 74 24 14          	push   0x14(%esp)
  1038f3:	55                   	push   %ebp
  1038f4:	ff 74 24 18          	push   0x18(%esp)
  1038f8:	68 05 00 00 80       	push   $0x80000005
  1038fd:	e8 ee 1a 00 00       	call   1053f0 <cpuid>
        cpuinfo->l1_cache_size = (ecx & 0xff000000) >> 24;
  103902:	8b 44 24 48          	mov    0x48(%esp),%eax
        break;
  103906:	83 c4 20             	add    $0x20,%esp
        cpuinfo->l1_cache_size = (ecx & 0xff000000) >> 24;
  103909:	89 c2                	mov    %eax,%edx
        cpuinfo->l1_cache_line_size = (ecx & 0x000000ff);
  10390b:	25 ff 00 00 00       	and    $0xff,%eax
        cpuinfo->l1_cache_size = (ecx & 0xff000000) >> 24;
  103910:	c1 ea 18             	shr    $0x18,%edx
        cpuinfo->l1_cache_line_size = (ecx & 0x000000ff);
  103913:	89 46 3c             	mov    %eax,0x3c(%esi)
        cpuinfo->l1_cache_size = (ecx & 0xff000000) >> 24;
  103916:	89 56 38             	mov    %edx,0x38(%esi)
        break;
  103919:	e9 08 fe ff ff       	jmp    103726 <pcpu_init_cpu+0x126>
  10391e:	66 90                	xchg   %ax,%ax
        if (cpuinfo->l1_cache_size && cpuinfo->l1_cache_line_size)
  103920:	8b 6c 24 18          	mov    0x18(%esp),%ebp
  103924:	85 d2                	test   %edx,%edx
  103926:	0f 85 84 00 00 00    	jne    1039b0 <pcpu_init_cpu+0x3b0>
  10392c:	31 ff                	xor    %edi,%edi
            cpuid_subleaf(0x00000004, i, &eax, &ebx, &ecx, &edx);
  10392e:	83 ec 08             	sub    $0x8,%esp
  103931:	ff 74 24 10          	push   0x10(%esp)
  103935:	ff 74 24 10          	push   0x10(%esp)
  103939:	55                   	push   %ebp
  10393a:	ff 74 24 14          	push   0x14(%esp)
  10393e:	57                   	push   %edi
  10393f:	6a 04                	push   $0x4
  103941:	e8 ea 1a 00 00       	call   105430 <cpuid_subleaf>
            if ((eax & 0xf) == 1 && ((eax & 0xe0) >> 5) == 1)
  103946:	8b 54 24 40          	mov    0x40(%esp),%edx
  10394a:	83 c4 20             	add    $0x20,%esp
  10394d:	89 d1                	mov    %edx,%ecx
  10394f:	83 e1 0f             	and    $0xf,%ecx
  103952:	83 f9 01             	cmp    $0x1,%ecx
  103955:	74 69                	je     1039c0 <pcpu_init_cpu+0x3c0>
        for (i = 0; i < 3; i++) {
  103957:	83 c7 01             	add    $0x1,%edi
  10395a:	83 ff 03             	cmp    $0x3,%edi
  10395d:	75 cf                	jne    10392e <pcpu_init_cpu+0x32e>
            KERN_WARN("Cannot determine L1 cache size.\n");
  10395f:	83 ec 04             	sub    $0x4,%esp
  103962:	8d 83 dc 79 ff ff    	lea    -0x8624(%ebx),%eax
  103968:	50                   	push   %eax
  103969:	8d 83 6c 77 ff ff    	lea    -0x8894(%ebx),%eax
  10396f:	6a 7c                	push   $0x7c
  103971:	50                   	push   %eax
  103972:	e8 89 0e 00 00       	call   104800 <debug_warn>
            break;
  103977:	83 c4 10             	add    $0x10,%esp
  10397a:	e9 a7 fd ff ff       	jmp    103726 <pcpu_init_cpu+0x126>
  10397f:	90                   	nop
    else if (strncmp(cpuinfo->vendor, "AuthenticAMD", 20) == 0)
  103980:	83 ec 04             	sub    $0x4,%esp
  103983:	8d 83 0c 78 ff ff    	lea    -0x87f4(%ebx),%eax
  103989:	6a 14                	push   $0x14
  10398b:	50                   	push   %eax
  10398c:	ff 74 24 1c          	push   0x1c(%esp)
  103990:	e8 8b 0a 00 00       	call   104420 <strncmp>
  103995:	83 c4 10             	add    $0x10,%esp
  103998:	85 c0                	test   %eax,%eax
  10399a:	0f 94 c0             	sete   %al
  10399d:	0f b6 c0             	movzbl %al,%eax
  1039a0:	01 c0                	add    %eax,%eax
  1039a2:	e9 fd fc ff ff       	jmp    1036a4 <pcpu_init_cpu+0xa4>
  1039a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1039ae:	66 90                	xchg   %ax,%ax
        if (cpuinfo->l1_cache_size && cpuinfo->l1_cache_line_size)
  1039b0:	85 ff                	test   %edi,%edi
  1039b2:	0f 85 6e fd ff ff    	jne    103726 <pcpu_init_cpu+0x126>
  1039b8:	e9 71 ff ff ff       	jmp    10392e <pcpu_init_cpu+0x32e>
  1039bd:	8d 76 00             	lea    0x0(%esi),%esi
            if ((eax & 0xf) == 1 && ((eax & 0xe0) >> 5) == 1)
  1039c0:	c1 ea 05             	shr    $0x5,%edx
  1039c3:	83 e2 07             	and    $0x7,%edx
  1039c6:	83 fa 01             	cmp    $0x1,%edx
  1039c9:	75 8c                	jne    103957 <pcpu_init_cpu+0x357>
            (((ebx & 0xffc00000) >> 22) + 1) *  /* ways */
  1039cb:	8b 7c 24 24          	mov    0x24(%esp),%edi
            (ecx + 1) /                         /* sets */
  1039cf:	8b 54 24 28          	mov    0x28(%esp),%edx
            (((ebx & 0x00000fff)) + 1) *        /* line size */
  1039d3:	89 f8                	mov    %edi,%eax
            (ecx + 1) /                         /* sets */
  1039d5:	83 c2 01             	add    $0x1,%edx
            (((ebx & 0x00000fff)) + 1) *        /* line size */
  1039d8:	25 ff 0f 00 00       	and    $0xfff,%eax
  1039dd:	8d 48 01             	lea    0x1(%eax),%ecx
            (((ebx & 0xffc00000) >> 22) + 1) *  /* ways */
  1039e0:	89 f8                	mov    %edi,%eax
            (((ebx & 0x003ff000) >> 12) + 1) *  /* partitions */
  1039e2:	c1 ef 0c             	shr    $0xc,%edi
            (((ebx & 0xffc00000) >> 22) + 1) *  /* ways */
  1039e5:	c1 e8 16             	shr    $0x16,%eax
        cpuinfo->l1_cache_line_size = ((ebx & 0x00000fff)) + 1;
  1039e8:	89 4e 3c             	mov    %ecx,0x3c(%esi)
            (((ebx & 0xffc00000) >> 22) + 1) *  /* ways */
  1039eb:	83 c0 01             	add    $0x1,%eax
            (((ebx & 0x00000fff)) + 1) *        /* line size */
  1039ee:	0f af c1             	imul   %ecx,%eax
  1039f1:	0f af c2             	imul   %edx,%eax
            (((ebx & 0x003ff000) >> 12) + 1) *  /* partitions */
  1039f4:	89 fa                	mov    %edi,%edx
  1039f6:	81 e2 ff 03 00 00    	and    $0x3ff,%edx
  1039fc:	83 c2 01             	add    $0x1,%edx
            (((ebx & 0x00000fff)) + 1) *        /* line size */
  1039ff:	0f af c2             	imul   %edx,%eax
            (ecx + 1) /                         /* sets */
  103a02:	c1 e8 0a             	shr    $0xa,%eax
  103a05:	89 46 38             	mov    %eax,0x38(%esi)
        break;
  103a08:	e9 19 fd ff ff       	jmp    103726 <pcpu_init_cpu+0x126>
  103a0d:	8d 76 00             	lea    0x0(%esi),%esi

00103a10 <pcpu_ncpu>:
    return ncpu;
  103a10:	e8 6c c9 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  103a15:	05 eb 05 01 00       	add    $0x105eb,%eax
  103a1a:	8b 80 64 b9 03 00    	mov    0x3b964(%eax),%eax
}
  103a20:	c3                   	ret    
  103a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103a28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103a2f:	90                   	nop

00103a30 <pcpu_is_smp>:
    return ismp;
  103a30:	e8 4c c9 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  103a35:	05 cb 05 01 00       	add    $0x105cb,%eax
  103a3a:	0f b6 80 60 b9 03 00 	movzbl 0x3b960(%eax),%eax
}
  103a41:	c3                   	ret    
  103a42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103a50 <pcpu_onboot>:
{
  103a50:	53                   	push   %ebx
  103a51:	e8 33 c9 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  103a56:	81 c3 aa 05 01 00    	add    $0x105aa,%ebx
  103a5c:	83 ec 08             	sub    $0x8,%esp
    int cpu_idx = get_pcpu_idx();
  103a5f:	e8 1c 27 00 00       	call   106180 <get_pcpu_idx>
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103a64:	83 ec 0c             	sub    $0xc,%esp
  103a67:	50                   	push   %eax
  103a68:	e8 53 28 00 00       	call   1062c0 <get_pcpu_arch_info_pointer>
    return (mp_inited == TRUE) ? arch_info->bsp : (get_pcpu_idx() == 0);
  103a6d:	83 c4 10             	add    $0x10,%esp
  103a70:	80 bb 61 b9 03 00 01 	cmpb   $0x1,0x3b961(%ebx)
  103a77:	75 0f                	jne    103a88 <pcpu_onboot+0x38>
  103a79:	0f b6 40 04          	movzbl 0x4(%eax),%eax
}
  103a7d:	83 c4 08             	add    $0x8,%esp
  103a80:	5b                   	pop    %ebx
  103a81:	c3                   	ret    
  103a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return (mp_inited == TRUE) ? arch_info->bsp : (get_pcpu_idx() == 0);
  103a88:	e8 f3 26 00 00       	call   106180 <get_pcpu_idx>
  103a8d:	85 c0                	test   %eax,%eax
  103a8f:	0f 94 c0             	sete   %al
}
  103a92:	83 c4 08             	add    $0x8,%esp
  103a95:	5b                   	pop    %ebx
  103a96:	c3                   	ret    
  103a97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103a9e:	66 90                	xchg   %ax,%ax

00103aa0 <pcpu_cpu_lapicid>:
{
  103aa0:	57                   	push   %edi
  103aa1:	56                   	push   %esi
  103aa2:	53                   	push   %ebx
  103aa3:	8b 7c 24 10          	mov    0x10(%esp),%edi
  103aa7:	e8 dd c8 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  103aac:	81 c3 54 05 01 00    	add    $0x10554,%ebx
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103ab2:	83 ec 0c             	sub    $0xc,%esp
  103ab5:	57                   	push   %edi
  103ab6:	e8 05 28 00 00       	call   1062c0 <get_pcpu_arch_info_pointer>
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < ncpu);
  103abb:	83 c4 10             	add    $0x10,%esp
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103abe:	89 c6                	mov    %eax,%esi
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < ncpu);
  103ac0:	85 ff                	test   %edi,%edi
  103ac2:	78 08                	js     103acc <pcpu_cpu_lapicid+0x2c>
  103ac4:	3b bb 64 b9 03 00    	cmp    0x3b964(%ebx),%edi
  103aca:	72 22                	jb     103aee <pcpu_cpu_lapicid+0x4e>
  103acc:	8d 83 28 79 ff ff    	lea    -0x86d8(%ebx),%eax
  103ad2:	50                   	push   %eax
  103ad3:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  103ad9:	50                   	push   %eax
  103ada:	8d 83 6c 77 ff ff    	lea    -0x8894(%ebx),%eax
  103ae0:	68 ea 01 00 00       	push   $0x1ea
  103ae5:	50                   	push   %eax
  103ae6:	e8 25 0c 00 00       	call   104710 <debug_panic>
  103aeb:	83 c4 10             	add    $0x10,%esp
    return arch_info->lapicid;
  103aee:	0f b6 06             	movzbl (%esi),%eax
}
  103af1:	5b                   	pop    %ebx
  103af2:	5e                   	pop    %esi
  103af3:	5f                   	pop    %edi
  103af4:	c3                   	ret    
  103af5:	66 90                	xchg   %ax,%ax
  103af7:	66 90                	xchg   %ax,%ax
  103af9:	66 90                	xchg   %ax,%ax
  103afb:	66 90                	xchg   %ax,%ax
  103afd:	66 90                	xchg   %ax,%ax
  103aff:	90                   	nop

00103b00 <ioapicinit>:
void ioapicinit(void)
{
    int32_t i, maxintr;
    int32_t id __attribute__((unused));

    ioapic = (volatile struct ioapic *) IOAPIC;
  103b00:	e8 7c c8 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  103b05:	05 fb 04 01 00       	add    $0x104fb,%eax
{
  103b0a:	53                   	push   %ebx
    ioapic = (volatile struct ioapic *) IOAPIC;
  103b0b:	c7 80 68 b9 03 00 00 	movl   $0xfec00000,0x3b968(%eax)
  103b12:	00 c0 fe 
    ioapic->reg = reg;
  103b15:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
  103b1c:	00 00 00 
    return ioapic->data;
  103b1f:	a1 10 00 c0 fe       	mov    0xfec00010,%eax
    ioapic->reg = reg;
  103b24:	c7 05 00 00 c0 fe 00 	movl   $0x0,0xfec00000
  103b2b:	00 00 00 
    return ioapic->data;
  103b2e:	8b 15 10 00 c0 fe    	mov    0xfec00010,%edx
  103b34:	ba 20 00 00 00       	mov    $0x20,%edx
    maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  103b39:	c1 e8 10             	shr    $0x10,%eax
  103b3c:	0f b6 c0             	movzbl %al,%eax
  103b3f:	8d 5c 00 12          	lea    0x12(%eax,%eax,1),%ebx
    return ioapic->data;
  103b43:	b8 10 00 00 00       	mov    $0x10,%eax
  103b48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103b4f:	90                   	nop
    id = ioapicread(REG_ID) >> 24;

    // Mark all interrupts edge-triggered, active high, disabled,
    // and not routed to any CPUs.
    for (i = 0; i <= maxintr; i++) {
        ioapicwrite(REG_TABLE + 2 * i, INT_DISABLED | (T_IRQ0 + i));
  103b50:	89 d1                	mov    %edx,%ecx
    ioapic->reg = reg;
  103b52:	a3 00 00 c0 fe       	mov    %eax,0xfec00000
    for (i = 0; i <= maxintr; i++) {
  103b57:	83 c2 01             	add    $0x1,%edx
        ioapicwrite(REG_TABLE + 2 * i, INT_DISABLED | (T_IRQ0 + i));
  103b5a:	81 c9 00 00 01 00    	or     $0x10000,%ecx
    ioapic->data = data;
  103b60:	89 0d 10 00 c0 fe    	mov    %ecx,0xfec00010
    ioapic->reg = reg;
  103b66:	8d 48 01             	lea    0x1(%eax),%ecx
    for (i = 0; i <= maxintr; i++) {
  103b69:	83 c0 02             	add    $0x2,%eax
    ioapic->reg = reg;
  103b6c:	89 0d 00 00 c0 fe    	mov    %ecx,0xfec00000
    ioapic->data = data;
  103b72:	c7 05 10 00 c0 fe 00 	movl   $0x0,0xfec00010
  103b79:	00 00 00 
    for (i = 0; i <= maxintr; i++) {
  103b7c:	39 d8                	cmp    %ebx,%eax
  103b7e:	75 d0                	jne    103b50 <ioapicinit+0x50>
        ioapicwrite(REG_TABLE + 2 * i + 1, 0);
    }
}
  103b80:	5b                   	pop    %ebx
  103b81:	c3                   	ret    
  103b82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103b90 <ioapicenable>:

void ioapicenable(int irq, int cpunum)
{
  103b90:	53                   	push   %ebx
  103b91:	8b 44 24 08          	mov    0x8(%esp),%eax
  103b95:	e8 ef c7 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  103b9a:	81 c3 66 04 01 00    	add    $0x10466,%ebx
    // Mark interrupt edge-triggered, active high,
    // enabled, and routed to the given cpunum,
    // which happens to be that cpu's APIC ID.
    ioapicwrite(REG_TABLE + 2 * irq, T_IRQ0 + irq);
  103ba0:	8d 48 20             	lea    0x20(%eax),%ecx
  103ba3:	8d 54 00 10          	lea    0x10(%eax,%eax,1),%edx
    ioapic->reg = reg;
  103ba7:	8b 83 68 b9 03 00    	mov    0x3b968(%ebx),%eax
  103bad:	89 10                	mov    %edx,(%eax)
    ioapicwrite(REG_TABLE + 2 * irq + 1, cpunum << 24);
  103baf:	83 c2 01             	add    $0x1,%edx
    ioapic->data = data;
  103bb2:	89 48 10             	mov    %ecx,0x10(%eax)
    ioapicwrite(REG_TABLE + 2 * irq + 1, cpunum << 24);
  103bb5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    ioapic->reg = reg;
  103bb9:	89 10                	mov    %edx,(%eax)
    ioapicwrite(REG_TABLE + 2 * irq + 1, cpunum << 24);
  103bbb:	c1 e1 18             	shl    $0x18,%ecx
    ioapic->data = data;
  103bbe:	89 48 10             	mov    %ecx,0x10(%eax)
}
  103bc1:	5b                   	pop    %ebx
  103bc2:	c3                   	ret    
  103bc3:	66 90                	xchg   %ax,%ax
  103bc5:	66 90                	xchg   %ax,%ax
  103bc7:	66 90                	xchg   %ax,%ax
  103bc9:	66 90                	xchg   %ax,%ax
  103bcb:	66 90                	xchg   %ax,%ax
  103bcd:	66 90                	xchg   %ax,%ax
  103bcf:	90                   	nop

00103bd0 <picenable>:
    outb(IO_PIC1 + 1, mask);
    outb(IO_PIC2 + 1, mask >> 8);
}

void picenable(int32_t irq)
{
  103bd0:	56                   	push   %esi
  103bd1:	53                   	push   %ebx
  103bd2:	e8 b2 c7 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  103bd7:	81 c3 29 04 01 00    	add    $0x10429,%ebx
  103bdd:	83 ec 0c             	sub    $0xc,%esp
    picsetmask(irqmask & ~(1 << irq));
  103be0:	8b 44 24 18          	mov    0x18(%esp),%eax
  103be4:	0f b7 b3 28 03 00 00 	movzwl 0x328(%ebx),%esi
  103beb:	0f b3 c6             	btr    %eax,%esi
    outb(IO_PIC1 + 1, mask);
  103bee:	89 f0                	mov    %esi,%eax
    irqmask = mask;
  103bf0:	66 89 b3 28 03 00 00 	mov    %si,0x328(%ebx)
    outb(IO_PIC2 + 1, mask >> 8);
  103bf7:	66 c1 ee 08          	shr    $0x8,%si
    outb(IO_PIC1 + 1, mask);
  103bfb:	0f b6 c0             	movzbl %al,%eax
    outb(IO_PIC2 + 1, mask >> 8);
  103bfe:	0f b7 f6             	movzwl %si,%esi
    outb(IO_PIC1 + 1, mask);
  103c01:	50                   	push   %eax
  103c02:	6a 21                	push   $0x21
  103c04:	e8 47 19 00 00       	call   105550 <outb>
    outb(IO_PIC2 + 1, mask >> 8);
  103c09:	58                   	pop    %eax
  103c0a:	5a                   	pop    %edx
  103c0b:	56                   	push   %esi
  103c0c:	68 a1 00 00 00       	push   $0xa1
  103c11:	e8 3a 19 00 00       	call   105550 <outb>
}
  103c16:	83 c4 14             	add    $0x14,%esp
  103c19:	5b                   	pop    %ebx
  103c1a:	5e                   	pop    %esi
  103c1b:	c3                   	ret    
  103c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103c20 <picinit>:

// Initialize the 8259A interrupt controllers.
void picinit(void)
{
  103c20:	56                   	push   %esi
  103c21:	53                   	push   %ebx
  103c22:	e8 62 c7 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  103c27:	81 c3 d9 03 01 00    	add    $0x103d9,%ebx
  103c2d:	83 ec 0c             	sub    $0xc,%esp
    // mask all interrupts
    outb(IO_PIC1 + 1, 0xFF);
  103c30:	68 ff 00 00 00       	push   $0xff
  103c35:	6a 21                	push   $0x21
  103c37:	e8 14 19 00 00       	call   105550 <outb>
    outb(IO_PIC2 + 1, 0xFF);
  103c3c:	59                   	pop    %ecx
  103c3d:	5e                   	pop    %esi
  103c3e:	68 ff 00 00 00       	push   $0xff
  103c43:	68 a1 00 00 00       	push   $0xa1
  103c48:	e8 03 19 00 00       	call   105550 <outb>

    // ICW1: 0001g0hi
    //    g: 0 = edge triggering, 1 = level triggering
    //    h: 0 = cascaded PICs, 1 = master only
    //    i: 0 = no ICW4, 1 = ICW4 required
    outb(IO_PIC1, 0x11);
  103c4d:	58                   	pop    %eax
  103c4e:	5a                   	pop    %edx
  103c4f:	6a 11                	push   $0x11
  103c51:	6a 20                	push   $0x20
  103c53:	e8 f8 18 00 00       	call   105550 <outb>

    // ICW2: Vector offset
    outb(IO_PIC1 + 1, T_IRQ0);
  103c58:	59                   	pop    %ecx
  103c59:	5e                   	pop    %esi
  103c5a:	6a 20                	push   $0x20
  103c5c:	6a 21                	push   $0x21
  103c5e:	e8 ed 18 00 00       	call   105550 <outb>

    // ICW3: (master PIC) bit mask of IR lines connected to slaves
    //       (slave PIC) 3-bit # of slave's connection to master
    outb(IO_PIC1 + 1, 1 << IRQ_SLAVE);
  103c63:	58                   	pop    %eax
  103c64:	5a                   	pop    %edx
  103c65:	6a 04                	push   $0x4
  103c67:	6a 21                	push   $0x21
  103c69:	e8 e2 18 00 00       	call   105550 <outb>
    //    m: 0 = slave PIC, 1 = master PIC
    //       (ignored when b is 0, as the master/slave role
    //       can be hardwired).
    //    a: 1 = Automatic EOI mode
    //    p: 0 = MCS-80/85 mode, 1 = intel x86 mode
    outb(IO_PIC1 + 1, 0x3);
  103c6e:	59                   	pop    %ecx
  103c6f:	5e                   	pop    %esi
  103c70:	6a 03                	push   $0x3
  103c72:	6a 21                	push   $0x21
  103c74:	e8 d7 18 00 00       	call   105550 <outb>

    // Set up slave (8259A-2)
    outb(IO_PIC2, 0x11);            // ICW1
  103c79:	58                   	pop    %eax
  103c7a:	5a                   	pop    %edx
  103c7b:	6a 11                	push   $0x11
  103c7d:	68 a0 00 00 00       	push   $0xa0
  103c82:	e8 c9 18 00 00       	call   105550 <outb>
    outb(IO_PIC2 + 1, T_IRQ0 + 8);  // ICW2
  103c87:	59                   	pop    %ecx
  103c88:	5e                   	pop    %esi
  103c89:	6a 28                	push   $0x28
  103c8b:	68 a1 00 00 00       	push   $0xa1
  103c90:	e8 bb 18 00 00       	call   105550 <outb>
    outb(IO_PIC2 + 1, IRQ_SLAVE);   // ICW3
  103c95:	58                   	pop    %eax
  103c96:	5a                   	pop    %edx
  103c97:	6a 02                	push   $0x2
  103c99:	68 a1 00 00 00       	push   $0xa1
  103c9e:	e8 ad 18 00 00       	call   105550 <outb>
    // NB Automatic EOI mode doesn't tend to work on the slave.
    // Linux source code says it's "to be investigated".
    outb(IO_PIC2 + 1, 0x3);         // ICW4
  103ca3:	59                   	pop    %ecx
  103ca4:	5e                   	pop    %esi
  103ca5:	6a 03                	push   $0x3
  103ca7:	68 a1 00 00 00       	push   $0xa1
  103cac:	e8 9f 18 00 00       	call   105550 <outb>

    // OCW3: 0ef01prs
    //   ef: 0x = NOP, 10 = clear specific mask, 11 = set specific mask
    //    p: 0 = no polling, 1 = polling mode
    //   rs: 0x = NOP, 10 = read IRR, 11 = read ISR
    outb(IO_PIC1, 0x68);  // clear specific mask
  103cb1:	58                   	pop    %eax
  103cb2:	5a                   	pop    %edx
  103cb3:	6a 68                	push   $0x68
  103cb5:	6a 20                	push   $0x20
  103cb7:	e8 94 18 00 00       	call   105550 <outb>
    outb(IO_PIC1, 0x0a);  // read IRR by default
  103cbc:	59                   	pop    %ecx
  103cbd:	5e                   	pop    %esi
  103cbe:	6a 0a                	push   $0xa
  103cc0:	6a 20                	push   $0x20
  103cc2:	e8 89 18 00 00       	call   105550 <outb>

    outb(IO_PIC2, 0x68);  // OCW3
  103cc7:	58                   	pop    %eax
  103cc8:	5a                   	pop    %edx
  103cc9:	6a 68                	push   $0x68
  103ccb:	68 a0 00 00 00       	push   $0xa0
  103cd0:	e8 7b 18 00 00       	call   105550 <outb>
    outb(IO_PIC2, 0x0a);  // OCW3
  103cd5:	59                   	pop    %ecx
  103cd6:	5e                   	pop    %esi
  103cd7:	6a 0a                	push   $0xa
  103cd9:	68 a0 00 00 00       	push   $0xa0
  103cde:	e8 6d 18 00 00       	call   105550 <outb>

    if (irqmask != 0xFFFF)
  103ce3:	0f b7 b3 28 03 00 00 	movzwl 0x328(%ebx),%esi
  103cea:	83 c4 10             	add    $0x10,%esp
  103ced:	66 83 fe ff          	cmp    $0xffff,%si
  103cf1:	74 27                	je     103d1a <picinit+0xfa>
    outb(IO_PIC1 + 1, mask);
  103cf3:	89 f0                	mov    %esi,%eax
  103cf5:	83 ec 08             	sub    $0x8,%esp
    outb(IO_PIC2 + 1, mask >> 8);
  103cf8:	66 c1 ee 08          	shr    $0x8,%si
    outb(IO_PIC1 + 1, mask);
  103cfc:	0f b6 c0             	movzbl %al,%eax
    outb(IO_PIC2 + 1, mask >> 8);
  103cff:	0f b7 f6             	movzwl %si,%esi
    outb(IO_PIC1 + 1, mask);
  103d02:	50                   	push   %eax
  103d03:	6a 21                	push   $0x21
  103d05:	e8 46 18 00 00       	call   105550 <outb>
    outb(IO_PIC2 + 1, mask >> 8);
  103d0a:	58                   	pop    %eax
  103d0b:	5a                   	pop    %edx
  103d0c:	56                   	push   %esi
  103d0d:	68 a1 00 00 00       	push   $0xa1
  103d12:	e8 39 18 00 00       	call   105550 <outb>
}
  103d17:	83 c4 10             	add    $0x10,%esp
        picsetmask(irqmask);
}
  103d1a:	83 c4 04             	add    $0x4,%esp
  103d1d:	5b                   	pop    %ebx
  103d1e:	5e                   	pop    %esi
  103d1f:	c3                   	ret    

00103d20 <ide_start>:

/**
 * Start the request for b.  Caller must hold ide_lk.
 */
static void ide_start(struct buf *b)
{
  103d20:	56                   	push   %esi
  103d21:	89 c6                	mov    %eax,%esi
  103d23:	53                   	push   %ebx
  103d24:	e8 60 c6 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  103d29:	81 c3 d7 02 01 00    	add    $0x102d7,%ebx
  103d2f:	83 ec 04             	sub    $0x4,%esp
    if (b == 0)
  103d32:	85 c0                	test   %eax,%eax
  103d34:	0f 84 e6 00 00 00    	je     103e20 <ide_start+0x100>
  103d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while (((r = inb(0x1f7)) & (IDE_BSY | IDE_DRDY)) != IDE_DRDY);
  103d40:	83 ec 0c             	sub    $0xc,%esp
  103d43:	68 f7 01 00 00       	push   $0x1f7
  103d48:	e8 d3 17 00 00       	call   105520 <inb>
  103d4d:	83 c4 10             	add    $0x10,%esp
  103d50:	83 e0 c0             	and    $0xffffffc0,%eax
  103d53:	3c 40                	cmp    $0x40,%al
  103d55:	75 e9                	jne    103d40 <ide_start+0x20>
        KERN_PANIC("ide_start");

    ide_wait(0);
    outb(0x3f6, 0);  // generate interrupt
  103d57:	83 ec 08             	sub    $0x8,%esp
  103d5a:	6a 00                	push   $0x0
  103d5c:	68 f6 03 00 00       	push   $0x3f6
  103d61:	e8 ea 17 00 00       	call   105550 <outb>
    outb(0x1f2, 1);  // number of sectors
  103d66:	58                   	pop    %eax
  103d67:	5a                   	pop    %edx
  103d68:	6a 01                	push   $0x1
  103d6a:	68 f2 01 00 00       	push   $0x1f2
  103d6f:	e8 dc 17 00 00       	call   105550 <outb>
    outb(0x1f3, b->sector & 0xff);
  103d74:	59                   	pop    %ecx
  103d75:	58                   	pop    %eax
  103d76:	0f b6 46 08          	movzbl 0x8(%esi),%eax
  103d7a:	50                   	push   %eax
  103d7b:	68 f3 01 00 00       	push   $0x1f3
  103d80:	e8 cb 17 00 00       	call   105550 <outb>
    outb(0x1f4, (b->sector >> 8) & 0xff);
  103d85:	58                   	pop    %eax
  103d86:	0f b6 46 09          	movzbl 0x9(%esi),%eax
  103d8a:	5a                   	pop    %edx
  103d8b:	50                   	push   %eax
  103d8c:	68 f4 01 00 00       	push   $0x1f4
  103d91:	e8 ba 17 00 00       	call   105550 <outb>
    outb(0x1f5, (b->sector >> 16) & 0xff);
  103d96:	59                   	pop    %ecx
  103d97:	58                   	pop    %eax
  103d98:	0f b6 46 0a          	movzbl 0xa(%esi),%eax
  103d9c:	50                   	push   %eax
  103d9d:	68 f5 01 00 00       	push   $0x1f5
  103da2:	e8 a9 17 00 00       	call   105550 <outb>
    outb(0x1f6, 0xe0 | ((b->dev & 1) << 4) | ((b->sector >> 24) & 0x0f));
  103da7:	58                   	pop    %eax
  103da8:	0f b6 46 04          	movzbl 0x4(%esi),%eax
  103dac:	5a                   	pop    %edx
  103dad:	0f b6 56 0b          	movzbl 0xb(%esi),%edx
  103db1:	c1 e0 04             	shl    $0x4,%eax
  103db4:	83 e2 0f             	and    $0xf,%edx
  103db7:	83 e0 10             	and    $0x10,%eax
  103dba:	09 d0                	or     %edx,%eax
  103dbc:	83 c8 e0             	or     $0xffffffe0,%eax
  103dbf:	0f b6 c0             	movzbl %al,%eax
  103dc2:	50                   	push   %eax
  103dc3:	68 f6 01 00 00       	push   $0x1f6
  103dc8:	e8 83 17 00 00       	call   105550 <outb>
    if (b->flags & B_DIRTY) {
  103dcd:	83 c4 10             	add    $0x10,%esp
  103dd0:	f6 06 04             	testb  $0x4,(%esi)
  103dd3:	74 33                	je     103e08 <ide_start+0xe8>
        outb(0x1f7, IDE_CMD_WRITE);
  103dd5:	83 ec 08             	sub    $0x8,%esp
        outsl(0x1f0, b->data, 512 / 4);
  103dd8:	83 c6 18             	add    $0x18,%esi
        outb(0x1f7, IDE_CMD_WRITE);
  103ddb:	6a 30                	push   $0x30
  103ddd:	68 f7 01 00 00       	push   $0x1f7
  103de2:	e8 69 17 00 00       	call   105550 <outb>
        outsl(0x1f0, b->data, 512 / 4);
  103de7:	83 c4 0c             	add    $0xc,%esp
  103dea:	68 80 00 00 00       	push   $0x80
  103def:	56                   	push   %esi
  103df0:	68 f0 01 00 00       	push   $0x1f0
  103df5:	e8 86 17 00 00       	call   105580 <outsl>
  103dfa:	83 c4 10             	add    $0x10,%esp
    } else {
        outb(0x1f7, IDE_CMD_READ);
    }
}
  103dfd:	83 c4 04             	add    $0x4,%esp
  103e00:	5b                   	pop    %ebx
  103e01:	5e                   	pop    %esi
  103e02:	c3                   	ret    
  103e03:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103e07:	90                   	nop
        outb(0x1f7, IDE_CMD_READ);
  103e08:	83 ec 08             	sub    $0x8,%esp
  103e0b:	6a 20                	push   $0x20
  103e0d:	68 f7 01 00 00       	push   $0x1f7
  103e12:	e8 39 17 00 00       	call   105550 <outb>
  103e17:	83 c4 10             	add    $0x10,%esp
}
  103e1a:	83 c4 04             	add    $0x4,%esp
  103e1d:	5b                   	pop    %ebx
  103e1e:	5e                   	pop    %esi
  103e1f:	c3                   	ret    
        KERN_PANIC("ide_start");
  103e20:	83 ec 04             	sub    $0x4,%esp
  103e23:	8d 83 f8 81 ff ff    	lea    -0x7e08(%ebx),%eax
  103e29:	50                   	push   %eax
  103e2a:	8d 83 02 82 ff ff    	lea    -0x7dfe(%ebx),%eax
  103e30:	6a 3e                	push   $0x3e
  103e32:	50                   	push   %eax
  103e33:	e8 d8 08 00 00       	call   104710 <debug_panic>
  103e38:	83 c4 10             	add    $0x10,%esp
  103e3b:	e9 00 ff ff ff       	jmp    103d40 <ide_start+0x20>

00103e40 <ide_init>:
{
  103e40:	56                   	push   %esi
  103e41:	53                   	push   %ebx
  103e42:	e8 42 c5 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  103e47:	81 c3 b9 01 01 00    	add    $0x101b9,%ebx
  103e4d:	83 ec 10             	sub    $0x10,%esp
    spinlock_init(&ide_lk);
  103e50:	8d 83 74 b9 03 00    	lea    0x3b974(%ebx),%eax
  103e56:	50                   	push   %eax
  103e57:	e8 84 1f 00 00       	call   105de0 <spinlock_init>
    picenable(IRQ_IDE1);
  103e5c:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  103e63:	e8 68 fd ff ff       	call   103bd0 <picenable>
    ioapicenable(IRQ_IDE1, pcpu_ncpu() - 1);
  103e68:	e8 a3 fb ff ff       	call   103a10 <pcpu_ncpu>
  103e6d:	5a                   	pop    %edx
  103e6e:	59                   	pop    %ecx
  103e6f:	83 e8 01             	sub    $0x1,%eax
  103e72:	50                   	push   %eax
  103e73:	6a 0e                	push   $0xe
  103e75:	e8 16 fd ff ff       	call   103b90 <ioapicenable>
    while (((r = inb(0x1f7)) & (IDE_BSY | IDE_DRDY)) != IDE_DRDY);
  103e7a:	83 c4 10             	add    $0x10,%esp
  103e7d:	8d 76 00             	lea    0x0(%esi),%esi
  103e80:	83 ec 0c             	sub    $0xc,%esp
  103e83:	68 f7 01 00 00       	push   $0x1f7
  103e88:	e8 93 16 00 00       	call   105520 <inb>
  103e8d:	83 c4 10             	add    $0x10,%esp
  103e90:	83 e0 c0             	and    $0xffffffc0,%eax
  103e93:	3c 40                	cmp    $0x40,%al
  103e95:	75 e9                	jne    103e80 <ide_init+0x40>
    outb(0x1f6, 0xe0 | (1 << 4));
  103e97:	83 ec 08             	sub    $0x8,%esp
  103e9a:	be e8 03 00 00       	mov    $0x3e8,%esi
  103e9f:	68 f0 00 00 00       	push   $0xf0
  103ea4:	68 f6 01 00 00       	push   $0x1f6
  103ea9:	e8 a2 16 00 00       	call   105550 <outb>
  103eae:	83 c4 10             	add    $0x10,%esp
  103eb1:	eb 0a                	jmp    103ebd <ide_init+0x7d>
  103eb3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103eb7:	90                   	nop
    for (i = 0; i < 1000; i++) {
  103eb8:	83 ee 01             	sub    $0x1,%esi
  103ebb:	74 1e                	je     103edb <ide_init+0x9b>
        if (inb(0x1f7) != 0) {
  103ebd:	83 ec 0c             	sub    $0xc,%esp
  103ec0:	68 f7 01 00 00       	push   $0x1f7
  103ec5:	e8 56 16 00 00       	call   105520 <inb>
  103eca:	83 c4 10             	add    $0x10,%esp
  103ecd:	84 c0                	test   %al,%al
  103ecf:	74 e7                	je     103eb8 <ide_init+0x78>
            havedisk1 = 1;
  103ed1:	c7 83 6c b9 03 00 01 	movl   $0x1,0x3b96c(%ebx)
  103ed8:	00 00 00 
    outb(0x1f6, 0xe0 | (0 << 4));
  103edb:	83 ec 08             	sub    $0x8,%esp
  103ede:	68 e0 00 00 00       	push   $0xe0
  103ee3:	68 f6 01 00 00       	push   $0x1f6
  103ee8:	e8 63 16 00 00       	call   105550 <outb>
}
  103eed:	83 c4 14             	add    $0x14,%esp
  103ef0:	5b                   	pop    %ebx
  103ef1:	5e                   	pop    %esi
  103ef2:	c3                   	ret    
  103ef3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103f00 <ide_intr>:

/**
 * Interrupt handler.
 */
void ide_intr(void)
{
  103f00:	57                   	push   %edi
  103f01:	56                   	push   %esi
  103f02:	53                   	push   %ebx
  103f03:	e8 81 c4 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  103f08:	81 c3 f8 00 01 00    	add    $0x100f8,%ebx
    struct buf *b;

    // First queued buffer is the active request.
    spinlock_acquire(&ide_lk);
  103f0e:	83 ec 0c             	sub    $0xc,%esp
  103f11:	8d b3 74 b9 03 00    	lea    0x3b974(%ebx),%esi
  103f17:	56                   	push   %esi
  103f18:	e8 53 1f 00 00       	call   105e70 <spinlock_acquire>
    if ((b = idequeue) == 0) {
  103f1d:	8b bb 70 b9 03 00    	mov    0x3b970(%ebx),%edi
  103f23:	83 c4 10             	add    $0x10,%esp
  103f26:	85 ff                	test   %edi,%edi
  103f28:	0f 84 82 00 00 00    	je     103fb0 <ide_intr+0xb0>
        spinlock_release(&ide_lk);
        KERN_INFO("spurious IDE interrupt\n");
        return;
    }
    idequeue = b->qnext;
  103f2e:	8b 47 14             	mov    0x14(%edi),%eax
  103f31:	89 83 70 b9 03 00    	mov    %eax,0x3b970(%ebx)

    // Read data if needed.
    if (!(b->flags & B_DIRTY) && ide_wait(1) >= 0)
  103f37:	8b 07                	mov    (%edi),%eax
  103f39:	a8 04                	test   $0x4,%al
  103f3b:	74 33                	je     103f70 <ide_intr+0x70>
        insl(0x1f0, b->data, 512 / 4);

    // Wake process waiting for this buf.
    b->flags |= B_VALID;
    b->flags &= ~B_DIRTY;
  103f3d:	83 e0 fb             	and    $0xfffffffb,%eax
    thread_wakeup(b);
  103f40:	83 ec 0c             	sub    $0xc,%esp
    b->flags &= ~B_DIRTY;
  103f43:	83 c8 02             	or     $0x2,%eax
  103f46:	89 07                	mov    %eax,(%edi)
    thread_wakeup(b);
  103f48:	57                   	push   %edi
  103f49:	e8 b2 3c 00 00       	call   107c00 <thread_wakeup>

    // Start disk on next buf in queue.
    if (idequeue != 0)
  103f4e:	8b 83 70 b9 03 00    	mov    0x3b970(%ebx),%eax
  103f54:	83 c4 10             	add    $0x10,%esp
  103f57:	85 c0                	test   %eax,%eax
  103f59:	74 05                	je     103f60 <ide_intr+0x60>
        ide_start(idequeue);
  103f5b:	e8 c0 fd ff ff       	call   103d20 <ide_start>

    spinlock_release(&ide_lk);
  103f60:	83 ec 0c             	sub    $0xc,%esp
  103f63:	56                   	push   %esi
  103f64:	e8 87 1f 00 00       	call   105ef0 <spinlock_release>
  103f69:	83 c4 10             	add    $0x10,%esp
}
  103f6c:	5b                   	pop    %ebx
  103f6d:	5e                   	pop    %esi
  103f6e:	5f                   	pop    %edi
  103f6f:	c3                   	ret    
    while (((r = inb(0x1f7)) & (IDE_BSY | IDE_DRDY)) != IDE_DRDY);
  103f70:	83 ec 0c             	sub    $0xc,%esp
  103f73:	68 f7 01 00 00       	push   $0x1f7
  103f78:	e8 a3 15 00 00       	call   105520 <inb>
  103f7d:	83 c4 10             	add    $0x10,%esp
  103f80:	89 c2                	mov    %eax,%edx
  103f82:	83 e2 c0             	and    $0xffffffc0,%edx
  103f85:	80 fa 40             	cmp    $0x40,%dl
  103f88:	75 e6                	jne    103f70 <ide_intr+0x70>
    if (checkerr && (r & (IDE_DF | IDE_ERR)) != 0)
  103f8a:	a8 21                	test   $0x21,%al
  103f8c:	75 3e                	jne    103fcc <ide_intr+0xcc>
        insl(0x1f0, b->data, 512 / 4);
  103f8e:	83 ec 04             	sub    $0x4,%esp
  103f91:	8d 47 18             	lea    0x18(%edi),%eax
  103f94:	68 80 00 00 00       	push   $0x80
  103f99:	50                   	push   %eax
  103f9a:	68 f0 01 00 00       	push   $0x1f0
  103f9f:	e8 8c 15 00 00       	call   105530 <insl>
    b->flags |= B_VALID;
  103fa4:	8b 07                	mov    (%edi),%eax
  103fa6:	83 c4 10             	add    $0x10,%esp
  103fa9:	eb 92                	jmp    103f3d <ide_intr+0x3d>
  103fab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103faf:	90                   	nop
        spinlock_release(&ide_lk);
  103fb0:	83 ec 0c             	sub    $0xc,%esp
  103fb3:	56                   	push   %esi
  103fb4:	e8 37 1f 00 00       	call   105ef0 <spinlock_release>
        KERN_INFO("spurious IDE interrupt\n");
  103fb9:	8d 83 16 82 ff ff    	lea    -0x7dea(%ebx),%eax
  103fbf:	89 04 24             	mov    %eax,(%esp)
  103fc2:	e8 a9 06 00 00       	call   104670 <debug_info>
        return;
  103fc7:	83 c4 10             	add    $0x10,%esp
  103fca:	eb a0                	jmp    103f6c <ide_intr+0x6c>
    b->flags |= B_VALID;
  103fcc:	8b 07                	mov    (%edi),%eax
  103fce:	e9 6a ff ff ff       	jmp    103f3d <ide_intr+0x3d>
  103fd3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103fe0 <ide_rw>:
 * Sync buf with disk.
 * If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
 * Else if B_VALID is not set, read buf from disk, set B_VALID.
 */
void ide_rw(struct buf *b)
{
  103fe0:	57                   	push   %edi
  103fe1:	56                   	push   %esi
  103fe2:	53                   	push   %ebx
  103fe3:	8b 7c 24 10          	mov    0x10(%esp),%edi
  103fe7:	e8 9d c3 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  103fec:	81 c3 14 00 01 00    	add    $0x10014,%ebx
    struct buf **pp;

    if (!(b->flags & B_BUSY))
  103ff2:	8b 07                	mov    (%edi),%eax
  103ff4:	a8 01                	test   $0x1,%al
  103ff6:	0f 84 a4 00 00 00    	je     1040a0 <ide_rw+0xc0>
        KERN_PANIC("ide_rw: buf not busy");
    if ((b->flags & (B_VALID | B_DIRTY)) == B_VALID)
  103ffc:	83 e0 06             	and    $0x6,%eax
  103fff:	83 f8 02             	cmp    $0x2,%eax
  104002:	0f 84 c1 00 00 00    	je     1040c9 <ide_rw+0xe9>
        KERN_PANIC("ide_rw: nothing to do");
    if (b->dev != 0 && !havedisk1)
  104008:	8b 57 04             	mov    0x4(%edi),%edx
  10400b:	85 d2                	test   %edx,%edx
  10400d:	74 0e                	je     10401d <ide_rw+0x3d>
  10400f:	8b 83 6c b9 03 00    	mov    0x3b96c(%ebx),%eax
  104015:	85 c0                	test   %eax,%eax
  104017:	0f 84 d3 00 00 00    	je     1040f0 <ide_rw+0x110>
        KERN_PANIC("ide_rw: ide disk 1 not present");

    spinlock_acquire(&ide_lk);
  10401d:	83 ec 0c             	sub    $0xc,%esp
  104020:	8d b3 74 b9 03 00    	lea    0x3b974(%ebx),%esi
  104026:	56                   	push   %esi
  104027:	e8 44 1e 00 00       	call   105e70 <spinlock_acquire>

    // Append b to idequeue.
    b->qnext = 0;
    for (pp = &idequeue; *pp; pp = &(*pp)->qnext)
  10402c:	8b 83 70 b9 03 00    	mov    0x3b970(%ebx),%eax
    b->qnext = 0;
  104032:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
    for (pp = &idequeue; *pp; pp = &(*pp)->qnext)
  104039:	83 c4 10             	add    $0x10,%esp
  10403c:	85 c0                	test   %eax,%eax
  10403e:	0f 84 dc 00 00 00    	je     104120 <ide_rw+0x140>
  104044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104048:	89 c2                	mov    %eax,%edx
  10404a:	8b 40 14             	mov    0x14(%eax),%eax
  10404d:	85 c0                	test   %eax,%eax
  10404f:	75 f7                	jne    104048 <ide_rw+0x68>
  104051:	83 c2 14             	add    $0x14,%edx
        ;
    *pp = b;
  104054:	89 3a                	mov    %edi,(%edx)

    // Start disk if necessary.
    if (idequeue == b)
  104056:	39 bb 70 b9 03 00    	cmp    %edi,0x3b970(%ebx)
  10405c:	0f 84 ae 00 00 00    	je     104110 <ide_rw+0x130>
        ide_start(b);

    // Wait for request to finish.
    while ((b->flags & (B_VALID | B_DIRTY)) != B_VALID) {
  104062:	8b 07                	mov    (%edi),%eax
  104064:	83 e0 06             	and    $0x6,%eax
  104067:	83 f8 02             	cmp    $0x2,%eax
  10406a:	74 1b                	je     104087 <ide_rw+0xa7>
  10406c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        thread_sleep(b, &ide_lk);
  104070:	83 ec 08             	sub    $0x8,%esp
  104073:	56                   	push   %esi
  104074:	57                   	push   %edi
  104075:	e8 46 3b 00 00       	call   107bc0 <thread_sleep>
    while ((b->flags & (B_VALID | B_DIRTY)) != B_VALID) {
  10407a:	8b 07                	mov    (%edi),%eax
  10407c:	83 c4 10             	add    $0x10,%esp
  10407f:	83 e0 06             	and    $0x6,%eax
  104082:	83 f8 02             	cmp    $0x2,%eax
  104085:	75 e9                	jne    104070 <ide_rw+0x90>
    }

    spinlock_release(&ide_lk);
  104087:	83 ec 0c             	sub    $0xc,%esp
  10408a:	56                   	push   %esi
  10408b:	e8 60 1e 00 00       	call   105ef0 <spinlock_release>
}
  104090:	83 c4 10             	add    $0x10,%esp
  104093:	5b                   	pop    %ebx
  104094:	5e                   	pop    %esi
  104095:	5f                   	pop    %edi
  104096:	c3                   	ret    
  104097:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10409e:	66 90                	xchg   %ax,%ax
        KERN_PANIC("ide_rw: buf not busy");
  1040a0:	83 ec 04             	sub    $0x4,%esp
  1040a3:	8d 83 2e 82 ff ff    	lea    -0x7dd2(%ebx),%eax
  1040a9:	50                   	push   %eax
  1040aa:	8d 83 02 82 ff ff    	lea    -0x7dfe(%ebx),%eax
  1040b0:	6a 79                	push   $0x79
  1040b2:	50                   	push   %eax
  1040b3:	e8 58 06 00 00       	call   104710 <debug_panic>
    if ((b->flags & (B_VALID | B_DIRTY)) == B_VALID)
  1040b8:	8b 07                	mov    (%edi),%eax
  1040ba:	83 c4 10             	add    $0x10,%esp
  1040bd:	83 e0 06             	and    $0x6,%eax
  1040c0:	83 f8 02             	cmp    $0x2,%eax
  1040c3:	0f 85 3f ff ff ff    	jne    104008 <ide_rw+0x28>
        KERN_PANIC("ide_rw: nothing to do");
  1040c9:	83 ec 04             	sub    $0x4,%esp
  1040cc:	8d 83 43 82 ff ff    	lea    -0x7dbd(%ebx),%eax
  1040d2:	50                   	push   %eax
  1040d3:	8d 83 02 82 ff ff    	lea    -0x7dfe(%ebx),%eax
  1040d9:	6a 7b                	push   $0x7b
  1040db:	50                   	push   %eax
  1040dc:	e8 2f 06 00 00       	call   104710 <debug_panic>
  1040e1:	83 c4 10             	add    $0x10,%esp
  1040e4:	e9 1f ff ff ff       	jmp    104008 <ide_rw+0x28>
  1040e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        KERN_PANIC("ide_rw: ide disk 1 not present");
  1040f0:	83 ec 04             	sub    $0x4,%esp
  1040f3:	8d 83 5c 82 ff ff    	lea    -0x7da4(%ebx),%eax
  1040f9:	50                   	push   %eax
  1040fa:	8d 83 02 82 ff ff    	lea    -0x7dfe(%ebx),%eax
  104100:	6a 7d                	push   $0x7d
  104102:	50                   	push   %eax
  104103:	e8 08 06 00 00       	call   104710 <debug_panic>
  104108:	83 c4 10             	add    $0x10,%esp
  10410b:	e9 0d ff ff ff       	jmp    10401d <ide_rw+0x3d>
        ide_start(b);
  104110:	89 f8                	mov    %edi,%eax
  104112:	e8 09 fc ff ff       	call   103d20 <ide_start>
  104117:	e9 46 ff ff ff       	jmp    104062 <ide_rw+0x82>
  10411c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for (pp = &idequeue; *pp; pp = &(*pp)->qnext)
  104120:	8d 93 70 b9 03 00    	lea    0x3b970(%ebx),%edx
  104126:	e9 29 ff ff ff       	jmp    104054 <ide_rw+0x74>
  10412b:	66 90                	xchg   %ax,%ax
  10412d:	66 90                	xchg   %ax,%ax
  10412f:	90                   	nop

00104130 <detect_kvm>:
}

#define CPUID_FEATURE_HYPERVISOR	(1<<31) /* Running on a hypervisor */

int detect_kvm(void)
{
  104130:	55                   	push   %ebp
	__asm __volatile("cpuid"
  104131:	b8 01 00 00 00       	mov    $0x1,%eax
{
  104136:	57                   	push   %edi
  104137:	e8 08 02 00 00       	call   104344 <__x86.get_pc_thunk.di>
  10413c:	81 c7 c4 fe 00 00    	add    $0xfec4,%edi
  104142:	56                   	push   %esi
	__asm __volatile("cpuid"
  104143:	31 f6                	xor    %esi,%esi
{
  104145:	53                   	push   %ebx
	__asm __volatile("cpuid"
  104146:	89 f1                	mov    %esi,%ecx
{
  104148:	83 ec 2c             	sub    $0x2c,%esp
	__asm __volatile("cpuid"
  10414b:	0f a2                	cpuid  
	uint32_t eax;

	if (cpu_has (CPUID_FEATURE_HYPERVISOR))
  10414d:	83 e2 01             	and    $0x1,%edx
  104150:	89 d5                	mov    %edx,%ebp
  104152:	75 0c                	jne    104160 <detect_kvm+0x30>
		{
			return 1;
		}
	}
	return 0;
}
  104154:	83 c4 2c             	add    $0x2c,%esp
  104157:	89 e8                	mov    %ebp,%eax
  104159:	5b                   	pop    %ebx
  10415a:	5e                   	pop    %esi
  10415b:	5f                   	pop    %edi
  10415c:	5d                   	pop    %ebp
  10415d:	c3                   	ret    
  10415e:	66 90                	xchg   %ax,%ax
		cpuid (CPUID_KVM_SIGNATURE, &eax, &hyper_vendor_id[0],
  104160:	83 ec 0c             	sub    $0xc,%esp
  104163:	89 fb                	mov    %edi,%ebx
  104165:	8d 54 24 28          	lea    0x28(%esp),%edx
  104169:	8d 44 24 20          	lea    0x20(%esp),%eax
  10416d:	52                   	push   %edx
  10416e:	8d 54 24 28          	lea    0x28(%esp),%edx
  104172:	52                   	push   %edx
  104173:	50                   	push   %eax
  104174:	8d 54 24 28          	lea    0x28(%esp),%edx
  104178:	89 44 24 24          	mov    %eax,0x24(%esp)
  10417c:	52                   	push   %edx
  10417d:	68 00 00 00 40       	push   $0x40000000
  104182:	e8 69 12 00 00       	call   1053f0 <cpuid>
		if (!strncmp ("KVMKVMKVM", (const char *) hyper_vendor_id, 9))
  104187:	83 c4 1c             	add    $0x1c,%esp
  10418a:	6a 09                	push   $0x9
  10418c:	8b 44 24 14          	mov    0x14(%esp),%eax
  104190:	50                   	push   %eax
  104191:	8d 87 7b 82 ff ff    	lea    -0x7d85(%edi),%eax
  104197:	50                   	push   %eax
  104198:	e8 83 02 00 00       	call   104420 <strncmp>
  10419d:	83 c4 10             	add    $0x10,%esp
	return 0;
  1041a0:	85 c0                	test   %eax,%eax
  1041a2:	0f 45 ee             	cmovne %esi,%ebp
}
  1041a5:	83 c4 2c             	add    $0x2c,%esp
  1041a8:	5b                   	pop    %ebx
  1041a9:	5e                   	pop    %esi
  1041aa:	89 e8                	mov    %ebp,%eax
  1041ac:	5f                   	pop    %edi
  1041ad:	5d                   	pop    %ebp
  1041ae:	c3                   	ret    
  1041af:	90                   	nop

001041b0 <kvm_has_feature>:

int
kvm_has_feature(uint32_t feature)
{
  1041b0:	53                   	push   %ebx
  1041b1:	e8 d3 c1 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1041b6:	81 c3 4a fe 00 00    	add    $0xfe4a,%ebx
  1041bc:	83 ec 24             	sub    $0x24,%esp
	uint32_t eax, ebx, ecx, edx;
	eax = 0; edx = 0;
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  1041bf:	8d 44 24 18          	lea    0x18(%esp),%eax
	eax = 0; edx = 0;
  1041c3:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1041ca:	00 
  1041cb:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  1041d2:	00 
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  1041d3:	50                   	push   %eax
  1041d4:	8d 44 24 18          	lea    0x18(%esp),%eax
  1041d8:	50                   	push   %eax
  1041d9:	8d 44 24 18          	lea    0x18(%esp),%eax
  1041dd:	50                   	push   %eax
  1041de:	8d 44 24 18          	lea    0x18(%esp),%eax
  1041e2:	50                   	push   %eax
  1041e3:	68 01 00 00 40       	push   $0x40000001
  1041e8:	e8 03 12 00 00       	call   1053f0 <cpuid>

	return ((eax & feature) != 0 ? 1 : 0);
  1041ed:	8b 44 24 40          	mov    0x40(%esp),%eax
  1041f1:	23 44 24 20          	and    0x20(%esp),%eax
  1041f5:	85 c0                	test   %eax,%eax
  1041f7:	0f 95 c0             	setne  %al
}
  1041fa:	83 c4 38             	add    $0x38,%esp
	return ((eax & feature) != 0 ? 1 : 0);
  1041fd:	0f b6 c0             	movzbl %al,%eax
}
  104200:	5b                   	pop    %ebx
  104201:	c3                   	ret    
  104202:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104210 <kvm_enable_feature>:

int
kvm_enable_feature(uint32_t feature)
{
  104210:	53                   	push   %ebx
	uint32_t eax, ebx, ecx, edx;
	eax = 1 << feature; edx = 0;
  104211:	b8 01 00 00 00       	mov    $0x1,%eax
  104216:	e8 6e c1 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10421b:	81 c3 e5 fd 00 00    	add    $0xfde5,%ebx
{
  104221:	83 ec 24             	sub    $0x24,%esp
	eax = 1 << feature; edx = 0;
  104224:	8b 4c 24 2c          	mov    0x2c(%esp),%ecx
  104228:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  10422f:	00 
  104230:	d3 e0                	shl    %cl,%eax
  104232:	89 44 24 0c          	mov    %eax,0xc(%esp)
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  104236:	8d 44 24 18          	lea    0x18(%esp),%eax
  10423a:	50                   	push   %eax
  10423b:	8d 44 24 18          	lea    0x18(%esp),%eax
  10423f:	50                   	push   %eax
  104240:	8d 44 24 18          	lea    0x18(%esp),%eax
  104244:	50                   	push   %eax
  104245:	8d 44 24 18          	lea    0x18(%esp),%eax
  104249:	50                   	push   %eax
  10424a:	68 01 00 00 40       	push   $0x40000001
  10424f:	e8 9c 11 00 00       	call   1053f0 <cpuid>

	return (ebx == 0 ? 1 : 0);
  104254:	8b 54 24 24          	mov    0x24(%esp),%edx
  104258:	31 c0                	xor    %eax,%eax
  10425a:	85 d2                	test   %edx,%edx
  10425c:	0f 94 c0             	sete   %al
}
  10425f:	83 c4 38             	add    $0x38,%esp
  104262:	5b                   	pop    %ebx
  104263:	c3                   	ret    
  104264:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10426b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10426f:	90                   	nop

00104270 <kvm_get_tsc_hz>:

uint64_t
kvm_get_tsc_hz(void)
{
  104270:	55                   	push   %ebp
  104271:	57                   	push   %edi
  104272:	56                   	push   %esi
  104273:	53                   	push   %ebx
  104274:	e8 10 c1 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  104279:	81 c3 87 fd 00 00    	add    $0xfd87,%ebx
  10427f:	83 ec 38             	sub    $0x38,%esp
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  104282:	8d 44 24 28          	lea    0x28(%esp),%eax
	eax = 0; edx = 0;
  104286:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  10428d:	00 
  10428e:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
  104295:	00 
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  104296:	50                   	push   %eax
  104297:	8d 6c 24 28          	lea    0x28(%esp),%ebp
  10429b:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  10429f:	55                   	push   %ebp
  1042a0:	8d 7c 24 28          	lea    0x28(%esp),%edi
  1042a4:	57                   	push   %edi
  1042a5:	8d 74 24 28          	lea    0x28(%esp),%esi
  1042a9:	56                   	push   %esi
  1042aa:	68 01 00 00 40       	push   $0x40000001
  1042af:	e8 3c 11 00 00       	call   1053f0 <cpuid>
	uint64_t tsc_hz = 0llu;
	uint32_t msr_sys_time;

	if (kvm_has_feature(KVM_FEATURE_CLOCKSOURCE2))
  1042b4:	83 c4 20             	add    $0x20,%esp
  1042b7:	f6 44 24 10 03       	testb  $0x3,0x10(%esp)
  1042bc:	75 42                	jne    104300 <kvm_get_tsc_hz+0x90>
	eax = 0; edx = 0;
  1042be:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  1042c5:	00 
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  1042c6:	83 ec 0c             	sub    $0xc,%esp
	eax = 0; edx = 0;
  1042c9:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
  1042d0:	00 
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  1042d1:	8b 44 24 18          	mov    0x18(%esp),%eax
  1042d5:	50                   	push   %eax
  1042d6:	55                   	push   %ebp
  1042d7:	57                   	push   %edi
	{
		msr_sys_time = MSR_KVM_SYSTEM_TIME;
	}
	else
	{
		return (0llu);
  1042d8:	31 ff                	xor    %edi,%edi
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  1042da:	56                   	push   %esi
		return (0llu);
  1042db:	31 f6                	xor    %esi,%esi
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  1042dd:	68 01 00 00 40       	push   $0x40000001
  1042e2:	e8 09 11 00 00       	call   1053f0 <cpuid>
	return ((eax & feature) != 0 ? 1 : 0);
  1042e7:	83 c4 20             	add    $0x20,%esp

	/* disable update */
	wrmsr(msr_sys_time, (uint64_t) ((uint32_t) &pvclock));

	return tsc_hz;
}
  1042ea:	89 f0                	mov    %esi,%eax
  1042ec:	89 fa                	mov    %edi,%edx
  1042ee:	83 c4 2c             	add    $0x2c,%esp
  1042f1:	5b                   	pop    %ebx
  1042f2:	5e                   	pop    %esi
  1042f3:	5f                   	pop    %edi
  1042f4:	5d                   	pop    %ebp
  1042f5:	c3                   	ret    
  1042f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1042fd:	8d 76 00             	lea    0x0(%esi),%esi
	wrmsr(msr_sys_time, (uint64_t) ((uint32_t) &pvclock) | 0x1llu);
  104300:	8d ab 80 b9 03 00    	lea    0x3b980(%ebx),%ebp
  104306:	83 ec 04             	sub    $0x4,%esp
  104309:	31 d2                	xor    %edx,%edx
	tsc_hz = (uint64_t) pvclock.tsc_to_system_mul;
  10430b:	31 ff                	xor    %edi,%edi
	wrmsr(msr_sys_time, (uint64_t) ((uint32_t) &pvclock) | 0x1llu);
  10430d:	89 e8                	mov    %ebp,%eax
  10430f:	52                   	push   %edx
  104310:	83 c8 01             	or     $0x1,%eax
  104313:	50                   	push   %eax
  104314:	68 01 4d 56 4b       	push   $0x4b564d01
  104319:	e8 42 10 00 00       	call   105360 <wrmsr>
	wrmsr(msr_sys_time, (uint64_t) ((uint32_t) &pvclock));
  10431e:	83 c4 0c             	add    $0xc,%esp
  104321:	31 d2                	xor    %edx,%edx
	tsc_hz = (uint64_t) pvclock.tsc_to_system_mul;
  104323:	8b b3 98 b9 03 00    	mov    0x3b998(%ebx),%esi
	wrmsr(msr_sys_time, (uint64_t) ((uint32_t) &pvclock));
  104329:	52                   	push   %edx
  10432a:	55                   	push   %ebp
  10432b:	68 01 4d 56 4b       	push   $0x4b564d01
  104330:	e8 2b 10 00 00       	call   105360 <wrmsr>
	return tsc_hz;
  104335:	83 c4 10             	add    $0x10,%esp
}
  104338:	89 f0                	mov    %esi,%eax
  10433a:	89 fa                	mov    %edi,%edx
  10433c:	83 c4 2c             	add    $0x2c,%esp
  10433f:	5b                   	pop    %ebx
  104340:	5e                   	pop    %esi
  104341:	5f                   	pop    %edi
  104342:	5d                   	pop    %ebp
  104343:	c3                   	ret    

00104344 <__x86.get_pc_thunk.di>:
  104344:	8b 3c 24             	mov    (%esp),%edi
  104347:	c3                   	ret    
  104348:	66 90                	xchg   %ax,%ax
  10434a:	66 90                	xchg   %ax,%ax
  10434c:	66 90                	xchg   %ax,%ax
  10434e:	66 90                	xchg   %ax,%ax

00104350 <memset>:
#include "string.h"
#include "types.h"

void *memset(void *v, int c, size_t n)
{
  104350:	57                   	push   %edi
  104351:	56                   	push   %esi
  104352:	53                   	push   %ebx
  104353:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  104357:	8b 7c 24 10          	mov    0x10(%esp),%edi
    if (n == 0)
  10435b:	85 c9                	test   %ecx,%ecx
  10435d:	74 28                	je     104387 <memset+0x37>
        return v;
    if ((int) v % 4 == 0 && n % 4 == 0) {
  10435f:	89 f8                	mov    %edi,%eax
  104361:	09 c8                	or     %ecx,%eax
  104363:	a8 03                	test   $0x3,%al
  104365:	75 29                	jne    104390 <memset+0x40>
        c &= 0xFF;
  104367:	0f b6 5c 24 14       	movzbl 0x14(%esp),%ebx
        c = (c << 24) | (c << 16) | (c << 8) | c;
        asm volatile ("cld; rep stosl\n"
                      :: "D" (v), "a" (c), "c" (n / 4)
  10436c:	c1 e9 02             	shr    $0x2,%ecx
        c = (c << 24) | (c << 16) | (c << 8) | c;
  10436f:	89 da                	mov    %ebx,%edx
  104371:	89 de                	mov    %ebx,%esi
  104373:	89 d8                	mov    %ebx,%eax
  104375:	c1 e2 18             	shl    $0x18,%edx
  104378:	c1 e6 10             	shl    $0x10,%esi
  10437b:	09 f2                	or     %esi,%edx
  10437d:	c1 e0 08             	shl    $0x8,%eax
  104380:	09 da                	or     %ebx,%edx
  104382:	09 d0                	or     %edx,%eax
        asm volatile ("cld; rep stosl\n"
  104384:	fc                   	cld    
  104385:	f3 ab                	rep stos %eax,%es:(%edi)
    } else
        asm volatile ("cld; rep stosb\n"
                      :: "D" (v), "a" (c), "c" (n)
                      : "cc", "memory");
    return v;
}
  104387:	89 f8                	mov    %edi,%eax
  104389:	5b                   	pop    %ebx
  10438a:	5e                   	pop    %esi
  10438b:	5f                   	pop    %edi
  10438c:	c3                   	ret    
  10438d:	8d 76 00             	lea    0x0(%esi),%esi
        asm volatile ("cld; rep stosb\n"
  104390:	8b 44 24 14          	mov    0x14(%esp),%eax
  104394:	fc                   	cld    
  104395:	f3 aa                	rep stos %al,%es:(%edi)
}
  104397:	89 f8                	mov    %edi,%eax
  104399:	5b                   	pop    %ebx
  10439a:	5e                   	pop    %esi
  10439b:	5f                   	pop    %edi
  10439c:	c3                   	ret    
  10439d:	8d 76 00             	lea    0x0(%esi),%esi

001043a0 <memmove>:

void *memmove(void *dst, const void *src, size_t n)
{
  1043a0:	57                   	push   %edi
  1043a1:	56                   	push   %esi
  1043a2:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1043a6:	8b 74 24 10          	mov    0x10(%esp),%esi
  1043aa:	8b 4c 24 14          	mov    0x14(%esp),%ecx
    const char *s;
    char *d;

    s = src;
    d = dst;
    if (s < d && s + n > d) {
  1043ae:	39 c6                	cmp    %eax,%esi
  1043b0:	73 26                	jae    1043d8 <memmove+0x38>
  1043b2:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
  1043b5:	39 c2                	cmp    %eax,%edx
  1043b7:	76 1f                	jbe    1043d8 <memmove+0x38>
        s += n;
        d += n;
  1043b9:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
  1043bc:	89 d6                	mov    %edx,%esi
  1043be:	09 fe                	or     %edi,%esi
  1043c0:	09 ce                	or     %ecx,%esi
  1043c2:	83 e6 03             	and    $0x3,%esi
  1043c5:	74 39                	je     104400 <memmove+0x60>
            asm volatile ("std; rep movsl\n"
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
                          : "cc", "memory");
        else
            asm volatile ("std; rep movsb\n"
                          :: "D" (d - 1), "S" (s - 1), "c" (n)
  1043c7:	83 ef 01             	sub    $0x1,%edi
  1043ca:	8d 72 ff             	lea    -0x1(%edx),%esi
            asm volatile ("std; rep movsb\n"
  1043cd:	fd                   	std    
  1043ce:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
                          : "cc", "memory");
        // Some versions of GCC rely on DF being clear
        asm volatile ("cld" ::: "cc");
  1043d0:	fc                   	cld    
            asm volatile ("cld; rep movsb\n"
                          :: "D" (d), "S" (s), "c" (n)
                          : "cc", "memory");
    }
    return dst;
}
  1043d1:	5e                   	pop    %esi
  1043d2:	5f                   	pop    %edi
  1043d3:	c3                   	ret    
  1043d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
  1043d8:	89 f2                	mov    %esi,%edx
  1043da:	09 c2                	or     %eax,%edx
  1043dc:	09 ca                	or     %ecx,%edx
  1043de:	83 e2 03             	and    $0x3,%edx
  1043e1:	74 0d                	je     1043f0 <memmove+0x50>
            asm volatile ("cld; rep movsb\n"
  1043e3:	89 c7                	mov    %eax,%edi
  1043e5:	fc                   	cld    
  1043e6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
}
  1043e8:	5e                   	pop    %esi
  1043e9:	5f                   	pop    %edi
  1043ea:	c3                   	ret    
  1043eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1043ef:	90                   	nop
                          :: "D" (d), "S" (s), "c" (n / 4)
  1043f0:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("cld; rep movsl\n"
  1043f3:	89 c7                	mov    %eax,%edi
  1043f5:	fc                   	cld    
  1043f6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  1043f8:	eb ee                	jmp    1043e8 <memmove+0x48>
  1043fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
  104400:	83 ef 04             	sub    $0x4,%edi
  104403:	8d 72 fc             	lea    -0x4(%edx),%esi
  104406:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("std; rep movsl\n"
  104409:	fd                   	std    
  10440a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  10440c:	eb c2                	jmp    1043d0 <memmove+0x30>
  10440e:	66 90                	xchg   %ax,%ax

00104410 <memcpy>:

void *memcpy(void *dst, const void *src, size_t n)
{
    return memmove(dst, src, n);
  104410:	eb 8e                	jmp    1043a0 <memmove>
  104412:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104420 <strncmp>:
}

int strncmp(const char *p, const char *q, size_t n)
{
  104420:	56                   	push   %esi
  104421:	53                   	push   %ebx
  104422:	8b 74 24 14          	mov    0x14(%esp),%esi
  104426:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  10442a:	8b 44 24 10          	mov    0x10(%esp),%eax
    while (n > 0 && *p && *p == *q)
  10442e:	85 f6                	test   %esi,%esi
  104430:	74 2e                	je     104460 <strncmp+0x40>
  104432:	01 c6                	add    %eax,%esi
  104434:	eb 18                	jmp    10444e <strncmp+0x2e>
  104436:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10443d:	8d 76 00             	lea    0x0(%esi),%esi
  104440:	38 da                	cmp    %bl,%dl
  104442:	75 14                	jne    104458 <strncmp+0x38>
        n--, p++, q++;
  104444:	83 c0 01             	add    $0x1,%eax
  104447:	83 c1 01             	add    $0x1,%ecx
    while (n > 0 && *p && *p == *q)
  10444a:	39 f0                	cmp    %esi,%eax
  10444c:	74 12                	je     104460 <strncmp+0x40>
  10444e:	0f b6 11             	movzbl (%ecx),%edx
  104451:	0f b6 18             	movzbl (%eax),%ebx
  104454:	84 d2                	test   %dl,%dl
  104456:	75 e8                	jne    104440 <strncmp+0x20>
    if (n == 0)
        return 0;
    else
        return (int) ((unsigned char) *p - (unsigned char) *q);
  104458:	0f b6 c2             	movzbl %dl,%eax
  10445b:	29 d8                	sub    %ebx,%eax
}
  10445d:	5b                   	pop    %ebx
  10445e:	5e                   	pop    %esi
  10445f:	c3                   	ret    
        return 0;
  104460:	31 c0                	xor    %eax,%eax
}
  104462:	5b                   	pop    %ebx
  104463:	5e                   	pop    %esi
  104464:	c3                   	ret    
  104465:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10446c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104470 <strnlen>:

int strnlen(const char *s, size_t size)
{
  104470:	8b 54 24 08          	mov    0x8(%esp),%edx
  104474:	8b 4c 24 04          	mov    0x4(%esp),%ecx
    int n;

    for (n = 0; size > 0 && *s != '\0'; s++, size--)
  104478:	31 c0                	xor    %eax,%eax
  10447a:	85 d2                	test   %edx,%edx
  10447c:	75 09                	jne    104487 <strnlen+0x17>
  10447e:	eb 10                	jmp    104490 <strnlen+0x20>
        n++;
  104480:	83 c0 01             	add    $0x1,%eax
    for (n = 0; size > 0 && *s != '\0'; s++, size--)
  104483:	39 d0                	cmp    %edx,%eax
  104485:	74 09                	je     104490 <strnlen+0x20>
  104487:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  10448b:	75 f3                	jne    104480 <strnlen+0x10>
  10448d:	c3                   	ret    
  10448e:	66 90                	xchg   %ax,%ax
    return n;
}
  104490:	c3                   	ret    
  104491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104498:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10449f:	90                   	nop

001044a0 <strcmp>:

int strcmp(const char *p, const char *q)
{
  1044a0:	53                   	push   %ebx
  1044a1:	8b 54 24 08          	mov    0x8(%esp),%edx
  1044a5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    while (*p && *p == *q)
  1044a9:	0f b6 02             	movzbl (%edx),%eax
  1044ac:	84 c0                	test   %al,%al
  1044ae:	75 18                	jne    1044c8 <strcmp+0x28>
  1044b0:	eb 30                	jmp    1044e2 <strcmp+0x42>
  1044b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1044b8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        p++, q++;
  1044bc:	83 c2 01             	add    $0x1,%edx
  1044bf:	8d 59 01             	lea    0x1(%ecx),%ebx
    while (*p && *p == *q)
  1044c2:	84 c0                	test   %al,%al
  1044c4:	74 12                	je     1044d8 <strcmp+0x38>
        p++, q++;
  1044c6:	89 d9                	mov    %ebx,%ecx
    while (*p && *p == *q)
  1044c8:	0f b6 19             	movzbl (%ecx),%ebx
  1044cb:	38 c3                	cmp    %al,%bl
  1044cd:	74 e9                	je     1044b8 <strcmp+0x18>
    return (int) ((unsigned char) *p - (unsigned char) *q);
  1044cf:	29 d8                	sub    %ebx,%eax
}
  1044d1:	5b                   	pop    %ebx
  1044d2:	c3                   	ret    
  1044d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1044d7:	90                   	nop
    return (int) ((unsigned char) *p - (unsigned char) *q);
  1044d8:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  1044dc:	31 c0                	xor    %eax,%eax
  1044de:	29 d8                	sub    %ebx,%eax
}
  1044e0:	5b                   	pop    %ebx
  1044e1:	c3                   	ret    
    return (int) ((unsigned char) *p - (unsigned char) *q);
  1044e2:	0f b6 19             	movzbl (%ecx),%ebx
  1044e5:	31 c0                	xor    %eax,%eax
  1044e7:	eb e6                	jmp    1044cf <strcmp+0x2f>
  1044e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001044f0 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *strchr(const char *s, char c)
{
  1044f0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1044f4:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
    for (; *s; s++)
  1044f9:	0f b6 10             	movzbl (%eax),%edx
  1044fc:	84 d2                	test   %dl,%dl
  1044fe:	75 13                	jne    104513 <strchr+0x23>
  104500:	eb 1e                	jmp    104520 <strchr+0x30>
  104502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104508:	0f b6 50 01          	movzbl 0x1(%eax),%edx
  10450c:	83 c0 01             	add    $0x1,%eax
  10450f:	84 d2                	test   %dl,%dl
  104511:	74 0d                	je     104520 <strchr+0x30>
        if (*s == c)
  104513:	38 d1                	cmp    %dl,%cl
  104515:	75 f1                	jne    104508 <strchr+0x18>
            return (char *) s;
    return 0;
}
  104517:	c3                   	ret    
  104518:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10451f:	90                   	nop
    return 0;
  104520:	31 c0                	xor    %eax,%eax
}
  104522:	c3                   	ret    
  104523:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10452a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104530 <memzero>:

void *memzero(void *v, size_t n)
{
  104530:	57                   	push   %edi
  104531:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  104535:	8b 7c 24 08          	mov    0x8(%esp),%edi
    if (n == 0)
  104539:	85 c9                	test   %ecx,%ecx
  10453b:	74 0f                	je     10454c <memzero+0x1c>
    if ((int) v % 4 == 0 && n % 4 == 0) {
  10453d:	89 f8                	mov    %edi,%eax
  10453f:	09 c8                	or     %ecx,%eax
  104541:	83 e0 03             	and    $0x3,%eax
  104544:	75 0a                	jne    104550 <memzero+0x20>
                      :: "D" (v), "a" (c), "c" (n / 4)
  104546:	c1 e9 02             	shr    $0x2,%ecx
        asm volatile ("cld; rep stosl\n"
  104549:	fc                   	cld    
  10454a:	f3 ab                	rep stos %eax,%es:(%edi)
    return memset(v, 0, n);
}
  10454c:	89 f8                	mov    %edi,%eax
  10454e:	5f                   	pop    %edi
  10454f:	c3                   	ret    
        asm volatile ("cld; rep stosb\n"
  104550:	31 c0                	xor    %eax,%eax
  104552:	fc                   	cld    
  104553:	f3 aa                	rep stos %al,%es:(%edi)
}
  104555:	89 f8                	mov    %edi,%eax
  104557:	5f                   	pop    %edi
  104558:	c3                   	ret    
  104559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104560 <memcmp>:

int memcmp(const void *v1, const void *v2, size_t n)
{
  104560:	56                   	push   %esi
  104561:	53                   	push   %ebx
  104562:	8b 74 24 14          	mov    0x14(%esp),%esi
  104566:	8b 54 24 0c          	mov    0xc(%esp),%edx
  10456a:	8b 44 24 10          	mov    0x10(%esp),%eax
    const uint8_t *s1 = (const uint8_t *) v1;
    const uint8_t *s2 = (const uint8_t *) v2;

    while (n-- > 0) {
  10456e:	85 f6                	test   %esi,%esi
  104570:	74 2e                	je     1045a0 <memcmp+0x40>
  104572:	01 c6                	add    %eax,%esi
  104574:	eb 14                	jmp    10458a <memcmp+0x2a>
  104576:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10457d:	8d 76 00             	lea    0x0(%esi),%esi
        if (*s1 != *s2)
            return (int) *s1 - (int) *s2;
        s1++, s2++;
  104580:	83 c0 01             	add    $0x1,%eax
  104583:	83 c2 01             	add    $0x1,%edx
    while (n-- > 0) {
  104586:	39 f0                	cmp    %esi,%eax
  104588:	74 16                	je     1045a0 <memcmp+0x40>
        if (*s1 != *s2)
  10458a:	0f b6 0a             	movzbl (%edx),%ecx
  10458d:	0f b6 18             	movzbl (%eax),%ebx
  104590:	38 d9                	cmp    %bl,%cl
  104592:	74 ec                	je     104580 <memcmp+0x20>
            return (int) *s1 - (int) *s2;
  104594:	0f b6 c1             	movzbl %cl,%eax
  104597:	29 d8                	sub    %ebx,%eax
    }

    return 0;
}
  104599:	5b                   	pop    %ebx
  10459a:	5e                   	pop    %esi
  10459b:	c3                   	ret    
  10459c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
  1045a0:	31 c0                	xor    %eax,%eax
}
  1045a2:	5b                   	pop    %ebx
  1045a3:	5e                   	pop    %esi
  1045a4:	c3                   	ret    
  1045a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1045ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001045b0 <strncpy>:

char *strncpy(char *s, const char *t, int n)
{
  1045b0:	55                   	push   %ebp
  1045b1:	57                   	push   %edi
  1045b2:	56                   	push   %esi
  1045b3:	53                   	push   %ebx
  1045b4:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1045b8:	8b 6c 24 18          	mov    0x18(%esp),%ebp
  1045bc:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
    char *os;

    os = s;
    while (n-- > 0 && (*s++ = *t++) != 0) {}
  1045c0:	89 f8                	mov    %edi,%eax
  1045c2:	eb 15                	jmp    1045d9 <strncpy+0x29>
  1045c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1045c8:	0f b6 55 00          	movzbl 0x0(%ebp),%edx
  1045cc:	83 c5 01             	add    $0x1,%ebp
  1045cf:	83 c0 01             	add    $0x1,%eax
  1045d2:	88 50 ff             	mov    %dl,-0x1(%eax)
  1045d5:	84 d2                	test   %dl,%dl
  1045d7:	74 09                	je     1045e2 <strncpy+0x32>
  1045d9:	89 cb                	mov    %ecx,%ebx
  1045db:	83 e9 01             	sub    $0x1,%ecx
  1045de:	85 db                	test   %ebx,%ebx
  1045e0:	7f e6                	jg     1045c8 <strncpy+0x18>
    while (n-- > 0)
  1045e2:	89 c2                	mov    %eax,%edx
  1045e4:	85 c9                	test   %ecx,%ecx
  1045e6:	7e 1b                	jle    104603 <strncpy+0x53>
  1045e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1045ef:	90                   	nop
        *s++ = 0;
  1045f0:	83 c2 01             	add    $0x1,%edx
  1045f3:	89 c1                	mov    %eax,%ecx
  1045f5:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
    while (n-- > 0)
  1045f9:	29 d1                	sub    %edx,%ecx
  1045fb:	8d 4c 0b ff          	lea    -0x1(%ebx,%ecx,1),%ecx
  1045ff:	85 c9                	test   %ecx,%ecx
  104601:	7f ed                	jg     1045f0 <strncpy+0x40>
    return os;
}
  104603:	5b                   	pop    %ebx
  104604:	89 f8                	mov    %edi,%eax
  104606:	5e                   	pop    %esi
  104607:	5f                   	pop    %edi
  104608:	5d                   	pop    %ebp
  104609:	c3                   	ret    
  10460a:	66 90                	xchg   %ax,%ax
  10460c:	66 90                	xchg   %ax,%ax
  10460e:	66 90                	xchg   %ax,%ax

00104610 <debug_init>:
#include <lib/reentrant_lock.h>

static reentrantlock debug_lk;

void debug_init(void)
{
  104610:	53                   	push   %ebx
  104611:	e8 73 bd ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  104616:	81 c3 ea f9 00 00    	add    $0xf9ea,%ebx
  10461c:	83 ec 14             	sub    $0x14,%esp
    reentrantlock_init(&debug_lk);
  10461f:	8d 83 a0 b9 03 00    	lea    0x3b9a0(%ebx),%eax
  104625:	50                   	push   %eax
  104626:	e8 95 19 00 00       	call   105fc0 <reentrantlock_init>
}
  10462b:	83 c4 18             	add    $0x18,%esp
  10462e:	5b                   	pop    %ebx
  10462f:	c3                   	ret    

00104630 <debug_lock>:

void debug_lock(void)
{
  104630:	53                   	push   %ebx
  104631:	e8 53 bd ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  104636:	81 c3 ca f9 00 00    	add    $0xf9ca,%ebx
  10463c:	83 ec 14             	sub    $0x14,%esp
    reentrantlock_acquire(&debug_lk);
  10463f:	8d 83 a0 b9 03 00    	lea    0x3b9a0(%ebx),%eax
  104645:	50                   	push   %eax
  104646:	e8 a5 19 00 00       	call   105ff0 <reentrantlock_acquire>
}
  10464b:	83 c4 18             	add    $0x18,%esp
  10464e:	5b                   	pop    %ebx
  10464f:	c3                   	ret    

00104650 <debug_unlock>:

void debug_unlock(void)
{
  104650:	53                   	push   %ebx
  104651:	e8 33 bd ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  104656:	81 c3 aa f9 00 00    	add    $0xf9aa,%ebx
  10465c:	83 ec 14             	sub    $0x14,%esp
    reentrantlock_release(&debug_lk);
  10465f:	8d 83 a0 b9 03 00    	lea    0x3b9a0(%ebx),%eax
  104665:	50                   	push   %eax
  104666:	e8 35 1a 00 00       	call   1060a0 <reentrantlock_release>
}
  10466b:	83 c4 18             	add    $0x18,%esp
  10466e:	5b                   	pop    %ebx
  10466f:	c3                   	ret    

00104670 <debug_info>:

extern int vdprintf(const char *fmt, va_list ap);

void debug_info(const char *fmt, ...)
{
  104670:	56                   	push   %esi
  104671:	53                   	push   %ebx
  104672:	e8 12 bd ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  104677:	81 c3 89 f9 00 00    	add    $0xf989,%ebx
  10467d:	83 ec 10             	sub    $0x10,%esp
    reentrantlock_acquire(&debug_lk);
  104680:	8d b3 a0 b9 03 00    	lea    0x3b9a0(%ebx),%esi
  104686:	56                   	push   %esi
  104687:	e8 64 19 00 00       	call   105ff0 <reentrantlock_acquire>
#ifdef DEBUG_MSG
    debug_lock();
    va_list ap;
    va_start(ap, fmt);
  10468c:	8d 44 24 24          	lea    0x24(%esp),%eax
    vdprintf(fmt, ap);
  104690:	5a                   	pop    %edx
  104691:	59                   	pop    %ecx
  104692:	50                   	push   %eax
  104693:	ff 74 24 1c          	push   0x1c(%esp)
  104697:	e8 34 02 00 00       	call   1048d0 <vdprintf>
    reentrantlock_release(&debug_lk);
  10469c:	89 34 24             	mov    %esi,(%esp)
  10469f:	e8 fc 19 00 00       	call   1060a0 <reentrantlock_release>
    va_end(ap);
    debug_unlock();
#endif
}
  1046a4:	83 c4 14             	add    $0x14,%esp
  1046a7:	5b                   	pop    %ebx
  1046a8:	5e                   	pop    %esi
  1046a9:	c3                   	ret    
  1046aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001046b0 <debug_normal>:

#ifdef DEBUG_MSG

void debug_normal(const char *file, int line, const char *fmt, ...)
{
  1046b0:	56                   	push   %esi
  1046b1:	53                   	push   %ebx
  1046b2:	e8 d2 bc ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1046b7:	81 c3 49 f9 00 00    	add    $0xf949,%ebx
  1046bd:	83 ec 10             	sub    $0x10,%esp
    reentrantlock_acquire(&debug_lk);
  1046c0:	8d b3 a0 b9 03 00    	lea    0x3b9a0(%ebx),%esi
  1046c6:	56                   	push   %esi
  1046c7:	e8 24 19 00 00       	call   105ff0 <reentrantlock_acquire>
    debug_lock();
    dprintf("[D] %s:%d: ", file, line);
  1046cc:	83 c4 0c             	add    $0xc,%esp
  1046cf:	8d 83 85 82 ff ff    	lea    -0x7d7b(%ebx),%eax
  1046d5:	ff 74 24 18          	push   0x18(%esp)
  1046d9:	ff 74 24 18          	push   0x18(%esp)
  1046dd:	50                   	push   %eax
  1046de:	e8 7d 02 00 00       	call   104960 <dprintf>

    va_list ap;
    va_start(ap, fmt);
  1046e3:	8d 44 24 2c          	lea    0x2c(%esp),%eax
    vdprintf(fmt, ap);
  1046e7:	5a                   	pop    %edx
  1046e8:	59                   	pop    %ecx
  1046e9:	50                   	push   %eax
  1046ea:	ff 74 24 24          	push   0x24(%esp)
  1046ee:	e8 dd 01 00 00       	call   1048d0 <vdprintf>
    reentrantlock_release(&debug_lk);
  1046f3:	89 34 24             	mov    %esi,(%esp)
  1046f6:	e8 a5 19 00 00       	call   1060a0 <reentrantlock_release>
    va_end(ap);
    debug_unlock();
}
  1046fb:	83 c4 14             	add    $0x14,%esp
  1046fe:	5b                   	pop    %ebx
  1046ff:	5e                   	pop    %esi
  104700:	c3                   	ret    
  104701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104708:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10470f:	90                   	nop

00104710 <debug_panic>:
    for (; i < DEBUG_TRACEFRAMES; i++)
        eips[i] = 0;
}

gcc_noinline void debug_panic(const char *file, int line, const char *fmt, ...)
{
  104710:	55                   	push   %ebp
  104711:	57                   	push   %edi
  104712:	56                   	push   %esi
  104713:	53                   	push   %ebx
  104714:	e8 70 bc ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  104719:	81 c3 e7 f8 00 00    	add    $0xf8e7,%ebx
  10471f:	83 ec 58             	sub    $0x58,%esp
    reentrantlock_acquire(&debug_lk);
  104722:	8d 83 a0 b9 03 00    	lea    0x3b9a0(%ebx),%eax
  104728:	89 44 24 18          	mov    %eax,0x18(%esp)
  10472c:	50                   	push   %eax
  10472d:	e8 be 18 00 00       	call   105ff0 <reentrantlock_acquire>
    int i;
    uintptr_t eips[DEBUG_TRACEFRAMES];
    va_list ap;

    debug_lock();
    dprintf("[P] %s:%d: ", file, line);
  104732:	83 c4 0c             	add    $0xc,%esp
  104735:	8d 83 91 82 ff ff    	lea    -0x7d6f(%ebx),%eax
  10473b:	ff 74 24 68          	push   0x68(%esp)
  10473f:	ff 74 24 68          	push   0x68(%esp)
  104743:	50                   	push   %eax
  104744:	e8 17 02 00 00       	call   104960 <dprintf>

    va_start(ap, fmt);
  104749:	8d 44 24 7c          	lea    0x7c(%esp),%eax
    vdprintf(fmt, ap);
  10474d:	5a                   	pop    %edx
  10474e:	59                   	pop    %ecx
  10474f:	50                   	push   %eax
  104750:	ff 74 24 74          	push   0x74(%esp)
  104754:	e8 77 01 00 00       	call   1048d0 <vdprintf>
    va_end(ap);

    debug_trace(read_ebp(), eips);
  104759:	e8 b2 0b 00 00       	call   105310 <read_ebp>
    for (i = 0; i < DEBUG_TRACEFRAMES && frame; i++) {
  10475e:	83 c4 10             	add    $0x10,%esp
  104761:	31 c9                	xor    %ecx,%ecx
  104763:	8d 54 24 18          	lea    0x18(%esp),%edx
  104767:	85 c0                	test   %eax,%eax
  104769:	74 1e                	je     104789 <debug_panic+0x79>
  10476b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10476f:	90                   	nop
        eips[i] = frame[1];              /* saved %eip */
  104770:	8b 70 04             	mov    0x4(%eax),%esi
        frame = (uintptr_t *) frame[0];  /* saved %ebp */
  104773:	8b 00                	mov    (%eax),%eax
        eips[i] = frame[1];              /* saved %eip */
  104775:	89 34 8a             	mov    %esi,(%edx,%ecx,4)
    for (i = 0; i < DEBUG_TRACEFRAMES && frame; i++) {
  104778:	83 c1 01             	add    $0x1,%ecx
  10477b:	83 f9 09             	cmp    $0x9,%ecx
  10477e:	7f 04                	jg     104784 <debug_panic+0x74>
  104780:	85 c0                	test   %eax,%eax
  104782:	75 ec                	jne    104770 <debug_panic+0x60>
    for (; i < DEBUG_TRACEFRAMES; i++)
  104784:	83 f9 0a             	cmp    $0xa,%ecx
  104787:	74 14                	je     10479d <debug_panic+0x8d>
  104789:	8d 04 8a             	lea    (%edx,%ecx,4),%eax
  10478c:	8d 4c 24 40          	lea    0x40(%esp),%ecx
        eips[i] = 0;
  104790:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    for (; i < DEBUG_TRACEFRAMES; i++)
  104796:	83 c0 04             	add    $0x4,%eax
  104799:	39 c8                	cmp    %ecx,%eax
  10479b:	75 f3                	jne    104790 <debug_panic+0x80>
  10479d:	89 d5                	mov    %edx,%ebp
  10479f:	8d 7c 24 40          	lea    0x40(%esp),%edi
    for (i = 0; i < DEBUG_TRACEFRAMES && eips[i] != 0; i++)
        dprintf("\tfrom 0x%08x\n", eips[i]);
  1047a3:	8d b3 9d 82 ff ff    	lea    -0x7d63(%ebx),%esi
  1047a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for (i = 0; i < DEBUG_TRACEFRAMES && eips[i] != 0; i++)
  1047b0:	8b 45 00             	mov    0x0(%ebp),%eax
  1047b3:	85 c0                	test   %eax,%eax
  1047b5:	74 14                	je     1047cb <debug_panic+0xbb>
        dprintf("\tfrom 0x%08x\n", eips[i]);
  1047b7:	83 ec 08             	sub    $0x8,%esp
    for (i = 0; i < DEBUG_TRACEFRAMES && eips[i] != 0; i++)
  1047ba:	83 c5 04             	add    $0x4,%ebp
        dprintf("\tfrom 0x%08x\n", eips[i]);
  1047bd:	50                   	push   %eax
  1047be:	56                   	push   %esi
  1047bf:	e8 9c 01 00 00       	call   104960 <dprintf>
    for (i = 0; i < DEBUG_TRACEFRAMES && eips[i] != 0; i++)
  1047c4:	83 c4 10             	add    $0x10,%esp
  1047c7:	39 ef                	cmp    %ebp,%edi
  1047c9:	75 e5                	jne    1047b0 <debug_panic+0xa0>

    dprintf("Kernel Panic !!!\n");
  1047cb:	83 ec 0c             	sub    $0xc,%esp
  1047ce:	8d 83 ab 82 ff ff    	lea    -0x7d55(%ebx),%eax
  1047d4:	50                   	push   %eax
  1047d5:	e8 86 01 00 00       	call   104960 <dprintf>
    reentrantlock_release(&debug_lk);
  1047da:	58                   	pop    %eax
  1047db:	ff 74 24 18          	push   0x18(%esp)
  1047df:	e8 bc 18 00 00       	call   1060a0 <reentrantlock_release>

    debug_unlock();
    halt();
  1047e4:	e8 87 0b 00 00       	call   105370 <halt>
}
  1047e9:	83 c4 5c             	add    $0x5c,%esp
  1047ec:	5b                   	pop    %ebx
  1047ed:	5e                   	pop    %esi
  1047ee:	5f                   	pop    %edi
  1047ef:	5d                   	pop    %ebp
  1047f0:	c3                   	ret    
  1047f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1047f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1047ff:	90                   	nop

00104800 <debug_warn>:

void debug_warn(const char *file, int line, const char *fmt, ...)
{
  104800:	56                   	push   %esi
  104801:	53                   	push   %ebx
  104802:	e8 82 bb ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  104807:	81 c3 f9 f7 00 00    	add    $0xf7f9,%ebx
  10480d:	83 ec 10             	sub    $0x10,%esp
    reentrantlock_acquire(&debug_lk);
  104810:	8d b3 a0 b9 03 00    	lea    0x3b9a0(%ebx),%esi
  104816:	56                   	push   %esi
  104817:	e8 d4 17 00 00       	call   105ff0 <reentrantlock_acquire>
    debug_lock();
    dprintf("[W] %s:%d: ", file, line);
  10481c:	83 c4 0c             	add    $0xc,%esp
  10481f:	8d 83 bd 82 ff ff    	lea    -0x7d43(%ebx),%eax
  104825:	ff 74 24 18          	push   0x18(%esp)
  104829:	ff 74 24 18          	push   0x18(%esp)
  10482d:	50                   	push   %eax
  10482e:	e8 2d 01 00 00       	call   104960 <dprintf>

    va_list ap;
    va_start(ap, fmt);
  104833:	8d 44 24 2c          	lea    0x2c(%esp),%eax
    vdprintf(fmt, ap);
  104837:	5a                   	pop    %edx
  104838:	59                   	pop    %ecx
  104839:	50                   	push   %eax
  10483a:	ff 74 24 24          	push   0x24(%esp)
  10483e:	e8 8d 00 00 00       	call   1048d0 <vdprintf>
    reentrantlock_release(&debug_lk);
  104843:	89 34 24             	mov    %esi,(%esp)
  104846:	e8 55 18 00 00       	call   1060a0 <reentrantlock_release>
    va_end(ap);
    debug_unlock();
}
  10484b:	83 c4 14             	add    $0x14,%esp
  10484e:	5b                   	pop    %ebx
  10484f:	5e                   	pop    %esi
  104850:	c3                   	ret    
  104851:	66 90                	xchg   %ax,%ax
  104853:	66 90                	xchg   %ax,%ax
  104855:	66 90                	xchg   %ax,%ax
  104857:	66 90                	xchg   %ax,%ax
  104859:	66 90                	xchg   %ax,%ax
  10485b:	66 90                	xchg   %ax,%ax
  10485d:	66 90                	xchg   %ax,%ax
  10485f:	90                   	nop

00104860 <putch>:
        str += 1;
    }
}

static void putch(int ch, struct dprintbuf *b)
{
  104860:	57                   	push   %edi
  104861:	56                   	push   %esi
  104862:	53                   	push   %ebx
  104863:	8b 74 24 14          	mov    0x14(%esp),%esi
  104867:	e8 1d bb ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10486c:	81 c3 94 f7 00 00    	add    $0xf794,%ebx
    b->buf[b->idx++] = ch;
  104872:	8b 54 24 10          	mov    0x10(%esp),%edx
  104876:	8b 0e                	mov    (%esi),%ecx
  104878:	8d 41 01             	lea    0x1(%ecx),%eax
  10487b:	89 06                	mov    %eax,(%esi)
  10487d:	88 54 0e 08          	mov    %dl,0x8(%esi,%ecx,1)
    if (b->idx == CONSOLE_BUFFER_SIZE - 1) {
  104881:	3d ff 01 00 00       	cmp    $0x1ff,%eax
  104886:	74 08                	je     104890 <putch+0x30>
        b->buf[b->idx] = 0;
        cputs(b->buf);
        b->idx = 0;
    }
    b->cnt++;
  104888:	83 46 04 01          	addl   $0x1,0x4(%esi)
}
  10488c:	5b                   	pop    %ebx
  10488d:	5e                   	pop    %esi
  10488e:	5f                   	pop    %edi
  10488f:	c3                   	ret    
    while (*str) {
  104890:	0f be 46 08          	movsbl 0x8(%esi),%eax
        b->buf[b->idx] = 0;
  104894:	c6 86 07 02 00 00 00 	movb   $0x0,0x207(%esi)
        cputs(b->buf);
  10489b:	8d 7e 08             	lea    0x8(%esi),%edi
    while (*str) {
  10489e:	84 c0                	test   %al,%al
  1048a0:	74 1c                	je     1048be <putch+0x5e>
  1048a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cons_putc(*str);
  1048a8:	83 ec 0c             	sub    $0xc,%esp
        str += 1;
  1048ab:	83 c7 01             	add    $0x1,%edi
        cons_putc(*str);
  1048ae:	50                   	push   %eax
  1048af:	e8 3c bc ff ff       	call   1004f0 <cons_putc>
    while (*str) {
  1048b4:	0f be 07             	movsbl (%edi),%eax
  1048b7:	83 c4 10             	add    $0x10,%esp
  1048ba:	84 c0                	test   %al,%al
  1048bc:	75 ea                	jne    1048a8 <putch+0x48>
    b->cnt++;
  1048be:	83 46 04 01          	addl   $0x1,0x4(%esi)
        b->idx = 0;
  1048c2:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
}
  1048c8:	5b                   	pop    %ebx
  1048c9:	5e                   	pop    %esi
  1048ca:	5f                   	pop    %edi
  1048cb:	c3                   	ret    
  1048cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001048d0 <vdprintf>:

int vdprintf(const char *fmt, va_list ap)
{
  1048d0:	56                   	push   %esi
  1048d1:	53                   	push   %ebx
  1048d2:	e8 b2 ba ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1048d7:	81 c3 29 f7 00 00    	add    $0xf729,%ebx
  1048dd:	81 ec 14 02 00 00    	sub    $0x214,%esp
    struct dprintbuf b;

    debug_lock();
  1048e3:	e8 48 fd ff ff       	call   104630 <debug_lock>
    b.idx = 0;
  1048e8:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1048ef:	00 
    b.cnt = 0;
  1048f0:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1048f7:	00 
    vprintfmt((void *) putch, &b, fmt, ap);
  1048f8:	ff b4 24 24 02 00 00 	push   0x224(%esp)
  1048ff:	ff b4 24 24 02 00 00 	push   0x224(%esp)
  104906:	8d 44 24 10          	lea    0x10(%esp),%eax
  10490a:	50                   	push   %eax
  10490b:	8d 83 60 08 ff ff    	lea    -0xf7a0(%ebx),%eax
  104911:	50                   	push   %eax
  104912:	e8 49 01 00 00       	call   104a60 <vprintfmt>

    b.buf[b.idx] = 0;
  104917:	8b 44 24 18          	mov    0x18(%esp),%eax
  10491b:	c6 44 04 20 00       	movb   $0x0,0x20(%esp,%eax,1)
    while (*str) {
  104920:	0f be 44 24 20       	movsbl 0x20(%esp),%eax
  104925:	83 c4 10             	add    $0x10,%esp
  104928:	84 c0                	test   %al,%al
  10492a:	74 1a                	je     104946 <vdprintf+0x76>
  10492c:	8d 74 24 10          	lea    0x10(%esp),%esi
        cons_putc(*str);
  104930:	83 ec 0c             	sub    $0xc,%esp
        str += 1;
  104933:	83 c6 01             	add    $0x1,%esi
        cons_putc(*str);
  104936:	50                   	push   %eax
  104937:	e8 b4 bb ff ff       	call   1004f0 <cons_putc>
    while (*str) {
  10493c:	0f be 06             	movsbl (%esi),%eax
  10493f:	83 c4 10             	add    $0x10,%esp
  104942:	84 c0                	test   %al,%al
  104944:	75 ea                	jne    104930 <vdprintf+0x60>
    cputs(b.buf);
    debug_unlock();
  104946:	e8 05 fd ff ff       	call   104650 <debug_unlock>

    return b.cnt;
}
  10494b:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10494f:	81 c4 14 02 00 00    	add    $0x214,%esp
  104955:	5b                   	pop    %ebx
  104956:	5e                   	pop    %esi
  104957:	c3                   	ret    
  104958:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10495f:	90                   	nop

00104960 <dprintf>:

int dprintf(const char *fmt, ...)
{
  104960:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    int cnt;

    va_start(ap, fmt);
  104963:	8d 44 24 14          	lea    0x14(%esp),%eax
    cnt = vdprintf(fmt, ap);
  104967:	83 ec 08             	sub    $0x8,%esp
  10496a:	50                   	push   %eax
  10496b:	ff 74 24 1c          	push   0x1c(%esp)
  10496f:	e8 5c ff ff ff       	call   1048d0 <vdprintf>
    va_end(ap);

    return cnt;
}
  104974:	83 c4 1c             	add    $0x1c,%esp
  104977:	c3                   	ret    
  104978:	66 90                	xchg   %ax,%ax
  10497a:	66 90                	xchg   %ax,%ax
  10497c:	66 90                	xchg   %ax,%ax
  10497e:	66 90                	xchg   %ax,%ax

00104980 <printnum>:
 * Print a number (base <= 16) in reverse order,
 * using specified putch function and associated pointer putdat.
 */
static void printnum(putch_t putch, void *putdat, unsigned long long num,
                     unsigned base, int width, int padc)
{
  104980:	e8 de 05 00 00       	call   104f63 <__x86.get_pc_thunk.cx>
  104985:	81 c1 7b f6 00 00    	add    $0xf67b,%ecx
  10498b:	55                   	push   %ebp
  10498c:	57                   	push   %edi
  10498d:	89 d7                	mov    %edx,%edi
  10498f:	56                   	push   %esi
  104990:	89 c6                	mov    %eax,%esi
  104992:	53                   	push   %ebx
  104993:	83 ec 2c             	sub    $0x2c,%esp
  104996:	8b 54 24 44          	mov    0x44(%esp),%edx
  10499a:	8b 44 24 40          	mov    0x40(%esp),%eax
  10499e:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    /* first recursively print all preceding (more significant) digits */
    if (num >= base) {
        printnum(putch, putdat, num / base, base, width - 1, padc);
    } else {
        /* print any needed pad characters before first digit */
        while (--width > 0)
  1049a2:	8b 4c 24 4c          	mov    0x4c(%esp),%ecx
{
  1049a6:	8b 5c 24 50          	mov    0x50(%esp),%ebx
    if (num >= base) {
  1049aa:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1049b1:	00 
{
  1049b2:	89 54 24 0c          	mov    %edx,0xc(%esp)
  1049b6:	8b 54 24 48          	mov    0x48(%esp),%edx
  1049ba:	89 44 24 08          	mov    %eax,0x8(%esp)
    if (num >= base) {
  1049be:	8b 44 24 0c          	mov    0xc(%esp),%eax
        while (--width > 0)
  1049c2:	8d 69 ff             	lea    -0x1(%ecx),%ebp
    if (num >= base) {
  1049c5:	39 54 24 08          	cmp    %edx,0x8(%esp)
  1049c9:	1b 44 24 14          	sbb    0x14(%esp),%eax
  1049cd:	89 54 24 10          	mov    %edx,0x10(%esp)
  1049d1:	73 55                	jae    104a28 <printnum+0xa8>
        while (--width > 0)
  1049d3:	85 ed                	test   %ebp,%ebp
  1049d5:	7e 18                	jle    1049ef <printnum+0x6f>
  1049d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1049de:	66 90                	xchg   %ax,%ax
            putch(padc, putdat);
  1049e0:	83 ec 08             	sub    $0x8,%esp
  1049e3:	57                   	push   %edi
  1049e4:	53                   	push   %ebx
  1049e5:	ff d6                	call   *%esi
        while (--width > 0)
  1049e7:	83 c4 10             	add    $0x10,%esp
  1049ea:	83 ed 01             	sub    $0x1,%ebp
  1049ed:	75 f1                	jne    1049e0 <printnum+0x60>
    }

    // then print this (the least significant) digit
    putch("0123456789abcdef"[num % base], putdat);
  1049ef:	89 7c 24 44          	mov    %edi,0x44(%esp)
  1049f3:	ff 74 24 14          	push   0x14(%esp)
  1049f7:	ff 74 24 14          	push   0x14(%esp)
  1049fb:	ff 74 24 14          	push   0x14(%esp)
  1049ff:	ff 74 24 14          	push   0x14(%esp)
  104a03:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
  104a07:	e8 f4 62 00 00       	call   10ad00 <__umoddi3>
  104a0c:	0f be 84 03 c9 82 ff 	movsbl -0x7d37(%ebx,%eax,1),%eax
  104a13:	ff 
  104a14:	89 44 24 50          	mov    %eax,0x50(%esp)
}
  104a18:	83 c4 3c             	add    $0x3c,%esp
    putch("0123456789abcdef"[num % base], putdat);
  104a1b:	89 f0                	mov    %esi,%eax
}
  104a1d:	5b                   	pop    %ebx
  104a1e:	5e                   	pop    %esi
  104a1f:	5f                   	pop    %edi
  104a20:	5d                   	pop    %ebp
    putch("0123456789abcdef"[num % base], putdat);
  104a21:	ff e0                	jmp    *%eax
  104a23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104a27:	90                   	nop
        printnum(putch, putdat, num / base, base, width - 1, padc);
  104a28:	83 ec 0c             	sub    $0xc,%esp
  104a2b:	53                   	push   %ebx
  104a2c:	55                   	push   %ebp
  104a2d:	52                   	push   %edx
  104a2e:	83 ec 08             	sub    $0x8,%esp
  104a31:	ff 74 24 34          	push   0x34(%esp)
  104a35:	ff 74 24 34          	push   0x34(%esp)
  104a39:	ff 74 24 34          	push   0x34(%esp)
  104a3d:	ff 74 24 34          	push   0x34(%esp)
  104a41:	8b 5c 24 4c          	mov    0x4c(%esp),%ebx
  104a45:	e8 96 61 00 00       	call   10abe0 <__udivdi3>
  104a4a:	83 c4 18             	add    $0x18,%esp
  104a4d:	52                   	push   %edx
  104a4e:	89 fa                	mov    %edi,%edx
  104a50:	50                   	push   %eax
  104a51:	89 f0                	mov    %esi,%eax
  104a53:	e8 28 ff ff ff       	call   104980 <printnum>
  104a58:	83 c4 20             	add    $0x20,%esp
  104a5b:	eb 92                	jmp    1049ef <printnum+0x6f>
  104a5d:	8d 76 00             	lea    0x0(%esi),%esi

00104a60 <vprintfmt>:
    else
        return va_arg(*ap, int);
}

void vprintfmt(putch_t putch, void *putdat, const char *fmt, va_list ap)
{
  104a60:	e8 1c b9 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  104a65:	05 9b f5 00 00       	add    $0xf59b,%eax
  104a6a:	55                   	push   %ebp
  104a6b:	57                   	push   %edi
  104a6c:	56                   	push   %esi
  104a6d:	53                   	push   %ebx
  104a6e:	83 ec 3c             	sub    $0x3c,%esp
  104a71:	8b 74 24 50          	mov    0x50(%esp),%esi
  104a75:	8b 6c 24 54          	mov    0x54(%esp),%ebp
  104a79:	89 44 24 14          	mov    %eax,0x14(%esp)
        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL)
                p = "(null)";
            if (width > 0 && padc != '-')
                for (width -= strnlen(p, precision); width > 0; width--)
  104a7d:	8d 80 da 82 ff ff    	lea    -0x7d26(%eax),%eax
  104a83:	89 44 24 24          	mov    %eax,0x24(%esp)
{
  104a87:	8b 7c 24 58          	mov    0x58(%esp),%edi
        while ((ch = *(unsigned char *) fmt++) != '%') {
  104a8b:	0f b6 07             	movzbl (%edi),%eax
  104a8e:	8d 5f 01             	lea    0x1(%edi),%ebx
  104a91:	83 f8 25             	cmp    $0x25,%eax
  104a94:	75 20                	jne    104ab6 <vprintfmt+0x56>
  104a96:	eb 30                	jmp    104ac8 <vprintfmt+0x68>
  104a98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104a9f:	90                   	nop
            putch(ch, putdat);
  104aa0:	83 ec 08             	sub    $0x8,%esp
        while ((ch = *(unsigned char *) fmt++) != '%') {
  104aa3:	83 c3 01             	add    $0x1,%ebx
            putch(ch, putdat);
  104aa6:	55                   	push   %ebp
  104aa7:	50                   	push   %eax
  104aa8:	ff d6                	call   *%esi
        while ((ch = *(unsigned char *) fmt++) != '%') {
  104aaa:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
  104aae:	83 c4 10             	add    $0x10,%esp
  104ab1:	83 f8 25             	cmp    $0x25,%eax
  104ab4:	74 12                	je     104ac8 <vprintfmt+0x68>
            if (ch == '\0')
  104ab6:	85 c0                	test   %eax,%eax
  104ab8:	75 e6                	jne    104aa0 <vprintfmt+0x40>
            for (fmt--; fmt[-1] != '%'; fmt--)
                /* do nothing */ ;
            break;
        }
    }
}
  104aba:	83 c4 3c             	add    $0x3c,%esp
  104abd:	5b                   	pop    %ebx
  104abe:	5e                   	pop    %esi
  104abf:	5f                   	pop    %edi
  104ac0:	5d                   	pop    %ebp
  104ac1:	c3                   	ret    
  104ac2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        precision = -1;
  104ac8:	ba ff ff ff ff       	mov    $0xffffffff,%edx
        padc = ' ';
  104acd:	c6 44 24 18 20       	movb   $0x20,0x18(%esp)
        altflag = 0;
  104ad2:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  104ad9:	00 
        width = -1;
  104ada:	c7 44 24 10 ff ff ff 	movl   $0xffffffff,0x10(%esp)
  104ae1:	ff 
        lflag = 0;
  104ae2:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%esp)
  104ae9:	00 
  104aea:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  104aee:	89 74 24 50          	mov    %esi,0x50(%esp)
        switch (ch = *(unsigned char *) fmt++) {
  104af2:	0f b6 0b             	movzbl (%ebx),%ecx
  104af5:	8d 7b 01             	lea    0x1(%ebx),%edi
  104af8:	8d 41 dd             	lea    -0x23(%ecx),%eax
  104afb:	3c 55                	cmp    $0x55,%al
  104afd:	77 19                	ja     104b18 <.L18>
  104aff:	8b 54 24 14          	mov    0x14(%esp),%edx
  104b03:	0f b6 c0             	movzbl %al,%eax
  104b06:	8b b4 82 e4 82 ff ff 	mov    -0x7d1c(%edx,%eax,4),%esi
  104b0d:	01 d6                	add    %edx,%esi
  104b0f:	ff e6                	jmp    *%esi
  104b11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104b18 <.L18>:
            putch('%', putdat);
  104b18:	8b 74 24 50          	mov    0x50(%esp),%esi
  104b1c:	83 ec 08             	sub    $0x8,%esp
            for (fmt--; fmt[-1] != '%'; fmt--)
  104b1f:	89 df                	mov    %ebx,%edi
            putch('%', putdat);
  104b21:	55                   	push   %ebp
  104b22:	6a 25                	push   $0x25
  104b24:	ff d6                	call   *%esi
            for (fmt--; fmt[-1] != '%'; fmt--)
  104b26:	83 c4 10             	add    $0x10,%esp
  104b29:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
  104b2d:	0f 84 58 ff ff ff    	je     104a8b <vprintfmt+0x2b>
  104b33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104b37:	90                   	nop
  104b38:	83 ef 01             	sub    $0x1,%edi
  104b3b:	80 7f ff 25          	cmpb   $0x25,-0x1(%edi)
  104b3f:	75 f7                	jne    104b38 <.L18+0x20>
  104b41:	e9 45 ff ff ff       	jmp    104a8b <vprintfmt+0x2b>
  104b46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104b4d:	8d 76 00             	lea    0x0(%esi),%esi

00104b50 <.L27>:
                ch = *fmt;
  104b50:	0f be 43 01          	movsbl 0x1(%ebx),%eax
                precision = precision * 10 + ch - '0';
  104b54:	8d 51 d0             	lea    -0x30(%ecx),%edx
        switch (ch = *(unsigned char *) fmt++) {
  104b57:	89 fb                	mov    %edi,%ebx
                precision = precision * 10 + ch - '0';
  104b59:	89 54 24 1c          	mov    %edx,0x1c(%esp)
                if (ch < '0' || ch > '9')
  104b5d:	8d 48 d0             	lea    -0x30(%eax),%ecx
  104b60:	83 f9 09             	cmp    $0x9,%ecx
  104b63:	77 28                	ja     104b8d <.L27+0x3d>
        switch (ch = *(unsigned char *) fmt++) {
  104b65:	8b 74 24 50          	mov    0x50(%esp),%esi
  104b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            for (precision = 0;; ++fmt) {
  104b70:	83 c3 01             	add    $0x1,%ebx
                precision = precision * 10 + ch - '0';
  104b73:	8d 14 92             	lea    (%edx,%edx,4),%edx
  104b76:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
                ch = *fmt;
  104b7a:	0f be 03             	movsbl (%ebx),%eax
                if (ch < '0' || ch > '9')
  104b7d:	8d 48 d0             	lea    -0x30(%eax),%ecx
  104b80:	83 f9 09             	cmp    $0x9,%ecx
  104b83:	76 eb                	jbe    104b70 <.L27+0x20>
  104b85:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  104b89:	89 74 24 50          	mov    %esi,0x50(%esp)
            if (width < 0)
  104b8d:	8b 74 24 10          	mov    0x10(%esp),%esi
  104b91:	85 f6                	test   %esi,%esi
  104b93:	0f 89 59 ff ff ff    	jns    104af2 <vprintfmt+0x92>
                width = precision, precision = -1;
  104b99:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  104b9d:	c7 44 24 1c ff ff ff 	movl   $0xffffffff,0x1c(%esp)
  104ba4:	ff 
  104ba5:	89 44 24 10          	mov    %eax,0x10(%esp)
  104ba9:	e9 44 ff ff ff       	jmp    104af2 <vprintfmt+0x92>

00104bae <.L23>:
            putch('0', putdat);
  104bae:	8b 74 24 50          	mov    0x50(%esp),%esi
  104bb2:	83 ec 08             	sub    $0x8,%esp
  104bb5:	55                   	push   %ebp
  104bb6:	6a 30                	push   $0x30
  104bb8:	ff d6                	call   *%esi
            putch('x', putdat);
  104bba:	59                   	pop    %ecx
  104bbb:	5b                   	pop    %ebx
  104bbc:	55                   	push   %ebp
  104bbd:	6a 78                	push   $0x78
            num = (unsigned long long) (uintptr_t) va_arg(ap, void *);
  104bbf:	31 db                	xor    %ebx,%ebx
            putch('x', putdat);
  104bc1:	ff d6                	call   *%esi
            num = (unsigned long long) (uintptr_t) va_arg(ap, void *);
  104bc3:	8b 44 24 6c          	mov    0x6c(%esp),%eax
            goto number;
  104bc7:	ba 10 00 00 00       	mov    $0x10,%edx
            num = (unsigned long long) (uintptr_t) va_arg(ap, void *);
  104bcc:	8b 08                	mov    (%eax),%ecx
            goto number;
  104bce:	83 c4 10             	add    $0x10,%esp
            num = (unsigned long long) (uintptr_t) va_arg(ap, void *);
  104bd1:	83 c0 04             	add    $0x4,%eax
  104bd4:	89 44 24 5c          	mov    %eax,0x5c(%esp)
            printnum(putch, putdat, num, base, width, padc);
  104bd8:	83 ec 0c             	sub    $0xc,%esp
  104bdb:	0f be 44 24 24       	movsbl 0x24(%esp),%eax
  104be0:	50                   	push   %eax
  104be1:	89 f0                	mov    %esi,%eax
  104be3:	ff 74 24 20          	push   0x20(%esp)
  104be7:	52                   	push   %edx
  104be8:	89 ea                	mov    %ebp,%edx
  104bea:	53                   	push   %ebx
  104beb:	51                   	push   %ecx
  104bec:	e8 8f fd ff ff       	call   104980 <printnum>
            break;
  104bf1:	83 c4 20             	add    $0x20,%esp
  104bf4:	e9 92 fe ff ff       	jmp    104a8b <vprintfmt+0x2b>

00104bf9 <.L32>:
            altflag = 1;
  104bf9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  104c00:	00 
        switch (ch = *(unsigned char *) fmt++) {
  104c01:	89 fb                	mov    %edi,%ebx
            goto reswitch;
  104c03:	e9 ea fe ff ff       	jmp    104af2 <vprintfmt+0x92>

00104c08 <.L31>:
            putch(ch, putdat);
  104c08:	8b 74 24 50          	mov    0x50(%esp),%esi
  104c0c:	83 ec 08             	sub    $0x8,%esp
  104c0f:	55                   	push   %ebp
  104c10:	6a 25                	push   $0x25
  104c12:	ff d6                	call   *%esi
            break;
  104c14:	83 c4 10             	add    $0x10,%esp
  104c17:	e9 6f fe ff ff       	jmp    104a8b <vprintfmt+0x2b>

00104c1c <.L30>:
            precision = va_arg(ap, int);
  104c1c:	8b 44 24 5c          	mov    0x5c(%esp),%eax
        switch (ch = *(unsigned char *) fmt++) {
  104c20:	89 fb                	mov    %edi,%ebx
            precision = va_arg(ap, int);
  104c22:	8b 00                	mov    (%eax),%eax
  104c24:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  104c28:	8b 44 24 5c          	mov    0x5c(%esp),%eax
  104c2c:	83 c0 04             	add    $0x4,%eax
  104c2f:	89 44 24 5c          	mov    %eax,0x5c(%esp)
            goto process_precision;
  104c33:	e9 55 ff ff ff       	jmp    104b8d <.L27+0x3d>

00104c38 <.L29>:
            if (width < 0)
  104c38:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  104c3c:	31 c0                	xor    %eax,%eax
        switch (ch = *(unsigned char *) fmt++) {
  104c3e:	89 fb                	mov    %edi,%ebx
  104c40:	85 c9                	test   %ecx,%ecx
  104c42:	0f 49 c1             	cmovns %ecx,%eax
  104c45:	89 44 24 10          	mov    %eax,0x10(%esp)
            goto reswitch;
  104c49:	e9 a4 fe ff ff       	jmp    104af2 <vprintfmt+0x92>

00104c4e <.L22>:
            if ((p = va_arg(ap, char *)) == NULL)
  104c4e:	8b 44 24 5c          	mov    0x5c(%esp),%eax
            if (width > 0 && padc != '-')
  104c52:	8b 5c 24 10          	mov    0x10(%esp),%ebx
            if ((p = va_arg(ap, char *)) == NULL)
  104c56:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  104c5a:	8b 74 24 50          	mov    0x50(%esp),%esi
  104c5e:	83 c0 04             	add    $0x4,%eax
            if (width > 0 && padc != '-')
  104c61:	85 db                	test   %ebx,%ebx
            if ((p = va_arg(ap, char *)) == NULL)
  104c63:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  104c67:	8b 44 24 5c          	mov    0x5c(%esp),%eax
  104c6b:	8b 08                	mov    (%eax),%ecx
            if (width > 0 && padc != '-')
  104c6d:	0f 9f c0             	setg   %al
  104c70:	80 7c 24 18 2d       	cmpb   $0x2d,0x18(%esp)
  104c75:	0f 95 c3             	setne  %bl
  104c78:	21 d8                	and    %ebx,%eax
            if ((p = va_arg(ap, char *)) == NULL)
  104c7a:	85 c9                	test   %ecx,%ecx
  104c7c:	0f 84 e4 01 00 00    	je     104e66 <.L28+0xc>
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  104c82:	8d 59 01             	lea    0x1(%ecx),%ebx
  104c85:	89 5c 24 20          	mov    %ebx,0x20(%esp)
            if (width > 0 && padc != '-')
  104c89:	84 c0                	test   %al,%al
  104c8b:	0f 85 04 02 00 00    	jne    104e95 <.L28+0x3b>
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  104c91:	0f be 09             	movsbl (%ecx),%ecx
  104c94:	89 c8                	mov    %ecx,%eax
  104c96:	85 c9                	test   %ecx,%ecx
  104c98:	0f 84 24 01 00 00    	je     104dc2 <.L24+0x18>
  104c9e:	89 74 24 50          	mov    %esi,0x50(%esp)
  104ca2:	89 d6                	mov    %edx,%esi
  104ca4:	89 7c 24 58          	mov    %edi,0x58(%esp)
  104ca8:	8b 7c 24 10          	mov    0x10(%esp),%edi
  104cac:	eb 2b                	jmp    104cd9 <.L22+0x8b>
  104cae:	66 90                	xchg   %ax,%ax
                if (altflag && (ch < ' ' || ch > '~'))
  104cb0:	83 e8 20             	sub    $0x20,%eax
  104cb3:	83 f8 5e             	cmp    $0x5e,%eax
  104cb6:	76 36                	jbe    104cee <.L22+0xa0>
                    putch('?', putdat);
  104cb8:	83 ec 08             	sub    $0x8,%esp
  104cbb:	55                   	push   %ebp
  104cbc:	6a 3f                	push   $0x3f
  104cbe:	ff 54 24 60          	call   *0x60(%esp)
  104cc2:	83 c4 10             	add    $0x10,%esp
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  104cc5:	0f be 03             	movsbl (%ebx),%eax
  104cc8:	83 c3 01             	add    $0x1,%ebx
                 width--)
  104ccb:	83 ef 01             	sub    $0x1,%edi
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  104cce:	0f be c8             	movsbl %al,%ecx
  104cd1:	85 c9                	test   %ecx,%ecx
  104cd3:	0f 84 dd 00 00 00    	je     104db6 <.L24+0xc>
  104cd9:	85 f6                	test   %esi,%esi
  104cdb:	78 09                	js     104ce6 <.L22+0x98>
  104cdd:	83 ee 01             	sub    $0x1,%esi
  104ce0:	0f 82 d0 00 00 00    	jb     104db6 <.L24+0xc>
                if (altflag && (ch < ' ' || ch > '~'))
  104ce6:	8b 54 24 08          	mov    0x8(%esp),%edx
  104cea:	85 d2                	test   %edx,%edx
  104cec:	75 c2                	jne    104cb0 <.L22+0x62>
                    putch(ch, putdat);
  104cee:	83 ec 08             	sub    $0x8,%esp
  104cf1:	55                   	push   %ebp
  104cf2:	51                   	push   %ecx
  104cf3:	ff 54 24 60          	call   *0x60(%esp)
  104cf7:	83 c4 10             	add    $0x10,%esp
  104cfa:	eb c9                	jmp    104cc5 <.L22+0x77>

00104cfc <.L21>:
    if (lflag >= 2)
  104cfc:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
  104d01:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, unsigned long long);
  104d05:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
  104d09:	0f 8f de 00 00 00    	jg     104ded <.L24+0x43>
        return va_arg(*ap, unsigned long);
  104d0f:	8b 4c 24 5c          	mov    0x5c(%esp),%ecx
            precision = va_arg(ap, int);
  104d13:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
  104d16:	31 db                	xor    %ebx,%ebx
  104d18:	ba 0a 00 00 00       	mov    $0xa,%edx
  104d1d:	8b 09                	mov    (%ecx),%ecx
  104d1f:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  104d23:	e9 b0 fe ff ff       	jmp    104bd8 <.L23+0x2a>

00104d28 <.L19>:
    if (lflag >= 2)
  104d28:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
  104d2d:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, unsigned long long);
  104d31:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
  104d35:	0f 8f c0 00 00 00    	jg     104dfb <.L24+0x51>
        return va_arg(*ap, unsigned long);
  104d3b:	8b 4c 24 5c          	mov    0x5c(%esp),%ecx
            precision = va_arg(ap, int);
  104d3f:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
  104d42:	31 db                	xor    %ebx,%ebx
  104d44:	ba 10 00 00 00       	mov    $0x10,%edx
  104d49:	8b 09                	mov    (%ecx),%ecx
  104d4b:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  104d4f:	e9 84 fe ff ff       	jmp    104bd8 <.L23+0x2a>

00104d54 <.L26>:
            putch(va_arg(ap, int), putdat);
  104d54:	8b 44 24 5c          	mov    0x5c(%esp),%eax
  104d58:	8b 74 24 50          	mov    0x50(%esp),%esi
  104d5c:	83 ec 08             	sub    $0x8,%esp
  104d5f:	55                   	push   %ebp
  104d60:	8d 58 04             	lea    0x4(%eax),%ebx
  104d63:	8b 44 24 68          	mov    0x68(%esp),%eax
  104d67:	ff 30                	push   (%eax)
  104d69:	ff d6                	call   *%esi
  104d6b:	89 5c 24 6c          	mov    %ebx,0x6c(%esp)
            break;
  104d6f:	83 c4 10             	add    $0x10,%esp
  104d72:	e9 14 fd ff ff       	jmp    104a8b <vprintfmt+0x2b>

00104d77 <.L25>:
    if (lflag >= 2)
  104d77:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
  104d7c:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, long long);
  104d80:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
  104d84:	0f 8f 87 00 00 00    	jg     104e11 <.L24+0x67>
        return va_arg(*ap, long);
  104d8a:	8b 00                	mov    (%eax),%eax
            precision = va_arg(ap, int);
  104d8c:	83 44 24 5c 04       	addl   $0x4,0x5c(%esp)
        return va_arg(*ap, long);
  104d91:	89 c3                	mov    %eax,%ebx
  104d93:	89 c1                	mov    %eax,%ecx
  104d95:	c1 fb 1f             	sar    $0x1f,%ebx
            if ((long long) num < 0) {
  104d98:	85 db                	test   %ebx,%ebx
  104d9a:	0f 88 82 00 00 00    	js     104e22 <.L24+0x78>
        return va_arg(*ap, unsigned long long);
  104da0:	ba 0a 00 00 00       	mov    $0xa,%edx
  104da5:	e9 2e fe ff ff       	jmp    104bd8 <.L23+0x2a>

00104daa <.L24>:
            lflag++;
  104daa:	83 44 24 20 01       	addl   $0x1,0x20(%esp)
        switch (ch = *(unsigned char *) fmt++) {
  104daf:	89 fb                	mov    %edi,%ebx
            goto reswitch;
  104db1:	e9 3c fd ff ff       	jmp    104af2 <vprintfmt+0x92>
  104db6:	89 7c 24 10          	mov    %edi,0x10(%esp)
  104dba:	8b 74 24 50          	mov    0x50(%esp),%esi
  104dbe:	8b 7c 24 58          	mov    0x58(%esp),%edi
            for (; width > 0; width--)
  104dc2:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  104dc6:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  104dca:	85 c9                	test   %ecx,%ecx
  104dcc:	7e 12                	jle    104de0 <.L24+0x36>
  104dce:	66 90                	xchg   %ax,%ax
                putch(' ', putdat);
  104dd0:	83 ec 08             	sub    $0x8,%esp
  104dd3:	55                   	push   %ebp
  104dd4:	6a 20                	push   $0x20
  104dd6:	ff d6                	call   *%esi
            for (; width > 0; width--)
  104dd8:	83 c4 10             	add    $0x10,%esp
  104ddb:	83 eb 01             	sub    $0x1,%ebx
  104dde:	75 f0                	jne    104dd0 <.L24+0x26>
            if ((p = va_arg(ap, char *)) == NULL)
  104de0:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  104de4:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  104de8:	e9 9e fc ff ff       	jmp    104a8b <vprintfmt+0x2b>
        return va_arg(*ap, unsigned long long);
  104ded:	8b 08                	mov    (%eax),%ecx
  104def:	8b 58 04             	mov    0x4(%eax),%ebx
  104df2:	83 c0 08             	add    $0x8,%eax
  104df5:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  104df9:	eb a5                	jmp    104da0 <.L25+0x29>
  104dfb:	8b 08                	mov    (%eax),%ecx
  104dfd:	8b 58 04             	mov    0x4(%eax),%ebx
  104e00:	83 c0 08             	add    $0x8,%eax
  104e03:	ba 10 00 00 00       	mov    $0x10,%edx
  104e08:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  104e0c:	e9 c7 fd ff ff       	jmp    104bd8 <.L23+0x2a>
        return va_arg(*ap, long long);
  104e11:	8b 08                	mov    (%eax),%ecx
  104e13:	8b 58 04             	mov    0x4(%eax),%ebx
  104e16:	83 c0 08             	add    $0x8,%eax
  104e19:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  104e1d:	e9 76 ff ff ff       	jmp    104d98 <.L25+0x21>
  104e22:	89 4c 24 08          	mov    %ecx,0x8(%esp)
                putch('-', putdat);
  104e26:	83 ec 08             	sub    $0x8,%esp
  104e29:	89 5c 24 14          	mov    %ebx,0x14(%esp)
  104e2d:	55                   	push   %ebp
  104e2e:	6a 2d                	push   $0x2d
  104e30:	ff d6                	call   *%esi
                num = -(long long) num;
  104e32:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  104e36:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  104e3a:	ba 0a 00 00 00       	mov    $0xa,%edx
  104e3f:	f7 d9                	neg    %ecx
  104e41:	83 d3 00             	adc    $0x0,%ebx
  104e44:	83 c4 10             	add    $0x10,%esp
  104e47:	f7 db                	neg    %ebx
  104e49:	e9 8a fd ff ff       	jmp    104bd8 <.L23+0x2a>

00104e4e <.L58>:
            padc = '-';
  104e4e:	c6 44 24 18 2d       	movb   $0x2d,0x18(%esp)
        switch (ch = *(unsigned char *) fmt++) {
  104e53:	89 fb                	mov    %edi,%ebx
  104e55:	e9 98 fc ff ff       	jmp    104af2 <vprintfmt+0x92>

00104e5a <.L28>:
  104e5a:	c6 44 24 18 30       	movb   $0x30,0x18(%esp)
  104e5f:	89 fb                	mov    %edi,%ebx
  104e61:	e9 8c fc ff ff       	jmp    104af2 <vprintfmt+0x92>
            if (width > 0 && padc != '-')
  104e66:	84 c0                	test   %al,%al
  104e68:	0f 85 9f 00 00 00    	jne    104f0d <.L28+0xb3>
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  104e6e:	8b 44 24 14          	mov    0x14(%esp),%eax
  104e72:	89 74 24 50          	mov    %esi,0x50(%esp)
  104e76:	b9 28 00 00 00       	mov    $0x28,%ecx
  104e7b:	89 d6                	mov    %edx,%esi
  104e7d:	89 7c 24 58          	mov    %edi,0x58(%esp)
  104e81:	8b 7c 24 10          	mov    0x10(%esp),%edi
  104e85:	8d 98 db 82 ff ff    	lea    -0x7d25(%eax),%ebx
  104e8b:	b8 28 00 00 00       	mov    $0x28,%eax
  104e90:	e9 44 fe ff ff       	jmp    104cd9 <.L22+0x8b>
                for (width -= strnlen(p, precision); width > 0; width--)
  104e95:	83 ec 08             	sub    $0x8,%esp
  104e98:	52                   	push   %edx
  104e99:	89 54 24 38          	mov    %edx,0x38(%esp)
  104e9d:	51                   	push   %ecx
  104e9e:	8b 5c 24 24          	mov    0x24(%esp),%ebx
  104ea2:	89 4c 24 38          	mov    %ecx,0x38(%esp)
  104ea6:	e8 c5 f5 ff ff       	call   104470 <strnlen>
  104eab:	29 44 24 20          	sub    %eax,0x20(%esp)
  104eaf:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  104eb3:	83 c4 10             	add    $0x10,%esp
  104eb6:	8b 54 24 2c          	mov    0x2c(%esp),%edx
  104eba:	85 c9                	test   %ecx,%ecx
  104ebc:	8b 4c 24 28          	mov    0x28(%esp),%ecx
  104ec0:	7e 34                	jle    104ef6 <.L28+0x9c>
                    putch(padc, putdat);
  104ec2:	0f be 5c 24 18       	movsbl 0x18(%esp),%ebx
  104ec7:	89 4c 24 28          	mov    %ecx,0x28(%esp)
  104ecb:	89 54 24 18          	mov    %edx,0x18(%esp)
  104ecf:	89 7c 24 58          	mov    %edi,0x58(%esp)
  104ed3:	8b 7c 24 10          	mov    0x10(%esp),%edi
  104ed7:	83 ec 08             	sub    $0x8,%esp
  104eda:	55                   	push   %ebp
  104edb:	53                   	push   %ebx
  104edc:	ff d6                	call   *%esi
                for (width -= strnlen(p, precision); width > 0; width--)
  104ede:	83 c4 10             	add    $0x10,%esp
  104ee1:	83 ef 01             	sub    $0x1,%edi
  104ee4:	75 f1                	jne    104ed7 <.L28+0x7d>
  104ee6:	8b 54 24 18          	mov    0x18(%esp),%edx
  104eea:	8b 4c 24 28          	mov    0x28(%esp),%ecx
  104eee:	89 7c 24 10          	mov    %edi,0x10(%esp)
  104ef2:	8b 7c 24 58          	mov    0x58(%esp),%edi
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  104ef6:	0f be 01             	movsbl (%ecx),%eax
  104ef9:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  104efd:	0f be c8             	movsbl %al,%ecx
  104f00:	85 c9                	test   %ecx,%ecx
  104f02:	0f 85 96 fd ff ff    	jne    104c9e <.L22+0x50>
  104f08:	e9 d3 fe ff ff       	jmp    104de0 <.L24+0x36>
                for (width -= strnlen(p, precision); width > 0; width--)
  104f0d:	83 ec 08             	sub    $0x8,%esp
  104f10:	52                   	push   %edx
  104f11:	89 54 24 34          	mov    %edx,0x34(%esp)
  104f15:	ff 74 24 30          	push   0x30(%esp)
  104f19:	8b 5c 24 24          	mov    0x24(%esp),%ebx
  104f1d:	e8 4e f5 ff ff       	call   104470 <strnlen>
  104f22:	29 44 24 20          	sub    %eax,0x20(%esp)
  104f26:	8b 44 24 20          	mov    0x20(%esp),%eax
  104f2a:	83 c4 10             	add    $0x10,%esp
                p = "(null)";
  104f2d:	8b 54 24 24          	mov    0x24(%esp),%edx
  104f31:	89 d1                	mov    %edx,%ecx
  104f33:	83 c2 01             	add    $0x1,%edx
                for (width -= strnlen(p, precision); width > 0; width--)
  104f36:	85 c0                	test   %eax,%eax
  104f38:	89 54 24 20          	mov    %edx,0x20(%esp)
  104f3c:	8b 54 24 28          	mov    0x28(%esp),%edx
  104f40:	7f 80                	jg     104ec2 <.L28+0x68>
  104f42:	89 74 24 50          	mov    %esi,0x50(%esp)
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  104f46:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  104f4a:	b9 28 00 00 00       	mov    $0x28,%ecx
  104f4f:	89 d6                	mov    %edx,%esi
  104f51:	89 7c 24 58          	mov    %edi,0x58(%esp)
  104f55:	b8 28 00 00 00       	mov    $0x28,%eax
  104f5a:	8b 7c 24 10          	mov    0x10(%esp),%edi
  104f5e:	e9 76 fd ff ff       	jmp    104cd9 <.L22+0x8b>

00104f63 <__x86.get_pc_thunk.cx>:
  104f63:	8b 0c 24             	mov    (%esp),%ecx
  104f66:	c3                   	ret    
  104f67:	66 90                	xchg   %ax,%ax
  104f69:	66 90                	xchg   %ax,%ax
  104f6b:	66 90                	xchg   %ax,%ax
  104f6d:	66 90                	xchg   %ax,%ax
  104f6f:	90                   	nop

00104f70 <kstack_switch>:
#include "seg.h"

#define offsetof(type, member) __builtin_offsetof(type, member)

void kstack_switch(uint32_t pid)
{
  104f70:	56                   	push   %esi
  104f71:	53                   	push   %ebx
  104f72:	e8 12 b4 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  104f77:	81 c3 89 f0 00 00    	add    $0xf089,%ebx
  104f7d:	83 ec 04             	sub    $0x4,%esp
    int cpu_idx = get_pcpu_idx();
  104f80:	e8 fb 11 00 00       	call   106180 <get_pcpu_idx>
    struct kstack *ks = (struct kstack *) get_pcpu_kstack_pointer(cpu_idx);
  104f85:	83 ec 0c             	sub    $0xc,%esp
  104f88:	50                   	push   %eax
  104f89:	e8 52 12 00 00       	call   1061e0 <get_pcpu_kstack_pointer>

    /*
     * Switch to the new TSS.
     */
    ks->tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  104f8e:	8b 74 24 20          	mov    0x20(%esp),%esi
  104f92:	c7 c1 00 00 15 00    	mov    $0x150000,%ecx
  104f98:	8d 56 01             	lea    0x1(%esi),%edx
  104f9b:	c1 e2 0c             	shl    $0xc,%edx
  104f9e:	8d 34 0a             	lea    (%edx,%ecx,1),%esi
    ks->tss.ts_ss0 = CPU_GDT_KDATA;
    ks->gdt[CPU_GDT_TSS >> 3] =
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  104fa1:	8d 94 0a 30 f0 ff ff 	lea    -0xfd0(%edx,%ecx,1),%edx
    ks->gdt[CPU_GDT_TSS >> 3] =
  104fa8:	b9 eb 00 00 00       	mov    $0xeb,%ecx
    ks->tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  104fad:	89 70 34             	mov    %esi,0x34(%eax)
    ks->tss.ts_ss0 = CPU_GDT_KDATA;
  104fb0:	be 10 00 00 00       	mov    $0x10,%esi
    ks->gdt[CPU_GDT_TSS >> 3] =
  104fb5:	66 89 48 28          	mov    %cx,0x28(%eax)
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  104fb9:	89 d1                	mov    %edx,%ecx
    ks->tss.ts_ss0 = CPU_GDT_KDATA;
  104fbb:	66 89 70 38          	mov    %si,0x38(%eax)
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  104fbf:	c1 e9 10             	shr    $0x10,%ecx
    ks->gdt[CPU_GDT_TSS >> 3] =
  104fc2:	be 89 40 00 00       	mov    $0x4089,%esi
  104fc7:	66 89 50 2a          	mov    %dx,0x2a(%eax)
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  104fcb:	c1 ea 18             	shr    $0x18,%edx
    ks->gdt[CPU_GDT_TSS >> 3] =
  104fce:	66 89 70 2d          	mov    %si,0x2d(%eax)
  104fd2:	88 48 2c             	mov    %cl,0x2c(%eax)
  104fd5:	88 50 2f             	mov    %dl,0x2f(%eax)
    ks->gdt[CPU_GDT_TSS >> 3].sd_s = 0;
    ltr(CPU_GDT_TSS);
  104fd8:	c7 04 24 28 00 00 00 	movl   $0x28,(%esp)
  104fdf:	e8 cc 04 00 00       	call   1054b0 <ltr>
}
  104fe4:	83 c4 14             	add    $0x14,%esp
  104fe7:	5b                   	pop    %ebx
  104fe8:	5e                   	pop    %esi
  104fe9:	c3                   	ret    
  104fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104ff0 <seg_init>:

void seg_init(int cpu_idx)
{
  104ff0:	55                   	push   %ebp
  104ff1:	57                   	push   %edi
  104ff2:	56                   	push   %esi
  104ff3:	53                   	push   %ebx
  104ff4:	e8 90 b3 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  104ff9:	81 c3 07 f0 00 00    	add    $0xf007,%ebx
  104fff:	83 ec 2c             	sub    $0x2c,%esp
  105002:	8b 7c 24 40          	mov    0x40(%esp),%edi
  105006:	c7 c6 00 00 19 00    	mov    $0x190000,%esi
    /* clear BSS */
    if (cpu_idx == 0) {
  10500c:	85 ff                	test   %edi,%edi
  10500e:	0f 84 1c 01 00 00    	je     105130 <seg_init+0x140>
    /* 0x20: user data */
    bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
        SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

    /* setup TSS */
    bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  105014:	8d 57 01             	lea    0x1(%edi),%edx
  105017:	89 f8                	mov    %edi,%eax
    bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  105019:	bd eb 00 00 00       	mov    $0xeb,%ebp
  10501e:	c1 e2 0c             	shl    $0xc,%edx
    bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  105021:	c1 e0 0c             	shl    $0xc,%eax
  105024:	01 f0                	add    %esi,%eax
  105026:	8d 0c 16             	lea    (%esi,%edx,1),%ecx
        SEGDESC16(STS_T32A, (uint32_t) &bsp_kstack[cpu_idx].tss, sizeof(tss_t) - 1, 0);
  105029:	89 54 24 0c          	mov    %edx,0xc(%esp)
    bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  10502d:	89 48 34             	mov    %ecx,0x34(%eax)
    bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  105030:	b9 10 00 00 00       	mov    $0x10,%ecx
  105035:	66 89 48 38          	mov    %cx,0x38(%eax)
        SEGDESC16(STS_T32A, (uint32_t) &bsp_kstack[cpu_idx].tss, sizeof(tss_t) - 1, 0);
  105039:	8d 8c 16 30 f0 ff ff 	lea    -0xfd0(%esi,%edx,1),%ecx
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  105040:	66 89 68 28          	mov    %bp,0x28(%eax)
        SEGDESC16(STS_T32A, (uint32_t) &bsp_kstack[cpu_idx].tss, sizeof(tss_t) - 1, 0);
  105044:	89 cd                	mov    %ecx,%ebp
  105046:	c1 ed 10             	shr    $0x10,%ebp
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  105049:	66 89 48 2a          	mov    %cx,0x2a(%eax)
        SEGDESC16(STS_T32A, (uint32_t) &bsp_kstack[cpu_idx].tss, sizeof(tss_t) - 1, 0);
  10504d:	c1 e9 18             	shr    $0x18,%ecx
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  105050:	89 ea                	mov    %ebp,%edx
    bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  105052:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  105058:	88 50 2c             	mov    %dl,0x2c(%eax)
  10505b:	8b 68 2c             	mov    0x2c(%eax),%ebp
    /* Set the KSTACK_MAGIC value when we initialize the kstack */
    bsp_kstack[cpu_idx].magic = KSTACK_MAGIC;

    pseudodesc_t gdt_desc = {
        .pd_lim   = sizeof(bsp_kstack[cpu_idx].gdt) - 1,
        .pd_base  = (uint32_t) bsp_kstack[cpu_idx].gdt
  10505e:	8b 54 24 0c          	mov    0xc(%esp),%edx
    bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  105062:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  105069:	81 e5 ff 10 c0 ff    	and    $0xffc010ff,%ebp
    bsp_kstack[cpu_idx].gdt[CPU_GDT_KCODE >> 3] =
  10506f:	c7 40 08 ff ff 00 00 	movl   $0xffff,0x8(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  105076:	81 cd 00 89 00 00    	or     $0x8900,%ebp
    bsp_kstack[cpu_idx].gdt[CPU_GDT_KCODE >> 3] =
  10507c:	c7 40 0c 00 9a cf 00 	movl   $0xcf9a00,0xc(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  105083:	89 68 2c             	mov    %ebp,0x2c(%eax)
  105086:	88 48 2f             	mov    %cl,0x2f(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3].sd_s = 0;
  105089:	8b 48 2c             	mov    0x2c(%eax),%ecx
    bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
  10508c:	c7 40 10 ff ff 00 00 	movl   $0xffff,0x10(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3].sd_s = 0;
  105093:	81 e1 ff ef 3f ff    	and    $0xff3fefff,%ecx
    bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
  105099:	c7 40 14 00 92 cf 00 	movl   $0xcf9200,0x14(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3].sd_s = 0;
  1050a0:	81 c9 00 00 40 00    	or     $0x400000,%ecx
    bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
  1050a6:	c7 40 18 ff ff 00 00 	movl   $0xffff,0x18(%eax)
  1050ad:	c7 40 1c 00 fa cf 00 	movl   $0xcffa00,0x1c(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
  1050b4:	c7 40 20 ff ff 00 00 	movl   $0xffff,0x20(%eax)
  1050bb:	c7 40 24 00 f2 cf 00 	movl   $0xcff200,0x24(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3].sd_s = 0;
  1050c2:	89 48 2c             	mov    %ecx,0x2c(%eax)
    bsp_kstack[cpu_idx].magic = KSTACK_MAGIC;
  1050c5:	c7 80 20 01 00 00 32 	movl   $0x98765432,0x120(%eax)
  1050cc:	54 76 98 
    pseudodesc_t gdt_desc = {
  1050cf:	b8 2f 00 00 00       	mov    $0x2f,%eax
  1050d4:	66 89 44 24 1a       	mov    %ax,0x1a(%esp)
        .pd_base  = (uint32_t) bsp_kstack[cpu_idx].gdt
  1050d9:	8d 84 16 00 f0 ff ff 	lea    -0x1000(%esi,%edx,1),%eax
  1050e0:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    };
    asm volatile ("lgdt %0" :: "m" (gdt_desc));
  1050e4:	0f 01 54 24 1a       	lgdtl  0x1a(%esp)
    asm volatile ("movw %%ax,%%gs" :: "a" (CPU_GDT_KDATA));
  1050e9:	b8 10 00 00 00       	mov    $0x10,%eax
  1050ee:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax,%%fs" :: "a" (CPU_GDT_KDATA));
  1050f0:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax,%%es" :: "a" (CPU_GDT_KDATA));
  1050f2:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax,%%ds" :: "a" (CPU_GDT_KDATA));
  1050f4:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax,%%ss" :: "a" (CPU_GDT_KDATA));
  1050f6:	8e d0                	mov    %eax,%ss
    /* reload %cs */
    asm volatile ("ljmp %0,$1f\n 1:\n" :: "i" (CPU_GDT_KCODE));
  1050f8:	ea ff 50 10 00 08 00 	ljmp   $0x8,$0x1050ff

    /*
     * Load a null LDT.
     */
    lldt(0);
  1050ff:	83 ec 0c             	sub    $0xc,%esp
  105102:	6a 00                	push   $0x0
  105104:	e8 17 02 00 00       	call   105320 <lldt>

    /*
     * Load the bootstrap TSS.
     */
    ltr(CPU_GDT_TSS);
  105109:	c7 04 24 28 00 00 00 	movl   $0x28,(%esp)
  105110:	e8 9b 03 00 00       	call   1054b0 <ltr>

    /*
     * Load IDT.
     */
    extern pseudodesc_t idt_pd;
    asm volatile ("lidt %0" :: "m" (idt_pd));
  105115:	c7 c0 20 43 11 00    	mov    $0x114320,%eax
  10511b:	0f 01 18             	lidtl  (%eax)

    /*
     * Initialize all TSS structures for processes.
     */
    if (cpu_idx == 0) {
  10511e:	83 c4 10             	add    $0x10,%esp
  105121:	85 ff                	test   %edi,%edi
  105123:	74 4b                	je     105170 <seg_init+0x180>
        memzero(&bsp_kstack[1], sizeof(struct kstack) * 7);
        memzero(proc_kstack, sizeof(struct kstack) * 64);
    }
}
  105125:	83 c4 2c             	add    $0x2c,%esp
  105128:	5b                   	pop    %ebx
  105129:	5e                   	pop    %esi
  10512a:	5f                   	pop    %edi
  10512b:	5d                   	pop    %ebp
  10512c:	c3                   	ret    
  10512d:	8d 76 00             	lea    0x0(%esi),%esi
        memzero(edata, ((uint8_t *) &bsp_kstack[0]) - edata);
  105130:	c7 c0 6a de 14 00    	mov    $0x14de6a,%eax
  105136:	89 f2                	mov    %esi,%edx
  105138:	83 ec 08             	sub    $0x8,%esp
  10513b:	29 c2                	sub    %eax,%edx
  10513d:	52                   	push   %edx
  10513e:	50                   	push   %eax
  10513f:	e8 ec f3 ff ff       	call   104530 <memzero>
        memzero(((uint8_t *) &bsp_kstack[0]) + 4096, end - ((uint8_t *) &bsp_kstack[0]) - 4096);
  105144:	58                   	pop    %eax
  105145:	c7 c0 58 0f e2 00    	mov    $0xe20f58,%eax
  10514b:	5a                   	pop    %edx
  10514c:	29 f0                	sub    %esi,%eax
  10514e:	2d 00 10 00 00       	sub    $0x1000,%eax
  105153:	50                   	push   %eax
  105154:	8d 86 00 10 00 00    	lea    0x1000(%esi),%eax
  10515a:	50                   	push   %eax
  10515b:	e8 d0 f3 ff ff       	call   104530 <memzero>
  105160:	83 c4 10             	add    $0x10,%esp
  105163:	e9 ac fe ff ff       	jmp    105014 <seg_init+0x24>
  105168:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10516f:	90                   	nop
        memzero(&bsp_kstack[1], sizeof(struct kstack) * 7);
  105170:	83 ec 08             	sub    $0x8,%esp
  105173:	8d 86 00 10 00 00    	lea    0x1000(%esi),%eax
  105179:	68 00 70 00 00       	push   $0x7000
  10517e:	50                   	push   %eax
  10517f:	e8 ac f3 ff ff       	call   104530 <memzero>
        memzero(proc_kstack, sizeof(struct kstack) * 64);
  105184:	58                   	pop    %eax
  105185:	5a                   	pop    %edx
  105186:	68 00 00 04 00       	push   $0x40000
  10518b:	ff b3 f4 ff ff ff    	push   -0xc(%ebx)
  105191:	e8 9a f3 ff ff       	call   104530 <memzero>
  105196:	83 c4 10             	add    $0x10,%esp
}
  105199:	83 c4 2c             	add    $0x2c,%esp
  10519c:	5b                   	pop    %ebx
  10519d:	5e                   	pop    %esi
  10519e:	5f                   	pop    %edi
  10519f:	5d                   	pop    %ebp
  1051a0:	c3                   	ret    
  1051a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1051a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1051af:	90                   	nop

001051b0 <seg_init_proc>:

/* initialize the kernel stack for each process */
void seg_init_proc(int cpu_idx, int pid)
{
  1051b0:	55                   	push   %ebp
        SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

    /* setup TSS */
    proc_kstack[pid].tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
    proc_kstack[pid].tss.ts_ss0 = CPU_GDT_KDATA;
    proc_kstack[pid].tss.ts_iomb = offsetof(tss_t, ts_iopm);
  1051b1:	ba 68 00 00 00       	mov    $0x68,%edx
{
  1051b6:	57                   	push   %edi
  1051b7:	56                   	push   %esi
  1051b8:	53                   	push   %ebx
  1051b9:	e8 cb b1 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1051be:	81 c3 42 ee 00 00    	add    $0xee42,%ebx
  1051c4:	83 ec 14             	sub    $0x14,%esp
  1051c7:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
  1051cb:	89 fe                	mov    %edi,%esi
  1051cd:	83 c7 01             	add    $0x1,%edi
  1051d0:	c7 c5 00 00 15 00    	mov    $0x150000,%ebp
  1051d6:	c1 e7 0c             	shl    $0xc,%edi
  1051d9:	c1 e6 0c             	shl    $0xc,%esi
  1051dc:	01 ee                	add    %ebp,%esi
    proc_kstack[pid].tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  1051de:	8d 04 2f             	lea    (%edi,%ebp,1),%eax
  1051e1:	89 46 34             	mov    %eax,0x34(%esi)
    proc_kstack[pid].tss.ts_ss0 = CPU_GDT_KDATA;
  1051e4:	b8 10 00 00 00       	mov    $0x10,%eax
  1051e9:	66 89 46 38          	mov    %ax,0x38(%esi)
    memzero (proc_kstack[pid].tss.ts_iopm, sizeof(uint8_t) * 128);
  1051ed:	8d 84 2f 98 f0 ff ff 	lea    -0xf68(%edi,%ebp,1),%eax
    proc_kstack[pid].tss.ts_iomb = offsetof(tss_t, ts_iopm);
  1051f4:	66 89 96 96 00 00 00 	mov    %dx,0x96(%esi)
    proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  1051fb:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  105201:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
    proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
  105208:	c7 46 08 ff ff 00 00 	movl   $0xffff,0x8(%esi)
  10520f:	c7 46 0c 00 9a cf 00 	movl   $0xcf9a00,0xc(%esi)
    proc_kstack[pid].gdt[CPU_GDT_KDATA >> 3] =
  105216:	c7 46 10 ff ff 00 00 	movl   $0xffff,0x10(%esi)
  10521d:	c7 46 14 00 92 cf 00 	movl   $0xcf9200,0x14(%esi)
    proc_kstack[pid].gdt[CPU_GDT_UCODE >> 3] =
  105224:	c7 46 18 ff ff 00 00 	movl   $0xffff,0x18(%esi)
  10522b:	c7 46 1c 00 fa cf 00 	movl   $0xcffa00,0x1c(%esi)
    proc_kstack[pid].gdt[CPU_GDT_UDATA >> 3] =
  105232:	c7 46 20 ff ff 00 00 	movl   $0xffff,0x20(%esi)
  105239:	c7 46 24 00 f2 cf 00 	movl   $0xcff200,0x24(%esi)
    memzero (proc_kstack[pid].tss.ts_iopm, sizeof(uint8_t) * 128);
  105240:	68 80 00 00 00       	push   $0x80
  105245:	50                   	push   %eax
  105246:	e8 e5 f2 ff ff       	call   104530 <memzero>
    proc_kstack[pid].tss.ts_iopm[128] = 0xff;

    proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
  10524b:	bb 89 40 00 00       	mov    $0x4089,%ebx
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  105250:	8d 84 2f 30 f0 ff ff 	lea    -0xfd0(%edi,%ebp,1),%eax
    proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
  105257:	b9 eb 00 00 00       	mov    $0xeb,%ecx
  10525c:	66 89 46 2a          	mov    %ax,0x2a(%esi)
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  105260:	89 c2                	mov    %eax,%edx
  105262:	c1 e8 18             	shr    $0x18,%eax
    proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
  105265:	88 46 2f             	mov    %al,0x2f(%esi)
    proc_kstack[pid].gdt[CPU_GDT_TSS >> 3].sd_s = 0;

    /* other fields */
    proc_kstack[pid].magic = KSTACK_MAGIC;
    proc_kstack[pid].cpu_idx = cpu_idx;
  105268:	8b 44 24 30          	mov    0x30(%esp),%eax
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  10526c:	c1 ea 10             	shr    $0x10,%edx
    proc_kstack[pid].tss.ts_iopm[128] = 0xff;
  10526f:	c6 86 18 01 00 00 ff 	movb   $0xff,0x118(%esi)
    proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
  105276:	66 89 4e 28          	mov    %cx,0x28(%esi)
  10527a:	88 56 2c             	mov    %dl,0x2c(%esi)
  10527d:	66 89 5e 2d          	mov    %bx,0x2d(%esi)
    proc_kstack[pid].magic = KSTACK_MAGIC;
  105281:	c7 86 20 01 00 00 32 	movl   $0x98765432,0x120(%esi)
  105288:	54 76 98 
    proc_kstack[pid].cpu_idx = cpu_idx;
  10528b:	89 86 1c 01 00 00    	mov    %eax,0x11c(%esi)
}
  105291:	83 c4 1c             	add    $0x1c,%esp
  105294:	5b                   	pop    %ebx
  105295:	5e                   	pop    %esi
  105296:	5f                   	pop    %edi
  105297:	5d                   	pop    %ebp
  105298:	c3                   	ret    
  105299:	66 90                	xchg   %ax,%ax
  10529b:	66 90                	xchg   %ax,%ax
  10529d:	66 90                	xchg   %ax,%ax
  10529f:	90                   	nop

001052a0 <max>:
#include "types.h"

uint32_t max(uint32_t a, uint32_t b)
{
  1052a0:	8b 44 24 08          	mov    0x8(%esp),%eax
    return (a > b) ? a : b;
  1052a4:	8b 54 24 04          	mov    0x4(%esp),%edx
  1052a8:	39 d0                	cmp    %edx,%eax
  1052aa:	0f 42 c2             	cmovb  %edx,%eax
}
  1052ad:	c3                   	ret    
  1052ae:	66 90                	xchg   %ax,%ax

001052b0 <min>:

uint32_t min(uint32_t a, uint32_t b)
{
  1052b0:	8b 44 24 08          	mov    0x8(%esp),%eax
    return (a < b) ? a : b;
  1052b4:	8b 54 24 04          	mov    0x4(%esp),%edx
  1052b8:	39 d0                	cmp    %edx,%eax
  1052ba:	0f 47 c2             	cmova  %edx,%eax
}
  1052bd:	c3                   	ret    
  1052be:	66 90                	xchg   %ax,%ax

001052c0 <rounddown>:

uint32_t rounddown(uint32_t a, uint32_t n)
{
  1052c0:	8b 4c 24 04          	mov    0x4(%esp),%ecx
    return a - a % n;
  1052c4:	31 d2                	xor    %edx,%edx
  1052c6:	89 c8                	mov    %ecx,%eax
  1052c8:	f7 74 24 08          	divl   0x8(%esp)
  1052cc:	89 c8                	mov    %ecx,%eax
  1052ce:	29 d0                	sub    %edx,%eax
}
  1052d0:	c3                   	ret    
  1052d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1052d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1052df:	90                   	nop

001052e0 <roundup>:

uint32_t roundup(uint32_t a, uint32_t n)
{
  1052e0:	53                   	push   %ebx
  1052e1:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
    return a - a % n;
  1052e5:	31 d2                	xor    %edx,%edx
    return rounddown(a + n - 1, n);
  1052e7:	8d 4b ff             	lea    -0x1(%ebx),%ecx
  1052ea:	03 4c 24 08          	add    0x8(%esp),%ecx
    return a - a % n;
  1052ee:	89 c8                	mov    %ecx,%eax
  1052f0:	f7 f3                	div    %ebx
  1052f2:	89 c8                	mov    %ecx,%eax
}
  1052f4:	5b                   	pop    %ebx
    return a - a % n;
  1052f5:	29 d0                	sub    %edx,%eax
}
  1052f7:	c3                   	ret    
  1052f8:	66 90                	xchg   %ax,%ax
  1052fa:	66 90                	xchg   %ax,%ax
  1052fc:	66 90                	xchg   %ax,%ax
  1052fe:	66 90                	xchg   %ax,%ax

00105300 <read_esp>:
#include "x86.h"

gcc_inline uintptr_t read_esp(void)
{
    uint32_t esp;
    __asm __volatile ("movl %%esp,%0" : "=rm" (esp));
  105300:	89 e0                	mov    %esp,%eax
    return esp;
}
  105302:	c3                   	ret    
  105303:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10530a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00105310 <read_ebp>:

gcc_inline uint32_t read_ebp(void)
{
    uint32_t ebp;
    __asm __volatile ("movl %%ebp,%0" : "=rm" (ebp));
  105310:	89 e8                	mov    %ebp,%eax
    return ebp;
}
  105312:	c3                   	ret    
  105313:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10531a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00105320 <lldt>:

gcc_inline void lldt(uint16_t sel)
{
    __asm __volatile ("lldt %0" :: "r" (sel));
  105320:	0f b7 44 24 04       	movzwl 0x4(%esp),%eax
  105325:	0f 00 d0             	lldt   %ax
}
  105328:	c3                   	ret    
  105329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105330 <cli>:

gcc_inline void cli(void)
{
    __asm __volatile ("cli" ::: "memory");
  105330:	fa                   	cli    
}
  105331:	c3                   	ret    
  105332:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105340 <sti>:

gcc_inline void sti(void)
{
    __asm __volatile ("sti; nop");
  105340:	fb                   	sti    
  105341:	90                   	nop
}
  105342:	c3                   	ret    
  105343:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10534a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00105350 <rdmsr>:

gcc_inline uint64_t rdmsr(uint32_t msr)
{
    uint64_t rv;
    __asm __volatile ("rdmsr"
  105350:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  105354:	0f 32                	rdmsr  
                      : "=A" (rv)
                      : "c" (msr));
    return rv;
}
  105356:	c3                   	ret    
  105357:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10535e:	66 90                	xchg   %ax,%ax

00105360 <wrmsr>:

gcc_inline void wrmsr(uint32_t msr, uint64_t newval)
{
    __asm __volatile ("wrmsr" :: "A" (newval), "c" (msr));
  105360:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  105364:	8b 44 24 08          	mov    0x8(%esp),%eax
  105368:	8b 54 24 0c          	mov    0xc(%esp),%edx
  10536c:	0f 30                	wrmsr  
}
  10536e:	c3                   	ret    
  10536f:	90                   	nop

00105370 <halt>:

gcc_inline void halt(void)
{
    __asm __volatile ("hlt");
  105370:	f4                   	hlt    
}
  105371:	c3                   	ret    
  105372:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105380 <pause>:

gcc_inline void pause(void)
{
    __asm __volatile ("pause" ::: "memory");
  105380:	f3 90                	pause  
}
  105382:	c3                   	ret    
  105383:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10538a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00105390 <xchg>:

gcc_inline uint32_t xchg(volatile uint32_t *addr, uint32_t newval)
{
  105390:	8b 54 24 04          	mov    0x4(%esp),%edx
    uint32_t result;

    __asm __volatile ("lock; xchgl %0, %1"
  105394:	8b 44 24 08          	mov    0x8(%esp),%eax
  105398:	f0 87 02             	lock xchg %eax,(%edx)
                      : "+m" (*addr), "=a" (result)
                      : "1" (newval)
                      : "cc");

    return result;
}
  10539b:	c3                   	ret    
  10539c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001053a0 <cmpxchg>:

gcc_inline uint32_t cmpxchg(volatile uint32_t *addr, uint32_t oldval, uint32_t newval)
{
  1053a0:	8b 4c 24 04          	mov    0x4(%esp),%ecx
    uint32_t result;

    __asm __volatile ("lock; cmpxchgl %2, %0"
  1053a4:	8b 44 24 08          	mov    0x8(%esp),%eax
  1053a8:	8b 54 24 0c          	mov    0xc(%esp),%edx
  1053ac:	f0 0f b1 11          	lock cmpxchg %edx,(%ecx)
                      : "+m" (*addr), "=a" (result)
                      : "r" (newval), "a" (oldval)
                      : "memory", "cc");

    return result;
}
  1053b0:	c3                   	ret    
  1053b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1053b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1053bf:	90                   	nop

001053c0 <rdtsc>:

gcc_inline uint64_t rdtsc(void)
{
    uint64_t rv;

    __asm __volatile ("rdtsc" : "=A" (rv));
  1053c0:	0f 31                	rdtsc  
    return (rv);
}
  1053c2:	c3                   	ret    
  1053c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1053ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001053d0 <enable_sse>:
}

gcc_inline uint32_t rcr4(void)
{
    uint32_t cr4;
    __asm __volatile ("movl %%cr4,%0" : "=r" (cr4));
  1053d0:	0f 20 e0             	mov    %cr4,%eax
    FENCE();
  1053d3:	0f ae f0             	mfence 
    cr4 = rcr4() | CR4_OSFXSR | CR4_OSXMMEXCPT;
  1053d6:	80 cc 06             	or     $0x6,%ah
    __asm __volatile ("movl %0,%%cr4" :: "r" (val));
  1053d9:	0f 22 e0             	mov    %eax,%cr4
    __asm __volatile ("movl %%cr0,%0" : "=r" (val));
  1053dc:	0f 20 c0             	mov    %cr0,%eax
    FENCE();
  1053df:	0f ae f0             	mfence 
}
  1053e2:	c3                   	ret    
  1053e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1053ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001053f0 <cpuid>:
{
  1053f0:	55                   	push   %ebp
  1053f1:	57                   	push   %edi
  1053f2:	56                   	push   %esi
  1053f3:	53                   	push   %ebx
  1053f4:	8b 44 24 14          	mov    0x14(%esp),%eax
  1053f8:	8b 74 24 18          	mov    0x18(%esp),%esi
  1053fc:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
  105400:	8b 6c 24 20          	mov    0x20(%esp),%ebp
    __asm __volatile ("cpuid"
  105404:	0f a2                	cpuid  
    if (eaxp)
  105406:	85 f6                	test   %esi,%esi
  105408:	74 02                	je     10540c <cpuid+0x1c>
        *eaxp = eax;
  10540a:	89 06                	mov    %eax,(%esi)
    if (ebxp)
  10540c:	85 ff                	test   %edi,%edi
  10540e:	74 02                	je     105412 <cpuid+0x22>
        *ebxp = ebx;
  105410:	89 1f                	mov    %ebx,(%edi)
    if (ecxp)
  105412:	85 ed                	test   %ebp,%ebp
  105414:	74 03                	je     105419 <cpuid+0x29>
        *ecxp = ecx;
  105416:	89 4d 00             	mov    %ecx,0x0(%ebp)
    if (edxp)
  105419:	8b 44 24 24          	mov    0x24(%esp),%eax
  10541d:	85 c0                	test   %eax,%eax
  10541f:	74 06                	je     105427 <cpuid+0x37>
        *edxp = edx;
  105421:	8b 44 24 24          	mov    0x24(%esp),%eax
  105425:	89 10                	mov    %edx,(%eax)
}
  105427:	5b                   	pop    %ebx
  105428:	5e                   	pop    %esi
  105429:	5f                   	pop    %edi
  10542a:	5d                   	pop    %ebp
  10542b:	c3                   	ret    
  10542c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00105430 <cpuid_subleaf>:
{
  105430:	55                   	push   %ebp
  105431:	57                   	push   %edi
  105432:	56                   	push   %esi
  105433:	53                   	push   %ebx
  105434:	8b 74 24 1c          	mov    0x1c(%esp),%esi
  105438:	8b 7c 24 20          	mov    0x20(%esp),%edi
  10543c:	8b 6c 24 24          	mov    0x24(%esp),%ebp
    asm volatile ("cpuid"
  105440:	8b 44 24 14          	mov    0x14(%esp),%eax
  105444:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  105448:	0f a2                	cpuid  
    if (eaxp)
  10544a:	85 f6                	test   %esi,%esi
  10544c:	74 02                	je     105450 <cpuid_subleaf+0x20>
        *eaxp = eax;
  10544e:	89 06                	mov    %eax,(%esi)
    if (ebxp)
  105450:	85 ff                	test   %edi,%edi
  105452:	74 02                	je     105456 <cpuid_subleaf+0x26>
        *ebxp = ebx;
  105454:	89 1f                	mov    %ebx,(%edi)
    if (ecxp)
  105456:	85 ed                	test   %ebp,%ebp
  105458:	74 03                	je     10545d <cpuid_subleaf+0x2d>
        *ecxp = ecx;
  10545a:	89 4d 00             	mov    %ecx,0x0(%ebp)
    if (edxp)
  10545d:	8b 44 24 28          	mov    0x28(%esp),%eax
  105461:	85 c0                	test   %eax,%eax
  105463:	74 06                	je     10546b <cpuid_subleaf+0x3b>
        *edxp = edx;
  105465:	8b 44 24 28          	mov    0x28(%esp),%eax
  105469:	89 10                	mov    %edx,(%eax)
}
  10546b:	5b                   	pop    %ebx
  10546c:	5e                   	pop    %esi
  10546d:	5f                   	pop    %edi
  10546e:	5d                   	pop    %ebp
  10546f:	c3                   	ret    

00105470 <rcr3>:
    __asm __volatile ("movl %%cr3,%0" : "=r" (val));
  105470:	0f 20 d8             	mov    %cr3,%eax
}
  105473:	c3                   	ret    
  105474:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10547b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10547f:	90                   	nop

00105480 <outl>:
    __asm __volatile ("outl %0,%w1" :: "a" (data), "d" (port));
  105480:	8b 54 24 04          	mov    0x4(%esp),%edx
  105484:	8b 44 24 08          	mov    0x8(%esp),%eax
  105488:	ef                   	out    %eax,(%dx)
}
  105489:	c3                   	ret    
  10548a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00105490 <inl>:
    __asm __volatile ("inl %w1,%0" : "=a" (data) : "d" (port));
  105490:	8b 54 24 04          	mov    0x4(%esp),%edx
  105494:	ed                   	in     (%dx),%eax
}
  105495:	c3                   	ret    
  105496:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10549d:	8d 76 00             	lea    0x0(%esi),%esi

001054a0 <smp_wmb>:
}
  1054a0:	c3                   	ret    
  1054a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1054a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1054af:	90                   	nop

001054b0 <ltr>:
    __asm __volatile ("ltr %0" :: "r" (sel));
  1054b0:	0f b7 44 24 04       	movzwl 0x4(%esp),%eax
  1054b5:	0f 00 d8             	ltr    %ax
}
  1054b8:	c3                   	ret    
  1054b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001054c0 <lcr0>:
    __asm __volatile ("movl %0,%%cr0" :: "r" (val));
  1054c0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1054c4:	0f 22 c0             	mov    %eax,%cr0
}
  1054c7:	c3                   	ret    
  1054c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1054cf:	90                   	nop

001054d0 <rcr0>:
    __asm __volatile ("movl %%cr0,%0" : "=r" (val));
  1054d0:	0f 20 c0             	mov    %cr0,%eax
}
  1054d3:	c3                   	ret    
  1054d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1054db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1054df:	90                   	nop

001054e0 <rcr2>:
    __asm __volatile ("movl %%cr2,%0" : "=r" (val));
  1054e0:	0f 20 d0             	mov    %cr2,%eax
}
  1054e3:	c3                   	ret    
  1054e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1054eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1054ef:	90                   	nop

001054f0 <lcr3>:
    __asm __volatile ("movl %0,%%cr3" :: "r" (val));
  1054f0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1054f4:	0f 22 d8             	mov    %eax,%cr3
}
  1054f7:	c3                   	ret    
  1054f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1054ff:	90                   	nop

00105500 <lcr4>:
    __asm __volatile ("movl %0,%%cr4" :: "r" (val));
  105500:	8b 44 24 04          	mov    0x4(%esp),%eax
  105504:	0f 22 e0             	mov    %eax,%cr4
}
  105507:	c3                   	ret    
  105508:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10550f:	90                   	nop

00105510 <rcr4>:
    __asm __volatile ("movl %%cr4,%0" : "=r" (cr4));
  105510:	0f 20 e0             	mov    %cr4,%eax
    return cr4;
}
  105513:	c3                   	ret    
  105514:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10551b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10551f:	90                   	nop

00105520 <inb>:

gcc_inline uint8_t inb(int port)
{
    uint8_t data;
    __asm __volatile ("inb %w1,%0"
  105520:	8b 54 24 04          	mov    0x4(%esp),%edx
  105524:	ec                   	in     (%dx),%al
                      : "=a" (data)
                      : "d" (port));
    return data;
}
  105525:	c3                   	ret    
  105526:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10552d:	8d 76 00             	lea    0x0(%esi),%esi

00105530 <insl>:

gcc_inline void insl(int port, void *addr, int cnt)
{
  105530:	57                   	push   %edi
    __asm __volatile ("cld\n\trepne\n\tinsl"
  105531:	8b 7c 24 0c          	mov    0xc(%esp),%edi
  105535:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  105539:	8b 54 24 08          	mov    0x8(%esp),%edx
  10553d:	fc                   	cld    
  10553e:	f2 6d                	repnz insl (%dx),%es:(%edi)
                      : "=D" (addr), "=c" (cnt)
                      : "d" (port), "0" (addr), "1" (cnt)
                      : "memory", "cc");
}
  105540:	5f                   	pop    %edi
  105541:	c3                   	ret    
  105542:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105550 <outb>:

gcc_inline void outb(int port, uint8_t data)
{
    __asm __volatile ("outb %0,%w1" :: "a" (data), "d" (port));
  105550:	8b 54 24 04          	mov    0x4(%esp),%edx
  105554:	0f b6 44 24 08       	movzbl 0x8(%esp),%eax
  105559:	ee                   	out    %al,(%dx)
}
  10555a:	c3                   	ret    
  10555b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10555f:	90                   	nop

00105560 <outsw>:

gcc_inline void outsw(int port, const void *addr, int cnt)
{
  105560:	56                   	push   %esi
    __asm __volatile ("cld\n\trepne\n\toutsw"
  105561:	8b 74 24 0c          	mov    0xc(%esp),%esi
  105565:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  105569:	8b 54 24 08          	mov    0x8(%esp),%edx
  10556d:	fc                   	cld    
  10556e:	f2 66 6f             	repnz outsw %ds:(%esi),(%dx)
                      : "=S" (addr), "=c" (cnt)
                      : "d" (port), "0" (addr), "1" (cnt)
                      : "cc");
}
  105571:	5e                   	pop    %esi
  105572:	c3                   	ret    
  105573:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10557a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00105580 <outsl>:

gcc_inline void outsl(int port, const void *addr, int cnt)
{
  105580:	56                   	push   %esi
    __asm __volatile ("cld\n\trepne\n\toutsl"
  105581:	8b 74 24 0c          	mov    0xc(%esp),%esi
  105585:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  105589:	8b 54 24 08          	mov    0x8(%esp),%edx
  10558d:	fc                   	cld    
  10558e:	f2 6f                	repnz outsl %ds:(%esi),(%dx)
                      : "=S" (addr), "=c" (cnt)
                      : "d" (port), "0" (addr), "1" (cnt)
                      : "cc");
}
  105590:	5e                   	pop    %esi
  105591:	c3                   	ret    
  105592:	66 90                	xchg   %ax,%ax
  105594:	66 90                	xchg   %ax,%ax
  105596:	66 90                	xchg   %ax,%ax
  105598:	66 90                	xchg   %ax,%ax
  10559a:	66 90                	xchg   %ax,%ax
  10559c:	66 90                	xchg   %ax,%ax
  10559e:	66 90                	xchg   %ax,%ax

001055a0 <mon_help>:

#define NCOMMANDS (sizeof(commands) / sizeof(commands[0]))

/***** Implementations of basic kernel monitor commands *****/
int mon_help(int argc, char **argv, struct Trapframe *tf)
{
  1055a0:	56                   	push   %esi
  1055a1:	53                   	push   %ebx
  1055a2:	e8 e2 ad ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1055a7:	81 c3 59 ea 00 00    	add    $0xea59,%ebx
  1055ad:	83 ec 08             	sub    $0x8,%esp
    int i;

    for (i = 0; i < NCOMMANDS; i++)
        dprintf("%s - %s\n", commands[i].name, commands[i].desc);
  1055b0:	8d 83 3c 84 ff ff    	lea    -0x7bc4(%ebx),%eax
  1055b6:	8d b3 5f 84 ff ff    	lea    -0x7ba1(%ebx),%esi
  1055bc:	50                   	push   %eax
  1055bd:	8d 83 5a 84 ff ff    	lea    -0x7ba6(%ebx),%eax
  1055c3:	50                   	push   %eax
  1055c4:	56                   	push   %esi
  1055c5:	e8 96 f3 ff ff       	call   104960 <dprintf>
  1055ca:	83 c4 0c             	add    $0xc,%esp
  1055cd:	8d 83 04 85 ff ff    	lea    -0x7afc(%ebx),%eax
  1055d3:	50                   	push   %eax
  1055d4:	8d 83 68 84 ff ff    	lea    -0x7b98(%ebx),%eax
  1055da:	50                   	push   %eax
  1055db:	56                   	push   %esi
  1055dc:	e8 7f f3 ff ff       	call   104960 <dprintf>
    return 0;
}
  1055e1:	83 c4 14             	add    $0x14,%esp
  1055e4:	31 c0                	xor    %eax,%eax
  1055e6:	5b                   	pop    %ebx
  1055e7:	5e                   	pop    %esi
  1055e8:	c3                   	ret    
  1055e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001055f0 <mon_kerninfo>:

int mon_kerninfo(int argc, char **argv, struct Trapframe *tf)
{
  1055f0:	57                   	push   %edi
  1055f1:	56                   	push   %esi
  1055f2:	53                   	push   %ebx
  1055f3:	e8 91 ad ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1055f8:	81 c3 08 ea 00 00    	add    $0xea08,%ebx
    extern uint8_t start[], etext[], edata[], end[];

    dprintf("Special kernel symbols:\n");
  1055fe:	83 ec 0c             	sub    $0xc,%esp
  105601:	8d 83 71 84 ff ff    	lea    -0x7b8f(%ebx),%eax
  105607:	50                   	push   %eax
  105608:	e8 53 f3 ff ff       	call   104960 <dprintf>
    dprintf("  start  %08x\n", start);
  10560d:	c7 c7 80 64 10 00    	mov    $0x106480,%edi
  105613:	58                   	pop    %eax
  105614:	8d 83 8a 84 ff ff    	lea    -0x7b76(%ebx),%eax
  10561a:	5a                   	pop    %edx
  10561b:	57                   	push   %edi
  10561c:	50                   	push   %eax
  10561d:	e8 3e f3 ff ff       	call   104960 <dprintf>
    dprintf("  etext  %08x\n", etext);
  105622:	8d 83 99 84 ff ff    	lea    -0x7b67(%ebx),%eax
  105628:	59                   	pop    %ecx
  105629:	5e                   	pop    %esi
  10562a:	ff b3 f8 ff ff ff    	push   -0x8(%ebx)
  105630:	50                   	push   %eax
  105631:	e8 2a f3 ff ff       	call   104960 <dprintf>
    dprintf("  edata  %08x\n", edata);
  105636:	58                   	pop    %eax
  105637:	8d 83 a8 84 ff ff    	lea    -0x7b58(%ebx),%eax
  10563d:	5a                   	pop    %edx
  10563e:	ff b3 f0 ff ff ff    	push   -0x10(%ebx)
  105644:	50                   	push   %eax
  105645:	e8 16 f3 ff ff       	call   104960 <dprintf>
    dprintf("  end    %08x\n", end);
  10564a:	59                   	pop    %ecx
  10564b:	5e                   	pop    %esi
  10564c:	8d 83 b7 84 ff ff    	lea    -0x7b49(%ebx),%eax
  105652:	c7 c6 58 0f e2 00    	mov    $0xe20f58,%esi
  105658:	56                   	push   %esi
    dprintf("Kernel executable memory footprint: %dKB\n",
            ROUNDUP(end - start, 1024) / 1024);
  105659:	29 fe                	sub    %edi,%esi
    dprintf("  end    %08x\n", end);
  10565b:	50                   	push   %eax
  10565c:	e8 ff f2 ff ff       	call   104960 <dprintf>
            ROUNDUP(end - start, 1024) / 1024);
  105661:	8d 86 ff 03 00 00    	lea    0x3ff(%esi),%eax
    dprintf("Kernel executable memory footprint: %dKB\n",
  105667:	5f                   	pop    %edi
  105668:	5a                   	pop    %edx
            ROUNDUP(end - start, 1024) / 1024);
  105669:	89 c1                	mov    %eax,%ecx
  10566b:	c1 f9 1f             	sar    $0x1f,%ecx
  10566e:	c1 e9 16             	shr    $0x16,%ecx
  105671:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  105674:	81 e2 ff 03 00 00    	and    $0x3ff,%edx
  10567a:	29 ca                	sub    %ecx,%edx
  10567c:	29 d0                	sub    %edx,%eax
    dprintf("Kernel executable memory footprint: %dKB\n",
  10567e:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  105684:	0f 48 c2             	cmovs  %edx,%eax
  105687:	c1 f8 0a             	sar    $0xa,%eax
  10568a:	50                   	push   %eax
  10568b:	8d 83 2c 85 ff ff    	lea    -0x7ad4(%ebx),%eax
  105691:	50                   	push   %eax
  105692:	e8 c9 f2 ff ff       	call   104960 <dprintf>
    return 0;
  105697:	83 c4 10             	add    $0x10,%esp
}
  10569a:	31 c0                	xor    %eax,%eax
  10569c:	5b                   	pop    %ebx
  10569d:	5e                   	pop    %esi
  10569e:	5f                   	pop    %edi
  10569f:	c3                   	ret    

001056a0 <monitor>:
    dprintf("Unknown command '%s'\n", argv[0]);
    return 0;
}

void monitor(struct Trapframe *tf)
{
  1056a0:	55                   	push   %ebp
  1056a1:	57                   	push   %edi
  1056a2:	56                   	push   %esi
  1056a3:	53                   	push   %ebx
  1056a4:	e8 e0 ac ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1056a9:	81 c3 57 e9 00 00    	add    $0xe957,%ebx
  1056af:	83 ec 68             	sub    $0x68,%esp
    char *buf;

    dprintf("\n****************************************\n\n");
  1056b2:	8d b3 58 85 ff ff    	lea    -0x7aa8(%ebx),%esi
  1056b8:	56                   	push   %esi
  1056b9:	e8 a2 f2 ff ff       	call   104960 <dprintf>
    dprintf("Welcome to the mCertiKOS kernel monitor!\n");
  1056be:	8d 83 84 85 ff ff    	lea    -0x7a7c(%ebx),%eax
  1056c4:	89 04 24             	mov    %eax,(%esp)
  1056c7:	e8 94 f2 ff ff       	call   104960 <dprintf>
    dprintf("\n****************************************\n\n");
  1056cc:	89 34 24             	mov    %esi,(%esp)
        while (*buf && strchr(WHITESPACE, *buf))
  1056cf:	8d b3 ca 84 ff ff    	lea    -0x7b36(%ebx),%esi
    dprintf("\n****************************************\n\n");
  1056d5:	e8 86 f2 ff ff       	call   104960 <dprintf>
    dprintf("Type 'help' for a list of commands.\n");
  1056da:	8d 83 b0 85 ff ff    	lea    -0x7a50(%ebx),%eax
  1056e0:	89 04 24             	mov    %eax,(%esp)
  1056e3:	e8 78 f2 ff ff       	call   104960 <dprintf>
  1056e8:	83 c4 10             	add    $0x10,%esp
  1056eb:	8d 83 c6 84 ff ff    	lea    -0x7b3a(%ebx),%eax
  1056f1:	89 04 24             	mov    %eax,(%esp)
  1056f4:	8d 83 5a 84 ff ff    	lea    -0x7ba6(%ebx),%eax
  1056fa:	89 44 24 08          	mov    %eax,0x8(%esp)
  1056fe:	8d 44 24 10          	lea    0x10(%esp),%eax
  105702:	89 44 24 0c          	mov    %eax,0xc(%esp)
  105706:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10570d:	8d 76 00             	lea    0x0(%esi),%esi

    while (1) {
        buf = (char *) readline("$> ");
  105710:	83 ec 0c             	sub    $0xc,%esp
  105713:	ff 74 24 0c          	push   0xc(%esp)
  105717:	e8 54 ae ff ff       	call   100570 <readline>
        if (buf != NULL)
  10571c:	83 c4 10             	add    $0x10,%esp
        buf = (char *) readline("$> ");
  10571f:	89 c5                	mov    %eax,%ebp
        if (buf != NULL)
  105721:	85 c0                	test   %eax,%eax
  105723:	74 eb                	je     105710 <monitor+0x70>
    argv[argc] = 0;
  105725:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  10572c:	00 
  10572d:	0f be 10             	movsbl (%eax),%edx
    argc = 0;
  105730:	31 c9                	xor    %ecx,%ecx
  105732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        while (*buf && strchr(WHITESPACE, *buf))
  105738:	84 d2                	test   %dl,%dl
  10573a:	75 74                	jne    1057b0 <monitor+0x110>
    if (argc == 0)
  10573c:	85 c9                	test   %ecx,%ecx
    argv[argc] = 0;
  10573e:	c7 44 8c 10 00 00 00 	movl   $0x0,0x10(%esp,%ecx,4)
  105745:	00 
    if (argc == 0)
  105746:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  10574a:	74 c4                	je     105710 <monitor+0x70>
        if (strcmp(argv[0], commands[i].name) == 0)
  10574c:	83 ec 08             	sub    $0x8,%esp
  10574f:	ff 74 24 10          	push   0x10(%esp)
  105753:	ff 74 24 1c          	push   0x1c(%esp)
  105757:	e8 44 ed ff ff       	call   1044a0 <strcmp>
  10575c:	83 c4 10             	add    $0x10,%esp
  10575f:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  105763:	85 c0                	test   %eax,%eax
  105765:	0f 84 db 00 00 00    	je     105846 <monitor+0x1a6>
  10576b:	83 ec 08             	sub    $0x8,%esp
  10576e:	8d 83 68 84 ff ff    	lea    -0x7b98(%ebx),%eax
  105774:	50                   	push   %eax
  105775:	ff 74 24 1c          	push   0x1c(%esp)
  105779:	e8 22 ed ff ff       	call   1044a0 <strcmp>
  10577e:	83 c4 10             	add    $0x10,%esp
  105781:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  105785:	85 c0                	test   %eax,%eax
  105787:	0f 84 e0 00 00 00    	je     10586d <monitor+0x1cd>
    dprintf("Unknown command '%s'\n", argv[0]);
  10578d:	83 ec 08             	sub    $0x8,%esp
  105790:	8d 83 ec 84 ff ff    	lea    -0x7b14(%ebx),%eax
  105796:	ff 74 24 18          	push   0x18(%esp)
  10579a:	50                   	push   %eax
  10579b:	e8 c0 f1 ff ff       	call   104960 <dprintf>
    return 0;
  1057a0:	83 c4 10             	add    $0x10,%esp
  1057a3:	e9 68 ff ff ff       	jmp    105710 <monitor+0x70>
  1057a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1057af:	90                   	nop
  1057b0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
        while (*buf && strchr(WHITESPACE, *buf))
  1057b4:	83 ec 08             	sub    $0x8,%esp
  1057b7:	52                   	push   %edx
  1057b8:	56                   	push   %esi
  1057b9:	e8 32 ed ff ff       	call   1044f0 <strchr>
  1057be:	83 c4 10             	add    $0x10,%esp
  1057c1:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1057c5:	85 c0                	test   %eax,%eax
  1057c7:	74 17                	je     1057e0 <monitor+0x140>
            *buf++ = 0;
  1057c9:	8d 45 01             	lea    0x1(%ebp),%eax
  1057cc:	c6 45 00 00          	movb   $0x0,0x0(%ebp)
  1057d0:	89 cf                	mov    %ecx,%edi
  1057d2:	89 c5                	mov    %eax,%ebp
  1057d4:	0f be 55 00          	movsbl 0x0(%ebp),%edx
  1057d8:	89 f9                	mov    %edi,%ecx
  1057da:	e9 59 ff ff ff       	jmp    105738 <monitor+0x98>
  1057df:	90                   	nop
        if (*buf == 0)
  1057e0:	80 7d 00 00          	cmpb   $0x0,0x0(%ebp)
  1057e4:	0f 84 52 ff ff ff    	je     10573c <monitor+0x9c>
        if (argc == MAXARGS - 1) {
  1057ea:	83 f9 0f             	cmp    $0xf,%ecx
  1057ed:	74 3e                	je     10582d <monitor+0x18d>
        argv[argc++] = buf;
  1057ef:	89 6c 8c 10          	mov    %ebp,0x10(%esp,%ecx,4)
        while (*buf && !strchr(WHITESPACE, *buf))
  1057f3:	0f be 55 00          	movsbl 0x0(%ebp),%edx
        argv[argc++] = buf;
  1057f7:	8d 79 01             	lea    0x1(%ecx),%edi
        while (*buf && !strchr(WHITESPACE, *buf))
  1057fa:	0f be c2             	movsbl %dl,%eax
  1057fd:	84 d2                	test   %dl,%dl
  1057ff:	74 d7                	je     1057d8 <monitor+0x138>
  105801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105808:	83 ec 08             	sub    $0x8,%esp
  10580b:	50                   	push   %eax
  10580c:	56                   	push   %esi
  10580d:	e8 de ec ff ff       	call   1044f0 <strchr>
  105812:	83 c4 10             	add    $0x10,%esp
  105815:	85 c0                	test   %eax,%eax
  105817:	75 bb                	jne    1057d4 <monitor+0x134>
  105819:	0f be 45 01          	movsbl 0x1(%ebp),%eax
            buf++;
  10581d:	83 c5 01             	add    $0x1,%ebp
        while (*buf && !strchr(WHITESPACE, *buf))
  105820:	84 c0                	test   %al,%al
  105822:	75 e4                	jne    105808 <monitor+0x168>
  105824:	31 d2                	xor    %edx,%edx
            *buf++ = 0;
  105826:	89 f9                	mov    %edi,%ecx
  105828:	e9 0b ff ff ff       	jmp    105738 <monitor+0x98>
            dprintf("Too many arguments (max %d)\n", MAXARGS);
  10582d:	83 ec 08             	sub    $0x8,%esp
  105830:	8d 83 cf 84 ff ff    	lea    -0x7b31(%ebx),%eax
  105836:	6a 10                	push   $0x10
  105838:	50                   	push   %eax
  105839:	e8 22 f1 ff ff       	call   104960 <dprintf>
            return 0;
  10583e:	83 c4 10             	add    $0x10,%esp
  105841:	e9 ca fe ff ff       	jmp    105710 <monitor+0x70>
        if (strcmp(argv[0], commands[i].name) == 0)
  105846:	8d 83 a0 15 ff ff    	lea    -0xea60(%ebx),%eax
            return commands[i].func(argc, argv, tf);
  10584c:	83 ec 04             	sub    $0x4,%esp
  10584f:	ff 74 24 74          	push   0x74(%esp)
  105853:	ff 74 24 14          	push   0x14(%esp)
  105857:	51                   	push   %ecx
  105858:	ff d0                	call   *%eax
            if (runcmd(buf, tf) < 0)
  10585a:	83 c4 10             	add    $0x10,%esp
  10585d:	85 c0                	test   %eax,%eax
  10585f:	0f 89 ab fe ff ff    	jns    105710 <monitor+0x70>
                break;
    }
}
  105865:	83 c4 5c             	add    $0x5c,%esp
  105868:	5b                   	pop    %ebx
  105869:	5e                   	pop    %esi
  10586a:	5f                   	pop    %edi
  10586b:	5d                   	pop    %ebp
  10586c:	c3                   	ret    
        if (strcmp(argv[0], commands[i].name) == 0)
  10586d:	8d 83 f0 15 ff ff    	lea    -0xea10(%ebx),%eax
  105873:	eb d7                	jmp    10584c <monitor+0x1ac>
  105875:	66 90                	xchg   %ax,%ax
  105877:	66 90                	xchg   %ax,%ax
  105879:	66 90                	xchg   %ax,%ax
  10587b:	66 90                	xchg   %ax,%ax
  10587d:	66 90                	xchg   %ax,%ax
  10587f:	90                   	nop

00105880 <pt_copyin>:
                       unsigned int perm);
extern unsigned int get_ptbl_entry_by_va(unsigned int pid,
                                         unsigned int vaddr);

size_t pt_copyin(uint32_t pmap_id, uintptr_t uva, void *kva, size_t len)
{
  105880:	55                   	push   %ebp
    if (!(VM_USERLO <= uva && uva + len <= VM_USERHI))
        return 0;
  105881:	31 ed                	xor    %ebp,%ebp
{
  105883:	57                   	push   %edi
  105884:	56                   	push   %esi
  105885:	53                   	push   %ebx
  105886:	e8 fe aa ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10588b:	81 c3 75 e7 00 00    	add    $0xe775,%ebx
  105891:	83 ec 1c             	sub    $0x1c,%esp
  105894:	8b 7c 24 34          	mov    0x34(%esp),%edi
  105898:	8b 74 24 3c          	mov    0x3c(%esp),%esi
    if (!(VM_USERLO <= uva && uva + len <= VM_USERHI))
  10589c:	81 ff ff ff ff 3f    	cmp    $0x3fffffff,%edi
  1058a2:	0f 86 b4 00 00 00    	jbe    10595c <pt_copyin+0xdc>
  1058a8:	8d 04 37             	lea    (%edi,%esi,1),%eax
  1058ab:	3d 00 00 00 f0       	cmp    $0xf0000000,%eax
  1058b0:	0f 87 a6 00 00 00    	ja     10595c <pt_copyin+0xdc>

    if ((uintptr_t) kva + len > VM_USERHI)
  1058b6:	8b 44 24 38          	mov    0x38(%esp),%eax
  1058ba:	01 f0                	add    %esi,%eax
  1058bc:	3d 00 00 00 f0       	cmp    $0xf0000000,%eax
  1058c1:	0f 87 95 00 00 00    	ja     10595c <pt_copyin+0xdc>
        return 0;

    size_t copied = 0;

    while (len) {
  1058c7:	85 f6                	test   %esi,%esi
  1058c9:	0f 84 8d 00 00 00    	je     10595c <pt_copyin+0xdc>
            uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
        }

        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);

        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1058cf:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  1058d3:	8b 6c 24 38          	mov    0x38(%esp),%ebp
  1058d7:	eb 44                	jmp    10591d <pt_copyin+0x9d>
  1058d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  1058e0:	89 f9                	mov    %edi,%ecx
        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1058e2:	ba 00 10 00 00       	mov    $0x1000,%edx
        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  1058e7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  1058ec:	81 e1 ff 0f 00 00    	and    $0xfff,%ecx
        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1058f2:	29 ca                	sub    %ecx,%edx
        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  1058f4:	09 c8                	or     %ecx,%eax
        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1058f6:	39 f2                	cmp    %esi,%edx
  1058f8:	0f 47 d6             	cmova  %esi,%edx
            len : PAGESIZE - uva_pa % PAGESIZE;

        memcpy(kva, (void *) uva_pa, size);
  1058fb:	83 ec 04             	sub    $0x4,%esp
  1058fe:	52                   	push   %edx
  1058ff:	89 54 24 10          	mov    %edx,0x10(%esp)
  105903:	50                   	push   %eax
  105904:	55                   	push   %ebp
  105905:	e8 06 eb ff ff       	call   104410 <memcpy>

        len -= size;
        uva += size;
  10590a:	8b 54 24 18          	mov    0x18(%esp),%edx
        kva += size;
        copied += size;
  10590e:	01 54 24 1c          	add    %edx,0x1c(%esp)
    while (len) {
  105912:	83 c4 10             	add    $0x10,%esp
        uva += size;
  105915:	01 d7                	add    %edx,%edi
        kva += size;
  105917:	01 d5                	add    %edx,%ebp
    while (len) {
  105919:	29 d6                	sub    %edx,%esi
  10591b:	74 3b                	je     105958 <pt_copyin+0xd8>
        uintptr_t uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
  10591d:	83 ec 08             	sub    $0x8,%esp
  105920:	57                   	push   %edi
  105921:	ff 74 24 3c          	push   0x3c(%esp)
  105925:	e8 46 14 00 00       	call   106d70 <get_ptbl_entry_by_va>
        if ((uva_pa & PTE_P) == 0) {
  10592a:	83 c4 10             	add    $0x10,%esp
  10592d:	a8 01                	test   $0x1,%al
  10592f:	75 af                	jne    1058e0 <pt_copyin+0x60>
            alloc_page(pmap_id, uva, PTE_P | PTE_U | PTE_W);
  105931:	83 ec 04             	sub    $0x4,%esp
  105934:	6a 07                	push   $0x7
  105936:	57                   	push   %edi
  105937:	ff 74 24 3c          	push   0x3c(%esp)
  10593b:	e8 e0 18 00 00       	call   107220 <alloc_page>
            uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
  105940:	58                   	pop    %eax
  105941:	5a                   	pop    %edx
  105942:	57                   	push   %edi
  105943:	ff 74 24 3c          	push   0x3c(%esp)
  105947:	e8 24 14 00 00       	call   106d70 <get_ptbl_entry_by_va>
  10594c:	83 c4 10             	add    $0x10,%esp
  10594f:	eb 8f                	jmp    1058e0 <pt_copyin+0x60>
  105951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105958:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
    }

    return copied;
}
  10595c:	83 c4 1c             	add    $0x1c,%esp
  10595f:	89 e8                	mov    %ebp,%eax
  105961:	5b                   	pop    %ebx
  105962:	5e                   	pop    %esi
  105963:	5f                   	pop    %edi
  105964:	5d                   	pop    %ebp
  105965:	c3                   	ret    
  105966:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10596d:	8d 76 00             	lea    0x0(%esi),%esi

00105970 <pt_copyout>:

size_t pt_copyout(void *kva, uint32_t pmap_id, uintptr_t uva, size_t len)
{
  105970:	55                   	push   %ebp
    if (!(VM_USERLO <= uva && uva + len <= VM_USERHI))
        return 0;
  105971:	31 ed                	xor    %ebp,%ebp
{
  105973:	57                   	push   %edi
  105974:	56                   	push   %esi
  105975:	53                   	push   %ebx
  105976:	e8 0e aa ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10597b:	81 c3 85 e6 00 00    	add    $0xe685,%ebx
  105981:	83 ec 1c             	sub    $0x1c,%esp
  105984:	8b 7c 24 38          	mov    0x38(%esp),%edi
  105988:	8b 74 24 3c          	mov    0x3c(%esp),%esi
    if (!(VM_USERLO <= uva && uva + len <= VM_USERHI))
  10598c:	81 ff ff ff ff 3f    	cmp    $0x3fffffff,%edi
  105992:	0f 86 b4 00 00 00    	jbe    105a4c <pt_copyout+0xdc>
  105998:	8d 04 37             	lea    (%edi,%esi,1),%eax
  10599b:	3d 00 00 00 f0       	cmp    $0xf0000000,%eax
  1059a0:	0f 87 a6 00 00 00    	ja     105a4c <pt_copyout+0xdc>

    if ((uintptr_t) kva + len > VM_USERHI)
  1059a6:	8b 44 24 30          	mov    0x30(%esp),%eax
  1059aa:	01 f0                	add    %esi,%eax
  1059ac:	3d 00 00 00 f0       	cmp    $0xf0000000,%eax
  1059b1:	0f 87 95 00 00 00    	ja     105a4c <pt_copyout+0xdc>
        return 0;

    size_t copied = 0;

    while (len) {
  1059b7:	85 f6                	test   %esi,%esi
  1059b9:	0f 84 8d 00 00 00    	je     105a4c <pt_copyout+0xdc>
            uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
        }

        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);

        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1059bf:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  1059c3:	8b 6c 24 30          	mov    0x30(%esp),%ebp
  1059c7:	eb 44                	jmp    105a0d <pt_copyout+0x9d>
  1059c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  1059d0:	89 f9                	mov    %edi,%ecx
        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1059d2:	ba 00 10 00 00       	mov    $0x1000,%edx
        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  1059d7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  1059dc:	81 e1 ff 0f 00 00    	and    $0xfff,%ecx
        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1059e2:	29 ca                	sub    %ecx,%edx
        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  1059e4:	09 c8                	or     %ecx,%eax
        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1059e6:	39 f2                	cmp    %esi,%edx
  1059e8:	0f 47 d6             	cmova  %esi,%edx
            len : PAGESIZE - uva_pa % PAGESIZE;

        memcpy((void *) uva_pa, kva, size);
  1059eb:	83 ec 04             	sub    $0x4,%esp
  1059ee:	52                   	push   %edx
  1059ef:	89 54 24 10          	mov    %edx,0x10(%esp)
  1059f3:	55                   	push   %ebp
  1059f4:	50                   	push   %eax
  1059f5:	e8 16 ea ff ff       	call   104410 <memcpy>

        len -= size;
        uva += size;
  1059fa:	8b 54 24 18          	mov    0x18(%esp),%edx
        kva += size;
        copied += size;
  1059fe:	01 54 24 1c          	add    %edx,0x1c(%esp)
    while (len) {
  105a02:	83 c4 10             	add    $0x10,%esp
        uva += size;
  105a05:	01 d7                	add    %edx,%edi
        kva += size;
  105a07:	01 d5                	add    %edx,%ebp
    while (len) {
  105a09:	29 d6                	sub    %edx,%esi
  105a0b:	74 3b                	je     105a48 <pt_copyout+0xd8>
        uintptr_t uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
  105a0d:	83 ec 08             	sub    $0x8,%esp
  105a10:	57                   	push   %edi
  105a11:	ff 74 24 40          	push   0x40(%esp)
  105a15:	e8 56 13 00 00       	call   106d70 <get_ptbl_entry_by_va>
        if ((uva_pa & PTE_P) == 0) {
  105a1a:	83 c4 10             	add    $0x10,%esp
  105a1d:	a8 01                	test   $0x1,%al
  105a1f:	75 af                	jne    1059d0 <pt_copyout+0x60>
            alloc_page(pmap_id, uva, PTE_P | PTE_U | PTE_W);
  105a21:	83 ec 04             	sub    $0x4,%esp
  105a24:	6a 07                	push   $0x7
  105a26:	57                   	push   %edi
  105a27:	ff 74 24 40          	push   0x40(%esp)
  105a2b:	e8 f0 17 00 00       	call   107220 <alloc_page>
            uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
  105a30:	58                   	pop    %eax
  105a31:	5a                   	pop    %edx
  105a32:	57                   	push   %edi
  105a33:	ff 74 24 40          	push   0x40(%esp)
  105a37:	e8 34 13 00 00       	call   106d70 <get_ptbl_entry_by_va>
  105a3c:	83 c4 10             	add    $0x10,%esp
  105a3f:	eb 8f                	jmp    1059d0 <pt_copyout+0x60>
  105a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105a48:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
    }

    return copied;
}
  105a4c:	83 c4 1c             	add    $0x1c,%esp
  105a4f:	89 e8                	mov    %ebp,%eax
  105a51:	5b                   	pop    %ebx
  105a52:	5e                   	pop    %esi
  105a53:	5f                   	pop    %edi
  105a54:	5d                   	pop    %ebp
  105a55:	c3                   	ret    
  105a56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105a5d:	8d 76 00             	lea    0x0(%esi),%esi

00105a60 <pt_memset>:

size_t pt_memset(uint32_t pmap_id, uintptr_t va, char c, size_t len)
{
  105a60:	55                   	push   %ebp
  105a61:	57                   	push   %edi
  105a62:	56                   	push   %esi
  105a63:	53                   	push   %ebx
  105a64:	e8 20 a9 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105a69:	81 c3 97 e5 00 00    	add    $0xe597,%ebx
  105a6f:	83 ec 1c             	sub    $0x1c,%esp
  105a72:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  105a76:	8b 7c 24 34          	mov    0x34(%esp),%edi
  105a7a:	8b 44 24 38          	mov    0x38(%esp),%eax
    size_t set = 0;

    while (len) {
  105a7e:	85 f6                	test   %esi,%esi
  105a80:	0f 84 8a 00 00 00    	je     105b10 <pt_memset+0xb0>
        pa = (pa & 0xfffff000) + (va % PAGESIZE);

        size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
            len : PAGESIZE - pa % PAGESIZE;

        memset((void *) pa, c, size);
  105a86:	0f be c0             	movsbl %al,%eax
    size_t set = 0;
  105a89:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  105a90:	00 
        memset((void *) pa, c, size);
  105a91:	89 44 24 0c          	mov    %eax,0xc(%esp)
  105a95:	eb 41                	jmp    105ad8 <pt_memset+0x78>
  105a97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105a9e:	66 90                	xchg   %ax,%ax
        pa = (pa & 0xfffff000) + (va % PAGESIZE);
  105aa0:	89 f9                	mov    %edi,%ecx
        size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
  105aa2:	ba 00 10 00 00       	mov    $0x1000,%edx
        pa = (pa & 0xfffff000) + (va % PAGESIZE);
  105aa7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  105aac:	81 e1 ff 0f 00 00    	and    $0xfff,%ecx
        size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
  105ab2:	29 ca                	sub    %ecx,%edx
        pa = (pa & 0xfffff000) + (va % PAGESIZE);
  105ab4:	09 c8                	or     %ecx,%eax
        size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
  105ab6:	39 f2                	cmp    %esi,%edx
  105ab8:	0f 47 d6             	cmova  %esi,%edx
        memset((void *) pa, c, size);
  105abb:	83 ec 04             	sub    $0x4,%esp
  105abe:	52                   	push   %edx
        size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
  105abf:	89 d5                	mov    %edx,%ebp
        memset((void *) pa, c, size);
  105ac1:	ff 74 24 14          	push   0x14(%esp)

        len -= size;
        va += size;
  105ac5:	01 ef                	add    %ebp,%edi
        memset((void *) pa, c, size);
  105ac7:	50                   	push   %eax
  105ac8:	e8 83 e8 ff ff       	call   104350 <memset>
        set += size;
  105acd:	01 6c 24 18          	add    %ebp,0x18(%esp)
    while (len) {
  105ad1:	83 c4 10             	add    $0x10,%esp
  105ad4:	29 ee                	sub    %ebp,%esi
  105ad6:	74 40                	je     105b18 <pt_memset+0xb8>
        uintptr_t pa = get_ptbl_entry_by_va(pmap_id, va);
  105ad8:	83 ec 08             	sub    $0x8,%esp
  105adb:	57                   	push   %edi
  105adc:	ff 74 24 3c          	push   0x3c(%esp)
  105ae0:	e8 8b 12 00 00       	call   106d70 <get_ptbl_entry_by_va>
        if ((pa & PTE_P) == 0) {
  105ae5:	83 c4 10             	add    $0x10,%esp
  105ae8:	a8 01                	test   $0x1,%al
  105aea:	75 b4                	jne    105aa0 <pt_memset+0x40>
            alloc_page(pmap_id, va, PTE_P | PTE_U | PTE_W);
  105aec:	83 ec 04             	sub    $0x4,%esp
  105aef:	6a 07                	push   $0x7
  105af1:	57                   	push   %edi
  105af2:	ff 74 24 3c          	push   0x3c(%esp)
  105af6:	e8 25 17 00 00       	call   107220 <alloc_page>
            pa = get_ptbl_entry_by_va(pmap_id, va);
  105afb:	58                   	pop    %eax
  105afc:	5a                   	pop    %edx
  105afd:	57                   	push   %edi
  105afe:	ff 74 24 3c          	push   0x3c(%esp)
  105b02:	e8 69 12 00 00       	call   106d70 <get_ptbl_entry_by_va>
  105b07:	83 c4 10             	add    $0x10,%esp
  105b0a:	eb 94                	jmp    105aa0 <pt_memset+0x40>
  105b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    size_t set = 0;
  105b10:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  105b17:	00 
    }

    return set;
}
  105b18:	8b 44 24 08          	mov    0x8(%esp),%eax
  105b1c:	83 c4 1c             	add    $0x1c,%esp
  105b1f:	5b                   	pop    %ebx
  105b20:	5e                   	pop    %esi
  105b21:	5f                   	pop    %edi
  105b22:	5d                   	pop    %ebp
  105b23:	c3                   	ret    
  105b24:	66 90                	xchg   %ax,%ax
  105b26:	66 90                	xchg   %ax,%ax
  105b28:	66 90                	xchg   %ax,%ax
  105b2a:	66 90                	xchg   %ax,%ax
  105b2c:	66 90                	xchg   %ax,%ax
  105b2e:	66 90                	xchg   %ax,%ax

00105b30 <elf_load>:

/*
 * Load elf execution file exe to the virtual address space pmap.
 */
void elf_load(void *exe_ptr, int pid)
{
  105b30:	55                   	push   %ebp
  105b31:	57                   	push   %edi
  105b32:	56                   	push   %esi
  105b33:	53                   	push   %ebx
  105b34:	e8 50 a8 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105b39:	81 c3 c7 e4 00 00    	add    $0xe4c7,%ebx
  105b3f:	83 ec 2c             	sub    $0x2c,%esp
    char *strtab __attribute__((unused));
    uintptr_t exe = (uintptr_t) exe_ptr;

    eh = (elfhdr *) exe;

    KERN_ASSERT(eh->e_magic == ELF_MAGIC);
  105b42:	8b 44 24 40          	mov    0x40(%esp),%eax
  105b46:	81 38 7f 45 4c 46    	cmpl   $0x464c457f,(%eax)
  105b4c:	74 1f                	je     105b6d <elf_load+0x3d>
  105b4e:	8d 83 d5 85 ff ff    	lea    -0x7a2b(%ebx),%eax
  105b54:	50                   	push   %eax
  105b55:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  105b5b:	50                   	push   %eax
  105b5c:	8d 83 ee 85 ff ff    	lea    -0x7a12(%ebx),%eax
  105b62:	6a 1e                	push   $0x1e
  105b64:	50                   	push   %eax
  105b65:	e8 a6 eb ff ff       	call   104710 <debug_panic>
  105b6a:	83 c4 10             	add    $0x10,%esp
    KERN_ASSERT(eh->e_shstrndx != ELF_SHN_UNDEF);
  105b6d:	8b 44 24 40          	mov    0x40(%esp),%eax
  105b71:	0f b7 40 32          	movzwl 0x32(%eax),%eax
  105b75:	66 85 c0             	test   %ax,%ax
  105b78:	0f 84 92 01 00 00    	je     105d10 <elf_load+0x1e0>

    sh = (sechdr *) ((uintptr_t) eh + eh->e_shoff);
    esh = sh + eh->e_shnum;

    strtab = (char *) (exe + sh[eh->e_shstrndx].sh_offset);
    KERN_ASSERT(sh[eh->e_shstrndx].sh_type == ELF_SHT_STRTAB);
  105b7e:	8b 4c 24 40          	mov    0x40(%esp),%ecx
  105b82:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105b85:	8d 04 c1             	lea    (%ecx,%eax,8),%eax
  105b88:	03 41 20             	add    0x20(%ecx),%eax
  105b8b:	83 78 04 03          	cmpl   $0x3,0x4(%eax)
  105b8f:	74 1f                	je     105bb0 <elf_load+0x80>
  105b91:	8d 83 20 86 ff ff    	lea    -0x79e0(%ebx),%eax
  105b97:	50                   	push   %eax
  105b98:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  105b9e:	50                   	push   %eax
  105b9f:	8d 83 ee 85 ff ff    	lea    -0x7a12(%ebx),%eax
  105ba5:	6a 25                	push   $0x25
  105ba7:	50                   	push   %eax
  105ba8:	e8 63 eb ff ff       	call   104710 <debug_panic>
  105bad:	83 c4 10             	add    $0x10,%esp

    ph = (proghdr *) ((uintptr_t) eh + eh->e_phoff);
  105bb0:	8b 44 24 40          	mov    0x40(%esp),%eax
  105bb4:	8b 68 1c             	mov    0x1c(%eax),%ebp
  105bb7:	01 c5                	add    %eax,%ebp
    eph = ph + eh->e_phnum;
  105bb9:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  105bbd:	c1 e0 05             	shl    $0x5,%eax
  105bc0:	01 e8                	add    %ebp,%eax
  105bc2:	89 44 24 18          	mov    %eax,0x18(%esp)

    for (; ph < eph; ph++) {
  105bc6:	39 c5                	cmp    %eax,%ebp
  105bc8:	72 13                	jb     105bdd <elf_load+0xad>
  105bca:	e9 32 01 00 00       	jmp    105d01 <elf_load+0x1d1>
  105bcf:	90                   	nop
  105bd0:	83 c5 20             	add    $0x20,%ebp
  105bd3:	39 6c 24 18          	cmp    %ebp,0x18(%esp)
  105bd7:	0f 86 24 01 00 00    	jbe    105d01 <elf_load+0x1d1>
        uintptr_t fa;
        uint32_t va, zva, eva, perm;

        if (ph->p_type != ELF_PROG_LOAD)
  105bdd:	83 7d 00 01          	cmpl   $0x1,0x0(%ebp)
  105be1:	75 ed                	jne    105bd0 <elf_load+0xa0>
            continue;

        fa = (uintptr_t) eh + rounddown(ph->p_offset, PAGESIZE);
  105be3:	83 ec 08             	sub    $0x8,%esp
  105be6:	68 00 10 00 00       	push   $0x1000
  105beb:	ff 75 04             	push   0x4(%ebp)
  105bee:	e8 cd f6 ff ff       	call   1052c0 <rounddown>
  105bf3:	03 44 24 50          	add    0x50(%esp),%eax
        va = rounddown(ph->p_va, PAGESIZE);
  105bf7:	5f                   	pop    %edi
        fa = (uintptr_t) eh + rounddown(ph->p_offset, PAGESIZE);
  105bf8:	89 c6                	mov    %eax,%esi
        va = rounddown(ph->p_va, PAGESIZE);
  105bfa:	58                   	pop    %eax
  105bfb:	68 00 10 00 00       	push   $0x1000
  105c00:	ff 75 08             	push   0x8(%ebp)
  105c03:	e8 b8 f6 ff ff       	call   1052c0 <rounddown>
        zva = ph->p_va + ph->p_filesz;
  105c08:	8b 4d 10             	mov    0x10(%ebp),%ecx
        va = rounddown(ph->p_va, PAGESIZE);
  105c0b:	89 c7                	mov    %eax,%edi
        zva = ph->p_va + ph->p_filesz;
  105c0d:	8b 45 08             	mov    0x8(%ebp),%eax
  105c10:	01 c1                	add    %eax,%ecx
  105c12:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
        eva = roundup(ph->p_va + ph->p_memsz, PAGESIZE);
  105c16:	5a                   	pop    %edx
  105c17:	59                   	pop    %ecx
  105c18:	68 00 10 00 00       	push   $0x1000
  105c1d:	03 45 14             	add    0x14(%ebp),%eax
  105c20:	50                   	push   %eax
  105c21:	e8 ba f6 ff ff       	call   1052e0 <roundup>
  105c26:	89 44 24 20          	mov    %eax,0x20(%esp)
  105c2a:	89 c1                	mov    %eax,%ecx

        perm = PTE_U | PTE_P;
        if (ph->p_flags & ELF_PROG_FLAG_WRITE)
  105c2c:	8b 45 18             	mov    0x18(%ebp),%eax
  105c2f:	83 c4 10             	add    $0x10,%esp
  105c32:	83 e0 02             	and    $0x2,%eax
            perm |= PTE_W;
  105c35:	83 f8 01             	cmp    $0x1,%eax
  105c38:	19 d2                	sbb    %edx,%edx
  105c3a:	83 e2 fe             	and    $0xfffffffe,%edx
  105c3d:	83 c2 07             	add    $0x7,%edx
  105c40:	89 54 24 14          	mov    %edx,0x14(%esp)

        for (; va < eva; va += PAGESIZE, fa += PAGESIZE) {
  105c44:	39 cf                	cmp    %ecx,%edi
  105c46:	73 88                	jae    105bd0 <elf_load+0xa0>
  105c48:	89 6c 24 1c          	mov    %ebp,0x1c(%esp)
  105c4c:	8b 6c 24 44          	mov    0x44(%esp),%ebp
  105c50:	eb 3a                	jmp    105c8c <elf_load+0x15c>
  105c52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            alloc_page(pid, va, perm);

            if (va < rounddown(zva, PAGESIZE)) {
                /* copy a complete page */
                pt_copyout((void *) fa, pid, va, PAGESIZE);
            } else if (va < zva && ph->p_filesz) {
  105c58:	39 7c 24 0c          	cmp    %edi,0xc(%esp)
  105c5c:	76 0b                	jbe    105c69 <elf_load+0x139>
  105c5e:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  105c62:	8b 40 10             	mov    0x10(%eax),%eax
  105c65:	85 c0                	test   %eax,%eax
  105c67:	75 5f                	jne    105cc8 <elf_load+0x198>
                /* copy a partial page */
                pt_memset(pid, va, 0, PAGESIZE);
                pt_copyout((void *) fa, pid, va, zva - va);
            } else {
                /* zero a page */
                pt_memset(pid, va, 0, PAGESIZE);
  105c69:	68 00 10 00 00       	push   $0x1000
  105c6e:	6a 00                	push   $0x0
  105c70:	57                   	push   %edi
  105c71:	55                   	push   %ebp
  105c72:	e8 e9 fd ff ff       	call   105a60 <pt_memset>
  105c77:	83 c4 10             	add    $0x10,%esp
        for (; va < eva; va += PAGESIZE, fa += PAGESIZE) {
  105c7a:	81 c7 00 10 00 00    	add    $0x1000,%edi
  105c80:	81 c6 00 10 00 00    	add    $0x1000,%esi
  105c86:	39 7c 24 10          	cmp    %edi,0x10(%esp)
  105c8a:	76 64                	jbe    105cf0 <elf_load+0x1c0>
            alloc_page(pid, va, perm);
  105c8c:	83 ec 04             	sub    $0x4,%esp
  105c8f:	ff 74 24 18          	push   0x18(%esp)
  105c93:	57                   	push   %edi
  105c94:	55                   	push   %ebp
  105c95:	e8 86 15 00 00       	call   107220 <alloc_page>
            if (va < rounddown(zva, PAGESIZE)) {
  105c9a:	5a                   	pop    %edx
  105c9b:	59                   	pop    %ecx
  105c9c:	68 00 10 00 00       	push   $0x1000
  105ca1:	ff 74 24 18          	push   0x18(%esp)
  105ca5:	e8 16 f6 ff ff       	call   1052c0 <rounddown>
  105caa:	83 c4 10             	add    $0x10,%esp
  105cad:	39 f8                	cmp    %edi,%eax
  105caf:	76 a7                	jbe    105c58 <elf_load+0x128>
                pt_copyout((void *) fa, pid, va, PAGESIZE);
  105cb1:	68 00 10 00 00       	push   $0x1000
  105cb6:	57                   	push   %edi
  105cb7:	55                   	push   %ebp
  105cb8:	56                   	push   %esi
  105cb9:	e8 b2 fc ff ff       	call   105970 <pt_copyout>
  105cbe:	83 c4 10             	add    $0x10,%esp
  105cc1:	eb b7                	jmp    105c7a <elf_load+0x14a>
  105cc3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  105cc7:	90                   	nop
                pt_memset(pid, va, 0, PAGESIZE);
  105cc8:	68 00 10 00 00       	push   $0x1000
  105ccd:	6a 00                	push   $0x0
  105ccf:	57                   	push   %edi
  105cd0:	55                   	push   %ebp
  105cd1:	e8 8a fd ff ff       	call   105a60 <pt_memset>
                pt_copyout((void *) fa, pid, va, zva - va);
  105cd6:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  105cda:	29 f8                	sub    %edi,%eax
  105cdc:	50                   	push   %eax
  105cdd:	57                   	push   %edi
  105cde:	55                   	push   %ebp
  105cdf:	56                   	push   %esi
  105ce0:	e8 8b fc ff ff       	call   105970 <pt_copyout>
  105ce5:	83 c4 20             	add    $0x20,%esp
  105ce8:	eb 90                	jmp    105c7a <elf_load+0x14a>
  105cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105cf0:	8b 6c 24 1c          	mov    0x1c(%esp),%ebp
    for (; ph < eph; ph++) {
  105cf4:	83 c5 20             	add    $0x20,%ebp
  105cf7:	39 6c 24 18          	cmp    %ebp,0x18(%esp)
  105cfb:	0f 87 dc fe ff ff    	ja     105bdd <elf_load+0xad>
            }
        }
    }
}
  105d01:	83 c4 2c             	add    $0x2c,%esp
  105d04:	5b                   	pop    %ebx
  105d05:	5e                   	pop    %esi
  105d06:	5f                   	pop    %edi
  105d07:	5d                   	pop    %ebp
  105d08:	c3                   	ret    
  105d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    KERN_ASSERT(eh->e_shstrndx != ELF_SHN_UNDEF);
  105d10:	8d 83 00 86 ff ff    	lea    -0x7a00(%ebx),%eax
  105d16:	50                   	push   %eax
  105d17:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  105d1d:	50                   	push   %eax
  105d1e:	8d 83 ee 85 ff ff    	lea    -0x7a12(%ebx),%eax
  105d24:	6a 1f                	push   $0x1f
  105d26:	50                   	push   %eax
  105d27:	e8 e4 e9 ff ff       	call   104710 <debug_panic>
    strtab = (char *) (exe + sh[eh->e_shstrndx].sh_offset);
  105d2c:	8b 44 24 50          	mov    0x50(%esp),%eax
  105d30:	83 c4 10             	add    $0x10,%esp
  105d33:	0f b7 40 32          	movzwl 0x32(%eax),%eax
  105d37:	e9 42 fe ff ff       	jmp    105b7e <elf_load+0x4e>
  105d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00105d40 <elf_entry>:

uintptr_t elf_entry(void *exe_ptr)
{
  105d40:	56                   	push   %esi
  105d41:	53                   	push   %ebx
  105d42:	e8 42 a6 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105d47:	81 c3 b9 e2 00 00    	add    $0xe2b9,%ebx
  105d4d:	83 ec 04             	sub    $0x4,%esp
  105d50:	8b 74 24 10          	mov    0x10(%esp),%esi
    uintptr_t exe = (uintptr_t) exe_ptr;
    elfhdr *eh = (elfhdr *) exe;
    KERN_ASSERT(eh->e_magic == ELF_MAGIC);
  105d54:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  105d5a:	74 1f                	je     105d7b <elf_entry+0x3b>
  105d5c:	8d 83 d5 85 ff ff    	lea    -0x7a2b(%ebx),%eax
  105d62:	50                   	push   %eax
  105d63:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  105d69:	50                   	push   %eax
  105d6a:	8d 83 ee 85 ff ff    	lea    -0x7a12(%ebx),%eax
  105d70:	6a 50                	push   $0x50
  105d72:	50                   	push   %eax
  105d73:	e8 98 e9 ff ff       	call   104710 <debug_panic>
  105d78:	83 c4 10             	add    $0x10,%esp
    return (uintptr_t) eh->e_entry;
  105d7b:	8b 46 18             	mov    0x18(%esi),%eax
}
  105d7e:	83 c4 04             	add    $0x4,%esp
  105d81:	5b                   	pop    %ebx
  105d82:	5e                   	pop    %esi
  105d83:	c3                   	ret    
  105d84:	66 90                	xchg   %ax,%ax
  105d86:	66 90                	xchg   %ax,%ax
  105d88:	66 90                	xchg   %ax,%ax
  105d8a:	66 90                	xchg   %ax,%ax
  105d8c:	66 90                	xchg   %ax,%ax
  105d8e:	66 90                	xchg   %ax,%ax

00105d90 <get_kstack_pointer>:

struct kstack bsp_kstack[NUM_CPUS];
struct kstack proc_kstack[NUM_IDS];

uintptr_t *get_kstack_pointer(void)
{
  105d90:	53                   	push   %ebx
  105d91:	e8 f3 a5 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105d96:	81 c3 6a e2 00 00    	add    $0xe26a,%ebx
  105d9c:	83 ec 08             	sub    $0x8,%esp
    return (uintptr_t *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  105d9f:	e8 5c f5 ff ff       	call   105300 <read_esp>
}
  105da4:	83 c4 08             	add    $0x8,%esp
    return (uintptr_t *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  105da7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
  105dac:	5b                   	pop    %ebx
  105dad:	c3                   	ret    
  105dae:	66 90                	xchg   %ax,%ax

00105db0 <get_kstack_cpu_idx>:

int get_kstack_cpu_idx(void)
{
  105db0:	53                   	push   %ebx
  105db1:	e8 d3 a5 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105db6:	81 c3 4a e2 00 00    	add    $0xe24a,%ebx
  105dbc:	83 ec 08             	sub    $0x8,%esp
    return (uintptr_t *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  105dbf:	e8 3c f5 ff ff       	call   105300 <read_esp>
  105dc4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    struct kstack *ks = (struct kstack *) get_kstack_pointer();
    return ks->cpu_idx;
  105dc9:	8b 80 1c 01 00 00    	mov    0x11c(%eax),%eax
}
  105dcf:	83 c4 08             	add    $0x8,%esp
  105dd2:	5b                   	pop    %ebx
  105dd3:	c3                   	ret    
  105dd4:	66 90                	xchg   %ax,%ax
  105dd6:	66 90                	xchg   %ax,%ax
  105dd8:	66 90                	xchg   %ax,%ax
  105dda:	66 90                	xchg   %ax,%ax
  105ddc:	66 90                	xchg   %ax,%ax
  105dde:	66 90                	xchg   %ax,%ax

00105de0 <spinlock_init>:
#include "spinlock.h"

extern volatile uint64_t tsc_per_ms;

void gcc_inline spinlock_init(spinlock_t *lk)
{
  105de0:	8b 44 24 04          	mov    0x4(%esp),%eax
    lk->lock_holder = NUM_CPUS + 1;
  105de4:	c7 00 09 00 00 00    	movl   $0x9,(%eax)
    lk->lock = 0;
  105dea:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
}
  105df1:	c3                   	ret    
  105df2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105e00 <spinlock_holding>:

bool gcc_inline spinlock_holding(spinlock_t *lk)
{
  105e00:	57                   	push   %edi
  105e01:	31 c0                	xor    %eax,%eax
  105e03:	56                   	push   %esi
  105e04:	53                   	push   %ebx
  105e05:	8b 74 24 10          	mov    0x10(%esp),%esi
  105e09:	e8 7b a5 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105e0e:	81 c3 f2 e1 00 00    	add    $0xe1f2,%ebx
    if (!lk->lock)
  105e14:	8b 56 04             	mov    0x4(%esi),%edx
  105e17:	85 d2                	test   %edx,%edx
  105e19:	75 05                	jne    105e20 <spinlock_holding+0x20>
        return FALSE;

    struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
    KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
    return lk->lock_holder == kstack->cpu_idx;
}
  105e1b:	5b                   	pop    %ebx
  105e1c:	5e                   	pop    %esi
  105e1d:	5f                   	pop    %edi
  105e1e:	c3                   	ret    
  105e1f:	90                   	nop
    struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  105e20:	e8 db f4 ff ff       	call   105300 <read_esp>
  105e25:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  105e2a:	81 b8 20 01 00 00 32 	cmpl   $0x98765432,0x120(%eax)
  105e31:	54 76 98 
    struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  105e34:	89 c7                	mov    %eax,%edi
    KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  105e36:	74 1f                	je     105e57 <spinlock_holding+0x57>
  105e38:	8d 83 4d 86 ff ff    	lea    -0x79b3(%ebx),%eax
  105e3e:	50                   	push   %eax
  105e3f:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  105e45:	50                   	push   %eax
  105e46:	8d 83 6b 86 ff ff    	lea    -0x7995(%ebx),%eax
  105e4c:	6a 16                	push   $0x16
  105e4e:	50                   	push   %eax
  105e4f:	e8 bc e8 ff ff       	call   104710 <debug_panic>
  105e54:	83 c4 10             	add    $0x10,%esp
    return lk->lock_holder == kstack->cpu_idx;
  105e57:	8b 87 1c 01 00 00    	mov    0x11c(%edi),%eax
  105e5d:	39 06                	cmp    %eax,(%esi)
}
  105e5f:	5b                   	pop    %ebx
    return lk->lock_holder == kstack->cpu_idx;
  105e60:	0f 94 c0             	sete   %al
}
  105e63:	5e                   	pop    %esi
  105e64:	5f                   	pop    %edi
  105e65:	c3                   	ret    
  105e66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105e6d:	8d 76 00             	lea    0x0(%esi),%esi

00105e70 <spinlock_acquire>:

    return spinlock_try_acquire_A(lk);
}
#else   /* DEBUG_LOCKHOLDING */
void gcc_inline spinlock_acquire(spinlock_t *lk)
{
  105e70:	57                   	push   %edi
  105e71:	56                   	push   %esi
  105e72:	53                   	push   %ebx
  105e73:	8b 7c 24 10          	mov    0x10(%esp),%edi
    while (xchg(&lk->lock, 1) != 0)
  105e77:	e8 0d a5 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105e7c:	81 c3 84 e1 00 00    	add    $0xe184,%ebx
  105e82:	8d 77 04             	lea    0x4(%edi),%esi
  105e85:	eb 0e                	jmp    105e95 <spinlock_acquire+0x25>
  105e87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105e8e:	66 90                	xchg   %ax,%ax
        pause();
  105e90:	e8 eb f4 ff ff       	call   105380 <pause>
    while (xchg(&lk->lock, 1) != 0)
  105e95:	83 ec 08             	sub    $0x8,%esp
  105e98:	6a 01                	push   $0x1
  105e9a:	56                   	push   %esi
  105e9b:	e8 f0 f4 ff ff       	call   105390 <xchg>
  105ea0:	83 c4 10             	add    $0x10,%esp
  105ea3:	85 c0                	test   %eax,%eax
  105ea5:	75 e9                	jne    105e90 <spinlock_acquire+0x20>
    struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  105ea7:	e8 54 f4 ff ff       	call   105300 <read_esp>
  105eac:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  105eb1:	81 b8 20 01 00 00 32 	cmpl   $0x98765432,0x120(%eax)
  105eb8:	54 76 98 
    struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  105ebb:	89 c6                	mov    %eax,%esi
    KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  105ebd:	74 1f                	je     105ede <spinlock_acquire+0x6e>
  105ebf:	8d 83 4d 86 ff ff    	lea    -0x79b3(%ebx),%eax
  105ec5:	50                   	push   %eax
  105ec6:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  105ecc:	50                   	push   %eax
  105ecd:	8d 83 6b 86 ff ff    	lea    -0x7995(%ebx),%eax
  105ed3:	6a 2f                	push   $0x2f
  105ed5:	50                   	push   %eax
  105ed6:	e8 35 e8 ff ff       	call   104710 <debug_panic>
  105edb:	83 c4 10             	add    $0x10,%esp
    lk->lock_holder = kstack->cpu_idx;
  105ede:	8b 86 1c 01 00 00    	mov    0x11c(%esi),%eax
  105ee4:	89 07                	mov    %eax,(%edi)
    spinlock_acquire_A(lk);
}
  105ee6:	5b                   	pop    %ebx
  105ee7:	5e                   	pop    %esi
  105ee8:	5f                   	pop    %edi
  105ee9:	c3                   	ret    
  105eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00105ef0 <spinlock_release>:

void gcc_inline spinlock_release(spinlock_t *lk)
{
  105ef0:	53                   	push   %ebx
  105ef1:	e8 93 a4 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105ef6:	81 c3 0a e1 00 00    	add    $0xe10a,%ebx
  105efc:	83 ec 10             	sub    $0x10,%esp
  105eff:	8b 44 24 18          	mov    0x18(%esp),%eax
    lk->lock_holder = NUM_CPUS + 1;
  105f03:	c7 00 09 00 00 00    	movl   $0x9,(%eax)
    xchg(&lk->lock, 0);
  105f09:	83 c0 04             	add    $0x4,%eax
  105f0c:	6a 00                	push   $0x0
  105f0e:	50                   	push   %eax
  105f0f:	e8 7c f4 ff ff       	call   105390 <xchg>
    spinlock_release_A(lk);
}
  105f14:	83 c4 18             	add    $0x18,%esp
  105f17:	5b                   	pop    %ebx
  105f18:	c3                   	ret    
  105f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105f20 <spinlock_try_acquire>:

int gcc_inline spinlock_try_acquire(spinlock_t *lk)
{
  105f20:	55                   	push   %ebp
  105f21:	57                   	push   %edi
  105f22:	56                   	push   %esi
  105f23:	53                   	push   %ebx
  105f24:	e8 60 a4 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105f29:	81 c3 d7 e0 00 00    	add    $0xe0d7,%ebx
  105f2f:	83 ec 14             	sub    $0x14,%esp
  105f32:	8b 7c 24 28          	mov    0x28(%esp),%edi
    uint32_t old_val = xchg(&lk->lock, 1);
  105f36:	6a 01                	push   $0x1
  105f38:	8d 47 04             	lea    0x4(%edi),%eax
  105f3b:	50                   	push   %eax
  105f3c:	e8 4f f4 ff ff       	call   105390 <xchg>
    if (old_val == 0) {
  105f41:	83 c4 10             	add    $0x10,%esp
    uint32_t old_val = xchg(&lk->lock, 1);
  105f44:	89 c6                	mov    %eax,%esi
    if (old_val == 0) {
  105f46:	85 c0                	test   %eax,%eax
  105f48:	74 0e                	je     105f58 <spinlock_try_acquire+0x38>
    return spinlock_try_acquire_A(lk);
}
  105f4a:	83 c4 0c             	add    $0xc,%esp
  105f4d:	89 f0                	mov    %esi,%eax
  105f4f:	5b                   	pop    %ebx
  105f50:	5e                   	pop    %esi
  105f51:	5f                   	pop    %edi
  105f52:	5d                   	pop    %ebp
  105f53:	c3                   	ret    
  105f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  105f58:	e8 a3 f3 ff ff       	call   105300 <read_esp>
  105f5d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
        KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  105f62:	81 b8 20 01 00 00 32 	cmpl   $0x98765432,0x120(%eax)
  105f69:	54 76 98 
        struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  105f6c:	89 c5                	mov    %eax,%ebp
        KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  105f6e:	75 18                	jne    105f88 <spinlock_try_acquire+0x68>
        lk->lock_holder = kstack->cpu_idx;
  105f70:	8b 85 1c 01 00 00    	mov    0x11c(%ebp),%eax
  105f76:	89 07                	mov    %eax,(%edi)
}
  105f78:	83 c4 0c             	add    $0xc,%esp
  105f7b:	89 f0                	mov    %esi,%eax
  105f7d:	5b                   	pop    %ebx
  105f7e:	5e                   	pop    %esi
  105f7f:	5f                   	pop    %edi
  105f80:	5d                   	pop    %ebp
  105f81:	c3                   	ret    
  105f82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  105f88:	8d 83 4d 86 ff ff    	lea    -0x79b3(%ebx),%eax
  105f8e:	50                   	push   %eax
  105f8f:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  105f95:	50                   	push   %eax
  105f96:	8d 83 6b 86 ff ff    	lea    -0x7995(%ebx),%eax
  105f9c:	6a 39                	push   $0x39
  105f9e:	50                   	push   %eax
  105f9f:	e8 6c e7 ff ff       	call   104710 <debug_panic>
        lk->lock_holder = kstack->cpu_idx;
  105fa4:	8b 85 1c 01 00 00    	mov    0x11c(%ebp),%eax
        KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  105faa:	83 c4 10             	add    $0x10,%esp
        lk->lock_holder = kstack->cpu_idx;
  105fad:	89 07                	mov    %eax,(%edi)
  105faf:	eb c7                	jmp    105f78 <spinlock_try_acquire+0x58>
  105fb1:	66 90                	xchg   %ax,%ax
  105fb3:	66 90                	xchg   %ax,%ax
  105fb5:	66 90                	xchg   %ax,%ax
  105fb7:	66 90                	xchg   %ax,%ax
  105fb9:	66 90                	xchg   %ax,%ax
  105fbb:	66 90                	xchg   %ax,%ax
  105fbd:	66 90                	xchg   %ax,%ax
  105fbf:	90                   	nop

00105fc0 <reentrantlock_init>:
#include "reentrant_lock.h"

#define UNLOCKED    0xFFFFFFFF

void reentrantlock_init(reentrantlock *lk)
{
  105fc0:	8b 44 24 04          	mov    0x4(%esp),%eax
    lk->lock = UNLOCKED;
  105fc4:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    lk->count = 0u;
  105fca:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
}
  105fd1:	c3                   	ret    
  105fd2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105fe0 <reentrantlock_holding>:

bool reentrantlock_holding(reentrantlock *lk)
{
    if (lk->count > 0u)
  105fe0:	8b 44 24 04          	mov    0x4(%esp),%eax
  105fe4:	8b 40 04             	mov    0x4(%eax),%eax
  105fe7:	85 c0                	test   %eax,%eax
  105fe9:	0f 95 c0             	setne  %al
        return TRUE;
    else
        return FALSE;
}
  105fec:	c3                   	ret    
  105fed:	8d 76 00             	lea    0x0(%esi),%esi

00105ff0 <reentrantlock_acquire>:

void reentrantlock_acquire(reentrantlock *lk)
{
  105ff0:	57                   	push   %edi
  105ff1:	56                   	push   %esi
  105ff2:	53                   	push   %ebx
  105ff3:	8b 7c 24 10          	mov    0x10(%esp),%edi
  105ff7:	e8 8d a3 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105ffc:	81 c3 04 e0 00 00    	add    $0xe004,%ebx
    uint32_t cpuid = get_kstack_cpu_idx();
  106002:	e8 a9 fd ff ff       	call   105db0 <get_kstack_cpu_idx>
  106007:	89 c6                	mov    %eax,%esi
  106009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uint32_t lv;

    do {
        lv = cmpxchg(&lk->lock, UNLOCKED, cpuid);
  106010:	83 ec 04             	sub    $0x4,%esp
  106013:	56                   	push   %esi
  106014:	6a ff                	push   $0xffffffff
  106016:	57                   	push   %edi
  106017:	e8 84 f3 ff ff       	call   1053a0 <cmpxchg>
    } while (lv != cpuid && lv != UNLOCKED);
  10601c:	83 c4 10             	add    $0x10,%esp
  10601f:	39 c6                	cmp    %eax,%esi
  106021:	74 05                	je     106028 <reentrantlock_acquire+0x38>
  106023:	83 f8 ff             	cmp    $0xffffffff,%eax
  106026:	75 e8                	jne    106010 <reentrantlock_acquire+0x20>
    lk->count++;
  106028:	8b 47 04             	mov    0x4(%edi),%eax
  10602b:	83 c0 01             	add    $0x1,%eax
  10602e:	89 47 04             	mov    %eax,0x4(%edi)
}
  106031:	5b                   	pop    %ebx
  106032:	5e                   	pop    %esi
  106033:	5f                   	pop    %edi
  106034:	c3                   	ret    
  106035:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10603c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106040 <reentrantlock_try_acquire>:

int reentrantlock_try_acquire(reentrantlock *lk)
{
  106040:	57                   	push   %edi
  106041:	56                   	push   %esi
  106042:	53                   	push   %ebx
  106043:	8b 7c 24 10          	mov    0x10(%esp),%edi
  106047:	e8 3d a3 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10604c:	81 c3 b4 df 00 00    	add    $0xdfb4,%ebx
    uint32_t cpuid = get_kstack_cpu_idx();
  106052:	e8 59 fd ff ff       	call   105db0 <get_kstack_cpu_idx>
    uint32_t lv;

    lv = cmpxchg(&lk->lock, UNLOCKED, cpuid);
  106057:	83 ec 04             	sub    $0x4,%esp
  10605a:	50                   	push   %eax
    uint32_t cpuid = get_kstack_cpu_idx();
  10605b:	89 c6                	mov    %eax,%esi
    lv = cmpxchg(&lk->lock, UNLOCKED, cpuid);
  10605d:	6a ff                	push   $0xffffffff
  10605f:	57                   	push   %edi
  106060:	e8 3b f3 ff ff       	call   1053a0 <cmpxchg>

    if (lv == cpuid || lv == UNLOCKED) {
  106065:	83 c4 10             	add    $0x10,%esp
  106068:	39 c6                	cmp    %eax,%esi
  10606a:	74 14                	je     106080 <reentrantlock_try_acquire+0x40>
        lk->count++;
        return 1;
    } else
        return 0;
  10606c:	31 d2                	xor    %edx,%edx
    if (lv == cpuid || lv == UNLOCKED) {
  10606e:	83 f8 ff             	cmp    $0xffffffff,%eax
  106071:	74 0d                	je     106080 <reentrantlock_try_acquire+0x40>
}
  106073:	5b                   	pop    %ebx
  106074:	89 d0                	mov    %edx,%eax
  106076:	5e                   	pop    %esi
  106077:	5f                   	pop    %edi
  106078:	c3                   	ret    
  106079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        lk->count++;
  106080:	8b 47 04             	mov    0x4(%edi),%eax
        return 1;
  106083:	ba 01 00 00 00       	mov    $0x1,%edx
        lk->count++;
  106088:	83 c0 01             	add    $0x1,%eax
  10608b:	89 47 04             	mov    %eax,0x4(%edi)
}
  10608e:	89 d0                	mov    %edx,%eax
  106090:	5b                   	pop    %ebx
  106091:	5e                   	pop    %esi
  106092:	5f                   	pop    %edi
  106093:	c3                   	ret    
  106094:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10609b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10609f:	90                   	nop

001060a0 <reentrantlock_release>:

void reentrantlock_release(reentrantlock *lk)
{
  1060a0:	53                   	push   %ebx
  1060a1:	e8 e3 a2 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1060a6:	81 c3 5a df 00 00    	add    $0xdf5a,%ebx
  1060ac:	83 ec 08             	sub    $0x8,%esp
  1060af:	8b 44 24 10          	mov    0x10(%esp),%eax
    lk->count--;
  1060b3:	8b 50 04             	mov    0x4(%eax),%edx
  1060b6:	83 ea 01             	sub    $0x1,%edx
  1060b9:	89 50 04             	mov    %edx,0x4(%eax)
    if (lk->count == 0u) {
  1060bc:	8b 50 04             	mov    0x4(%eax),%edx
  1060bf:	85 d2                	test   %edx,%edx
  1060c1:	74 0d                	je     1060d0 <reentrantlock_release+0x30>
        xchg(&lk->lock, UNLOCKED);
    }
}
  1060c3:	83 c4 08             	add    $0x8,%esp
  1060c6:	5b                   	pop    %ebx
  1060c7:	c3                   	ret    
  1060c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1060cf:	90                   	nop
        xchg(&lk->lock, UNLOCKED);
  1060d0:	83 ec 08             	sub    $0x8,%esp
  1060d3:	6a ff                	push   $0xffffffff
  1060d5:	50                   	push   %eax
  1060d6:	e8 b5 f2 ff ff       	call   105390 <xchg>
  1060db:	83 c4 10             	add    $0x10,%esp
}
  1060de:	83 c4 08             	add    $0x8,%esp
  1060e1:	5b                   	pop    %ebx
  1060e2:	c3                   	ret    
  1060e3:	66 90                	xchg   %ax,%ax
  1060e5:	66 90                	xchg   %ax,%ax
  1060e7:	66 90                	xchg   %ax,%ax
  1060e9:	66 90                	xchg   %ax,%ax
  1060eb:	66 90                	xchg   %ax,%ax
  1060ed:	66 90                	xchg   %ax,%ax
  1060ef:	90                   	nop

001060f0 <pcpu_set_zero>:
struct pcpu pcpu[NUM_CPUS];

extern int get_kstack_cpu_idx(void);

void pcpu_set_zero()
{
  1060f0:	53                   	push   %ebx
  1060f1:	e8 93 a2 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1060f6:	81 c3 0a df 00 00    	add    $0xdf0a,%ebx
  1060fc:	83 ec 10             	sub    $0x10,%esp
    memzero(pcpu, sizeof(struct pcpu) * NUM_CPUS);
  1060ff:	68 80 02 00 00       	push   $0x280
  106104:	8d 83 00 40 08 00    	lea    0x84000(%ebx),%eax
  10610a:	50                   	push   %eax
  10610b:	e8 20 e4 ff ff       	call   104530 <memzero>
}
  106110:	83 c4 18             	add    $0x18,%esp
  106113:	5b                   	pop    %ebx
  106114:	c3                   	ret    
  106115:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10611c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106120 <pcpu_fields_init>:

void pcpu_fields_init(int cpu_idx)
{
    pcpu[cpu_idx].inited = TRUE;
  106120:	e8 3e ee ff ff       	call   104f63 <__x86.get_pc_thunk.cx>
  106125:	81 c1 db de 00 00    	add    $0xdedb,%ecx
{
  10612b:	8b 54 24 04          	mov    0x4(%esp),%edx
    pcpu[cpu_idx].inited = TRUE;
  10612f:	8d 04 92             	lea    (%edx,%edx,4),%eax
  106132:	c1 e0 04             	shl    $0x4,%eax
  106135:	c6 84 01 00 40 08 00 	movb   $0x1,0x84000(%ecx,%eax,1)
  10613c:	01 
    pcpu[cpu_idx].cpu_idx = cpu_idx;
  10613d:	89 94 01 4c 40 08 00 	mov    %edx,0x8404c(%ecx,%eax,1)
}
  106144:	c3                   	ret    
  106145:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10614c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106150 <pcpu_cur>:

struct pcpu *pcpu_cur(void)
{
  106150:	53                   	push   %ebx
  106151:	e8 33 a2 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106156:	81 c3 aa de 00 00    	add    $0xdeaa,%ebx
  10615c:	83 ec 08             	sub    $0x8,%esp
    int cpu_idx = get_kstack_cpu_idx();
  10615f:	e8 4c fc ff ff       	call   105db0 <get_kstack_cpu_idx>
    return &pcpu[cpu_idx];
}
  106164:	83 c4 08             	add    $0x8,%esp
    return &pcpu[cpu_idx];
  106167:	8d 04 80             	lea    (%eax,%eax,4),%eax
  10616a:	c1 e0 04             	shl    $0x4,%eax
  10616d:	8d 84 03 00 40 08 00 	lea    0x84000(%ebx,%eax,1),%eax
}
  106174:	5b                   	pop    %ebx
  106175:	c3                   	ret    
  106176:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10617d:	8d 76 00             	lea    0x0(%esi),%esi

00106180 <get_pcpu_idx>:

int get_pcpu_idx(void)
{
  106180:	53                   	push   %ebx
  106181:	e8 03 a2 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106186:	81 c3 7a de 00 00    	add    $0xde7a,%ebx
  10618c:	83 ec 08             	sub    $0x8,%esp
    int cpu_idx = get_kstack_cpu_idx();
  10618f:	e8 1c fc ff ff       	call   105db0 <get_kstack_cpu_idx>
    return pcpu_cur()->cpu_idx;
  106194:	8d 04 80             	lea    (%eax,%eax,4),%eax
  106197:	c1 e0 04             	shl    $0x4,%eax
  10619a:	8b 84 03 4c 40 08 00 	mov    0x8404c(%ebx,%eax,1),%eax
}
  1061a1:	83 c4 08             	add    $0x8,%esp
  1061a4:	5b                   	pop    %ebx
  1061a5:	c3                   	ret    
  1061a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1061ad:	8d 76 00             	lea    0x0(%esi),%esi

001061b0 <set_pcpu_idx>:

void set_pcpu_idx(int index, int cpu_idx)
{
    pcpu[index].cpu_idx = cpu_idx;
  1061b0:	e8 d0 a1 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  1061b5:	81 c2 4b de 00 00    	add    $0xde4b,%edx
{
  1061bb:	8b 44 24 04          	mov    0x4(%esp),%eax
    pcpu[index].cpu_idx = cpu_idx;
  1061bf:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  1061c3:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1061c6:	c1 e0 04             	shl    $0x4,%eax
  1061c9:	89 8c 02 4c 40 08 00 	mov    %ecx,0x8404c(%edx,%eax,1)
}
  1061d0:	c3                   	ret    
  1061d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1061d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1061df:	90                   	nop

001061e0 <get_pcpu_kstack_pointer>:

uintptr_t *get_pcpu_kstack_pointer(int cpu_idx)
{
    return pcpu[cpu_idx].kstack;
  1061e0:	e8 a0 a1 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  1061e5:	81 c2 1b de 00 00    	add    $0xde1b,%edx
{
  1061eb:	8b 44 24 04          	mov    0x4(%esp),%eax
    return pcpu[cpu_idx].kstack;
  1061ef:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1061f2:	c1 e0 04             	shl    $0x4,%eax
  1061f5:	8b 84 02 04 40 08 00 	mov    0x84004(%edx,%eax,1),%eax
}
  1061fc:	c3                   	ret    
  1061fd:	8d 76 00             	lea    0x0(%esi),%esi

00106200 <set_pcpu_kstack_pointer>:

void set_pcpu_kstack_pointer(int cpu_idx, uintptr_t *ks)
{
    pcpu[cpu_idx].kstack = ks;
  106200:	e8 80 a1 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106205:	81 c2 fb dd 00 00    	add    $0xddfb,%edx
{
  10620b:	8b 44 24 04          	mov    0x4(%esp),%eax
    pcpu[cpu_idx].kstack = ks;
  10620f:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  106213:	8d 04 80             	lea    (%eax,%eax,4),%eax
  106216:	c1 e0 04             	shl    $0x4,%eax
  106219:	89 8c 02 04 40 08 00 	mov    %ecx,0x84004(%edx,%eax,1)
}
  106220:	c3                   	ret    
  106221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106228:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10622f:	90                   	nop

00106230 <get_pcpu_boot_info>:

volatile bool get_pcpu_boot_info(int cpu_idx)
{
    return pcpu[cpu_idx].booted;
  106230:	e8 50 a1 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106235:	81 c2 cb dd 00 00    	add    $0xddcb,%edx
{
  10623b:	8b 44 24 04          	mov    0x4(%esp),%eax
    return pcpu[cpu_idx].booted;
  10623f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  106242:	c1 e0 04             	shl    $0x4,%eax
  106245:	8d 84 02 00 40 08 00 	lea    0x84000(%edx,%eax,1),%eax
  10624c:	0f b6 40 01          	movzbl 0x1(%eax),%eax
}
  106250:	c3                   	ret    
  106251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106258:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10625f:	90                   	nop

00106260 <set_pcpu_boot_info>:

void set_pcpu_boot_info(int cpu_idx, volatile bool boot_info)
{
    pcpu[cpu_idx].booted = boot_info;
  106260:	e8 fe ec ff ff       	call   104f63 <__x86.get_pc_thunk.cx>
  106265:	81 c1 9b dd 00 00    	add    $0xdd9b,%ecx
{
  10626b:	83 ec 04             	sub    $0x4,%esp
  10626e:	8b 44 24 08          	mov    0x8(%esp),%eax
  106272:	8b 54 24 0c          	mov    0xc(%esp),%edx
    pcpu[cpu_idx].booted = boot_info;
  106276:	8d 04 80             	lea    (%eax,%eax,4),%eax
{
  106279:	88 14 24             	mov    %dl,(%esp)
    pcpu[cpu_idx].booted = boot_info;
  10627c:	0f b6 14 24          	movzbl (%esp),%edx
  106280:	c1 e0 04             	shl    $0x4,%eax
  106283:	8d 84 01 00 40 08 00 	lea    0x84000(%ecx,%eax,1),%eax
  10628a:	88 50 01             	mov    %dl,0x1(%eax)
}
  10628d:	83 c4 04             	add    $0x4,%esp
  106290:	c3                   	ret    
  106291:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106298:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10629f:	90                   	nop

001062a0 <get_pcpu_cpu_vendor>:

cpu_vendor get_pcpu_cpu_vendor(int cpu_idx)
{
    return pcpu[cpu_idx].arch_info.cpu_vendor;
  1062a0:	e8 e0 a0 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  1062a5:	81 c2 5b dd 00 00    	add    $0xdd5b,%edx
{
  1062ab:	8b 44 24 04          	mov    0x4(%esp),%eax
    return pcpu[cpu_idx].arch_info.cpu_vendor;
  1062af:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1062b2:	c1 e0 04             	shl    $0x4,%eax
  1062b5:	8b 84 02 28 40 08 00 	mov    0x84028(%edx,%eax,1),%eax
}
  1062bc:	c3                   	ret    
  1062bd:	8d 76 00             	lea    0x0(%esi),%esi

001062c0 <get_pcpu_arch_info_pointer>:

uintptr_t *get_pcpu_arch_info_pointer(int cpu_idx)
{
    return (uintptr_t *) &pcpu[cpu_idx].arch_info;
  1062c0:	e8 c0 a0 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  1062c5:	81 c2 3b dd 00 00    	add    $0xdd3b,%edx
{
  1062cb:	8b 44 24 04          	mov    0x4(%esp),%eax
    return (uintptr_t *) &pcpu[cpu_idx].arch_info;
  1062cf:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1062d2:	c1 e0 04             	shl    $0x4,%eax
  1062d5:	8d 84 02 08 40 08 00 	lea    0x84008(%edx,%eax,1),%eax
}
  1062dc:	c3                   	ret    
  1062dd:	8d 76 00             	lea    0x0(%esi),%esi

001062e0 <get_pcpu_inited_info>:

bool get_pcpu_inited_info(int cpu_idx)
{
    return pcpu[cpu_idx].inited;
  1062e0:	e8 a0 a0 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  1062e5:	81 c2 1b dd 00 00    	add    $0xdd1b,%edx
{
  1062eb:	8b 44 24 04          	mov    0x4(%esp),%eax
    return pcpu[cpu_idx].inited;
  1062ef:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1062f2:	c1 e0 04             	shl    $0x4,%eax
  1062f5:	0f b6 84 02 00 40 08 	movzbl 0x84000(%edx,%eax,1),%eax
  1062fc:	00 
}
  1062fd:	c3                   	ret    
  1062fe:	66 90                	xchg   %ax,%ax

00106300 <pcpu_init>:
#include "import.h"

static bool pcpu_inited = FALSE;

void pcpu_init(void)
{
  106300:	55                   	push   %ebp
  106301:	57                   	push   %edi
  106302:	56                   	push   %esi
  106303:	53                   	push   %ebx
  106304:	e8 80 a0 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106309:	81 c3 f7 dc 00 00    	add    $0xdcf7,%ebx
  10630f:	83 ec 0c             	sub    $0xc,%esp
    struct kstack *ks = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  106312:	e8 e9 ef ff ff       	call   105300 <read_esp>
  106317:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    int cpu_idx = ks->cpu_idx;
  10631c:	8b b8 1c 01 00 00    	mov    0x11c(%eax),%edi
    struct kstack *ks = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  106322:	89 c5                	mov    %eax,%ebp
    int i;

    if (cpu_idx == 0) {
  106324:	85 ff                	test   %edi,%edi
  106326:	75 33                	jne    10635b <pcpu_init+0x5b>
        if (pcpu_inited == TRUE)
  106328:	80 bb 80 42 08 00 01 	cmpb   $0x1,0x84280(%ebx)
  10632f:	74 4f                	je     106380 <pcpu_init+0x80>
            return;

        pcpu_set_zero();
  106331:	e8 ba fd ff ff       	call   1060f0 <pcpu_set_zero>

        /* Probe SMP. */
        pcpu_mp_init();

        for (i = 0; i < NUM_CPUS; i++) {
  106336:	31 f6                	xor    %esi,%esi
        pcpu_mp_init();
  106338:	e8 c3 ca ff ff       	call   102e00 <pcpu_mp_init>
        for (i = 0; i < NUM_CPUS; i++) {
  10633d:	8d 76 00             	lea    0x0(%esi),%esi
            pcpu_fields_init(i);
  106340:	83 ec 0c             	sub    $0xc,%esp
  106343:	56                   	push   %esi
        for (i = 0; i < NUM_CPUS; i++) {
  106344:	83 c6 01             	add    $0x1,%esi
            pcpu_fields_init(i);
  106347:	e8 d4 fd ff ff       	call   106120 <pcpu_fields_init>
        for (i = 0; i < NUM_CPUS; i++) {
  10634c:	83 c4 10             	add    $0x10,%esp
  10634f:	83 fe 08             	cmp    $0x8,%esi
  106352:	75 ec                	jne    106340 <pcpu_init+0x40>
        }

        pcpu_inited = TRUE;
  106354:	c6 83 80 42 08 00 01 	movb   $0x1,0x84280(%ebx)
    }

    set_pcpu_idx(cpu_idx, cpu_idx);
  10635b:	83 ec 08             	sub    $0x8,%esp
  10635e:	57                   	push   %edi
  10635f:	57                   	push   %edi
  106360:	e8 4b fe ff ff       	call   1061b0 <set_pcpu_idx>
    set_pcpu_kstack_pointer(cpu_idx, (uintptr_t *) ks);
  106365:	58                   	pop    %eax
  106366:	5a                   	pop    %edx
  106367:	55                   	push   %ebp
  106368:	57                   	push   %edi
  106369:	e8 92 fe ff ff       	call   106200 <set_pcpu_kstack_pointer>
    set_pcpu_boot_info(cpu_idx, TRUE);
  10636e:	59                   	pop    %ecx
  10636f:	5e                   	pop    %esi
  106370:	6a 01                	push   $0x1
  106372:	57                   	push   %edi
  106373:	e8 e8 fe ff ff       	call   106260 <set_pcpu_boot_info>
    pcpu_init_cpu();
  106378:	e8 83 d2 ff ff       	call   103600 <pcpu_init_cpu>
  10637d:	83 c4 10             	add    $0x10,%esp
}
  106380:	83 c4 0c             	add    $0xc,%esp
  106383:	5b                   	pop    %ebx
  106384:	5e                   	pop    %esi
  106385:	5f                   	pop    %edi
  106386:	5d                   	pop    %ebp
  106387:	c3                   	ret    
  106388:	66 90                	xchg   %ax,%ax
  10638a:	66 90                	xchg   %ax,%ax
  10638c:	66 90                	xchg   %ax,%ax
  10638e:	66 90                	xchg   %ax,%ax

00106390 <kern_init>:

    cpu_booted++;
}

void kern_init(uintptr_t mbi_addr)
{
  106390:	57                   	push   %edi
  106391:	56                   	push   %esi
  106392:	53                   	push   %ebx
  106393:	e8 f1 9f ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106398:	81 c3 68 dc 00 00    	add    $0xdc68,%ebx
    thread_init(mbi_addr);
  10639e:	83 ec 0c             	sub    $0xc,%esp
  1063a1:	ff 74 24 1c          	push   0x1c(%esp)
  1063a5:	e8 f6 15 00 00       	call   1079a0 <thread_init>
    KERN_INFO("[BSP KERN] Kernel initialized.\n");
  1063aa:	8d 83 80 86 ff ff    	lea    -0x7980(%ebx),%eax
  1063b0:	89 04 24             	mov    %eax,(%esp)
  1063b3:	e8 b8 e2 ff ff       	call   104670 <debug_info>
    KERN_INFO("[BSP KERN] In kernel main.\n\n");
  1063b8:	8d 83 1a 87 ff ff    	lea    -0x78e6(%ebx),%eax
  1063be:	89 04 24             	mov    %eax,(%esp)
  1063c1:	e8 aa e2 ff ff       	call   104670 <debug_info>
    KERN_INFO("[BSP KERN] Number of CPUs in this system: %d. \n", pcpu_ncpu());
  1063c6:	e8 45 d6 ff ff       	call   103a10 <pcpu_ncpu>
  1063cb:	5a                   	pop    %edx
  1063cc:	59                   	pop    %ecx
  1063cd:	50                   	push   %eax
  1063ce:	8d 83 a0 86 ff ff    	lea    -0x7960(%ebx),%eax
  1063d4:	50                   	push   %eax
  1063d5:	e8 96 e2 ff ff       	call   104670 <debug_info>
    int cpu_idx = get_pcpu_idx();
  1063da:	e8 a1 fd ff ff       	call   106180 <get_pcpu_idx>
    pid = proc_create(_binary___obj_user_idle_idle_start, 10000);
  1063df:	5e                   	pop    %esi
    int cpu_idx = get_pcpu_idx();
  1063e0:	89 c7                	mov    %eax,%edi
    pid = proc_create(_binary___obj_user_idle_idle_start, 10000);
  1063e2:	58                   	pop    %eax
  1063e3:	68 10 27 00 00       	push   $0x2710
  1063e8:	ff b3 ec ff ff ff    	push   -0x14(%ebx)
  1063ee:	e8 6d 18 00 00       	call   107c60 <proc_create>
    KERN_INFO("CPU%d: process idle %d is created.\n", cpu_idx, pid);
  1063f3:	83 c4 0c             	add    $0xc,%esp
  1063f6:	50                   	push   %eax
    pid = proc_create(_binary___obj_user_idle_idle_start, 10000);
  1063f7:	89 c6                	mov    %eax,%esi
    KERN_INFO("CPU%d: process idle %d is created.\n", cpu_idx, pid);
  1063f9:	8d 83 d0 86 ff ff    	lea    -0x7930(%ebx),%eax
  1063ff:	57                   	push   %edi
  106400:	50                   	push   %eax
  106401:	e8 6a e2 ff ff       	call   104670 <debug_info>
    tqueue_remove(NUM_IDS, pid);
  106406:	58                   	pop    %eax
  106407:	5a                   	pop    %edx
  106408:	56                   	push   %esi
  106409:	6a 40                	push   $0x40
  10640b:	e8 50 14 00 00       	call   107860 <tqueue_remove>
    tcb_set_state(pid, TSTATE_RUN);
  106410:	59                   	pop    %ecx
  106411:	5f                   	pop    %edi
  106412:	6a 01                	push   $0x1
  106414:	56                   	push   %esi
  106415:	e8 e6 0f 00 00       	call   107400 <tcb_set_state>
    set_curid(pid);
  10641a:	89 34 24             	mov    %esi,(%esp)
  10641d:	e8 4e 15 00 00       	call   107970 <set_curid>
    kctx_switch(0, pid);
  106422:	58                   	pop    %eax
  106423:	5a                   	pop    %edx
  106424:	56                   	push   %esi
  106425:	6a 00                	push   $0x0
  106427:	e8 b4 0e 00 00       	call   1072e0 <kctx_switch>
    KERN_PANIC("kern_main() should never reach here.\n");
  10642c:	83 c4 0c             	add    $0xc,%esp
  10642f:	8d 83 f4 86 ff ff    	lea    -0x790c(%ebx),%eax
  106435:	50                   	push   %eax
  106436:	8d 83 37 87 ff ff    	lea    -0x78c9(%ebx),%eax
  10643c:	6a 26                	push   $0x26
  10643e:	50                   	push   %eax
  10643f:	e8 cc e2 ff ff       	call   104710 <debug_panic>
    kern_main();
}
  106444:	83 c4 10             	add    $0x10,%esp
  106447:	5b                   	pop    %ebx
  106448:	5e                   	pop    %esi
  106449:	5f                   	pop    %edi
  10644a:	c3                   	ret    
  10644b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10644f:	90                   	nop

00106450 <kern_init_ap>:

void kern_init_ap(void (*f)(void))
{
  106450:	56                   	push   %esi
  106451:	53                   	push   %ebx
  106452:	e8 32 9f ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106457:	81 c3 a9 db 00 00    	add    $0xdba9,%ebx
  10645d:	83 ec 04             	sub    $0x4,%esp
  106460:	8b 74 24 10          	mov    0x10(%esp),%esi
    devinit_ap();
  106464:	e8 b7 a6 ff ff       	call   100b20 <devinit_ap>
    f();
}
  106469:	83 c4 04             	add    $0x4,%esp
    f();
  10646c:	89 f0                	mov    %esi,%eax
}
  10646e:	5b                   	pop    %ebx
  10646f:	5e                   	pop    %esi
    f();
  106470:	ff e0                	jmp    *%eax
  106472:	66 90                	xchg   %ax,%ax
  106474:	02 b0 ad 1b 03 00    	add    0x31bad(%eax),%dh
  10647a:	00 00                	add    %al,(%eax)
  10647c:	fb                   	sti    
  10647d:	4f                   	dec    %edi
  10647e:	52                   	push   %edx
  10647f:	e4                   	.byte 0xe4

00106480 <start>:
	.long CHECKSUM

	/* this is the entry of the kernel */
	.globl start
start:
	cli
  106480:	fa                   	cli    

	/* check whether the bootloader provide multiboot information */
	cmpl	$MULTIBOOT_BOOTLOADER_MAGIC, %eax
  106481:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
	jne	spin
  106486:	75 27                	jne    1064af <spin>
	movl	%ebx, multiboot_ptr
  106488:	89 1d b0 64 10 00    	mov    %ebx,0x1064b0

	/* tell BIOS to warmboot next time */
	movw	$0x1234, 0x472
  10648e:	66 c7 05 72 04 00 00 	movw   $0x1234,0x472
  106495:	34 12 

	/* clear EFLAGS */
	pushl	$0x2
  106497:	6a 02                	push   $0x2
	popfl
  106499:	9d                   	popf   

	/* prepare the kernel stack */
	movl	$0x0, %ebp
  10649a:	bd 00 00 00 00       	mov    $0x0,%ebp
	movl	$(bsp_kstack + 4096), %esp
  10649f:	bc 00 10 19 00       	mov    $0x191000,%esp

	/* jump to the C code */
	push	multiboot_ptr
  1064a4:	ff 35 b0 64 10 00    	push   0x1064b0
	call	kern_init
  1064aa:	e8 e1 fe ff ff       	call   106390 <kern_init>

001064af <spin>:

	/* should not be here */
spin:
	hlt
  1064af:	f4                   	hlt    

001064b0 <multiboot_ptr>:
  1064b0:	00 00                	add    %al,(%eax)
  1064b2:	00 00                	add    %al,(%eax)
  1064b4:	66 90                	xchg   %ax,%ax
  1064b6:	66 90                	xchg   %ax,%ax
  1064b8:	66 90                	xchg   %ax,%ax
  1064ba:	66 90                	xchg   %ax,%ax
  1064bc:	66 90                	xchg   %ax,%ax
  1064be:	66 90                	xchg   %ax,%ax

001064c0 <mem_spinlock_init>:
 * So it may have up to 2^20 physical pages,
 * with the page size being 4KB.
 */
static struct ATStruct AT[1 << 20];

void mem_spinlock_init(void) {
  1064c0:	53                   	push   %ebx
  1064c1:	e8 c3 9e ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1064c6:	81 c3 3a db 00 00    	add    $0xdb3a,%ebx
  1064cc:	83 ec 14             	sub    $0x14,%esp
    spinlock_init(&mem_lk);
  1064cf:	8d 83 a4 42 88 00    	lea    0x8842a4(%ebx),%eax
  1064d5:	50                   	push   %eax
  1064d6:	e8 05 f9 ff ff       	call   105de0 <spinlock_init>
}
  1064db:	83 c4 18             	add    $0x18,%esp
  1064de:	5b                   	pop    %ebx
  1064df:	c3                   	ret    

001064e0 <mem_lock>:

void mem_lock(void) {
  1064e0:	53                   	push   %ebx
  1064e1:	e8 a3 9e ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1064e6:	81 c3 1a db 00 00    	add    $0xdb1a,%ebx
  1064ec:	83 ec 14             	sub    $0x14,%esp
    spinlock_acquire(&mem_lk);
  1064ef:	8d 83 a4 42 88 00    	lea    0x8842a4(%ebx),%eax
  1064f5:	50                   	push   %eax
  1064f6:	e8 75 f9 ff ff       	call   105e70 <spinlock_acquire>
}
  1064fb:	83 c4 18             	add    $0x18,%esp
  1064fe:	5b                   	pop    %ebx
  1064ff:	c3                   	ret    

00106500 <mem_unlock>:

void mem_unlock(void) {
  106500:	53                   	push   %ebx
  106501:	e8 83 9e ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106506:	81 c3 fa da 00 00    	add    $0xdafa,%ebx
  10650c:	83 ec 14             	sub    $0x14,%esp
    spinlock_release(&mem_lk);
  10650f:	8d 83 a4 42 88 00    	lea    0x8842a4(%ebx),%eax
  106515:	50                   	push   %eax
  106516:	e8 d5 f9 ff ff       	call   105ef0 <spinlock_release>
}
  10651b:	83 c4 18             	add    $0x18,%esp
  10651e:	5b                   	pop    %ebx
  10651f:	c3                   	ret    

00106520 <get_nps>:

// The getter function for NUM_PAGES.
unsigned int get_nps(void)
{
    return NUM_PAGES;
  106520:	e8 5c 9e ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  106525:	05 db da 00 00       	add    $0xdadb,%eax
  10652a:	8b 80 a0 42 88 00    	mov    0x8842a0(%eax),%eax
}
  106530:	c3                   	ret    
  106531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106538:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10653f:	90                   	nop

00106540 <set_nps>:

// The setter function for NUM_PAGES.
void set_nps(unsigned int nps)
{
    NUM_PAGES = nps;
  106540:	e8 3c 9e ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  106545:	05 bb da 00 00       	add    $0xdabb,%eax
  10654a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10654e:	89 90 a0 42 88 00    	mov    %edx,0x8842a0(%eax)
}
  106554:	c3                   	ret    
  106555:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10655c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106560 <at_is_norm>:
        perm = 1;
    } else {
        perm = 0;
    }

    return perm;
  106560:	e8 1c 9e ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  106565:	05 9b da 00 00       	add    $0xda9b,%eax
    if (perm > 1) {
  10656a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10656e:	83 bc d0 a0 42 08 00 	cmpl   $0x1,0x842a0(%eax,%edx,8)
  106575:	01 
  106576:	0f 97 c0             	seta   %al
  106579:	0f b6 c0             	movzbl %al,%eax
}
  10657c:	c3                   	ret    
  10657d:	8d 76 00             	lea    0x0(%esi),%esi

00106580 <at_set_perm>:
 * Sets the permission of the page with given index.
 * It also marks the page as unallocated.
 */
void at_set_perm(unsigned int page_index, unsigned int perm)
{
    AT[page_index].perm = perm;
  106580:	e8 fc 9d ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  106585:	05 7b da 00 00       	add    $0xda7b,%eax
{
  10658a:	8b 54 24 04          	mov    0x4(%esp),%edx
    AT[page_index].perm = perm;
  10658e:	8b 4c 24 08          	mov    0x8(%esp),%ecx
    AT[page_index].allocated = 0;
  106592:	c7 84 d0 a4 42 08 00 	movl   $0x0,0x842a4(%eax,%edx,8)
  106599:	00 00 00 00 
    AT[page_index].perm = perm;
  10659d:	89 8c d0 a0 42 08 00 	mov    %ecx,0x842a0(%eax,%edx,8)
}
  1065a4:	c3                   	ret    
  1065a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1065ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001065b0 <at_is_allocated>:
    allocated = AT[page_index].allocated;
    if (allocated > 0) {
        allocated = 1;
    }

    return allocated;
  1065b0:	e8 cc 9d ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  1065b5:	05 4b da 00 00       	add    $0xda4b,%eax
    if (allocated > 0) {
  1065ba:	8b 54 24 04          	mov    0x4(%esp),%edx
  1065be:	8b 84 d0 a4 42 08 00 	mov    0x842a4(%eax,%edx,8),%eax
  1065c5:	85 c0                	test   %eax,%eax
  1065c7:	0f 95 c0             	setne  %al
  1065ca:	0f b6 c0             	movzbl %al,%eax
}
  1065cd:	c3                   	ret    
  1065ce:	66 90                	xchg   %ax,%ax

001065d0 <at_set_allocated>:
 * The setter function for the physical page allocation flag.
 * Set the flag of the page with given index to the given value.
 */
void at_set_allocated(unsigned int page_index, unsigned int allocated)
{
    AT[page_index].allocated = allocated;
  1065d0:	e8 ac 9d ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  1065d5:	05 2b da 00 00       	add    $0xda2b,%eax
  1065da:	8b 54 24 04          	mov    0x4(%esp),%edx
  1065de:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  1065e2:	89 8c d0 a4 42 08 00 	mov    %ecx,0x842a4(%eax,%edx,8)
}
  1065e9:	c3                   	ret    
  1065ea:	66 90                	xchg   %ax,%ax
  1065ec:	66 90                	xchg   %ax,%ax
  1065ee:	66 90                	xchg   %ax,%ax

001065f0 <pmem_init>:
 *    based on the information available in the physical memory map table.
 *    Review import.h in the current directory for the list of available
 *    getter and setter functions.
 */
void pmem_init(unsigned int mbi_addr)
{
  1065f0:	55                   	push   %ebp
  1065f1:	57                   	push   %edi
  1065f2:	56                   	push   %esi
  1065f3:	53                   	push   %ebx
  1065f4:	e8 90 9d ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1065f9:	81 c3 07 da 00 00    	add    $0xda07,%ebx
  1065ff:	83 ec 38             	sub    $0x38,%esp
    unsigned int pg_idx, pmmap_size, cur_addr, highest_addr;
    unsigned int entry_idx, flag, isnorm, start, len;

    // Calls the lower layer initialization primitive.
    // The parameter mbi_addr should not be used in the further code.
    devinit(mbi_addr);
  106602:	ff 74 24 4c          	push   0x4c(%esp)
  106606:	e8 55 a4 ff ff       	call   100a60 <devinit>
    mem_spinlock_init();
  10660b:	e8 b0 fe ff ff       	call   1064c0 <mem_spinlock_init>
     * Hint: Think of it as the highest address in the ranges of the memory map table,
     *       divided by the page size.
     */
    nps = 0;
    entry_idx = 0;
    pmmap_size = get_size();
  106610:	e8 1b aa ff ff       	call   101030 <get_size>
  106615:	89 44 24 18          	mov    %eax,0x18(%esp)
    while (entry_idx < pmmap_size) {
  106619:	83 c4 10             	add    $0x10,%esp
  10661c:	85 c0                	test   %eax,%eax
  10661e:	0f 84 62 01 00 00    	je     106786 <pmem_init+0x196>
    entry_idx = 0;
  106624:	31 ff                	xor    %edi,%edi
    nps = 0;
  106626:	31 f6                	xor    %esi,%esi
  106628:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10662f:	90                   	nop
        cur_addr = get_mms(entry_idx) + get_mml(entry_idx);
  106630:	83 ec 0c             	sub    $0xc,%esp
  106633:	57                   	push   %edi
  106634:	e8 17 aa ff ff       	call   101050 <get_mms>
  106639:	89 3c 24             	mov    %edi,(%esp)
  10663c:	89 c5                	mov    %eax,%ebp
  10663e:	e8 5d aa ff ff       	call   1010a0 <get_mml>
  106643:	01 e8                	add    %ebp,%eax
  106645:	39 c6                	cmp    %eax,%esi
  106647:	0f 42 f0             	cmovb  %eax,%esi
    while (entry_idx < pmmap_size) {
  10664a:	83 c4 10             	add    $0x10,%esp
        if (nps < cur_addr) {
            nps = cur_addr;
        }
        entry_idx++;
  10664d:	83 c7 01             	add    $0x1,%edi
    while (entry_idx < pmmap_size) {
  106650:	39 7c 24 08          	cmp    %edi,0x8(%esp)
  106654:	75 da                	jne    106630 <pmem_init+0x40>
    }

    nps = ROUNDDOWN(nps, PAGESIZE) / PAGESIZE;
  106656:	89 f5                	mov    %esi,%ebp
    set_nps(nps);  // Setting the value computed above to NUM_PAGES.
  106658:	83 ec 0c             	sub    $0xc,%esp
    nps = ROUNDDOWN(nps, PAGESIZE) / PAGESIZE;
  10665b:	c1 ed 0c             	shr    $0xc,%ebp
  10665e:	89 6c 24 28          	mov    %ebp,0x28(%esp)
    set_nps(nps);  // Setting the value computed above to NUM_PAGES.
  106662:	55                   	push   %ebp
  106663:	e8 d8 fe ff ff       	call   106540 <set_nps>
     *    not aligned by pages, so it may be possible that for some pages, only some of
     *    the addresses are in a usable range. Currently, we do not utilize partial pages,
     *    so in that case, you should consider those pages as unavailable.
     */
    pg_idx = 0;
    while (pg_idx < nps) {
  106668:	83 c4 10             	add    $0x10,%esp
  10666b:	85 ed                	test   %ebp,%ebp
  10666d:	0f 84 f2 00 00 00    	je     106765 <pmem_init+0x175>
  106673:	31 c0                	xor    %eax,%eax
    pg_idx = 0;
  106675:	89 7c 24 10          	mov    %edi,0x10(%esp)
  106679:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  106680:	00 
  106681:	89 c7                	mov    %eax,%edi
  106683:	eb 25                	jmp    1066aa <pmem_init+0xba>
  106685:	8d 76 00             	lea    0x0(%esi),%esi
        if (pg_idx < VM_USERLO_PI || VM_USERHI_PI <= pg_idx) {
            at_set_perm(pg_idx, 1);
  106688:	83 ec 08             	sub    $0x8,%esp
  10668b:	6a 01                	push   $0x1
  10668d:	51                   	push   %ecx
  10668e:	e8 ed fe ff ff       	call   106580 <at_set_perm>
  106693:	83 c4 10             	add    $0x10,%esp
    while (pg_idx < nps) {
  106696:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  10669a:	81 c7 00 10 00 00    	add    $0x1000,%edi
  1066a0:	39 54 24 08          	cmp    %edx,0x8(%esp)
  1066a4:	0f 84 bb 00 00 00    	je     106765 <pmem_init+0x175>
        if (pg_idx < VM_USERLO_PI || VM_USERHI_PI <= pg_idx) {
  1066aa:	8b 44 24 08          	mov    0x8(%esp),%eax
  1066ae:	89 c1                	mov    %eax,%ecx
  1066b0:	89 44 24 18          	mov    %eax,0x18(%esp)
            isnorm = 0;
            while (entry_idx < pmmap_size && !flag) {
                isnorm = is_usable(entry_idx);
                start = get_mms(entry_idx);
                len = get_mml(entry_idx);
                if (start <= pg_idx * PAGESIZE && (pg_idx + 1) * PAGESIZE <= start + len) {
  1066b4:	83 c0 01             	add    $0x1,%eax
  1066b7:	89 44 24 08          	mov    %eax,0x8(%esp)
        if (pg_idx < VM_USERLO_PI || VM_USERHI_PI <= pg_idx) {
  1066bb:	8d 81 00 00 fc ff    	lea    -0x40000(%ecx),%eax
  1066c1:	3d ff ff 0a 00       	cmp    $0xaffff,%eax
  1066c6:	77 c0                	ja     106688 <pmem_init+0x98>
            while (entry_idx < pmmap_size && !flag) {
  1066c8:	8b 44 24 08          	mov    0x8(%esp),%eax
            entry_idx = 0;
  1066cc:	31 f6                	xor    %esi,%esi
  1066ce:	c1 e0 0c             	shl    $0xc,%eax
  1066d1:	89 44 24 14          	mov    %eax,0x14(%esp)
  1066d5:	eb 27                	jmp    1066fe <pmem_init+0x10e>
  1066d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1066de:	66 90                	xchg   %ax,%ax
                if (start <= pg_idx * PAGESIZE && (pg_idx + 1) * PAGESIZE <= start + len) {
  1066e0:	8d 54 05 00          	lea    0x0(%ebp,%eax,1),%edx
  1066e4:	3b 54 24 14          	cmp    0x14(%esp),%edx
  1066e8:	0f 93 c2             	setae  %dl
  1066eb:	0f 92 c0             	setb   %al
                    flag = 1;
                }
                entry_idx++;
  1066ee:	83 c6 01             	add    $0x1,%esi
                if (start <= pg_idx * PAGESIZE && (pg_idx + 1) * PAGESIZE <= start + len) {
  1066f1:	0f b6 d2             	movzbl %dl,%edx
            while (entry_idx < pmmap_size && !flag) {
  1066f4:	3b 74 24 10          	cmp    0x10(%esp),%esi
  1066f8:	73 3a                	jae    106734 <pmem_init+0x144>
  1066fa:	84 c0                	test   %al,%al
  1066fc:	74 36                	je     106734 <pmem_init+0x144>
                isnorm = is_usable(entry_idx);
  1066fe:	83 ec 0c             	sub    $0xc,%esp
  106701:	56                   	push   %esi
  106702:	e8 f9 a9 ff ff       	call   101100 <is_usable>
                start = get_mms(entry_idx);
  106707:	89 34 24             	mov    %esi,(%esp)
                isnorm = is_usable(entry_idx);
  10670a:	89 44 24 1c          	mov    %eax,0x1c(%esp)
                start = get_mms(entry_idx);
  10670e:	e8 3d a9 ff ff       	call   101050 <get_mms>
                len = get_mml(entry_idx);
  106713:	89 34 24             	mov    %esi,(%esp)
                start = get_mms(entry_idx);
  106716:	89 c5                	mov    %eax,%ebp
                len = get_mml(entry_idx);
  106718:	e8 83 a9 ff ff       	call   1010a0 <get_mml>
                if (start <= pg_idx * PAGESIZE && (pg_idx + 1) * PAGESIZE <= start + len) {
  10671d:	83 c4 10             	add    $0x10,%esp
  106720:	39 ef                	cmp    %ebp,%edi
  106722:	73 bc                	jae    1066e0 <pmem_init+0xf0>
  106724:	b8 01 00 00 00       	mov    $0x1,%eax
  106729:	31 d2                	xor    %edx,%edx
                entry_idx++;
  10672b:	83 c6 01             	add    $0x1,%esi
            while (entry_idx < pmmap_size && !flag) {
  10672e:	3b 74 24 10          	cmp    0x10(%esp),%esi
  106732:	72 c6                	jb     1066fa <pmem_init+0x10a>
            }

            if (flag && isnorm) {
  106734:	8b 44 24 0c          	mov    0xc(%esp),%eax
  106738:	85 c0                	test   %eax,%eax
  10673a:	74 34                	je     106770 <pmem_init+0x180>
  10673c:	85 d2                	test   %edx,%edx
  10673e:	74 30                	je     106770 <pmem_init+0x180>
                at_set_perm(pg_idx, 2);
  106740:	83 ec 08             	sub    $0x8,%esp
    while (pg_idx < nps) {
  106743:	81 c7 00 10 00 00    	add    $0x1000,%edi
                at_set_perm(pg_idx, 2);
  106749:	6a 02                	push   $0x2
  10674b:	ff 74 24 24          	push   0x24(%esp)
  10674f:	e8 2c fe ff ff       	call   106580 <at_set_perm>
  106754:	83 c4 10             	add    $0x10,%esp
    while (pg_idx < nps) {
  106757:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  10675b:	39 54 24 08          	cmp    %edx,0x8(%esp)
  10675f:	0f 85 45 ff ff ff    	jne    1066aa <pmem_init+0xba>
                at_set_perm(pg_idx, 0);
            }
        }
        pg_idx++;
    }
}
  106765:	83 c4 2c             	add    $0x2c,%esp
  106768:	5b                   	pop    %ebx
  106769:	5e                   	pop    %esi
  10676a:	5f                   	pop    %edi
  10676b:	5d                   	pop    %ebp
  10676c:	c3                   	ret    
  10676d:	8d 76 00             	lea    0x0(%esi),%esi
                at_set_perm(pg_idx, 0);
  106770:	83 ec 08             	sub    $0x8,%esp
  106773:	6a 00                	push   $0x0
  106775:	ff 74 24 24          	push   0x24(%esp)
  106779:	e8 02 fe ff ff       	call   106580 <at_set_perm>
  10677e:	83 c4 10             	add    $0x10,%esp
  106781:	e9 10 ff ff ff       	jmp    106696 <pmem_init+0xa6>
    set_nps(nps);  // Setting the value computed above to NUM_PAGES.
  106786:	83 ec 0c             	sub    $0xc,%esp
  106789:	6a 00                	push   $0x0
  10678b:	e8 b0 fd ff ff       	call   106540 <set_nps>
  106790:	83 c4 10             	add    $0x10,%esp
}
  106793:	83 c4 2c             	add    $0x2c,%esp
  106796:	5b                   	pop    %ebx
  106797:	5e                   	pop    %esi
  106798:	5f                   	pop    %edi
  106799:	5d                   	pop    %ebp
  10679a:	c3                   	ret    
  10679b:	66 90                	xchg   %ax,%ax
  10679d:	66 90                	xchg   %ax,%ax
  10679f:	90                   	nop

001067a0 <palloc>:
 *    return 0.
 * 2. Optimize the code using memoization so that you do not have to
 *    scan the allocation table from scratch every time.
 */
unsigned int palloc()
{
  1067a0:	55                   	push   %ebp
  1067a1:	57                   	push   %edi
  1067a2:	56                   	push   %esi
  1067a3:	53                   	push   %ebx
  1067a4:	e8 e0 9b ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1067a9:	81 c3 57 d8 00 00    	add    $0xd857,%ebx
  1067af:	83 ec 0c             	sub    $0xc,%esp
    unsigned int nps;
    unsigned int palloc_index;
    unsigned int palloc_free_index;
    bool first;

    mem_lock();
  1067b2:	e8 29 fd ff ff       	call   1064e0 <mem_lock>

    nps = get_nps();
  1067b7:	e8 64 fd ff ff       	call   106520 <get_nps>
    palloc_index = last_palloc_index;
  1067bc:	8b b3 2c 03 00 00    	mov    0x32c(%ebx),%esi
    nps = get_nps();
  1067c2:	89 c7                	mov    %eax,%edi
    palloc_free_index = nps;
    first = TRUE;

    while ((palloc_index != last_palloc_index || first) && palloc_free_index == nps) {
  1067c4:	eb 1a                	jmp    1067e0 <palloc+0x40>
  1067c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1067cd:	8d 76 00             	lea    0x0(%esi),%esi
  1067d0:	3d 00 00 04 00       	cmp    $0x40000,%eax
  1067d5:	74 30                	je     106807 <palloc+0x67>
  1067d7:	be 00 00 04 00       	mov    $0x40000,%esi
  1067dc:	39 fd                	cmp    %edi,%ebp
  1067de:	75 68                	jne    106848 <palloc+0xa8>
        first = FALSE;
        if (at_is_norm(palloc_index) && !at_is_allocated(palloc_index)) {
  1067e0:	83 ec 0c             	sub    $0xc,%esp
  1067e3:	89 fd                	mov    %edi,%ebp
  1067e5:	56                   	push   %esi
  1067e6:	e8 75 fd ff ff       	call   106560 <at_is_norm>
  1067eb:	83 c4 10             	add    $0x10,%esp
  1067ee:	85 c0                	test   %eax,%eax
  1067f0:	75 3e                	jne    106830 <palloc+0x90>
            palloc_free_index = palloc_index;
        }
        palloc_index++;
  1067f2:	83 c6 01             	add    $0x1,%esi
    while ((palloc_index != last_palloc_index || first) && palloc_free_index == nps) {
  1067f5:	8b 83 2c 03 00 00    	mov    0x32c(%ebx),%eax
        if (palloc_index >= VM_USERHI_PI) {
  1067fb:	81 fe ff ff 0e 00    	cmp    $0xeffff,%esi
  106801:	77 cd                	ja     1067d0 <palloc+0x30>
    while ((palloc_index != last_palloc_index || first) && palloc_free_index == nps) {
  106803:	39 c6                	cmp    %eax,%esi
  106805:	75 d5                	jne    1067dc <palloc+0x3c>
            palloc_index = VM_USERLO_PI;
        }
    }

    if (palloc_free_index == nps) {
  106807:	39 fd                	cmp    %edi,%ebp
  106809:	75 3d                	jne    106848 <palloc+0xa8>
  10680b:	b8 00 00 04 00       	mov    $0x40000,%eax
        palloc_free_index = 0;
  106810:	31 ed                	xor    %ebp,%ebp
        last_palloc_index = VM_USERLO_PI;
  106812:	89 83 2c 03 00 00    	mov    %eax,0x32c(%ebx)
    } else {
        at_set_allocated(palloc_free_index, 1);
        last_palloc_index = palloc_free_index;
    }

    mem_unlock();
  106818:	e8 e3 fc ff ff       	call   106500 <mem_unlock>

    return palloc_free_index;
}
  10681d:	83 c4 0c             	add    $0xc,%esp
  106820:	89 e8                	mov    %ebp,%eax
  106822:	5b                   	pop    %ebx
  106823:	5e                   	pop    %esi
  106824:	5f                   	pop    %edi
  106825:	5d                   	pop    %ebp
  106826:	c3                   	ret    
  106827:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10682e:	66 90                	xchg   %ax,%ax
        if (at_is_norm(palloc_index) && !at_is_allocated(palloc_index)) {
  106830:	83 ec 0c             	sub    $0xc,%esp
  106833:	89 f5                	mov    %esi,%ebp
  106835:	56                   	push   %esi
  106836:	e8 75 fd ff ff       	call   1065b0 <at_is_allocated>
  10683b:	83 c4 10             	add    $0x10,%esp
  10683e:	85 c0                	test   %eax,%eax
  106840:	0f 45 ef             	cmovne %edi,%ebp
  106843:	eb ad                	jmp    1067f2 <palloc+0x52>
  106845:	8d 76 00             	lea    0x0(%esi),%esi
        at_set_allocated(palloc_free_index, 1);
  106848:	83 ec 08             	sub    $0x8,%esp
  10684b:	6a 01                	push   $0x1
  10684d:	55                   	push   %ebp
  10684e:	e8 7d fd ff ff       	call   1065d0 <at_set_allocated>
  106853:	83 c4 10             	add    $0x10,%esp
  106856:	89 e8                	mov    %ebp,%eax
  106858:	eb b8                	jmp    106812 <palloc+0x72>
  10685a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106860 <pfree>:
 * in the allocation table.
 *
 * Hint: Simple.
 */
void pfree(unsigned int pfree_index)
{
  106860:	53                   	push   %ebx
  106861:	e8 23 9b ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106866:	81 c3 9a d7 00 00    	add    $0xd79a,%ebx
  10686c:	83 ec 08             	sub    $0x8,%esp
    mem_lock();
  10686f:	e8 6c fc ff ff       	call   1064e0 <mem_lock>
    at_set_allocated(pfree_index, 0);
  106874:	83 ec 08             	sub    $0x8,%esp
  106877:	6a 00                	push   $0x0
  106879:	ff 74 24 1c          	push   0x1c(%esp)
  10687d:	e8 4e fd ff ff       	call   1065d0 <at_set_allocated>
    mem_unlock();
  106882:	e8 79 fc ff ff       	call   106500 <mem_unlock>
}
  106887:	83 c4 18             	add    $0x18,%esp
  10688a:	5b                   	pop    %ebx
  10688b:	c3                   	ret    
  10688c:	66 90                	xchg   %ax,%ax
  10688e:	66 90                	xchg   %ax,%ax

00106890 <container_init>:
/**
 * Initializes the container data for the root process (the one with index 0).
 * The root process is the one that gets spawned first by the kernel.
 */
void container_init(unsigned int mbi_addr)
{
  106890:	55                   	push   %ebp
  106891:	57                   	push   %edi
  106892:	56                   	push   %esi
  106893:	53                   	push   %ebx
  106894:	e8 f0 9a ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106899:	81 c3 67 d7 00 00    	add    $0xd767,%ebx
  10689f:	83 ec 18             	sub    $0x18,%esp
    unsigned int real_quota;
    unsigned int nps, idx;

    pmem_init(mbi_addr);
  1068a2:	ff 74 24 2c          	push   0x2c(%esp)
  1068a6:	e8 45 fd ff ff       	call   1065f0 <pmem_init>
    /**
     * Compute the available quota and store it into the variable real_quota.
     * It should be the number of the unallocated pages with the normal permission
     * in the physical memory allocation table.
     */
    nps = get_nps();
  1068ab:	e8 70 fc ff ff       	call   106520 <get_nps>
    idx = 1;
    while (idx < nps) {
  1068b0:	83 c4 10             	add    $0x10,%esp
  1068b3:	83 f8 01             	cmp    $0x1,%eax
  1068b6:	0f 86 b7 00 00 00    	jbe    106973 <container_init+0xe3>
  1068bc:	89 c6                	mov    %eax,%esi
    idx = 1;
  1068be:	bd 01 00 00 00       	mov    $0x1,%ebp
    real_quota = 0;
  1068c3:	31 ff                	xor    %edi,%edi
  1068c5:	eb 10                	jmp    1068d7 <container_init+0x47>
  1068c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1068ce:	66 90                	xchg   %ax,%ax
        if (at_is_norm(idx) && !at_is_allocated(idx)) {
            real_quota++;
        }
        idx++;
  1068d0:	83 c5 01             	add    $0x1,%ebp
    while (idx < nps) {
  1068d3:	39 ee                	cmp    %ebp,%esi
  1068d5:	74 29                	je     106900 <container_init+0x70>
        if (at_is_norm(idx) && !at_is_allocated(idx)) {
  1068d7:	83 ec 0c             	sub    $0xc,%esp
  1068da:	55                   	push   %ebp
  1068db:	e8 80 fc ff ff       	call   106560 <at_is_norm>
  1068e0:	83 c4 10             	add    $0x10,%esp
  1068e3:	85 c0                	test   %eax,%eax
  1068e5:	74 e9                	je     1068d0 <container_init+0x40>
  1068e7:	83 ec 0c             	sub    $0xc,%esp
  1068ea:	55                   	push   %ebp
  1068eb:	e8 c0 fc ff ff       	call   1065b0 <at_is_allocated>
  1068f0:	83 c4 10             	add    $0x10,%esp
            real_quota++;
  1068f3:	83 f8 01             	cmp    $0x1,%eax
  1068f6:	83 d7 00             	adc    $0x0,%edi
        idx++;
  1068f9:	83 c5 01             	add    $0x1,%ebp
    while (idx < nps) {
  1068fc:	39 ee                	cmp    %ebp,%esi
  1068fe:	75 d7                	jne    1068d7 <container_init+0x47>
    }

    KERN_DEBUG("\nreal quota: %d\n\n", real_quota);

    CONTAINER[0].quota = real_quota;
  106900:	89 fe                	mov    %edi,%esi
    KERN_DEBUG("\nreal quota: %d\n\n", real_quota);
  106902:	8d 83 48 87 ff ff    	lea    -0x78b8(%ebx),%eax
  106908:	57                   	push   %edi
  106909:	50                   	push   %eax
  10690a:	8d 83 5c 87 ff ff    	lea    -0x78a4(%ebx),%eax
  106910:	6a 2c                	push   $0x2c
  106912:	50                   	push   %eax
  106913:	e8 98 dd ff ff       	call   1046b0 <debug_normal>
    CONTAINER[0].quota = real_quota;
  106918:	89 b3 c0 44 88 00    	mov    %esi,0x8844c0(%ebx)
    CONTAINER[0].usage = 0;
  10691e:	83 c4 10             	add    $0x10,%esp
  106921:	8d b3 c0 42 88 00    	lea    0x8842c0(%ebx),%esi
  106927:	c7 83 c4 44 88 00 00 	movl   $0x0,0x8844c4(%ebx)
  10692e:	00 00 00 
    CONTAINER[0].parent = 0;
  106931:	8d be 00 02 00 00    	lea    0x200(%esi),%edi
  106937:	c7 83 c8 44 88 00 00 	movl   $0x0,0x8844c8(%ebx)
  10693e:	00 00 00 
    CONTAINER[0].nchildren = 0;
  106941:	c7 83 cc 44 88 00 00 	movl   $0x0,0x8844cc(%ebx)
  106948:	00 00 00 
    CONTAINER[0].used = 1;
  10694b:	c7 83 d0 44 88 00 01 	movl   $0x1,0x8844d0(%ebx)
  106952:	00 00 00 

    for (idx = 0; idx < NUM_IDS; idx++) {
  106955:	8d 76 00             	lea    0x0(%esi),%esi
        spinlock_init(&container_lks[idx]);
  106958:	83 ec 0c             	sub    $0xc,%esp
  10695b:	56                   	push   %esi
    for (idx = 0; idx < NUM_IDS; idx++) {
  10695c:	83 c6 08             	add    $0x8,%esi
        spinlock_init(&container_lks[idx]);
  10695f:	e8 7c f4 ff ff       	call   105de0 <spinlock_init>
    for (idx = 0; idx < NUM_IDS; idx++) {
  106964:	83 c4 10             	add    $0x10,%esp
  106967:	39 fe                	cmp    %edi,%esi
  106969:	75 ed                	jne    106958 <container_init+0xc8>
    }
}
  10696b:	83 c4 0c             	add    $0xc,%esp
  10696e:	5b                   	pop    %ebx
  10696f:	5e                   	pop    %esi
  106970:	5f                   	pop    %edi
  106971:	5d                   	pop    %ebp
  106972:	c3                   	ret    
    while (idx < nps) {
  106973:	31 f6                	xor    %esi,%esi
    real_quota = 0;
  106975:	31 ff                	xor    %edi,%edi
  106977:	eb 89                	jmp    106902 <container_init+0x72>
  106979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00106980 <container_get_parent>:

// Get the id of parent process of process # [id].
unsigned int container_get_parent(unsigned int id)
{
    return CONTAINER[id].parent;
  106980:	e8 00 9a ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106985:	81 c2 7b d6 00 00    	add    $0xd67b,%edx
{
  10698b:	8b 44 24 04          	mov    0x4(%esp),%eax
    return CONTAINER[id].parent;
  10698f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  106992:	8b 84 82 c8 44 88 00 	mov    0x8844c8(%edx,%eax,4),%eax
}
  106999:	c3                   	ret    
  10699a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001069a0 <container_get_nchildren>:

// Get the number of children of process # [id].
unsigned int container_get_nchildren(unsigned int id)
{
    return CONTAINER[id].nchildren;
  1069a0:	e8 e0 99 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  1069a5:	81 c2 5b d6 00 00    	add    $0xd65b,%edx
{
  1069ab:	8b 44 24 04          	mov    0x4(%esp),%eax
    return CONTAINER[id].nchildren;
  1069af:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1069b2:	8b 84 82 cc 44 88 00 	mov    0x8844cc(%edx,%eax,4),%eax
}
  1069b9:	c3                   	ret    
  1069ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001069c0 <container_get_quota>:

// Get the maximum memory quota of process # [id].
unsigned int container_get_quota(unsigned int id)
{
    return CONTAINER[id].quota;
  1069c0:	e8 c0 99 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  1069c5:	81 c2 3b d6 00 00    	add    $0xd63b,%edx
{
  1069cb:	8b 44 24 04          	mov    0x4(%esp),%eax
    return CONTAINER[id].quota;
  1069cf:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1069d2:	8b 84 82 c0 44 88 00 	mov    0x8844c0(%edx,%eax,4),%eax
}
  1069d9:	c3                   	ret    
  1069da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001069e0 <container_get_usage>:

// Get the current memory usage of process # [id].
unsigned int container_get_usage(unsigned int id)
{
    return CONTAINER[id].usage;
  1069e0:	e8 a0 99 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  1069e5:	81 c2 1b d6 00 00    	add    $0xd61b,%edx
{
  1069eb:	8b 44 24 04          	mov    0x4(%esp),%eax
    return CONTAINER[id].usage;
  1069ef:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1069f2:	8b 84 82 c4 44 88 00 	mov    0x8844c4(%edx,%eax,4),%eax
}
  1069f9:	c3                   	ret    
  1069fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106a00 <container_can_consume>:

// Determines whether the process # [id] can consume an extra
// [n] pages of memory. If so, returns 1, otherwise, returns 0.
unsigned int container_can_consume(unsigned int id, unsigned int n)
{
    return CONTAINER[id].usage + n <= CONTAINER[id].quota;
  106a00:	e8 5e e5 ff ff       	call   104f63 <__x86.get_pc_thunk.cx>
  106a05:	81 c1 fb d5 00 00    	add    $0xd5fb,%ecx
{
  106a0b:	8b 44 24 04          	mov    0x4(%esp),%eax
    return CONTAINER[id].usage + n <= CONTAINER[id].quota;
  106a0f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  106a12:	c1 e0 02             	shl    $0x2,%eax
  106a15:	8b 94 01 c4 44 88 00 	mov    0x8844c4(%ecx,%eax,1),%edx
  106a1c:	03 54 24 08          	add    0x8(%esp),%edx
  106a20:	3b 94 01 c0 44 88 00 	cmp    0x8844c0(%ecx,%eax,1),%edx
  106a27:	0f 96 c0             	setbe  %al
  106a2a:	0f b6 c0             	movzbl %al,%eax
}
  106a2d:	c3                   	ret    
  106a2e:	66 90                	xchg   %ax,%ax

00106a30 <container_split>:
 * You can assume it is safe to allocate [quota] pages
 * (the check is already done outside before calling this function).
 * Returns the container index for the new child process.
 */
unsigned int container_split(unsigned int id, unsigned int quota)
{
  106a30:	55                   	push   %ebp
  106a31:	57                   	push   %edi
  106a32:	56                   	push   %esi
  106a33:	53                   	push   %ebx
  106a34:	e8 50 99 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106a39:	81 c3 c7 d5 00 00    	add    $0xd5c7,%ebx
  106a3f:	83 ec 28             	sub    $0x28,%esp
  106a42:	8b 74 24 3c          	mov    0x3c(%esp),%esi
    unsigned int child, nc;

    spinlock_acquire(&container_lks[id]);

    nc = CONTAINER[id].nchildren;
    child = id * MAX_CHILDREN + 1 + nc;  // container index for the child process
  106a46:	8d 7c 76 01          	lea    0x1(%esi,%esi,2),%edi
    spinlock_acquire(&container_lks[id]);
  106a4a:	8d ac f3 c0 42 88 00 	lea    0x8842c0(%ebx,%esi,8),%ebp
  106a51:	55                   	push   %ebp
  106a52:	e8 19 f4 ff ff       	call   105e70 <spinlock_acquire>
    nc = CONTAINER[id].nchildren;
  106a57:	8d 04 b6             	lea    (%esi,%esi,4),%eax

    if (NUM_IDS <= child) {
  106a5a:	83 c4 10             	add    $0x10,%esp
    nc = CONTAINER[id].nchildren;
  106a5d:	8d 84 83 c0 44 88 00 	lea    0x8844c0(%ebx,%eax,4),%eax
    child = id * MAX_CHILDREN + 1 + nc;  // container index for the child process
  106a64:	03 78 0c             	add    0xc(%eax),%edi
    if (NUM_IDS <= child) {
  106a67:	83 ff 3f             	cmp    $0x3f,%edi
  106a6a:	77 54                	ja     106ac0 <container_split+0x90>
    }

    /**
     * Update the container structure of both parent and child process appropriately.
     */
    CONTAINER[child].used = 1;
  106a6c:	8d 14 bf             	lea    (%edi,%edi,4),%edx
    CONTAINER[child].nchildren = 0;

    CONTAINER[id].usage += quota;
    CONTAINER[id].nchildren++;

    spinlock_release(&container_lks[id]);
  106a6f:	83 ec 0c             	sub    $0xc,%esp
    CONTAINER[child].used = 1;
  106a72:	c1 e2 02             	shl    $0x2,%edx
  106a75:	8d 8c 13 c0 44 88 00 	lea    0x8844c0(%ebx,%edx,1),%ecx
  106a7c:	89 54 24 18          	mov    %edx,0x18(%esp)
    CONTAINER[child].quota = quota;
  106a80:	8b 54 24 40          	mov    0x40(%esp),%edx
    CONTAINER[child].usage = 0;
  106a84:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
    CONTAINER[child].parent = id;
  106a8b:	89 71 08             	mov    %esi,0x8(%ecx)
    CONTAINER[child].nchildren = 0;
  106a8e:	c7 41 0c 00 00 00 00 	movl   $0x0,0xc(%ecx)
    CONTAINER[child].used = 1;
  106a95:	c7 41 10 01 00 00 00 	movl   $0x1,0x10(%ecx)
    CONTAINER[id].nchildren++;
  106a9c:	83 40 0c 01          	addl   $0x1,0xc(%eax)
    CONTAINER[child].quota = quota;
  106aa0:	89 11                	mov    %edx,(%ecx)
    CONTAINER[id].usage += quota;
  106aa2:	8b 4c 24 40          	mov    0x40(%esp),%ecx
  106aa6:	01 48 04             	add    %ecx,0x4(%eax)
    spinlock_release(&container_lks[id]);
  106aa9:	55                   	push   %ebp
  106aaa:	e8 41 f4 ff ff       	call   105ef0 <spinlock_release>

    return child;
  106aaf:	83 c4 10             	add    $0x10,%esp
}
  106ab2:	89 f8                	mov    %edi,%eax
  106ab4:	83 c4 1c             	add    $0x1c,%esp
  106ab7:	5b                   	pop    %ebx
  106ab8:	5e                   	pop    %esi
  106ab9:	5f                   	pop    %edi
  106aba:	5d                   	pop    %ebp
  106abb:	c3                   	ret    
  106abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  106ac0:	83 c4 1c             	add    $0x1c,%esp
        return NUM_IDS;
  106ac3:	bf 40 00 00 00       	mov    $0x40,%edi
}
  106ac8:	5b                   	pop    %ebx
  106ac9:	89 f8                	mov    %edi,%eax
  106acb:	5e                   	pop    %esi
  106acc:	5f                   	pop    %edi
  106acd:	5d                   	pop    %ebp
  106ace:	c3                   	ret    
  106acf:	90                   	nop

00106ad0 <container_alloc>:
 * Allocates one more page for process # [id], given that this will not exceed the quota.
 * The container structure should be updated accordingly after the allocation.
 * Returns the page index of the allocated page, or 0 in the case of failure.
 */
unsigned int container_alloc(unsigned int id)
{
  106ad0:	57                   	push   %edi
  106ad1:	56                   	push   %esi
  106ad2:	53                   	push   %ebx
  106ad3:	8b 74 24 10          	mov    0x10(%esp),%esi
  106ad7:	e8 ad 98 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106adc:	81 c3 24 d5 00 00    	add    $0xd524,%ebx
    unsigned int page_index = 0;

    spinlock_acquire(&container_lks[id]);
  106ae2:	83 ec 0c             	sub    $0xc,%esp
  106ae5:	8d bc f3 c0 42 88 00 	lea    0x8842c0(%ebx,%esi,8),%edi
  106aec:	57                   	push   %edi
  106aed:	e8 7e f3 ff ff       	call   105e70 <spinlock_acquire>

    if (CONTAINER[id].usage + 1 <= CONTAINER[id].quota) {
  106af2:	8d 14 b6             	lea    (%esi,%esi,4),%edx
  106af5:	83 c4 10             	add    $0x10,%esp
  106af8:	31 f6                	xor    %esi,%esi
  106afa:	c1 e2 02             	shl    $0x2,%edx
  106afd:	8d 8c 13 c0 44 88 00 	lea    0x8844c0(%ebx,%edx,1),%ecx
  106b04:	8b 41 04             	mov    0x4(%ecx),%eax
  106b07:	3b 84 13 c0 44 88 00 	cmp    0x8844c0(%ebx,%edx,1),%eax
  106b0e:	7c 18                	jl     106b28 <container_alloc+0x58>
        CONTAINER[id].usage++;
        page_index = palloc();
    }

    spinlock_release(&container_lks[id]);
  106b10:	83 ec 0c             	sub    $0xc,%esp
  106b13:	57                   	push   %edi
  106b14:	e8 d7 f3 ff ff       	call   105ef0 <spinlock_release>

    return page_index;
  106b19:	83 c4 10             	add    $0x10,%esp
}
  106b1c:	89 f0                	mov    %esi,%eax
  106b1e:	5b                   	pop    %ebx
  106b1f:	5e                   	pop    %esi
  106b20:	5f                   	pop    %edi
  106b21:	c3                   	ret    
  106b22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        CONTAINER[id].usage++;
  106b28:	83 c0 01             	add    $0x1,%eax
  106b2b:	89 41 04             	mov    %eax,0x4(%ecx)
        page_index = palloc();
  106b2e:	e8 6d fc ff ff       	call   1067a0 <palloc>
  106b33:	89 c6                	mov    %eax,%esi
  106b35:	eb d9                	jmp    106b10 <container_alloc+0x40>
  106b37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106b3e:	66 90                	xchg   %ax,%ax

00106b40 <container_free>:

// Frees the physical page and reduces the usage by 1.
void container_free(unsigned int id, unsigned int page_index)
{
  106b40:	55                   	push   %ebp
  106b41:	57                   	push   %edi
  106b42:	56                   	push   %esi
  106b43:	53                   	push   %ebx
  106b44:	e8 40 98 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106b49:	81 c3 b7 d4 00 00    	add    $0xd4b7,%ebx
  106b4f:	83 ec 18             	sub    $0x18,%esp
  106b52:	8b 74 24 2c          	mov    0x2c(%esp),%esi
  106b56:	8b 7c 24 30          	mov    0x30(%esp),%edi
    spinlock_acquire(&container_lks[id]);
  106b5a:	8d ac f3 c0 42 88 00 	lea    0x8842c0(%ebx,%esi,8),%ebp
  106b61:	55                   	push   %ebp
  106b62:	e8 09 f3 ff ff       	call   105e70 <spinlock_acquire>

    if (at_is_allocated(page_index)) {
  106b67:	89 3c 24             	mov    %edi,(%esp)
  106b6a:	e8 41 fa ff ff       	call   1065b0 <at_is_allocated>
  106b6f:	83 c4 10             	add    $0x10,%esp
  106b72:	85 c0                	test   %eax,%eax
  106b74:	75 1a                	jne    106b90 <container_free+0x50>
        if (CONTAINER[id].usage > 0) {
            CONTAINER[id].usage--;
        }
    }

    spinlock_release(&container_lks[id]);
  106b76:	83 ec 0c             	sub    $0xc,%esp
  106b79:	55                   	push   %ebp
  106b7a:	e8 71 f3 ff ff       	call   105ef0 <spinlock_release>
}
  106b7f:	83 c4 1c             	add    $0x1c,%esp
  106b82:	5b                   	pop    %ebx
  106b83:	5e                   	pop    %esi
  106b84:	5f                   	pop    %edi
  106b85:	5d                   	pop    %ebp
  106b86:	c3                   	ret    
  106b87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106b8e:	66 90                	xchg   %ax,%ax
        pfree(page_index);
  106b90:	83 ec 0c             	sub    $0xc,%esp
  106b93:	57                   	push   %edi
  106b94:	e8 c7 fc ff ff       	call   106860 <pfree>
        if (CONTAINER[id].usage > 0) {
  106b99:	8d 04 b6             	lea    (%esi,%esi,4),%eax
  106b9c:	83 c4 10             	add    $0x10,%esp
  106b9f:	8d 94 83 c0 44 88 00 	lea    0x8844c0(%ebx,%eax,4),%edx
  106ba6:	8b 42 04             	mov    0x4(%edx),%eax
  106ba9:	85 c0                	test   %eax,%eax
  106bab:	7e c9                	jle    106b76 <container_free+0x36>
            CONTAINER[id].usage--;
  106bad:	83 e8 01             	sub    $0x1,%eax
  106bb0:	89 42 04             	mov    %eax,0x4(%edx)
  106bb3:	eb c1                	jmp    106b76 <container_free+0x36>
  106bb5:	66 90                	xchg   %ax,%ax
  106bb7:	66 90                	xchg   %ax,%ax
  106bb9:	66 90                	xchg   %ax,%ax
  106bbb:	66 90                	xchg   %ax,%ax
  106bbd:	66 90                	xchg   %ax,%ax
  106bbf:	90                   	nop

00106bc0 <set_pdir_base>:
 */
unsigned int IDPTbl[1024][1024] gcc_aligned(PAGESIZE);

// Sets the CR3 register with the start address of the page structure for process # [index].
void set_pdir_base(unsigned int index)
{
  106bc0:	53                   	push   %ebx
  106bc1:	e8 c3 97 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106bc6:	81 c3 3a d4 00 00    	add    $0xd43a,%ebx
  106bcc:	83 ec 14             	sub    $0x14,%esp
    set_cr3(PDirPool[index]);
  106bcf:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  106bd3:	c1 e0 0c             	shl    $0xc,%eax
  106bd6:	8d 84 03 00 50 c8 00 	lea    0xc85000(%ebx,%eax,1),%eax
  106bdd:	50                   	push   %eax
  106bde:	e8 7d a5 ff ff       	call   101160 <set_cr3>
}
  106be3:	83 c4 18             	add    $0x18,%esp
  106be6:	5b                   	pop    %ebx
  106be7:	c3                   	ret    
  106be8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106bef:	90                   	nop

00106bf0 <get_pdir_entry>:

// Returns the page directory entry # [pde_index] of the process # [proc_index].
// This can be used to test whether the page directory entry is mapped.
unsigned int get_pdir_entry(unsigned int proc_index, unsigned int pde_index)
{
    return (unsigned int) PDirPool[proc_index][pde_index];
  106bf0:	e8 90 97 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106bf5:	81 c2 0b d4 00 00    	add    $0xd40b,%edx
  106bfb:	8b 44 24 04          	mov    0x4(%esp),%eax
  106bff:	c1 e0 0a             	shl    $0xa,%eax
  106c02:	03 44 24 08          	add    0x8(%esp),%eax
  106c06:	8b 84 82 00 50 c8 00 	mov    0xc85000(%edx,%eax,4),%eax
}
  106c0d:	c3                   	ret    
  106c0e:	66 90                	xchg   %ax,%ax

00106c10 <set_pdir_entry>:
// You should also set the permissions PTE_P, PTE_W, and PTE_U.
void set_pdir_entry(unsigned int proc_index, unsigned int pde_index,
                    unsigned int page_index)
{
    unsigned int addr = page_index << 12;
    PDirPool[proc_index][pde_index] = (unsigned int *) (addr | PT_PERM_PTU);
  106c10:	e8 4e e3 ff ff       	call   104f63 <__x86.get_pc_thunk.cx>
  106c15:	81 c1 eb d3 00 00    	add    $0xd3eb,%ecx
    unsigned int addr = page_index << 12;
  106c1b:	8b 54 24 0c          	mov    0xc(%esp),%edx
    PDirPool[proc_index][pde_index] = (unsigned int *) (addr | PT_PERM_PTU);
  106c1f:	8b 44 24 04          	mov    0x4(%esp),%eax
    unsigned int addr = page_index << 12;
  106c23:	c1 e2 0c             	shl    $0xc,%edx
    PDirPool[proc_index][pde_index] = (unsigned int *) (addr | PT_PERM_PTU);
  106c26:	c1 e0 0a             	shl    $0xa,%eax
  106c29:	03 44 24 08          	add    0x8(%esp),%eax
  106c2d:	83 ca 07             	or     $0x7,%edx
  106c30:	89 94 81 00 50 c8 00 	mov    %edx,0xc85000(%ecx,%eax,4)
}
  106c37:	c3                   	ret    
  106c38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106c3f:	90                   	nop

00106c40 <set_pdir_entry_identity>:
// with the initial address of page directory # [pde_index] in IDPTbl.
// You should also set the permissions PTE_P, PTE_W, and PTE_U.
// This will be used to map a page directory entry to an identity page table.
void set_pdir_entry_identity(unsigned int proc_index, unsigned int pde_index)
{
    unsigned int addr = (unsigned int) IDPTbl[pde_index];
  106c40:	e8 1e e3 ff ff       	call   104f63 <__x86.get_pc_thunk.cx>
  106c45:	81 c1 bb d3 00 00    	add    $0xd3bb,%ecx
    PDirPool[proc_index][pde_index] = (unsigned int *) (addr | PT_PERM_PTU);
  106c4b:	8b 44 24 04          	mov    0x4(%esp),%eax
{
  106c4f:	8b 54 24 08          	mov    0x8(%esp),%edx
    PDirPool[proc_index][pde_index] = (unsigned int *) (addr | PT_PERM_PTU);
  106c53:	c1 e0 0a             	shl    $0xa,%eax
  106c56:	01 d0                	add    %edx,%eax
    unsigned int addr = (unsigned int) IDPTbl[pde_index];
  106c58:	c1 e2 0c             	shl    $0xc,%edx
  106c5b:	8d 94 11 00 50 88 00 	lea    0x885000(%ecx,%edx,1),%edx
    PDirPool[proc_index][pde_index] = (unsigned int *) (addr | PT_PERM_PTU);
  106c62:	83 ca 07             	or     $0x7,%edx
  106c65:	89 94 81 00 50 c8 00 	mov    %edx,0xc85000(%ecx,%eax,4)
}
  106c6c:	c3                   	ret    
  106c6d:	8d 76 00             	lea    0x0(%esi),%esi

00106c70 <rmv_pdir_entry>:

// Removes the specified page directory entry (sets the page directory entry to 0).
// Don't forget to cast the value to (unsigned int *).
void rmv_pdir_entry(unsigned int proc_index, unsigned int pde_index)
{
    PDirPool[proc_index][pde_index] = (unsigned int *) 0;
  106c70:	e8 10 97 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106c75:	81 c2 8b d3 00 00    	add    $0xd38b,%edx
  106c7b:	8b 44 24 04          	mov    0x4(%esp),%eax
  106c7f:	c1 e0 0a             	shl    $0xa,%eax
  106c82:	03 44 24 08          	add    0x8(%esp),%eax
  106c86:	c7 84 82 00 50 c8 00 	movl   $0x0,0xc85000(%edx,%eax,4)
  106c8d:	00 00 00 00 
}
  106c91:	c3                   	ret    
  106c92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00106ca0 <get_ptbl_entry>:
// Do not forget that the permission info is also stored in the page directory entries.
unsigned int get_ptbl_entry(unsigned int proc_index, unsigned int pde_index,
                            unsigned int pte_index)
{
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
    return pt[pte_index];
  106ca0:	e8 e0 96 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106ca5:	81 c2 5b d3 00 00    	add    $0xd35b,%edx
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  106cab:	8b 44 24 04          	mov    0x4(%esp),%eax
  106caf:	c1 e0 0a             	shl    $0xa,%eax
  106cb2:	03 44 24 08          	add    0x8(%esp),%eax
  106cb6:	8b 84 82 00 50 c8 00 	mov    0xc85000(%edx,%eax,4),%eax
    return pt[pte_index];
  106cbd:	8b 54 24 0c          	mov    0xc(%esp),%edx
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  106cc1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    return pt[pte_index];
  106cc6:	8b 04 90             	mov    (%eax,%edx,4),%eax
}
  106cc9:	c3                   	ret    
  106cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106cd0 <set_ptbl_entry>:
void set_ptbl_entry(unsigned int proc_index, unsigned int pde_index,
                    unsigned int pte_index, unsigned int page_index,
                    unsigned int perm)
{
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
    pt[pte_index] = (page_index << 12) | perm;
  106cd0:	e8 b0 96 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106cd5:	81 c2 2b d3 00 00    	add    $0xd32b,%edx
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  106cdb:	8b 44 24 04          	mov    0x4(%esp),%eax
    pt[pte_index] = (page_index << 12) | perm;
  106cdf:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  106ce3:	c1 e0 0a             	shl    $0xa,%eax
  106ce6:	03 44 24 08          	add    0x8(%esp),%eax
  106cea:	8b 94 82 00 50 c8 00 	mov    0xc85000(%edx,%eax,4),%edx
    pt[pte_index] = (page_index << 12) | perm;
  106cf1:	8b 44 24 10          	mov    0x10(%esp),%eax
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  106cf5:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
    pt[pte_index] = (page_index << 12) | perm;
  106cfb:	c1 e0 0c             	shl    $0xc,%eax
  106cfe:	0b 44 24 14          	or     0x14(%esp),%eax
  106d02:	89 04 8a             	mov    %eax,(%edx,%ecx,4)
}
  106d05:	c3                   	ret    
  106d06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106d0d:	8d 76 00             	lea    0x0(%esi),%esi

00106d10 <set_ptbl_entry_identity>:

// Sets up the specified page table entry in IDPTbl as the identity map.
// You should also set the given permission.
void set_ptbl_entry_identity(unsigned int pde_index, unsigned int pte_index,
                             unsigned int perm)
{
  106d10:	53                   	push   %ebx
  106d11:	8b 54 24 08          	mov    0x8(%esp),%edx
  106d15:	e8 6f 96 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106d1a:	81 c3 e6 d2 00 00    	add    $0xd2e6,%ebx
  106d20:	8b 44 24 0c          	mov    0xc(%esp),%eax
    unsigned int addr = (pde_index << 22) | (pte_index << 12);
    IDPTbl[pde_index][pte_index] = addr | perm;
  106d24:	89 d1                	mov    %edx,%ecx
    unsigned int addr = (pde_index << 22) | (pte_index << 12);
  106d26:	c1 e2 16             	shl    $0x16,%edx
    IDPTbl[pde_index][pte_index] = addr | perm;
  106d29:	c1 e1 0a             	shl    $0xa,%ecx
  106d2c:	01 c1                	add    %eax,%ecx
    unsigned int addr = (pde_index << 22) | (pte_index << 12);
  106d2e:	c1 e0 0c             	shl    $0xc,%eax
    IDPTbl[pde_index][pte_index] = addr | perm;
  106d31:	0b 44 24 10          	or     0x10(%esp),%eax
  106d35:	09 d0                	or     %edx,%eax
  106d37:	89 84 8b 00 50 88 00 	mov    %eax,0x885000(%ebx,%ecx,4)
}
  106d3e:	5b                   	pop    %ebx
  106d3f:	c3                   	ret    

00106d40 <rmv_ptbl_entry>:
// Sets the specified page table entry to 0.
void rmv_ptbl_entry(unsigned int proc_index, unsigned int pde_index,
                    unsigned int pte_index)
{
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
    pt[pte_index] = 0;
  106d40:	e8 40 96 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106d45:	81 c2 bb d2 00 00    	add    $0xd2bb,%edx
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  106d4b:	8b 44 24 04          	mov    0x4(%esp),%eax
  106d4f:	c1 e0 0a             	shl    $0xa,%eax
  106d52:	03 44 24 08          	add    0x8(%esp),%eax
  106d56:	8b 84 82 00 50 c8 00 	mov    0xc85000(%edx,%eax,4),%eax
    pt[pte_index] = 0;
  106d5d:	8b 54 24 0c          	mov    0xc(%esp),%edx
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  106d61:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    pt[pte_index] = 0;
  106d66:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
}
  106d6d:	c3                   	ret    
  106d6e:	66 90                	xchg   %ax,%ax

00106d70 <get_ptbl_entry_by_va>:
 * Returns the page table entry corresponding to the virtual address,
 * according to the page structure of process # [proc_index].
 * Returns 0 if the mapping does not exist.
 */
unsigned int get_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  106d70:	55                   	push   %ebp
  106d71:	57                   	push   %edi
  106d72:	56                   	push   %esi
  106d73:	53                   	push   %ebx
  106d74:	e8 10 96 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106d79:	81 c3 87 d2 00 00    	add    $0xd287,%ebx
  106d7f:	83 ec 14             	sub    $0x14,%esp
  106d82:	8b 74 24 2c          	mov    0x2c(%esp),%esi
  106d86:	8b 7c 24 28          	mov    0x28(%esp),%edi
    unsigned int pde_index = PDE_ADDR(vaddr);
  106d8a:	89 f5                	mov    %esi,%ebp
  106d8c:	c1 ed 16             	shr    $0x16,%ebp
    if (get_pdir_entry(proc_index, pde_index) != 0) {
  106d8f:	55                   	push   %ebp
  106d90:	57                   	push   %edi
  106d91:	e8 5a fe ff ff       	call   106bf0 <get_pdir_entry>
  106d96:	83 c4 10             	add    $0x10,%esp
  106d99:	85 c0                	test   %eax,%eax
  106d9b:	75 0b                	jne    106da8 <get_ptbl_entry_by_va+0x38>
        return get_ptbl_entry(proc_index, pde_index, PTE_ADDR(vaddr));
    } else {
        return 0;
    }
}
  106d9d:	83 c4 0c             	add    $0xc,%esp
  106da0:	5b                   	pop    %ebx
  106da1:	5e                   	pop    %esi
  106da2:	5f                   	pop    %edi
  106da3:	5d                   	pop    %ebp
  106da4:	c3                   	ret    
  106da5:	8d 76 00             	lea    0x0(%esi),%esi
        return get_ptbl_entry(proc_index, pde_index, PTE_ADDR(vaddr));
  106da8:	c1 ee 0c             	shr    $0xc,%esi
  106dab:	83 ec 04             	sub    $0x4,%esp
  106dae:	81 e6 ff 03 00 00    	and    $0x3ff,%esi
  106db4:	56                   	push   %esi
  106db5:	55                   	push   %ebp
  106db6:	57                   	push   %edi
  106db7:	e8 e4 fe ff ff       	call   106ca0 <get_ptbl_entry>
  106dbc:	83 c4 10             	add    $0x10,%esp
}
  106dbf:	83 c4 0c             	add    $0xc,%esp
  106dc2:	5b                   	pop    %ebx
  106dc3:	5e                   	pop    %esi
  106dc4:	5f                   	pop    %edi
  106dc5:	5d                   	pop    %ebp
  106dc6:	c3                   	ret    
  106dc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106dce:	66 90                	xchg   %ax,%ax

00106dd0 <get_pdir_entry_by_va>:

// Returns the page directory entry corresponding to the given virtual address.
unsigned int get_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  106dd0:	53                   	push   %ebx
  106dd1:	e8 b3 95 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106dd6:	81 c3 2a d2 00 00    	add    $0xd22a,%ebx
  106ddc:	83 ec 10             	sub    $0x10,%esp
    return get_pdir_entry(proc_index, PDE_ADDR(vaddr));
  106ddf:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  106de3:	c1 e8 16             	shr    $0x16,%eax
  106de6:	50                   	push   %eax
  106de7:	ff 74 24 1c          	push   0x1c(%esp)
  106deb:	e8 00 fe ff ff       	call   106bf0 <get_pdir_entry>
}
  106df0:	83 c4 18             	add    $0x18,%esp
  106df3:	5b                   	pop    %ebx
  106df4:	c3                   	ret    
  106df5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106e00 <rmv_ptbl_entry_by_va>:

// Removes the page table entry for the given virtual address.
void rmv_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  106e00:	55                   	push   %ebp
  106e01:	57                   	push   %edi
  106e02:	56                   	push   %esi
  106e03:	53                   	push   %ebx
  106e04:	e8 80 95 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106e09:	81 c3 f7 d1 00 00    	add    $0xd1f7,%ebx
  106e0f:	83 ec 14             	sub    $0x14,%esp
  106e12:	8b 74 24 2c          	mov    0x2c(%esp),%esi
  106e16:	8b 7c 24 28          	mov    0x28(%esp),%edi
    unsigned int pde_index = PDE_ADDR(vaddr);
  106e1a:	89 f5                	mov    %esi,%ebp
  106e1c:	c1 ed 16             	shr    $0x16,%ebp
    if (get_pdir_entry(proc_index, pde_index) != 0) {
  106e1f:	55                   	push   %ebp
  106e20:	57                   	push   %edi
  106e21:	e8 ca fd ff ff       	call   106bf0 <get_pdir_entry>
  106e26:	83 c4 10             	add    $0x10,%esp
  106e29:	85 c0                	test   %eax,%eax
  106e2b:	75 0b                	jne    106e38 <rmv_ptbl_entry_by_va+0x38>
        rmv_ptbl_entry(proc_index, pde_index, PTE_ADDR(vaddr));
    }
}
  106e2d:	83 c4 0c             	add    $0xc,%esp
  106e30:	5b                   	pop    %ebx
  106e31:	5e                   	pop    %esi
  106e32:	5f                   	pop    %edi
  106e33:	5d                   	pop    %ebp
  106e34:	c3                   	ret    
  106e35:	8d 76 00             	lea    0x0(%esi),%esi
        rmv_ptbl_entry(proc_index, pde_index, PTE_ADDR(vaddr));
  106e38:	c1 ee 0c             	shr    $0xc,%esi
  106e3b:	83 ec 04             	sub    $0x4,%esp
  106e3e:	81 e6 ff 03 00 00    	and    $0x3ff,%esi
  106e44:	56                   	push   %esi
  106e45:	55                   	push   %ebp
  106e46:	57                   	push   %edi
  106e47:	e8 f4 fe ff ff       	call   106d40 <rmv_ptbl_entry>
  106e4c:	83 c4 10             	add    $0x10,%esp
}
  106e4f:	83 c4 0c             	add    $0xc,%esp
  106e52:	5b                   	pop    %ebx
  106e53:	5e                   	pop    %esi
  106e54:	5f                   	pop    %edi
  106e55:	5d                   	pop    %ebp
  106e56:	c3                   	ret    
  106e57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106e5e:	66 90                	xchg   %ax,%ax

00106e60 <rmv_pdir_entry_by_va>:

// Removes the page directory entry for the given virtual address.
void rmv_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  106e60:	53                   	push   %ebx
  106e61:	e8 23 95 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106e66:	81 c3 9a d1 00 00    	add    $0xd19a,%ebx
  106e6c:	83 ec 10             	sub    $0x10,%esp
    rmv_pdir_entry(proc_index, PDE_ADDR(vaddr));
  106e6f:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  106e73:	c1 e8 16             	shr    $0x16,%eax
  106e76:	50                   	push   %eax
  106e77:	ff 74 24 1c          	push   0x1c(%esp)
  106e7b:	e8 f0 fd ff ff       	call   106c70 <rmv_pdir_entry>
}
  106e80:	83 c4 18             	add    $0x18,%esp
  106e83:	5b                   	pop    %ebx
  106e84:	c3                   	ret    
  106e85:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106e90 <set_ptbl_entry_by_va>:

// Maps the virtual address [vaddr] to the physical page # [page_index] with permission [perm].
// You do not need to worry about the page directory entry. just map the page table entry.
void set_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr,
                          unsigned int page_index, unsigned int perm)
{
  106e90:	53                   	push   %ebx
  106e91:	e8 f3 94 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106e96:	81 c3 6a d1 00 00    	add    $0xd16a,%ebx
  106e9c:	83 ec 14             	sub    $0x14,%esp
  106e9f:	8b 44 24 20          	mov    0x20(%esp),%eax
    set_ptbl_entry(proc_index, PDE_ADDR(vaddr), PTE_ADDR(vaddr), page_index, perm);
  106ea3:	ff 74 24 28          	push   0x28(%esp)
  106ea7:	ff 74 24 28          	push   0x28(%esp)
  106eab:	89 c2                	mov    %eax,%edx
  106ead:	c1 e8 16             	shr    $0x16,%eax
  106eb0:	c1 ea 0c             	shr    $0xc,%edx
  106eb3:	81 e2 ff 03 00 00    	and    $0x3ff,%edx
  106eb9:	52                   	push   %edx
  106eba:	50                   	push   %eax
  106ebb:	ff 74 24 2c          	push   0x2c(%esp)
  106ebf:	e8 0c fe ff ff       	call   106cd0 <set_ptbl_entry>
}
  106ec4:	83 c4 28             	add    $0x28,%esp
  106ec7:	5b                   	pop    %ebx
  106ec8:	c3                   	ret    
  106ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00106ed0 <set_pdir_entry_by_va>:

// Registers the mapping from [vaddr] to physical page # [page_index] in the page directory.
void set_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr,
                          unsigned int page_index)
{
  106ed0:	53                   	push   %ebx
  106ed1:	e8 b3 94 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106ed6:	81 c3 2a d1 00 00    	add    $0xd12a,%ebx
  106edc:	83 ec 0c             	sub    $0xc,%esp
    set_pdir_entry(proc_index, PDE_ADDR(vaddr), page_index);
  106edf:	ff 74 24 1c          	push   0x1c(%esp)
  106ee3:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  106ee7:	c1 e8 16             	shr    $0x16,%eax
  106eea:	50                   	push   %eax
  106eeb:	ff 74 24 1c          	push   0x1c(%esp)
  106eef:	e8 1c fd ff ff       	call   106c10 <set_pdir_entry>
}
  106ef4:	83 c4 18             	add    $0x18,%esp
  106ef7:	5b                   	pop    %ebx
  106ef8:	c3                   	ret    
  106ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00106f00 <idptbl_init>:

// Initializes the identity page table.
// The permission for the kernel memory should be PTE_P, PTE_W, and PTE_G,
// While the permission for the rest should be PTE_P and PTE_W.
void idptbl_init(unsigned int mbi_addr)
{
  106f00:	55                   	push   %ebp
    unsigned int pde_index, pte_index, perm;
    container_init(mbi_addr);

    // Set up IDPTbl
    for (pde_index = 0; pde_index < 1024; pde_index++) {
  106f01:	31 ed                	xor    %ebp,%ebp
{
  106f03:	57                   	push   %edi
  106f04:	56                   	push   %esi
  106f05:	53                   	push   %ebx
  106f06:	e8 7e 94 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106f0b:	81 c3 f5 d0 00 00    	add    $0xd0f5,%ebx
  106f11:	83 ec 18             	sub    $0x18,%esp
    container_init(mbi_addr);
  106f14:	ff 74 24 2c          	push   0x2c(%esp)
  106f18:	e8 73 f9 ff ff       	call   106890 <container_init>
  106f1d:	83 c4 10             	add    $0x10,%esp
        if ((pde_index < VM_USERLO_PDE) || (VM_USERHI_PDE <= pde_index)) {
  106f20:	8d 85 00 ff ff ff    	lea    -0x100(%ebp),%eax
            // kernel mapping
            perm = PTE_P | PTE_W | PTE_G;
        } else {
            // normal memory
            perm = PTE_P | PTE_W;
  106f26:	3d c0 02 00 00       	cmp    $0x2c0,%eax
  106f2b:	19 ff                	sbb    %edi,%edi
        }

        for (pte_index = 0; pte_index < 1024; pte_index++) {
  106f2d:	31 f6                	xor    %esi,%esi
            perm = PTE_P | PTE_W;
  106f2f:	81 e7 00 ff ff ff    	and    $0xffffff00,%edi
  106f35:	81 c7 03 01 00 00    	add    $0x103,%edi
        for (pte_index = 0; pte_index < 1024; pte_index++) {
  106f3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  106f3f:	90                   	nop
            set_ptbl_entry_identity(pde_index, pte_index, perm);
  106f40:	83 ec 04             	sub    $0x4,%esp
  106f43:	57                   	push   %edi
  106f44:	56                   	push   %esi
        for (pte_index = 0; pte_index < 1024; pte_index++) {
  106f45:	83 c6 01             	add    $0x1,%esi
            set_ptbl_entry_identity(pde_index, pte_index, perm);
  106f48:	55                   	push   %ebp
  106f49:	e8 c2 fd ff ff       	call   106d10 <set_ptbl_entry_identity>
        for (pte_index = 0; pte_index < 1024; pte_index++) {
  106f4e:	83 c4 10             	add    $0x10,%esp
  106f51:	81 fe 00 04 00 00    	cmp    $0x400,%esi
  106f57:	75 e7                	jne    106f40 <idptbl_init+0x40>
    for (pde_index = 0; pde_index < 1024; pde_index++) {
  106f59:	83 c5 01             	add    $0x1,%ebp
  106f5c:	81 fd 00 04 00 00    	cmp    $0x400,%ebp
  106f62:	75 bc                	jne    106f20 <idptbl_init+0x20>
        }
    }
}
  106f64:	83 c4 0c             	add    $0xc,%esp
  106f67:	5b                   	pop    %ebx
  106f68:	5e                   	pop    %esi
  106f69:	5f                   	pop    %edi
  106f6a:	5d                   	pop    %ebp
  106f6b:	c3                   	ret    
  106f6c:	66 90                	xchg   %ax,%ax
  106f6e:	66 90                	xchg   %ax,%ax

00106f70 <pdir_init>:
 * For each process from id 0 to NUM_IDS - 1,
 * set up the page directory entries so that the kernel portion of the map is
 * the identity map, and the rest of the page directories are unmapped.
 */
void pdir_init(unsigned int mbi_addr)
{
  106f70:	57                   	push   %edi
    unsigned int proc_index, pde_index;
    idptbl_init(mbi_addr);

    for (proc_index = 0; proc_index < NUM_IDS; proc_index++) {
  106f71:	31 ff                	xor    %edi,%edi
{
  106f73:	56                   	push   %esi
  106f74:	53                   	push   %ebx
  106f75:	e8 0f 94 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106f7a:	81 c3 86 d0 00 00    	add    $0xd086,%ebx
    idptbl_init(mbi_addr);
  106f80:	83 ec 0c             	sub    $0xc,%esp
  106f83:	ff 74 24 1c          	push   0x1c(%esp)
  106f87:	e8 74 ff ff ff       	call   106f00 <idptbl_init>
  106f8c:	83 c4 10             	add    $0x10,%esp
        for (pde_index = 0; pde_index < 1024; pde_index++) {
  106f8f:	31 c0                	xor    %eax,%eax
  106f91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            if ((pde_index < VM_USERLO_PDE) || (VM_USERHI_PDE <= pde_index)) {
  106f98:	8d 90 00 ff ff ff    	lea    -0x100(%eax),%edx
        for (pde_index = 0; pde_index < 1024; pde_index++) {
  106f9e:	8d 70 01             	lea    0x1(%eax),%esi
            if ((pde_index < VM_USERLO_PDE) || (VM_USERHI_PDE <= pde_index)) {
  106fa1:	81 fa bf 02 00 00    	cmp    $0x2bf,%edx
  106fa7:	77 11                	ja     106fba <pdir_init+0x4a>
                set_pdir_entry_identity(proc_index, pde_index);
            } else {
                rmv_pdir_entry(proc_index, pde_index);
  106fa9:	83 ec 08             	sub    $0x8,%esp
  106fac:	50                   	push   %eax
  106fad:	57                   	push   %edi
  106fae:	e8 bd fc ff ff       	call   106c70 <rmv_pdir_entry>
  106fb3:	83 c4 10             	add    $0x10,%esp
        for (pde_index = 0; pde_index < 1024; pde_index++) {
  106fb6:	89 f0                	mov    %esi,%eax
  106fb8:	eb de                	jmp    106f98 <pdir_init+0x28>
                set_pdir_entry_identity(proc_index, pde_index);
  106fba:	83 ec 08             	sub    $0x8,%esp
  106fbd:	50                   	push   %eax
  106fbe:	57                   	push   %edi
  106fbf:	e8 7c fc ff ff       	call   106c40 <set_pdir_entry_identity>
        for (pde_index = 0; pde_index < 1024; pde_index++) {
  106fc4:	83 c4 10             	add    $0x10,%esp
  106fc7:	81 fe 00 04 00 00    	cmp    $0x400,%esi
  106fcd:	75 e7                	jne    106fb6 <pdir_init+0x46>
    for (proc_index = 0; proc_index < NUM_IDS; proc_index++) {
  106fcf:	83 c7 01             	add    $0x1,%edi
  106fd2:	83 ff 40             	cmp    $0x40,%edi
  106fd5:	75 b8                	jne    106f8f <pdir_init+0x1f>
            }
        }
    }
}
  106fd7:	5b                   	pop    %ebx
  106fd8:	5e                   	pop    %esi
  106fd9:	5f                   	pop    %edi
  106fda:	c3                   	ret    
  106fdb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  106fdf:	90                   	nop

00106fe0 <alloc_ptbl>:
 * and clears (set to 0) all page table entries for this newly mapped page table.
 * It returns the page index of the newly allocated physical page.
 * In the case when there's no physical page available, it returns 0.
 */
unsigned int alloc_ptbl(unsigned int proc_index, unsigned int vaddr)
{
  106fe0:	55                   	push   %ebp
  106fe1:	57                   	push   %edi
  106fe2:	56                   	push   %esi
  106fe3:	53                   	push   %ebx
  106fe4:	e8 a0 93 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106fe9:	81 c3 17 d0 00 00    	add    $0xd017,%ebx
  106fef:	83 ec 28             	sub    $0x28,%esp
  106ff2:	8b 74 24 3c          	mov    0x3c(%esp),%esi
    unsigned int page_index = container_alloc(proc_index);
  106ff6:	56                   	push   %esi
  106ff7:	e8 d4 fa ff ff       	call   106ad0 <container_alloc>
  106ffc:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    unsigned int pde_index = PDE_ADDR(vaddr);
    unsigned int pte_index;

    if (page_index == 0) {
  107000:	83 c4 10             	add    $0x10,%esp
  107003:	85 c0                	test   %eax,%eax
  107005:	75 0c                	jne    107013 <alloc_ptbl+0x33>
            rmv_ptbl_entry(proc_index, pde_index, pte_index);
        }

        return page_index;
    }
}
  107007:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10700b:	83 c4 1c             	add    $0x1c,%esp
  10700e:	5b                   	pop    %ebx
  10700f:	5e                   	pop    %esi
  107010:	5f                   	pop    %edi
  107011:	5d                   	pop    %ebp
  107012:	c3                   	ret    
    unsigned int pde_index = PDE_ADDR(vaddr);
  107013:	8b 7c 24 34          	mov    0x34(%esp),%edi
        set_pdir_entry_by_va(proc_index, vaddr, page_index);
  107017:	83 ec 04             	sub    $0x4,%esp
        for (pte_index = 0; pte_index < 1024; pte_index++) {
  10701a:	31 ed                	xor    %ebp,%ebp
        set_pdir_entry_by_va(proc_index, vaddr, page_index);
  10701c:	50                   	push   %eax
  10701d:	ff 74 24 3c          	push   0x3c(%esp)
    unsigned int pde_index = PDE_ADDR(vaddr);
  107021:	c1 ef 16             	shr    $0x16,%edi
        set_pdir_entry_by_va(proc_index, vaddr, page_index);
  107024:	56                   	push   %esi
  107025:	e8 a6 fe ff ff       	call   106ed0 <set_pdir_entry_by_va>
  10702a:	83 c4 10             	add    $0x10,%esp
  10702d:	8d 76 00             	lea    0x0(%esi),%esi
            rmv_ptbl_entry(proc_index, pde_index, pte_index);
  107030:	83 ec 04             	sub    $0x4,%esp
  107033:	55                   	push   %ebp
        for (pte_index = 0; pte_index < 1024; pte_index++) {
  107034:	83 c5 01             	add    $0x1,%ebp
            rmv_ptbl_entry(proc_index, pde_index, pte_index);
  107037:	57                   	push   %edi
  107038:	56                   	push   %esi
  107039:	e8 02 fd ff ff       	call   106d40 <rmv_ptbl_entry>
        for (pte_index = 0; pte_index < 1024; pte_index++) {
  10703e:	83 c4 10             	add    $0x10,%esp
  107041:	81 fd 00 04 00 00    	cmp    $0x400,%ebp
  107047:	75 e7                	jne    107030 <alloc_ptbl+0x50>
}
  107049:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10704d:	83 c4 1c             	add    $0x1c,%esp
  107050:	5b                   	pop    %ebx
  107051:	5e                   	pop    %esi
  107052:	5f                   	pop    %edi
  107053:	5d                   	pop    %ebp
  107054:	c3                   	ret    
  107055:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10705c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107060 <free_ptbl>:

// Reverse operation of alloc_ptbl.
// Removes corresponding the page directory entry,
// and frees the page for the page table entries (with container_free).
void free_ptbl(unsigned int proc_index, unsigned int vaddr)
{
  107060:	55                   	push   %ebp
  107061:	57                   	push   %edi
  107062:	56                   	push   %esi
  107063:	53                   	push   %ebx
  107064:	e8 20 93 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107069:	81 c3 97 cf 00 00    	add    $0xcf97,%ebx
  10706f:	83 ec 14             	sub    $0x14,%esp
  107072:	8b 6c 24 28          	mov    0x28(%esp),%ebp
  107076:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
    unsigned int page_index = get_pdir_entry_by_va(proc_index, vaddr) >> 12;
  10707a:	57                   	push   %edi

    rmv_pdir_entry(proc_index, PDE_ADDR(vaddr));
  10707b:	c1 ef 16             	shr    $0x16,%edi
    unsigned int page_index = get_pdir_entry_by_va(proc_index, vaddr) >> 12;
  10707e:	55                   	push   %ebp
  10707f:	e8 4c fd ff ff       	call   106dd0 <get_pdir_entry_by_va>
  107084:	89 c6                	mov    %eax,%esi
    rmv_pdir_entry(proc_index, PDE_ADDR(vaddr));
  107086:	58                   	pop    %eax
  107087:	5a                   	pop    %edx
  107088:	57                   	push   %edi
  107089:	55                   	push   %ebp
    unsigned int page_index = get_pdir_entry_by_va(proc_index, vaddr) >> 12;
  10708a:	c1 ee 0c             	shr    $0xc,%esi
    rmv_pdir_entry(proc_index, PDE_ADDR(vaddr));
  10708d:	e8 de fb ff ff       	call   106c70 <rmv_pdir_entry>
    container_free(proc_index, page_index);
  107092:	59                   	pop    %ecx
  107093:	5f                   	pop    %edi
  107094:	56                   	push   %esi
  107095:	55                   	push   %ebp
  107096:	e8 a5 fa ff ff       	call   106b40 <container_free>
}
  10709b:	83 c4 1c             	add    $0x1c,%esp
  10709e:	5b                   	pop    %ebx
  10709f:	5e                   	pop    %esi
  1070a0:	5f                   	pop    %edi
  1070a1:	5d                   	pop    %ebp
  1070a2:	c3                   	ret    
  1070a3:	66 90                	xchg   %ax,%ax
  1070a5:	66 90                	xchg   %ax,%ax
  1070a7:	66 90                	xchg   %ax,%ax
  1070a9:	66 90                	xchg   %ax,%ax
  1070ab:	66 90                	xchg   %ax,%ax
  1070ad:	66 90                	xchg   %ax,%ax
  1070af:	90                   	nop

001070b0 <pdir_init_kern>:
/**
 * Sets the entire page map for process 0 as the identity map.
 * Note that part of the task is already completed by pdir_init.
 */
void pdir_init_kern(unsigned int mbi_addr)
{
  1070b0:	56                   	push   %esi
    unsigned int pde_index;

    pdir_init(mbi_addr);

    // Set identity map for user PDEs
    for (pde_index = VM_USERLO_PDE; pde_index < VM_USERHI_PDE; pde_index++) {
  1070b1:	be 00 01 00 00       	mov    $0x100,%esi
{
  1070b6:	53                   	push   %ebx
  1070b7:	e8 cd 92 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1070bc:	81 c3 44 cf 00 00    	add    $0xcf44,%ebx
  1070c2:	83 ec 10             	sub    $0x10,%esp
    pdir_init(mbi_addr);
  1070c5:	ff 74 24 1c          	push   0x1c(%esp)
  1070c9:	e8 a2 fe ff ff       	call   106f70 <pdir_init>
  1070ce:	83 c4 10             	add    $0x10,%esp
  1070d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        set_pdir_entry_identity(0, pde_index);
  1070d8:	83 ec 08             	sub    $0x8,%esp
  1070db:	56                   	push   %esi
    for (pde_index = VM_USERLO_PDE; pde_index < VM_USERHI_PDE; pde_index++) {
  1070dc:	83 c6 01             	add    $0x1,%esi
        set_pdir_entry_identity(0, pde_index);
  1070df:	6a 00                	push   $0x0
  1070e1:	e8 5a fb ff ff       	call   106c40 <set_pdir_entry_identity>
    for (pde_index = VM_USERLO_PDE; pde_index < VM_USERHI_PDE; pde_index++) {
  1070e6:	83 c4 10             	add    $0x10,%esp
  1070e9:	81 fe c0 03 00 00    	cmp    $0x3c0,%esi
  1070ef:	75 e7                	jne    1070d8 <pdir_init_kern+0x28>
    }
}
  1070f1:	83 c4 04             	add    $0x4,%esp
  1070f4:	5b                   	pop    %ebx
  1070f5:	5e                   	pop    %esi
  1070f6:	c3                   	ret    
  1070f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1070fe:	66 90                	xchg   %ax,%ax

00107100 <map_page>:
 * otherwise, it returns the physical page index registered in the page directory,
 * (the return value of get_pdir_entry_by_va or alloc_ptbl).
 */
unsigned int map_page(unsigned int proc_index, unsigned int vaddr,
                      unsigned int page_index, unsigned int perm)
{
  107100:	55                   	push   %ebp
  107101:	57                   	push   %edi
  107102:	56                   	push   %esi
  107103:	53                   	push   %ebx
  107104:	e8 80 92 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107109:	81 c3 f7 ce 00 00    	add    $0xcef7,%ebx
  10710f:	83 ec 14             	sub    $0x14,%esp
  107112:	8b 7c 24 28          	mov    0x28(%esp),%edi
  107116:	8b 6c 24 2c          	mov    0x2c(%esp),%ebp
    unsigned int pde_entry = get_pdir_entry_by_va(proc_index, vaddr);
  10711a:	55                   	push   %ebp
  10711b:	57                   	push   %edi
  10711c:	e8 af fc ff ff       	call   106dd0 <get_pdir_entry_by_va>
    unsigned int pde_page_index = pde_entry >> 12;

    if (pde_entry == 0) {
  107121:	83 c4 10             	add    $0x10,%esp
  107124:	85 c0                	test   %eax,%eax
  107126:	74 28                	je     107150 <map_page+0x50>
    unsigned int pde_page_index = pde_entry >> 12;
  107128:	c1 e8 0c             	shr    $0xc,%eax
  10712b:	89 c6                	mov    %eax,%esi
        if (pde_page_index == 0) {
            return MagicNumber;
        }
    }

    set_ptbl_entry_by_va(proc_index, vaddr, page_index, perm);
  10712d:	ff 74 24 2c          	push   0x2c(%esp)
  107131:	ff 74 24 2c          	push   0x2c(%esp)
  107135:	55                   	push   %ebp
  107136:	57                   	push   %edi
  107137:	e8 54 fd ff ff       	call   106e90 <set_ptbl_entry_by_va>
    return pde_page_index;
  10713c:	83 c4 10             	add    $0x10,%esp
}
  10713f:	89 f0                	mov    %esi,%eax
  107141:	83 c4 0c             	add    $0xc,%esp
  107144:	5b                   	pop    %ebx
  107145:	5e                   	pop    %esi
  107146:	5f                   	pop    %edi
  107147:	5d                   	pop    %ebp
  107148:	c3                   	ret    
  107149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        pde_page_index = alloc_ptbl(proc_index, vaddr);
  107150:	83 ec 08             	sub    $0x8,%esp
  107153:	55                   	push   %ebp
  107154:	57                   	push   %edi
  107155:	e8 86 fe ff ff       	call   106fe0 <alloc_ptbl>
        if (pde_page_index == 0) {
  10715a:	83 c4 10             	add    $0x10,%esp
        pde_page_index = alloc_ptbl(proc_index, vaddr);
  10715d:	89 c6                	mov    %eax,%esi
        if (pde_page_index == 0) {
  10715f:	85 c0                	test   %eax,%eax
  107161:	75 ca                	jne    10712d <map_page+0x2d>
}
  107163:	83 c4 0c             	add    $0xc,%esp
            return MagicNumber;
  107166:	be 01 00 10 00       	mov    $0x100001,%esi
}
  10716b:	5b                   	pop    %ebx
  10716c:	89 f0                	mov    %esi,%eax
  10716e:	5e                   	pop    %esi
  10716f:	5f                   	pop    %edi
  107170:	5d                   	pop    %ebp
  107171:	c3                   	ret    
  107172:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00107180 <unmap_page>:
 * Nothing should be done if the mapping no longer exists.
 * You do not need to unmap the page table from the page directory.
 * It should return the corresponding page table entry.
 */
unsigned int unmap_page(unsigned int proc_index, unsigned int vaddr)
{
  107180:	57                   	push   %edi
  107181:	56                   	push   %esi
  107182:	53                   	push   %ebx
  107183:	e8 01 92 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107188:	81 c3 78 ce 00 00    	add    $0xce78,%ebx
  10718e:	83 ec 18             	sub    $0x18,%esp
  107191:	8b 74 24 28          	mov    0x28(%esp),%esi
  107195:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
    unsigned int pte_entry = get_ptbl_entry_by_va(proc_index, vaddr);
  107199:	57                   	push   %edi
  10719a:	56                   	push   %esi
  10719b:	e8 d0 fb ff ff       	call   106d70 <get_ptbl_entry_by_va>
    if (pte_entry != 0) {
  1071a0:	83 c4 10             	add    $0x10,%esp
  1071a3:	85 c0                	test   %eax,%eax
  1071a5:	75 09                	jne    1071b0 <unmap_page+0x30>
        rmv_ptbl_entry_by_va(proc_index, vaddr);
    }
    return pte_entry;
}
  1071a7:	83 c4 10             	add    $0x10,%esp
  1071aa:	5b                   	pop    %ebx
  1071ab:	5e                   	pop    %esi
  1071ac:	5f                   	pop    %edi
  1071ad:	c3                   	ret    
  1071ae:	66 90                	xchg   %ax,%ax
  1071b0:	89 44 24 0c          	mov    %eax,0xc(%esp)
        rmv_ptbl_entry_by_va(proc_index, vaddr);
  1071b4:	83 ec 08             	sub    $0x8,%esp
  1071b7:	57                   	push   %edi
  1071b8:	56                   	push   %esi
  1071b9:	e8 42 fc ff ff       	call   106e00 <rmv_ptbl_entry_by_va>
  1071be:	83 c4 10             	add    $0x10,%esp
  1071c1:	8b 44 24 0c          	mov    0xc(%esp),%eax
}
  1071c5:	83 c4 10             	add    $0x10,%esp
  1071c8:	5b                   	pop    %ebx
  1071c9:	5e                   	pop    %esi
  1071ca:	5f                   	pop    %edi
  1071cb:	c3                   	ret    
  1071cc:	66 90                	xchg   %ax,%ax
  1071ce:	66 90                	xchg   %ax,%ax

001071d0 <paging_init>:
/**
 * Initializes the page structures, moves to the kernel page structure (0),
 * and turns on the paging.
 */
void paging_init(unsigned int mbi_addr)
{
  1071d0:	53                   	push   %ebx
  1071d1:	e8 b3 91 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1071d6:	81 c3 2a ce 00 00    	add    $0xce2a,%ebx
  1071dc:	83 ec 14             	sub    $0x14,%esp
    pdir_init_kern(mbi_addr);
  1071df:	ff 74 24 1c          	push   0x1c(%esp)
  1071e3:	e8 c8 fe ff ff       	call   1070b0 <pdir_init_kern>
    set_pdir_base(0);
  1071e8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1071ef:	e8 cc f9 ff ff       	call   106bc0 <set_pdir_base>
    enable_paging();
  1071f4:	e8 87 9f ff ff       	call   101180 <enable_paging>
}
  1071f9:	83 c4 18             	add    $0x18,%esp
  1071fc:	5b                   	pop    %ebx
  1071fd:	c3                   	ret    
  1071fe:	66 90                	xchg   %ax,%ax

00107200 <paging_init_ap>:

void paging_init_ap(void)
{
  107200:	53                   	push   %ebx
  107201:	e8 83 91 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107206:	81 c3 fa cd 00 00    	add    $0xcdfa,%ebx
  10720c:	83 ec 14             	sub    $0x14,%esp
    set_pdir_base(0);
  10720f:	6a 00                	push   $0x0
  107211:	e8 aa f9 ff ff       	call   106bc0 <set_pdir_base>
    enable_paging();
  107216:	e8 65 9f ff ff       	call   101180 <enable_paging>
}
  10721b:	83 c4 18             	add    $0x18,%esp
  10721e:	5b                   	pop    %ebx
  10721f:	c3                   	ret    

00107220 <alloc_page>:
 * return value from map_page.
 * In the case of error, it should return the constant MagicNumber.
 */
unsigned int alloc_page(unsigned int proc_index, unsigned int vaddr,
                        unsigned int perm)
{
  107220:	56                   	push   %esi
  107221:	53                   	push   %ebx
  107222:	e8 62 91 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107227:	81 c3 d9 cd 00 00    	add    $0xcdd9,%ebx
  10722d:	83 ec 10             	sub    $0x10,%esp
  107230:	8b 74 24 1c          	mov    0x1c(%esp),%esi
    unsigned int page_index = container_alloc(proc_index);
  107234:	56                   	push   %esi
  107235:	e8 96 f8 ff ff       	call   106ad0 <container_alloc>
    if (page_index != 0) {
  10723a:	83 c4 10             	add    $0x10,%esp
  10723d:	ba 01 00 10 00       	mov    $0x100001,%edx
  107242:	85 c0                	test   %eax,%eax
  107244:	74 14                	je     10725a <alloc_page+0x3a>
        return map_page(proc_index, vaddr, page_index, perm);
  107246:	ff 74 24 18          	push   0x18(%esp)
  10724a:	50                   	push   %eax
  10724b:	ff 74 24 1c          	push   0x1c(%esp)
  10724f:	56                   	push   %esi
  107250:	e8 ab fe ff ff       	call   107100 <map_page>
  107255:	83 c4 10             	add    $0x10,%esp
  107258:	89 c2                	mov    %eax,%edx
    } else {
        return MagicNumber;
    }
}
  10725a:	83 c4 04             	add    $0x4,%esp
  10725d:	89 d0                	mov    %edx,%eax
  10725f:	5b                   	pop    %ebx
  107260:	5e                   	pop    %esi
  107261:	c3                   	ret    
  107262:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00107270 <alloc_mem_quota>:

/**
 * Designate some memory quota for the next child process.
 */
unsigned int alloc_mem_quota(unsigned int id, unsigned int quota)
{
  107270:	53                   	push   %ebx
  107271:	e8 13 91 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107276:	81 c3 8a cd 00 00    	add    $0xcd8a,%ebx
  10727c:	83 ec 10             	sub    $0x10,%esp
    unsigned int child;
    child = container_split(id, quota);
  10727f:	ff 74 24 1c          	push   0x1c(%esp)
  107283:	ff 74 24 1c          	push   0x1c(%esp)
  107287:	e8 a4 f7 ff ff       	call   106a30 <container_split>
    return child;
}
  10728c:	83 c4 18             	add    $0x18,%esp
  10728f:	5b                   	pop    %ebx
  107290:	c3                   	ret    
  107291:	66 90                	xchg   %ax,%ax
  107293:	66 90                	xchg   %ax,%ax
  107295:	66 90                	xchg   %ax,%ax
  107297:	66 90                	xchg   %ax,%ax
  107299:	66 90                	xchg   %ax,%ax
  10729b:	66 90                	xchg   %ax,%ax
  10729d:	66 90                	xchg   %ax,%ax
  10729f:	90                   	nop

001072a0 <kctx_set_esp>:
// Memory to save the NUM_IDS kernel thread states.
struct kctx kctx_pool[NUM_IDS];

void kctx_set_esp(unsigned int pid, void *esp)
{
    kctx_pool[pid].esp = esp;
  1072a0:	e8 e0 90 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  1072a5:	81 c2 5b cd 00 00    	add    $0xcd5b,%edx
{
  1072ab:	8b 44 24 04          	mov    0x4(%esp),%eax
    kctx_pool[pid].esp = esp;
  1072af:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  1072b3:	8d 04 40             	lea    (%eax,%eax,2),%eax
  1072b6:	89 8c c2 00 50 cc 00 	mov    %ecx,0xcc5000(%edx,%eax,8)
}
  1072bd:	c3                   	ret    
  1072be:	66 90                	xchg   %ax,%ax

001072c0 <kctx_set_eip>:

void kctx_set_eip(unsigned int pid, void *eip)
{
    kctx_pool[pid].eip = eip;
  1072c0:	e8 c0 90 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  1072c5:	81 c2 3b cd 00 00    	add    $0xcd3b,%edx
{
  1072cb:	8b 44 24 04          	mov    0x4(%esp),%eax
    kctx_pool[pid].eip = eip;
  1072cf:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  1072d3:	8d 04 40             	lea    (%eax,%eax,2),%eax
  1072d6:	89 8c c2 14 50 cc 00 	mov    %ecx,0xcc5014(%edx,%eax,8)
}
  1072dd:	c3                   	ret    
  1072de:	66 90                	xchg   %ax,%ax

001072e0 <kctx_switch>:
/**
 * Saves the states for thread # [from_pid] and restores the states
 * for thread # [to_pid].
 */
void kctx_switch(unsigned int from_pid, unsigned int to_pid)
{
  1072e0:	53                   	push   %ebx
  1072e1:	e8 a3 90 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1072e6:	81 c3 1a cd 00 00    	add    $0xcd1a,%ebx
  1072ec:	83 ec 10             	sub    $0x10,%esp
  1072ef:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  1072f3:	8b 54 24 18          	mov    0x18(%esp),%edx
    cswitch(&kctx_pool[from_pid], &kctx_pool[to_pid]);
  1072f7:	8d 0c 40             	lea    (%eax,%eax,2),%ecx
  1072fa:	8d 14 52             	lea    (%edx,%edx,2),%edx
  1072fd:	8d 83 00 50 cc 00    	lea    0xcc5000(%ebx),%eax
  107303:	8d 0c c8             	lea    (%eax,%ecx,8),%ecx
  107306:	8d 04 d0             	lea    (%eax,%edx,8),%eax
  107309:	51                   	push   %ecx
  10730a:	50                   	push   %eax
  10730b:	e8 05 00 00 00       	call   107315 <cswitch>
}
  107310:	83 c4 18             	add    $0x18,%esp
  107313:	5b                   	pop    %ebx
  107314:	c3                   	ret    

00107315 <cswitch>:
/*
 * void cswitch(struct kctx *from, struct kctx *to);
 */
	.globl cswitch
cswitch:
	movl	4(%esp), %eax	/* %eax <- from */
  107315:	8b 44 24 04          	mov    0x4(%esp),%eax
	movl	8(%esp), %edx	/* %edx <- to */
  107319:	8b 54 24 08          	mov    0x8(%esp),%edx

	/* save the old kernel context */
	movl	0(%esp), %ecx
  10731d:	8b 0c 24             	mov    (%esp),%ecx
	movl	%ecx, 20(%eax)
  107320:	89 48 14             	mov    %ecx,0x14(%eax)
	movl	%ebp, 16(%eax)
  107323:	89 68 10             	mov    %ebp,0x10(%eax)
	movl	%ebx, 12(%eax)
  107326:	89 58 0c             	mov    %ebx,0xc(%eax)
	movl	%esi, 8(%eax)
  107329:	89 70 08             	mov    %esi,0x8(%eax)
	movl	%edi, 4(%eax)
  10732c:	89 78 04             	mov    %edi,0x4(%eax)
	movl	%esp, 0(%eax)
  10732f:	89 20                	mov    %esp,(%eax)

	/* load the new kernel context */
	movl	0(%edx), %esp
  107331:	8b 22                	mov    (%edx),%esp
	movl	4(%edx), %edi
  107333:	8b 7a 04             	mov    0x4(%edx),%edi
	movl	8(%edx), %esi
  107336:	8b 72 08             	mov    0x8(%edx),%esi
	movl	12(%edx), %ebx
  107339:	8b 5a 0c             	mov    0xc(%edx),%ebx
	movl	16(%edx), %ebp
  10733c:	8b 6a 10             	mov    0x10(%edx),%ebp
	movl	20(%edx), %ecx
  10733f:	8b 4a 14             	mov    0x14(%edx),%ecx
	movl	%ecx, 0(%esp)
  107342:	89 0c 24             	mov    %ecx,(%esp)

	xor	%eax, %eax
  107345:	31 c0                	xor    %eax,%eax
	ret
  107347:	c3                   	ret    
  107348:	66 90                	xchg   %ax,%ax
  10734a:	66 90                	xchg   %ax,%ax
  10734c:	66 90                	xchg   %ax,%ax
  10734e:	66 90                	xchg   %ax,%ax

00107350 <kctx_new>:
 * Don't forget the stack is going down from high address to low.
 * We do not care about the rest of states when a new thread starts.
 * The function returns the child thread (process) id.
 */
unsigned int kctx_new(void *entry, unsigned int id, unsigned int quota)
{
  107350:	55                   	push   %ebp
  107351:	57                   	push   %edi
  107352:	56                   	push   %esi
    unsigned int pid = NUM_IDS;
  107353:	be 40 00 00 00       	mov    $0x40,%esi
{
  107358:	53                   	push   %ebx
  107359:	e8 2b 90 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10735e:	81 c3 a2 cc 00 00    	add    $0xcca2,%ebx
  107364:	83 ec 14             	sub    $0x14,%esp
  107367:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
  10736b:	8b 6c 24 30          	mov    0x30(%esp),%ebp

    if (container_can_consume(id, quota)) {
  10736f:	55                   	push   %ebp
  107370:	57                   	push   %edi
  107371:	e8 8a f6 ff ff       	call   106a00 <container_can_consume>
  107376:	83 c4 10             	add    $0x10,%esp
  107379:	85 c0                	test   %eax,%eax
  10737b:	75 13                	jne    107390 <kctx_new+0x40>
            kctx_set_eip(pid, entry);
        }
    }

    return pid;
}
  10737d:	83 c4 0c             	add    $0xc,%esp
  107380:	89 f0                	mov    %esi,%eax
  107382:	5b                   	pop    %ebx
  107383:	5e                   	pop    %esi
  107384:	5f                   	pop    %edi
  107385:	5d                   	pop    %ebp
  107386:	c3                   	ret    
  107387:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10738e:	66 90                	xchg   %ax,%ax
        pid = alloc_mem_quota(id, quota);
  107390:	83 ec 08             	sub    $0x8,%esp
  107393:	55                   	push   %ebp
  107394:	57                   	push   %edi
  107395:	e8 d6 fe ff ff       	call   107270 <alloc_mem_quota>
        if (pid != NUM_IDS) {
  10739a:	83 c4 10             	add    $0x10,%esp
        pid = alloc_mem_quota(id, quota);
  10739d:	89 c6                	mov    %eax,%esi
        if (pid != NUM_IDS) {
  10739f:	83 f8 40             	cmp    $0x40,%eax
  1073a2:	74 d9                	je     10737d <kctx_new+0x2d>
            kctx_set_esp(pid, proc_kstack[pid].kstack_hi);
  1073a4:	8d 40 01             	lea    0x1(%eax),%eax
  1073a7:	83 ec 08             	sub    $0x8,%esp
  1073aa:	c1 e0 0c             	shl    $0xc,%eax
  1073ad:	81 c0 00 00 15 00    	add    $0x150000,%eax
  1073b3:	50                   	push   %eax
  1073b4:	56                   	push   %esi
  1073b5:	e8 e6 fe ff ff       	call   1072a0 <kctx_set_esp>
            kctx_set_eip(pid, entry);
  1073ba:	58                   	pop    %eax
  1073bb:	5a                   	pop    %edx
  1073bc:	ff 74 24 28          	push   0x28(%esp)
  1073c0:	56                   	push   %esi
  1073c1:	e8 fa fe ff ff       	call   1072c0 <kctx_set_eip>
  1073c6:	83 c4 10             	add    $0x10,%esp
}
  1073c9:	89 f0                	mov    %esi,%eax
  1073cb:	83 c4 0c             	add    $0xc,%esp
  1073ce:	5b                   	pop    %ebx
  1073cf:	5e                   	pop    %esi
  1073d0:	5f                   	pop    %edi
  1073d1:	5d                   	pop    %ebp
  1073d2:	c3                   	ret    
  1073d3:	66 90                	xchg   %ax,%ax
  1073d5:	66 90                	xchg   %ax,%ax
  1073d7:	66 90                	xchg   %ax,%ax
  1073d9:	66 90                	xchg   %ax,%ax
  1073db:	66 90                	xchg   %ax,%ax
  1073dd:	66 90                	xchg   %ax,%ax
  1073df:	90                   	nop

001073e0 <tcb_get_state>:

struct TCB TCBPool[NUM_IDS];

unsigned int tcb_get_state(unsigned int pid)
{
    return TCBPool[pid].state;
  1073e0:	e8 a0 8f ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  1073e5:	81 c2 1b cc 00 00    	add    $0xcc1b,%edx
  1073eb:	6b 44 24 04 58       	imul   $0x58,0x4(%esp),%eax
  1073f0:	8b 84 02 00 56 cc 00 	mov    0xcc5600(%edx,%eax,1),%eax
}
  1073f7:	c3                   	ret    
  1073f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1073ff:	90                   	nop

00107400 <tcb_set_state>:

void tcb_set_state(unsigned int pid, unsigned int state)
{
    TCBPool[pid].state = state;
  107400:	e8 80 8f ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  107405:	81 c2 fb cb 00 00    	add    $0xcbfb,%edx
  10740b:	6b 44 24 04 58       	imul   $0x58,0x4(%esp),%eax
  107410:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  107414:	89 8c 02 00 56 cc 00 	mov    %ecx,0xcc5600(%edx,%eax,1)
}
  10741b:	c3                   	ret    
  10741c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107420 <tcb_get_cpu>:

unsigned int tcb_get_cpu(unsigned int pid)
{
    return TCBPool[pid].cpuid;
  107420:	e8 60 8f ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  107425:	81 c2 db cb 00 00    	add    $0xcbdb,%edx
  10742b:	6b 44 24 04 58       	imul   $0x58,0x4(%esp),%eax
  107430:	8b 84 02 04 56 cc 00 	mov    0xcc5604(%edx,%eax,1),%eax
}
  107437:	c3                   	ret    
  107438:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10743f:	90                   	nop

00107440 <tcb_set_cpu>:

void tcb_set_cpu(unsigned int pid, unsigned int cpu)
{
    TCBPool[pid].cpuid = cpu;
  107440:	e8 40 8f ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  107445:	81 c2 bb cb 00 00    	add    $0xcbbb,%edx
  10744b:	6b 44 24 04 58       	imul   $0x58,0x4(%esp),%eax
  107450:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  107454:	89 8c 02 04 56 cc 00 	mov    %ecx,0xcc5604(%edx,%eax,1)
}
  10745b:	c3                   	ret    
  10745c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107460 <tcb_get_prev>:

unsigned int tcb_get_prev(unsigned int pid)
{
    return TCBPool[pid].prev;
  107460:	e8 20 8f ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  107465:	81 c2 9b cb 00 00    	add    $0xcb9b,%edx
  10746b:	6b 44 24 04 58       	imul   $0x58,0x4(%esp),%eax
  107470:	8b 84 02 08 56 cc 00 	mov    0xcc5608(%edx,%eax,1),%eax
}
  107477:	c3                   	ret    
  107478:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10747f:	90                   	nop

00107480 <tcb_set_prev>:

void tcb_set_prev(unsigned int pid, unsigned int prev_pid)
{
    TCBPool[pid].prev = prev_pid;
  107480:	e8 00 8f ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  107485:	81 c2 7b cb 00 00    	add    $0xcb7b,%edx
  10748b:	6b 44 24 04 58       	imul   $0x58,0x4(%esp),%eax
  107490:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  107494:	89 8c 02 08 56 cc 00 	mov    %ecx,0xcc5608(%edx,%eax,1)
}
  10749b:	c3                   	ret    
  10749c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001074a0 <tcb_get_next>:

unsigned int tcb_get_next(unsigned int pid)
{
    return TCBPool[pid].next;
  1074a0:	e8 e0 8e ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  1074a5:	81 c2 5b cb 00 00    	add    $0xcb5b,%edx
  1074ab:	6b 44 24 04 58       	imul   $0x58,0x4(%esp),%eax
  1074b0:	8b 84 02 0c 56 cc 00 	mov    0xcc560c(%edx,%eax,1),%eax
}
  1074b7:	c3                   	ret    
  1074b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1074bf:	90                   	nop

001074c0 <tcb_set_next>:

void tcb_set_next(unsigned int pid, unsigned int next_pid)
{
    TCBPool[pid].next = next_pid;
  1074c0:	e8 c0 8e ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  1074c5:	81 c2 3b cb 00 00    	add    $0xcb3b,%edx
  1074cb:	6b 44 24 04 58       	imul   $0x58,0x4(%esp),%eax
  1074d0:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  1074d4:	89 8c 02 0c 56 cc 00 	mov    %ecx,0xcc560c(%edx,%eax,1)
}
  1074db:	c3                   	ret    
  1074dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001074e0 <tcb_init_at_id>:

void tcb_init_at_id(unsigned int pid)
{
  1074e0:	57                   	push   %edi
    TCBPool[pid].state = TSTATE_DEAD;
  1074e1:	8d 3d 00 56 cc 00    	lea    0xcc5600,%edi
{
  1074e7:	56                   	push   %esi
  1074e8:	53                   	push   %ebx
    TCBPool[pid].state = TSTATE_DEAD;
  1074e9:	6b 44 24 10 58       	imul   $0x58,0x10(%esp),%eax
  1074ee:	e8 96 8e ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1074f3:	81 c3 0d cb 00 00    	add    $0xcb0d,%ebx
    TCBPool[pid].cpuid = NUM_CPUS;
    TCBPool[pid].prev = NUM_IDS;
    TCBPool[pid].next = NUM_IDS;
    TCBPool[pid].channel = 0;
    memzero(TCBPool[pid].openfiles, sizeof *TCBPool[pid].openfiles);
  1074f9:	83 ec 08             	sub    $0x8,%esp
    TCBPool[pid].state = TSTATE_DEAD;
  1074fc:	8d 14 3b             	lea    (%ebx,%edi,1),%edx
    TCBPool[pid].cpuid = NUM_CPUS;
  1074ff:	8d 34 18             	lea    (%eax,%ebx,1),%esi
  107502:	01 fe                	add    %edi,%esi
    TCBPool[pid].state = TSTATE_DEAD;
  107504:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
    memzero(TCBPool[pid].openfiles, sizeof *TCBPool[pid].openfiles);
  107507:	8d 44 02 14          	lea    0x14(%edx,%eax,1),%eax
    TCBPool[pid].state = TSTATE_DEAD;
  10750b:	c7 01 03 00 00 00    	movl   $0x3,(%ecx)
    TCBPool[pid].cpuid = NUM_CPUS;
  107511:	c7 46 04 08 00 00 00 	movl   $0x8,0x4(%esi)
    TCBPool[pid].prev = NUM_IDS;
  107518:	c7 46 08 40 00 00 00 	movl   $0x40,0x8(%esi)
    TCBPool[pid].next = NUM_IDS;
  10751f:	c7 46 0c 40 00 00 00 	movl   $0x40,0xc(%esi)
    TCBPool[pid].channel = 0;
  107526:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
    memzero(TCBPool[pid].openfiles, sizeof *TCBPool[pid].openfiles);
  10752d:	6a 04                	push   $0x4
  10752f:	50                   	push   %eax
  107530:	e8 fb cf ff ff       	call   104530 <memzero>
    TCBPool[pid].cwd = namei("/");
  107535:	8d 83 7d 87 ff ff    	lea    -0x7883(%ebx),%eax
  10753b:	89 04 24             	mov    %eax,(%esp)
  10753e:	e8 7d 28 00 00       	call   109dc0 <namei>
}
  107543:	83 c4 10             	add    $0x10,%esp
    TCBPool[pid].cwd = namei("/");
  107546:	89 46 54             	mov    %eax,0x54(%esi)
}
  107549:	5b                   	pop    %ebx
  10754a:	5e                   	pop    %esi
  10754b:	5f                   	pop    %edi
  10754c:	c3                   	ret    
  10754d:	8d 76 00             	lea    0x0(%esi),%esi

00107550 <tcb_get_chan>:

void *tcb_get_chan(unsigned int pid)
{
    return TCBPool[pid].channel;
  107550:	e8 30 8e ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  107555:	81 c2 ab ca 00 00    	add    $0xcaab,%edx
  10755b:	6b 44 24 04 58       	imul   $0x58,0x4(%esp),%eax
  107560:	8b 84 02 10 56 cc 00 	mov    0xcc5610(%edx,%eax,1),%eax
}
  107567:	c3                   	ret    
  107568:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10756f:	90                   	nop

00107570 <tcb_set_chan>:

void tcb_set_chan(unsigned int pid, void *chan)
{
    TCBPool[pid].channel = chan;
  107570:	e8 10 8e ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  107575:	81 c2 8b ca 00 00    	add    $0xca8b,%edx
  10757b:	6b 44 24 04 58       	imul   $0x58,0x4(%esp),%eax
  107580:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  107584:	89 8c 02 10 56 cc 00 	mov    %ecx,0xcc5610(%edx,%eax,1)
}
  10758b:	c3                   	ret    
  10758c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107590 <tcb_get_openfiles>:

struct file **tcb_get_openfiles(unsigned int pid)
{
    return TCBPool[pid].openfiles;
  107590:	e8 f0 8d ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  107595:	81 c2 6b ca 00 00    	add    $0xca6b,%edx
  10759b:	6b 44 24 04 58       	imul   $0x58,0x4(%esp),%eax
  1075a0:	8d 84 02 14 56 cc 00 	lea    0xcc5614(%edx,%eax,1),%eax
}
  1075a7:	c3                   	ret    
  1075a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1075af:	90                   	nop

001075b0 <tcb_set_openfiles>:

void tcb_set_openfiles(unsigned int pid, int fd, struct file *f)
{
    TCBPool[pid].openfiles[fd] = f;
  1075b0:	e8 d0 8d ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  1075b5:	81 c2 4b ca 00 00    	add    $0xca4b,%edx
  1075bb:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  1075bf:	6b 44 24 04 16       	imul   $0x16,0x4(%esp),%eax
  1075c4:	03 44 24 08          	add    0x8(%esp),%eax
  1075c8:	89 8c 82 14 56 cc 00 	mov    %ecx,0xcc5614(%edx,%eax,4)
}
  1075cf:	c3                   	ret    

001075d0 <tcb_get_cwd>:

struct inode *tcb_get_cwd(unsigned int pid)
{
    return TCBPool[pid].cwd;
  1075d0:	e8 b0 8d ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  1075d5:	81 c2 2b ca 00 00    	add    $0xca2b,%edx
  1075db:	6b 44 24 04 58       	imul   $0x58,0x4(%esp),%eax
  1075e0:	8b 84 02 54 56 cc 00 	mov    0xcc5654(%edx,%eax,1),%eax
}
  1075e7:	c3                   	ret    
  1075e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1075ef:	90                   	nop

001075f0 <tcb_set_cwd>:

void tcb_set_cwd(unsigned int pid, struct inode *d)
{
    TCBPool[pid].cwd = d;
  1075f0:	e8 90 8d ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  1075f5:	81 c2 0b ca 00 00    	add    $0xca0b,%edx
  1075fb:	6b 44 24 04 58       	imul   $0x58,0x4(%esp),%eax
  107600:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  107604:	89 8c 02 54 56 cc 00 	mov    %ecx,0xcc5654(%edx,%eax,1)
}
  10760b:	c3                   	ret    
  10760c:	66 90                	xchg   %ax,%ax
  10760e:	66 90                	xchg   %ax,%ax

00107610 <tcb_init>:
/**
 * Initializes the TCB for all NUM_IDS threads with the state TSTATE_DEAD,
 * and with two indices being NUM_IDS (which represents NULL).
 */
void tcb_init(unsigned int mbi_addr)
{
  107610:	56                   	push   %esi
    unsigned int pid = 0;
  107611:	31 f6                	xor    %esi,%esi
{
  107613:	53                   	push   %ebx
  107614:	e8 70 8d ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107619:	81 c3 e7 c9 00 00    	add    $0xc9e7,%ebx
  10761f:	83 ec 10             	sub    $0x10,%esp
    paging_init(mbi_addr);
  107622:	ff 74 24 1c          	push   0x1c(%esp)
  107626:	e8 a5 fb ff ff       	call   1071d0 <paging_init>
  10762b:	83 c4 10             	add    $0x10,%esp
  10762e:	66 90                	xchg   %ax,%ax

    while (pid < NUM_IDS) {
        tcb_init_at_id(pid);
  107630:	83 ec 0c             	sub    $0xc,%esp
  107633:	56                   	push   %esi
        pid++;
  107634:	83 c6 01             	add    $0x1,%esi
        tcb_init_at_id(pid);
  107637:	e8 a4 fe ff ff       	call   1074e0 <tcb_init_at_id>
    while (pid < NUM_IDS) {
  10763c:	83 c4 10             	add    $0x10,%esp
  10763f:	83 fe 40             	cmp    $0x40,%esi
  107642:	75 ec                	jne    107630 <tcb_init+0x20>
    }
}
  107644:	83 c4 04             	add    $0x4,%esp
  107647:	5b                   	pop    %ebx
  107648:	5e                   	pop    %esi
  107649:	c3                   	ret    
  10764a:	66 90                	xchg   %ax,%ax
  10764c:	66 90                	xchg   %ax,%ax
  10764e:	66 90                	xchg   %ax,%ax

00107650 <tqueue_get_head>:
 */
struct TQueue TQueuePool[NUM_IDS + NUM_CPUS];

unsigned int tqueue_get_head(unsigned int chid)
{
    return TQueuePool[chid].head;
  107650:	e8 2c 8d ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  107655:	05 ab c9 00 00       	add    $0xc9ab,%eax
  10765a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10765e:	8b 84 d0 60 6c cc 00 	mov    0xcc6c60(%eax,%edx,8),%eax
}
  107665:	c3                   	ret    
  107666:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10766d:	8d 76 00             	lea    0x0(%esi),%esi

00107670 <tqueue_set_head>:

void tqueue_set_head(unsigned int chid, unsigned int head)
{
    TQueuePool[chid].head = head;
  107670:	e8 0c 8d ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  107675:	05 8b c9 00 00       	add    $0xc98b,%eax
  10767a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10767e:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  107682:	89 8c d0 60 6c cc 00 	mov    %ecx,0xcc6c60(%eax,%edx,8)
}
  107689:	c3                   	ret    
  10768a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107690 <tqueue_get_tail>:

unsigned int tqueue_get_tail(unsigned int chid)
{
    return TQueuePool[chid].tail;
  107690:	e8 ec 8c ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  107695:	05 6b c9 00 00       	add    $0xc96b,%eax
  10769a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10769e:	8b 84 d0 64 6c cc 00 	mov    0xcc6c64(%eax,%edx,8),%eax
}
  1076a5:	c3                   	ret    
  1076a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1076ad:	8d 76 00             	lea    0x0(%esi),%esi

001076b0 <tqueue_set_tail>:

void tqueue_set_tail(unsigned int chid, unsigned int tail)
{
    TQueuePool[chid].tail = tail;
  1076b0:	e8 cc 8c ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  1076b5:	05 4b c9 00 00       	add    $0xc94b,%eax
  1076ba:	8b 54 24 04          	mov    0x4(%esp),%edx
  1076be:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  1076c2:	89 8c d0 64 6c cc 00 	mov    %ecx,0xcc6c64(%eax,%edx,8)
}
  1076c9:	c3                   	ret    
  1076ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001076d0 <tqueue_init_at_id>:

void tqueue_init_at_id(unsigned int chid)
{
    TQueuePool[chid].head = NUM_IDS;
  1076d0:	e8 ac 8c ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  1076d5:	05 2b c9 00 00       	add    $0xc92b,%eax
{
  1076da:	8b 54 24 04          	mov    0x4(%esp),%edx
    TQueuePool[chid].head = NUM_IDS;
  1076de:	c7 84 d0 60 6c cc 00 	movl   $0x40,0xcc6c60(%eax,%edx,8)
  1076e5:	40 00 00 00 
    TQueuePool[chid].tail = NUM_IDS;
  1076e9:	c7 84 d0 64 6c cc 00 	movl   $0x40,0xcc6c64(%eax,%edx,8)
  1076f0:	40 00 00 00 
}
  1076f4:	c3                   	ret    
  1076f5:	66 90                	xchg   %ax,%ax
  1076f7:	66 90                	xchg   %ax,%ax
  1076f9:	66 90                	xchg   %ax,%ax
  1076fb:	66 90                	xchg   %ax,%ax
  1076fd:	66 90                	xchg   %ax,%ax
  1076ff:	90                   	nop

00107700 <tqueue_init>:

/**
 * Initializes all the thread queues with tqueue_init_at_id.
 */
void tqueue_init(unsigned int mbi_addr)
{
  107700:	56                   	push   %esi
    unsigned int cpu_idx, chid;
    tcb_init(mbi_addr);

    chid = 0;
  107701:	31 f6                	xor    %esi,%esi
{
  107703:	53                   	push   %ebx
  107704:	e8 80 8c ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107709:	81 c3 f7 c8 00 00    	add    $0xc8f7,%ebx
  10770f:	83 ec 10             	sub    $0x10,%esp
    tcb_init(mbi_addr);
  107712:	ff 74 24 1c          	push   0x1c(%esp)
  107716:	e8 f5 fe ff ff       	call   107610 <tcb_init>
  10771b:	83 c4 10             	add    $0x10,%esp
  10771e:	66 90                	xchg   %ax,%ax
    while (chid < NUM_IDS + NUM_CPUS) {
        tqueue_init_at_id(chid);
  107720:	83 ec 0c             	sub    $0xc,%esp
  107723:	56                   	push   %esi
        chid++;
  107724:	83 c6 01             	add    $0x1,%esi
        tqueue_init_at_id(chid);
  107727:	e8 a4 ff ff ff       	call   1076d0 <tqueue_init_at_id>
    while (chid < NUM_IDS + NUM_CPUS) {
  10772c:	83 c4 10             	add    $0x10,%esp
  10772f:	83 fe 48             	cmp    $0x48,%esi
  107732:	75 ec                	jne    107720 <tqueue_init+0x20>
    }
}
  107734:	83 c4 04             	add    $0x4,%esp
  107737:	5b                   	pop    %ebx
  107738:	5e                   	pop    %esi
  107739:	c3                   	ret    
  10773a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107740 <tqueue_enqueue>:
 * Recall that the doubly linked list is index based.
 * So you only need to insert the index.
 * Hint: there are multiple cases in this function.
 */
void tqueue_enqueue(unsigned int chid, unsigned int pid)
{
  107740:	55                   	push   %ebp
  107741:	57                   	push   %edi
  107742:	56                   	push   %esi
  107743:	53                   	push   %ebx
  107744:	e8 40 8c ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107749:	81 c3 b7 c8 00 00    	add    $0xc8b7,%ebx
  10774f:	83 ec 18             	sub    $0x18,%esp
  107752:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
  107756:	8b 74 24 30          	mov    0x30(%esp),%esi
    unsigned int tail = tqueue_get_tail(chid);
  10775a:	57                   	push   %edi
  10775b:	e8 30 ff ff ff       	call   107690 <tqueue_get_tail>

    if (tail == NUM_IDS) {
  107760:	83 c4 10             	add    $0x10,%esp
  107763:	83 f8 40             	cmp    $0x40,%eax
  107766:	74 38                	je     1077a0 <tqueue_enqueue+0x60>
        tcb_set_prev(pid, NUM_IDS);
        tcb_set_next(pid, NUM_IDS);
        tqueue_set_head(chid, pid);
        tqueue_set_tail(chid, pid);
    } else {
        tcb_set_next(tail, pid);
  107768:	83 ec 08             	sub    $0x8,%esp
  10776b:	89 c5                	mov    %eax,%ebp
  10776d:	56                   	push   %esi
  10776e:	50                   	push   %eax
  10776f:	e8 4c fd ff ff       	call   1074c0 <tcb_set_next>
        tcb_set_prev(pid, tail);
  107774:	59                   	pop    %ecx
  107775:	58                   	pop    %eax
  107776:	55                   	push   %ebp
  107777:	56                   	push   %esi
  107778:	e8 03 fd ff ff       	call   107480 <tcb_set_prev>
        tcb_set_next(pid, NUM_IDS);
  10777d:	58                   	pop    %eax
  10777e:	5a                   	pop    %edx
  10777f:	6a 40                	push   $0x40
  107781:	56                   	push   %esi
  107782:	e8 39 fd ff ff       	call   1074c0 <tcb_set_next>
        tqueue_set_tail(chid, pid);
  107787:	58                   	pop    %eax
  107788:	5a                   	pop    %edx
  107789:	56                   	push   %esi
  10778a:	57                   	push   %edi
  10778b:	e8 20 ff ff ff       	call   1076b0 <tqueue_set_tail>
  107790:	83 c4 10             	add    $0x10,%esp
    }
}
  107793:	83 c4 0c             	add    $0xc,%esp
  107796:	5b                   	pop    %ebx
  107797:	5e                   	pop    %esi
  107798:	5f                   	pop    %edi
  107799:	5d                   	pop    %ebp
  10779a:	c3                   	ret    
  10779b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10779f:	90                   	nop
        tcb_set_prev(pid, NUM_IDS);
  1077a0:	83 ec 08             	sub    $0x8,%esp
  1077a3:	6a 40                	push   $0x40
  1077a5:	56                   	push   %esi
  1077a6:	e8 d5 fc ff ff       	call   107480 <tcb_set_prev>
        tcb_set_next(pid, NUM_IDS);
  1077ab:	59                   	pop    %ecx
  1077ac:	5d                   	pop    %ebp
  1077ad:	6a 40                	push   $0x40
  1077af:	56                   	push   %esi
  1077b0:	e8 0b fd ff ff       	call   1074c0 <tcb_set_next>
        tqueue_set_head(chid, pid);
  1077b5:	58                   	pop    %eax
  1077b6:	5a                   	pop    %edx
  1077b7:	56                   	push   %esi
  1077b8:	57                   	push   %edi
  1077b9:	e8 b2 fe ff ff       	call   107670 <tqueue_set_head>
        tqueue_set_tail(chid, pid);
  1077be:	eb c7                	jmp    107787 <tqueue_enqueue+0x47>

001077c0 <tqueue_dequeue>:
 * Reverse action of tqueue_enqueue, i.e. pops a TCB from the head of the specified queue.
 * It returns the popped thread's id, or NUM_IDS if the queue is empty.
 * Hint: there are multiple cases in this function.
 */
unsigned int tqueue_dequeue(unsigned int chid)
{
  1077c0:	55                   	push   %ebp
  1077c1:	57                   	push   %edi
  1077c2:	56                   	push   %esi
  1077c3:	53                   	push   %ebx
  1077c4:	e8 c0 8b ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1077c9:	81 c3 37 c8 00 00    	add    $0xc837,%ebx
  1077cf:	83 ec 18             	sub    $0x18,%esp
  1077d2:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
    unsigned int head, next, pid;

    pid = NUM_IDS;
    head = tqueue_get_head(chid);
  1077d6:	57                   	push   %edi
  1077d7:	e8 74 fe ff ff       	call   107650 <tqueue_get_head>

    if (head != NUM_IDS) {
  1077dc:	83 c4 10             	add    $0x10,%esp
    head = tqueue_get_head(chid);
  1077df:	89 c6                	mov    %eax,%esi
    if (head != NUM_IDS) {
  1077e1:	83 f8 40             	cmp    $0x40,%eax
  1077e4:	74 42                	je     107828 <tqueue_dequeue+0x68>
        pid = head;
        next = tcb_get_next(head);
  1077e6:	83 ec 0c             	sub    $0xc,%esp
  1077e9:	50                   	push   %eax
  1077ea:	e8 b1 fc ff ff       	call   1074a0 <tcb_get_next>

        if (next == NUM_IDS) {
  1077ef:	83 c4 10             	add    $0x10,%esp
        next = tcb_get_next(head);
  1077f2:	89 c5                	mov    %eax,%ebp
        if (next == NUM_IDS) {
  1077f4:	83 f8 40             	cmp    $0x40,%eax
  1077f7:	74 3f                	je     107838 <tqueue_dequeue+0x78>
            tqueue_set_head(chid, NUM_IDS);
            tqueue_set_tail(chid, NUM_IDS);
        } else {
            tcb_set_prev(next, NUM_IDS);
  1077f9:	83 ec 08             	sub    $0x8,%esp
  1077fc:	6a 40                	push   $0x40
  1077fe:	50                   	push   %eax
  1077ff:	e8 7c fc ff ff       	call   107480 <tcb_set_prev>
            tqueue_set_head(chid, next);
  107804:	59                   	pop    %ecx
  107805:	58                   	pop    %eax
  107806:	55                   	push   %ebp
  107807:	57                   	push   %edi
  107808:	e8 63 fe ff ff       	call   107670 <tqueue_set_head>
  10780d:	83 c4 10             	add    $0x10,%esp
        }
        tcb_set_prev(pid, NUM_IDS);
  107810:	83 ec 08             	sub    $0x8,%esp
  107813:	6a 40                	push   $0x40
  107815:	56                   	push   %esi
  107816:	e8 65 fc ff ff       	call   107480 <tcb_set_prev>
        tcb_set_next(pid, NUM_IDS);
  10781b:	58                   	pop    %eax
  10781c:	5a                   	pop    %edx
  10781d:	6a 40                	push   $0x40
  10781f:	56                   	push   %esi
  107820:	e8 9b fc ff ff       	call   1074c0 <tcb_set_next>
  107825:	83 c4 10             	add    $0x10,%esp
    }

    return pid;
}
  107828:	83 c4 0c             	add    $0xc,%esp
  10782b:	89 f0                	mov    %esi,%eax
  10782d:	5b                   	pop    %ebx
  10782e:	5e                   	pop    %esi
  10782f:	5f                   	pop    %edi
  107830:	5d                   	pop    %ebp
  107831:	c3                   	ret    
  107832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            tqueue_set_head(chid, NUM_IDS);
  107838:	83 ec 08             	sub    $0x8,%esp
  10783b:	6a 40                	push   $0x40
  10783d:	57                   	push   %edi
  10783e:	e8 2d fe ff ff       	call   107670 <tqueue_set_head>
            tqueue_set_tail(chid, NUM_IDS);
  107843:	58                   	pop    %eax
  107844:	5a                   	pop    %edx
  107845:	6a 40                	push   $0x40
  107847:	57                   	push   %edi
  107848:	e8 63 fe ff ff       	call   1076b0 <tqueue_set_tail>
  10784d:	83 c4 10             	add    $0x10,%esp
  107850:	eb be                	jmp    107810 <tqueue_dequeue+0x50>
  107852:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00107860 <tqueue_remove>:
/**
 * Removes the TCB #pid from the queue #chid.
 * Hint: there are many cases in this function.
 */
void tqueue_remove(unsigned int chid, unsigned int pid)
{
  107860:	55                   	push   %ebp
  107861:	57                   	push   %edi
  107862:	56                   	push   %esi
  107863:	53                   	push   %ebx
  107864:	e8 20 8b ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107869:	81 c3 97 c7 00 00    	add    $0xc797,%ebx
  10786f:	83 ec 18             	sub    $0x18,%esp
  107872:	8b 7c 24 30          	mov    0x30(%esp),%edi
    unsigned int prev, next;

    prev = tcb_get_prev(pid);
  107876:	57                   	push   %edi
  107877:	e8 e4 fb ff ff       	call   107460 <tcb_get_prev>
    next = tcb_get_next(pid);
  10787c:	89 3c 24             	mov    %edi,(%esp)
    prev = tcb_get_prev(pid);
  10787f:	89 c5                	mov    %eax,%ebp
    next = tcb_get_next(pid);
  107881:	e8 1a fc ff ff       	call   1074a0 <tcb_get_next>

    if (prev == NUM_IDS) {
  107886:	83 c4 10             	add    $0x10,%esp
    next = tcb_get_next(pid);
  107889:	89 c6                	mov    %eax,%esi
    if (prev == NUM_IDS) {
  10788b:	83 fd 40             	cmp    $0x40,%ebp
  10788e:	74 50                	je     1078e0 <tqueue_remove+0x80>
        } else {
            tcb_set_prev(next, NUM_IDS);
            tqueue_set_head(chid, next);
        }
    } else {
        if (next == NUM_IDS) {
  107890:	83 f8 40             	cmp    $0x40,%eax
  107893:	74 73                	je     107908 <tqueue_remove+0xa8>
            tcb_set_next(prev, NUM_IDS);
            tqueue_set_tail(chid, prev);
        } else {
            if (prev != next)
  107895:	39 c5                	cmp    %eax,%ebp
  107897:	75 2f                	jne    1078c8 <tqueue_remove+0x68>
                tcb_set_next(prev, next);
            tcb_set_prev(next, prev);
  107899:	83 ec 08             	sub    $0x8,%esp
  10789c:	55                   	push   %ebp
  10789d:	56                   	push   %esi
  10789e:	e8 dd fb ff ff       	call   107480 <tcb_set_prev>
  1078a3:	83 c4 10             	add    $0x10,%esp
        }
    }
    tcb_set_prev(pid, NUM_IDS);
  1078a6:	83 ec 08             	sub    $0x8,%esp
  1078a9:	6a 40                	push   $0x40
  1078ab:	57                   	push   %edi
  1078ac:	e8 cf fb ff ff       	call   107480 <tcb_set_prev>
    tcb_set_next(pid, NUM_IDS);
  1078b1:	58                   	pop    %eax
  1078b2:	5a                   	pop    %edx
  1078b3:	6a 40                	push   $0x40
  1078b5:	57                   	push   %edi
  1078b6:	e8 05 fc ff ff       	call   1074c0 <tcb_set_next>
}
  1078bb:	83 c4 1c             	add    $0x1c,%esp
  1078be:	5b                   	pop    %ebx
  1078bf:	5e                   	pop    %esi
  1078c0:	5f                   	pop    %edi
  1078c1:	5d                   	pop    %ebp
  1078c2:	c3                   	ret    
  1078c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1078c7:	90                   	nop
                tcb_set_next(prev, next);
  1078c8:	83 ec 08             	sub    $0x8,%esp
  1078cb:	50                   	push   %eax
  1078cc:	55                   	push   %ebp
  1078cd:	e8 ee fb ff ff       	call   1074c0 <tcb_set_next>
  1078d2:	83 c4 10             	add    $0x10,%esp
  1078d5:	eb c2                	jmp    107899 <tqueue_remove+0x39>
  1078d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1078de:	66 90                	xchg   %ax,%ax
        if (next == NUM_IDS) {
  1078e0:	83 f8 40             	cmp    $0x40,%eax
  1078e3:	74 43                	je     107928 <tqueue_remove+0xc8>
            tcb_set_prev(next, NUM_IDS);
  1078e5:	83 ec 08             	sub    $0x8,%esp
  1078e8:	6a 40                	push   $0x40
  1078ea:	50                   	push   %eax
  1078eb:	e8 90 fb ff ff       	call   107480 <tcb_set_prev>
            tqueue_set_head(chid, next);
  1078f0:	5d                   	pop    %ebp
  1078f1:	58                   	pop    %eax
  1078f2:	56                   	push   %esi
  1078f3:	ff 74 24 2c          	push   0x2c(%esp)
  1078f7:	e8 74 fd ff ff       	call   107670 <tqueue_set_head>
  1078fc:	83 c4 10             	add    $0x10,%esp
  1078ff:	eb a5                	jmp    1078a6 <tqueue_remove+0x46>
  107901:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            tcb_set_next(prev, NUM_IDS);
  107908:	83 ec 08             	sub    $0x8,%esp
  10790b:	6a 40                	push   $0x40
  10790d:	55                   	push   %ebp
  10790e:	e8 ad fb ff ff       	call   1074c0 <tcb_set_next>
            tqueue_set_tail(chid, prev);
  107913:	59                   	pop    %ecx
  107914:	5e                   	pop    %esi
  107915:	55                   	push   %ebp
  107916:	ff 74 24 2c          	push   0x2c(%esp)
  10791a:	e8 91 fd ff ff       	call   1076b0 <tqueue_set_tail>
  10791f:	83 c4 10             	add    $0x10,%esp
  107922:	eb 82                	jmp    1078a6 <tqueue_remove+0x46>
  107924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            tqueue_set_head(chid, NUM_IDS);
  107928:	83 ec 08             	sub    $0x8,%esp
  10792b:	6a 40                	push   $0x40
  10792d:	ff 74 24 2c          	push   0x2c(%esp)
  107931:	e8 3a fd ff ff       	call   107670 <tqueue_set_head>
            tqueue_set_tail(chid, NUM_IDS);
  107936:	58                   	pop    %eax
  107937:	5a                   	pop    %edx
  107938:	6a 40                	push   $0x40
  10793a:	ff 74 24 2c          	push   0x2c(%esp)
  10793e:	e8 6d fd ff ff       	call   1076b0 <tqueue_set_tail>
  107943:	83 c4 10             	add    $0x10,%esp
  107946:	e9 5b ff ff ff       	jmp    1078a6 <tqueue_remove+0x46>
  10794b:	66 90                	xchg   %ax,%ax
  10794d:	66 90                	xchg   %ax,%ax
  10794f:	90                   	nop

00107950 <get_curid>:
#include <pcpu/PCPUIntro/export.h>

unsigned int CURID[NUM_CPUS];

unsigned int get_curid(void)
{
  107950:	53                   	push   %ebx
  107951:	e8 33 8a ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107956:	81 c3 aa c6 00 00    	add    $0xc6aa,%ebx
  10795c:	83 ec 08             	sub    $0x8,%esp
    return CURID[get_pcpu_idx()];
  10795f:	e8 1c e8 ff ff       	call   106180 <get_pcpu_idx>
  107964:	8b 84 83 a0 6e cc 00 	mov    0xcc6ea0(%ebx,%eax,4),%eax
}
  10796b:	83 c4 08             	add    $0x8,%esp
  10796e:	5b                   	pop    %ebx
  10796f:	c3                   	ret    

00107970 <set_curid>:

void set_curid(unsigned int curid)
{
  107970:	53                   	push   %ebx
  107971:	e8 13 8a ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107976:	81 c3 8a c6 00 00    	add    $0xc68a,%ebx
  10797c:	83 ec 08             	sub    $0x8,%esp
    CURID[get_pcpu_idx()] = curid;
  10797f:	e8 fc e7 ff ff       	call   106180 <get_pcpu_idx>
  107984:	8b 54 24 10          	mov    0x10(%esp),%edx
  107988:	89 94 83 a0 6e cc 00 	mov    %edx,0xcc6ea0(%ebx,%eax,4)
}
  10798f:	83 c4 08             	add    $0x8,%esp
  107992:	5b                   	pop    %ebx
  107993:	c3                   	ret    
  107994:	66 90                	xchg   %ax,%ax
  107996:	66 90                	xchg   %ax,%ax
  107998:	66 90                	xchg   %ax,%ax
  10799a:	66 90                	xchg   %ax,%ax
  10799c:	66 90                	xchg   %ax,%ax
  10799e:	66 90                	xchg   %ax,%ax

001079a0 <thread_init>:
static spinlock_t sched_lk;

unsigned int sched_ticks[NUM_CPUS];

void thread_init(unsigned int mbi_addr)
{
  1079a0:	53                   	push   %ebx
  1079a1:	e8 e3 89 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1079a6:	81 c3 5a c6 00 00    	add    $0xc65a,%ebx
  1079ac:	83 ec 14             	sub    $0x14,%esp
    unsigned int i;
    for (i = 0; i < NUM_CPUS; i++) {
        sched_ticks[i] = 0;
  1079af:	c7 83 c0 6e cc 00 00 	movl   $0x0,0xcc6ec0(%ebx)
  1079b6:	00 00 00 
    }

    spinlock_init(&sched_lk);
  1079b9:	8d 83 e0 6e cc 00    	lea    0xcc6ee0(%ebx),%eax
  1079bf:	50                   	push   %eax
        sched_ticks[i] = 0;
  1079c0:	c7 83 c4 6e cc 00 00 	movl   $0x0,0xcc6ec4(%ebx)
  1079c7:	00 00 00 
  1079ca:	c7 83 c8 6e cc 00 00 	movl   $0x0,0xcc6ec8(%ebx)
  1079d1:	00 00 00 
  1079d4:	c7 83 cc 6e cc 00 00 	movl   $0x0,0xcc6ecc(%ebx)
  1079db:	00 00 00 
  1079de:	c7 83 d0 6e cc 00 00 	movl   $0x0,0xcc6ed0(%ebx)
  1079e5:	00 00 00 
  1079e8:	c7 83 d4 6e cc 00 00 	movl   $0x0,0xcc6ed4(%ebx)
  1079ef:	00 00 00 
  1079f2:	c7 83 d8 6e cc 00 00 	movl   $0x0,0xcc6ed8(%ebx)
  1079f9:	00 00 00 
  1079fc:	c7 83 dc 6e cc 00 00 	movl   $0x0,0xcc6edc(%ebx)
  107a03:	00 00 00 
    spinlock_init(&sched_lk);
  107a06:	e8 d5 e3 ff ff       	call   105de0 <spinlock_init>
    tqueue_init(mbi_addr);
  107a0b:	58                   	pop    %eax
  107a0c:	ff 74 24 1c          	push   0x1c(%esp)
  107a10:	e8 eb fc ff ff       	call   107700 <tqueue_init>
    set_curid(0);
  107a15:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  107a1c:	e8 4f ff ff ff       	call   107970 <set_curid>
    tcb_set_state(0, TSTATE_RUN);
  107a21:	5a                   	pop    %edx
  107a22:	59                   	pop    %ecx
  107a23:	6a 01                	push   $0x1
  107a25:	6a 00                	push   $0x0
  107a27:	e8 d4 f9 ff ff       	call   107400 <tcb_set_state>
}
  107a2c:	83 c4 18             	add    $0x18,%esp
  107a2f:	5b                   	pop    %ebx
  107a30:	c3                   	ret    
  107a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107a38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107a3f:	90                   	nop

00107a40 <thread_spawn>:
 * Allocates a new child thread context, sets the state of the new child thread
 * to ready, and pushes it to the ready queue.
 * It returns the child thread id.
 */
unsigned int thread_spawn(void *entry, unsigned int id, unsigned int quota)
{
  107a40:	57                   	push   %edi
  107a41:	56                   	push   %esi
  107a42:	53                   	push   %ebx
  107a43:	e8 41 89 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107a48:	81 c3 b8 c5 00 00    	add    $0xc5b8,%ebx
    unsigned int pid;

    spinlock_acquire(&sched_lk);
  107a4e:	83 ec 0c             	sub    $0xc,%esp
  107a51:	8d bb e0 6e cc 00    	lea    0xcc6ee0(%ebx),%edi
  107a57:	57                   	push   %edi
  107a58:	e8 13 e4 ff ff       	call   105e70 <spinlock_acquire>

    pid = kctx_new(entry, id, quota);
  107a5d:	83 c4 0c             	add    $0xc,%esp
  107a60:	ff 74 24 1c          	push   0x1c(%esp)
  107a64:	ff 74 24 1c          	push   0x1c(%esp)
  107a68:	ff 74 24 1c          	push   0x1c(%esp)
  107a6c:	e8 df f8 ff ff       	call   107350 <kctx_new>
    if (pid != NUM_IDS) {
  107a71:	83 c4 10             	add    $0x10,%esp
    pid = kctx_new(entry, id, quota);
  107a74:	89 c6                	mov    %eax,%esi
    if (pid != NUM_IDS) {
  107a76:	83 f8 40             	cmp    $0x40,%eax
  107a79:	74 18                	je     107a93 <thread_spawn+0x53>
        tcb_set_state(pid, TSTATE_READY);
  107a7b:	83 ec 08             	sub    $0x8,%esp
  107a7e:	6a 00                	push   $0x0
  107a80:	50                   	push   %eax
  107a81:	e8 7a f9 ff ff       	call   107400 <tcb_set_state>
        tqueue_enqueue(NUM_IDS, pid);
  107a86:	58                   	pop    %eax
  107a87:	5a                   	pop    %edx
  107a88:	56                   	push   %esi
  107a89:	6a 40                	push   $0x40
  107a8b:	e8 b0 fc ff ff       	call   107740 <tqueue_enqueue>
  107a90:	83 c4 10             	add    $0x10,%esp
    }

    spinlock_release(&sched_lk);
  107a93:	83 ec 0c             	sub    $0xc,%esp
  107a96:	57                   	push   %edi
  107a97:	e8 54 e4 ff ff       	call   105ef0 <spinlock_release>

    return pid;
  107a9c:	83 c4 10             	add    $0x10,%esp
}
  107a9f:	89 f0                	mov    %esi,%eax
  107aa1:	5b                   	pop    %ebx
  107aa2:	5e                   	pop    %esi
  107aa3:	5f                   	pop    %edi
  107aa4:	c3                   	ret    
  107aa5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107ab0 <thread_yield>:
 * current thread id, and switch to the new kernel context.
 * Hint: If you are the only thread that is ready to run,
 * do you need to switch to yourself?
 */
void thread_yield(void)
{
  107ab0:	55                   	push   %ebp
  107ab1:	57                   	push   %edi
  107ab2:	56                   	push   %esi
  107ab3:	53                   	push   %ebx
  107ab4:	e8 d0 88 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107ab9:	81 c3 47 c5 00 00    	add    $0xc547,%ebx
  107abf:	83 ec 18             	sub    $0x18,%esp
    unsigned int old_cur_pid;
    unsigned int new_cur_pid;

    spinlock_acquire(&sched_lk);
  107ac2:	8d ab e0 6e cc 00    	lea    0xcc6ee0(%ebx),%ebp
  107ac8:	55                   	push   %ebp
  107ac9:	e8 a2 e3 ff ff       	call   105e70 <spinlock_acquire>

    old_cur_pid = get_curid();
  107ace:	e8 7d fe ff ff       	call   107950 <get_curid>
    tcb_set_state(old_cur_pid, TSTATE_READY);
  107ad3:	59                   	pop    %ecx
  107ad4:	5f                   	pop    %edi
  107ad5:	6a 00                	push   $0x0
  107ad7:	50                   	push   %eax
    old_cur_pid = get_curid();
  107ad8:	89 c6                	mov    %eax,%esi
    tcb_set_state(old_cur_pid, TSTATE_READY);
  107ada:	e8 21 f9 ff ff       	call   107400 <tcb_set_state>
    tqueue_enqueue(NUM_IDS, old_cur_pid);
  107adf:	58                   	pop    %eax
  107ae0:	5a                   	pop    %edx
  107ae1:	56                   	push   %esi
  107ae2:	6a 40                	push   $0x40
  107ae4:	e8 57 fc ff ff       	call   107740 <tqueue_enqueue>

    new_cur_pid = tqueue_dequeue(NUM_IDS);
  107ae9:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
  107af0:	e8 cb fc ff ff       	call   1077c0 <tqueue_dequeue>
    tcb_set_state(new_cur_pid, TSTATE_RUN);
  107af5:	59                   	pop    %ecx
  107af6:	5a                   	pop    %edx
  107af7:	6a 01                	push   $0x1
  107af9:	50                   	push   %eax
    new_cur_pid = tqueue_dequeue(NUM_IDS);
  107afa:	89 c7                	mov    %eax,%edi
    tcb_set_state(new_cur_pid, TSTATE_RUN);
  107afc:	e8 ff f8 ff ff       	call   107400 <tcb_set_state>
    set_curid(new_cur_pid);
  107b01:	89 3c 24             	mov    %edi,(%esp)
  107b04:	e8 67 fe ff ff       	call   107970 <set_curid>

    if (old_cur_pid != new_cur_pid) {
  107b09:	83 c4 10             	add    $0x10,%esp
  107b0c:	39 fe                	cmp    %edi,%esi
  107b0e:	74 20                	je     107b30 <thread_yield+0x80>
        spinlock_release(&sched_lk);
  107b10:	83 ec 0c             	sub    $0xc,%esp
  107b13:	55                   	push   %ebp
  107b14:	e8 d7 e3 ff ff       	call   105ef0 <spinlock_release>
        kctx_switch(old_cur_pid, new_cur_pid);
  107b19:	58                   	pop    %eax
  107b1a:	5a                   	pop    %edx
  107b1b:	57                   	push   %edi
  107b1c:	56                   	push   %esi
  107b1d:	e8 be f7 ff ff       	call   1072e0 <kctx_switch>
  107b22:	83 c4 10             	add    $0x10,%esp
    }
    else {
        spinlock_release(&sched_lk);
    }
}
  107b25:	83 c4 0c             	add    $0xc,%esp
  107b28:	5b                   	pop    %ebx
  107b29:	5e                   	pop    %esi
  107b2a:	5f                   	pop    %edi
  107b2b:	5d                   	pop    %ebp
  107b2c:	c3                   	ret    
  107b2d:	8d 76 00             	lea    0x0(%esi),%esi
        spinlock_release(&sched_lk);
  107b30:	83 ec 0c             	sub    $0xc,%esp
  107b33:	55                   	push   %ebp
  107b34:	e8 b7 e3 ff ff       	call   105ef0 <spinlock_release>
  107b39:	83 c4 10             	add    $0x10,%esp
}
  107b3c:	83 c4 0c             	add    $0xc,%esp
  107b3f:	5b                   	pop    %ebx
  107b40:	5e                   	pop    %esi
  107b41:	5f                   	pop    %edi
  107b42:	5d                   	pop    %ebp
  107b43:	c3                   	ret    
  107b44:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107b4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  107b4f:	90                   	nop

00107b50 <sched_update>:

void sched_update(void)
{
  107b50:	57                   	push   %edi
  107b51:	56                   	push   %esi
  107b52:	53                   	push   %ebx
  107b53:	e8 31 88 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107b58:	81 c3 a8 c4 00 00    	add    $0xc4a8,%ebx
    spinlock_acquire(&sched_lk);
  107b5e:	83 ec 0c             	sub    $0xc,%esp
  107b61:	8d bb e0 6e cc 00    	lea    0xcc6ee0(%ebx),%edi
    sched_ticks[get_pcpu_idx()] += 1000 / LAPIC_TIMER_INTR_FREQ;
  107b67:	8d b3 c0 6e cc 00    	lea    0xcc6ec0(%ebx),%esi
    spinlock_acquire(&sched_lk);
  107b6d:	57                   	push   %edi
  107b6e:	e8 fd e2 ff ff       	call   105e70 <spinlock_acquire>
    sched_ticks[get_pcpu_idx()] += 1000 / LAPIC_TIMER_INTR_FREQ;
  107b73:	e8 08 e6 ff ff       	call   106180 <get_pcpu_idx>
  107b78:	83 04 86 01          	addl   $0x1,(%esi,%eax,4)
    if (sched_ticks[get_pcpu_idx()] >= SCHED_SLICE) {
  107b7c:	e8 ff e5 ff ff       	call   106180 <get_pcpu_idx>
  107b81:	83 c4 10             	add    $0x10,%esp
  107b84:	83 3c 86 04          	cmpl   $0x4,(%esi,%eax,4)
  107b88:	76 26                	jbe    107bb0 <sched_update+0x60>
        sched_ticks[get_pcpu_idx()] = 0;
  107b8a:	e8 f1 e5 ff ff       	call   106180 <get_pcpu_idx>
        spinlock_release(&sched_lk);
  107b8f:	83 ec 0c             	sub    $0xc,%esp
  107b92:	57                   	push   %edi
        sched_ticks[get_pcpu_idx()] = 0;
  107b93:	c7 04 86 00 00 00 00 	movl   $0x0,(%esi,%eax,4)
        spinlock_release(&sched_lk);
  107b9a:	e8 51 e3 ff ff       	call   105ef0 <spinlock_release>
        thread_yield();
  107b9f:	83 c4 10             	add    $0x10,%esp
    }
    else {
        spinlock_release(&sched_lk);
    }
}
  107ba2:	5b                   	pop    %ebx
  107ba3:	5e                   	pop    %esi
  107ba4:	5f                   	pop    %edi
        thread_yield();
  107ba5:	e9 06 ff ff ff       	jmp    107ab0 <thread_yield>
  107baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        spinlock_release(&sched_lk);
  107bb0:	83 ec 0c             	sub    $0xc,%esp
  107bb3:	57                   	push   %edi
  107bb4:	e8 37 e3 ff ff       	call   105ef0 <spinlock_release>
  107bb9:	83 c4 10             	add    $0x10,%esp
}
  107bbc:	5b                   	pop    %ebx
  107bbd:	5e                   	pop    %esi
  107bbe:	5f                   	pop    %edi
  107bbf:	c3                   	ret    

00107bc0 <thread_sleep>:
/**
 * Atomically release lock and sleep on chan.
 * Reacquires lock when awakened.
 */
void thread_sleep(void *chan, spinlock_t *lk)
{
  107bc0:	53                   	push   %ebx
  107bc1:	e8 c3 87 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107bc6:	81 c3 3a c4 00 00    	add    $0xc43a,%ebx
  107bcc:	83 ec 08             	sub    $0x8,%esp
    // TODO: your local variables here.

    if (lk == 0)
  107bcf:	8b 44 24 14          	mov    0x14(%esp),%eax
  107bd3:	85 c0                	test   %eax,%eax
  107bd5:	74 09                	je     107be0 <thread_sleep+0x20>
    // TODO: Context switch.

    // TODO: Tidy up.

    // TODO: Reacquire original lock.
}
  107bd7:	83 c4 08             	add    $0x8,%esp
  107bda:	5b                   	pop    %ebx
  107bdb:	c3                   	ret    
  107bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        KERN_PANIC("sleep without lock");
  107be0:	83 ec 04             	sub    $0x4,%esp
  107be3:	8d 83 7f 87 ff ff    	lea    -0x7881(%ebx),%eax
  107be9:	50                   	push   %eax
  107bea:	8d 83 92 87 ff ff    	lea    -0x786e(%ebx),%eax
  107bf0:	6a 6a                	push   $0x6a
  107bf2:	50                   	push   %eax
  107bf3:	e8 18 cb ff ff       	call   104710 <debug_panic>
  107bf8:	83 c4 10             	add    $0x10,%esp
}
  107bfb:	83 c4 08             	add    $0x8,%esp
  107bfe:	5b                   	pop    %ebx
  107bff:	c3                   	ret    

00107c00 <thread_wakeup>:
 * Wake up all processes sleeping on chan.
 */
void thread_wakeup(void *chan)
{
    // TODO
}
  107c00:	c3                   	ret    
  107c01:	66 90                	xchg   %ax,%ax
  107c03:	66 90                	xchg   %ax,%ax
  107c05:	66 90                	xchg   %ax,%ax
  107c07:	66 90                	xchg   %ax,%ax
  107c09:	66 90                	xchg   %ax,%ax
  107c0b:	66 90                	xchg   %ax,%ax
  107c0d:	66 90                	xchg   %ax,%ax
  107c0f:	90                   	nop

00107c10 <proc_start_user>:
extern tf_t uctx_pool[NUM_IDS];

extern unsigned int last_active[NUM_CPUS];

void proc_start_user(void)
{
  107c10:	57                   	push   %edi
  107c11:	56                   	push   %esi
  107c12:	53                   	push   %ebx
  107c13:	e8 71 87 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107c18:	81 c3 e8 c3 00 00    	add    $0xc3e8,%ebx
    unsigned int cur_pid = get_curid();
  107c1e:	e8 2d fd ff ff       	call   107950 <get_curid>
  107c23:	89 c6                	mov    %eax,%esi
    unsigned int cpu_idx = get_pcpu_idx();
  107c25:	e8 56 e5 ff ff       	call   106180 <get_pcpu_idx>

    kstack_switch(cur_pid);
  107c2a:	83 ec 0c             	sub    $0xc,%esp
  107c2d:	56                   	push   %esi
    unsigned int cpu_idx = get_pcpu_idx();
  107c2e:	89 c7                	mov    %eax,%edi
    kstack_switch(cur_pid);
  107c30:	e8 3b d3 ff ff       	call   104f70 <kstack_switch>
    set_pdir_base(cur_pid);
  107c35:	89 34 24             	mov    %esi,(%esp)
  107c38:	e8 83 ef ff ff       	call   106bc0 <set_pdir_base>
    last_active[cpu_idx] = cur_pid;
  107c3d:	c7 c0 00 c0 e1 00    	mov    $0xe1c000,%eax
  107c43:	89 34 b8             	mov    %esi,(%eax,%edi,4)

    trap_return((void *) &uctx_pool[cur_pid]);
  107c46:	6b f6 44             	imul   $0x44,%esi,%esi
  107c49:	81 c6 00 af dd 00    	add    $0xddaf00,%esi
  107c4f:	89 34 24             	mov    %esi,(%esp)
  107c52:	e8 b9 a5 ff ff       	call   102210 <trap_return>
}
  107c57:	83 c4 10             	add    $0x10,%esp
  107c5a:	5b                   	pop    %ebx
  107c5b:	5e                   	pop    %esi
  107c5c:	5f                   	pop    %edi
  107c5d:	c3                   	ret    
  107c5e:	66 90                	xchg   %ax,%ax

00107c60 <proc_create>:

unsigned int proc_create(void *elf_addr, unsigned int quota)
{
  107c60:	57                   	push   %edi
  107c61:	56                   	push   %esi
  107c62:	53                   	push   %ebx
  107c63:	e8 21 87 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107c68:	81 c3 98 c3 00 00    	add    $0xc398,%ebx
    unsigned int pid, id;

    id = get_curid();
  107c6e:	e8 dd fc ff ff       	call   107950 <get_curid>
    pid = thread_spawn((void *) proc_start_user, id, quota);
  107c73:	83 ec 04             	sub    $0x4,%esp
  107c76:	ff 74 24 18          	push   0x18(%esp)
  107c7a:	50                   	push   %eax
  107c7b:	8d 83 10 3c ff ff    	lea    -0xc3f0(%ebx),%eax
  107c81:	50                   	push   %eax
  107c82:	e8 b9 fd ff ff       	call   107a40 <thread_spawn>

    if (pid != NUM_IDS) {
  107c87:	83 c4 10             	add    $0x10,%esp
    pid = thread_spawn((void *) proc_start_user, id, quota);
  107c8a:	89 c6                	mov    %eax,%esi
    if (pid != NUM_IDS) {
  107c8c:	83 f8 40             	cmp    $0x40,%eax
  107c8f:	74 66                	je     107cf7 <proc_create+0x97>
        elf_load(elf_addr, pid);
  107c91:	83 ec 08             	sub    $0x8,%esp

        uctx_pool[pid].es = CPU_GDT_UDATA | 3;
  107c94:	6b fe 44             	imul   $0x44,%esi,%edi
        elf_load(elf_addr, pid);
  107c97:	50                   	push   %eax
  107c98:	ff 74 24 1c          	push   0x1c(%esp)
  107c9c:	e8 8f de ff ff       	call   105b30 <elf_load>
        uctx_pool[pid].es = CPU_GDT_UDATA | 3;
  107ca1:	81 c7 00 af dd 00    	add    $0xddaf00,%edi
  107ca7:	b8 23 00 00 00       	mov    $0x23,%eax
        uctx_pool[pid].ds = CPU_GDT_UDATA | 3;
  107cac:	ba 23 00 00 00       	mov    $0x23,%edx
        uctx_pool[pid].es = CPU_GDT_UDATA | 3;
  107cb1:	66 89 47 20          	mov    %ax,0x20(%edi)
        uctx_pool[pid].cs = CPU_GDT_UCODE | 3;
  107cb5:	b9 1b 00 00 00       	mov    $0x1b,%ecx
        uctx_pool[pid].ss = CPU_GDT_UDATA | 3;
  107cba:	b8 23 00 00 00       	mov    $0x23,%eax
        uctx_pool[pid].ds = CPU_GDT_UDATA | 3;
  107cbf:	66 89 57 24          	mov    %dx,0x24(%edi)
        uctx_pool[pid].cs = CPU_GDT_UCODE | 3;
  107cc3:	66 89 4f 34          	mov    %cx,0x34(%edi)
        uctx_pool[pid].ss = CPU_GDT_UDATA | 3;
  107cc7:	66 89 47 40          	mov    %ax,0x40(%edi)
        uctx_pool[pid].esp = VM_USERHI;
  107ccb:	c7 47 3c 00 00 00 f0 	movl   $0xf0000000,0x3c(%edi)
        uctx_pool[pid].eflags = FL_IF;
  107cd2:	c7 47 38 00 02 00 00 	movl   $0x200,0x38(%edi)
        uctx_pool[pid].eip = elf_entry(elf_addr);
  107cd9:	58                   	pop    %eax
  107cda:	ff 74 24 1c          	push   0x1c(%esp)
  107cde:	e8 5d e0 ff ff       	call   105d40 <elf_entry>
  107ce3:	89 47 30             	mov    %eax,0x30(%edi)

        seg_init_proc(get_pcpu_idx(), pid);
  107ce6:	e8 95 e4 ff ff       	call   106180 <get_pcpu_idx>
  107ceb:	5a                   	pop    %edx
  107cec:	59                   	pop    %ecx
  107ced:	56                   	push   %esi
  107cee:	50                   	push   %eax
  107cef:	e8 bc d4 ff ff       	call   1051b0 <seg_init_proc>
  107cf4:	83 c4 10             	add    $0x10,%esp
    }

    return pid;
}
  107cf7:	89 f0                	mov    %esi,%eax
  107cf9:	5b                   	pop    %ebx
  107cfa:	5e                   	pop    %esi
  107cfb:	5f                   	pop    %edi
  107cfc:	c3                   	ret    
  107cfd:	66 90                	xchg   %ax,%ax
  107cff:	90                   	nop

00107d00 <syscall_get_arg1>:
 * Retrieves the system call arguments from uctx_pool that get
 * passed in from the current running process' system call.
 */
unsigned int syscall_get_arg1(tf_t *tf)
{
    return tf->regs.eax;
  107d00:	8b 44 24 04          	mov    0x4(%esp),%eax
  107d04:	8b 40 1c             	mov    0x1c(%eax),%eax
}
  107d07:	c3                   	ret    
  107d08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107d0f:	90                   	nop

00107d10 <syscall_get_arg2>:

unsigned int syscall_get_arg2(tf_t *tf)
{
    return tf->regs.ebx;
  107d10:	8b 44 24 04          	mov    0x4(%esp),%eax
  107d14:	8b 40 10             	mov    0x10(%eax),%eax
}
  107d17:	c3                   	ret    
  107d18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107d1f:	90                   	nop

00107d20 <syscall_get_arg3>:

unsigned int syscall_get_arg3(tf_t *tf)
{
    return tf->regs.ecx;
  107d20:	8b 44 24 04          	mov    0x4(%esp),%eax
  107d24:	8b 40 18             	mov    0x18(%eax),%eax
}
  107d27:	c3                   	ret    
  107d28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107d2f:	90                   	nop

00107d30 <syscall_get_arg4>:

unsigned int syscall_get_arg4(tf_t *tf)
{
    return tf->regs.edx;
  107d30:	8b 44 24 04          	mov    0x4(%esp),%eax
  107d34:	8b 40 14             	mov    0x14(%eax),%eax
}
  107d37:	c3                   	ret    
  107d38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107d3f:	90                   	nop

00107d40 <syscall_get_arg5>:

unsigned int syscall_get_arg5(tf_t *tf)
{
    return tf->regs.esi;
  107d40:	8b 44 24 04          	mov    0x4(%esp),%eax
  107d44:	8b 40 04             	mov    0x4(%eax),%eax
}
  107d47:	c3                   	ret    
  107d48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107d4f:	90                   	nop

00107d50 <syscall_get_arg6>:

unsigned int syscall_get_arg6(tf_t *tf)
{
    return tf->regs.edi;
  107d50:	8b 44 24 04          	mov    0x4(%esp),%eax
  107d54:	8b 00                	mov    (%eax),%eax
}
  107d56:	c3                   	ret    
  107d57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107d5e:	66 90                	xchg   %ax,%ax

00107d60 <syscall_set_errno>:
 * Sets the error number in uctx_pool that gets passed
 * to the current running process when we return to it.
 */
void syscall_set_errno(tf_t *tf, unsigned int errno)
{
    tf->regs.eax = errno;
  107d60:	8b 44 24 04          	mov    0x4(%esp),%eax
  107d64:	8b 54 24 08          	mov    0x8(%esp),%edx
  107d68:	89 50 1c             	mov    %edx,0x1c(%eax)
}
  107d6b:	c3                   	ret    
  107d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107d70 <syscall_set_retval1>:
 * Sets the return values in uctx_pool that get passed
 * to the current running process when we return to it.
 */
void syscall_set_retval1(tf_t *tf, unsigned int retval)
{
    tf->regs.ebx = retval;
  107d70:	8b 44 24 04          	mov    0x4(%esp),%eax
  107d74:	8b 54 24 08          	mov    0x8(%esp),%edx
  107d78:	89 50 10             	mov    %edx,0x10(%eax)
}
  107d7b:	c3                   	ret    
  107d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107d80 <syscall_set_retval2>:

void syscall_set_retval2(tf_t *tf, unsigned int retval)
{
    tf->regs.ecx = retval;
  107d80:	8b 44 24 04          	mov    0x4(%esp),%eax
  107d84:	8b 54 24 08          	mov    0x8(%esp),%edx
  107d88:	89 50 18             	mov    %edx,0x18(%eax)
}
  107d8b:	c3                   	ret    
  107d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107d90 <syscall_set_retval3>:

void syscall_set_retval3(tf_t *tf, unsigned int retval)
{
    tf->regs.edx = retval;
  107d90:	8b 44 24 04          	mov    0x4(%esp),%eax
  107d94:	8b 54 24 08          	mov    0x8(%esp),%edx
  107d98:	89 50 14             	mov    %edx,0x14(%eax)
}
  107d9b:	c3                   	ret    
  107d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107da0 <syscall_set_retval4>:

void syscall_set_retval4(tf_t *tf, unsigned int retval)
{
    tf->regs.esi = retval;
  107da0:	8b 44 24 04          	mov    0x4(%esp),%eax
  107da4:	8b 54 24 08          	mov    0x8(%esp),%edx
  107da8:	89 50 04             	mov    %edx,0x4(%eax)
}
  107dab:	c3                   	ret    
  107dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107db0 <syscall_set_retval5>:

void syscall_set_retval5(tf_t *tf, unsigned int retval)
{
    tf->regs.edi = retval;
  107db0:	8b 44 24 04          	mov    0x4(%esp),%eax
  107db4:	8b 54 24 08          	mov    0x8(%esp),%edx
  107db8:	89 10                	mov    %edx,(%eax)
}
  107dba:	c3                   	ret    
  107dbb:	66 90                	xchg   %ax,%ax
  107dbd:	66 90                	xchg   %ax,%ax
  107dbf:	90                   	nop

00107dc0 <sys_puts>:
/**
 * Copies a string from user into buffer and prints it to the screen.
 * This is called by the user level "printf" library as a system call.
 */
void sys_puts(tf_t *tf)
{
  107dc0:	55                   	push   %ebp
  107dc1:	57                   	push   %edi
  107dc2:	56                   	push   %esi
  107dc3:	53                   	push   %ebx
  107dc4:	e8 c0 85 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107dc9:	81 c3 37 c2 00 00    	add    $0xc237,%ebx
  107dcf:	83 ec 1c             	sub    $0x1c,%esp
    unsigned int cur_pid;
    unsigned int str_uva, str_len;
    unsigned int remain, cur_pos, nbytes;

    cur_pid = get_curid();
  107dd2:	e8 79 fb ff ff       	call   107950 <get_curid>
    str_uva = syscall_get_arg2(tf);
  107dd7:	83 ec 0c             	sub    $0xc,%esp
    cur_pid = get_curid();
  107dda:	89 44 24 14          	mov    %eax,0x14(%esp)
    str_uva = syscall_get_arg2(tf);
  107dde:	ff 74 24 3c          	push   0x3c(%esp)
  107de2:	e8 29 ff ff ff       	call   107d10 <syscall_get_arg2>
  107de7:	89 c7                	mov    %eax,%edi
    str_len = syscall_get_arg3(tf);
  107de9:	58                   	pop    %eax
  107dea:	ff 74 24 3c          	push   0x3c(%esp)
  107dee:	e8 2d ff ff ff       	call   107d20 <syscall_get_arg3>

    if (!(VM_USERLO <= str_uva && str_uva + str_len <= VM_USERHI)) {
  107df3:	83 c4 10             	add    $0x10,%esp
  107df6:	81 ff ff ff ff 3f    	cmp    $0x3fffffff,%edi
  107dfc:	0f 86 e6 00 00 00    	jbe    107ee8 <sys_puts+0x128>
  107e02:	01 c7                	add    %eax,%edi
  107e04:	89 c5                	mov    %eax,%ebp
  107e06:	81 ff 00 00 00 f0    	cmp    $0xf0000000,%edi
  107e0c:	0f 87 d6 00 00 00    	ja     107ee8 <sys_puts+0x128>
    }

    remain = str_len;
    cur_pos = str_uva;

    while (remain) {
  107e12:	85 c0                	test   %eax,%eax
  107e14:	0f 84 b2 00 00 00    	je     107ecc <sys_puts+0x10c>
        if (remain < PAGESIZE - 1)
            nbytes = remain;
        else
            nbytes = PAGESIZE - 1;

        if (pt_copyin(cur_pid, cur_pos, sys_buf[cur_pid], nbytes) != nbytes) {
  107e1a:	8b 74 24 08          	mov    0x8(%esp),%esi
  107e1e:	8d 83 00 80 cc 00    	lea    0xcc8000(%ebx),%eax
  107e24:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107e28:	c1 e6 0c             	shl    $0xc,%esi
  107e2b:	01 c6                	add    %eax,%esi
  107e2d:	eb 3d                	jmp    107e6c <sys_puts+0xac>
  107e2f:	90                   	nop
  107e30:	68 ff 0f 00 00       	push   $0xfff
  107e35:	56                   	push   %esi
  107e36:	50                   	push   %eax
  107e37:	ff 74 24 14          	push   0x14(%esp)
  107e3b:	e8 40 da ff ff       	call   105880 <pt_copyin>
  107e40:	83 c4 10             	add    $0x10,%esp
  107e43:	3d ff 0f 00 00       	cmp    $0xfff,%eax
  107e48:	75 41                	jne    107e8b <sys_puts+0xcb>
            syscall_set_errno(tf, E_MEM);
            return;
        }

        sys_buf[cur_pid][nbytes] = '\0';
        KERN_INFO("%s", sys_buf[cur_pid]);
  107e4a:	83 ec 08             	sub    $0x8,%esp
  107e4d:	8d 83 0e 70 ff ff    	lea    -0x8ff2(%ebx),%eax
        sys_buf[cur_pid][nbytes] = '\0';
  107e53:	c6 86 ff 0f 00 00 00 	movb   $0x0,0xfff(%esi)
        KERN_INFO("%s", sys_buf[cur_pid]);
  107e5a:	56                   	push   %esi
  107e5b:	50                   	push   %eax
  107e5c:	e8 0f c8 ff ff       	call   104670 <debug_info>
    while (remain) {
  107e61:	83 c4 10             	add    $0x10,%esp
  107e64:	81 ed ff 0f 00 00    	sub    $0xfff,%ebp
  107e6a:	74 60                	je     107ecc <sys_puts+0x10c>
  107e6c:	89 f8                	mov    %edi,%eax
  107e6e:	29 e8                	sub    %ebp,%eax
        if (remain < PAGESIZE - 1)
  107e70:	81 fd fe 0f 00 00    	cmp    $0xffe,%ebp
  107e76:	77 b8                	ja     107e30 <sys_puts+0x70>
        if (pt_copyin(cur_pid, cur_pos, sys_buf[cur_pid], nbytes) != nbytes) {
  107e78:	55                   	push   %ebp
  107e79:	56                   	push   %esi
  107e7a:	50                   	push   %eax
  107e7b:	ff 74 24 14          	push   0x14(%esp)
  107e7f:	e8 fc d9 ff ff       	call   105880 <pt_copyin>
  107e84:	83 c4 10             	add    $0x10,%esp
  107e87:	39 c5                	cmp    %eax,%ebp
  107e89:	74 1d                	je     107ea8 <sys_puts+0xe8>
            syscall_set_errno(tf, E_MEM);
  107e8b:	83 ec 08             	sub    $0x8,%esp
  107e8e:	6a 01                	push   $0x1
  107e90:	ff 74 24 3c          	push   0x3c(%esp)
  107e94:	e8 c7 fe ff ff       	call   107d60 <syscall_set_errno>
            return;
  107e99:	83 c4 10             	add    $0x10,%esp
        remain -= nbytes;
        cur_pos += nbytes;
    }

    syscall_set_errno(tf, E_SUCC);
}
  107e9c:	83 c4 1c             	add    $0x1c,%esp
  107e9f:	5b                   	pop    %ebx
  107ea0:	5e                   	pop    %esi
  107ea1:	5f                   	pop    %edi
  107ea2:	5d                   	pop    %ebp
  107ea3:	c3                   	ret    
  107ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        sys_buf[cur_pid][nbytes] = '\0';
  107ea8:	8b 44 24 08          	mov    0x8(%esp),%eax
        KERN_INFO("%s", sys_buf[cur_pid]);
  107eac:	83 ec 08             	sub    $0x8,%esp
        sys_buf[cur_pid][nbytes] = '\0';
  107eaf:	c1 e0 0c             	shl    $0xc,%eax
  107eb2:	01 c5                	add    %eax,%ebp
  107eb4:	8b 44 24 14          	mov    0x14(%esp),%eax
  107eb8:	c6 04 28 00          	movb   $0x0,(%eax,%ebp,1)
        KERN_INFO("%s", sys_buf[cur_pid]);
  107ebc:	8d 83 0e 70 ff ff    	lea    -0x8ff2(%ebx),%eax
  107ec2:	56                   	push   %esi
  107ec3:	50                   	push   %eax
  107ec4:	e8 a7 c7 ff ff       	call   104670 <debug_info>
  107ec9:	83 c4 10             	add    $0x10,%esp
    syscall_set_errno(tf, E_SUCC);
  107ecc:	83 ec 08             	sub    $0x8,%esp
  107ecf:	6a 00                	push   $0x0
  107ed1:	ff 74 24 3c          	push   0x3c(%esp)
  107ed5:	e8 86 fe ff ff       	call   107d60 <syscall_set_errno>
  107eda:	83 c4 10             	add    $0x10,%esp
}
  107edd:	83 c4 1c             	add    $0x1c,%esp
  107ee0:	5b                   	pop    %ebx
  107ee1:	5e                   	pop    %esi
  107ee2:	5f                   	pop    %edi
  107ee3:	5d                   	pop    %ebp
  107ee4:	c3                   	ret    
  107ee5:	8d 76 00             	lea    0x0(%esi),%esi
        syscall_set_errno(tf, E_INVAL_ADDR);
  107ee8:	83 ec 08             	sub    $0x8,%esp
  107eeb:	6a 04                	push   $0x4
  107eed:	ff 74 24 3c          	push   0x3c(%esp)
  107ef1:	e8 6a fe ff ff       	call   107d60 <syscall_set_errno>
        return;
  107ef6:	83 c4 10             	add    $0x10,%esp
}
  107ef9:	83 c4 1c             	add    $0x1c,%esp
  107efc:	5b                   	pop    %ebx
  107efd:	5e                   	pop    %esi
  107efe:	5f                   	pop    %edi
  107eff:	5d                   	pop    %ebp
  107f00:	c3                   	ret    
  107f01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107f08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107f0f:	90                   	nop

00107f10 <sys_spawn>:
 * NUM_IDS with the error number E_INVAL_PID. The same error case apply
 * when the proc_create fails.
 * Otherwise, you should mark it as successful, and return the new child process id.
 */
void sys_spawn(tf_t *tf)
{
  107f10:	55                   	push   %ebp
  107f11:	57                   	push   %edi
  107f12:	56                   	push   %esi
  107f13:	53                   	push   %ebx
  107f14:	e8 70 84 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107f19:	81 c3 e7 c0 00 00    	add    $0xc0e7,%ebx
  107f1f:	83 ec 1c             	sub    $0x1c,%esp
  107f22:	8b 74 24 30          	mov    0x30(%esp),%esi
    unsigned int new_pid;
    unsigned int elf_id, quota;
    void *elf_addr;
    unsigned int curid = get_curid();
  107f26:	e8 25 fa ff ff       	call   107950 <get_curid>

    elf_id = syscall_get_arg2(tf);
  107f2b:	83 ec 0c             	sub    $0xc,%esp
  107f2e:	56                   	push   %esi
    unsigned int curid = get_curid();
  107f2f:	89 c5                	mov    %eax,%ebp
    elf_id = syscall_get_arg2(tf);
  107f31:	e8 da fd ff ff       	call   107d10 <syscall_get_arg2>
    quota = syscall_get_arg3(tf);
  107f36:	89 34 24             	mov    %esi,(%esp)
    elf_id = syscall_get_arg2(tf);
  107f39:	89 c7                	mov    %eax,%edi
    quota = syscall_get_arg3(tf);
  107f3b:	e8 e0 fd ff ff       	call   107d20 <syscall_get_arg3>
  107f40:	89 44 24 1c          	mov    %eax,0x1c(%esp)

    if (!container_can_consume(curid, quota)) {
  107f44:	5a                   	pop    %edx
  107f45:	59                   	pop    %ecx
  107f46:	50                   	push   %eax
  107f47:	55                   	push   %ebp
  107f48:	e8 b3 ea ff ff       	call   106a00 <container_can_consume>
  107f4d:	83 c4 10             	add    $0x10,%esp
  107f50:	85 c0                	test   %eax,%eax
  107f52:	0f 84 b8 00 00 00    	je     108010 <sys_spawn+0x100>
        syscall_set_errno(tf, E_EXCEEDS_QUOTA);
        syscall_set_retval1(tf, NUM_IDS);
        return;
    }
    else if (NUM_IDS < curid * MAX_CHILDREN + 1 + MAX_CHILDREN) {
  107f58:	8d 44 6d 04          	lea    0x4(%ebp,%ebp,2),%eax
  107f5c:	83 f8 40             	cmp    $0x40,%eax
  107f5f:	0f 87 9b 00 00 00    	ja     108000 <sys_spawn+0xf0>
        syscall_set_errno(tf, E_MAX_NUM_CHILDEN_REACHED);
        syscall_set_retval1(tf, NUM_IDS);
        return;
    }
    else if (container_get_nchildren(curid) == MAX_CHILDREN) {
  107f65:	83 ec 0c             	sub    $0xc,%esp
  107f68:	55                   	push   %ebp
  107f69:	e8 32 ea ff ff       	call   1069a0 <container_get_nchildren>
  107f6e:	83 c4 10             	add    $0x10,%esp
  107f71:	83 f8 03             	cmp    $0x3,%eax
  107f74:	0f 84 a6 00 00 00    	je     108020 <sys_spawn+0x110>
        syscall_set_errno(tf, E_INVAL_CHILD_ID);
        syscall_set_retval1(tf, NUM_IDS);
        return;
    }

    switch (elf_id) {
  107f7a:	83 ff 03             	cmp    $0x3,%edi
  107f7d:	0f 84 bd 00 00 00    	je     108040 <sys_spawn+0x130>
  107f83:	77 4b                	ja     107fd0 <sys_spawn+0xc0>
  107f85:	83 ff 01             	cmp    $0x1,%edi
  107f88:	0f 84 a2 00 00 00    	je     108030 <sys_spawn+0x120>
  107f8e:	83 ff 02             	cmp    $0x2,%edi
  107f91:	75 48                	jne    107fdb <sys_spawn+0xcb>
  107f93:	c7 c0 86 78 12 00    	mov    $0x127886,%eax
        syscall_set_errno(tf, E_INVAL_PID);
        syscall_set_retval1(tf, NUM_IDS);
        return;
    }

    new_pid = proc_create(elf_addr, quota);
  107f99:	83 ec 08             	sub    $0x8,%esp
  107f9c:	ff 74 24 14          	push   0x14(%esp)
  107fa0:	50                   	push   %eax
  107fa1:	e8 ba fc ff ff       	call   107c60 <proc_create>

    if (new_pid == NUM_IDS) {
  107fa6:	83 c4 10             	add    $0x10,%esp
    new_pid = proc_create(elf_addr, quota);
  107fa9:	89 c7                	mov    %eax,%edi
    if (new_pid == NUM_IDS) {
  107fab:	83 f8 40             	cmp    $0x40,%eax
  107fae:	74 2b                	je     107fdb <sys_spawn+0xcb>
        syscall_set_errno(tf, E_INVAL_PID);
        syscall_set_retval1(tf, NUM_IDS);
    } else {
        syscall_set_errno(tf, E_SUCC);
  107fb0:	83 ec 08             	sub    $0x8,%esp
  107fb3:	6a 00                	push   $0x0
  107fb5:	56                   	push   %esi
  107fb6:	e8 a5 fd ff ff       	call   107d60 <syscall_set_errno>
        syscall_set_retval1(tf, new_pid);
  107fbb:	58                   	pop    %eax
  107fbc:	5a                   	pop    %edx
  107fbd:	57                   	push   %edi
  107fbe:	56                   	push   %esi
  107fbf:	e8 ac fd ff ff       	call   107d70 <syscall_set_retval1>
  107fc4:	83 c4 10             	add    $0x10,%esp
    }
}
  107fc7:	83 c4 1c             	add    $0x1c,%esp
  107fca:	5b                   	pop    %ebx
  107fcb:	5e                   	pop    %esi
  107fcc:	5f                   	pop    %edi
  107fcd:	5d                   	pop    %ebp
  107fce:	c3                   	ret    
  107fcf:	90                   	nop
        elf_addr = _binary___obj_user_fstest_fstest_start;
  107fd0:	c7 c0 9e ac 13 00    	mov    $0x13ac9e,%eax
    switch (elf_id) {
  107fd6:	83 ff 04             	cmp    $0x4,%edi
  107fd9:	74 be                	je     107f99 <sys_spawn+0x89>
        syscall_set_errno(tf, E_INVAL_PID);
  107fdb:	83 ec 08             	sub    $0x8,%esp
  107fde:	6a 05                	push   $0x5
  107fe0:	56                   	push   %esi
  107fe1:	e8 7a fd ff ff       	call   107d60 <syscall_set_errno>
        syscall_set_retval1(tf, NUM_IDS);
  107fe6:	59                   	pop    %ecx
  107fe7:	5f                   	pop    %edi
  107fe8:	6a 40                	push   $0x40
  107fea:	56                   	push   %esi
  107feb:	e8 80 fd ff ff       	call   107d70 <syscall_set_retval1>
  107ff0:	83 c4 10             	add    $0x10,%esp
}
  107ff3:	83 c4 1c             	add    $0x1c,%esp
  107ff6:	5b                   	pop    %ebx
  107ff7:	5e                   	pop    %esi
  107ff8:	5f                   	pop    %edi
  107ff9:	5d                   	pop    %ebp
  107ffa:	c3                   	ret    
  107ffb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  107fff:	90                   	nop
        syscall_set_errno(tf, E_MAX_NUM_CHILDEN_REACHED);
  108000:	83 ec 08             	sub    $0x8,%esp
  108003:	6a 18                	push   $0x18
  108005:	eb d9                	jmp    107fe0 <sys_spawn+0xd0>
  108007:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10800e:	66 90                	xchg   %ax,%ax
        syscall_set_errno(tf, E_EXCEEDS_QUOTA);
  108010:	83 ec 08             	sub    $0x8,%esp
  108013:	6a 17                	push   $0x17
  108015:	eb c9                	jmp    107fe0 <sys_spawn+0xd0>
  108017:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10801e:	66 90                	xchg   %ax,%ax
        syscall_set_errno(tf, E_INVAL_CHILD_ID);
  108020:	83 ec 08             	sub    $0x8,%esp
  108023:	6a 19                	push   $0x19
  108025:	eb b9                	jmp    107fe0 <sys_spawn+0xd0>
  108027:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10802e:	66 90                	xchg   %ax,%ax
        elf_addr = _binary___obj_user_pingpong_ping_start;
  108030:	c7 c0 7a de 11 00    	mov    $0x11de7a,%eax
  108036:	e9 5e ff ff ff       	jmp    107f99 <sys_spawn+0x89>
  10803b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10803f:	90                   	nop
        elf_addr = _binary___obj_user_pingpong_ding_start;
  108040:	c7 c0 92 12 13 00    	mov    $0x131292,%eax
  108046:	e9 4e ff ff ff       	jmp    107f99 <sys_spawn+0x89>
  10804b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10804f:	90                   	nop

00108050 <sys_yield>:
 * The user level library function sys_yield (defined in user/include/syscall.h)
 * does not take any argument and does not have any return values.
 * Do not forget to set the error number as E_SUCC.
 */
void sys_yield(tf_t *tf)
{
  108050:	53                   	push   %ebx
  108051:	e8 33 83 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  108056:	81 c3 aa bf 00 00    	add    $0xbfaa,%ebx
  10805c:	83 ec 08             	sub    $0x8,%esp
    thread_yield();
  10805f:	e8 4c fa ff ff       	call   107ab0 <thread_yield>
    syscall_set_errno(tf, E_SUCC);
  108064:	83 ec 08             	sub    $0x8,%esp
  108067:	6a 00                	push   $0x0
  108069:	ff 74 24 1c          	push   0x1c(%esp)
  10806d:	e8 ee fc ff ff       	call   107d60 <syscall_set_errno>
}
  108072:	83 c4 18             	add    $0x18,%esp
  108075:	5b                   	pop    %ebx
  108076:	c3                   	ret    
  108077:	66 90                	xchg   %ax,%ax
  108079:	66 90                	xchg   %ax,%ax
  10807b:	66 90                	xchg   %ax,%ax
  10807d:	66 90                	xchg   %ax,%ax
  10807f:	90                   	nop

00108080 <syscall_dispatch>:

#include "import.h"
#include <kern/fs/sysfile.h>

void syscall_dispatch(tf_t *tf)
{
  108080:	56                   	push   %esi
  108081:	53                   	push   %ebx
  108082:	e8 02 83 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  108087:	81 c3 79 bf 00 00    	add    $0xbf79,%ebx
  10808d:	83 ec 10             	sub    $0x10,%esp
  108090:	8b 74 24 1c          	mov    0x1c(%esp),%esi
    unsigned int nr;

    nr = syscall_get_arg1(tf);
  108094:	56                   	push   %esi
  108095:	e8 66 fc ff ff       	call   107d00 <syscall_get_arg1>

    switch (nr) {
  10809a:	83 c4 10             	add    $0x10,%esp
  10809d:	83 f8 0b             	cmp    $0xb,%eax
  1080a0:	0f 87 f3 00 00 00    	ja     108199 <.L6+0x11>
  1080a6:	8b 94 83 b0 87 ff ff 	mov    -0x7850(%ebx,%eax,4),%edx
  1080ad:	01 da                	add    %ebx,%edx
  1080af:	ff e2                	jmp    *%edx
  1080b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001080b8 <.L5>:
        break;
    case SYS_link:
        sys_link(tf);
        break;
    case SYS_unlink:
        sys_unlink(tf);
  1080b8:	83 ec 0c             	sub    $0xc,%esp
  1080bb:	56                   	push   %esi
  1080bc:	e8 9f 25 00 00       	call   10a660 <sys_unlink>
        break;
  1080c1:	83 c4 10             	add    $0x10,%esp
        sys_fstat(tf);
        break;
    default:
        syscall_set_errno(tf, E_INVAL_CALLNR);
    }
}
  1080c4:	83 c4 04             	add    $0x4,%esp
  1080c7:	5b                   	pop    %ebx
  1080c8:	5e                   	pop    %esi
  1080c9:	c3                   	ret    
  1080ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001080d0 <.L3>:
        sys_fstat(tf);
  1080d0:	83 ec 0c             	sub    $0xc,%esp
  1080d3:	56                   	push   %esi
  1080d4:	e8 d7 23 00 00       	call   10a4b0 <sys_fstat>
        break;
  1080d9:	83 c4 10             	add    $0x10,%esp
  1080dc:	eb e6                	jmp    1080c4 <.L5+0xc>
  1080de:	66 90                	xchg   %ax,%ax

001080e0 <.L15>:
        sys_puts(tf);
  1080e0:	83 ec 0c             	sub    $0xc,%esp
  1080e3:	56                   	push   %esi
  1080e4:	e8 d7 fc ff ff       	call   107dc0 <sys_puts>
        break;
  1080e9:	83 c4 10             	add    $0x10,%esp
  1080ec:	eb d6                	jmp    1080c4 <.L5+0xc>
  1080ee:	66 90                	xchg   %ax,%ax

001080f0 <.L14>:
        sys_spawn(tf);
  1080f0:	83 ec 0c             	sub    $0xc,%esp
  1080f3:	56                   	push   %esi
  1080f4:	e8 17 fe ff ff       	call   107f10 <sys_spawn>
        break;
  1080f9:	83 c4 10             	add    $0x10,%esp
  1080fc:	eb c6                	jmp    1080c4 <.L5+0xc>
  1080fe:	66 90                	xchg   %ax,%ax

00108100 <.L13>:
        sys_yield(tf);
  108100:	83 ec 0c             	sub    $0xc,%esp
  108103:	56                   	push   %esi
  108104:	e8 47 ff ff ff       	call   108050 <sys_yield>
        break;
  108109:	83 c4 10             	add    $0x10,%esp
  10810c:	eb b6                	jmp    1080c4 <.L5+0xc>
  10810e:	66 90                	xchg   %ax,%ax

00108110 <.L12>:
        sys_open(tf);
  108110:	83 ec 0c             	sub    $0xc,%esp
  108113:	56                   	push   %esi
  108114:	e8 d7 27 00 00       	call   10a8f0 <sys_open>
        break;
  108119:	83 c4 10             	add    $0x10,%esp
  10811c:	eb a6                	jmp    1080c4 <.L5+0xc>
  10811e:	66 90                	xchg   %ax,%ax

00108120 <.L11>:
        sys_close(tf);
  108120:	83 ec 0c             	sub    $0xc,%esp
  108123:	56                   	push   %esi
  108124:	e8 77 23 00 00       	call   10a4a0 <sys_close>
        break;
  108129:	83 c4 10             	add    $0x10,%esp
  10812c:	eb 96                	jmp    1080c4 <.L5+0xc>
  10812e:	66 90                	xchg   %ax,%ax

00108130 <.L10>:
        sys_read(tf);
  108130:	83 ec 0c             	sub    $0xc,%esp
  108133:	56                   	push   %esi
  108134:	e8 47 23 00 00       	call   10a480 <sys_read>
        break;
  108139:	83 c4 10             	add    $0x10,%esp
  10813c:	eb 86                	jmp    1080c4 <.L5+0xc>
  10813e:	66 90                	xchg   %ax,%ax

00108140 <.L9>:
        sys_write(tf);
  108140:	83 ec 0c             	sub    $0xc,%esp
  108143:	56                   	push   %esi
  108144:	e8 47 23 00 00       	call   10a490 <sys_write>
        break;
  108149:	83 c4 10             	add    $0x10,%esp
  10814c:	e9 73 ff ff ff       	jmp    1080c4 <.L5+0xc>
  108151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00108158 <.L8>:
        sys_mkdir(tf);
  108158:	83 ec 0c             	sub    $0xc,%esp
  10815b:	56                   	push   %esi
  10815c:	e8 df 28 00 00       	call   10aa40 <sys_mkdir>
        break;
  108161:	83 c4 10             	add    $0x10,%esp
  108164:	e9 5b ff ff ff       	jmp    1080c4 <.L5+0xc>
  108169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00108170 <.L7>:
        sys_chdir(tf);
  108170:	83 ec 0c             	sub    $0xc,%esp
  108173:	56                   	push   %esi
  108174:	e8 67 29 00 00       	call   10aae0 <sys_chdir>
        break;
  108179:	83 c4 10             	add    $0x10,%esp
  10817c:	e9 43 ff ff ff       	jmp    1080c4 <.L5+0xc>
  108181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00108188 <.L6>:
        sys_link(tf);
  108188:	83 ec 0c             	sub    $0xc,%esp
  10818b:	56                   	push   %esi
  10818c:	e8 2f 23 00 00       	call   10a4c0 <sys_link>
        break;
  108191:	83 c4 10             	add    $0x10,%esp
  108194:	e9 2b ff ff ff       	jmp    1080c4 <.L5+0xc>
        syscall_set_errno(tf, E_INVAL_CALLNR);
  108199:	83 ec 08             	sub    $0x8,%esp
  10819c:	6a 03                	push   $0x3
  10819e:	56                   	push   %esi
  10819f:	e8 bc fb ff ff       	call   107d60 <syscall_set_errno>
  1081a4:	83 c4 10             	add    $0x10,%esp
}
  1081a7:	e9 18 ff ff ff       	jmp    1080c4 <.L5+0xc>
  1081ac:	66 90                	xchg   %ax,%ax
  1081ae:	66 90                	xchg   %ax,%ax

001081b0 <trap_dump.part.0>:

#include "import.h"

void ide_intr(void);

static void trap_dump(tf_t *tf)
  1081b0:	55                   	push   %ebp
  1081b1:	57                   	push   %edi
  1081b2:	56                   	push   %esi
  1081b3:	89 c6                	mov    %eax,%esi
  1081b5:	53                   	push   %ebx
  1081b6:	e8 ce 81 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1081bb:	81 c3 45 be 00 00    	add    $0xbe45,%ebx
  1081c1:	83 ec 0c             	sub    $0xc,%esp
    if (tf == NULL)
        return;

    uintptr_t base = (uintptr_t) tf;

    KERN_DEBUG("trapframe at %x\n", base);
  1081c4:	50                   	push   %eax
  1081c5:	8d bb 64 89 ff ff    	lea    -0x769c(%ebx),%edi
  1081cb:	8d 83 e0 87 ff ff    	lea    -0x7820(%ebx),%eax
  1081d1:	50                   	push   %eax
    KERN_DEBUG("\t%08x:\tedi:   \t\t%08x\n", &tf->regs.edi, tf->regs.edi);
    KERN_DEBUG("\t%08x:\tesi:   \t\t%08x\n", &tf->regs.esi, tf->regs.esi);
    KERN_DEBUG("\t%08x:\tebp:   \t\t%08x\n", &tf->regs.ebp, tf->regs.ebp);
    KERN_DEBUG("\t%08x:\tesp:   \t\t%08x\n", &tf->regs.oesp, tf->regs.oesp);
  1081d2:	8d ab 33 88 ff ff    	lea    -0x77cd(%ebx),%ebp
    KERN_DEBUG("trapframe at %x\n", base);
  1081d8:	6a 18                	push   $0x18
  1081da:	57                   	push   %edi
  1081db:	e8 d0 c4 ff ff       	call   1046b0 <debug_normal>
    KERN_DEBUG("\t%08x:\tedi:   \t\t%08x\n", &tf->regs.edi, tf->regs.edi);
  1081e0:	58                   	pop    %eax
  1081e1:	8d 83 f1 87 ff ff    	lea    -0x780f(%ebx),%eax
  1081e7:	ff 36                	push   (%esi)
  1081e9:	56                   	push   %esi
  1081ea:	50                   	push   %eax
  1081eb:	6a 19                	push   $0x19
  1081ed:	57                   	push   %edi
  1081ee:	e8 bd c4 ff ff       	call   1046b0 <debug_normal>
    KERN_DEBUG("\t%08x:\tesi:   \t\t%08x\n", &tf->regs.esi, tf->regs.esi);
  1081f3:	83 c4 14             	add    $0x14,%esp
  1081f6:	8d 46 04             	lea    0x4(%esi),%eax
  1081f9:	ff 76 04             	push   0x4(%esi)
  1081fc:	50                   	push   %eax
  1081fd:	8d 83 07 88 ff ff    	lea    -0x77f9(%ebx),%eax
  108203:	50                   	push   %eax
  108204:	6a 1a                	push   $0x1a
  108206:	57                   	push   %edi
  108207:	e8 a4 c4 ff ff       	call   1046b0 <debug_normal>
    KERN_DEBUG("\t%08x:\tebp:   \t\t%08x\n", &tf->regs.ebp, tf->regs.ebp);
  10820c:	83 c4 14             	add    $0x14,%esp
  10820f:	8d 46 08             	lea    0x8(%esi),%eax
  108212:	ff 76 08             	push   0x8(%esi)
  108215:	50                   	push   %eax
  108216:	8d 83 1d 88 ff ff    	lea    -0x77e3(%ebx),%eax
  10821c:	50                   	push   %eax
  10821d:	6a 1b                	push   $0x1b
  10821f:	57                   	push   %edi
  108220:	e8 8b c4 ff ff       	call   1046b0 <debug_normal>
    KERN_DEBUG("\t%08x:\tesp:   \t\t%08x\n", &tf->regs.oesp, tf->regs.oesp);
  108225:	83 c4 14             	add    $0x14,%esp
  108228:	8d 46 0c             	lea    0xc(%esi),%eax
  10822b:	ff 76 0c             	push   0xc(%esi)
  10822e:	50                   	push   %eax
  10822f:	55                   	push   %ebp
  108230:	6a 1c                	push   $0x1c
  108232:	57                   	push   %edi
  108233:	e8 78 c4 ff ff       	call   1046b0 <debug_normal>
    KERN_DEBUG("\t%08x:\tebx:   \t\t%08x\n", &tf->regs.ebx, tf->regs.ebx);
  108238:	83 c4 14             	add    $0x14,%esp
  10823b:	8d 46 10             	lea    0x10(%esi),%eax
  10823e:	ff 76 10             	push   0x10(%esi)
  108241:	50                   	push   %eax
  108242:	8d 83 49 88 ff ff    	lea    -0x77b7(%ebx),%eax
  108248:	50                   	push   %eax
  108249:	6a 1d                	push   $0x1d
  10824b:	57                   	push   %edi
  10824c:	e8 5f c4 ff ff       	call   1046b0 <debug_normal>
    KERN_DEBUG("\t%08x:\tedx:   \t\t%08x\n", &tf->regs.edx, tf->regs.edx);
  108251:	83 c4 14             	add    $0x14,%esp
  108254:	8d 46 14             	lea    0x14(%esi),%eax
  108257:	ff 76 14             	push   0x14(%esi)
  10825a:	50                   	push   %eax
  10825b:	8d 83 5f 88 ff ff    	lea    -0x77a1(%ebx),%eax
  108261:	50                   	push   %eax
  108262:	6a 1e                	push   $0x1e
  108264:	57                   	push   %edi
  108265:	e8 46 c4 ff ff       	call   1046b0 <debug_normal>
    KERN_DEBUG("\t%08x:\tecx:   \t\t%08x\n", &tf->regs.ecx, tf->regs.ecx);
  10826a:	83 c4 14             	add    $0x14,%esp
  10826d:	8d 46 18             	lea    0x18(%esi),%eax
  108270:	ff 76 18             	push   0x18(%esi)
  108273:	50                   	push   %eax
  108274:	8d 83 75 88 ff ff    	lea    -0x778b(%ebx),%eax
  10827a:	50                   	push   %eax
  10827b:	6a 1f                	push   $0x1f
  10827d:	57                   	push   %edi
  10827e:	e8 2d c4 ff ff       	call   1046b0 <debug_normal>
    KERN_DEBUG("\t%08x:\teax:   \t\t%08x\n", &tf->regs.eax, tf->regs.eax);
  108283:	83 c4 14             	add    $0x14,%esp
  108286:	8d 46 1c             	lea    0x1c(%esi),%eax
  108289:	ff 76 1c             	push   0x1c(%esi)
  10828c:	50                   	push   %eax
  10828d:	8d 83 8b 88 ff ff    	lea    -0x7775(%ebx),%eax
  108293:	50                   	push   %eax
  108294:	6a 20                	push   $0x20
  108296:	57                   	push   %edi
  108297:	e8 14 c4 ff ff       	call   1046b0 <debug_normal>
    KERN_DEBUG("\t%08x:\tes:    \t\t%08x\n", &tf->es, tf->es);
  10829c:	0f b7 46 20          	movzwl 0x20(%esi),%eax
  1082a0:	83 c4 14             	add    $0x14,%esp
  1082a3:	50                   	push   %eax
  1082a4:	8d 46 20             	lea    0x20(%esi),%eax
  1082a7:	50                   	push   %eax
  1082a8:	8d 83 a1 88 ff ff    	lea    -0x775f(%ebx),%eax
  1082ae:	50                   	push   %eax
  1082af:	6a 21                	push   $0x21
  1082b1:	57                   	push   %edi
  1082b2:	e8 f9 c3 ff ff       	call   1046b0 <debug_normal>
    KERN_DEBUG("\t%08x:\tds:    \t\t%08x\n", &tf->ds, tf->ds);
  1082b7:	0f b7 46 24          	movzwl 0x24(%esi),%eax
  1082bb:	83 c4 14             	add    $0x14,%esp
  1082be:	50                   	push   %eax
  1082bf:	8d 46 24             	lea    0x24(%esi),%eax
  1082c2:	50                   	push   %eax
  1082c3:	8d 83 b7 88 ff ff    	lea    -0x7749(%ebx),%eax
  1082c9:	50                   	push   %eax
  1082ca:	6a 22                	push   $0x22
  1082cc:	57                   	push   %edi
  1082cd:	e8 de c3 ff ff       	call   1046b0 <debug_normal>
    KERN_DEBUG("\t%08x:\ttrapno:\t\t%08x\n", &tf->trapno, tf->trapno);
  1082d2:	83 c4 14             	add    $0x14,%esp
  1082d5:	8d 46 28             	lea    0x28(%esi),%eax
  1082d8:	ff 76 28             	push   0x28(%esi)
  1082db:	50                   	push   %eax
  1082dc:	8d 83 cd 88 ff ff    	lea    -0x7733(%ebx),%eax
  1082e2:	50                   	push   %eax
  1082e3:	6a 23                	push   $0x23
  1082e5:	57                   	push   %edi
  1082e6:	e8 c5 c3 ff ff       	call   1046b0 <debug_normal>
    KERN_DEBUG("\t%08x:\terr:   \t\t%08x\n", &tf->err, tf->err);
  1082eb:	83 c4 14             	add    $0x14,%esp
  1082ee:	8d 46 2c             	lea    0x2c(%esi),%eax
  1082f1:	ff 76 2c             	push   0x2c(%esi)
  1082f4:	50                   	push   %eax
  1082f5:	8d 83 e3 88 ff ff    	lea    -0x771d(%ebx),%eax
  1082fb:	50                   	push   %eax
  1082fc:	6a 24                	push   $0x24
  1082fe:	57                   	push   %edi
  1082ff:	e8 ac c3 ff ff       	call   1046b0 <debug_normal>
    KERN_DEBUG("\t%08x:\teip:   \t\t%08x\n", &tf->eip, tf->eip);
  108304:	83 c4 14             	add    $0x14,%esp
  108307:	8d 46 30             	lea    0x30(%esi),%eax
  10830a:	ff 76 30             	push   0x30(%esi)
  10830d:	50                   	push   %eax
  10830e:	8d 83 f9 88 ff ff    	lea    -0x7707(%ebx),%eax
  108314:	50                   	push   %eax
  108315:	6a 25                	push   $0x25
  108317:	57                   	push   %edi
  108318:	e8 93 c3 ff ff       	call   1046b0 <debug_normal>
    KERN_DEBUG("\t%08x:\tcs:    \t\t%08x\n", &tf->cs, tf->cs);
  10831d:	0f b7 46 34          	movzwl 0x34(%esi),%eax
  108321:	83 c4 14             	add    $0x14,%esp
  108324:	50                   	push   %eax
  108325:	8d 46 34             	lea    0x34(%esi),%eax
  108328:	50                   	push   %eax
  108329:	8d 83 0f 89 ff ff    	lea    -0x76f1(%ebx),%eax
  10832f:	50                   	push   %eax
  108330:	6a 26                	push   $0x26
  108332:	57                   	push   %edi
  108333:	e8 78 c3 ff ff       	call   1046b0 <debug_normal>
    KERN_DEBUG("\t%08x:\teflags:\t\t%08x\n", &tf->eflags, tf->eflags);
  108338:	83 c4 14             	add    $0x14,%esp
  10833b:	8d 46 38             	lea    0x38(%esi),%eax
  10833e:	ff 76 38             	push   0x38(%esi)
  108341:	50                   	push   %eax
  108342:	8d 83 25 89 ff ff    	lea    -0x76db(%ebx),%eax
  108348:	50                   	push   %eax
  108349:	6a 27                	push   $0x27
  10834b:	57                   	push   %edi
  10834c:	e8 5f c3 ff ff       	call   1046b0 <debug_normal>
    KERN_DEBUG("\t%08x:\tesp:   \t\t%08x\n", &tf->esp, tf->esp);
  108351:	83 c4 14             	add    $0x14,%esp
  108354:	8d 46 3c             	lea    0x3c(%esi),%eax
  108357:	ff 76 3c             	push   0x3c(%esi)
  10835a:	50                   	push   %eax
    KERN_DEBUG("\t%08x:\tss:    \t\t%08x\n", &tf->ss, tf->ss);
  10835b:	83 c6 40             	add    $0x40,%esi
    KERN_DEBUG("\t%08x:\tesp:   \t\t%08x\n", &tf->esp, tf->esp);
  10835e:	55                   	push   %ebp
  10835f:	6a 28                	push   $0x28
  108361:	57                   	push   %edi
  108362:	e8 49 c3 ff ff       	call   1046b0 <debug_normal>
    KERN_DEBUG("\t%08x:\tss:    \t\t%08x\n", &tf->ss, tf->ss);
  108367:	0f b7 06             	movzwl (%esi),%eax
  10836a:	83 c4 14             	add    $0x14,%esp
  10836d:	50                   	push   %eax
  10836e:	8d 83 3b 89 ff ff    	lea    -0x76c5(%ebx),%eax
  108374:	56                   	push   %esi
  108375:	50                   	push   %eax
  108376:	6a 29                	push   $0x29
  108378:	57                   	push   %edi
  108379:	e8 32 c3 ff ff       	call   1046b0 <debug_normal>
}
  10837e:	83 c4 2c             	add    $0x2c,%esp
  108381:	5b                   	pop    %ebx
  108382:	5e                   	pop    %esi
  108383:	5f                   	pop    %edi
  108384:	5d                   	pop    %ebp
  108385:	c3                   	ret    
  108386:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10838d:	8d 76 00             	lea    0x0(%esi),%esi

00108390 <default_exception_handler>:

void default_exception_handler(tf_t *tf)
{
  108390:	56                   	push   %esi
  108391:	53                   	push   %ebx
  108392:	e8 f2 7f ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  108397:	81 c3 69 bc 00 00    	add    $0xbc69,%ebx
  10839d:	83 ec 04             	sub    $0x4,%esp
  1083a0:	8b 74 24 10          	mov    0x10(%esp),%esi
    unsigned int cur_pid;

    cur_pid = get_curid();
  1083a4:	e8 a7 f5 ff ff       	call   107950 <get_curid>
    if (tf == NULL)
  1083a9:	85 f6                	test   %esi,%esi
  1083ab:	74 07                	je     1083b4 <default_exception_handler+0x24>
  1083ad:	89 f0                	mov    %esi,%eax
  1083af:	e8 fc fd ff ff       	call   1081b0 <trap_dump.part.0>
    trap_dump(tf);

    KERN_PANIC("Trap %d @ 0x%08x.\n", tf->trapno, tf->eip);
  1083b4:	83 ec 0c             	sub    $0xc,%esp
  1083b7:	8d 83 51 89 ff ff    	lea    -0x76af(%ebx),%eax
  1083bd:	ff 76 30             	push   0x30(%esi)
  1083c0:	ff 76 28             	push   0x28(%esi)
  1083c3:	50                   	push   %eax
  1083c4:	8d 83 64 89 ff ff    	lea    -0x769c(%ebx),%eax
  1083ca:	6a 33                	push   $0x33
  1083cc:	50                   	push   %eax
  1083cd:	e8 3e c3 ff ff       	call   104710 <debug_panic>
}
  1083d2:	83 c4 24             	add    $0x24,%esp
  1083d5:	5b                   	pop    %ebx
  1083d6:	5e                   	pop    %esi
  1083d7:	c3                   	ret    
  1083d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1083df:	90                   	nop

001083e0 <pgflt_handler>:

void pgflt_handler(tf_t *tf)
{
  1083e0:	55                   	push   %ebp
  1083e1:	57                   	push   %edi
  1083e2:	56                   	push   %esi
  1083e3:	53                   	push   %ebx
  1083e4:	e8 a0 7f ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1083e9:	81 c3 17 bc 00 00    	add    $0xbc17,%ebx
  1083ef:	83 ec 0c             	sub    $0xc,%esp
    unsigned int cur_pid;
    unsigned int errno;
    unsigned int fault_va;

    cur_pid = get_curid();
  1083f2:	e8 59 f5 ff ff       	call   107950 <get_curid>
  1083f7:	89 c6                	mov    %eax,%esi
    errno = tf->err;
  1083f9:	8b 44 24 20          	mov    0x20(%esp),%eax
  1083fd:	8b 78 2c             	mov    0x2c(%eax),%edi
    fault_va = rcr2();
  108400:	e8 db d0 ff ff       	call   1054e0 <rcr2>
  108405:	89 c5                	mov    %eax,%ebp

    // Uncomment this line to see information about the page fault
    // KERN_DEBUG("Page fault: VA 0x%08x, errno 0x%08x, process %d, EIP 0x%08x.\n",
    //            fault_va, errno, cur_pid, uctx_pool[cur_pid].eip);

    if (errno & PFE_PR) {
  108407:	f7 c7 01 00 00 00    	test   $0x1,%edi
  10840d:	75 21                	jne    108430 <pgflt_handler+0x50>
        KERN_PANIC("Permission denied: va = 0x%08x, errno = 0x%08x.\n",
                   fault_va, errno);
        return;
    }

    if (alloc_page(cur_pid, fault_va, PTE_W | PTE_U | PTE_P) == MagicNumber) {
  10840f:	83 ec 04             	sub    $0x4,%esp
  108412:	6a 07                	push   $0x7
  108414:	50                   	push   %eax
  108415:	56                   	push   %esi
  108416:	e8 05 ee ff ff       	call   107220 <alloc_page>
  10841b:	83 c4 10             	add    $0x10,%esp
  10841e:	3d 01 00 10 00       	cmp    $0x100001,%eax
  108423:	74 3b                	je     108460 <pgflt_handler+0x80>
        KERN_PANIC("Page allocation failed: va = 0x%08x, errno = 0x%08x.\n",
                   fault_va, errno);
    }
}
  108425:	83 c4 0c             	add    $0xc,%esp
  108428:	5b                   	pop    %ebx
  108429:	5e                   	pop    %esi
  10842a:	5f                   	pop    %edi
  10842b:	5d                   	pop    %ebp
  10842c:	c3                   	ret    
  10842d:	8d 76 00             	lea    0x0(%esi),%esi
    if (tf == NULL)
  108430:	8b 44 24 20          	mov    0x20(%esp),%eax
  108434:	e8 77 fd ff ff       	call   1081b0 <trap_dump.part.0>
        KERN_PANIC("Permission denied: va = 0x%08x, errno = 0x%08x.\n",
  108439:	83 ec 0c             	sub    $0xc,%esp
  10843c:	8d 83 8c 89 ff ff    	lea    -0x7674(%ebx),%eax
  108442:	57                   	push   %edi
  108443:	55                   	push   %ebp
  108444:	50                   	push   %eax
  108445:	8d 83 64 89 ff ff    	lea    -0x769c(%ebx),%eax
  10844b:	6a 46                	push   $0x46
  10844d:	50                   	push   %eax
  10844e:	e8 bd c2 ff ff       	call   104710 <debug_panic>
        return;
  108453:	83 c4 20             	add    $0x20,%esp
}
  108456:	83 c4 0c             	add    $0xc,%esp
  108459:	5b                   	pop    %ebx
  10845a:	5e                   	pop    %esi
  10845b:	5f                   	pop    %edi
  10845c:	5d                   	pop    %ebp
  10845d:	c3                   	ret    
  10845e:	66 90                	xchg   %ax,%ax
        KERN_PANIC("Page allocation failed: va = 0x%08x, errno = 0x%08x.\n",
  108460:	83 ec 0c             	sub    $0xc,%esp
  108463:	8d 83 c0 89 ff ff    	lea    -0x7640(%ebx),%eax
  108469:	57                   	push   %edi
  10846a:	55                   	push   %ebp
  10846b:	50                   	push   %eax
  10846c:	8d 83 64 89 ff ff    	lea    -0x769c(%ebx),%eax
  108472:	6a 4c                	push   $0x4c
  108474:	50                   	push   %eax
  108475:	e8 96 c2 ff ff       	call   104710 <debug_panic>
  10847a:	83 c4 20             	add    $0x20,%esp
}
  10847d:	83 c4 0c             	add    $0xc,%esp
  108480:	5b                   	pop    %ebx
  108481:	5e                   	pop    %esi
  108482:	5f                   	pop    %edi
  108483:	5d                   	pop    %ebp
  108484:	c3                   	ret    
  108485:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10848c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00108490 <exception_handler>:
/**
 * We currently only handle the page fault exception.
 * All other exceptions should be routed to the default exception handler.
 */
void exception_handler(tf_t *tf)
{
  108490:	56                   	push   %esi
  108491:	53                   	push   %ebx
  108492:	e8 f2 7e ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  108497:	81 c3 69 bb 00 00    	add    $0xbb69,%ebx
  10849d:	83 ec 04             	sub    $0x4,%esp
  1084a0:	8b 74 24 10          	mov    0x10(%esp),%esi
    if (tf->trapno == T_PGFLT)
  1084a4:	83 7e 28 0e          	cmpl   $0xe,0x28(%esi)
  1084a8:	74 36                	je     1084e0 <exception_handler+0x50>
    cur_pid = get_curid();
  1084aa:	e8 a1 f4 ff ff       	call   107950 <get_curid>
    if (tf == NULL)
  1084af:	89 f0                	mov    %esi,%eax
  1084b1:	e8 fa fc ff ff       	call   1081b0 <trap_dump.part.0>
    KERN_PANIC("Trap %d @ 0x%08x.\n", tf->trapno, tf->eip);
  1084b6:	83 ec 0c             	sub    $0xc,%esp
  1084b9:	8d 83 51 89 ff ff    	lea    -0x76af(%ebx),%eax
  1084bf:	ff 76 30             	push   0x30(%esi)
  1084c2:	ff 76 28             	push   0x28(%esi)
  1084c5:	50                   	push   %eax
  1084c6:	8d 83 64 89 ff ff    	lea    -0x769c(%ebx),%eax
  1084cc:	6a 33                	push   $0x33
  1084ce:	50                   	push   %eax
  1084cf:	e8 3c c2 ff ff       	call   104710 <debug_panic>
        pgflt_handler(tf);
    else
        default_exception_handler(tf);
}
  1084d4:	83 c4 24             	add    $0x24,%esp
  1084d7:	5b                   	pop    %ebx
  1084d8:	5e                   	pop    %esi
  1084d9:	c3                   	ret    
  1084da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        pgflt_handler(tf);
  1084e0:	89 74 24 10          	mov    %esi,0x10(%esp)
}
  1084e4:	83 c4 04             	add    $0x4,%esp
  1084e7:	5b                   	pop    %ebx
  1084e8:	5e                   	pop    %esi
        pgflt_handler(tf);
  1084e9:	e9 f2 fe ff ff       	jmp    1083e0 <pgflt_handler>
  1084ee:	66 90                	xchg   %ax,%ax

001084f0 <interrupt_handler>:
/**
 * Any interrupt request other than the spurious or timer should be
 * routed to the default interrupt handler.
 */
void interrupt_handler(tf_t *tf)
{
  1084f0:	53                   	push   %ebx
  1084f1:	e8 93 7e ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1084f6:	81 c3 0a bb 00 00    	add    $0xbb0a,%ebx
  1084fc:	83 ec 08             	sub    $0x8,%esp
    switch (tf->trapno) {
  1084ff:	8b 44 24 10          	mov    0x10(%esp),%eax
  108503:	8b 40 28             	mov    0x28(%eax),%eax
  108506:	83 f8 20             	cmp    $0x20,%eax
  108509:	74 15                	je     108520 <interrupt_handler+0x30>
  10850b:	83 f8 27             	cmp    $0x27,%eax
  10850e:	74 05                	je     108515 <interrupt_handler+0x25>
    intr_eoi();
  108510:	e8 fb 93 ff ff       	call   101910 <intr_eoi>
        break;
    // TODO: handle the disk interrupts here
    default:
        default_intr_handler();
    }
}
  108515:	83 c4 08             	add    $0x8,%esp
  108518:	5b                   	pop    %ebx
  108519:	c3                   	ret    
  10851a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    intr_eoi();
  108520:	e8 eb 93 ff ff       	call   101910 <intr_eoi>
    sched_update();
  108525:	e8 26 f6 ff ff       	call   107b50 <sched_update>
}
  10852a:	83 c4 08             	add    $0x8,%esp
  10852d:	5b                   	pop    %ebx
  10852e:	c3                   	ret    
  10852f:	90                   	nop

00108530 <trap>:

unsigned int last_active[NUM_CPUS];

void trap(tf_t *tf)
{
  108530:	55                   	push   %ebp
  108531:	57                   	push   %edi
  108532:	56                   	push   %esi
  108533:	53                   	push   %ebx
  108534:	e8 50 7e ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  108539:	81 c3 c7 ba 00 00    	add    $0xbac7,%ebx
  10853f:	83 ec 1c             	sub    $0x1c,%esp
    unsigned int cur_pid = get_curid();
  108542:	e8 09 f4 ff ff       	call   107950 <get_curid>
    unsigned int cpu_idx = get_pcpu_idx();
    trap_cb_t handler;

    unsigned int last_pid = last_active[cpu_idx];
  108547:	8d ab 00 80 d0 00    	lea    0xd08000(%ebx),%ebp
    unsigned int cur_pid = get_curid();
  10854d:	89 44 24 0c          	mov    %eax,0xc(%esp)
    unsigned int cpu_idx = get_pcpu_idx();
  108551:	e8 2a dc ff ff       	call   106180 <get_pcpu_idx>
    unsigned int last_pid = last_active[cpu_idx];
  108556:	8b 7c 85 00          	mov    0x0(%ebp,%eax,4),%edi
    unsigned int cpu_idx = get_pcpu_idx();
  10855a:	89 c6                	mov    %eax,%esi

    if (last_pid != 0)
  10855c:	85 ff                	test   %edi,%edi
  10855e:	75 48                	jne    1085a8 <trap+0x78>
    {
        set_pdir_base(0);  // switch to the kernel's page table
        last_active[cpu_idx] = 0;
    }

    handler = TRAP_HANDLER[get_pcpu_idx()][tf->trapno];
  108560:	e8 1b dc ff ff       	call   106180 <get_pcpu_idx>
  108565:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  108569:	c1 e0 08             	shl    $0x8,%eax
  10856c:	8b 51 28             	mov    0x28(%ecx),%edx
  10856f:	c7 c1 20 c0 e1 00    	mov    $0xe1c020,%ecx
  108575:	01 d0                	add    %edx,%eax
  108577:	8b 04 81             	mov    (%ecx,%eax,4),%eax

    if (handler) {
  10857a:	85 c0                	test   %eax,%eax
  10857c:	74 62                	je     1085e0 <trap+0xb0>
        handler(tf);
  10857e:	83 ec 0c             	sub    $0xc,%esp
  108581:	ff 74 24 3c          	push   0x3c(%esp)
  108585:	ff d0                	call   *%eax
  108587:	83 c4 10             	add    $0x10,%esp
    } else {
        KERN_WARN("No handler for user trap 0x%x, process %d, eip 0x%08x.\n",
                  tf->trapno, cur_pid, tf->eip);
    }

    if (last_pid != 0)
  10858a:	85 ff                	test   %edi,%edi
  10858c:	75 32                	jne    1085c0 <trap+0x90>
        kstack_switch(cur_pid);
        set_pdir_base(cur_pid);
        last_active[cpu_idx] = last_pid;
    }

    trap_return((void *) tf);
  10858e:	83 ec 0c             	sub    $0xc,%esp
  108591:	ff 74 24 3c          	push   0x3c(%esp)
  108595:	e8 76 9c ff ff       	call   102210 <trap_return>
}
  10859a:	83 c4 2c             	add    $0x2c,%esp
  10859d:	5b                   	pop    %ebx
  10859e:	5e                   	pop    %esi
  10859f:	5f                   	pop    %edi
  1085a0:	5d                   	pop    %ebp
  1085a1:	c3                   	ret    
  1085a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        set_pdir_base(0);  // switch to the kernel's page table
  1085a8:	83 ec 0c             	sub    $0xc,%esp
  1085ab:	6a 00                	push   $0x0
  1085ad:	e8 0e e6 ff ff       	call   106bc0 <set_pdir_base>
        last_active[cpu_idx] = 0;
  1085b2:	c7 44 b5 00 00 00 00 	movl   $0x0,0x0(%ebp,%esi,4)
  1085b9:	00 
  1085ba:	83 c4 10             	add    $0x10,%esp
  1085bd:	eb a1                	jmp    108560 <trap+0x30>
  1085bf:	90                   	nop
        kstack_switch(cur_pid);
  1085c0:	83 ec 0c             	sub    $0xc,%esp
  1085c3:	ff 74 24 18          	push   0x18(%esp)
  1085c7:	e8 a4 c9 ff ff       	call   104f70 <kstack_switch>
        set_pdir_base(cur_pid);
  1085cc:	58                   	pop    %eax
  1085cd:	ff 74 24 18          	push   0x18(%esp)
  1085d1:	e8 ea e5 ff ff       	call   106bc0 <set_pdir_base>
        last_active[cpu_idx] = last_pid;
  1085d6:	89 7c b5 00          	mov    %edi,0x0(%ebp,%esi,4)
  1085da:	83 c4 10             	add    $0x10,%esp
  1085dd:	eb af                	jmp    10858e <trap+0x5e>
  1085df:	90                   	nop
        KERN_WARN("No handler for user trap 0x%x, process %d, eip 0x%08x.\n",
  1085e0:	83 ec 08             	sub    $0x8,%esp
  1085e3:	8b 44 24 38          	mov    0x38(%esp),%eax
  1085e7:	ff 70 30             	push   0x30(%eax)
  1085ea:	8d 83 f8 89 ff ff    	lea    -0x7608(%ebx),%eax
  1085f0:	ff 74 24 18          	push   0x18(%esp)
  1085f4:	52                   	push   %edx
  1085f5:	50                   	push   %eax
  1085f6:	8d 83 64 89 ff ff    	lea    -0x769c(%ebx),%eax
  1085fc:	68 97 00 00 00       	push   $0x97
  108601:	50                   	push   %eax
  108602:	e8 f9 c1 ff ff       	call   104800 <debug_warn>
  108607:	83 c4 20             	add    $0x20,%esp
  10860a:	e9 7b ff ff ff       	jmp    10858a <trap+0x5a>
  10860f:	90                   	nop

00108610 <trap_init_array>:
int inited = FALSE;

trap_cb_t TRAP_HANDLER[NUM_CPUS][256];

void trap_init_array(void)
{
  108610:	53                   	push   %ebx
  108611:	e8 73 7d ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  108616:	81 c3 ea b9 00 00    	add    $0xb9ea,%ebx
  10861c:	83 ec 08             	sub    $0x8,%esp
    KERN_ASSERT(inited == FALSE);
  10861f:	8b 83 20 a0 d0 00    	mov    0xd0a020(%ebx),%eax
  108625:	85 c0                	test   %eax,%eax
  108627:	75 27                	jne    108650 <trap_init_array+0x40>
    memzero(&TRAP_HANDLER, sizeof(trap_cb_t) * 8 * 256);
  108629:	83 ec 08             	sub    $0x8,%esp
  10862c:	8d 83 20 80 d0 00    	lea    0xd08020(%ebx),%eax
  108632:	68 00 20 00 00       	push   $0x2000
  108637:	50                   	push   %eax
  108638:	e8 f3 be ff ff       	call   104530 <memzero>
    inited = TRUE;
  10863d:	c7 83 20 a0 d0 00 01 	movl   $0x1,0xd0a020(%ebx)
  108644:	00 00 00 
}
  108647:	83 c4 18             	add    $0x18,%esp
  10864a:	5b                   	pop    %ebx
  10864b:	c3                   	ret    
  10864c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    KERN_ASSERT(inited == FALSE);
  108650:	8d 83 30 8a ff ff    	lea    -0x75d0(%ebx),%eax
  108656:	50                   	push   %eax
  108657:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  10865d:	50                   	push   %eax
  10865e:	8d 83 a8 8a ff ff    	lea    -0x7558(%ebx),%eax
  108664:	6a 11                	push   $0x11
  108666:	50                   	push   %eax
  108667:	e8 a4 c0 ff ff       	call   104710 <debug_panic>
  10866c:	83 c4 10             	add    $0x10,%esp
  10866f:	eb b8                	jmp    108629 <trap_init_array+0x19>
  108671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  108678:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10867f:	90                   	nop

00108680 <trap_handler_register>:

void trap_handler_register(int cpu_idx, int trapno, trap_cb_t cb)
{
  108680:	55                   	push   %ebp
  108681:	57                   	push   %edi
  108682:	56                   	push   %esi
  108683:	53                   	push   %ebx
  108684:	e8 00 7d ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  108689:	81 c3 77 b9 00 00    	add    $0xb977,%ebx
  10868f:	83 ec 0c             	sub    $0xc,%esp
  108692:	8b 74 24 20          	mov    0x20(%esp),%esi
  108696:	8b 6c 24 24          	mov    0x24(%esp),%ebp
  10869a:	8b 7c 24 28          	mov    0x28(%esp),%edi
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  10869e:	83 fe 07             	cmp    $0x7,%esi
  1086a1:	77 25                	ja     1086c8 <trap_handler_register+0x48>
    KERN_ASSERT(0 <= trapno && trapno < 256);
  1086a3:	81 fd ff 00 00 00    	cmp    $0xff,%ebp
  1086a9:	77 44                	ja     1086ef <trap_handler_register+0x6f>
    KERN_ASSERT(cb != NULL);
  1086ab:	85 ff                	test   %edi,%edi
  1086ad:	74 63                	je     108712 <trap_handler_register+0x92>

    TRAP_HANDLER[cpu_idx][trapno] = cb;
  1086af:	c1 e6 08             	shl    $0x8,%esi
  1086b2:	01 ee                	add    %ebp,%esi
  1086b4:	89 bc b3 20 80 d0 00 	mov    %edi,0xd08020(%ebx,%esi,4)
}
  1086bb:	83 c4 0c             	add    $0xc,%esp
  1086be:	5b                   	pop    %ebx
  1086bf:	5e                   	pop    %esi
  1086c0:	5f                   	pop    %edi
  1086c1:	5d                   	pop    %ebp
  1086c2:	c3                   	ret    
  1086c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1086c7:	90                   	nop
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  1086c8:	8d 83 40 8a ff ff    	lea    -0x75c0(%ebx),%eax
  1086ce:	50                   	push   %eax
  1086cf:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  1086d5:	50                   	push   %eax
  1086d6:	8d 83 a8 8a ff ff    	lea    -0x7558(%ebx),%eax
  1086dc:	6a 18                	push   $0x18
  1086de:	50                   	push   %eax
  1086df:	e8 2c c0 ff ff       	call   104710 <debug_panic>
  1086e4:	83 c4 10             	add    $0x10,%esp
    KERN_ASSERT(0 <= trapno && trapno < 256);
  1086e7:	81 fd ff 00 00 00    	cmp    $0xff,%ebp
  1086ed:	76 bc                	jbe    1086ab <trap_handler_register+0x2b>
  1086ef:	8d 83 5c 8a ff ff    	lea    -0x75a4(%ebx),%eax
  1086f5:	50                   	push   %eax
  1086f6:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  1086fc:	50                   	push   %eax
  1086fd:	8d 83 a8 8a ff ff    	lea    -0x7558(%ebx),%eax
  108703:	6a 19                	push   $0x19
  108705:	50                   	push   %eax
  108706:	e8 05 c0 ff ff       	call   104710 <debug_panic>
  10870b:	83 c4 10             	add    $0x10,%esp
    KERN_ASSERT(cb != NULL);
  10870e:	85 ff                	test   %edi,%edi
  108710:	75 9d                	jne    1086af <trap_handler_register+0x2f>
  108712:	8d 83 78 8a ff ff    	lea    -0x7588(%ebx),%eax
  108718:	50                   	push   %eax
  108719:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  10871f:	50                   	push   %eax
  108720:	8d 83 a8 8a ff ff    	lea    -0x7558(%ebx),%eax
  108726:	6a 1a                	push   $0x1a
  108728:	50                   	push   %eax
  108729:	e8 e2 bf ff ff       	call   104710 <debug_panic>
  10872e:	83 c4 10             	add    $0x10,%esp
  108731:	e9 79 ff ff ff       	jmp    1086af <trap_handler_register+0x2f>
  108736:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10873d:	8d 76 00             	lea    0x0(%esi),%esi

00108740 <trap_init>:

void trap_init(unsigned int cpu_idx)
{
  108740:	55                   	push   %ebp
  108741:	57                   	push   %edi
  108742:	56                   	push   %esi
  108743:	53                   	push   %ebx
  108744:	e8 40 7c ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  108749:	81 c3 b7 b8 00 00    	add    $0xb8b7,%ebx
  10874f:	83 ec 2c             	sub    $0x2c,%esp
  108752:	8b 6c 24 40          	mov    0x40(%esp),%ebp
    int trapno;

    if (cpu_idx == 0) {
  108756:	85 ed                	test   %ebp,%ebp
  108758:	0f 84 2f 02 00 00    	je     10898d <trap_init+0x24d>
        trap_init_array();
    }

    KERN_INFO_CPU("Register trap handlers...\n", cpu_idx);
  10875e:	83 ec 08             	sub    $0x8,%esp
  108761:	8d 83 38 8b ff ff    	lea    -0x74c8(%ebx),%eax
  108767:	55                   	push   %ebp
  108768:	50                   	push   %eax
  108769:	e8 02 bf ff ff       	call   104670 <debug_info>
  10876e:	83 c4 10             	add    $0x10,%esp
  108771:	8d 83 20 80 d0 00    	lea    0xd08020(%ebx),%eax
  108777:	89 44 24 18          	mov    %eax,0x18(%esp)
    TRAP_HANDLER[cpu_idx][trapno] = cb;
  10877b:	c7 c0 90 84 10 00    	mov    $0x108490,%eax
  108781:	89 ea                	mov    %ebp,%edx
  108783:	89 6c 24 40          	mov    %ebp,0x40(%esp)
{
  108787:	31 f6                	xor    %esi,%esi
  108789:	c1 e2 0a             	shl    $0xa,%edx
  10878c:	bf 01 00 00 00       	mov    $0x1,%edi
  108791:	03 54 24 18          	add    0x18(%esp),%edx
    TRAP_HANDLER[cpu_idx][trapno] = cb;
  108795:	89 44 24 04          	mov    %eax,0x4(%esp)
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  108799:	8d 83 40 8a ff ff    	lea    -0x75c0(%ebx),%eax
  10879f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1087a3:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  1087a9:	89 44 24 10          	mov    %eax,0x10(%esp)
  1087ad:	8d 83 a8 8a ff ff    	lea    -0x7558(%ebx),%eax
  1087b3:	89 44 24 14          	mov    %eax,0x14(%esp)
    TRAP_HANDLER[cpu_idx][trapno] = cb;
  1087b7:	c7 c0 80 80 10 00    	mov    $0x108080,%eax
  1087bd:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  1087c1:	c7 c0 f0 84 10 00    	mov    $0x1084f0,%eax
  1087c7:	89 04 24             	mov    %eax,(%esp)
  1087ca:	eb 1b                	jmp    1087e7 <trap_init+0xa7>
  1087cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                 || (trapno == T_IRQ0 + IRQ_ERROR) || (trapno == T_IRQ0 + IRQ_EHCI_2)
                 || (T_LTIMER <= trapno && trapno <= T_PERFCTR)) {
            trap_handler_register(cpu_idx, trapno, interrupt_handler);
        }
        // Syscall
        else if (trapno == T_SYSCALL) {
  1087d0:	83 fe 30             	cmp    $0x30,%esi
  1087d3:	0f 84 17 01 00 00    	je     1088f0 <trap_init+0x1b0>
    for (trapno = 0; trapno < 256; trapno++) {
  1087d9:	81 ff 00 01 00 00    	cmp    $0x100,%edi
  1087df:	74 43                	je     108824 <trap_init+0xe4>
  1087e1:	83 c6 01             	add    $0x1,%esi
  1087e4:	83 c7 01             	add    $0x1,%edi
        if ((T_DIVIDE <= trapno && trapno <= T_SIMD) || trapno == T_SECEV) {
  1087e7:	83 fe 13             	cmp    $0x13,%esi
  1087ea:	0f 86 a0 00 00 00    	jbe    108890 <trap_init+0x150>
  1087f0:	83 fe 1e             	cmp    $0x1e,%esi
  1087f3:	0f 84 97 00 00 00    	je     108890 <trap_init+0x150>
        else if ((T_IRQ0 + IRQ_TIMER <= trapno && trapno <= T_IRQ0 + IRQ_RTC)
  1087f9:	8d 46 e0             	lea    -0x20(%esi),%eax
  1087fc:	83 f8 17             	cmp    $0x17,%eax
  1087ff:	77 cf                	ja     1087d0 <trap_init+0x90>
  108801:	b9 00 0e 71 ff       	mov    $0xff710e00,%ecx
  108806:	0f a3 c1             	bt     %eax,%ecx
  108809:	72 c5                	jb     1087d0 <trap_init+0x90>
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  10880b:	83 7c 24 40 07       	cmpl   $0x7,0x40(%esp)
  108810:	0f 87 92 00 00 00    	ja     1088a8 <trap_init+0x168>
    TRAP_HANDLER[cpu_idx][trapno] = cb;
  108816:	8b 04 24             	mov    (%esp),%eax
  108819:	89 04 b2             	mov    %eax,(%edx,%esi,4)
    for (trapno = 0; trapno < 256; trapno++) {
  10881c:	81 ff 00 01 00 00    	cmp    $0x100,%edi
  108822:	75 bd                	jne    1087e1 <trap_init+0xa1>
            trap_handler_register(cpu_idx, trapno, syscall_dispatch);
        }
    }

    KERN_INFO_CPU("Done.\n", cpu_idx);
  108824:	8b 6c 24 40          	mov    0x40(%esp),%ebp
  108828:	85 ed                	test   %ebp,%ebp
  10882a:	0f 85 02 01 00 00    	jne    108932 <trap_init+0x1f2>
  108830:	83 ec 0c             	sub    $0xc,%esp
  108833:	8d b3 83 8a ff ff    	lea    -0x757d(%ebx),%esi
  108839:	56                   	push   %esi
  10883a:	e8 31 be ff ff       	call   104670 <debug_info>
    KERN_INFO_CPU("Enabling interrupts...\n", cpu_idx);
  10883f:	8d 83 f0 8a ff ff    	lea    -0x7510(%ebx),%eax
  108845:	89 04 24             	mov    %eax,(%esp)
  108848:	e8 23 be ff ff       	call   104670 <debug_info>

    /* enable interrupts */
    intr_enable(IRQ_TIMER, cpu_idx);
  10884d:	5d                   	pop    %ebp
  10884e:	58                   	pop    %eax
  10884f:	6a 00                	push   $0x0
  108851:	6a 00                	push   $0x0
  108853:	e8 38 8f ff ff       	call   101790 <intr_enable>
    intr_enable(IRQ_KBD, cpu_idx);
  108858:	58                   	pop    %eax
  108859:	5a                   	pop    %edx
  10885a:	6a 00                	push   $0x0
  10885c:	6a 01                	push   $0x1
  10885e:	e8 2d 8f ff ff       	call   101790 <intr_enable>
    intr_enable(IRQ_SERIAL13, cpu_idx);
  108863:	59                   	pop    %ecx
  108864:	5f                   	pop    %edi
  108865:	6a 00                	push   $0x0
  108867:	6a 04                	push   $0x4
  108869:	e8 22 8f ff ff       	call   101790 <intr_enable>
    intr_enable(IRQ_IDE1, cpu_idx);
  10886e:	5d                   	pop    %ebp
  10886f:	58                   	pop    %eax
  108870:	6a 00                	push   $0x0
  108872:	6a 0e                	push   $0xe
  108874:	e8 17 8f ff ff       	call   101790 <intr_enable>

    KERN_INFO_CPU("Done.\n", cpu_idx);
  108879:	89 34 24             	mov    %esi,(%esp)
  10887c:	e8 ef bd ff ff       	call   104670 <debug_info>
  108881:	83 c4 10             	add    $0x10,%esp
}
  108884:	83 c4 2c             	add    $0x2c,%esp
  108887:	5b                   	pop    %ebx
  108888:	5e                   	pop    %esi
  108889:	5f                   	pop    %edi
  10888a:	5d                   	pop    %ebp
  10888b:	c3                   	ret    
  10888c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  108890:	83 7c 24 40 07       	cmpl   $0x7,0x40(%esp)
  108895:	77 39                	ja     1088d0 <trap_init+0x190>
    TRAP_HANDLER[cpu_idx][trapno] = cb;
  108897:	8b 44 24 04          	mov    0x4(%esp),%eax
  10889b:	89 04 b2             	mov    %eax,(%edx,%esi,4)
}
  10889e:	e9 36 ff ff ff       	jmp    1087d9 <trap_init+0x99>
  1088a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1088a7:	90                   	nop
  1088a8:	89 54 24 08          	mov    %edx,0x8(%esp)
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  1088ac:	ff 74 24 0c          	push   0xc(%esp)
  1088b0:	ff 74 24 14          	push   0x14(%esp)
  1088b4:	6a 18                	push   $0x18
  1088b6:	ff 74 24 20          	push   0x20(%esp)
  1088ba:	e8 51 be ff ff       	call   104710 <debug_panic>
  1088bf:	83 c4 10             	add    $0x10,%esp
  1088c2:	8b 54 24 08          	mov    0x8(%esp),%edx
  1088c6:	e9 4b ff ff ff       	jmp    108816 <trap_init+0xd6>
  1088cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1088cf:	90                   	nop
  1088d0:	89 54 24 08          	mov    %edx,0x8(%esp)
  1088d4:	ff 74 24 0c          	push   0xc(%esp)
  1088d8:	ff 74 24 14          	push   0x14(%esp)
  1088dc:	6a 18                	push   $0x18
  1088de:	ff 74 24 20          	push   0x20(%esp)
  1088e2:	e8 29 be ff ff       	call   104710 <debug_panic>
  1088e7:	83 c4 10             	add    $0x10,%esp
  1088ea:	8b 54 24 08          	mov    0x8(%esp),%edx
  1088ee:	eb a7                	jmp    108897 <trap_init+0x157>
  1088f0:	83 7c 24 40 07       	cmpl   $0x7,0x40(%esp)
  1088f5:	77 1b                	ja     108912 <trap_init+0x1d2>
    TRAP_HANDLER[cpu_idx][trapno] = cb;
  1088f7:	8b 44 24 40          	mov    0x40(%esp),%eax
  1088fb:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  1088ff:	8b 6c 24 1c          	mov    0x1c(%esp),%ebp
  108903:	c1 e0 0a             	shl    $0xa,%eax
  108906:	89 ac 08 c0 00 00 00 	mov    %ebp,0xc0(%eax,%ecx,1)
    for (trapno = 0; trapno < 256; trapno++) {
  10890d:	e9 cf fe ff ff       	jmp    1087e1 <trap_init+0xa1>
  108912:	89 54 24 08          	mov    %edx,0x8(%esp)
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  108916:	ff 74 24 0c          	push   0xc(%esp)
  10891a:	ff 74 24 14          	push   0x14(%esp)
  10891e:	6a 18                	push   $0x18
  108920:	ff 74 24 20          	push   0x20(%esp)
  108924:	e8 e7 bd ff ff       	call   104710 <debug_panic>
  108929:	83 c4 10             	add    $0x10,%esp
  10892c:	8b 54 24 08          	mov    0x8(%esp),%edx
  108930:	eb c5                	jmp    1088f7 <trap_init+0x1b7>
    KERN_INFO_CPU("Done.\n", cpu_idx);
  108932:	83 ec 08             	sub    $0x8,%esp
  108935:	8d b3 95 8a ff ff    	lea    -0x756b(%ebx),%esi
  10893b:	55                   	push   %ebp
  10893c:	56                   	push   %esi
  10893d:	e8 2e bd ff ff       	call   104670 <debug_info>
    KERN_INFO_CPU("Enabling interrupts...\n", cpu_idx);
  108942:	58                   	pop    %eax
  108943:	8d 83 14 8b ff ff    	lea    -0x74ec(%ebx),%eax
  108949:	5a                   	pop    %edx
  10894a:	55                   	push   %ebp
  10894b:	50                   	push   %eax
  10894c:	e8 1f bd ff ff       	call   104670 <debug_info>
    intr_enable(IRQ_TIMER, cpu_idx);
  108951:	59                   	pop    %ecx
  108952:	5f                   	pop    %edi
  108953:	55                   	push   %ebp
  108954:	6a 00                	push   $0x0
  108956:	e8 35 8e ff ff       	call   101790 <intr_enable>
    intr_enable(IRQ_KBD, cpu_idx);
  10895b:	58                   	pop    %eax
  10895c:	5a                   	pop    %edx
  10895d:	55                   	push   %ebp
  10895e:	6a 01                	push   $0x1
  108960:	e8 2b 8e ff ff       	call   101790 <intr_enable>
    intr_enable(IRQ_SERIAL13, cpu_idx);
  108965:	59                   	pop    %ecx
  108966:	5f                   	pop    %edi
  108967:	55                   	push   %ebp
  108968:	6a 04                	push   $0x4
  10896a:	e8 21 8e ff ff       	call   101790 <intr_enable>
    intr_enable(IRQ_IDE1, cpu_idx);
  10896f:	58                   	pop    %eax
  108970:	5a                   	pop    %edx
  108971:	55                   	push   %ebp
  108972:	6a 0e                	push   $0xe
  108974:	e8 17 8e ff ff       	call   101790 <intr_enable>
    KERN_INFO_CPU("Done.\n", cpu_idx);
  108979:	59                   	pop    %ecx
  10897a:	5f                   	pop    %edi
  10897b:	55                   	push   %ebp
  10897c:	56                   	push   %esi
  10897d:	e8 ee bc ff ff       	call   104670 <debug_info>
  108982:	83 c4 10             	add    $0x10,%esp
}
  108985:	83 c4 2c             	add    $0x2c,%esp
  108988:	5b                   	pop    %ebx
  108989:	5e                   	pop    %esi
  10898a:	5f                   	pop    %edi
  10898b:	5d                   	pop    %ebp
  10898c:	c3                   	ret    
    KERN_ASSERT(inited == FALSE);
  10898d:	8b 83 20 a0 d0 00    	mov    0xd0a020(%ebx),%eax
  108993:	85 c0                	test   %eax,%eax
  108995:	75 38                	jne    1089cf <trap_init+0x28f>
    memzero(&TRAP_HANDLER, sizeof(trap_cb_t) * 8 * 256);
  108997:	83 ec 08             	sub    $0x8,%esp
  10899a:	8d 83 20 80 d0 00    	lea    0xd08020(%ebx),%eax
  1089a0:	68 00 20 00 00       	push   $0x2000
  1089a5:	89 44 24 24          	mov    %eax,0x24(%esp)
  1089a9:	50                   	push   %eax
  1089aa:	e8 81 bb ff ff       	call   104530 <memzero>
    KERN_INFO_CPU("Register trap handlers...\n", cpu_idx);
  1089af:	8d 83 c8 8a ff ff    	lea    -0x7538(%ebx),%eax
    inited = TRUE;
  1089b5:	c7 83 20 a0 d0 00 01 	movl   $0x1,0xd0a020(%ebx)
  1089bc:	00 00 00 
    KERN_INFO_CPU("Register trap handlers...\n", cpu_idx);
  1089bf:	89 04 24             	mov    %eax,(%esp)
  1089c2:	e8 a9 bc ff ff       	call   104670 <debug_info>
  1089c7:	83 c4 10             	add    $0x10,%esp
  1089ca:	e9 ac fd ff ff       	jmp    10877b <trap_init+0x3b>
    KERN_ASSERT(inited == FALSE);
  1089cf:	8d 83 30 8a ff ff    	lea    -0x75d0(%ebx),%eax
  1089d5:	50                   	push   %eax
  1089d6:	8d 83 bf 72 ff ff    	lea    -0x8d41(%ebx),%eax
  1089dc:	50                   	push   %eax
  1089dd:	8d 83 a8 8a ff ff    	lea    -0x7558(%ebx),%eax
  1089e3:	6a 11                	push   $0x11
  1089e5:	50                   	push   %eax
  1089e6:	e8 25 bd ff ff       	call   104710 <debug_panic>
  1089eb:	83 c4 10             	add    $0x10,%esp
  1089ee:	eb a7                	jmp    108997 <trap_init+0x257>

001089f0 <bufcache_init>:
    // head.next is most recently used.
    struct buf head;
} bcache;

void bufcache_init(void)
{
  1089f0:	57                   	push   %edi
  1089f1:	56                   	push   %esi
  1089f2:	e8 79 02 00 00       	call   108c70 <__x86.get_pc_thunk.si>
  1089f7:	81 c6 09 b6 00 00    	add    $0xb609,%esi
  1089fd:	53                   	push   %ebx
    struct buf *b;

    spinlock_init(&bcache.lock);
  1089fe:	83 ec 0c             	sub    $0xc,%esp
  108a01:	8d be 40 a0 d0 00    	lea    0xd0a040(%esi),%edi
  108a07:	89 f3                	mov    %esi,%ebx
  108a09:	57                   	push   %edi
  108a0a:	e8 d1 d3 ff ff       	call   105de0 <spinlock_init>

    // Create linked list of buffers
    bcache.head.prev = &bcache.head;
  108a0f:	8d 97 f8 14 00 00    	lea    0x14f8(%edi),%edx
  108a15:	83 c4 10             	add    $0x10,%esp
    bcache.head.next = &bcache.head;
    for (b = bcache.buf; b < bcache.buf + NBUF; b++) {
  108a18:	8d 47 08             	lea    0x8(%edi),%eax
    bcache.head.prev = &bcache.head;
  108a1b:	89 96 44 b5 d0 00    	mov    %edx,0xd0b544(%esi)
    for (b = bcache.buf; b < bcache.buf + NBUF; b++) {
  108a21:	8d 9e 38 b5 d0 00    	lea    0xd0b538(%esi),%ebx
  108a27:	eb 09                	jmp    108a32 <bufcache_init+0x42>
  108a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  108a30:	89 c8                	mov    %ecx,%eax
  108a32:	8d 88 18 02 00 00    	lea    0x218(%eax),%ecx
        b->next = bcache.head.next;
  108a38:	89 50 10             	mov    %edx,0x10(%eax)
        b->prev = &bcache.head;
  108a3b:	89 58 0c             	mov    %ebx,0xc(%eax)
        b->dev = -1;
  108a3e:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
        bcache.head.next->prev = b;
  108a45:	89 42 0c             	mov    %eax,0xc(%edx)
    for (b = bcache.buf; b < bcache.buf + NBUF; b++) {
  108a48:	89 c2                	mov    %eax,%edx
  108a4a:	39 d9                	cmp    %ebx,%ecx
  108a4c:	75 e2                	jne    108a30 <bufcache_init+0x40>
        bcache.head.next = b;
    }
}
  108a4e:	5b                   	pop    %ebx
  108a4f:	89 86 48 b5 d0 00    	mov    %eax,0xd0b548(%esi)
  108a55:	5e                   	pop    %esi
  108a56:	5f                   	pop    %edi
  108a57:	c3                   	ret    
  108a58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  108a5f:	90                   	nop

00108a60 <bufcache_read>:

/**
 * Return a B_BUSY buf with the contents of the indicated disk sector.
 */
struct buf *bufcache_read(uint32_t dev, uint32_t sector)
{
  108a60:	55                   	push   %ebp
  108a61:	57                   	push   %edi
  108a62:	56                   	push   %esi
  108a63:	53                   	push   %ebx
  108a64:	e8 20 79 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  108a69:	81 c3 97 b5 00 00    	add    $0xb597,%ebx
  108a6f:	83 ec 28             	sub    $0x28,%esp
  108a72:	8b 6c 24 3c          	mov    0x3c(%esp),%ebp
    spinlock_acquire(&bcache.lock);
  108a76:	8d 83 40 a0 d0 00    	lea    0xd0a040(%ebx),%eax
  108a7c:	8d bb 38 b5 d0 00    	lea    0xd0b538(%ebx),%edi
  108a82:	89 44 24 14          	mov    %eax,0x14(%esp)
  108a86:	50                   	push   %eax
  108a87:	e8 e4 d3 ff ff       	call   105e70 <spinlock_acquire>
  108a8c:	8b 44 24 44          	mov    0x44(%esp),%eax
  108a90:	83 c4 10             	add    $0x10,%esp
  108a93:	8d 0d 40 a0 d0 00    	lea    0xd0a040,%ecx
    for (b = bcache.head.next; b != &bcache.head; b = b->next) {
  108a99:	8b b4 19 08 15 00 00 	mov    0x1508(%ecx,%ebx,1),%esi
  108aa0:	39 fe                	cmp    %edi,%esi
  108aa2:	75 13                	jne    108ab7 <bufcache_read+0x57>
  108aa4:	eb 4a                	jmp    108af0 <bufcache_read+0x90>
  108aa6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  108aad:	8d 76 00             	lea    0x0(%esi),%esi
  108ab0:	8b 76 10             	mov    0x10(%esi),%esi
  108ab3:	39 fe                	cmp    %edi,%esi
  108ab5:	74 39                	je     108af0 <bufcache_read+0x90>
        if (b->dev == dev && b->sector == sector) {
  108ab7:	3b 6e 04             	cmp    0x4(%esi),%ebp
  108aba:	75 f4                	jne    108ab0 <bufcache_read+0x50>
  108abc:	3b 46 08             	cmp    0x8(%esi),%eax
  108abf:	75 ef                	jne    108ab0 <bufcache_read+0x50>
            if (!(b->flags & B_BUSY)) {
  108ac1:	8b 16                	mov    (%esi),%edx
  108ac3:	f6 c2 01             	test   $0x1,%dl
  108ac6:	0f 84 8a 00 00 00    	je     108b56 <bufcache_read+0xf6>
  108acc:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
            thread_sleep(b, &bcache.lock);
  108ad0:	83 ec 08             	sub    $0x8,%esp
  108ad3:	89 44 24 3c          	mov    %eax,0x3c(%esp)
  108ad7:	ff 74 24 10          	push   0x10(%esp)
  108adb:	56                   	push   %esi
  108adc:	e8 df f0 ff ff       	call   107bc0 <thread_sleep>
            goto loop;
  108ae1:	83 c4 10             	add    $0x10,%esp
  108ae4:	8b 44 24 34          	mov    0x34(%esp),%eax
  108ae8:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  108aec:	eb ab                	jmp    108a99 <bufcache_read+0x39>
  108aee:	66 90                	xchg   %ax,%ax
    for (b = bcache.head.prev; b != &bcache.head; b = b->prev) {
  108af0:	8b b3 44 b5 d0 00    	mov    0xd0b544(%ebx),%esi
  108af6:	39 fe                	cmp    %edi,%esi
  108af8:	75 0d                	jne    108b07 <bufcache_read+0xa7>
  108afa:	eb 72                	jmp    108b6e <bufcache_read+0x10e>
  108afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  108b00:	8b 76 0c             	mov    0xc(%esi),%esi
  108b03:	39 fe                	cmp    %edi,%esi
  108b05:	74 67                	je     108b6e <bufcache_read+0x10e>
        if ((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0) {
  108b07:	f6 06 05             	testb  $0x5,(%esi)
  108b0a:	75 f4                	jne    108b00 <bufcache_read+0xa0>
            spinlock_release(&bcache.lock);
  108b0c:	83 ec 0c             	sub    $0xc,%esp
            b->dev = dev;
  108b0f:	89 6e 04             	mov    %ebp,0x4(%esi)
            b->sector = sector;
  108b12:	89 46 08             	mov    %eax,0x8(%esi)
            b->flags = B_BUSY;
  108b15:	c7 06 01 00 00 00    	movl   $0x1,(%esi)
            spinlock_release(&bcache.lock);
  108b1b:	ff 74 24 14          	push   0x14(%esp)
  108b1f:	e8 cc d3 ff ff       	call   105ef0 <spinlock_release>
            return b;
  108b24:	83 c4 10             	add    $0x10,%esp
    struct buf *b;

    b = bufcache_get(dev, sector);
    if (!(b->flags & B_VALID)) {
  108b27:	f6 06 02             	testb  $0x2,(%esi)
  108b2a:	74 14                	je     108b40 <bufcache_read+0xe0>
        ide_rw(b);
    }
    return b;
}
  108b2c:	83 c4 1c             	add    $0x1c,%esp
  108b2f:	89 f0                	mov    %esi,%eax
  108b31:	5b                   	pop    %ebx
  108b32:	5e                   	pop    %esi
  108b33:	5f                   	pop    %edi
  108b34:	5d                   	pop    %ebp
  108b35:	c3                   	ret    
  108b36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  108b3d:	8d 76 00             	lea    0x0(%esi),%esi
        ide_rw(b);
  108b40:	83 ec 0c             	sub    $0xc,%esp
  108b43:	56                   	push   %esi
  108b44:	e8 97 b4 ff ff       	call   103fe0 <ide_rw>
  108b49:	83 c4 10             	add    $0x10,%esp
}
  108b4c:	89 f0                	mov    %esi,%eax
  108b4e:	83 c4 1c             	add    $0x1c,%esp
  108b51:	5b                   	pop    %ebx
  108b52:	5e                   	pop    %esi
  108b53:	5f                   	pop    %edi
  108b54:	5d                   	pop    %ebp
  108b55:	c3                   	ret    
                b->flags |= B_BUSY;
  108b56:	89 d0                	mov    %edx,%eax
                spinlock_release(&bcache.lock);
  108b58:	83 ec 0c             	sub    $0xc,%esp
                b->flags |= B_BUSY;
  108b5b:	83 c8 01             	or     $0x1,%eax
  108b5e:	89 06                	mov    %eax,(%esi)
                spinlock_release(&bcache.lock);
  108b60:	ff 74 24 14          	push   0x14(%esp)
  108b64:	e8 87 d3 ff ff       	call   105ef0 <spinlock_release>
                return b;
  108b69:	83 c4 10             	add    $0x10,%esp
  108b6c:	eb b9                	jmp    108b27 <bufcache_read+0xc7>
    KERN_PANIC("bufcache_get: no buffers");
  108b6e:	50                   	push   %eax
  108b6f:	8d 83 5f 8b ff ff    	lea    -0x74a1(%ebx),%eax
  108b75:	50                   	push   %eax
  108b76:	8d 83 78 8b ff ff    	lea    -0x7488(%ebx),%eax
  108b7c:	6a 5d                	push   $0x5d
  108b7e:	50                   	push   %eax
  108b7f:	e8 8c bb ff ff       	call   104710 <debug_panic>
    if (!(b->flags & B_VALID)) {
  108b84:	a1 00 00 00 00       	mov    0x0,%eax
  108b89:	0f 0b                	ud2    
  108b8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  108b8f:	90                   	nop

00108b90 <bufcache_write>:

/**
 * Write b's contents to disk. Must be B_BUSY.
 */
void bufcache_write(struct buf *b)
{
  108b90:	56                   	push   %esi
  108b91:	53                   	push   %ebx
  108b92:	e8 f2 77 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  108b97:	81 c3 69 b4 00 00    	add    $0xb469,%ebx
  108b9d:	83 ec 04             	sub    $0x4,%esp
  108ba0:	8b 74 24 10          	mov    0x10(%esp),%esi
    if ((b->flags & B_BUSY) == 0)
  108ba4:	8b 06                	mov    (%esi),%eax
  108ba6:	a8 01                	test   $0x1,%al
  108ba8:	74 16                	je     108bc0 <bufcache_write+0x30>
        KERN_PANIC("bwrite");

    b->flags |= B_DIRTY;
    ide_rw(b);
  108baa:	83 ec 0c             	sub    $0xc,%esp
    b->flags |= B_DIRTY;
  108bad:	83 c8 04             	or     $0x4,%eax
  108bb0:	89 06                	mov    %eax,(%esi)
    ide_rw(b);
  108bb2:	56                   	push   %esi
  108bb3:	e8 28 b4 ff ff       	call   103fe0 <ide_rw>
}
  108bb8:	83 c4 14             	add    $0x14,%esp
  108bbb:	5b                   	pop    %ebx
  108bbc:	5e                   	pop    %esi
  108bbd:	c3                   	ret    
  108bbe:	66 90                	xchg   %ax,%ax
        KERN_PANIC("bwrite");
  108bc0:	83 ec 04             	sub    $0x4,%esp
  108bc3:	8d 83 8b 8b ff ff    	lea    -0x7475(%ebx),%eax
  108bc9:	50                   	push   %eax
  108bca:	8d 83 78 8b ff ff    	lea    -0x7488(%ebx),%eax
  108bd0:	6a 75                	push   $0x75
  108bd2:	50                   	push   %eax
  108bd3:	e8 38 bb ff ff       	call   104710 <debug_panic>
    b->flags |= B_DIRTY;
  108bd8:	8b 06                	mov    (%esi),%eax
  108bda:	83 c4 10             	add    $0x10,%esp
  108bdd:	eb cb                	jmp    108baa <bufcache_write+0x1a>
  108bdf:	90                   	nop

00108be0 <bufcache_release>:
/**
 * Release a B_BUSY buffer.
 * Move to the head of the MRU list.
 */
void bufcache_release(struct buf *b)
{
  108be0:	57                   	push   %edi
  108be1:	56                   	push   %esi
  108be2:	53                   	push   %ebx
  108be3:	8b 74 24 10          	mov    0x10(%esp),%esi
  108be7:	e8 9d 77 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  108bec:	81 c3 14 b4 00 00    	add    $0xb414,%ebx
    if ((b->flags & B_BUSY) == 0)
  108bf2:	f6 06 01             	testb  $0x1,(%esi)
  108bf5:	74 59                	je     108c50 <bufcache_release+0x70>
        KERN_PANIC("brelse");

    spinlock_acquire(&bcache.lock);
  108bf7:	83 ec 0c             	sub    $0xc,%esp
  108bfa:	8d bb 40 a0 d0 00    	lea    0xd0a040(%ebx),%edi
  108c00:	57                   	push   %edi
  108c01:	e8 6a d2 ff ff       	call   105e70 <spinlock_acquire>

    b->next->prev = b->prev;
  108c06:	8b 56 10             	mov    0x10(%esi),%edx
  108c09:	8b 46 0c             	mov    0xc(%esi),%eax
  108c0c:	89 42 0c             	mov    %eax,0xc(%edx)
    b->prev->next = b->next;
  108c0f:	89 50 10             	mov    %edx,0x10(%eax)
    b->next = bcache.head.next;
  108c12:	8b 83 48 b5 d0 00    	mov    0xd0b548(%ebx),%eax
    b->prev = &bcache.head;
  108c18:	8d 97 f8 14 00 00    	lea    0x14f8(%edi),%edx
  108c1e:	89 56 0c             	mov    %edx,0xc(%esi)
    b->next = bcache.head.next;
  108c21:	89 46 10             	mov    %eax,0x10(%esi)
    bcache.head.next->prev = b;
  108c24:	89 70 0c             	mov    %esi,0xc(%eax)
    bcache.head.next = b;
  108c27:	89 b3 48 b5 d0 00    	mov    %esi,0xd0b548(%ebx)

    b->flags &= ~B_BUSY;
  108c2d:	83 26 fe             	andl   $0xfffffffe,(%esi)
    thread_wakeup(b);
  108c30:	89 34 24             	mov    %esi,(%esp)
  108c33:	e8 c8 ef ff ff       	call   107c00 <thread_wakeup>

    spinlock_release(&bcache.lock);
  108c38:	89 3c 24             	mov    %edi,(%esp)
  108c3b:	e8 b0 d2 ff ff       	call   105ef0 <spinlock_release>
}
  108c40:	83 c4 10             	add    $0x10,%esp
  108c43:	5b                   	pop    %ebx
  108c44:	5e                   	pop    %esi
  108c45:	5f                   	pop    %edi
  108c46:	c3                   	ret    
  108c47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  108c4e:	66 90                	xchg   %ax,%ax
        KERN_PANIC("brelse");
  108c50:	83 ec 04             	sub    $0x4,%esp
  108c53:	8d 83 92 8b ff ff    	lea    -0x746e(%ebx),%eax
  108c59:	50                   	push   %eax
  108c5a:	8d 83 78 8b ff ff    	lea    -0x7488(%ebx),%eax
  108c60:	68 82 00 00 00       	push   $0x82
  108c65:	50                   	push   %eax
  108c66:	e8 a5 ba ff ff       	call   104710 <debug_panic>
  108c6b:	83 c4 10             	add    $0x10,%esp
  108c6e:	eb 87                	jmp    108bf7 <bufcache_release+0x17>

00108c70 <__x86.get_pc_thunk.si>:
  108c70:	8b 34 24             	mov    (%esp),%esi
  108c73:	c3                   	ret    
  108c74:	66 90                	xchg   %ax,%ax
  108c76:	66 90                	xchg   %ax,%ax
  108c78:	66 90                	xchg   %ax,%ax
  108c7a:	66 90                	xchg   %ax,%ax
  108c7c:	66 90                	xchg   %ax,%ax
  108c7e:	66 90                	xchg   %ax,%ax

00108c80 <install_trans>:
    recover_from_log();
}

// Copy committed blocks from log to their home location.
static void install_trans(void)
{
  108c80:	55                   	push   %ebp
  108c81:	57                   	push   %edi
  108c82:	56                   	push   %esi
  108c83:	53                   	push   %ebx
  108c84:	e8 00 77 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  108c89:	81 c3 77 b3 00 00    	add    $0xb377,%ebx
  108c8f:	83 ec 1c             	sub    $0x1c,%esp
    int tail;

    for (tail = 0; tail < log.lh.n; tail++) {
  108c92:	8b b3 78 b7 d0 00    	mov    0xd0b778(%ebx),%esi
  108c98:	85 f6                	test   %esi,%esi
  108c9a:	7e 79                	jle    108d15 <install_trans+0x95>
  108c9c:	31 ed                	xor    %ebp,%ebp
  108c9e:	8d 3d 60 b7 d0 00    	lea    0xd0b760,%edi
  108ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        struct buf *lbuf = bufcache_read(log.dev, log.start + tail + 1);  // read log block
  108ca8:	8b 44 1f 08          	mov    0x8(%edi,%ebx,1),%eax
  108cac:	83 ec 08             	sub    $0x8,%esp
  108caf:	01 e8                	add    %ebp,%eax
  108cb1:	83 c0 01             	add    $0x1,%eax
  108cb4:	50                   	push   %eax
  108cb5:	ff 74 1f 14          	push   0x14(%edi,%ebx,1)
  108cb9:	e8 a2 fd ff ff       	call   108a60 <bufcache_read>
  108cbe:	89 44 24 1c          	mov    %eax,0x1c(%esp)
        struct buf *dbuf = bufcache_read(log.dev, log.lh.sector[tail]);   // read dst
  108cc2:	58                   	pop    %eax
  108cc3:	5a                   	pop    %edx
  108cc4:	ff b4 ab 7c b7 d0 00 	push   0xd0b77c(%ebx,%ebp,4)
    for (tail = 0; tail < log.lh.n; tail++) {
  108ccb:	83 c5 01             	add    $0x1,%ebp
        struct buf *dbuf = bufcache_read(log.dev, log.lh.sector[tail]);   // read dst
  108cce:	ff 74 1f 14          	push   0x14(%edi,%ebx,1)
  108cd2:	e8 89 fd ff ff       	call   108a60 <bufcache_read>
        memmove(dbuf->data, lbuf->data, BSIZE);                           // copy block to dst
  108cd7:	83 c4 0c             	add    $0xc,%esp
  108cda:	68 00 02 00 00       	push   $0x200
        struct buf *dbuf = bufcache_read(log.dev, log.lh.sector[tail]);   // read dst
  108cdf:	89 c6                	mov    %eax,%esi
        memmove(dbuf->data, lbuf->data, BSIZE);                           // copy block to dst
  108ce1:	8b 44 24 14          	mov    0x14(%esp),%eax
  108ce5:	83 c0 18             	add    $0x18,%eax
  108ce8:	50                   	push   %eax
  108ce9:	8d 46 18             	lea    0x18(%esi),%eax
  108cec:	50                   	push   %eax
  108ced:	e8 ae b6 ff ff       	call   1043a0 <memmove>
        bufcache_write(dbuf);                                             // write dst to disk
  108cf2:	89 34 24             	mov    %esi,(%esp)
  108cf5:	e8 96 fe ff ff       	call   108b90 <bufcache_write>
        bufcache_release(lbuf);
  108cfa:	59                   	pop    %ecx
  108cfb:	ff 74 24 18          	push   0x18(%esp)
  108cff:	e8 dc fe ff ff       	call   108be0 <bufcache_release>
        bufcache_release(dbuf);
  108d04:	89 34 24             	mov    %esi,(%esp)
  108d07:	e8 d4 fe ff ff       	call   108be0 <bufcache_release>
    for (tail = 0; tail < log.lh.n; tail++) {
  108d0c:	83 c4 10             	add    $0x10,%esp
  108d0f:	39 6c 1f 18          	cmp    %ebp,0x18(%edi,%ebx,1)
  108d13:	7f 93                	jg     108ca8 <install_trans+0x28>
    }
}
  108d15:	83 c4 1c             	add    $0x1c,%esp
  108d18:	5b                   	pop    %ebx
  108d19:	5e                   	pop    %esi
  108d1a:	5f                   	pop    %edi
  108d1b:	5d                   	pop    %ebp
  108d1c:	c3                   	ret    
  108d1d:	8d 76 00             	lea    0x0(%esi),%esi

00108d20 <write_head>:
}

// Write in-memory log header to disk.
// This is the true point at which the current transaction commits.
static void write_head(void)
{
  108d20:	57                   	push   %edi
  108d21:	56                   	push   %esi
  108d22:	e8 49 ff ff ff       	call   108c70 <__x86.get_pc_thunk.si>
  108d27:	81 c6 d9 b2 00 00    	add    $0xb2d9,%esi
  108d2d:	53                   	push   %ebx
    struct buf *buf = bufcache_read(log.dev, log.start);
  108d2e:	83 ec 08             	sub    $0x8,%esp
  108d31:	ff b6 68 b7 d0 00    	push   0xd0b768(%esi)
  108d37:	89 f3                	mov    %esi,%ebx
  108d39:	ff b6 74 b7 d0 00    	push   0xd0b774(%esi)
  108d3f:	e8 1c fd ff ff       	call   108a60 <bufcache_read>
    struct logheader *hb = (struct logheader *) (buf->data);
    int i;
    hb->n = log.lh.n;
  108d44:	8b 8e 78 b7 d0 00    	mov    0xd0b778(%esi),%ecx
    for (i = 0; i < log.lh.n; i++) {
  108d4a:	83 c4 10             	add    $0x10,%esp
    struct buf *buf = bufcache_read(log.dev, log.start);
  108d4d:	89 c7                	mov    %eax,%edi
    hb->n = log.lh.n;
  108d4f:	89 48 18             	mov    %ecx,0x18(%eax)
    for (i = 0; i < log.lh.n; i++) {
  108d52:	85 c9                	test   %ecx,%ecx
  108d54:	7e 21                	jle    108d77 <write_head+0x57>
  108d56:	8d 96 7c b7 d0 00    	lea    0xd0b77c(%esi),%edx
  108d5c:	8d 40 1c             	lea    0x1c(%eax),%eax
  108d5f:	8d 5c 8f 1c          	lea    0x1c(%edi,%ecx,4),%ebx
  108d63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  108d67:	90                   	nop
        hb->sector[i] = log.lh.sector[i];
  108d68:	8b 0a                	mov    (%edx),%ecx
    for (i = 0; i < log.lh.n; i++) {
  108d6a:	83 c0 04             	add    $0x4,%eax
  108d6d:	83 c2 04             	add    $0x4,%edx
        hb->sector[i] = log.lh.sector[i];
  108d70:	89 48 fc             	mov    %ecx,-0x4(%eax)
    for (i = 0; i < log.lh.n; i++) {
  108d73:	39 d8                	cmp    %ebx,%eax
  108d75:	75 f1                	jne    108d68 <write_head+0x48>
    }
    bufcache_write(buf);
  108d77:	83 ec 0c             	sub    $0xc,%esp
  108d7a:	89 f3                	mov    %esi,%ebx
  108d7c:	57                   	push   %edi
  108d7d:	e8 0e fe ff ff       	call   108b90 <bufcache_write>
    bufcache_release(buf);
  108d82:	89 3c 24             	mov    %edi,(%esp)
  108d85:	e8 56 fe ff ff       	call   108be0 <bufcache_release>
}
  108d8a:	83 c4 10             	add    $0x10,%esp
  108d8d:	5b                   	pop    %ebx
  108d8e:	5e                   	pop    %esi
  108d8f:	5f                   	pop    %edi
  108d90:	c3                   	ret    
  108d91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  108d98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  108d9f:	90                   	nop

00108da0 <log_init>:
{
  108da0:	57                   	push   %edi
  108da1:	56                   	push   %esi
  108da2:	53                   	push   %ebx
  108da3:	e8 e1 75 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  108da8:	81 c3 58 b2 00 00    	add    $0xb258,%ebx
  108dae:	83 ec 1c             	sub    $0x1c,%esp
    spinlock_init(&log.lock);
  108db1:	8d b3 60 b7 d0 00    	lea    0xd0b760(%ebx),%esi
  108db7:	56                   	push   %esi
  108db8:	e8 23 d0 ff ff       	call   105de0 <spinlock_init>
    read_superblock(ROOTDEV, &sb);
  108dbd:	58                   	pop    %eax
  108dbe:	5a                   	pop    %edx
  108dbf:	8d 44 24 08          	lea    0x8(%esp),%eax
  108dc3:	50                   	push   %eax
  108dc4:	6a 01                	push   $0x1
  108dc6:	e8 85 02 00 00       	call   109050 <read_superblock>
    log.start = sb.size - sb.nlog;
  108dcb:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  108dcf:	8b 44 24 10          	mov    0x10(%esp),%eax
    log.dev = ROOTDEV;
  108dd3:	c7 83 74 b7 d0 00 01 	movl   $0x1,0xd0b774(%ebx)
  108dda:	00 00 00 
    struct buf *buf = bufcache_read(log.dev, log.start);
  108ddd:	59                   	pop    %ecx
  108dde:	5f                   	pop    %edi
    log.start = sb.size - sb.nlog;
  108ddf:	29 d0                	sub    %edx,%eax
    log.size = sb.nlog;
  108de1:	89 93 6c b7 d0 00    	mov    %edx,0xd0b76c(%ebx)
    struct buf *buf = bufcache_read(log.dev, log.start);
  108de7:	50                   	push   %eax
  108de8:	6a 01                	push   $0x1
    log.start = sb.size - sb.nlog;
  108dea:	89 83 68 b7 d0 00    	mov    %eax,0xd0b768(%ebx)
    struct buf *buf = bufcache_read(log.dev, log.start);
  108df0:	e8 6b fc ff ff       	call   108a60 <bufcache_read>
    for (i = 0; i < log.lh.n; i++) {
  108df5:	83 c4 10             	add    $0x10,%esp
    log.lh.n = lh->n;
  108df8:	8b 48 18             	mov    0x18(%eax),%ecx
    struct buf *buf = bufcache_read(log.dev, log.start);
  108dfb:	89 c7                	mov    %eax,%edi
    log.lh.n = lh->n;
  108dfd:	89 8b 78 b7 d0 00    	mov    %ecx,0xd0b778(%ebx)
    for (i = 0; i < log.lh.n; i++) {
  108e03:	85 c9                	test   %ecx,%ecx
  108e05:	7e 18                	jle    108e1f <log_init+0x7f>
  108e07:	8d 40 1c             	lea    0x1c(%eax),%eax
  108e0a:	8d 56 1c             	lea    0x1c(%esi),%edx
  108e0d:	8d 34 88             	lea    (%eax,%ecx,4),%esi
        log.lh.sector[i] = lh->sector[i];
  108e10:	8b 08                	mov    (%eax),%ecx
    for (i = 0; i < log.lh.n; i++) {
  108e12:	83 c0 04             	add    $0x4,%eax
  108e15:	83 c2 04             	add    $0x4,%edx
        log.lh.sector[i] = lh->sector[i];
  108e18:	89 4a fc             	mov    %ecx,-0x4(%edx)
    for (i = 0; i < log.lh.n; i++) {
  108e1b:	39 f0                	cmp    %esi,%eax
  108e1d:	75 f1                	jne    108e10 <log_init+0x70>
    bufcache_release(buf);
  108e1f:	83 ec 0c             	sub    $0xc,%esp
  108e22:	57                   	push   %edi
  108e23:	e8 b8 fd ff ff       	call   108be0 <bufcache_release>

static void recover_from_log(void)
{
    read_head();
    install_trans();  // if committed, copy from log to disk
  108e28:	e8 53 fe ff ff       	call   108c80 <install_trans>
    log.lh.n = 0;
  108e2d:	c7 83 78 b7 d0 00 00 	movl   $0x0,0xd0b778(%ebx)
  108e34:	00 00 00 
    write_head();     // clear the log
  108e37:	e8 e4 fe ff ff       	call   108d20 <write_head>
}
  108e3c:	83 c4 20             	add    $0x20,%esp
  108e3f:	5b                   	pop    %ebx
  108e40:	5e                   	pop    %esi
  108e41:	5f                   	pop    %edi
  108e42:	c3                   	ret    
  108e43:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  108e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00108e50 <begin_trans>:
}

void begin_trans(void)
{
  108e50:	57                   	push   %edi
  108e51:	56                   	push   %esi
  108e52:	53                   	push   %ebx
  108e53:	e8 31 75 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  108e58:	81 c3 a8 b1 00 00    	add    $0xb1a8,%ebx
    spinlock_acquire(&log.lock);
  108e5e:	83 ec 0c             	sub    $0xc,%esp
  108e61:	8d b3 60 b7 d0 00    	lea    0xd0b760(%ebx),%esi
  108e67:	56                   	push   %esi
  108e68:	e8 03 d0 ff ff       	call   105e70 <spinlock_acquire>
    while (log.busy) {
  108e6d:	8b 93 70 b7 d0 00    	mov    0xd0b770(%ebx),%edx
  108e73:	83 c4 10             	add    $0x10,%esp
  108e76:	85 d2                	test   %edx,%edx
  108e78:	74 1b                	je     108e95 <begin_trans+0x45>
  108e7a:	8d 3d 60 b7 d0 00    	lea    0xd0b760,%edi
        thread_sleep(&log, &log.lock);
  108e80:	83 ec 08             	sub    $0x8,%esp
  108e83:	56                   	push   %esi
  108e84:	56                   	push   %esi
  108e85:	e8 36 ed ff ff       	call   107bc0 <thread_sleep>
    while (log.busy) {
  108e8a:	8b 44 1f 10          	mov    0x10(%edi,%ebx,1),%eax
  108e8e:	83 c4 10             	add    $0x10,%esp
  108e91:	85 c0                	test   %eax,%eax
  108e93:	75 eb                	jne    108e80 <begin_trans+0x30>
    }
    log.busy = 1;
  108e95:	c7 83 70 b7 d0 00 01 	movl   $0x1,0xd0b770(%ebx)
  108e9c:	00 00 00 
    spinlock_release(&log.lock);
  108e9f:	83 ec 0c             	sub    $0xc,%esp
  108ea2:	56                   	push   %esi
  108ea3:	e8 48 d0 ff ff       	call   105ef0 <spinlock_release>
}
  108ea8:	83 c4 10             	add    $0x10,%esp
  108eab:	5b                   	pop    %ebx
  108eac:	5e                   	pop    %esi
  108ead:	5f                   	pop    %edi
  108eae:	c3                   	ret    
  108eaf:	90                   	nop

00108eb0 <commit_trans>:

void commit_trans(void)
{
  108eb0:	56                   	push   %esi
  108eb1:	53                   	push   %ebx
  108eb2:	e8 d2 74 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  108eb7:	81 c3 49 b1 00 00    	add    $0xb149,%ebx
  108ebd:	83 ec 04             	sub    $0x4,%esp
    if (log.lh.n > 0) {
  108ec0:	8b 83 78 b7 d0 00    	mov    0xd0b778(%ebx),%eax
  108ec6:	85 c0                	test   %eax,%eax
  108ec8:	7e 19                	jle    108ee3 <commit_trans+0x33>
        write_head();     // Write header to disk -- the real commit
  108eca:	e8 51 fe ff ff       	call   108d20 <write_head>
        install_trans();  // Now install writes to home locations
  108ecf:	e8 ac fd ff ff       	call   108c80 <install_trans>
        log.lh.n = 0;
  108ed4:	c7 83 78 b7 d0 00 00 	movl   $0x0,0xd0b778(%ebx)
  108edb:	00 00 00 
        write_head();     // Erase the transaction from the log
  108ede:	e8 3d fe ff ff       	call   108d20 <write_head>
    }

    spinlock_acquire(&log.lock);
  108ee3:	83 ec 0c             	sub    $0xc,%esp
  108ee6:	8d b3 60 b7 d0 00    	lea    0xd0b760(%ebx),%esi
  108eec:	56                   	push   %esi
  108eed:	e8 7e cf ff ff       	call   105e70 <spinlock_acquire>
    log.busy = 0;
    thread_wakeup(&log);
  108ef2:	89 34 24             	mov    %esi,(%esp)
    log.busy = 0;
  108ef5:	c7 83 70 b7 d0 00 00 	movl   $0x0,0xd0b770(%ebx)
  108efc:	00 00 00 
    thread_wakeup(&log);
  108eff:	e8 fc ec ff ff       	call   107c00 <thread_wakeup>
    spinlock_release(&log.lock);
  108f04:	89 34 24             	mov    %esi,(%esp)
  108f07:	e8 e4 cf ff ff       	call   105ef0 <spinlock_release>
}
  108f0c:	83 c4 14             	add    $0x14,%esp
  108f0f:	5b                   	pop    %ebx
  108f10:	5e                   	pop    %esi
  108f11:	c3                   	ret    
  108f12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  108f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00108f20 <log_write>:
//   bp = bufcache_read(...)
//   modify bp->data[]
//   log_write(bp)
//   bufcache_release(bp)
void log_write(struct buf *b)
{
  108f20:	55                   	push   %ebp
  108f21:	57                   	push   %edi
  108f22:	56                   	push   %esi
  108f23:	53                   	push   %ebx
  108f24:	e8 60 74 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  108f29:	81 c3 d7 b0 00 00    	add    $0xb0d7,%ebx
  108f2f:	83 ec 0c             	sub    $0xc,%esp
  108f32:	8b 7c 24 20          	mov    0x20(%esp),%edi
    int i;

    if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
  108f36:	8b 83 78 b7 d0 00    	mov    0xd0b778(%ebx),%eax
  108f3c:	8b 93 6c b7 d0 00    	mov    0xd0b76c(%ebx),%edx
  108f42:	83 f8 09             	cmp    $0x9,%eax
  108f45:	0f 8f a5 00 00 00    	jg     108ff0 <log_write+0xd0>
  108f4b:	8d 4a ff             	lea    -0x1(%edx),%ecx
  108f4e:	39 c8                	cmp    %ecx,%eax
  108f50:	0f 8d 9a 00 00 00    	jge    108ff0 <log_write+0xd0>
        KERN_PANIC("too big a transaction. %d < %d <= %d",
                   log.size, log.lh.n, LOGSIZE);
    if (!log.busy)
  108f56:	8b 83 70 b7 d0 00    	mov    0xd0b770(%ebx),%eax
  108f5c:	85 c0                	test   %eax,%eax
  108f5e:	0f 84 bc 00 00 00    	je     109020 <log_write+0x100>
        KERN_PANIC("write outside of trans");

    for (i = 0; i < log.lh.n; i++) {
  108f64:	8b 93 78 b7 d0 00    	mov    0xd0b778(%ebx),%edx
        if (log.lh.sector[i] == b->sector)  // log absorbtion?
            break;
    }
    log.lh.sector[i] = b->sector;
  108f6a:	8b 47 08             	mov    0x8(%edi),%eax
    for (i = 0; i < log.lh.n; i++) {
  108f6d:	31 f6                	xor    %esi,%esi
  108f6f:	85 d2                	test   %edx,%edx
  108f71:	7f 0c                	jg     108f7f <log_write+0x5f>
  108f73:	eb 13                	jmp    108f88 <log_write+0x68>
  108f75:	8d 76 00             	lea    0x0(%esi),%esi
  108f78:	83 c6 01             	add    $0x1,%esi
  108f7b:	39 d6                	cmp    %edx,%esi
  108f7d:	74 09                	je     108f88 <log_write+0x68>
        if (log.lh.sector[i] == b->sector)  // log absorbtion?
  108f7f:	39 84 b3 7c b7 d0 00 	cmp    %eax,0xd0b77c(%ebx,%esi,4)
  108f86:	75 f0                	jne    108f78 <log_write+0x58>
    log.lh.sector[i] = b->sector;
  108f88:	89 84 b3 7c b7 d0 00 	mov    %eax,0xd0b77c(%ebx,%esi,4)
    struct buf *lbuf = bufcache_read(b->dev, log.start + i + 1);
  108f8f:	8b 83 68 b7 d0 00    	mov    0xd0b768(%ebx),%eax
  108f95:	83 ec 08             	sub    $0x8,%esp
  108f98:	01 f0                	add    %esi,%eax
  108f9a:	83 c0 01             	add    $0x1,%eax
  108f9d:	50                   	push   %eax
  108f9e:	ff 77 04             	push   0x4(%edi)
  108fa1:	e8 ba fa ff ff       	call   108a60 <bufcache_read>
    memmove(lbuf->data, b->data, BSIZE);
  108fa6:	83 c4 0c             	add    $0xc,%esp
    struct buf *lbuf = bufcache_read(b->dev, log.start + i + 1);
  108fa9:	89 c5                	mov    %eax,%ebp
    memmove(lbuf->data, b->data, BSIZE);
  108fab:	8d 47 18             	lea    0x18(%edi),%eax
  108fae:	68 00 02 00 00       	push   $0x200
  108fb3:	50                   	push   %eax
  108fb4:	8d 45 18             	lea    0x18(%ebp),%eax
  108fb7:	50                   	push   %eax
  108fb8:	e8 e3 b3 ff ff       	call   1043a0 <memmove>
    bufcache_write(lbuf);
  108fbd:	89 2c 24             	mov    %ebp,(%esp)
  108fc0:	e8 cb fb ff ff       	call   108b90 <bufcache_write>
    bufcache_release(lbuf);
  108fc5:	89 2c 24             	mov    %ebp,(%esp)
  108fc8:	e8 13 fc ff ff       	call   108be0 <bufcache_release>
    if (i == log.lh.n)
  108fcd:	83 c4 10             	add    $0x10,%esp
  108fd0:	39 b3 78 b7 d0 00    	cmp    %esi,0xd0b778(%ebx)
  108fd6:	75 09                	jne    108fe1 <log_write+0xc1>
        log.lh.n++;
  108fd8:	83 c6 01             	add    $0x1,%esi
  108fdb:	89 b3 78 b7 d0 00    	mov    %esi,0xd0b778(%ebx)
    b->flags |= B_DIRTY;  // XXX: prevent eviction
  108fe1:	83 0f 04             	orl    $0x4,(%edi)
}
  108fe4:	83 c4 0c             	add    $0xc,%esp
  108fe7:	5b                   	pop    %ebx
  108fe8:	5e                   	pop    %esi
  108fe9:	5f                   	pop    %edi
  108fea:	5d                   	pop    %ebp
  108feb:	c3                   	ret    
  108fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        KERN_PANIC("too big a transaction. %d < %d <= %d",
  108ff0:	83 ec 08             	sub    $0x8,%esp
  108ff3:	6a 0a                	push   $0xa
  108ff5:	50                   	push   %eax
  108ff6:	8d 83 9c 8b ff ff    	lea    -0x7464(%ebx),%eax
  108ffc:	52                   	push   %edx
  108ffd:	50                   	push   %eax
  108ffe:	8d 83 c1 8b ff ff    	lea    -0x743f(%ebx),%eax
  109004:	68 9d 00 00 00       	push   $0x9d
  109009:	50                   	push   %eax
  10900a:	e8 01 b7 ff ff       	call   104710 <debug_panic>
    if (!log.busy)
  10900f:	8b 83 70 b7 d0 00    	mov    0xd0b770(%ebx),%eax
        KERN_PANIC("too big a transaction. %d < %d <= %d",
  109015:	83 c4 20             	add    $0x20,%esp
    if (!log.busy)
  109018:	85 c0                	test   %eax,%eax
  10901a:	0f 85 44 ff ff ff    	jne    108f64 <log_write+0x44>
        KERN_PANIC("write outside of trans");
  109020:	83 ec 04             	sub    $0x4,%esp
  109023:	8d 83 cf 8b ff ff    	lea    -0x7431(%ebx),%eax
  109029:	50                   	push   %eax
  10902a:	8d 83 c1 8b ff ff    	lea    -0x743f(%ebx),%eax
  109030:	68 a0 00 00 00       	push   $0xa0
  109035:	50                   	push   %eax
  109036:	e8 d5 b6 ff ff       	call   104710 <debug_panic>
  10903b:	83 c4 10             	add    $0x10,%esp
  10903e:	e9 21 ff ff ff       	jmp    108f64 <log_write+0x44>
  109043:	66 90                	xchg   %ax,%ax
  109045:	66 90                	xchg   %ax,%ax
  109047:	66 90                	xchg   %ax,%ax
  109049:	66 90                	xchg   %ax,%ax
  10904b:	66 90                	xchg   %ax,%ax
  10904d:	66 90                	xchg   %ax,%ax
  10904f:	90                   	nop

00109050 <read_superblock>:
#include "dinode.h"
#include "log.h"

// Read the super block.
void read_superblock(int dev, struct superblock *sb)
{
  109050:	56                   	push   %esi
  109051:	53                   	push   %ebx
  109052:	e8 32 73 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  109057:	81 c3 a9 af 00 00    	add    $0xafa9,%ebx
  10905d:	83 ec 0c             	sub    $0xc,%esp
    struct buf *bp;

    bp = bufcache_read(dev, 1);  // Block 1 is super block.
  109060:	6a 01                	push   $0x1
  109062:	ff 74 24 1c          	push   0x1c(%esp)
  109066:	e8 f5 f9 ff ff       	call   108a60 <bufcache_read>
    memmove(sb, bp->data, sizeof(*sb));
  10906b:	83 c4 0c             	add    $0xc,%esp
    bp = bufcache_read(dev, 1);  // Block 1 is super block.
  10906e:	89 c6                	mov    %eax,%esi
    memmove(sb, bp->data, sizeof(*sb));
  109070:	8d 40 18             	lea    0x18(%eax),%eax
  109073:	6a 10                	push   $0x10
  109075:	50                   	push   %eax
  109076:	ff 74 24 20          	push   0x20(%esp)
  10907a:	e8 21 b3 ff ff       	call   1043a0 <memmove>
    bufcache_release(bp);
  10907f:	89 34 24             	mov    %esi,(%esp)
  109082:	e8 59 fb ff ff       	call   108be0 <bufcache_release>
}
  109087:	83 c4 14             	add    $0x14,%esp
  10908a:	5b                   	pop    %ebx
  10908b:	5e                   	pop    %esi
  10908c:	c3                   	ret    
  10908d:	8d 76 00             	lea    0x0(%esi),%esi

00109090 <block_zero>:

// Zero a block.
void block_zero(uint32_t dev, uint32_t bno)
{
  109090:	56                   	push   %esi
  109091:	53                   	push   %ebx
  109092:	e8 f2 72 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  109097:	81 c3 69 af 00 00    	add    $0xaf69,%ebx
  10909d:	83 ec 0c             	sub    $0xc,%esp
    struct buf *bp;

    bp = bufcache_read(dev, bno);
  1090a0:	ff 74 24 1c          	push   0x1c(%esp)
  1090a4:	ff 74 24 1c          	push   0x1c(%esp)
  1090a8:	e8 b3 f9 ff ff       	call   108a60 <bufcache_read>
    memset(bp->data, 0, BSIZE);
  1090ad:	83 c4 0c             	add    $0xc,%esp
    bp = bufcache_read(dev, bno);
  1090b0:	89 c6                	mov    %eax,%esi
    memset(bp->data, 0, BSIZE);
  1090b2:	8d 40 18             	lea    0x18(%eax),%eax
  1090b5:	68 00 02 00 00       	push   $0x200
  1090ba:	6a 00                	push   $0x0
  1090bc:	50                   	push   %eax
  1090bd:	e8 8e b2 ff ff       	call   104350 <memset>
    log_write(bp);
  1090c2:	89 34 24             	mov    %esi,(%esp)
  1090c5:	e8 56 fe ff ff       	call   108f20 <log_write>
    bufcache_release(bp);
  1090ca:	89 34 24             	mov    %esi,(%esp)
  1090cd:	e8 0e fb ff ff       	call   108be0 <bufcache_release>
}
  1090d2:	83 c4 14             	add    $0x14,%esp
  1090d5:	5b                   	pop    %ebx
  1090d6:	5e                   	pop    %esi
  1090d7:	c3                   	ret    
  1090d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1090df:	90                   	nop

001090e0 <block_alloc>:

// Allocate a zeroed disk block.
uint32_t block_alloc(uint32_t dev)
{
  1090e0:	55                   	push   %ebp
  1090e1:	57                   	push   %edi
  1090e2:	56                   	push   %esi
  1090e3:	53                   	push   %ebx
  1090e4:	e8 a0 72 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1090e9:	81 c3 17 af 00 00    	add    $0xaf17,%ebx
  1090ef:	83 ec 34             	sub    $0x34,%esp
    bp = bufcache_read(dev, 1);  // Block 1 is super block.
  1090f2:	89 5c 24 14          	mov    %ebx,0x14(%esp)
  1090f6:	6a 01                	push   $0x1
  1090f8:	ff 74 24 4c          	push   0x4c(%esp)
  1090fc:	e8 5f f9 ff ff       	call   108a60 <bufcache_read>
    memmove(sb, bp->data, sizeof(*sb));
  109101:	83 c4 0c             	add    $0xc,%esp
    bp = bufcache_read(dev, 1);  // Block 1 is super block.
  109104:	89 c6                	mov    %eax,%esi
    memmove(sb, bp->data, sizeof(*sb));
  109106:	83 c0 18             	add    $0x18,%eax
  109109:	6a 10                	push   $0x10
  10910b:	50                   	push   %eax
  10910c:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  109110:	50                   	push   %eax
  109111:	e8 8a b2 ff ff       	call   1043a0 <memmove>
    bufcache_release(bp);
  109116:	89 34 24             	mov    %esi,(%esp)
  109119:	e8 c2 fa ff ff       	call   108be0 <bufcache_release>
    struct buf *bp;
    struct superblock sb;

    bp = 0;
    read_superblock(dev, &sb);
    for (b = 0; b < sb.size; b += BPB) {
  10911e:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  109122:	83 c4 10             	add    $0x10,%esp
  109125:	85 c9                	test   %ecx,%ecx
  109127:	0f 84 98 00 00 00    	je     1091c5 <block_alloc+0xe5>
  10912d:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  109134:	00 
        bp = bufcache_read(dev, BBLOCK(b, sb.ninodes));
  109135:	83 ec 08             	sub    $0x8,%esp
  109138:	8b 74 24 10          	mov    0x10(%esp),%esi
  10913c:	8b 44 24 20          	mov    0x20(%esp),%eax
  109140:	89 f2                	mov    %esi,%edx
  109142:	c1 e8 03             	shr    $0x3,%eax
  109145:	c1 fa 0c             	sar    $0xc,%edx
  109148:	8d 44 10 03          	lea    0x3(%eax,%edx,1),%eax
  10914c:	50                   	push   %eax
  10914d:	ff 74 24 4c          	push   0x4c(%esp)
  109151:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  109155:	e8 06 f9 ff ff       	call   108a60 <bufcache_read>
  10915a:	89 c7                	mov    %eax,%edi
        for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
  10915c:	8b 44 24 20          	mov    0x20(%esp),%eax
  109160:	89 44 24 14          	mov    %eax,0x14(%esp)
  109164:	83 c4 10             	add    $0x10,%esp
  109167:	31 c0                	xor    %eax,%eax
  109169:	eb 2e                	jmp    109199 <block_alloc+0xb9>
  10916b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10916f:	90                   	nop
            m = 1 << (bi % 8);
  109170:	89 c1                	mov    %eax,%ecx
  109172:	bb 01 00 00 00       	mov    $0x1,%ebx
  109177:	83 e1 07             	and    $0x7,%ecx
  10917a:	d3 e3                	shl    %cl,%ebx
            if ((bp->data[bi / 8] & m) == 0) {  // Is block free?
  10917c:	89 c1                	mov    %eax,%ecx
  10917e:	c1 f9 03             	sar    $0x3,%ecx
  109181:	0f b6 6c 0f 18       	movzbl 0x18(%edi,%ecx,1),%ebp
  109186:	89 ea                	mov    %ebp,%edx
  109188:	85 dd                	test   %ebx,%ebp
  10918a:	74 64                	je     1091f0 <block_alloc+0x110>
        for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
  10918c:	83 c0 01             	add    $0x1,%eax
  10918f:	83 c6 01             	add    $0x1,%esi
  109192:	3d 00 10 00 00       	cmp    $0x1000,%eax
  109197:	74 06                	je     10919f <block_alloc+0xbf>
  109199:	39 74 24 04          	cmp    %esi,0x4(%esp)
  10919d:	77 d1                	ja     109170 <block_alloc+0x90>
                bufcache_release(bp);
                block_zero(dev, b + bi);
                return b + bi;
            }
        }
        bufcache_release(bp);
  10919f:	83 ec 0c             	sub    $0xc,%esp
  1091a2:	57                   	push   %edi
  1091a3:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  1091a7:	e8 34 fa ff ff       	call   108be0 <bufcache_release>
    for (b = 0; b < sb.size; b += BPB) {
  1091ac:	81 44 24 18 00 10 00 	addl   $0x1000,0x18(%esp)
  1091b3:	00 
  1091b4:	8b 44 24 18          	mov    0x18(%esp),%eax
  1091b8:	83 c4 10             	add    $0x10,%esp
  1091bb:	39 44 24 10          	cmp    %eax,0x10(%esp)
  1091bf:	0f 87 70 ff ff ff    	ja     109135 <block_alloc+0x55>
    }
    KERN_PANIC("balloc: out of blocks");
  1091c5:	83 ec 04             	sub    $0x4,%esp
    return 0;
  1091c8:	31 f6                	xor    %esi,%esi
    KERN_PANIC("balloc: out of blocks");
  1091ca:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1091ce:	8d 83 e6 8b ff ff    	lea    -0x741a(%ebx),%eax
  1091d4:	50                   	push   %eax
  1091d5:	8d 83 fc 8b ff ff    	lea    -0x7404(%ebx),%eax
  1091db:	6a 35                	push   $0x35
  1091dd:	50                   	push   %eax
  1091de:	e8 2d b5 ff ff       	call   104710 <debug_panic>
    return 0;
  1091e3:	83 c4 10             	add    $0x10,%esp
}
  1091e6:	89 f0                	mov    %esi,%eax
  1091e8:	83 c4 2c             	add    $0x2c,%esp
  1091eb:	5b                   	pop    %ebx
  1091ec:	5e                   	pop    %esi
  1091ed:	5f                   	pop    %edi
  1091ee:	5d                   	pop    %ebp
  1091ef:	c3                   	ret    
                log_write(bp);
  1091f0:	83 ec 0c             	sub    $0xc,%esp
                bp->data[bi / 8] |= m;          // Mark block in use.
  1091f3:	09 da                	or     %ebx,%edx
  1091f5:	88 54 0f 18          	mov    %dl,0x18(%edi,%ecx,1)
                log_write(bp);
  1091f9:	57                   	push   %edi
  1091fa:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  1091fe:	e8 1d fd ff ff       	call   108f20 <log_write>
                bufcache_release(bp);
  109203:	89 3c 24             	mov    %edi,(%esp)
  109206:	e8 d5 f9 ff ff       	call   108be0 <bufcache_release>
    bp = bufcache_read(dev, bno);
  10920b:	58                   	pop    %eax
  10920c:	5a                   	pop    %edx
  10920d:	56                   	push   %esi
  10920e:	ff 74 24 4c          	push   0x4c(%esp)
  109212:	e8 49 f8 ff ff       	call   108a60 <bufcache_read>
    memset(bp->data, 0, BSIZE);
  109217:	83 c4 0c             	add    $0xc,%esp
    bp = bufcache_read(dev, bno);
  10921a:	89 c7                	mov    %eax,%edi
    memset(bp->data, 0, BSIZE);
  10921c:	8d 40 18             	lea    0x18(%eax),%eax
  10921f:	68 00 02 00 00       	push   $0x200
  109224:	6a 00                	push   $0x0
  109226:	50                   	push   %eax
  109227:	e8 24 b1 ff ff       	call   104350 <memset>
    log_write(bp);
  10922c:	89 3c 24             	mov    %edi,(%esp)
  10922f:	e8 ec fc ff ff       	call   108f20 <log_write>
    bufcache_release(bp);
  109234:	89 3c 24             	mov    %edi,(%esp)
  109237:	e8 a4 f9 ff ff       	call   108be0 <bufcache_release>
}
  10923c:	83 c4 10             	add    $0x10,%esp
}
  10923f:	89 f0                	mov    %esi,%eax
  109241:	83 c4 2c             	add    $0x2c,%esp
  109244:	5b                   	pop    %ebx
  109245:	5e                   	pop    %esi
  109246:	5f                   	pop    %edi
  109247:	5d                   	pop    %ebp
  109248:	c3                   	ret    
  109249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00109250 <block_free>:

// Free a disk block.
void block_free(uint32_t dev, uint32_t b)
{
  109250:	55                   	push   %ebp
  109251:	57                   	push   %edi
  109252:	56                   	push   %esi
  109253:	53                   	push   %ebx
  109254:	e8 30 71 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  109259:	81 c3 a7 ad 00 00    	add    $0xada7,%ebx
  10925f:	83 ec 34             	sub    $0x34,%esp
  109262:	8b 7c 24 48          	mov    0x48(%esp),%edi
  109266:	8b 74 24 4c          	mov    0x4c(%esp),%esi
    bp = bufcache_read(dev, 1);  // Block 1 is super block.
  10926a:	6a 01                	push   $0x1
  10926c:	57                   	push   %edi
  10926d:	e8 ee f7 ff ff       	call   108a60 <bufcache_read>
    memmove(sb, bp->data, sizeof(*sb));
  109272:	83 c4 0c             	add    $0xc,%esp
    bp = bufcache_read(dev, 1);  // Block 1 is super block.
  109275:	89 c5                	mov    %eax,%ebp
    memmove(sb, bp->data, sizeof(*sb));
  109277:	83 c0 18             	add    $0x18,%eax
  10927a:	6a 10                	push   $0x10
  10927c:	50                   	push   %eax
  10927d:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  109281:	50                   	push   %eax
  109282:	e8 19 b1 ff ff       	call   1043a0 <memmove>
    bufcache_release(bp);
  109287:	89 2c 24             	mov    %ebp,(%esp)
  10928a:	e8 51 f9 ff ff       	call   108be0 <bufcache_release>
    struct buf *bp;
    struct superblock sb;
    int bi, m;

    read_superblock(dev, &sb);
    bp = bufcache_read(dev, BBLOCK(b, sb.ninodes));
  10928f:	58                   	pop    %eax
  109290:	5a                   	pop    %edx
  109291:	89 f2                	mov    %esi,%edx
  109293:	8b 44 24 20          	mov    0x20(%esp),%eax
  109297:	c1 ea 0c             	shr    $0xc,%edx
  10929a:	c1 e8 03             	shr    $0x3,%eax
  10929d:	8d 44 10 03          	lea    0x3(%eax,%edx,1),%eax
  1092a1:	50                   	push   %eax
  1092a2:	57                   	push   %edi
  1092a3:	e8 b8 f7 ff ff       	call   108a60 <bufcache_read>
    bi = b % BPB;
    m = 1 << (bi % 8);
  1092a8:	89 f1                	mov    %esi,%ecx
    if ((bp->data[bi / 8] & m) == 0)
  1092aa:	c1 fe 03             	sar    $0x3,%esi
  1092ad:	83 c4 10             	add    $0x10,%esp
    bp = bufcache_read(dev, BBLOCK(b, sb.ninodes));
  1092b0:	89 c7                	mov    %eax,%edi
    m = 1 << (bi % 8);
  1092b2:	83 e1 07             	and    $0x7,%ecx
  1092b5:	b8 01 00 00 00       	mov    $0x1,%eax
    if ((bp->data[bi / 8] & m) == 0)
  1092ba:	81 e6 ff 01 00 00    	and    $0x1ff,%esi
    m = 1 << (bi % 8);
  1092c0:	d3 e0                	shl    %cl,%eax
    if ((bp->data[bi / 8] & m) == 0)
  1092c2:	0f b6 4c 37 18       	movzbl 0x18(%edi,%esi,1),%ecx
  1092c7:	89 ca                	mov    %ecx,%edx
  1092c9:	85 c1                	test   %eax,%ecx
  1092cb:	74 23                	je     1092f0 <block_free+0xa0>
        KERN_PANIC("freeing free block");
    bp->data[bi / 8] &= ~m;
  1092cd:	f7 d0                	not    %eax
    log_write(bp);
  1092cf:	83 ec 0c             	sub    $0xc,%esp
    bp->data[bi / 8] &= ~m;
  1092d2:	21 d0                	and    %edx,%eax
  1092d4:	88 44 37 18          	mov    %al,0x18(%edi,%esi,1)
    log_write(bp);
  1092d8:	57                   	push   %edi
  1092d9:	e8 42 fc ff ff       	call   108f20 <log_write>
    bufcache_release(bp);
  1092de:	89 3c 24             	mov    %edi,(%esp)
  1092e1:	e8 fa f8 ff ff       	call   108be0 <bufcache_release>
}
  1092e6:	83 c4 3c             	add    $0x3c,%esp
  1092e9:	5b                   	pop    %ebx
  1092ea:	5e                   	pop    %esi
  1092eb:	5f                   	pop    %edi
  1092ec:	5d                   	pop    %ebp
  1092ed:	c3                   	ret    
  1092ee:	66 90                	xchg   %ax,%ax
  1092f0:	89 44 24 0c          	mov    %eax,0xc(%esp)
        KERN_PANIC("freeing free block");
  1092f4:	8d 93 0c 8c ff ff    	lea    -0x73f4(%ebx),%edx
  1092fa:	83 ec 04             	sub    $0x4,%esp
  1092fd:	52                   	push   %edx
  1092fe:	8d 93 fc 8b ff ff    	lea    -0x7404(%ebx),%edx
  109304:	6a 45                	push   $0x45
  109306:	52                   	push   %edx
  109307:	e8 04 b4 ff ff       	call   104710 <debug_panic>
    bp->data[bi / 8] &= ~m;
  10930c:	83 c4 10             	add    $0x10,%esp
  10930f:	0f b6 54 37 18       	movzbl 0x18(%edi,%esi,1),%edx
  109314:	8b 44 24 0c          	mov    0xc(%esp),%eax
  109318:	eb b3                	jmp    1092cd <block_free+0x7d>
  10931a:	66 90                	xchg   %ax,%ax
  10931c:	66 90                	xchg   %ax,%ax
  10931e:	66 90                	xchg   %ax,%ax

00109320 <bmap>:
/**
 * Return the disk block address of the nth block in inode ip.
 * If there is no such block, bmap allocates one.
 */
static uint32_t bmap(struct inode *ip, uint32_t bn)
{
  109320:	55                   	push   %ebp
  109321:	57                   	push   %edi
  109322:	89 c7                	mov    %eax,%edi
  109324:	56                   	push   %esi
  109325:	53                   	push   %ebx
  109326:	e8 5e 70 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10932b:	81 c3 d5 ac 00 00    	add    $0xacd5,%ebx
  109331:	83 ec 1c             	sub    $0x1c,%esp
    uint32_t addr, *a;
    struct buf *bp;

    if (bn < NDIRECT) {
  109334:	83 fa 0b             	cmp    $0xb,%edx
  109337:	76 77                	jbe    1093b0 <bmap+0x90>
        if ((addr = ip->addrs[bn]) == 0)
            ip->addrs[bn] = addr = block_alloc(ip->dev);
        return addr;
    }
    bn -= NDIRECT;
  109339:	8d 72 f4             	lea    -0xc(%edx),%esi

    if (bn < NINDIRECT) {
  10933c:	83 fe 7f             	cmp    $0x7f,%esi
  10933f:	77 47                	ja     109388 <bmap+0x68>
        // Load indirect block, allocating if necessary.
        if ((addr = ip->addrs[NDIRECT]) == 0)
  109341:	8b 40 4c             	mov    0x4c(%eax),%eax
  109344:	85 c0                	test   %eax,%eax
  109346:	0f 84 b4 00 00 00    	je     109400 <bmap+0xe0>
            ip->addrs[NDIRECT] = addr = block_alloc(ip->dev);
        bp = bufcache_read(ip->dev, addr);
  10934c:	83 ec 08             	sub    $0x8,%esp
  10934f:	50                   	push   %eax
  109350:	ff 37                	push   (%edi)
  109352:	e8 09 f7 ff ff       	call   108a60 <bufcache_read>
        a = (uint32_t *) bp->data;
        if ((addr = a[bn]) == 0) {
  109357:	83 c4 10             	add    $0x10,%esp
  10935a:	8d 74 b0 18          	lea    0x18(%eax,%esi,4),%esi
        bp = bufcache_read(ip->dev, addr);
  10935e:	89 c5                	mov    %eax,%ebp
        if ((addr = a[bn]) == 0) {
  109360:	8b 06                	mov    (%esi),%eax
  109362:	85 c0                	test   %eax,%eax
  109364:	74 72                	je     1093d8 <bmap+0xb8>
  109366:	89 44 24 0c          	mov    %eax,0xc(%esp)
            a[bn] = addr = block_alloc(ip->dev);
            log_write(bp);
        }
        bufcache_release(bp);
  10936a:	83 ec 0c             	sub    $0xc,%esp
  10936d:	55                   	push   %ebp
  10936e:	e8 6d f8 ff ff       	call   108be0 <bufcache_release>
        return addr;
  109373:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  109377:	83 c4 10             	add    $0x10,%esp
    }

    KERN_PANIC("bmap: out of range");
    return 0;
}
  10937a:	83 c4 1c             	add    $0x1c,%esp
  10937d:	5b                   	pop    %ebx
  10937e:	5e                   	pop    %esi
  10937f:	5f                   	pop    %edi
  109380:	5d                   	pop    %ebp
  109381:	c3                   	ret    
  109382:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    KERN_PANIC("bmap: out of range");
  109388:	83 ec 04             	sub    $0x4,%esp
  10938b:	8d 83 1f 8c ff ff    	lea    -0x73e1(%ebx),%eax
  109391:	50                   	push   %eax
  109392:	8d 83 32 8c ff ff    	lea    -0x73ce(%ebx),%eax
  109398:	68 fd 00 00 00       	push   $0xfd
  10939d:	50                   	push   %eax
  10939e:	e8 6d b3 ff ff       	call   104710 <debug_panic>
    return 0;
  1093a3:	83 c4 10             	add    $0x10,%esp
  1093a6:	31 c0                	xor    %eax,%eax
}
  1093a8:	83 c4 1c             	add    $0x1c,%esp
  1093ab:	5b                   	pop    %ebx
  1093ac:	5e                   	pop    %esi
  1093ad:	5f                   	pop    %edi
  1093ae:	5d                   	pop    %ebp
  1093af:	c3                   	ret    
        if ((addr = ip->addrs[bn]) == 0)
  1093b0:	8d 72 04             	lea    0x4(%edx),%esi
  1093b3:	8b 44 b0 0c          	mov    0xc(%eax,%esi,4),%eax
  1093b7:	85 c0                	test   %eax,%eax
  1093b9:	75 bf                	jne    10937a <bmap+0x5a>
            ip->addrs[bn] = addr = block_alloc(ip->dev);
  1093bb:	83 ec 0c             	sub    $0xc,%esp
  1093be:	ff 37                	push   (%edi)
  1093c0:	e8 1b fd ff ff       	call   1090e0 <block_alloc>
  1093c5:	83 c4 10             	add    $0x10,%esp
  1093c8:	89 44 b7 0c          	mov    %eax,0xc(%edi,%esi,4)
}
  1093cc:	83 c4 1c             	add    $0x1c,%esp
  1093cf:	5b                   	pop    %ebx
  1093d0:	5e                   	pop    %esi
  1093d1:	5f                   	pop    %edi
  1093d2:	5d                   	pop    %ebp
  1093d3:	c3                   	ret    
  1093d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            a[bn] = addr = block_alloc(ip->dev);
  1093d8:	83 ec 0c             	sub    $0xc,%esp
  1093db:	ff 37                	push   (%edi)
  1093dd:	e8 fe fc ff ff       	call   1090e0 <block_alloc>
  1093e2:	89 06                	mov    %eax,(%esi)
  1093e4:	89 44 24 1c          	mov    %eax,0x1c(%esp)
            log_write(bp);
  1093e8:	89 2c 24             	mov    %ebp,(%esp)
  1093eb:	e8 30 fb ff ff       	call   108f20 <log_write>
  1093f0:	83 c4 10             	add    $0x10,%esp
  1093f3:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1093f7:	e9 6a ff ff ff       	jmp    109366 <bmap+0x46>
  1093fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            ip->addrs[NDIRECT] = addr = block_alloc(ip->dev);
  109400:	83 ec 0c             	sub    $0xc,%esp
  109403:	ff 37                	push   (%edi)
  109405:	e8 d6 fc ff ff       	call   1090e0 <block_alloc>
  10940a:	83 c4 10             	add    $0x10,%esp
  10940d:	89 47 4c             	mov    %eax,0x4c(%edi)
  109410:	e9 37 ff ff ff       	jmp    10934c <bmap+0x2c>
  109415:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10941c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00109420 <inode_init>:
{
  109420:	53                   	push   %ebx
  109421:	e8 63 6f ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  109426:	81 c3 da ab 00 00    	add    $0xabda,%ebx
  10942c:	83 ec 14             	sub    $0x14,%esp
    spinlock_init(&inode_cache.lock);
  10942f:	8d 83 c0 b7 d0 00    	lea    0xd0b7c0(%ebx),%eax
  109435:	50                   	push   %eax
  109436:	e8 a5 c9 ff ff       	call   105de0 <spinlock_init>
}
  10943b:	83 c4 18             	add    $0x18,%esp
  10943e:	5b                   	pop    %ebx
  10943f:	c3                   	ret    

00109440 <inode_update>:
{
  109440:	57                   	push   %edi
  109441:	56                   	push   %esi
  109442:	53                   	push   %ebx
  109443:	8b 74 24 10          	mov    0x10(%esp),%esi
  109447:	e8 3d 6f ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10944c:	81 c3 b4 ab 00 00    	add    $0xabb4,%ebx
    bp = bufcache_read(ip->dev, IBLOCK(ip->inum));
  109452:	8b 46 04             	mov    0x4(%esi),%eax
    memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  109455:	83 c6 1c             	add    $0x1c,%esi
    bp = bufcache_read(ip->dev, IBLOCK(ip->inum));
  109458:	83 ec 08             	sub    $0x8,%esp
  10945b:	c1 e8 03             	shr    $0x3,%eax
  10945e:	83 c0 02             	add    $0x2,%eax
  109461:	50                   	push   %eax
  109462:	ff 76 e4             	push   -0x1c(%esi)
  109465:	e8 f6 f5 ff ff       	call   108a60 <bufcache_read>
    dip->type = ip->type;
  10946a:	0f b7 56 f4          	movzwl -0xc(%esi),%edx
    memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  10946e:	83 c4 0c             	add    $0xc,%esp
    bp = bufcache_read(ip->dev, IBLOCK(ip->inum));
  109471:	89 c7                	mov    %eax,%edi
    dip = (struct dinode *) bp->data + ip->inum % IPB;
  109473:	8b 46 e8             	mov    -0x18(%esi),%eax
  109476:	83 e0 07             	and    $0x7,%eax
  109479:	c1 e0 06             	shl    $0x6,%eax
  10947c:	8d 44 07 18          	lea    0x18(%edi,%eax,1),%eax
    dip->type = ip->type;
  109480:	66 89 10             	mov    %dx,(%eax)
    dip->major = ip->major;
  109483:	0f b7 56 f6          	movzwl -0xa(%esi),%edx
    memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  109487:	83 c0 0c             	add    $0xc,%eax
    dip->major = ip->major;
  10948a:	66 89 50 f6          	mov    %dx,-0xa(%eax)
    dip->minor = ip->minor;
  10948e:	0f b7 56 f8          	movzwl -0x8(%esi),%edx
  109492:	66 89 50 f8          	mov    %dx,-0x8(%eax)
    dip->nlink = ip->nlink;
  109496:	0f b7 56 fa          	movzwl -0x6(%esi),%edx
  10949a:	66 89 50 fa          	mov    %dx,-0x6(%eax)
    dip->size = ip->size;
  10949e:	8b 56 fc             	mov    -0x4(%esi),%edx
  1094a1:	89 50 fc             	mov    %edx,-0x4(%eax)
    memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  1094a4:	6a 34                	push   $0x34
  1094a6:	56                   	push   %esi
  1094a7:	50                   	push   %eax
  1094a8:	e8 f3 ae ff ff       	call   1043a0 <memmove>
    log_write(bp);
  1094ad:	89 3c 24             	mov    %edi,(%esp)
  1094b0:	e8 6b fa ff ff       	call   108f20 <log_write>
    bufcache_release(bp);
  1094b5:	89 3c 24             	mov    %edi,(%esp)
  1094b8:	e8 23 f7 ff ff       	call   108be0 <bufcache_release>
}
  1094bd:	83 c4 10             	add    $0x10,%esp
  1094c0:	5b                   	pop    %ebx
  1094c1:	5e                   	pop    %esi
  1094c2:	5f                   	pop    %edi
  1094c3:	c3                   	ret    
  1094c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1094cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1094cf:	90                   	nop

001094d0 <inode_get>:
{
  1094d0:	55                   	push   %ebp
  1094d1:	57                   	push   %edi
    empty = 0;
  1094d2:	31 ff                	xor    %edi,%edi
{
  1094d4:	56                   	push   %esi
  1094d5:	53                   	push   %ebx
  1094d6:	e8 ae 6e ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1094db:	81 c3 25 ab 00 00    	add    $0xab25,%ebx
  1094e1:	83 ec 28             	sub    $0x28,%esp
  1094e4:	8b 6c 24 3c          	mov    0x3c(%esp),%ebp
    spinlock_acquire(&inode_cache.lock);
  1094e8:	8d 83 c0 b7 d0 00    	lea    0xd0b7c0(%ebx),%eax
  1094ee:	89 44 24 18          	mov    %eax,0x18(%esp)
  1094f2:	89 c6                	mov    %eax,%esi
  1094f4:	50                   	push   %eax
    for (ip = &inode_cache.inode[0]; ip < &inode_cache.inode[NINODE]; ip++) {
  1094f5:	8d 76 08             	lea    0x8(%esi),%esi
    spinlock_acquire(&inode_cache.lock);
  1094f8:	e8 73 c9 ff ff       	call   105e70 <spinlock_acquire>
  1094fd:	83 c4 10             	add    $0x10,%esp
  109500:	8d 93 68 c7 d0 00    	lea    0xd0c768(%ebx),%edx
  109506:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  10950a:	eb 0f                	jmp    10951b <inode_get+0x4b>
  10950c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if (ip->ref > 0 && ip->dev == dev && ip->inum == inum) {
  109510:	39 2e                	cmp    %ebp,(%esi)
  109512:	74 5c                	je     109570 <inode_get+0xa0>
    for (ip = &inode_cache.inode[0]; ip < &inode_cache.inode[NINODE]; ip++) {
  109514:	83 c6 50             	add    $0x50,%esi
  109517:	39 d6                	cmp    %edx,%esi
  109519:	73 25                	jae    109540 <inode_get+0x70>
        if (ip->ref > 0 && ip->dev == dev && ip->inum == inum) {
  10951b:	8b 46 08             	mov    0x8(%esi),%eax
  10951e:	85 c0                	test   %eax,%eax
  109520:	7f ee                	jg     109510 <inode_get+0x40>
        if (empty == 0 && ip->ref == 0)  // Remember empty slot.
  109522:	85 ff                	test   %edi,%edi
  109524:	75 ee                	jne    109514 <inode_get+0x44>
  109526:	85 c0                	test   %eax,%eax
  109528:	0f 85 8f 00 00 00    	jne    1095bd <inode_get+0xed>
  10952e:	89 f7                	mov    %esi,%edi
    for (ip = &inode_cache.inode[0]; ip < &inode_cache.inode[NINODE]; ip++) {
  109530:	83 c6 50             	add    $0x50,%esi
  109533:	39 d6                	cmp    %edx,%esi
  109535:	72 e4                	jb     10951b <inode_get+0x4b>
  109537:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10953e:	66 90                	xchg   %ax,%ax
    if (empty == 0)
  109540:	85 ff                	test   %edi,%edi
  109542:	74 52                	je     109596 <inode_get+0xc6>
    spinlock_release(&inode_cache.lock);
  109544:	83 ec 0c             	sub    $0xc,%esp
    ip->dev = dev;
  109547:	89 2f                	mov    %ebp,(%edi)
    ip->inum = inum;
  109549:	89 4f 04             	mov    %ecx,0x4(%edi)
    ip->ref = 1;
  10954c:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
    ip->flags = 0;
  109553:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    spinlock_release(&inode_cache.lock);
  10955a:	ff 74 24 18          	push   0x18(%esp)
  10955e:	e8 8d c9 ff ff       	call   105ef0 <spinlock_release>
    return ip;
  109563:	83 c4 10             	add    $0x10,%esp
}
  109566:	89 f8                	mov    %edi,%eax
  109568:	83 c4 1c             	add    $0x1c,%esp
  10956b:	5b                   	pop    %ebx
  10956c:	5e                   	pop    %esi
  10956d:	5f                   	pop    %edi
  10956e:	5d                   	pop    %ebp
  10956f:	c3                   	ret    
        if (ip->ref > 0 && ip->dev == dev && ip->inum == inum) {
  109570:	39 4e 04             	cmp    %ecx,0x4(%esi)
  109573:	75 9f                	jne    109514 <inode_get+0x44>
            ip->ref++;
  109575:	83 c0 01             	add    $0x1,%eax
            spinlock_release(&inode_cache.lock);
  109578:	83 ec 0c             	sub    $0xc,%esp
            return ip;
  10957b:	89 f7                	mov    %esi,%edi
            ip->ref++;
  10957d:	89 46 08             	mov    %eax,0x8(%esi)
            spinlock_release(&inode_cache.lock);
  109580:	ff 74 24 18          	push   0x18(%esp)
  109584:	e8 67 c9 ff ff       	call   105ef0 <spinlock_release>
            return ip;
  109589:	83 c4 10             	add    $0x10,%esp
}
  10958c:	89 f8                	mov    %edi,%eax
  10958e:	83 c4 1c             	add    $0x1c,%esp
  109591:	5b                   	pop    %ebx
  109592:	5e                   	pop    %esi
  109593:	5f                   	pop    %edi
  109594:	5d                   	pop    %ebp
  109595:	c3                   	ret    
  109596:	89 4c 24 34          	mov    %ecx,0x34(%esp)
        KERN_PANIC("inode_get: no inodes");
  10959a:	8d 83 42 8c ff ff    	lea    -0x73be(%ebx),%eax
  1095a0:	83 ec 04             	sub    $0x4,%esp
  1095a3:	31 ff                	xor    %edi,%edi
  1095a5:	50                   	push   %eax
  1095a6:	8d 83 32 8c ff ff    	lea    -0x73ce(%ebx),%eax
  1095ac:	6a 69                	push   $0x69
  1095ae:	50                   	push   %eax
  1095af:	e8 5c b1 ff ff       	call   104710 <debug_panic>
  1095b4:	83 c4 10             	add    $0x10,%esp
  1095b7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  1095bb:	eb 87                	jmp    109544 <inode_get+0x74>
    for (ip = &inode_cache.inode[0]; ip < &inode_cache.inode[NINODE]; ip++) {
  1095bd:	83 c6 50             	add    $0x50,%esi
  1095c0:	39 d6                	cmp    %edx,%esi
  1095c2:	73 d2                	jae    109596 <inode_get+0xc6>
        if (ip->ref > 0 && ip->dev == dev && ip->inum == inum) {
  1095c4:	8b 46 08             	mov    0x8(%esi),%eax
  1095c7:	85 c0                	test   %eax,%eax
  1095c9:	0f 8f 41 ff ff ff    	jg     109510 <inode_get+0x40>
  1095cf:	e9 52 ff ff ff       	jmp    109526 <inode_get+0x56>
  1095d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1095db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1095df:	90                   	nop

001095e0 <inode_alloc>:
{
  1095e0:	55                   	push   %ebp
  1095e1:	57                   	push   %edi
  1095e2:	56                   	push   %esi
  1095e3:	53                   	push   %ebx
  1095e4:	e8 a0 6d ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1095e9:	81 c3 17 aa 00 00    	add    $0xaa17,%ebx
  1095ef:	83 ec 34             	sub    $0x34,%esp
  1095f2:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  1095f6:	8b 7c 24 48          	mov    0x48(%esp),%edi
  1095fa:	89 44 24 10          	mov    %eax,0x10(%esp)
    read_superblock(dev, &sb);
  1095fe:	8d 44 24 18          	lea    0x18(%esp),%eax
  109602:	50                   	push   %eax
  109603:	57                   	push   %edi
  109604:	e8 47 fa ff ff       	call   109050 <read_superblock>
    for (inum = 1; inum < sb.ninodes; inum++) {
  109609:	83 c4 10             	add    $0x10,%esp
  10960c:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
  109611:	0f 86 89 00 00 00    	jbe    1096a0 <inode_alloc+0xc0>
  109617:	bd 01 00 00 00       	mov    $0x1,%ebp
  10961c:	eb 17                	jmp    109635 <inode_alloc+0x55>
  10961e:	66 90                	xchg   %ax,%ax
        bufcache_release(bp);
  109620:	83 ec 0c             	sub    $0xc,%esp
    for (inum = 1; inum < sb.ninodes; inum++) {
  109623:	83 c5 01             	add    $0x1,%ebp
        bufcache_release(bp);
  109626:	56                   	push   %esi
  109627:	e8 b4 f5 ff ff       	call   108be0 <bufcache_release>
    for (inum = 1; inum < sb.ninodes; inum++) {
  10962c:	83 c4 10             	add    $0x10,%esp
  10962f:	39 6c 24 18          	cmp    %ebp,0x18(%esp)
  109633:	76 6b                	jbe    1096a0 <inode_alloc+0xc0>
        bp = bufcache_read(dev, IBLOCK(inum));
  109635:	89 e8                	mov    %ebp,%eax
  109637:	83 ec 08             	sub    $0x8,%esp
  10963a:	c1 e8 03             	shr    $0x3,%eax
  10963d:	83 c0 02             	add    $0x2,%eax
  109640:	50                   	push   %eax
  109641:	57                   	push   %edi
  109642:	e8 19 f4 ff ff       	call   108a60 <bufcache_read>
        if (dip->type == 0) {  // a free inode
  109647:	83 c4 10             	add    $0x10,%esp
        bp = bufcache_read(dev, IBLOCK(inum));
  10964a:	89 c6                	mov    %eax,%esi
        dip = (struct dinode *) bp->data + inum % IPB;
  10964c:	89 e8                	mov    %ebp,%eax
  10964e:	83 e0 07             	and    $0x7,%eax
  109651:	c1 e0 06             	shl    $0x6,%eax
  109654:	8d 4c 06 18          	lea    0x18(%esi,%eax,1),%ecx
        if (dip->type == 0) {  // a free inode
  109658:	66 83 39 00          	cmpw   $0x0,(%ecx)
  10965c:	75 c2                	jne    109620 <inode_alloc+0x40>
            memset(dip, 0, sizeof(*dip));
  10965e:	83 ec 04             	sub    $0x4,%esp
  109661:	6a 40                	push   $0x40
  109663:	6a 00                	push   $0x0
  109665:	51                   	push   %ecx
  109666:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
  10966a:	e8 e1 ac ff ff       	call   104350 <memset>
            dip->type = type;
  10966f:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
  109673:	0f b7 44 24 18       	movzwl 0x18(%esp),%eax
  109678:	66 89 01             	mov    %ax,(%ecx)
            log_write(bp);  // mark it allocated on the disk
  10967b:	89 34 24             	mov    %esi,(%esp)
  10967e:	e8 9d f8 ff ff       	call   108f20 <log_write>
            bufcache_release(bp);
  109683:	89 34 24             	mov    %esi,(%esp)
  109686:	e8 55 f5 ff ff       	call   108be0 <bufcache_release>
            return inode_get(dev, inum);
  10968b:	58                   	pop    %eax
  10968c:	5a                   	pop    %edx
  10968d:	55                   	push   %ebp
  10968e:	57                   	push   %edi
  10968f:	e8 3c fe ff ff       	call   1094d0 <inode_get>
  109694:	83 c4 10             	add    $0x10,%esp
}
  109697:	83 c4 2c             	add    $0x2c,%esp
  10969a:	5b                   	pop    %ebx
  10969b:	5e                   	pop    %esi
  10969c:	5f                   	pop    %edi
  10969d:	5d                   	pop    %ebp
  10969e:	c3                   	ret    
  10969f:	90                   	nop
    KERN_PANIC("inode_alloc: no inodes");
  1096a0:	83 ec 04             	sub    $0x4,%esp
  1096a3:	8d 83 57 8c ff ff    	lea    -0x73a9(%ebx),%eax
  1096a9:	50                   	push   %eax
  1096aa:	8d 83 32 8c ff ff    	lea    -0x73ce(%ebx),%eax
  1096b0:	6a 38                	push   $0x38
  1096b2:	50                   	push   %eax
  1096b3:	e8 58 b0 ff ff       	call   104710 <debug_panic>
    return NULL;
  1096b8:	83 c4 10             	add    $0x10,%esp
  1096bb:	31 c0                	xor    %eax,%eax
}
  1096bd:	83 c4 2c             	add    $0x2c,%esp
  1096c0:	5b                   	pop    %ebx
  1096c1:	5e                   	pop    %esi
  1096c2:	5f                   	pop    %edi
  1096c3:	5d                   	pop    %ebp
  1096c4:	c3                   	ret    
  1096c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1096cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001096d0 <inode_dup>:
{
  1096d0:	57                   	push   %edi
  1096d1:	56                   	push   %esi
  1096d2:	53                   	push   %ebx
  1096d3:	8b 74 24 10          	mov    0x10(%esp),%esi
  1096d7:	e8 ad 6c ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1096dc:	81 c3 24 a9 00 00    	add    $0xa924,%ebx
    spinlock_acquire(&inode_cache.lock);
  1096e2:	83 ec 0c             	sub    $0xc,%esp
  1096e5:	8d bb c0 b7 d0 00    	lea    0xd0b7c0(%ebx),%edi
  1096eb:	57                   	push   %edi
  1096ec:	e8 7f c7 ff ff       	call   105e70 <spinlock_acquire>
    ip->ref++;
  1096f1:	83 46 08 01          	addl   $0x1,0x8(%esi)
    spinlock_release(&inode_cache.lock);
  1096f5:	89 3c 24             	mov    %edi,(%esp)
  1096f8:	e8 f3 c7 ff ff       	call   105ef0 <spinlock_release>
    return ip;
  1096fd:	83 c4 10             	add    $0x10,%esp
}
  109700:	89 f0                	mov    %esi,%eax
  109702:	5b                   	pop    %ebx
  109703:	5e                   	pop    %esi
  109704:	5f                   	pop    %edi
  109705:	c3                   	ret    
  109706:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10970d:	8d 76 00             	lea    0x0(%esi),%esi

00109710 <inode_lock>:
{
  109710:	57                   	push   %edi
  109711:	56                   	push   %esi
  109712:	53                   	push   %ebx
  109713:	8b 74 24 10          	mov    0x10(%esp),%esi
  109717:	e8 6d 6c ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10971c:	81 c3 e4 a8 00 00    	add    $0xa8e4,%ebx
    if (ip == 0 || ip->ref < 1)
  109722:	85 f6                	test   %esi,%esi
  109724:	74 5a                	je     109780 <inode_lock+0x70>
  109726:	8b 46 08             	mov    0x8(%esi),%eax
  109729:	85 c0                	test   %eax,%eax
  10972b:	7e 53                	jle    109780 <inode_lock+0x70>
    spinlock_acquire(&inode_cache.lock);
  10972d:	83 ec 0c             	sub    $0xc,%esp
  109730:	8d bb c0 b7 d0 00    	lea    0xd0b7c0(%ebx),%edi
  109736:	57                   	push   %edi
  109737:	e8 34 c7 ff ff       	call   105e70 <spinlock_acquire>
    while (ip->flags & I_BUSY)
  10973c:	8b 46 0c             	mov    0xc(%esi),%eax
  10973f:	83 c4 10             	add    $0x10,%esp
  109742:	a8 01                	test   $0x1,%al
  109744:	74 1e                	je     109764 <inode_lock+0x54>
  109746:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10974d:	8d 76 00             	lea    0x0(%esi),%esi
        thread_sleep(ip, &inode_cache.lock);
  109750:	83 ec 08             	sub    $0x8,%esp
  109753:	57                   	push   %edi
  109754:	56                   	push   %esi
  109755:	e8 66 e4 ff ff       	call   107bc0 <thread_sleep>
    while (ip->flags & I_BUSY)
  10975a:	8b 46 0c             	mov    0xc(%esi),%eax
  10975d:	83 c4 10             	add    $0x10,%esp
  109760:	a8 01                	test   $0x1,%al
  109762:	75 ec                	jne    109750 <inode_lock+0x40>
    spinlock_release(&inode_cache.lock);
  109764:	83 ec 0c             	sub    $0xc,%esp
    ip->flags |= I_BUSY;
  109767:	83 c8 01             	or     $0x1,%eax
  10976a:	89 46 0c             	mov    %eax,0xc(%esi)
    spinlock_release(&inode_cache.lock);
  10976d:	57                   	push   %edi
  10976e:	e8 7d c7 ff ff       	call   105ef0 <spinlock_release>
    if (!(ip->flags & I_VALID)) {
  109773:	83 c4 10             	add    $0x10,%esp
  109776:	f6 46 0c 02          	testb  $0x2,0xc(%esi)
  10977a:	74 24                	je     1097a0 <inode_lock+0x90>
}
  10977c:	5b                   	pop    %ebx
  10977d:	5e                   	pop    %esi
  10977e:	5f                   	pop    %edi
  10977f:	c3                   	ret    
        KERN_PANIC("inode_lock");
  109780:	83 ec 04             	sub    $0x4,%esp
  109783:	8d 83 6e 8c ff ff    	lea    -0x7392(%ebx),%eax
  109789:	50                   	push   %eax
  10978a:	8d 83 32 8c ff ff    	lea    -0x73ce(%ebx),%eax
  109790:	68 8b 00 00 00       	push   $0x8b
  109795:	50                   	push   %eax
  109796:	e8 75 af ff ff       	call   104710 <debug_panic>
  10979b:	83 c4 10             	add    $0x10,%esp
  10979e:	eb 8d                	jmp    10972d <inode_lock+0x1d>
        bp = bufcache_read(ip->dev, IBLOCK(ip->inum));
  1097a0:	8b 46 04             	mov    0x4(%esi),%eax
  1097a3:	83 ec 08             	sub    $0x8,%esp
  1097a6:	c1 e8 03             	shr    $0x3,%eax
  1097a9:	83 c0 02             	add    $0x2,%eax
  1097ac:	50                   	push   %eax
  1097ad:	ff 36                	push   (%esi)
  1097af:	e8 ac f2 ff ff       	call   108a60 <bufcache_read>
        memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  1097b4:	83 c4 0c             	add    $0xc,%esp
        bp = bufcache_read(ip->dev, IBLOCK(ip->inum));
  1097b7:	89 c7                	mov    %eax,%edi
        dip = (struct dinode *) bp->data + ip->inum % IPB;
  1097b9:	8b 46 04             	mov    0x4(%esi),%eax
  1097bc:	83 e0 07             	and    $0x7,%eax
  1097bf:	c1 e0 06             	shl    $0x6,%eax
  1097c2:	8d 44 07 18          	lea    0x18(%edi,%eax,1),%eax
        ip->type = dip->type;
  1097c6:	0f b7 10             	movzwl (%eax),%edx
        memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  1097c9:	83 c0 0c             	add    $0xc,%eax
        ip->type = dip->type;
  1097cc:	66 89 56 10          	mov    %dx,0x10(%esi)
        ip->major = dip->major;
  1097d0:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
  1097d4:	66 89 56 12          	mov    %dx,0x12(%esi)
        ip->minor = dip->minor;
  1097d8:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
  1097dc:	66 89 56 14          	mov    %dx,0x14(%esi)
        ip->nlink = dip->nlink;
  1097e0:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
  1097e4:	66 89 56 16          	mov    %dx,0x16(%esi)
        ip->size = dip->size;
  1097e8:	8b 50 fc             	mov    -0x4(%eax),%edx
  1097eb:	89 56 18             	mov    %edx,0x18(%esi)
        memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  1097ee:	6a 34                	push   $0x34
  1097f0:	50                   	push   %eax
  1097f1:	8d 46 1c             	lea    0x1c(%esi),%eax
  1097f4:	50                   	push   %eax
  1097f5:	e8 a6 ab ff ff       	call   1043a0 <memmove>
        bufcache_release(bp);
  1097fa:	89 3c 24             	mov    %edi,(%esp)
  1097fd:	e8 de f3 ff ff       	call   108be0 <bufcache_release>
        ip->flags |= I_VALID;
  109802:	83 4e 0c 02          	orl    $0x2,0xc(%esi)
        if (ip->type == 0)
  109806:	83 c4 10             	add    $0x10,%esp
  109809:	66 83 7e 10 00       	cmpw   $0x0,0x10(%esi)
  10980e:	0f 85 68 ff ff ff    	jne    10977c <inode_lock+0x6c>
            KERN_PANIC("inode_lock: no type");
  109814:	83 ec 04             	sub    $0x4,%esp
  109817:	8d 83 79 8c ff ff    	lea    -0x7387(%ebx),%eax
  10981d:	50                   	push   %eax
  10981e:	8d 83 32 8c ff ff    	lea    -0x73ce(%ebx),%eax
  109824:	68 9f 00 00 00       	push   $0x9f
  109829:	50                   	push   %eax
  10982a:	e8 e1 ae ff ff       	call   104710 <debug_panic>
  10982f:	83 c4 10             	add    $0x10,%esp
}
  109832:	5b                   	pop    %ebx
  109833:	5e                   	pop    %esi
  109834:	5f                   	pop    %edi
  109835:	c3                   	ret    
  109836:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10983d:	8d 76 00             	lea    0x0(%esi),%esi

00109840 <inode_unlock>:
{
  109840:	57                   	push   %edi
  109841:	56                   	push   %esi
  109842:	53                   	push   %ebx
  109843:	8b 74 24 10          	mov    0x10(%esp),%esi
  109847:	e8 3d 6b ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10984c:	81 c3 b4 a7 00 00    	add    $0xa7b4,%ebx
    if (ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
  109852:	85 f6                	test   %esi,%esi
  109854:	74 06                	je     10985c <inode_unlock+0x1c>
  109856:	f6 46 0c 01          	testb  $0x1,0xc(%esi)
  10985a:	75 4c                	jne    1098a8 <inode_unlock+0x68>
        KERN_PANIC("inode_unlock");
  10985c:	83 ec 04             	sub    $0x4,%esp
  10985f:	8d 83 8d 8c ff ff    	lea    -0x7373(%ebx),%eax
  109865:	50                   	push   %eax
  109866:	8d 83 32 8c ff ff    	lea    -0x73ce(%ebx),%eax
  10986c:	68 aa 00 00 00       	push   $0xaa
  109871:	50                   	push   %eax
  109872:	e8 99 ae ff ff       	call   104710 <debug_panic>
  109877:	83 c4 10             	add    $0x10,%esp
    spinlock_acquire(&inode_cache.lock);
  10987a:	83 ec 0c             	sub    $0xc,%esp
  10987d:	8d bb c0 b7 d0 00    	lea    0xd0b7c0(%ebx),%edi
  109883:	57                   	push   %edi
  109884:	e8 e7 c5 ff ff       	call   105e70 <spinlock_acquire>
    ip->flags &= ~I_BUSY;
  109889:	83 66 0c fe          	andl   $0xfffffffe,0xc(%esi)
    thread_wakeup(ip);
  10988d:	89 34 24             	mov    %esi,(%esp)
  109890:	e8 6b e3 ff ff       	call   107c00 <thread_wakeup>
    spinlock_release(&inode_cache.lock);
  109895:	89 3c 24             	mov    %edi,(%esp)
  109898:	e8 53 c6 ff ff       	call   105ef0 <spinlock_release>
}
  10989d:	83 c4 10             	add    $0x10,%esp
  1098a0:	5b                   	pop    %ebx
  1098a1:	5e                   	pop    %esi
  1098a2:	5f                   	pop    %edi
  1098a3:	c3                   	ret    
  1098a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
  1098a8:	8b 46 08             	mov    0x8(%esi),%eax
  1098ab:	85 c0                	test   %eax,%eax
  1098ad:	7f cb                	jg     10987a <inode_unlock+0x3a>
  1098af:	eb ab                	jmp    10985c <inode_unlock+0x1c>
  1098b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1098b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1098bf:	90                   	nop

001098c0 <inode_put>:
{
  1098c0:	55                   	push   %ebp
  1098c1:	57                   	push   %edi
  1098c2:	56                   	push   %esi
  1098c3:	53                   	push   %ebx
  1098c4:	e8 c0 6a ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1098c9:	81 c3 37 a7 00 00    	add    $0xa737,%ebx
  1098cf:	83 ec 28             	sub    $0x28,%esp
  1098d2:	8b 74 24 3c          	mov    0x3c(%esp),%esi
    spinlock_acquire(&inode_cache.lock);
  1098d6:	8d bb c0 b7 d0 00    	lea    0xd0b7c0(%ebx),%edi
  1098dc:	57                   	push   %edi
  1098dd:	e8 8e c5 ff ff       	call   105e70 <spinlock_acquire>
    if (ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0) {
  1098e2:	8b 46 08             	mov    0x8(%esi),%eax
  1098e5:	83 c4 10             	add    $0x10,%esp
  1098e8:	83 f8 01             	cmp    $0x1,%eax
  1098eb:	74 1b                	je     109908 <inode_put+0x48>
    spinlock_release(&inode_cache.lock);
  1098ed:	83 ec 0c             	sub    $0xc,%esp
    ip->ref--;
  1098f0:	83 e8 01             	sub    $0x1,%eax
  1098f3:	89 46 08             	mov    %eax,0x8(%esi)
    spinlock_release(&inode_cache.lock);
  1098f6:	57                   	push   %edi
  1098f7:	e8 f4 c5 ff ff       	call   105ef0 <spinlock_release>
}
  1098fc:	83 c4 2c             	add    $0x2c,%esp
  1098ff:	5b                   	pop    %ebx
  109900:	5e                   	pop    %esi
  109901:	5f                   	pop    %edi
  109902:	5d                   	pop    %ebp
  109903:	c3                   	ret    
  109904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0) {
  109908:	8b 56 0c             	mov    0xc(%esi),%edx
  10990b:	f6 c2 02             	test   $0x2,%dl
  10990e:	74 dd                	je     1098ed <inode_put+0x2d>
  109910:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
  109915:	75 d6                	jne    1098ed <inode_put+0x2d>
        if (ip->flags & I_BUSY)
  109917:	f6 c2 01             	test   $0x1,%dl
  10991a:	0f 85 97 00 00 00    	jne    1099b7 <inode_put+0xf7>
        ip->flags |= I_BUSY;
  109920:	83 ca 01             	or     $0x1,%edx
        spinlock_release(&inode_cache.lock);
  109923:	83 ec 0c             	sub    $0xc,%esp
  109926:	8d 6e 1c             	lea    0x1c(%esi),%ebp
        ip->flags |= I_BUSY;
  109929:	89 56 0c             	mov    %edx,0xc(%esi)
        spinlock_release(&inode_cache.lock);
  10992c:	57                   	push   %edi
  10992d:	e8 be c5 ff ff       	call   105ef0 <spinlock_release>
{
    int i, j;
    struct buf *bp;
    uint32_t *a;

    for (i = 0; i < NDIRECT; i++) {
  109932:	8d 56 4c             	lea    0x4c(%esi),%edx
  109935:	83 c4 10             	add    $0x10,%esp
  109938:	eb 0d                	jmp    109947 <inode_put+0x87>
  10993a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  109940:	83 c5 04             	add    $0x4,%ebp
  109943:	39 d5                	cmp    %edx,%ebp
  109945:	74 29                	je     109970 <inode_put+0xb0>
        if (ip->addrs[i]) {
  109947:	8b 45 00             	mov    0x0(%ebp),%eax
  10994a:	85 c0                	test   %eax,%eax
  10994c:	74 f2                	je     109940 <inode_put+0x80>
  10994e:	89 54 24 08          	mov    %edx,0x8(%esp)
            block_free(ip->dev, ip->addrs[i]);
  109952:	83 ec 08             	sub    $0x8,%esp
  109955:	50                   	push   %eax
  109956:	ff 36                	push   (%esi)
  109958:	e8 f3 f8 ff ff       	call   109250 <block_free>
            ip->addrs[i] = 0;
  10995d:	83 c4 10             	add    $0x10,%esp
  109960:	c7 45 00 00 00 00 00 	movl   $0x0,0x0(%ebp)
  109967:	8b 54 24 08          	mov    0x8(%esp),%edx
  10996b:	eb d3                	jmp    109940 <inode_put+0x80>
  10996d:	8d 76 00             	lea    0x0(%esi),%esi
        }
    }

    if (ip->addrs[NDIRECT]) {
  109970:	8b 46 4c             	mov    0x4c(%esi),%eax
  109973:	85 c0                	test   %eax,%eax
  109975:	75 66                	jne    1099dd <inode_put+0x11d>
        block_free(ip->dev, ip->addrs[NDIRECT]);
        ip->addrs[NDIRECT] = 0;
    }

    ip->size = 0;
    inode_update(ip);
  109977:	83 ec 0c             	sub    $0xc,%esp
    ip->size = 0;
  10997a:	c7 46 18 00 00 00 00 	movl   $0x0,0x18(%esi)
    inode_update(ip);
  109981:	56                   	push   %esi
  109982:	e8 b9 fa ff ff       	call   109440 <inode_update>
        ip->type = 0;
  109987:	31 c0                	xor    %eax,%eax
  109989:	66 89 46 10          	mov    %ax,0x10(%esi)
        inode_update(ip);
  10998d:	89 34 24             	mov    %esi,(%esp)
  109990:	e8 ab fa ff ff       	call   109440 <inode_update>
        spinlock_acquire(&inode_cache.lock);
  109995:	89 3c 24             	mov    %edi,(%esp)
  109998:	e8 d3 c4 ff ff       	call   105e70 <spinlock_acquire>
        ip->flags = 0;
  10999d:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
        thread_wakeup(ip);
  1099a4:	89 34 24             	mov    %esi,(%esp)
  1099a7:	e8 54 e2 ff ff       	call   107c00 <thread_wakeup>
    ip->ref--;
  1099ac:	8b 46 08             	mov    0x8(%esi),%eax
  1099af:	83 c4 10             	add    $0x10,%esp
  1099b2:	e9 36 ff ff ff       	jmp    1098ed <inode_put+0x2d>
            KERN_PANIC("inode_put busy");
  1099b7:	83 ec 04             	sub    $0x4,%esp
  1099ba:	8d 83 9a 8c ff ff    	lea    -0x7366(%ebx),%eax
  1099c0:	50                   	push   %eax
  1099c1:	8d 83 32 8c ff ff    	lea    -0x73ce(%ebx),%eax
  1099c7:	68 bf 00 00 00       	push   $0xbf
  1099cc:	50                   	push   %eax
  1099cd:	e8 3e ad ff ff       	call   104710 <debug_panic>
        ip->flags |= I_BUSY;
  1099d2:	8b 56 0c             	mov    0xc(%esi),%edx
  1099d5:	83 c4 10             	add    $0x10,%esp
  1099d8:	e9 43 ff ff ff       	jmp    109920 <inode_put+0x60>
        bp = bufcache_read(ip->dev, ip->addrs[NDIRECT]);
  1099dd:	83 ec 08             	sub    $0x8,%esp
  1099e0:	50                   	push   %eax
  1099e1:	ff 36                	push   (%esi)
  1099e3:	e8 78 f0 ff ff       	call   108a60 <bufcache_read>
  1099e8:	89 c2                	mov    %eax,%edx
  1099ea:	89 44 24 1c          	mov    %eax,0x1c(%esp)
        for (j = 0; j < NINDIRECT; j++) {
  1099ee:	8d 40 18             	lea    0x18(%eax),%eax
  1099f1:	83 c4 10             	add    $0x10,%esp
  1099f4:	8d aa 18 02 00 00    	lea    0x218(%edx),%ebp
  1099fa:	eb 0b                	jmp    109a07 <inode_put+0x147>
  1099fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  109a00:	83 c0 04             	add    $0x4,%eax
  109a03:	39 e8                	cmp    %ebp,%eax
  109a05:	74 1e                	je     109a25 <inode_put+0x165>
            if (a[j])
  109a07:	8b 08                	mov    (%eax),%ecx
  109a09:	85 c9                	test   %ecx,%ecx
  109a0b:	74 f3                	je     109a00 <inode_put+0x140>
  109a0d:	89 44 24 08          	mov    %eax,0x8(%esp)
                block_free(ip->dev, a[j]);
  109a11:	83 ec 08             	sub    $0x8,%esp
  109a14:	51                   	push   %ecx
  109a15:	ff 36                	push   (%esi)
  109a17:	e8 34 f8 ff ff       	call   109250 <block_free>
  109a1c:	83 c4 10             	add    $0x10,%esp
  109a1f:	8b 44 24 08          	mov    0x8(%esp),%eax
  109a23:	eb db                	jmp    109a00 <inode_put+0x140>
        bufcache_release(bp);
  109a25:	83 ec 0c             	sub    $0xc,%esp
  109a28:	ff 74 24 18          	push   0x18(%esp)
  109a2c:	e8 af f1 ff ff       	call   108be0 <bufcache_release>
        block_free(ip->dev, ip->addrs[NDIRECT]);
  109a31:	5a                   	pop    %edx
  109a32:	59                   	pop    %ecx
  109a33:	ff 76 4c             	push   0x4c(%esi)
  109a36:	ff 36                	push   (%esi)
  109a38:	e8 13 f8 ff ff       	call   109250 <block_free>
        ip->addrs[NDIRECT] = 0;
  109a3d:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  109a44:	83 c4 10             	add    $0x10,%esp
  109a47:	e9 2b ff ff ff       	jmp    109977 <inode_put+0xb7>
  109a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00109a50 <inode_unlockput>:
{
  109a50:	53                   	push   %ebx
  109a51:	83 ec 14             	sub    $0x14,%esp
  109a54:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
    inode_unlock(ip);
  109a58:	53                   	push   %ebx
  109a59:	e8 e2 fd ff ff       	call   109840 <inode_unlock>
    inode_put(ip);
  109a5e:	89 5c 24 20          	mov    %ebx,0x20(%esp)
}
  109a62:	83 c4 18             	add    $0x18,%esp
  109a65:	5b                   	pop    %ebx
    inode_put(ip);
  109a66:	e9 55 fe ff ff       	jmp    1098c0 <inode_put>
  109a6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  109a6f:	90                   	nop

00109a70 <inode_stat>:

/**
 * Copy stat information from inode.
 */
void inode_stat(struct inode *ip, struct file_stat *st)
{
  109a70:	8b 54 24 04          	mov    0x4(%esp),%edx
  109a74:	8b 44 24 08          	mov    0x8(%esp),%eax
    st->dev = ip->dev;
  109a78:	8b 0a                	mov    (%edx),%ecx
  109a7a:	89 48 04             	mov    %ecx,0x4(%eax)
    st->ino = ip->inum;
  109a7d:	8b 4a 04             	mov    0x4(%edx),%ecx
  109a80:	89 48 08             	mov    %ecx,0x8(%eax)
    st->type = ip->type;
  109a83:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
  109a87:	66 89 08             	mov    %cx,(%eax)
    st->nlink = ip->nlink;
  109a8a:	0f b7 4a 16          	movzwl 0x16(%edx),%ecx
    st->size = ip->size;
  109a8e:	8b 52 18             	mov    0x18(%edx),%edx
    st->nlink = ip->nlink;
  109a91:	66 89 48 0c          	mov    %cx,0xc(%eax)
    st->size = ip->size;
  109a95:	89 50 10             	mov    %edx,0x10(%eax)
}
  109a98:	c3                   	ret    
  109a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00109aa0 <inode_read>:

/**
 * Read data from inode.
 */
int inode_read(struct inode *ip, char *dst, uint32_t off, uint32_t n)
{
  109aa0:	55                   	push   %ebp
  109aa1:	57                   	push   %edi
  109aa2:	56                   	push   %esi
  109aa3:	53                   	push   %ebx
  109aa4:	e8 e0 68 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  109aa9:	81 c3 57 a5 00 00    	add    $0xa557,%ebx
  109aaf:	83 ec 2c             	sub    $0x2c,%esp
  109ab2:	8b 44 24 44          	mov    0x44(%esp),%eax
  109ab6:	8b 6c 24 40          	mov    0x40(%esp),%ebp
  109aba:	8b 7c 24 48          	mov    0x48(%esp),%edi
  109abe:	89 44 24 10          	mov    %eax,0x10(%esp)
  109ac2:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    uint32_t tot, m;
    struct buf *bp;

    if (ip->type == T_DEV) {
  109ac6:	66 83 7d 10 03       	cmpw   $0x3,0x10(%ebp)
{
  109acb:	89 44 24 0c          	mov    %eax,0xc(%esp)
    if (ip->type == T_DEV) {
  109acf:	0f 84 c3 00 00 00    	je     109b98 <inode_read+0xf8>
        if (ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
            return -1;
        return devsw[ip->major].read(ip, dst, n);
    }

    if (off > ip->size || off + n < off)
  109ad5:	8b 45 18             	mov    0x18(%ebp),%eax
  109ad8:	39 f8                	cmp    %edi,%eax
  109ada:	0f 82 ec 00 00 00    	jb     109bcc <inode_read+0x12c>
  109ae0:	8b 54 24 0c          	mov    0xc(%esp),%edx
  109ae4:	31 c9                	xor    %ecx,%ecx
  109ae6:	01 fa                	add    %edi,%edx
  109ae8:	0f 92 c1             	setb   %cl
  109aeb:	89 ce                	mov    %ecx,%esi
  109aed:	0f 82 d9 00 00 00    	jb     109bcc <inode_read+0x12c>
        return -1;
    if (off + n > ip->size)
        n = ip->size - off;
  109af3:	89 c1                	mov    %eax,%ecx
  109af5:	29 f9                	sub    %edi,%ecx
  109af7:	39 d0                	cmp    %edx,%eax
  109af9:	0f 43 4c 24 0c       	cmovae 0xc(%esp),%ecx
  109afe:	89 4c 24 0c          	mov    %ecx,0xc(%esp)

    for (tot = 0; tot < n; tot += m, off += m, dst += m) {
  109b02:	85 c9                	test   %ecx,%ecx
  109b04:	0f 84 7c 00 00 00    	je     109b86 <inode_read+0xe6>
        bp = bufcache_read(ip->dev, bmap(ip, off / BSIZE));
        m = min(n - tot, BSIZE - off % BSIZE);
  109b0a:	89 6c 24 1c          	mov    %ebp,0x1c(%esp)
  109b0e:	89 f5                	mov    %esi,%ebp
        bp = bufcache_read(ip->dev, bmap(ip, off / BSIZE));
  109b10:	8b 74 24 1c          	mov    0x1c(%esp),%esi
  109b14:	89 fa                	mov    %edi,%edx
  109b16:	c1 ea 09             	shr    $0x9,%edx
  109b19:	89 f0                	mov    %esi,%eax
  109b1b:	e8 00 f8 ff ff       	call   109320 <bmap>
  109b20:	83 ec 08             	sub    $0x8,%esp
  109b23:	50                   	push   %eax
  109b24:	ff 36                	push   (%esi)
  109b26:	e8 35 ef ff ff       	call   108a60 <bufcache_read>
        m = min(n - tot, BSIZE - off % BSIZE);
  109b2b:	89 f9                	mov    %edi,%ecx
  109b2d:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
        bp = bufcache_read(ip->dev, bmap(ip, off / BSIZE));
  109b33:	89 c6                	mov    %eax,%esi
        m = min(n - tot, BSIZE - off % BSIZE);
  109b35:	58                   	pop    %eax
  109b36:	b8 00 02 00 00       	mov    $0x200,%eax
  109b3b:	5a                   	pop    %edx
  109b3c:	29 c8                	sub    %ecx,%eax
  109b3e:	89 4c 24 20          	mov    %ecx,0x20(%esp)
  109b42:	50                   	push   %eax
  109b43:	8b 44 24 18          	mov    0x18(%esp),%eax
  109b47:	29 e8                	sub    %ebp,%eax
  109b49:	50                   	push   %eax
  109b4a:	e8 61 b7 ff ff       	call   1052b0 <min>
        memmove(dst, bp->data + off % BSIZE, m);
  109b4f:	83 c4 0c             	add    $0xc,%esp
  109b52:	50                   	push   %eax
  109b53:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  109b57:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  109b5b:	8d 44 0e 18          	lea    0x18(%esi,%ecx,1),%eax
  109b5f:	50                   	push   %eax
  109b60:	ff 74 24 1c          	push   0x1c(%esp)
  109b64:	e8 37 a8 ff ff       	call   1043a0 <memmove>
        bufcache_release(bp);
  109b69:	89 34 24             	mov    %esi,(%esp)
  109b6c:	e8 6f f0 ff ff       	call   108be0 <bufcache_release>
    for (tot = 0; tot < n; tot += m, off += m, dst += m) {
  109b71:	8b 54 24 24          	mov    0x24(%esp),%edx
  109b75:	01 54 24 20          	add    %edx,0x20(%esp)
  109b79:	83 c4 10             	add    $0x10,%esp
  109b7c:	01 d5                	add    %edx,%ebp
  109b7e:	01 d7                	add    %edx,%edi
  109b80:	39 6c 24 0c          	cmp    %ebp,0xc(%esp)
  109b84:	77 8a                	ja     109b10 <inode_read+0x70>
    }
    return n;
  109b86:	8b 44 24 0c          	mov    0xc(%esp),%eax
}
  109b8a:	83 c4 2c             	add    $0x2c,%esp
  109b8d:	5b                   	pop    %ebx
  109b8e:	5e                   	pop    %esi
  109b8f:	5f                   	pop    %edi
  109b90:	5d                   	pop    %ebp
  109b91:	c3                   	ret    
  109b92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if (ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
  109b98:	0f bf 45 12          	movswl 0x12(%ebp),%eax
  109b9c:	66 83 f8 09          	cmp    $0x9,%ax
  109ba0:	77 2a                	ja     109bcc <inode_read+0x12c>
  109ba2:	8b 93 68 c7 d0 00    	mov    0xd0c768(%ebx),%edx
  109ba8:	8b 04 c2             	mov    (%edx,%eax,8),%eax
  109bab:	85 c0                	test   %eax,%eax
  109bad:	74 1d                	je     109bcc <inode_read+0x12c>
        return devsw[ip->major].read(ip, dst, n);
  109baf:	8b 7c 24 0c          	mov    0xc(%esp),%edi
  109bb3:	89 6c 24 40          	mov    %ebp,0x40(%esp)
  109bb7:	89 7c 24 48          	mov    %edi,0x48(%esp)
  109bbb:	8b 7c 24 10          	mov    0x10(%esp),%edi
  109bbf:	89 7c 24 44          	mov    %edi,0x44(%esp)
}
  109bc3:	83 c4 2c             	add    $0x2c,%esp
  109bc6:	5b                   	pop    %ebx
  109bc7:	5e                   	pop    %esi
  109bc8:	5f                   	pop    %edi
  109bc9:	5d                   	pop    %ebp
        return devsw[ip->major].read(ip, dst, n);
  109bca:	ff e0                	jmp    *%eax
            return -1;
  109bcc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  109bd1:	eb b7                	jmp    109b8a <inode_read+0xea>
  109bd3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  109bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00109be0 <inode_write>:

/**
 * Write data to inode.
 */
int inode_write(struct inode *ip, char *src, uint32_t off, uint32_t n)
{
  109be0:	55                   	push   %ebp
  109be1:	57                   	push   %edi
  109be2:	56                   	push   %esi
  109be3:	53                   	push   %ebx
  109be4:	e8 a0 67 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  109be9:	81 c3 17 a4 00 00    	add    $0xa417,%ebx
  109bef:	83 ec 2c             	sub    $0x2c,%esp
  109bf2:	8b 44 24 40          	mov    0x40(%esp),%eax
  109bf6:	8b 7c 24 44          	mov    0x44(%esp),%edi
  109bfa:	8b 4c 24 4c          	mov    0x4c(%esp),%ecx
    uint32_t tot, m;
    struct buf *bp;

    if (ip->type == T_DEV) {
  109bfe:	66 83 78 10 03       	cmpw   $0x3,0x10(%eax)
{
  109c03:	89 7c 24 10          	mov    %edi,0x10(%esp)
  109c07:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  109c0b:	8b 7c 24 48          	mov    0x48(%esp),%edi
  109c0f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    if (ip->type == T_DEV) {
  109c13:	0f 84 cf 00 00 00    	je     109ce8 <inode_write+0x108>
        if (ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
            return -1;
        return devsw[ip->major].write(ip, src, n);
    }

    if (off > ip->size || off + n < off)
  109c19:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  109c1d:	39 78 18             	cmp    %edi,0x18(%eax)
  109c20:	0f 82 0f 01 00 00    	jb     109d35 <inode_write+0x155>
  109c26:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  109c2a:	31 d2                	xor    %edx,%edx
  109c2c:	89 c8                	mov    %ecx,%eax
  109c2e:	01 f8                	add    %edi,%eax
  109c30:	0f 92 c2             	setb   %dl
        return -1;
    if (off + n > MAXFILE * BSIZE)
  109c33:	3d 00 18 01 00       	cmp    $0x11800,%eax
  109c38:	0f 87 f7 00 00 00    	ja     109d35 <inode_write+0x155>
  109c3e:	85 d2                	test   %edx,%edx
  109c40:	0f 85 ef 00 00 00    	jne    109d35 <inode_write+0x155>
        return -1;

    for (tot = 0; tot < n; tot += m, off += m, src += m) {
  109c46:	31 ed                	xor    %ebp,%ebp
  109c48:	85 c9                	test   %ecx,%ecx
  109c4a:	0f 84 87 00 00 00    	je     109cd7 <inode_write+0xf7>
        bp = bufcache_read(ip->dev, bmap(ip, off / BSIZE));
  109c50:	8b 74 24 1c          	mov    0x1c(%esp),%esi
  109c54:	89 fa                	mov    %edi,%edx
  109c56:	c1 ea 09             	shr    $0x9,%edx
  109c59:	89 f0                	mov    %esi,%eax
  109c5b:	e8 c0 f6 ff ff       	call   109320 <bmap>
  109c60:	83 ec 08             	sub    $0x8,%esp
  109c63:	50                   	push   %eax
  109c64:	ff 36                	push   (%esi)
  109c66:	e8 f5 ed ff ff       	call   108a60 <bufcache_read>
        m = min(n - tot, BSIZE - off % BSIZE);
  109c6b:	89 f9                	mov    %edi,%ecx
        bp = bufcache_read(ip->dev, bmap(ip, off / BSIZE));
  109c6d:	89 c6                	mov    %eax,%esi
        m = min(n - tot, BSIZE - off % BSIZE);
  109c6f:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
  109c75:	58                   	pop    %eax
  109c76:	b8 00 02 00 00       	mov    $0x200,%eax
  109c7b:	5a                   	pop    %edx
  109c7c:	29 c8                	sub    %ecx,%eax
  109c7e:	89 4c 24 20          	mov    %ecx,0x20(%esp)
  109c82:	50                   	push   %eax
  109c83:	8b 44 24 18          	mov    0x18(%esp),%eax
  109c87:	29 e8                	sub    %ebp,%eax
  109c89:	50                   	push   %eax
  109c8a:	e8 21 b6 ff ff       	call   1052b0 <min>
        memmove(bp->data + off % BSIZE, src, m);
  109c8f:	83 c4 0c             	add    $0xc,%esp
  109c92:	50                   	push   %eax
  109c93:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  109c97:	ff 74 24 18          	push   0x18(%esp)
  109c9b:	8b 4c 24 24          	mov    0x24(%esp),%ecx
  109c9f:	8d 44 0e 18          	lea    0x18(%esi,%ecx,1),%eax
  109ca3:	50                   	push   %eax
  109ca4:	e8 f7 a6 ff ff       	call   1043a0 <memmove>
        log_write(bp);
  109ca9:	89 34 24             	mov    %esi,(%esp)
  109cac:	e8 6f f2 ff ff       	call   108f20 <log_write>
        bufcache_release(bp);
  109cb1:	89 34 24             	mov    %esi,(%esp)
  109cb4:	e8 27 ef ff ff       	call   108be0 <bufcache_release>
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
  109cb9:	8b 54 24 24          	mov    0x24(%esp),%edx
  109cbd:	01 54 24 20          	add    %edx,0x20(%esp)
  109cc1:	83 c4 10             	add    $0x10,%esp
  109cc4:	01 d5                	add    %edx,%ebp
  109cc6:	01 d7                	add    %edx,%edi
  109cc8:	39 6c 24 0c          	cmp    %ebp,0xc(%esp)
  109ccc:	77 82                	ja     109c50 <inode_write+0x70>
    }

    if (n > 0 && off > ip->size) {
  109cce:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  109cd2:	39 78 18             	cmp    %edi,0x18(%eax)
  109cd5:	72 49                	jb     109d20 <inode_write+0x140>
        ip->size = off;
        inode_update(ip);
    }
    return n;
  109cd7:	8b 44 24 0c          	mov    0xc(%esp),%eax
}
  109cdb:	83 c4 2c             	add    $0x2c,%esp
  109cde:	5b                   	pop    %ebx
  109cdf:	5e                   	pop    %esi
  109ce0:	5f                   	pop    %edi
  109ce1:	5d                   	pop    %ebp
  109ce2:	c3                   	ret    
  109ce3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  109ce7:	90                   	nop
        if (ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
  109ce8:	89 c7                	mov    %eax,%edi
  109cea:	0f bf 40 12          	movswl 0x12(%eax),%eax
  109cee:	66 83 f8 09          	cmp    $0x9,%ax
  109cf2:	77 41                	ja     109d35 <inode_write+0x155>
  109cf4:	8b 93 68 c7 d0 00    	mov    0xd0c768(%ebx),%edx
  109cfa:	8b 44 c2 04          	mov    0x4(%edx,%eax,8),%eax
  109cfe:	85 c0                	test   %eax,%eax
  109d00:	74 33                	je     109d35 <inode_write+0x155>
        return devsw[ip->major].write(ip, src, n);
  109d02:	89 4c 24 48          	mov    %ecx,0x48(%esp)
  109d06:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  109d0a:	89 7c 24 40          	mov    %edi,0x40(%esp)
  109d0e:	89 4c 24 44          	mov    %ecx,0x44(%esp)
}
  109d12:	83 c4 2c             	add    $0x2c,%esp
  109d15:	5b                   	pop    %ebx
  109d16:	5e                   	pop    %esi
  109d17:	5f                   	pop    %edi
  109d18:	5d                   	pop    %ebp
        return devsw[ip->major].write(ip, src, n);
  109d19:	ff e0                	jmp    *%eax
  109d1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  109d1f:	90                   	nop
        ip->size = off;
  109d20:	8b 44 24 1c          	mov    0x1c(%esp),%eax
        inode_update(ip);
  109d24:	83 ec 0c             	sub    $0xc,%esp
        ip->size = off;
  109d27:	89 78 18             	mov    %edi,0x18(%eax)
        inode_update(ip);
  109d2a:	50                   	push   %eax
  109d2b:	e8 10 f7 ff ff       	call   109440 <inode_update>
  109d30:	83 c4 10             	add    $0x10,%esp
  109d33:	eb a2                	jmp    109cd7 <inode_write+0xf7>
            return -1;
  109d35:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  109d3a:	eb 9f                	jmp    109cdb <inode_write+0xfb>
  109d3c:	66 90                	xchg   %ax,%ax
  109d3e:	66 90                	xchg   %ax,%ax

00109d40 <dir_namecmp>:
#include "dir.h"

// Directories

int dir_namecmp(const char *s, const char *t)
{
  109d40:	53                   	push   %ebx
  109d41:	e8 43 66 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  109d46:	81 c3 ba a2 00 00    	add    $0xa2ba,%ebx
  109d4c:	83 ec 0c             	sub    $0xc,%esp
    return strncmp(s, t, DIRSIZ);
  109d4f:	6a 0e                	push   $0xe
  109d51:	ff 74 24 1c          	push   0x1c(%esp)
  109d55:	ff 74 24 1c          	push   0x1c(%esp)
  109d59:	e8 c2 a6 ff ff       	call   104420 <strncmp>
}
  109d5e:	83 c4 18             	add    $0x18,%esp
  109d61:	5b                   	pop    %ebx
  109d62:	c3                   	ret    
  109d63:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  109d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00109d70 <dir_lookup>:
/**
 * Look for a directory entry in a directory.
 * If found, set *poff to byte offset of entry.
 */
struct inode *dir_lookup(struct inode *dp, char *name, uint32_t * poff)
{
  109d70:	53                   	push   %ebx
  109d71:	e8 13 66 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  109d76:	81 c3 8a a2 00 00    	add    $0xa28a,%ebx
  109d7c:	83 ec 08             	sub    $0x8,%esp
    uint32_t off, inum;
    struct dirent de;

    if (dp->type != T_DIR)
  109d7f:	8b 44 24 10          	mov    0x10(%esp),%eax
  109d83:	66 83 78 10 01       	cmpw   $0x1,0x10(%eax)
  109d88:	74 1b                	je     109da5 <dir_lookup+0x35>
        KERN_PANIC("dir_lookup not DIR");
  109d8a:	83 ec 04             	sub    $0x4,%esp
  109d8d:	8d 83 a9 8c ff ff    	lea    -0x7357(%ebx),%eax
  109d93:	50                   	push   %eax
  109d94:	8d 83 bc 8c ff ff    	lea    -0x7344(%ebx),%eax
  109d9a:	6a 18                	push   $0x18
  109d9c:	50                   	push   %eax
  109d9d:	e8 6e a9 ff ff       	call   104710 <debug_panic>
  109da2:	83 c4 10             	add    $0x10,%esp

    //TODO

    return 0;
}
  109da5:	83 c4 08             	add    $0x8,%esp
  109da8:	31 c0                	xor    %eax,%eax
  109daa:	5b                   	pop    %ebx
  109dab:	c3                   	ret    
  109dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00109db0 <dir_link>:
    // TODO: Check that name is not present.

    // TODO: Look for an empty dirent.

    return 0;
}
  109db0:	31 c0                	xor    %eax,%eax
  109db2:	c3                   	ret    
  109db3:	66 90                	xchg   %ax,%ax
  109db5:	66 90                	xchg   %ax,%ax
  109db7:	66 90                	xchg   %ax,%ax
  109db9:	66 90                	xchg   %ax,%ax
  109dbb:	66 90                	xchg   %ax,%ax
  109dbd:	66 90                	xchg   %ax,%ax
  109dbf:	90                   	nop

00109dc0 <namei>:

/**
 * Return the inode corresponding to path.
 */
struct inode *namei(char *path)
{
  109dc0:	53                   	push   %ebx
  109dc1:	e8 c3 65 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  109dc6:	81 c3 3a a2 00 00    	add    $0xa23a,%ebx
  109dcc:	83 ec 08             	sub    $0x8,%esp
    if (*path == '/') {
  109dcf:	8b 44 24 10          	mov    0x10(%esp),%eax
  109dd3:	80 38 2f             	cmpb   $0x2f,(%eax)
  109dd6:	74 28                	je     109e00 <namei+0x40>
        ip = inode_dup((struct inode *) tcb_get_cwd(get_curid()));
  109dd8:	e8 73 db ff ff       	call   107950 <get_curid>
  109ddd:	83 ec 0c             	sub    $0xc,%esp
  109de0:	50                   	push   %eax
  109de1:	e8 ea d7 ff ff       	call   1075d0 <tcb_get_cwd>
  109de6:	89 04 24             	mov    %eax,(%esp)
  109de9:	e8 e2 f8 ff ff       	call   1096d0 <inode_dup>
  109dee:	83 c4 10             	add    $0x10,%esp
    char name[DIRSIZ];
    return namex(path, FALSE, name);
}
  109df1:	83 c4 08             	add    $0x8,%esp
  109df4:	5b                   	pop    %ebx
  109df5:	c3                   	ret    
  109df6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  109dfd:	8d 76 00             	lea    0x0(%esi),%esi
        ip = inode_get(ROOTDEV, ROOTINO);
  109e00:	83 ec 08             	sub    $0x8,%esp
  109e03:	6a 01                	push   $0x1
  109e05:	6a 01                	push   $0x1
  109e07:	e8 c4 f6 ff ff       	call   1094d0 <inode_get>
  109e0c:	83 c4 10             	add    $0x10,%esp
}
  109e0f:	83 c4 08             	add    $0x8,%esp
  109e12:	5b                   	pop    %ebx
  109e13:	c3                   	ret    
  109e14:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  109e1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  109e1f:	90                   	nop

00109e20 <nameiparent>:
/**
 * Return the inode corresponding to path's parent directory and copy the final
 * element into name.
 */
struct inode *nameiparent(char *path, char *name)
{
  109e20:	53                   	push   %ebx
  109e21:	e8 63 65 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  109e26:	81 c3 da a1 00 00    	add    $0xa1da,%ebx
  109e2c:	83 ec 08             	sub    $0x8,%esp
    if (*path == '/') {
  109e2f:	8b 44 24 10          	mov    0x10(%esp),%eax
  109e33:	80 38 2f             	cmpb   $0x2f,(%eax)
  109e36:	74 30                	je     109e68 <nameiparent+0x48>
        ip = inode_dup((struct inode *) tcb_get_cwd(get_curid()));
  109e38:	e8 13 db ff ff       	call   107950 <get_curid>
  109e3d:	83 ec 0c             	sub    $0xc,%esp
  109e40:	50                   	push   %eax
  109e41:	e8 8a d7 ff ff       	call   1075d0 <tcb_get_cwd>
  109e46:	89 04 24             	mov    %eax,(%esp)
  109e49:	e8 82 f8 ff ff       	call   1096d0 <inode_dup>
  109e4e:	83 c4 10             	add    $0x10,%esp
        inode_put(ip);
  109e51:	83 ec 0c             	sub    $0xc,%esp
  109e54:	50                   	push   %eax
  109e55:	e8 66 fa ff ff       	call   1098c0 <inode_put>
    return namex(path, TRUE, name);
}
  109e5a:	83 c4 18             	add    $0x18,%esp
  109e5d:	31 c0                	xor    %eax,%eax
  109e5f:	5b                   	pop    %ebx
  109e60:	c3                   	ret    
  109e61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        ip = inode_get(ROOTDEV, ROOTINO);
  109e68:	83 ec 08             	sub    $0x8,%esp
  109e6b:	6a 01                	push   $0x1
  109e6d:	6a 01                	push   $0x1
  109e6f:	e8 5c f6 ff ff       	call   1094d0 <inode_get>
  109e74:	83 c4 10             	add    $0x10,%esp
        inode_put(ip);
  109e77:	83 ec 0c             	sub    $0xc,%esp
  109e7a:	50                   	push   %eax
  109e7b:	e8 40 fa ff ff       	call   1098c0 <inode_put>
}
  109e80:	83 c4 18             	add    $0x18,%esp
  109e83:	31 c0                	xor    %eax,%eax
  109e85:	5b                   	pop    %ebx
  109e86:	c3                   	ret    
  109e87:	66 90                	xchg   %ax,%ax
  109e89:	66 90                	xchg   %ax,%ax
  109e8b:	66 90                	xchg   %ax,%ax
  109e8d:	66 90                	xchg   %ax,%ax
  109e8f:	90                   	nop

00109e90 <file_init>:
    spinlock_t lock;
    struct file file[NFILE];
} ftable;

void file_init(void)
{
  109e90:	53                   	push   %ebx
  109e91:	e8 f3 64 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  109e96:	81 c3 6a a1 00 00    	add    $0xa16a,%ebx
  109e9c:	83 ec 14             	sub    $0x14,%esp
    spinlock_init(&ftable.lock);
  109e9f:	8d 83 80 c7 d0 00    	lea    0xd0c780(%ebx),%eax
  109ea5:	50                   	push   %eax
  109ea6:	e8 35 bf ff ff       	call   105de0 <spinlock_init>
}
  109eab:	83 c4 18             	add    $0x18,%esp
  109eae:	5b                   	pop    %ebx
  109eaf:	c3                   	ret    

00109eb0 <file_alloc>:

/**
 * Allocate a file structure.
 */
struct file *file_alloc(void)
{
  109eb0:	57                   	push   %edi
  109eb1:	56                   	push   %esi
  109eb2:	53                   	push   %ebx
  109eb3:	e8 d1 64 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  109eb8:	81 c3 48 a1 00 00    	add    $0xa148,%ebx
    struct file *f;

    spinlock_acquire(&ftable.lock);
  109ebe:	83 ec 0c             	sub    $0xc,%esp
  109ec1:	8d bb 80 c7 d0 00    	lea    0xd0c780(%ebx),%edi
  109ec7:	57                   	push   %edi
    for (f = ftable.file; f < ftable.file + NFILE; f++) {
  109ec8:	8d 77 08             	lea    0x8(%edi),%esi
    spinlock_acquire(&ftable.lock);
  109ecb:	e8 a0 bf ff ff       	call   105e70 <spinlock_acquire>
  109ed0:	83 c4 10             	add    $0x10,%esp
    for (f = ftable.file; f < ftable.file + NFILE; f++) {
  109ed3:	8d 83 58 cf d0 00    	lea    0xd0cf58(%ebx),%eax
  109ed9:	eb 0c                	jmp    109ee7 <file_alloc+0x37>
  109edb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  109edf:	90                   	nop
  109ee0:	83 c6 14             	add    $0x14,%esi
  109ee3:	39 c6                	cmp    %eax,%esi
  109ee5:	74 29                	je     109f10 <file_alloc+0x60>
        if (f->ref == 0) {
  109ee7:	8b 56 04             	mov    0x4(%esi),%edx
  109eea:	85 d2                	test   %edx,%edx
  109eec:	75 f2                	jne    109ee0 <file_alloc+0x30>
            f->ref = 1;
            spinlock_release(&ftable.lock);
  109eee:	83 ec 0c             	sub    $0xc,%esp
            f->ref = 1;
  109ef1:	c7 46 04 01 00 00 00 	movl   $0x1,0x4(%esi)
            spinlock_release(&ftable.lock);
  109ef8:	57                   	push   %edi
  109ef9:	e8 f2 bf ff ff       	call   105ef0 <spinlock_release>
            return f;
  109efe:	83 c4 10             	add    $0x10,%esp
        }
    }
    spinlock_release(&ftable.lock);
    return 0;
}
  109f01:	89 f0                	mov    %esi,%eax
  109f03:	5b                   	pop    %ebx
  109f04:	5e                   	pop    %esi
  109f05:	5f                   	pop    %edi
  109f06:	c3                   	ret    
  109f07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  109f0e:	66 90                	xchg   %ax,%ax
    spinlock_release(&ftable.lock);
  109f10:	8d 86 28 f8 ff ff    	lea    -0x7d8(%esi),%eax
  109f16:	83 ec 0c             	sub    $0xc,%esp
    return 0;
  109f19:	31 f6                	xor    %esi,%esi
    spinlock_release(&ftable.lock);
  109f1b:	50                   	push   %eax
  109f1c:	e8 cf bf ff ff       	call   105ef0 <spinlock_release>
    return 0;
  109f21:	83 c4 10             	add    $0x10,%esp
}
  109f24:	89 f0                	mov    %esi,%eax
  109f26:	5b                   	pop    %ebx
  109f27:	5e                   	pop    %esi
  109f28:	5f                   	pop    %edi
  109f29:	c3                   	ret    
  109f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00109f30 <file_dup>:

/**
 * Increment ref count for file f.
 */
struct file *file_dup(struct file *f)
{
  109f30:	57                   	push   %edi
  109f31:	56                   	push   %esi
  109f32:	53                   	push   %ebx
  109f33:	8b 74 24 10          	mov    0x10(%esp),%esi
  109f37:	e8 4d 64 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  109f3c:	81 c3 c4 a0 00 00    	add    $0xa0c4,%ebx
    spinlock_acquire(&ftable.lock);
  109f42:	83 ec 0c             	sub    $0xc,%esp
  109f45:	8d bb 80 c7 d0 00    	lea    0xd0c780(%ebx),%edi
  109f4b:	57                   	push   %edi
  109f4c:	e8 1f bf ff ff       	call   105e70 <spinlock_acquire>
    if (f->ref < 1)
  109f51:	8b 46 04             	mov    0x4(%esi),%eax
  109f54:	83 c4 10             	add    $0x10,%esp
  109f57:	85 c0                	test   %eax,%eax
  109f59:	7e 1d                	jle    109f78 <file_dup+0x48>
        KERN_PANIC("file_dup");
    f->ref++;
  109f5b:	83 c0 01             	add    $0x1,%eax
    spinlock_release(&ftable.lock);
  109f5e:	83 ec 0c             	sub    $0xc,%esp
    f->ref++;
  109f61:	89 46 04             	mov    %eax,0x4(%esi)
    spinlock_release(&ftable.lock);
  109f64:	57                   	push   %edi
  109f65:	e8 86 bf ff ff       	call   105ef0 <spinlock_release>
    return f;
  109f6a:	83 c4 10             	add    $0x10,%esp
}
  109f6d:	89 f0                	mov    %esi,%eax
  109f6f:	5b                   	pop    %ebx
  109f70:	5e                   	pop    %esi
  109f71:	5f                   	pop    %edi
  109f72:	c3                   	ret    
  109f73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  109f77:	90                   	nop
        KERN_PANIC("file_dup");
  109f78:	83 ec 04             	sub    $0x4,%esp
  109f7b:	8d 83 ca 8c ff ff    	lea    -0x7336(%ebx),%eax
  109f81:	50                   	push   %eax
  109f82:	8d 83 d3 8c ff ff    	lea    -0x732d(%ebx),%eax
  109f88:	6a 31                	push   $0x31
  109f8a:	50                   	push   %eax
  109f8b:	e8 80 a7 ff ff       	call   104710 <debug_panic>
    f->ref++;
  109f90:	8b 46 04             	mov    0x4(%esi),%eax
  109f93:	83 c4 10             	add    $0x10,%esp
  109f96:	eb c3                	jmp    109f5b <file_dup+0x2b>
  109f98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  109f9f:	90                   	nop

00109fa0 <file_close>:

/**
 * Close file f. Decrement ref count, close when reaches 0.
 */
void file_close(struct file *f)
{
  109fa0:	55                   	push   %ebp
  109fa1:	57                   	push   %edi
  109fa2:	56                   	push   %esi
  109fa3:	53                   	push   %ebx
  109fa4:	e8 e0 63 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  109fa9:	81 c3 57 a0 00 00    	add    $0xa057,%ebx
  109faf:	83 ec 28             	sub    $0x28,%esp
  109fb2:	8b 74 24 3c          	mov    0x3c(%esp),%esi
    struct file ff;

    spinlock_acquire(&ftable.lock);
  109fb6:	8d ab 80 c7 d0 00    	lea    0xd0c780(%ebx),%ebp
  109fbc:	55                   	push   %ebp
  109fbd:	e8 ae be ff ff       	call   105e70 <spinlock_acquire>
    if (f->ref < 1)
  109fc2:	8b 46 04             	mov    0x4(%esi),%eax
  109fc5:	83 c4 10             	add    $0x10,%esp
  109fc8:	85 c0                	test   %eax,%eax
  109fca:	7e 54                	jle    10a020 <file_close+0x80>
        KERN_PANIC("file_close");
    if (--f->ref > 0) {
  109fcc:	83 e8 01             	sub    $0x1,%eax
  109fcf:	89 46 04             	mov    %eax,0x4(%esi)
  109fd2:	85 c0                	test   %eax,%eax
  109fd4:	7f 32                	jg     10a008 <file_close+0x68>
        spinlock_release(&ftable.lock);
        return;
    }
    ff = *f;
  109fd6:	8b 46 0c             	mov    0xc(%esi),%eax
    f->ref = 0;
    f->type = FD_NONE;
    spinlock_release(&ftable.lock);
  109fd9:	83 ec 0c             	sub    $0xc,%esp
    ff = *f;
  109fdc:	8b 3e                	mov    (%esi),%edi
    f->ref = 0;
  109fde:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
    f->type = FD_NONE;
  109fe5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
    ff = *f;
  109feb:	89 44 24 18          	mov    %eax,0x18(%esp)
    spinlock_release(&ftable.lock);
  109fef:	55                   	push   %ebp
  109ff0:	e8 fb be ff ff       	call   105ef0 <spinlock_release>

    if (ff.type == FD_INODE) {
  109ff5:	83 c4 10             	add    $0x10,%esp
  109ff8:	83 ff 02             	cmp    $0x2,%edi
  109ffb:	74 43                	je     10a040 <file_close+0xa0>
        begin_trans();
        inode_put(ff.ip);
        commit_trans();
    }
}
  109ffd:	83 c4 1c             	add    $0x1c,%esp
  10a000:	5b                   	pop    %ebx
  10a001:	5e                   	pop    %esi
  10a002:	5f                   	pop    %edi
  10a003:	5d                   	pop    %ebp
  10a004:	c3                   	ret    
  10a005:	8d 76 00             	lea    0x0(%esi),%esi
        spinlock_release(&ftable.lock);
  10a008:	83 ec 0c             	sub    $0xc,%esp
  10a00b:	55                   	push   %ebp
  10a00c:	e8 df be ff ff       	call   105ef0 <spinlock_release>
  10a011:	83 c4 10             	add    $0x10,%esp
}
  10a014:	83 c4 1c             	add    $0x1c,%esp
  10a017:	5b                   	pop    %ebx
  10a018:	5e                   	pop    %esi
  10a019:	5f                   	pop    %edi
  10a01a:	5d                   	pop    %ebp
  10a01b:	c3                   	ret    
  10a01c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        KERN_PANIC("file_close");
  10a020:	83 ec 04             	sub    $0x4,%esp
  10a023:	8d 83 e2 8c ff ff    	lea    -0x731e(%ebx),%eax
  10a029:	50                   	push   %eax
  10a02a:	8d 83 d3 8c ff ff    	lea    -0x732d(%ebx),%eax
  10a030:	6a 40                	push   $0x40
  10a032:	50                   	push   %eax
  10a033:	e8 d8 a6 ff ff       	call   104710 <debug_panic>
    if (--f->ref > 0) {
  10a038:	8b 46 04             	mov    0x4(%esi),%eax
  10a03b:	83 c4 10             	add    $0x10,%esp
  10a03e:	eb 8c                	jmp    109fcc <file_close+0x2c>
        begin_trans();
  10a040:	e8 0b ee ff ff       	call   108e50 <begin_trans>
        inode_put(ff.ip);
  10a045:	83 ec 0c             	sub    $0xc,%esp
  10a048:	ff 74 24 18          	push   0x18(%esp)
  10a04c:	e8 6f f8 ff ff       	call   1098c0 <inode_put>
        commit_trans();
  10a051:	e8 5a ee ff ff       	call   108eb0 <commit_trans>
  10a056:	83 c4 10             	add    $0x10,%esp
}
  10a059:	83 c4 1c             	add    $0x1c,%esp
  10a05c:	5b                   	pop    %ebx
  10a05d:	5e                   	pop    %esi
  10a05e:	5f                   	pop    %edi
  10a05f:	5d                   	pop    %ebp
  10a060:	c3                   	ret    
  10a061:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10a068:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10a06f:	90                   	nop

0010a070 <file_stat>:

/**
 * Get metadata about file f.
 */
int file_stat(struct file *f, struct file_stat *st)
{
  10a070:	56                   	push   %esi
  10a071:	53                   	push   %ebx
  10a072:	e8 12 63 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10a077:	81 c3 89 9f 00 00    	add    $0x9f89,%ebx
  10a07d:	83 ec 04             	sub    $0x4,%esp
  10a080:	8b 74 24 10          	mov    0x10(%esp),%esi
    if (f->type == FD_INODE) {
  10a084:	83 3e 02             	cmpl   $0x2,(%esi)
  10a087:	75 37                	jne    10a0c0 <file_stat+0x50>
        inode_lock(f->ip);
  10a089:	83 ec 0c             	sub    $0xc,%esp
  10a08c:	ff 76 0c             	push   0xc(%esi)
  10a08f:	e8 7c f6 ff ff       	call   109710 <inode_lock>
        inode_stat(f->ip, st);
  10a094:	58                   	pop    %eax
  10a095:	5a                   	pop    %edx
  10a096:	ff 74 24 1c          	push   0x1c(%esp)
  10a09a:	ff 76 0c             	push   0xc(%esi)
  10a09d:	e8 ce f9 ff ff       	call   109a70 <inode_stat>
        inode_unlock(f->ip);
  10a0a2:	59                   	pop    %ecx
  10a0a3:	ff 76 0c             	push   0xc(%esi)
  10a0a6:	e8 95 f7 ff ff       	call   109840 <inode_unlock>
        return 0;
  10a0ab:	83 c4 10             	add    $0x10,%esp
  10a0ae:	31 c0                	xor    %eax,%eax
    }
    return -1;
}
  10a0b0:	83 c4 04             	add    $0x4,%esp
  10a0b3:	5b                   	pop    %ebx
  10a0b4:	5e                   	pop    %esi
  10a0b5:	c3                   	ret    
  10a0b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10a0bd:	8d 76 00             	lea    0x0(%esi),%esi
  10a0c0:	83 c4 04             	add    $0x4,%esp
    return -1;
  10a0c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10a0c8:	5b                   	pop    %ebx
  10a0c9:	5e                   	pop    %esi
  10a0ca:	c3                   	ret    
  10a0cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10a0cf:	90                   	nop

0010a0d0 <file_read>:

/**
 * Read from file f.
 */
int file_read(struct file *f, char *addr, int n)
{
  10a0d0:	57                   	push   %edi
  10a0d1:	56                   	push   %esi
  10a0d2:	53                   	push   %ebx
  10a0d3:	8b 74 24 10          	mov    0x10(%esp),%esi
  10a0d7:	e8 ad 62 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10a0dc:	81 c3 24 9f 00 00    	add    $0x9f24,%ebx
    int r;

    if (f->readable == 0)
  10a0e2:	80 7e 08 00          	cmpb   $0x0,0x8(%esi)
  10a0e6:	74 70                	je     10a158 <file_read+0x88>
        return -1;
    if (f->type == FD_INODE) {
  10a0e8:	83 3e 02             	cmpl   $0x2,(%esi)
  10a0eb:	75 43                	jne    10a130 <file_read+0x60>
        inode_lock(f->ip);
  10a0ed:	83 ec 0c             	sub    $0xc,%esp
  10a0f0:	ff 76 0c             	push   0xc(%esi)
  10a0f3:	e8 18 f6 ff ff       	call   109710 <inode_lock>
        if ((r = inode_read(f->ip, addr, f->off, n)) > 0)
  10a0f8:	ff 74 24 28          	push   0x28(%esp)
  10a0fc:	ff 76 10             	push   0x10(%esi)
  10a0ff:	ff 74 24 2c          	push   0x2c(%esp)
  10a103:	ff 76 0c             	push   0xc(%esi)
  10a106:	e8 95 f9 ff ff       	call   109aa0 <inode_read>
  10a10b:	83 c4 20             	add    $0x20,%esp
  10a10e:	89 c7                	mov    %eax,%edi
  10a110:	85 c0                	test   %eax,%eax
  10a112:	7e 03                	jle    10a117 <file_read+0x47>
            f->off += r;
  10a114:	01 46 10             	add    %eax,0x10(%esi)
        inode_unlock(f->ip);
  10a117:	83 ec 0c             	sub    $0xc,%esp
  10a11a:	ff 76 0c             	push   0xc(%esi)
  10a11d:	e8 1e f7 ff ff       	call   109840 <inode_unlock>
        return r;
  10a122:	83 c4 10             	add    $0x10,%esp
    }
    KERN_PANIC("file_read");
    return -1;
}
  10a125:	89 f8                	mov    %edi,%eax
  10a127:	5b                   	pop    %ebx
  10a128:	5e                   	pop    %esi
  10a129:	5f                   	pop    %edi
  10a12a:	c3                   	ret    
  10a12b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10a12f:	90                   	nop
    KERN_PANIC("file_read");
  10a130:	83 ec 04             	sub    $0x4,%esp
  10a133:	8d 83 ed 8c ff ff    	lea    -0x7313(%ebx),%eax
    return -1;
  10a139:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    KERN_PANIC("file_read");
  10a13e:	50                   	push   %eax
  10a13f:	8d 83 d3 8c ff ff    	lea    -0x732d(%ebx),%eax
  10a145:	6a 6f                	push   $0x6f
  10a147:	50                   	push   %eax
  10a148:	e8 c3 a5 ff ff       	call   104710 <debug_panic>
    return -1;
  10a14d:	83 c4 10             	add    $0x10,%esp
  10a150:	eb d3                	jmp    10a125 <file_read+0x55>
  10a152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
  10a158:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  10a15d:	eb c6                	jmp    10a125 <file_read+0x55>
  10a15f:	90                   	nop

0010a160 <file_write>:

/**
 * Write to file f.
 */
int file_write(struct file *f, char *addr, int n)
{
  10a160:	55                   	push   %ebp
  10a161:	57                   	push   %edi
  10a162:	56                   	push   %esi
  10a163:	53                   	push   %ebx
  10a164:	e8 20 62 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10a169:	81 c3 97 9e 00 00    	add    $0x9e97,%ebx
  10a16f:	83 ec 1c             	sub    $0x1c,%esp
  10a172:	8b 7c 24 30          	mov    0x30(%esp),%edi
    int r;

    if (f->writable == 0)
  10a176:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)
  10a17a:	0f 84 eb 00 00 00    	je     10a26b <file_write+0x10b>
        return -1;
    if (f->type == FD_INODE) {
  10a180:	83 3f 02             	cmpl   $0x2,(%edi)
  10a183:	0f 85 ef 00 00 00    	jne    10a278 <file_write+0x118>
        // and 2 blocks of slop for non-aligned writes.
        // this really belongs lower down, since inode_write()
        // might be writing a device like the console.
        int max = ((LOGSIZE - 1 - 1 - 2) / 2) * 512;
        int i = 0;
        while (i < n) {
  10a189:	8b 44 24 38          	mov    0x38(%esp),%eax
        int i = 0;
  10a18d:	31 ed                	xor    %ebp,%ebp
        while (i < n) {
  10a18f:	85 c0                	test   %eax,%eax
  10a191:	0f 8e cc 00 00 00    	jle    10a263 <file_write+0x103>
            commit_trans();

            if (r < 0)
                break;
            if (r != n1)
                KERN_PANIC("short file_write");
  10a197:	8d 83 f7 8c ff ff    	lea    -0x7309(%ebx),%eax
  10a19d:	89 44 24 08          	mov    %eax,0x8(%esp)
  10a1a1:	8d 83 d3 8c ff ff    	lea    -0x732d(%ebx),%eax
  10a1a7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10a1ab:	eb 31                	jmp    10a1de <file_write+0x7e>
  10a1ad:	8d 76 00             	lea    0x0(%esi),%esi
                f->off += r;
  10a1b0:	01 47 10             	add    %eax,0x10(%edi)
            inode_unlock(f->ip);
  10a1b3:	83 ec 0c             	sub    $0xc,%esp
                f->off += r;
  10a1b6:	89 44 24 10          	mov    %eax,0x10(%esp)
            inode_unlock(f->ip);
  10a1ba:	ff 77 0c             	push   0xc(%edi)
  10a1bd:	e8 7e f6 ff ff       	call   109840 <inode_unlock>
            commit_trans();
  10a1c2:	e8 e9 ec ff ff       	call   108eb0 <commit_trans>
            if (r != n1)
  10a1c7:	8b 44 24 14          	mov    0x14(%esp),%eax
  10a1cb:	83 c4 10             	add    $0x10,%esp
  10a1ce:	39 c6                	cmp    %eax,%esi
  10a1d0:	75 65                	jne    10a237 <file_write+0xd7>
            i += r;
  10a1d2:	01 c5                	add    %eax,%ebp
        while (i < n) {
  10a1d4:	39 6c 24 38          	cmp    %ebp,0x38(%esp)
  10a1d8:	0f 8e 85 00 00 00    	jle    10a263 <file_write+0x103>
            int n1 = n - i;
  10a1de:	8b 74 24 38          	mov    0x38(%esp),%esi
  10a1e2:	b8 00 06 00 00       	mov    $0x600,%eax
  10a1e7:	29 ee                	sub    %ebp,%esi
  10a1e9:	39 c6                	cmp    %eax,%esi
  10a1eb:	0f 4f f0             	cmovg  %eax,%esi
            begin_trans();
  10a1ee:	e8 5d ec ff ff       	call   108e50 <begin_trans>
            inode_lock(f->ip);
  10a1f3:	83 ec 0c             	sub    $0xc,%esp
  10a1f6:	ff 77 0c             	push   0xc(%edi)
  10a1f9:	e8 12 f5 ff ff       	call   109710 <inode_lock>
            if ((r = inode_write(f->ip, addr + i, f->off, n1)) > 0)
  10a1fe:	56                   	push   %esi
  10a1ff:	ff 77 10             	push   0x10(%edi)
  10a202:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  10a206:	01 e8                	add    %ebp,%eax
  10a208:	50                   	push   %eax
  10a209:	ff 77 0c             	push   0xc(%edi)
  10a20c:	e8 cf f9 ff ff       	call   109be0 <inode_write>
  10a211:	83 c4 20             	add    $0x20,%esp
  10a214:	85 c0                	test   %eax,%eax
  10a216:	7f 98                	jg     10a1b0 <file_write+0x50>
  10a218:	89 44 24 04          	mov    %eax,0x4(%esp)
            inode_unlock(f->ip);
  10a21c:	83 ec 0c             	sub    $0xc,%esp
  10a21f:	ff 77 0c             	push   0xc(%edi)
  10a222:	e8 19 f6 ff ff       	call   109840 <inode_unlock>
            commit_trans();
  10a227:	e8 84 ec ff ff       	call   108eb0 <commit_trans>
            if (r < 0)
  10a22c:	8b 44 24 14          	mov    0x14(%esp),%eax
  10a230:	83 c4 10             	add    $0x10,%esp
  10a233:	85 c0                	test   %eax,%eax
  10a235:	75 34                	jne    10a26b <file_write+0x10b>
  10a237:	89 44 24 04          	mov    %eax,0x4(%esp)
                KERN_PANIC("short file_write");
  10a23b:	83 ec 04             	sub    $0x4,%esp
  10a23e:	ff 74 24 0c          	push   0xc(%esp)
  10a242:	68 94 00 00 00       	push   $0x94
  10a247:	ff 74 24 18          	push   0x18(%esp)
  10a24b:	e8 c0 a4 ff ff       	call   104710 <debug_panic>
  10a250:	8b 44 24 14          	mov    0x14(%esp),%eax
  10a254:	83 c4 10             	add    $0x10,%esp
            i += r;
  10a257:	01 c5                	add    %eax,%ebp
        while (i < n) {
  10a259:	39 6c 24 38          	cmp    %ebp,0x38(%esp)
  10a25d:	0f 8f 7b ff ff ff    	jg     10a1de <file_write+0x7e>
        }
        return i == n ? n : -1;
  10a263:	89 e8                	mov    %ebp,%eax
  10a265:	3b 6c 24 38          	cmp    0x38(%esp),%ebp
  10a269:	74 05                	je     10a270 <file_write+0x110>
    }
    KERN_PANIC("file_write");
    return -1;
  10a26b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10a270:	83 c4 1c             	add    $0x1c,%esp
  10a273:	5b                   	pop    %ebx
  10a274:	5e                   	pop    %esi
  10a275:	5f                   	pop    %edi
  10a276:	5d                   	pop    %ebp
  10a277:	c3                   	ret    
    KERN_PANIC("file_write");
  10a278:	83 ec 04             	sub    $0x4,%esp
  10a27b:	8d 83 fd 8c ff ff    	lea    -0x7303(%ebx),%eax
  10a281:	50                   	push   %eax
  10a282:	8d 83 d3 8c ff ff    	lea    -0x732d(%ebx),%eax
  10a288:	68 99 00 00 00       	push   $0x99
  10a28d:	50                   	push   %eax
  10a28e:	e8 7d a4 ff ff       	call   104710 <debug_panic>
    return -1;
  10a293:	83 c4 10             	add    $0x10,%esp
  10a296:	eb d3                	jmp    10a26b <file_write+0x10b>
  10a298:	66 90                	xchg   %ax,%ax
  10a29a:	66 90                	xchg   %ax,%ax
  10a29c:	66 90                	xchg   %ax,%ax
  10a29e:	66 90                	xchg   %ax,%ax

0010a2a0 <create.constprop.0>:
    commit_trans();
    syscall_set_errno(tf, E_DISK_OP);
    return;
}

static struct inode *create(char *path, short type, short major, short minor)
  10a2a0:	55                   	push   %ebp
  10a2a1:	57                   	push   %edi
  10a2a2:	56                   	push   %esi
  10a2a3:	53                   	push   %ebx
  10a2a4:	e8 e0 60 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10a2a9:	81 c3 57 9d 00 00    	add    $0x9d57,%ebx
  10a2af:	83 ec 44             	sub    $0x44,%esp
{
    uint32_t off;
    struct inode *ip, *dp;
    char name[DIRSIZ];

    if ((dp = nameiparent(path, name)) == 0)
  10a2b2:	8d 6c 24 2a          	lea    0x2a(%esp),%ebp
static struct inode *create(char *path, short type, short major, short minor)
  10a2b6:	89 54 24 14          	mov    %edx,0x14(%esp)
    if ((dp = nameiparent(path, name)) == 0)
  10a2ba:	55                   	push   %ebp
  10a2bb:	50                   	push   %eax
  10a2bc:	e8 5f fb ff ff       	call   109e20 <nameiparent>
  10a2c1:	83 c4 10             	add    $0x10,%esp
  10a2c4:	85 c0                	test   %eax,%eax
  10a2c6:	0f 84 04 01 00 00    	je     10a3d0 <create.constprop.0+0x130>
        return 0;
    inode_lock(dp);
  10a2cc:	83 ec 0c             	sub    $0xc,%esp
  10a2cf:	89 c6                	mov    %eax,%esi
  10a2d1:	50                   	push   %eax
  10a2d2:	e8 39 f4 ff ff       	call   109710 <inode_lock>

    if ((ip = dir_lookup(dp, name, &off)) != 0) {
  10a2d7:	83 c4 0c             	add    $0xc,%esp
  10a2da:	8d 44 24 20          	lea    0x20(%esp),%eax
  10a2de:	50                   	push   %eax
  10a2df:	55                   	push   %ebp
  10a2e0:	56                   	push   %esi
  10a2e1:	e8 8a fa ff ff       	call   109d70 <dir_lookup>
  10a2e6:	83 c4 10             	add    $0x10,%esp
  10a2e9:	89 c7                	mov    %eax,%edi
  10a2eb:	85 c0                	test   %eax,%eax
  10a2ed:	74 51                	je     10a340 <create.constprop.0+0xa0>
        inode_unlockput(dp);
  10a2ef:	83 ec 0c             	sub    $0xc,%esp
  10a2f2:	56                   	push   %esi
  10a2f3:	e8 58 f7 ff ff       	call   109a50 <inode_unlockput>
        inode_lock(ip);
  10a2f8:	89 3c 24             	mov    %edi,(%esp)
  10a2fb:	e8 10 f4 ff ff       	call   109710 <inode_lock>
        if (type == T_FILE && ip->type == T_FILE)
  10a300:	83 c4 10             	add    $0x10,%esp
  10a303:	66 83 7c 24 0c 02    	cmpw   $0x2,0xc(%esp)
  10a309:	75 15                	jne    10a320 <create.constprop.0+0x80>
  10a30b:	66 83 7f 10 02       	cmpw   $0x2,0x10(%edi)
  10a310:	75 0e                	jne    10a320 <create.constprop.0+0x80>
    if (dir_link(dp, name, ip->inum) < 0)
        KERN_PANIC("create: dir_link");

    inode_unlockput(dp);
    return ip;
}
  10a312:	83 c4 3c             	add    $0x3c,%esp
  10a315:	89 f8                	mov    %edi,%eax
  10a317:	5b                   	pop    %ebx
  10a318:	5e                   	pop    %esi
  10a319:	5f                   	pop    %edi
  10a31a:	5d                   	pop    %ebp
  10a31b:	c3                   	ret    
  10a31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        inode_unlockput(ip);
  10a320:	83 ec 0c             	sub    $0xc,%esp
  10a323:	57                   	push   %edi
        return 0;
  10a324:	31 ff                	xor    %edi,%edi
        inode_unlockput(ip);
  10a326:	e8 25 f7 ff ff       	call   109a50 <inode_unlockput>
        return 0;
  10a32b:	83 c4 10             	add    $0x10,%esp
}
  10a32e:	89 f8                	mov    %edi,%eax
  10a330:	83 c4 3c             	add    $0x3c,%esp
  10a333:	5b                   	pop    %ebx
  10a334:	5e                   	pop    %esi
  10a335:	5f                   	pop    %edi
  10a336:	5d                   	pop    %ebp
  10a337:	c3                   	ret    
  10a338:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10a33f:	90                   	nop
    if ((ip = inode_alloc(dp->dev, type)) == 0)
  10a340:	83 ec 08             	sub    $0x8,%esp
  10a343:	0f bf 44 24 14       	movswl 0x14(%esp),%eax
  10a348:	50                   	push   %eax
  10a349:	ff 36                	push   (%esi)
  10a34b:	e8 90 f2 ff ff       	call   1095e0 <inode_alloc>
  10a350:	83 c4 10             	add    $0x10,%esp
  10a353:	89 c7                	mov    %eax,%edi
  10a355:	85 c0                	test   %eax,%eax
  10a357:	0f 84 f3 00 00 00    	je     10a450 <create.constprop.0+0x1b0>
    inode_lock(ip);
  10a35d:	83 ec 0c             	sub    $0xc,%esp
  10a360:	57                   	push   %edi
  10a361:	e8 aa f3 ff ff       	call   109710 <inode_lock>
    ip->major = major;
  10a366:	31 c0                	xor    %eax,%eax
    ip->minor = minor;
  10a368:	c7 47 14 00 00 01 00 	movl   $0x10000,0x14(%edi)
    ip->major = major;
  10a36f:	66 89 47 12          	mov    %ax,0x12(%edi)
    inode_update(ip);
  10a373:	89 3c 24             	mov    %edi,(%esp)
  10a376:	e8 c5 f0 ff ff       	call   109440 <inode_update>
    if (type == T_DIR) {  // Create . and .. entries.
  10a37b:	83 c4 10             	add    $0x10,%esp
  10a37e:	66 83 7c 24 0c 01    	cmpw   $0x1,0xc(%esp)
  10a384:	74 5a                	je     10a3e0 <create.constprop.0+0x140>
    if (dir_link(dp, name, ip->inum) < 0)
  10a386:	83 ec 04             	sub    $0x4,%esp
  10a389:	ff 77 04             	push   0x4(%edi)
  10a38c:	55                   	push   %ebp
  10a38d:	56                   	push   %esi
  10a38e:	e8 1d fa ff ff       	call   109db0 <dir_link>
  10a393:	83 c4 10             	add    $0x10,%esp
  10a396:	85 c0                	test   %eax,%eax
  10a398:	78 16                	js     10a3b0 <create.constprop.0+0x110>
    inode_unlockput(dp);
  10a39a:	83 ec 0c             	sub    $0xc,%esp
  10a39d:	56                   	push   %esi
  10a39e:	e8 ad f6 ff ff       	call   109a50 <inode_unlockput>
    return ip;
  10a3a3:	83 c4 10             	add    $0x10,%esp
}
  10a3a6:	89 f8                	mov    %edi,%eax
  10a3a8:	83 c4 3c             	add    $0x3c,%esp
  10a3ab:	5b                   	pop    %ebx
  10a3ac:	5e                   	pop    %esi
  10a3ad:	5f                   	pop    %edi
  10a3ae:	5d                   	pop    %ebp
  10a3af:	c3                   	ret    
        KERN_PANIC("create: dir_link");
  10a3b0:	83 ec 04             	sub    $0x4,%esp
  10a3b3:	8d 83 38 8d ff ff    	lea    -0x72c8(%ebx),%eax
  10a3b9:	50                   	push   %eax
  10a3ba:	8d 83 17 8d ff ff    	lea    -0x72e9(%ebx),%eax
  10a3c0:	68 f7 00 00 00       	push   $0xf7
  10a3c5:	50                   	push   %eax
  10a3c6:	e8 45 a3 ff ff       	call   104710 <debug_panic>
  10a3cb:	83 c4 10             	add    $0x10,%esp
  10a3ce:	eb ca                	jmp    10a39a <create.constprop.0+0xfa>
}
  10a3d0:	83 c4 3c             	add    $0x3c,%esp
        return 0;
  10a3d3:	31 ff                	xor    %edi,%edi
}
  10a3d5:	5b                   	pop    %ebx
  10a3d6:	89 f8                	mov    %edi,%eax
  10a3d8:	5e                   	pop    %esi
  10a3d9:	5f                   	pop    %edi
  10a3da:	5d                   	pop    %ebp
  10a3db:	c3                   	ret    
  10a3dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        inode_update(dp);
  10a3e0:	83 ec 0c             	sub    $0xc,%esp
        dp->nlink++;      // for ".."
  10a3e3:	66 83 46 16 01       	addw   $0x1,0x16(%esi)
        inode_update(dp);
  10a3e8:	56                   	push   %esi
  10a3e9:	e8 52 f0 ff ff       	call   109440 <inode_update>
        if (dir_link(ip, ".", ip->inum) < 0
  10a3ee:	83 c4 0c             	add    $0xc,%esp
  10a3f1:	8d 83 36 8d ff ff    	lea    -0x72ca(%ebx),%eax
  10a3f7:	ff 77 04             	push   0x4(%edi)
  10a3fa:	50                   	push   %eax
  10a3fb:	57                   	push   %edi
  10a3fc:	e8 af f9 ff ff       	call   109db0 <dir_link>
  10a401:	83 c4 10             	add    $0x10,%esp
  10a404:	85 c0                	test   %eax,%eax
  10a406:	78 1e                	js     10a426 <create.constprop.0+0x186>
            || dir_link(ip, "..", dp->inum) < 0)
  10a408:	83 ec 04             	sub    $0x4,%esp
  10a40b:	8d 83 35 8d ff ff    	lea    -0x72cb(%ebx),%eax
  10a411:	ff 76 04             	push   0x4(%esi)
  10a414:	50                   	push   %eax
  10a415:	57                   	push   %edi
  10a416:	e8 95 f9 ff ff       	call   109db0 <dir_link>
  10a41b:	83 c4 10             	add    $0x10,%esp
  10a41e:	85 c0                	test   %eax,%eax
  10a420:	0f 89 60 ff ff ff    	jns    10a386 <create.constprop.0+0xe6>
            KERN_PANIC("create dots");
  10a426:	83 ec 04             	sub    $0x4,%esp
  10a429:	8d 83 29 8d ff ff    	lea    -0x72d7(%ebx),%eax
  10a42f:	50                   	push   %eax
  10a430:	8d 83 17 8d ff ff    	lea    -0x72e9(%ebx),%eax
  10a436:	68 f3 00 00 00       	push   $0xf3
  10a43b:	50                   	push   %eax
  10a43c:	e8 cf a2 ff ff       	call   104710 <debug_panic>
  10a441:	83 c4 10             	add    $0x10,%esp
  10a444:	e9 3d ff ff ff       	jmp    10a386 <create.constprop.0+0xe6>
  10a449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        KERN_PANIC("create: ialloc");
  10a450:	83 ec 04             	sub    $0x4,%esp
  10a453:	8d 83 08 8d ff ff    	lea    -0x72f8(%ebx),%eax
  10a459:	50                   	push   %eax
  10a45a:	8d 83 17 8d ff ff    	lea    -0x72e9(%ebx),%eax
  10a460:	68 e5 00 00 00       	push   $0xe5
  10a465:	50                   	push   %eax
  10a466:	e8 a5 a2 ff ff       	call   104710 <debug_panic>
  10a46b:	83 c4 10             	add    $0x10,%esp
  10a46e:	e9 ea fe ff ff       	jmp    10a35d <create.constprop.0+0xbd>
  10a473:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10a47a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

0010a480 <sys_read>:
}
  10a480:	c3                   	ret    
  10a481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10a488:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10a48f:	90                   	nop

0010a490 <sys_write>:
  10a490:	c3                   	ret    
  10a491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10a498:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10a49f:	90                   	nop

0010a4a0 <sys_close>:
  10a4a0:	c3                   	ret    
  10a4a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10a4a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10a4af:	90                   	nop

0010a4b0 <sys_fstat>:
  10a4b0:	c3                   	ret    
  10a4b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10a4b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10a4bf:	90                   	nop

0010a4c0 <sys_link>:
{
  10a4c0:	55                   	push   %ebp
  10a4c1:	57                   	push   %edi
  10a4c2:	56                   	push   %esi
  10a4c3:	53                   	push   %ebx
  10a4c4:	e8 c0 5e ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10a4c9:	81 c3 37 9b 00 00    	add    $0x9b37,%ebx
  10a4cf:	81 ec 28 01 00 00    	sub    $0x128,%esp
    pt_copyin(get_curid(), syscall_get_arg2(tf), old, 128);
  10a4d5:	ff b4 24 3c 01 00 00 	push   0x13c(%esp)
  10a4dc:	e8 2f d8 ff ff       	call   107d10 <syscall_get_arg2>
  10a4e1:	89 c6                	mov    %eax,%esi
  10a4e3:	e8 68 d4 ff ff       	call   107950 <get_curid>
  10a4e8:	68 80 00 00 00       	push   $0x80
  10a4ed:	8d bc 24 a4 00 00 00 	lea    0xa4(%esp),%edi
  10a4f4:	57                   	push   %edi
  10a4f5:	56                   	push   %esi
  10a4f6:	50                   	push   %eax
  10a4f7:	e8 84 b3 ff ff       	call   105880 <pt_copyin>
    pt_copyin(get_curid(), syscall_get_arg3(tf), new, 128);
  10a4fc:	83 c4 14             	add    $0x14,%esp
  10a4ff:	ff b4 24 3c 01 00 00 	push   0x13c(%esp)
  10a506:	e8 15 d8 ff ff       	call   107d20 <syscall_get_arg3>
  10a50b:	89 c6                	mov    %eax,%esi
  10a50d:	e8 3e d4 ff ff       	call   107950 <get_curid>
  10a512:	68 80 00 00 00       	push   $0x80
  10a517:	8d 6c 24 24          	lea    0x24(%esp),%ebp
  10a51b:	55                   	push   %ebp
  10a51c:	56                   	push   %esi
  10a51d:	50                   	push   %eax
  10a51e:	e8 5d b3 ff ff       	call   105880 <pt_copyin>
    if ((ip = namei(old)) == 0) {
  10a523:	83 c4 14             	add    $0x14,%esp
  10a526:	57                   	push   %edi
  10a527:	e8 94 f8 ff ff       	call   109dc0 <namei>
  10a52c:	83 c4 10             	add    $0x10,%esp
  10a52f:	85 c0                	test   %eax,%eax
  10a531:	0f 84 f9 00 00 00    	je     10a630 <sys_link+0x170>
  10a537:	89 c6                	mov    %eax,%esi
    begin_trans();
  10a539:	e8 12 e9 ff ff       	call   108e50 <begin_trans>
    inode_lock(ip);
  10a53e:	83 ec 0c             	sub    $0xc,%esp
  10a541:	56                   	push   %esi
  10a542:	e8 c9 f1 ff ff       	call   109710 <inode_lock>
    if (ip->type == T_DIR) {
  10a547:	83 c4 10             	add    $0x10,%esp
  10a54a:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  10a54f:	0f 84 fb 00 00 00    	je     10a650 <sys_link+0x190>
    inode_update(ip);
  10a555:	83 ec 0c             	sub    $0xc,%esp
    ip->nlink++;
  10a558:	66 83 46 16 01       	addw   $0x1,0x16(%esi)
    inode_update(ip);
  10a55d:	56                   	push   %esi
  10a55e:	e8 dd ee ff ff       	call   109440 <inode_update>
    inode_unlock(ip);
  10a563:	89 34 24             	mov    %esi,(%esp)
  10a566:	e8 d5 f2 ff ff       	call   109840 <inode_unlock>
    if ((dp = nameiparent(new, name)) == 0)
  10a56b:	5f                   	pop    %edi
  10a56c:	58                   	pop    %eax
  10a56d:	8d 44 24 0a          	lea    0xa(%esp),%eax
  10a571:	50                   	push   %eax
  10a572:	89 c7                	mov    %eax,%edi
  10a574:	55                   	push   %ebp
  10a575:	e8 a6 f8 ff ff       	call   109e20 <nameiparent>
  10a57a:	83 c4 10             	add    $0x10,%esp
  10a57d:	89 c5                	mov    %eax,%ebp
  10a57f:	85 c0                	test   %eax,%eax
  10a581:	74 69                	je     10a5ec <sys_link+0x12c>
    inode_lock(dp);
  10a583:	83 ec 0c             	sub    $0xc,%esp
  10a586:	50                   	push   %eax
  10a587:	e8 84 f1 ff ff       	call   109710 <inode_lock>
    if (dp->dev != ip->dev || dir_link(dp, name, ip->inum) < 0) {
  10a58c:	8b 06                	mov    (%esi),%eax
  10a58e:	83 c4 10             	add    $0x10,%esp
  10a591:	39 45 00             	cmp    %eax,0x0(%ebp)
  10a594:	75 4a                	jne    10a5e0 <sys_link+0x120>
  10a596:	83 ec 04             	sub    $0x4,%esp
  10a599:	ff 76 04             	push   0x4(%esi)
  10a59c:	57                   	push   %edi
  10a59d:	55                   	push   %ebp
  10a59e:	e8 0d f8 ff ff       	call   109db0 <dir_link>
  10a5a3:	83 c4 10             	add    $0x10,%esp
  10a5a6:	85 c0                	test   %eax,%eax
  10a5a8:	78 36                	js     10a5e0 <sys_link+0x120>
    inode_unlockput(dp);
  10a5aa:	83 ec 0c             	sub    $0xc,%esp
  10a5ad:	55                   	push   %ebp
  10a5ae:	e8 9d f4 ff ff       	call   109a50 <inode_unlockput>
    inode_put(ip);
  10a5b3:	89 34 24             	mov    %esi,(%esp)
  10a5b6:	e8 05 f3 ff ff       	call   1098c0 <inode_put>
    commit_trans();
  10a5bb:	e8 f0 e8 ff ff       	call   108eb0 <commit_trans>
    syscall_set_errno(tf, E_SUCC);
  10a5c0:	59                   	pop    %ecx
  10a5c1:	5e                   	pop    %esi
  10a5c2:	6a 00                	push   $0x0
  10a5c4:	ff b4 24 3c 01 00 00 	push   0x13c(%esp)
  10a5cb:	e8 90 d7 ff ff       	call   107d60 <syscall_set_errno>
    return;
  10a5d0:	83 c4 10             	add    $0x10,%esp
}
  10a5d3:	81 c4 1c 01 00 00    	add    $0x11c,%esp
  10a5d9:	5b                   	pop    %ebx
  10a5da:	5e                   	pop    %esi
  10a5db:	5f                   	pop    %edi
  10a5dc:	5d                   	pop    %ebp
  10a5dd:	c3                   	ret    
  10a5de:	66 90                	xchg   %ax,%ax
        inode_unlockput(dp);
  10a5e0:	83 ec 0c             	sub    $0xc,%esp
  10a5e3:	55                   	push   %ebp
  10a5e4:	e8 67 f4 ff ff       	call   109a50 <inode_unlockput>
        goto bad;
  10a5e9:	83 c4 10             	add    $0x10,%esp
    inode_lock(ip);
  10a5ec:	83 ec 0c             	sub    $0xc,%esp
  10a5ef:	56                   	push   %esi
  10a5f0:	e8 1b f1 ff ff       	call   109710 <inode_lock>
    ip->nlink--;
  10a5f5:	66 83 6e 16 01       	subw   $0x1,0x16(%esi)
    inode_update(ip);
  10a5fa:	89 34 24             	mov    %esi,(%esp)
  10a5fd:	e8 3e ee ff ff       	call   109440 <inode_update>
    inode_unlockput(ip);
  10a602:	89 34 24             	mov    %esi,(%esp)
  10a605:	e8 46 f4 ff ff       	call   109a50 <inode_unlockput>
    commit_trans();
  10a60a:	e8 a1 e8 ff ff       	call   108eb0 <commit_trans>
    syscall_set_errno(tf, E_DISK_OP);
  10a60f:	58                   	pop    %eax
  10a610:	5a                   	pop    %edx
  10a611:	6a 0d                	push   $0xd
  10a613:	ff b4 24 3c 01 00 00 	push   0x13c(%esp)
  10a61a:	e8 41 d7 ff ff       	call   107d60 <syscall_set_errno>
    return;
  10a61f:	83 c4 10             	add    $0x10,%esp
}
  10a622:	81 c4 1c 01 00 00    	add    $0x11c,%esp
  10a628:	5b                   	pop    %ebx
  10a629:	5e                   	pop    %esi
  10a62a:	5f                   	pop    %edi
  10a62b:	5d                   	pop    %ebp
  10a62c:	c3                   	ret    
  10a62d:	8d 76 00             	lea    0x0(%esi),%esi
        syscall_set_errno(tf, E_NEXIST);
  10a630:	83 ec 08             	sub    $0x8,%esp
  10a633:	6a 1a                	push   $0x1a
  10a635:	ff b4 24 3c 01 00 00 	push   0x13c(%esp)
  10a63c:	e8 1f d7 ff ff       	call   107d60 <syscall_set_errno>
        return;
  10a641:	83 c4 10             	add    $0x10,%esp
}
  10a644:	81 c4 1c 01 00 00    	add    $0x11c,%esp
  10a64a:	5b                   	pop    %ebx
  10a64b:	5e                   	pop    %esi
  10a64c:	5f                   	pop    %edi
  10a64d:	5d                   	pop    %ebp
  10a64e:	c3                   	ret    
  10a64f:	90                   	nop
        inode_unlockput(ip);
  10a650:	83 ec 0c             	sub    $0xc,%esp
  10a653:	56                   	push   %esi
  10a654:	eb af                	jmp    10a605 <sys_link+0x145>
  10a656:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10a65d:	8d 76 00             	lea    0x0(%esi),%esi

0010a660 <sys_unlink>:
{
  10a660:	55                   	push   %ebp
  10a661:	57                   	push   %edi
  10a662:	56                   	push   %esi
  10a663:	53                   	push   %ebx
  10a664:	e8 20 5d ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10a669:	81 c3 97 99 00 00    	add    $0x9997,%ebx
  10a66f:	81 ec d8 00 00 00    	sub    $0xd8,%esp
    pt_copyin(get_curid(), syscall_get_arg2(tf), path, 128);
  10a675:	ff b4 24 ec 00 00 00 	push   0xec(%esp)
  10a67c:	e8 8f d6 ff ff       	call   107d10 <syscall_get_arg2>
  10a681:	89 c6                	mov    %eax,%esi
  10a683:	e8 c8 d2 ff ff       	call   107950 <get_curid>
  10a688:	68 80 00 00 00       	push   $0x80
  10a68d:	8d 6c 24 54          	lea    0x54(%esp),%ebp
  10a691:	55                   	push   %ebp
  10a692:	56                   	push   %esi
  10a693:	50                   	push   %eax
  10a694:	e8 e7 b1 ff ff       	call   105880 <pt_copyin>
    if ((dp = nameiparent(path, name)) == 0) {
  10a699:	83 c4 18             	add    $0x18,%esp
  10a69c:	8d 7c 24 2a          	lea    0x2a(%esp),%edi
  10a6a0:	57                   	push   %edi
  10a6a1:	55                   	push   %ebp
  10a6a2:	e8 79 f7 ff ff       	call   109e20 <nameiparent>
  10a6a7:	83 c4 10             	add    $0x10,%esp
  10a6aa:	85 c0                	test   %eax,%eax
  10a6ac:	0f 84 3e 01 00 00    	je     10a7f0 <sys_unlink+0x190>
  10a6b2:	89 c6                	mov    %eax,%esi
    begin_trans();
  10a6b4:	e8 97 e7 ff ff       	call   108e50 <begin_trans>
    inode_lock(dp);
  10a6b9:	83 ec 0c             	sub    $0xc,%esp
  10a6bc:	56                   	push   %esi
  10a6bd:	e8 4e f0 ff ff       	call   109710 <inode_lock>
    if (dir_namecmp(name, ".") == 0 || dir_namecmp(name, "..") == 0)
  10a6c2:	5d                   	pop    %ebp
  10a6c3:	58                   	pop    %eax
  10a6c4:	8d 83 36 8d ff ff    	lea    -0x72ca(%ebx),%eax
  10a6ca:	50                   	push   %eax
  10a6cb:	57                   	push   %edi
  10a6cc:	e8 6f f6 ff ff       	call   109d40 <dir_namecmp>
  10a6d1:	83 c4 10             	add    $0x10,%esp
  10a6d4:	85 c0                	test   %eax,%eax
  10a6d6:	75 30                	jne    10a708 <sys_unlink+0xa8>
    inode_unlockput(dp);
  10a6d8:	83 ec 0c             	sub    $0xc,%esp
  10a6db:	56                   	push   %esi
  10a6dc:	e8 6f f3 ff ff       	call   109a50 <inode_unlockput>
    commit_trans();
  10a6e1:	e8 ca e7 ff ff       	call   108eb0 <commit_trans>
    syscall_set_errno(tf, E_DISK_OP);
  10a6e6:	58                   	pop    %eax
  10a6e7:	5a                   	pop    %edx
  10a6e8:	6a 0d                	push   $0xd
  10a6ea:	ff b4 24 ec 00 00 00 	push   0xec(%esp)
  10a6f1:	e8 6a d6 ff ff       	call   107d60 <syscall_set_errno>
    return;
  10a6f6:	83 c4 10             	add    $0x10,%esp
}
  10a6f9:	81 c4 cc 00 00 00    	add    $0xcc,%esp
  10a6ff:	5b                   	pop    %ebx
  10a700:	5e                   	pop    %esi
  10a701:	5f                   	pop    %edi
  10a702:	5d                   	pop    %ebp
  10a703:	c3                   	ret    
  10a704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (dir_namecmp(name, ".") == 0 || dir_namecmp(name, "..") == 0)
  10a708:	83 ec 08             	sub    $0x8,%esp
  10a70b:	8d 83 35 8d ff ff    	lea    -0x72cb(%ebx),%eax
  10a711:	50                   	push   %eax
  10a712:	57                   	push   %edi
  10a713:	e8 28 f6 ff ff       	call   109d40 <dir_namecmp>
  10a718:	83 c4 10             	add    $0x10,%esp
  10a71b:	85 c0                	test   %eax,%eax
  10a71d:	74 b9                	je     10a6d8 <sys_unlink+0x78>
    if ((ip = dir_lookup(dp, name, &off)) == 0)
  10a71f:	83 ec 04             	sub    $0x4,%esp
  10a722:	8d 44 24 20          	lea    0x20(%esp),%eax
  10a726:	50                   	push   %eax
  10a727:	57                   	push   %edi
  10a728:	56                   	push   %esi
  10a729:	e8 42 f6 ff ff       	call   109d70 <dir_lookup>
  10a72e:	83 c4 10             	add    $0x10,%esp
  10a731:	89 c7                	mov    %eax,%edi
  10a733:	85 c0                	test   %eax,%eax
  10a735:	74 a1                	je     10a6d8 <sys_unlink+0x78>
    inode_lock(ip);
  10a737:	83 ec 0c             	sub    $0xc,%esp
  10a73a:	50                   	push   %eax
  10a73b:	e8 d0 ef ff ff       	call   109710 <inode_lock>
    if (ip->nlink < 1)
  10a740:	83 c4 10             	add    $0x10,%esp
  10a743:	66 83 7f 16 00       	cmpw   $0x0,0x16(%edi)
  10a748:	0f 8e 4a 01 00 00    	jle    10a898 <sys_unlink+0x238>
    if (ip->type == T_DIR && !isdirempty(ip)) {
  10a74e:	8d 44 24 30          	lea    0x30(%esp),%eax
  10a752:	66 83 7f 10 01       	cmpw   $0x1,0x10(%edi)
  10a757:	89 04 24             	mov    %eax,(%esp)
  10a75a:	0f 84 b0 00 00 00    	je     10a810 <sys_unlink+0x1b0>
    memset(&de, 0, sizeof(de));
  10a760:	83 ec 04             	sub    $0x4,%esp
  10a763:	6a 10                	push   $0x10
  10a765:	6a 00                	push   $0x0
  10a767:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  10a76b:	55                   	push   %ebp
  10a76c:	e8 df 9b ff ff       	call   104350 <memset>
    if (inode_write(dp, (char *) &de, off, sizeof(de)) != sizeof(de))
  10a771:	6a 10                	push   $0x10
  10a773:	ff 74 24 30          	push   0x30(%esp)
  10a777:	55                   	push   %ebp
  10a778:	56                   	push   %esi
  10a779:	e8 62 f4 ff ff       	call   109be0 <inode_write>
  10a77e:	83 c4 20             	add    $0x20,%esp
  10a781:	83 f8 10             	cmp    $0x10,%eax
  10a784:	74 1e                	je     10a7a4 <sys_unlink+0x144>
        KERN_PANIC("unlink: writei");
  10a786:	83 ec 04             	sub    $0x4,%esp
  10a789:	8d 83 6d 8d ff ff    	lea    -0x7293(%ebx),%eax
  10a78f:	50                   	push   %eax
  10a790:	8d 83 17 8d ff ff    	lea    -0x72e9(%ebx),%eax
  10a796:	68 ba 00 00 00       	push   $0xba
  10a79b:	50                   	push   %eax
  10a79c:	e8 6f 9f ff ff       	call   104710 <debug_panic>
  10a7a1:	83 c4 10             	add    $0x10,%esp
    if (ip->type == T_DIR) {
  10a7a4:	66 83 7f 10 01       	cmpw   $0x1,0x10(%edi)
  10a7a9:	0f 84 11 01 00 00    	je     10a8c0 <sys_unlink+0x260>
    inode_unlockput(dp);
  10a7af:	83 ec 0c             	sub    $0xc,%esp
  10a7b2:	56                   	push   %esi
  10a7b3:	e8 98 f2 ff ff       	call   109a50 <inode_unlockput>
    ip->nlink--;
  10a7b8:	66 83 6f 16 01       	subw   $0x1,0x16(%edi)
    inode_update(ip);
  10a7bd:	89 3c 24             	mov    %edi,(%esp)
  10a7c0:	e8 7b ec ff ff       	call   109440 <inode_update>
    inode_unlockput(ip);
  10a7c5:	89 3c 24             	mov    %edi,(%esp)
  10a7c8:	e8 83 f2 ff ff       	call   109a50 <inode_unlockput>
    commit_trans();
  10a7cd:	e8 de e6 ff ff       	call   108eb0 <commit_trans>
    syscall_set_errno(tf, E_SUCC);
  10a7d2:	59                   	pop    %ecx
  10a7d3:	5e                   	pop    %esi
  10a7d4:	6a 00                	push   $0x0
  10a7d6:	ff b4 24 ec 00 00 00 	push   0xec(%esp)
  10a7dd:	e8 7e d5 ff ff       	call   107d60 <syscall_set_errno>
    return;
  10a7e2:	83 c4 10             	add    $0x10,%esp
}
  10a7e5:	81 c4 cc 00 00 00    	add    $0xcc,%esp
  10a7eb:	5b                   	pop    %ebx
  10a7ec:	5e                   	pop    %esi
  10a7ed:	5f                   	pop    %edi
  10a7ee:	5d                   	pop    %ebp
  10a7ef:	c3                   	ret    
        syscall_set_errno(tf, E_DISK_OP);
  10a7f0:	83 ec 08             	sub    $0x8,%esp
  10a7f3:	6a 0d                	push   $0xd
  10a7f5:	ff b4 24 ec 00 00 00 	push   0xec(%esp)
  10a7fc:	e8 5f d5 ff ff       	call   107d60 <syscall_set_errno>
        return;
  10a801:	83 c4 10             	add    $0x10,%esp
}
  10a804:	81 c4 cc 00 00 00    	add    $0xcc,%esp
  10a80a:	5b                   	pop    %ebx
  10a80b:	5e                   	pop    %esi
  10a80c:	5f                   	pop    %edi
  10a80d:	5d                   	pop    %ebp
  10a80e:	c3                   	ret    
  10a80f:	90                   	nop
    for (off = 2 * sizeof(de); off < dp->size; off += sizeof(de)) {
  10a810:	83 7f 18 20          	cmpl   $0x20,0x18(%edi)
  10a814:	0f 86 46 ff ff ff    	jbe    10a760 <sys_unlink+0x100>
            KERN_PANIC("isdirempty: readi");
  10a81a:	8d 83 5b 8d ff ff    	lea    -0x72a5(%ebx),%eax
  10a820:	89 74 24 0c          	mov    %esi,0xc(%esp)
    for (off = 2 * sizeof(de); off < dp->size; off += sizeof(de)) {
  10a824:	bd 20 00 00 00       	mov    $0x20,%ebp
            KERN_PANIC("isdirempty: readi");
  10a829:	8b 34 24             	mov    (%esp),%esi
  10a82c:	89 44 24 04          	mov    %eax,0x4(%esp)
  10a830:	8d 83 17 8d ff ff    	lea    -0x72e9(%ebx),%eax
  10a836:	89 44 24 08          	mov    %eax,0x8(%esp)
  10a83a:	eb 10                	jmp    10a84c <sys_unlink+0x1ec>
  10a83c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for (off = 2 * sizeof(de); off < dp->size; off += sizeof(de)) {
  10a840:	83 c5 10             	add    $0x10,%ebp
  10a843:	3b 6f 18             	cmp    0x18(%edi),%ebp
  10a846:	0f 83 94 00 00 00    	jae    10a8e0 <sys_unlink+0x280>
        if (inode_read(dp, (char *) &de, off, sizeof(de)) != sizeof(de))
  10a84c:	6a 10                	push   $0x10
  10a84e:	55                   	push   %ebp
  10a84f:	56                   	push   %esi
  10a850:	57                   	push   %edi
  10a851:	e8 4a f2 ff ff       	call   109aa0 <inode_read>
  10a856:	83 c4 10             	add    $0x10,%esp
  10a859:	83 f8 10             	cmp    $0x10,%eax
  10a85c:	74 18                	je     10a876 <sys_unlink+0x216>
            KERN_PANIC("isdirempty: readi");
  10a85e:	83 ec 04             	sub    $0x4,%esp
  10a861:	ff 74 24 08          	push   0x8(%esp)
  10a865:	68 90 00 00 00       	push   $0x90
  10a86a:	ff 74 24 14          	push   0x14(%esp)
  10a86e:	e8 9d 9e ff ff       	call   104710 <debug_panic>
  10a873:	83 c4 10             	add    $0x10,%esp
        if (de.inum != 0)
  10a876:	66 83 7c 24 30 00    	cmpw   $0x0,0x30(%esp)
  10a87c:	74 c2                	je     10a840 <sys_unlink+0x1e0>
        inode_unlockput(ip);
  10a87e:	8b 74 24 0c          	mov    0xc(%esp),%esi
  10a882:	83 ec 0c             	sub    $0xc,%esp
  10a885:	57                   	push   %edi
  10a886:	e8 c5 f1 ff ff       	call   109a50 <inode_unlockput>
        goto bad;
  10a88b:	83 c4 10             	add    $0x10,%esp
  10a88e:	e9 45 fe ff ff       	jmp    10a6d8 <sys_unlink+0x78>
  10a893:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10a897:	90                   	nop
        KERN_PANIC("unlink: nlink < 1");
  10a898:	83 ec 04             	sub    $0x4,%esp
  10a89b:	8d 83 49 8d ff ff    	lea    -0x72b7(%ebx),%eax
  10a8a1:	50                   	push   %eax
  10a8a2:	8d 83 17 8d ff ff    	lea    -0x72e9(%ebx),%eax
  10a8a8:	68 b2 00 00 00       	push   $0xb2
  10a8ad:	50                   	push   %eax
  10a8ae:	e8 5d 9e ff ff       	call   104710 <debug_panic>
  10a8b3:	83 c4 10             	add    $0x10,%esp
  10a8b6:	e9 93 fe ff ff       	jmp    10a74e <sys_unlink+0xee>
  10a8bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10a8bf:	90                   	nop
        inode_update(dp);
  10a8c0:	83 ec 0c             	sub    $0xc,%esp
        dp->nlink--;
  10a8c3:	66 83 6e 16 01       	subw   $0x1,0x16(%esi)
        inode_update(dp);
  10a8c8:	56                   	push   %esi
  10a8c9:	e8 72 eb ff ff       	call   109440 <inode_update>
  10a8ce:	83 c4 10             	add    $0x10,%esp
  10a8d1:	e9 d9 fe ff ff       	jmp    10a7af <sys_unlink+0x14f>
  10a8d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10a8dd:	8d 76 00             	lea    0x0(%esi),%esi
  10a8e0:	8b 74 24 0c          	mov    0xc(%esp),%esi
  10a8e4:	e9 77 fe ff ff       	jmp    10a760 <sys_unlink+0x100>
  10a8e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

0010a8f0 <sys_open>:

void sys_open(tf_t *tf)
{
  10a8f0:	55                   	push   %ebp
  10a8f1:	57                   	push   %edi
  10a8f2:	56                   	push   %esi
  10a8f3:	53                   	push   %ebx
  10a8f4:	e8 90 5a ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10a8f9:	81 c3 07 97 00 00    	add    $0x9707,%ebx
  10a8ff:	81 ec 8c 00 00 00    	sub    $0x8c,%esp
  10a905:	8b bc 24 a0 00 00 00 	mov    0xa0(%esp),%edi
    int fd, omode;
    struct file *f;
    struct inode *ip;

    static int first = TRUE;
    if (first) {
  10a90c:	8b 8b 30 03 00 00    	mov    0x330(%ebx),%ecx
  10a912:	85 c9                	test   %ecx,%ecx
  10a914:	0f 85 ce 00 00 00    	jne    10a9e8 <sys_open+0xf8>
        first = FALSE;
        log_init();
    }

    pt_copyin(get_curid(), syscall_get_arg2(tf), path, 128);
  10a91a:	83 ec 0c             	sub    $0xc,%esp
  10a91d:	57                   	push   %edi
  10a91e:	e8 ed d3 ff ff       	call   107d10 <syscall_get_arg2>
  10a923:	89 c5                	mov    %eax,%ebp
  10a925:	e8 26 d0 ff ff       	call   107950 <get_curid>
  10a92a:	68 80 00 00 00       	push   $0x80
  10a92f:	8d 74 24 14          	lea    0x14(%esp),%esi
  10a933:	56                   	push   %esi
  10a934:	55                   	push   %ebp
  10a935:	50                   	push   %eax
  10a936:	e8 45 af ff ff       	call   105880 <pt_copyin>
    omode = syscall_get_arg3(tf);
  10a93b:	83 c4 14             	add    $0x14,%esp
  10a93e:	57                   	push   %edi
  10a93f:	e8 dc d3 ff ff       	call   107d20 <syscall_get_arg3>

    if (omode & O_CREATE) {
  10a944:	89 f4                	mov    %esi,%esp
    omode = syscall_get_arg3(tf);
  10a946:	89 c5                	mov    %eax,%ebp
    if (omode & O_CREATE) {
  10a948:	f6 c4 02             	test   $0x2,%ah
  10a94b:	74 63                	je     10a9b0 <sys_open+0xc0>
        begin_trans();
  10a94d:	e8 fe e4 ff ff       	call   108e50 <begin_trans>
        ip = create(path, T_FILE, 0, 0);
  10a952:	89 f0                	mov    %esi,%eax
  10a954:	ba 02 00 00 00       	mov    $0x2,%edx
  10a959:	e8 42 f9 ff ff       	call   10a2a0 <create.constprop.0>
  10a95e:	89 c6                	mov    %eax,%esi
        commit_trans();
  10a960:	e8 4b e5 ff ff       	call   108eb0 <commit_trans>
        if (ip == 0) {
  10a965:	85 f6                	test   %esi,%esi
  10a967:	0f 84 b3 00 00 00    	je     10aa20 <sys_open+0x130>
            syscall_set_errno(tf, E_DISK_OP);
            return;
        }
    }

    if ((f = file_alloc()) == 0 || (fd = fdalloc(f)) < 0) {
  10a96d:	e8 3e f5 ff ff       	call   109eb0 <file_alloc>
        if (f)
  10a972:	85 c0                	test   %eax,%eax
  10a974:	74 0c                	je     10a982 <sys_open+0x92>
            file_close(f);
  10a976:	83 ec 0c             	sub    $0xc,%esp
  10a979:	50                   	push   %eax
  10a97a:	e8 21 f6 ff ff       	call   109fa0 <file_close>
  10a97f:	83 c4 10             	add    $0x10,%esp
        inode_unlockput(ip);
  10a982:	83 ec 0c             	sub    $0xc,%esp
  10a985:	56                   	push   %esi
  10a986:	e8 c5 f0 ff ff       	call   109a50 <inode_unlockput>
        syscall_set_retval1(tf, -1);
  10a98b:	58                   	pop    %eax
  10a98c:	5a                   	pop    %edx
  10a98d:	6a ff                	push   $0xffffffff
  10a98f:	57                   	push   %edi
  10a990:	e8 db d3 ff ff       	call   107d70 <syscall_set_retval1>
        syscall_set_errno(tf, E_DISK_OP);
  10a995:	59                   	pop    %ecx
  10a996:	5e                   	pop    %esi
  10a997:	6a 0d                	push   $0xd
  10a999:	57                   	push   %edi
  10a99a:	e8 c1 d3 ff ff       	call   107d60 <syscall_set_errno>
        return;
  10a99f:	83 c4 10             	add    $0x10,%esp
    f->off = 0;
    f->readable = !(omode & O_WRONLY);
    f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    syscall_set_retval1(tf, fd);
    syscall_set_errno(tf, E_SUCC);
}
  10a9a2:	81 c4 8c 00 00 00    	add    $0x8c,%esp
  10a9a8:	5b                   	pop    %ebx
  10a9a9:	5e                   	pop    %esi
  10a9aa:	5f                   	pop    %edi
  10a9ab:	5d                   	pop    %ebp
  10a9ac:	c3                   	ret    
  10a9ad:	8d 76 00             	lea    0x0(%esi),%esi
        if ((ip = namei(path)) == 0) {
  10a9b0:	83 ec 0c             	sub    $0xc,%esp
  10a9b3:	56                   	push   %esi
  10a9b4:	e8 07 f4 ff ff       	call   109dc0 <namei>
  10a9b9:	83 c4 10             	add    $0x10,%esp
  10a9bc:	89 c6                	mov    %eax,%esi
  10a9be:	85 c0                	test   %eax,%eax
  10a9c0:	74 3e                	je     10aa00 <sys_open+0x110>
        inode_lock(ip);
  10a9c2:	83 ec 0c             	sub    $0xc,%esp
  10a9c5:	50                   	push   %eax
  10a9c6:	e8 45 ed ff ff       	call   109710 <inode_lock>
        if (ip->type == T_DIR && omode != O_RDONLY) {
  10a9cb:	83 c4 10             	add    $0x10,%esp
  10a9ce:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  10a9d3:	75 98                	jne    10a96d <sys_open+0x7d>
  10a9d5:	85 ed                	test   %ebp,%ebp
  10a9d7:	75 a9                	jne    10a982 <sys_open+0x92>
    if ((f = file_alloc()) == 0 || (fd = fdalloc(f)) < 0) {
  10a9d9:	e8 d2 f4 ff ff       	call   109eb0 <file_alloc>
        if (f)
  10a9de:	85 c0                	test   %eax,%eax
  10a9e0:	75 94                	jne    10a976 <sys_open+0x86>
  10a9e2:	eb 9e                	jmp    10a982 <sys_open+0x92>
  10a9e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        first = FALSE;
  10a9e8:	c7 83 30 03 00 00 00 	movl   $0x0,0x330(%ebx)
  10a9ef:	00 00 00 
        log_init();
  10a9f2:	e8 a9 e3 ff ff       	call   108da0 <log_init>
  10a9f7:	e9 1e ff ff ff       	jmp    10a91a <sys_open+0x2a>
  10a9fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            syscall_set_retval1(tf, -1);
  10aa00:	83 ec 08             	sub    $0x8,%esp
  10aa03:	6a ff                	push   $0xffffffff
  10aa05:	57                   	push   %edi
  10aa06:	e8 65 d3 ff ff       	call   107d70 <syscall_set_retval1>
            syscall_set_errno(tf, E_NEXIST);
  10aa0b:	5d                   	pop    %ebp
  10aa0c:	58                   	pop    %eax
  10aa0d:	6a 1a                	push   $0x1a
  10aa0f:	57                   	push   %edi
  10aa10:	e8 4b d3 ff ff       	call   107d60 <syscall_set_errno>
            return;
  10aa15:	83 c4 10             	add    $0x10,%esp
  10aa18:	eb 88                	jmp    10a9a2 <sys_open+0xb2>
  10aa1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            syscall_set_retval1(tf, -1);
  10aa20:	83 ec 08             	sub    $0x8,%esp
  10aa23:	6a ff                	push   $0xffffffff
  10aa25:	57                   	push   %edi
  10aa26:	e8 45 d3 ff ff       	call   107d70 <syscall_set_retval1>
            syscall_set_errno(tf, E_CREATE);
  10aa2b:	58                   	pop    %eax
  10aa2c:	5a                   	pop    %edx
  10aa2d:	6a 1b                	push   $0x1b
  10aa2f:	57                   	push   %edi
  10aa30:	e8 2b d3 ff ff       	call   107d60 <syscall_set_errno>
            return;
  10aa35:	83 c4 10             	add    $0x10,%esp
  10aa38:	e9 65 ff ff ff       	jmp    10a9a2 <sys_open+0xb2>
  10aa3d:	8d 76 00             	lea    0x0(%esi),%esi

0010aa40 <sys_mkdir>:

void sys_mkdir(tf_t *tf)
{
  10aa40:	55                   	push   %ebp
  10aa41:	57                   	push   %edi
  10aa42:	56                   	push   %esi
  10aa43:	53                   	push   %ebx
  10aa44:	e8 40 59 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10aa49:	81 c3 b7 95 00 00    	add    $0x95b7,%ebx
  10aa4f:	81 ec 98 00 00 00    	sub    $0x98,%esp
  10aa55:	8b b4 24 ac 00 00 00 	mov    0xac(%esp),%esi
    char path[128];
    struct inode *ip;

    pt_copyin(get_curid(), syscall_get_arg2(tf), path, 128);
  10aa5c:	56                   	push   %esi
  10aa5d:	e8 ae d2 ff ff       	call   107d10 <syscall_get_arg2>
  10aa62:	89 c7                	mov    %eax,%edi
  10aa64:	e8 e7 ce ff ff       	call   107950 <get_curid>
  10aa69:	68 80 00 00 00       	push   $0x80
  10aa6e:	8d 6c 24 14          	lea    0x14(%esp),%ebp
  10aa72:	55                   	push   %ebp
  10aa73:	57                   	push   %edi
  10aa74:	50                   	push   %eax
  10aa75:	e8 06 ae ff ff       	call   105880 <pt_copyin>

    begin_trans();
  10aa7a:	89 ec                	mov    %ebp,%esp
  10aa7c:	e8 cf e3 ff ff       	call   108e50 <begin_trans>
    if ((ip = (struct inode *) create(path, T_DIR, 0, 0)) == 0) {
  10aa81:	ba 01 00 00 00       	mov    $0x1,%edx
  10aa86:	89 e8                	mov    %ebp,%eax
  10aa88:	e8 13 f8 ff ff       	call   10a2a0 <create.constprop.0>
  10aa8d:	85 c0                	test   %eax,%eax
  10aa8f:	74 2f                	je     10aac0 <sys_mkdir+0x80>
        commit_trans();
        syscall_set_errno(tf, E_DISK_OP);
        return;
    }
    inode_unlockput(ip);
  10aa91:	83 ec 0c             	sub    $0xc,%esp
  10aa94:	50                   	push   %eax
  10aa95:	e8 b6 ef ff ff       	call   109a50 <inode_unlockput>
    commit_trans();
  10aa9a:	e8 11 e4 ff ff       	call   108eb0 <commit_trans>
    syscall_set_errno(tf, E_SUCC);
  10aa9f:	58                   	pop    %eax
  10aaa0:	5a                   	pop    %edx
  10aaa1:	6a 00                	push   $0x0
  10aaa3:	56                   	push   %esi
  10aaa4:	e8 b7 d2 ff ff       	call   107d60 <syscall_set_errno>
  10aaa9:	83 c4 10             	add    $0x10,%esp
}
  10aaac:	81 c4 8c 00 00 00    	add    $0x8c,%esp
  10aab2:	5b                   	pop    %ebx
  10aab3:	5e                   	pop    %esi
  10aab4:	5f                   	pop    %edi
  10aab5:	5d                   	pop    %ebp
  10aab6:	c3                   	ret    
  10aab7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10aabe:	66 90                	xchg   %ax,%ax
        commit_trans();
  10aac0:	e8 eb e3 ff ff       	call   108eb0 <commit_trans>
        syscall_set_errno(tf, E_DISK_OP);
  10aac5:	83 ec 08             	sub    $0x8,%esp
  10aac8:	6a 0d                	push   $0xd
  10aaca:	56                   	push   %esi
  10aacb:	e8 90 d2 ff ff       	call   107d60 <syscall_set_errno>
  10aad0:	89 ec                	mov    %ebp,%esp
}
  10aad2:	81 c4 8c 00 00 00    	add    $0x8c,%esp
  10aad8:	5b                   	pop    %ebx
  10aad9:	5e                   	pop    %esi
  10aada:	5f                   	pop    %edi
  10aadb:	5d                   	pop    %ebp
  10aadc:	c3                   	ret    
  10aadd:	8d 76 00             	lea    0x0(%esi),%esi

0010aae0 <sys_chdir>:

void sys_chdir(tf_t *tf)
{
  10aae0:	55                   	push   %ebp
  10aae1:	57                   	push   %edi
  10aae2:	56                   	push   %esi
  10aae3:	53                   	push   %ebx
  10aae4:	e8 a0 58 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10aae9:	81 c3 17 95 00 00    	add    $0x9517,%ebx
  10aaef:	81 ec 8c 00 00 00    	sub    $0x8c,%esp
    char path[128];
    struct inode *ip;
    int pid = get_curid();
  10aaf5:	e8 56 ce ff ff       	call   107950 <get_curid>

    pt_copyin(get_curid(), syscall_get_arg2(tf), path, 128);
  10aafa:	83 ec 0c             	sub    $0xc,%esp
  10aafd:	ff b4 24 ac 00 00 00 	push   0xac(%esp)
    int pid = get_curid();
  10ab04:	89 c6                	mov    %eax,%esi
    pt_copyin(get_curid(), syscall_get_arg2(tf), path, 128);
  10ab06:	e8 05 d2 ff ff       	call   107d10 <syscall_get_arg2>
  10ab0b:	89 c5                	mov    %eax,%ebp
  10ab0d:	e8 3e ce ff ff       	call   107950 <get_curid>
  10ab12:	68 80 00 00 00       	push   $0x80
  10ab17:	8d 7c 24 14          	lea    0x14(%esp),%edi
  10ab1b:	57                   	push   %edi
  10ab1c:	55                   	push   %ebp
  10ab1d:	50                   	push   %eax
  10ab1e:	e8 5d ad ff ff       	call   105880 <pt_copyin>

    if ((ip = namei(path)) == 0) {
  10ab23:	83 c4 14             	add    $0x14,%esp
  10ab26:	57                   	push   %edi
  10ab27:	e8 94 f2 ff ff       	call   109dc0 <namei>
  10ab2c:	89 fc                	mov    %edi,%esp
  10ab2e:	85 c0                	test   %eax,%eax
  10ab30:	0f 84 8a 00 00 00    	je     10abc0 <sys_chdir+0xe0>
        syscall_set_errno(tf, E_DISK_OP);
        return;
    }
    inode_lock(ip);
  10ab36:	83 ec 0c             	sub    $0xc,%esp
  10ab39:	89 c5                	mov    %eax,%ebp
  10ab3b:	50                   	push   %eax
  10ab3c:	e8 cf eb ff ff       	call   109710 <inode_lock>
    if (ip->type != T_DIR) {
  10ab41:	83 c4 10             	add    $0x10,%esp
  10ab44:	66 83 7d 10 01       	cmpw   $0x1,0x10(%ebp)
  10ab49:	75 45                	jne    10ab90 <sys_chdir+0xb0>
        inode_unlockput(ip);
        syscall_set_errno(tf, E_DISK_OP);
        return;
    }
    inode_unlock(ip);
  10ab4b:	83 ec 0c             	sub    $0xc,%esp
  10ab4e:	55                   	push   %ebp
  10ab4f:	e8 ec ec ff ff       	call   109840 <inode_unlock>
    inode_put(tcb_get_cwd(pid));
  10ab54:	89 34 24             	mov    %esi,(%esp)
  10ab57:	e8 74 ca ff ff       	call   1075d0 <tcb_get_cwd>
  10ab5c:	89 04 24             	mov    %eax,(%esp)
  10ab5f:	e8 5c ed ff ff       	call   1098c0 <inode_put>
    tcb_set_cwd(pid, ip);
  10ab64:	58                   	pop    %eax
  10ab65:	5a                   	pop    %edx
  10ab66:	55                   	push   %ebp
  10ab67:	56                   	push   %esi
  10ab68:	e8 83 ca ff ff       	call   1075f0 <tcb_set_cwd>
    syscall_set_errno(tf, E_SUCC);
  10ab6d:	59                   	pop    %ecx
  10ab6e:	5e                   	pop    %esi
  10ab6f:	6a 00                	push   $0x0
  10ab71:	ff b4 24 ac 00 00 00 	push   0xac(%esp)
  10ab78:	e8 e3 d1 ff ff       	call   107d60 <syscall_set_errno>
  10ab7d:	83 c4 10             	add    $0x10,%esp
}
  10ab80:	81 c4 8c 00 00 00    	add    $0x8c,%esp
  10ab86:	5b                   	pop    %ebx
  10ab87:	5e                   	pop    %esi
  10ab88:	5f                   	pop    %edi
  10ab89:	5d                   	pop    %ebp
  10ab8a:	c3                   	ret    
  10ab8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10ab8f:	90                   	nop
        inode_unlockput(ip);
  10ab90:	83 ec 0c             	sub    $0xc,%esp
  10ab93:	55                   	push   %ebp
  10ab94:	e8 b7 ee ff ff       	call   109a50 <inode_unlockput>
        syscall_set_errno(tf, E_DISK_OP);
  10ab99:	5f                   	pop    %edi
  10ab9a:	5d                   	pop    %ebp
  10ab9b:	6a 0d                	push   $0xd
  10ab9d:	ff b4 24 ac 00 00 00 	push   0xac(%esp)
  10aba4:	e8 b7 d1 ff ff       	call   107d60 <syscall_set_errno>
        return;
  10aba9:	83 c4 10             	add    $0x10,%esp
}
  10abac:	81 c4 8c 00 00 00    	add    $0x8c,%esp
  10abb2:	5b                   	pop    %ebx
  10abb3:	5e                   	pop    %esi
  10abb4:	5f                   	pop    %edi
  10abb5:	5d                   	pop    %ebp
  10abb6:	c3                   	ret    
  10abb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10abbe:	66 90                	xchg   %ax,%ax
        syscall_set_errno(tf, E_DISK_OP);
  10abc0:	83 ec 08             	sub    $0x8,%esp
  10abc3:	6a 0d                	push   $0xd
  10abc5:	ff b4 24 ac 00 00 00 	push   0xac(%esp)
  10abcc:	e8 8f d1 ff ff       	call   107d60 <syscall_set_errno>
        return;
  10abd1:	89 fc                	mov    %edi,%esp
}
  10abd3:	81 c4 8c 00 00 00    	add    $0x8c,%esp
  10abd9:	5b                   	pop    %ebx
  10abda:	5e                   	pop    %esi
  10abdb:	5f                   	pop    %edi
  10abdc:	5d                   	pop    %ebp
  10abdd:	c3                   	ret    
  10abde:	66 90                	xchg   %ax,%ax

0010abe0 <__udivdi3>:
  10abe0:	f3 0f 1e fb          	endbr32 
  10abe4:	55                   	push   %ebp
  10abe5:	57                   	push   %edi
  10abe6:	56                   	push   %esi
  10abe7:	53                   	push   %ebx
  10abe8:	83 ec 1c             	sub    $0x1c,%esp
  10abeb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  10abef:	8b 6c 24 30          	mov    0x30(%esp),%ebp
  10abf3:	8b 74 24 34          	mov    0x34(%esp),%esi
  10abf7:	8b 5c 24 38          	mov    0x38(%esp),%ebx
  10abfb:	85 c0                	test   %eax,%eax
  10abfd:	75 19                	jne    10ac18 <__udivdi3+0x38>
  10abff:	39 f3                	cmp    %esi,%ebx
  10ac01:	76 4d                	jbe    10ac50 <__udivdi3+0x70>
  10ac03:	31 ff                	xor    %edi,%edi
  10ac05:	89 e8                	mov    %ebp,%eax
  10ac07:	89 f2                	mov    %esi,%edx
  10ac09:	f7 f3                	div    %ebx
  10ac0b:	89 fa                	mov    %edi,%edx
  10ac0d:	83 c4 1c             	add    $0x1c,%esp
  10ac10:	5b                   	pop    %ebx
  10ac11:	5e                   	pop    %esi
  10ac12:	5f                   	pop    %edi
  10ac13:	5d                   	pop    %ebp
  10ac14:	c3                   	ret    
  10ac15:	8d 76 00             	lea    0x0(%esi),%esi
  10ac18:	39 f0                	cmp    %esi,%eax
  10ac1a:	76 14                	jbe    10ac30 <__udivdi3+0x50>
  10ac1c:	31 ff                	xor    %edi,%edi
  10ac1e:	31 c0                	xor    %eax,%eax
  10ac20:	89 fa                	mov    %edi,%edx
  10ac22:	83 c4 1c             	add    $0x1c,%esp
  10ac25:	5b                   	pop    %ebx
  10ac26:	5e                   	pop    %esi
  10ac27:	5f                   	pop    %edi
  10ac28:	5d                   	pop    %ebp
  10ac29:	c3                   	ret    
  10ac2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10ac30:	0f bd f8             	bsr    %eax,%edi
  10ac33:	83 f7 1f             	xor    $0x1f,%edi
  10ac36:	75 48                	jne    10ac80 <__udivdi3+0xa0>
  10ac38:	39 f0                	cmp    %esi,%eax
  10ac3a:	72 06                	jb     10ac42 <__udivdi3+0x62>
  10ac3c:	31 c0                	xor    %eax,%eax
  10ac3e:	39 eb                	cmp    %ebp,%ebx
  10ac40:	77 de                	ja     10ac20 <__udivdi3+0x40>
  10ac42:	b8 01 00 00 00       	mov    $0x1,%eax
  10ac47:	eb d7                	jmp    10ac20 <__udivdi3+0x40>
  10ac49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10ac50:	89 d9                	mov    %ebx,%ecx
  10ac52:	85 db                	test   %ebx,%ebx
  10ac54:	75 0b                	jne    10ac61 <__udivdi3+0x81>
  10ac56:	b8 01 00 00 00       	mov    $0x1,%eax
  10ac5b:	31 d2                	xor    %edx,%edx
  10ac5d:	f7 f3                	div    %ebx
  10ac5f:	89 c1                	mov    %eax,%ecx
  10ac61:	31 d2                	xor    %edx,%edx
  10ac63:	89 f0                	mov    %esi,%eax
  10ac65:	f7 f1                	div    %ecx
  10ac67:	89 c6                	mov    %eax,%esi
  10ac69:	89 e8                	mov    %ebp,%eax
  10ac6b:	89 f7                	mov    %esi,%edi
  10ac6d:	f7 f1                	div    %ecx
  10ac6f:	89 fa                	mov    %edi,%edx
  10ac71:	83 c4 1c             	add    $0x1c,%esp
  10ac74:	5b                   	pop    %ebx
  10ac75:	5e                   	pop    %esi
  10ac76:	5f                   	pop    %edi
  10ac77:	5d                   	pop    %ebp
  10ac78:	c3                   	ret    
  10ac79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10ac80:	89 f9                	mov    %edi,%ecx
  10ac82:	ba 20 00 00 00       	mov    $0x20,%edx
  10ac87:	29 fa                	sub    %edi,%edx
  10ac89:	d3 e0                	shl    %cl,%eax
  10ac8b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10ac8f:	89 d1                	mov    %edx,%ecx
  10ac91:	89 d8                	mov    %ebx,%eax
  10ac93:	d3 e8                	shr    %cl,%eax
  10ac95:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  10ac99:	09 c1                	or     %eax,%ecx
  10ac9b:	89 f0                	mov    %esi,%eax
  10ac9d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  10aca1:	89 f9                	mov    %edi,%ecx
  10aca3:	d3 e3                	shl    %cl,%ebx
  10aca5:	89 d1                	mov    %edx,%ecx
  10aca7:	d3 e8                	shr    %cl,%eax
  10aca9:	89 f9                	mov    %edi,%ecx
  10acab:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  10acaf:	89 eb                	mov    %ebp,%ebx
  10acb1:	d3 e6                	shl    %cl,%esi
  10acb3:	89 d1                	mov    %edx,%ecx
  10acb5:	d3 eb                	shr    %cl,%ebx
  10acb7:	09 f3                	or     %esi,%ebx
  10acb9:	89 c6                	mov    %eax,%esi
  10acbb:	89 f2                	mov    %esi,%edx
  10acbd:	89 d8                	mov    %ebx,%eax
  10acbf:	f7 74 24 08          	divl   0x8(%esp)
  10acc3:	89 d6                	mov    %edx,%esi
  10acc5:	89 c3                	mov    %eax,%ebx
  10acc7:	f7 64 24 0c          	mull   0xc(%esp)
  10accb:	39 d6                	cmp    %edx,%esi
  10accd:	72 19                	jb     10ace8 <__udivdi3+0x108>
  10accf:	89 f9                	mov    %edi,%ecx
  10acd1:	d3 e5                	shl    %cl,%ebp
  10acd3:	39 c5                	cmp    %eax,%ebp
  10acd5:	73 04                	jae    10acdb <__udivdi3+0xfb>
  10acd7:	39 d6                	cmp    %edx,%esi
  10acd9:	74 0d                	je     10ace8 <__udivdi3+0x108>
  10acdb:	89 d8                	mov    %ebx,%eax
  10acdd:	31 ff                	xor    %edi,%edi
  10acdf:	e9 3c ff ff ff       	jmp    10ac20 <__udivdi3+0x40>
  10ace4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10ace8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  10aceb:	31 ff                	xor    %edi,%edi
  10aced:	e9 2e ff ff ff       	jmp    10ac20 <__udivdi3+0x40>
  10acf2:	66 90                	xchg   %ax,%ax
  10acf4:	66 90                	xchg   %ax,%ax
  10acf6:	66 90                	xchg   %ax,%ax
  10acf8:	66 90                	xchg   %ax,%ax
  10acfa:	66 90                	xchg   %ax,%ax
  10acfc:	66 90                	xchg   %ax,%ax
  10acfe:	66 90                	xchg   %ax,%ax

0010ad00 <__umoddi3>:
  10ad00:	f3 0f 1e fb          	endbr32 
  10ad04:	55                   	push   %ebp
  10ad05:	57                   	push   %edi
  10ad06:	56                   	push   %esi
  10ad07:	53                   	push   %ebx
  10ad08:	83 ec 1c             	sub    $0x1c,%esp
  10ad0b:	8b 74 24 30          	mov    0x30(%esp),%esi
  10ad0f:	8b 5c 24 34          	mov    0x34(%esp),%ebx
  10ad13:	8b 7c 24 3c          	mov    0x3c(%esp),%edi
  10ad17:	8b 6c 24 38          	mov    0x38(%esp),%ebp
  10ad1b:	89 f0                	mov    %esi,%eax
  10ad1d:	89 da                	mov    %ebx,%edx
  10ad1f:	85 ff                	test   %edi,%edi
  10ad21:	75 15                	jne    10ad38 <__umoddi3+0x38>
  10ad23:	39 dd                	cmp    %ebx,%ebp
  10ad25:	76 39                	jbe    10ad60 <__umoddi3+0x60>
  10ad27:	f7 f5                	div    %ebp
  10ad29:	89 d0                	mov    %edx,%eax
  10ad2b:	31 d2                	xor    %edx,%edx
  10ad2d:	83 c4 1c             	add    $0x1c,%esp
  10ad30:	5b                   	pop    %ebx
  10ad31:	5e                   	pop    %esi
  10ad32:	5f                   	pop    %edi
  10ad33:	5d                   	pop    %ebp
  10ad34:	c3                   	ret    
  10ad35:	8d 76 00             	lea    0x0(%esi),%esi
  10ad38:	39 df                	cmp    %ebx,%edi
  10ad3a:	77 f1                	ja     10ad2d <__umoddi3+0x2d>
  10ad3c:	0f bd cf             	bsr    %edi,%ecx
  10ad3f:	83 f1 1f             	xor    $0x1f,%ecx
  10ad42:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  10ad46:	75 40                	jne    10ad88 <__umoddi3+0x88>
  10ad48:	39 df                	cmp    %ebx,%edi
  10ad4a:	72 04                	jb     10ad50 <__umoddi3+0x50>
  10ad4c:	39 f5                	cmp    %esi,%ebp
  10ad4e:	77 dd                	ja     10ad2d <__umoddi3+0x2d>
  10ad50:	89 da                	mov    %ebx,%edx
  10ad52:	89 f0                	mov    %esi,%eax
  10ad54:	29 e8                	sub    %ebp,%eax
  10ad56:	19 fa                	sbb    %edi,%edx
  10ad58:	eb d3                	jmp    10ad2d <__umoddi3+0x2d>
  10ad5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10ad60:	89 e9                	mov    %ebp,%ecx
  10ad62:	85 ed                	test   %ebp,%ebp
  10ad64:	75 0b                	jne    10ad71 <__umoddi3+0x71>
  10ad66:	b8 01 00 00 00       	mov    $0x1,%eax
  10ad6b:	31 d2                	xor    %edx,%edx
  10ad6d:	f7 f5                	div    %ebp
  10ad6f:	89 c1                	mov    %eax,%ecx
  10ad71:	89 d8                	mov    %ebx,%eax
  10ad73:	31 d2                	xor    %edx,%edx
  10ad75:	f7 f1                	div    %ecx
  10ad77:	89 f0                	mov    %esi,%eax
  10ad79:	f7 f1                	div    %ecx
  10ad7b:	89 d0                	mov    %edx,%eax
  10ad7d:	31 d2                	xor    %edx,%edx
  10ad7f:	eb ac                	jmp    10ad2d <__umoddi3+0x2d>
  10ad81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10ad88:	8b 44 24 04          	mov    0x4(%esp),%eax
  10ad8c:	ba 20 00 00 00       	mov    $0x20,%edx
  10ad91:	29 c2                	sub    %eax,%edx
  10ad93:	89 c1                	mov    %eax,%ecx
  10ad95:	89 e8                	mov    %ebp,%eax
  10ad97:	d3 e7                	shl    %cl,%edi
  10ad99:	89 d1                	mov    %edx,%ecx
  10ad9b:	89 54 24 0c          	mov    %edx,0xc(%esp)
  10ad9f:	d3 e8                	shr    %cl,%eax
  10ada1:	89 c1                	mov    %eax,%ecx
  10ada3:	8b 44 24 04          	mov    0x4(%esp),%eax
  10ada7:	09 f9                	or     %edi,%ecx
  10ada9:	89 df                	mov    %ebx,%edi
  10adab:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  10adaf:	89 c1                	mov    %eax,%ecx
  10adb1:	d3 e5                	shl    %cl,%ebp
  10adb3:	89 d1                	mov    %edx,%ecx
  10adb5:	d3 ef                	shr    %cl,%edi
  10adb7:	89 c1                	mov    %eax,%ecx
  10adb9:	89 f0                	mov    %esi,%eax
  10adbb:	d3 e3                	shl    %cl,%ebx
  10adbd:	89 d1                	mov    %edx,%ecx
  10adbf:	89 fa                	mov    %edi,%edx
  10adc1:	d3 e8                	shr    %cl,%eax
  10adc3:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
  10adc8:	09 d8                	or     %ebx,%eax
  10adca:	f7 74 24 08          	divl   0x8(%esp)
  10adce:	89 d3                	mov    %edx,%ebx
  10add0:	d3 e6                	shl    %cl,%esi
  10add2:	f7 e5                	mul    %ebp
  10add4:	89 c7                	mov    %eax,%edi
  10add6:	89 d1                	mov    %edx,%ecx
  10add8:	39 d3                	cmp    %edx,%ebx
  10adda:	72 06                	jb     10ade2 <__umoddi3+0xe2>
  10addc:	75 0e                	jne    10adec <__umoddi3+0xec>
  10adde:	39 c6                	cmp    %eax,%esi
  10ade0:	73 0a                	jae    10adec <__umoddi3+0xec>
  10ade2:	29 e8                	sub    %ebp,%eax
  10ade4:	1b 54 24 08          	sbb    0x8(%esp),%edx
  10ade8:	89 d1                	mov    %edx,%ecx
  10adea:	89 c7                	mov    %eax,%edi
  10adec:	89 f5                	mov    %esi,%ebp
  10adee:	8b 74 24 04          	mov    0x4(%esp),%esi
  10adf2:	29 fd                	sub    %edi,%ebp
  10adf4:	19 cb                	sbb    %ecx,%ebx
  10adf6:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
  10adfb:	89 d8                	mov    %ebx,%eax
  10adfd:	d3 e0                	shl    %cl,%eax
  10adff:	89 f1                	mov    %esi,%ecx
  10ae01:	d3 ed                	shr    %cl,%ebp
  10ae03:	d3 eb                	shr    %cl,%ebx
  10ae05:	09 e8                	or     %ebp,%eax
  10ae07:	89 da                	mov    %ebx,%edx
  10ae09:	83 c4 1c             	add    $0x1c,%esp
  10ae0c:	5b                   	pop    %ebx
  10ae0d:	5e                   	pop    %esi
  10ae0e:	5f                   	pop    %edi
  10ae0f:	5d                   	pop    %ebp
  10ae10:	c3                   	ret    
