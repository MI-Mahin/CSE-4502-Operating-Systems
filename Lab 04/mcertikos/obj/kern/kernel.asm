
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
  10000b:	89 bd 78 76 02 00    	mov    %edi,0x27678(%ebp)
  100011:	80 7c 24 04 00       	cmpb   $0x0,0x4(%esp)
  100016:	74 0a                	je     100022 <pmmap_init.cold+0x22>
  100018:	c7 85 7c 76 02 00 80 	movl   $0x80,0x2767c(%ebp)
  10001f:	00 00 00 
        KERN_PANIC("More than 128 E820 entries.\n");
  100022:	50                   	push   %eax
  100023:	8d 85 a2 93 ff ff    	lea    -0x6c5e(%ebp),%eax
  100029:	89 eb                	mov    %ebp,%ebx
  10002b:	50                   	push   %eax
  10002c:	8d 85 bf 93 ff ff    	lea    -0x6c41(%ebp),%eax
  100032:	6a 3c                	push   $0x3c
  100034:	50                   	push   %eax
  100035:	e8 f6 3f 00 00       	call   104030 <debug_panic>
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
  100064:	81 c3 9c ff 00 00    	add    $0xff9c,%ebx
  10006a:	66 89 0d 00 80 0b 00 	mov    %cx,0xb8000
    if (*cp != 0xA55A) {
  100071:	0f b7 05 00 80 0b 00 	movzwl 0xb8000,%eax
  100078:	66 3d 5a a5          	cmp    $0xa55a,%ax
  10007c:	0f 84 96 00 00 00    	je     100118 <video_init+0xc8>
        cp = (uint16_t *) MONO_BUF;
        addr_6845 = MONO_BASE;
        dprintf("addr_6845:%x\n", addr_6845);
  100082:	83 ec 08             	sub    $0x8,%esp
  100085:	8d 83 00 90 ff ff    	lea    -0x7000(%ebx),%eax
        cp = (uint16_t *) MONO_BUF;
  10008b:	bf 00 00 0b 00       	mov    $0xb0000,%edi
        addr_6845 = MONO_BASE;
  100090:	c7 83 0c 70 02 00 b4 	movl   $0x3b4,0x2700c(%ebx)
  100097:	03 00 00 
        dprintf("addr_6845:%x\n", addr_6845);
  10009a:	68 b4 03 00 00       	push   $0x3b4
  10009f:	50                   	push   %eax
  1000a0:	e8 9b 41 00 00       	call   104240 <dprintf>
  1000a5:	83 c4 10             	add    $0x10,%esp
        addr_6845 = CGA_BASE;
        dprintf("addr_6845:%x\n", addr_6845);
    }

    /* Extract cursor location */
    outb(addr_6845, 14);
  1000a8:	83 ec 08             	sub    $0x8,%esp
  1000ab:	6a 0e                	push   $0xe
  1000ad:	ff b3 0c 70 02 00    	push   0x2700c(%ebx)
  1000b3:	e8 78 4d 00 00       	call   104e30 <outb>
    pos = inb(addr_6845 + 1) << 8;
  1000b8:	8b 83 0c 70 02 00    	mov    0x2700c(%ebx),%eax
  1000be:	83 c0 01             	add    $0x1,%eax
  1000c1:	89 04 24             	mov    %eax,(%esp)
  1000c4:	e8 37 4d 00 00       	call   104e00 <inb>
  1000c9:	0f b6 f0             	movzbl %al,%esi
    outb(addr_6845, 15);
  1000cc:	58                   	pop    %eax
  1000cd:	5a                   	pop    %edx
  1000ce:	6a 0f                	push   $0xf
  1000d0:	ff b3 0c 70 02 00    	push   0x2700c(%ebx)
    pos = inb(addr_6845 + 1) << 8;
  1000d6:	c1 e6 08             	shl    $0x8,%esi
    outb(addr_6845, 15);
  1000d9:	e8 52 4d 00 00       	call   104e30 <outb>
    pos |= inb(addr_6845 + 1);
  1000de:	8b 83 0c 70 02 00    	mov    0x2700c(%ebx),%eax
  1000e4:	83 c0 01             	add    $0x1,%eax
  1000e7:	89 04 24             	mov    %eax,(%esp)
  1000ea:	e8 11 4d 00 00       	call   104e00 <inb>

    terminal.crt_buf = (uint16_t *) cp;
    terminal.crt_pos = pos;
    terminal.active_console = 0;
}
  1000ef:	83 c4 10             	add    $0x10,%esp
    terminal.crt_buf = (uint16_t *) cp;
  1000f2:	89 bb 00 70 02 00    	mov    %edi,0x27000(%ebx)
    terminal.active_console = 0;
  1000f8:	c7 83 08 70 02 00 00 	movl   $0x0,0x27008(%ebx)
  1000ff:	00 00 00 
    pos |= inb(addr_6845 + 1);
  100102:	0f b6 c0             	movzbl %al,%eax
  100105:	09 f0                	or     %esi,%eax
    terminal.crt_pos = pos;
  100107:	66 89 83 04 70 02 00 	mov    %ax,0x27004(%ebx)
}
  10010e:	5b                   	pop    %ebx
  10010f:	5e                   	pop    %esi
  100110:	5f                   	pop    %edi
  100111:	c3                   	ret    
  100112:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        dprintf("addr_6845:%x\n", addr_6845);
  100118:	83 ec 08             	sub    $0x8,%esp
  10011b:	8d 83 00 90 ff ff    	lea    -0x7000(%ebx),%eax
    cp = (uint16_t *) CGA_BUF;
  100121:	bf 00 80 0b 00       	mov    $0xb8000,%edi
        *cp = was;
  100126:	66 89 15 00 80 0b 00 	mov    %dx,0xb8000
        dprintf("addr_6845:%x\n", addr_6845);
  10012d:	68 d4 03 00 00       	push   $0x3d4
  100132:	50                   	push   %eax
        addr_6845 = CGA_BASE;
  100133:	c7 83 0c 70 02 00 d4 	movl   $0x3d4,0x2700c(%ebx)
  10013a:	03 00 00 
        dprintf("addr_6845:%x\n", addr_6845);
  10013d:	e8 fe 40 00 00       	call   104240 <dprintf>
  100142:	83 c4 10             	add    $0x10,%esp
  100145:	e9 5e ff ff ff       	jmp    1000a8 <video_init+0x58>
  10014a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100150 <video_putc>:

void video_putc(int c)
{
  100150:	56                   	push   %esi
  100151:	53                   	push   %ebx
  100152:	e8 32 02 00 00       	call   100389 <__x86.get_pc_thunk.bx>
  100157:	81 c3 a9 fe 00 00    	add    $0xfea9,%ebx
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
  1001d0:	0f b7 83 04 70 02 00 	movzwl 0x27004(%ebx),%eax
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
  1001e9:	ff b3 0c 70 02 00    	push   0x2700c(%ebx)
  1001ef:	e8 3c 4c 00 00       	call   104e30 <outb>
    outb(addr_6845 + 1, terminal.crt_pos >> 8);
  1001f4:	58                   	pop    %eax
  1001f5:	0f b6 83 05 70 02 00 	movzbl 0x27005(%ebx),%eax
  1001fc:	5a                   	pop    %edx
  1001fd:	50                   	push   %eax
  1001fe:	8b 83 0c 70 02 00    	mov    0x2700c(%ebx),%eax
  100204:	83 c0 01             	add    $0x1,%eax
  100207:	50                   	push   %eax
  100208:	e8 23 4c 00 00       	call   104e30 <outb>
    outb(addr_6845, 15);
  10020d:	59                   	pop    %ecx
  10020e:	5e                   	pop    %esi
  10020f:	6a 0f                	push   $0xf
  100211:	ff b3 0c 70 02 00    	push   0x2700c(%ebx)
  100217:	e8 14 4c 00 00       	call   104e30 <outb>
    outb(addr_6845 + 1, terminal.crt_pos);
  10021c:	58                   	pop    %eax
  10021d:	0f b6 83 04 70 02 00 	movzbl 0x27004(%ebx),%eax
  100224:	5a                   	pop    %edx
  100225:	50                   	push   %eax
  100226:	8b 83 0c 70 02 00    	mov    0x2700c(%ebx),%eax
  10022c:	83 c0 01             	add    $0x1,%eax
  10022f:	50                   	push   %eax
  100230:	e8 fb 4b 00 00       	call   104e30 <outb>
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
  100245:	0f b7 83 04 70 02 00 	movzwl 0x27004(%ebx),%eax
        terminal.crt_pos -= (terminal.crt_pos % CRT_COLS);
  10024c:	0f b7 c0             	movzwl %ax,%eax
  10024f:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  100255:	c1 e8 16             	shr    $0x16,%eax
  100258:	8d 04 80             	lea    (%eax,%eax,4),%eax
  10025b:	c1 e0 04             	shl    $0x4,%eax
  10025e:	66 89 83 04 70 02 00 	mov    %ax,0x27004(%ebx)
    if (terminal.crt_pos >= CRT_SIZE) {
  100265:	66 3d cf 07          	cmp    $0x7cf,%ax
  100269:	0f 86 75 ff ff ff    	jbe    1001e4 <video_putc+0x94>
        memmove(terminal.crt_buf, terminal.crt_buf + CRT_COLS,
  10026f:	8b 83 00 70 02 00    	mov    0x27000(%ebx),%eax
  100275:	83 ec 04             	sub    $0x4,%esp
  100278:	68 00 0f 00 00       	push   $0xf00
  10027d:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  100283:	52                   	push   %edx
  100284:	50                   	push   %eax
  100285:	e8 16 3b 00 00       	call   103da0 <memmove>
            terminal.crt_buf[i] = 0x0700 | ' ';
  10028a:	8b 93 00 70 02 00    	mov    0x27000(%ebx),%edx
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
  1002b0:	66 83 ab 04 70 02 00 	subw   $0x50,0x27004(%ebx)
  1002b7:	50 
  1002b8:	e9 27 ff ff ff       	jmp    1001e4 <video_putc+0x94>
  1002bd:	8d 76 00             	lea    0x0(%esi),%esi
        terminal.crt_buf[terminal.crt_pos++] = c;  /* write the character */
  1002c0:	0f b7 8b 04 70 02 00 	movzwl 0x27004(%ebx),%ecx
  1002c7:	8b b3 00 70 02 00    	mov    0x27000(%ebx),%esi
  1002cd:	8d 41 01             	lea    0x1(%ecx),%eax
  1002d0:	66 89 14 4e          	mov    %dx,(%esi,%ecx,2)
  1002d4:	66 89 83 04 70 02 00 	mov    %ax,0x27004(%ebx)
        break;
  1002db:	e9 fa fe ff ff       	jmp    1001da <video_putc+0x8a>
        if (terminal.crt_pos > 0) {
  1002e0:	0f b7 83 04 70 02 00 	movzwl 0x27004(%ebx),%eax
  1002e7:	66 85 c0             	test   %ax,%ax
  1002ea:	0f 84 f4 fe ff ff    	je     1001e4 <video_putc+0x94>
            terminal.crt_pos--;
  1002f0:	83 e8 01             	sub    $0x1,%eax
            terminal.crt_buf[terminal.crt_pos] = (c & ~0xff) | ' ';
  1002f3:	8b 8b 00 70 02 00    	mov    0x27000(%ebx),%ecx
  1002f9:	30 d2                	xor    %dl,%dl
  1002fb:	0f b7 f0             	movzwl %ax,%esi
  1002fe:	83 ca 20             	or     $0x20,%edx
            terminal.crt_pos--;
  100301:	66 89 83 04 70 02 00 	mov    %ax,0x27004(%ebx)
            terminal.crt_buf[terminal.crt_pos] = (c & ~0xff) | ' ';
  100308:	66 89 14 71          	mov    %dx,(%ecx,%esi,2)
  10030c:	e9 c9 fe ff ff       	jmp    1001da <video_putc+0x8a>
        terminal.crt_pos += CRT_COLS;
  100311:	0f b7 83 04 70 02 00 	movzwl 0x27004(%ebx),%eax
  100318:	83 c0 50             	add    $0x50,%eax
  10031b:	e9 2c ff ff ff       	jmp    10024c <video_putc+0xfc>

00100320 <video_set_cursor>:

void video_set_cursor(int x, int y)
{
    terminal.crt_pos = x * CRT_COLS + y;
  100320:	e8 60 00 00 00       	call   100385 <__x86.get_pc_thunk.dx>
  100325:	81 c2 db fc 00 00    	add    $0xfcdb,%edx
{
  10032b:	8b 44 24 04          	mov    0x4(%esp),%eax
    terminal.crt_pos = x * CRT_COLS + y;
  10032f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  100332:	c1 e0 04             	shl    $0x4,%eax
  100335:	66 03 44 24 08       	add    0x8(%esp),%ax
  10033a:	66 89 82 04 70 02 00 	mov    %ax,0x27004(%edx)
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
  100355:	05 ab fc 00 00       	add    $0xfcab,%eax
  10035a:	8b 80 00 70 02 00    	mov    0x27000(%eax),%eax
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
  100396:	81 c3 6a fc 00 00    	add    $0xfc6a,%ebx
  10039c:	83 ec 0c             	sub    $0xc,%esp
    memset(&cons, 0x0, sizeof(cons));
  10039f:	68 08 02 00 00       	push   $0x208
  1003a4:	6a 00                	push   $0x0
  1003a6:	8d 83 20 70 02 00    	lea    0x27020(%ebx),%eax
  1003ac:	50                   	push   %eax
  1003ad:	e8 9e 39 00 00       	call   103d50 <memset>
    serial_init();
  1003b2:	e8 69 04 00 00       	call   100820 <serial_init>
    video_init();
  1003b7:	e8 94 fc ff ff       	call   100050 <video_init>
}
  1003bc:	83 c4 18             	add    $0x18,%esp
  1003bf:	5b                   	pop    %ebx
  1003c0:	c3                   	ret    
  1003c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1003c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1003cf:	90                   	nop

001003d0 <cons_intr>:

void cons_intr(int (*proc)(void))
{
  1003d0:	55                   	push   %ebp
  1003d1:	57                   	push   %edi
  1003d2:	56                   	push   %esi
  1003d3:	e8 e8 02 00 00       	call   1006c0 <__x86.get_pc_thunk.si>
  1003d8:	81 c6 28 fc 00 00    	add    $0xfc28,%esi
  1003de:	53                   	push   %ebx
    int c;

    while ((c = (*proc)()) != -1) {
        if (c == 0)
            continue;
        cons.buf[cons.wpos++] = c;
  1003df:	8d 1d 20 70 02 00    	lea    0x27020,%ebx
{
  1003e5:	83 ec 0c             	sub    $0xc,%esp
  1003e8:	8b 7c 24 20          	mov    0x20(%esp),%edi
        cons.buf[cons.wpos++] = c;
  1003ec:	8d 2c 1e             	lea    (%esi,%ebx,1),%ebp
  1003ef:	90                   	nop
    while ((c = (*proc)()) != -1) {
  1003f0:	ff d7                	call   *%edi
  1003f2:	83 f8 ff             	cmp    $0xffffffff,%eax
  1003f5:	74 33                	je     10042a <cons_intr+0x5a>
        if (c == 0)
  1003f7:	85 c0                	test   %eax,%eax
  1003f9:	74 f5                	je     1003f0 <cons_intr+0x20>
        cons.buf[cons.wpos++] = c;
  1003fb:	8b 8c 1e 04 02 00 00 	mov    0x204(%esi,%ebx,1),%ecx
  100402:	8d 51 01             	lea    0x1(%ecx),%edx
  100405:	88 44 0d 00          	mov    %al,0x0(%ebp,%ecx,1)
  100409:	89 94 1e 04 02 00 00 	mov    %edx,0x204(%esi,%ebx,1)
        if (cons.wpos == CONSOLE_BUFFER_SIZE)
  100410:	81 fa 00 02 00 00    	cmp    $0x200,%edx
  100416:	75 d8                	jne    1003f0 <cons_intr+0x20>
            cons.wpos = 0;
  100418:	c7 84 33 04 02 00 00 	movl   $0x0,0x204(%ebx,%esi,1)
  10041f:	00 00 00 00 
    while ((c = (*proc)()) != -1) {
  100423:	ff d7                	call   *%edi
  100425:	83 f8 ff             	cmp    $0xffffffff,%eax
  100428:	75 cd                	jne    1003f7 <cons_intr+0x27>
    }
}
  10042a:	83 c4 0c             	add    $0xc,%esp
  10042d:	5b                   	pop    %ebx
  10042e:	5e                   	pop    %esi
  10042f:	5f                   	pop    %edi
  100430:	5d                   	pop    %ebp
  100431:	c3                   	ret    
  100432:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100440 <cons_getc>:

char cons_getc(void)
{
  100440:	53                   	push   %ebx
  100441:	e8 43 ff ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  100446:	81 c3 ba fb 00 00    	add    $0xfbba,%ebx
  10044c:	83 ec 08             	sub    $0x8,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  10044f:	e8 cc 02 00 00       	call   100720 <serial_intr>
    keyboard_intr();
  100454:	e8 37 06 00 00       	call   100a90 <keyboard_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  100459:	8b 83 20 72 02 00    	mov    0x27220(%ebx),%eax
  10045f:	31 d2                	xor    %edx,%edx
  100461:	3b 83 24 72 02 00    	cmp    0x27224(%ebx),%eax
  100467:	74 1e                	je     100487 <cons_getc+0x47>
        c = cons.buf[cons.rpos++];
  100469:	8d 48 01             	lea    0x1(%eax),%ecx
        if (cons.rpos == CONSOLE_BUFFER_SIZE)
            cons.rpos = 0;
  10046c:	3d ff 01 00 00       	cmp    $0x1ff,%eax
        c = cons.buf[cons.rpos++];
  100471:	0f b6 94 03 20 70 02 	movzbl 0x27020(%ebx,%eax,1),%edx
  100478:	00 
            cons.rpos = 0;
  100479:	b8 00 00 00 00       	mov    $0x0,%eax
  10047e:	0f 45 c1             	cmovne %ecx,%eax
  100481:	89 83 20 72 02 00    	mov    %eax,0x27220(%ebx)
        return c;
    }
    return 0;
}
  100487:	83 c4 08             	add    $0x8,%esp
  10048a:	89 d0                	mov    %edx,%eax
  10048c:	5b                   	pop    %ebx
  10048d:	c3                   	ret    
  10048e:	66 90                	xchg   %ax,%ax

00100490 <cons_putc>:

void cons_putc(char c)
{
  100490:	56                   	push   %esi
  100491:	53                   	push   %ebx
  100492:	e8 f2 fe ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  100497:	81 c3 69 fb 00 00    	add    $0xfb69,%ebx
  10049d:	83 ec 10             	sub    $0x10,%esp
    serial_putc(c);
  1004a0:	0f be 74 24 1c       	movsbl 0x1c(%esp),%esi
  1004a5:	56                   	push   %esi
  1004a6:	e8 b5 02 00 00       	call   100760 <serial_putc>
    video_putc(c);
  1004ab:	89 34 24             	mov    %esi,(%esp)
  1004ae:	e8 9d fc ff ff       	call   100150 <video_putc>
}
  1004b3:	83 c4 14             	add    $0x14,%esp
  1004b6:	5b                   	pop    %ebx
  1004b7:	5e                   	pop    %esi
  1004b8:	c3                   	ret    
  1004b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001004c0 <getchar>:

char getchar(void)
{
  1004c0:	55                   	push   %ebp
  1004c1:	8d 2d 20 70 02 00    	lea    0x27020,%ebp
  1004c7:	57                   	push   %edi
  1004c8:	56                   	push   %esi
            cons.rpos = 0;
  1004c9:	31 f6                	xor    %esi,%esi
{
  1004cb:	53                   	push   %ebx
  1004cc:	e8 b8 fe ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1004d1:	81 c3 2f fb 00 00    	add    $0xfb2f,%ebx
  1004d7:	83 ec 0c             	sub    $0xc,%esp
        c = cons.buf[cons.rpos++];
  1004da:	8d 7c 1d 00          	lea    0x0(%ebp,%ebx,1),%edi
  1004de:	66 90                	xchg   %ax,%ax
    serial_intr();
  1004e0:	e8 3b 02 00 00       	call   100720 <serial_intr>
    keyboard_intr();
  1004e5:	e8 a6 05 00 00       	call   100a90 <keyboard_intr>
    if (cons.rpos != cons.wpos) {
  1004ea:	8b 84 1d 00 02 00 00 	mov    0x200(%ebp,%ebx,1),%eax
  1004f1:	3b 84 1d 04 02 00 00 	cmp    0x204(%ebp,%ebx,1),%eax
  1004f8:	74 e6                	je     1004e0 <getchar+0x20>
        c = cons.buf[cons.rpos++];
  1004fa:	8d 50 01             	lea    0x1(%eax),%edx
            cons.rpos = 0;
  1004fd:	3d ff 01 00 00       	cmp    $0x1ff,%eax
        c = cons.buf[cons.rpos++];
  100502:	0f b6 0c 07          	movzbl (%edi,%eax,1),%ecx
            cons.rpos = 0;
  100506:	0f 44 d6             	cmove  %esi,%edx
  100509:	89 94 1d 00 02 00 00 	mov    %edx,0x200(%ebp,%ebx,1)
    char c;

    while ((c = cons_getc()) == 0)
  100510:	84 c9                	test   %cl,%cl
  100512:	74 cc                	je     1004e0 <getchar+0x20>
        /* do nothing */ ;
    return c;
}
  100514:	83 c4 0c             	add    $0xc,%esp
  100517:	89 c8                	mov    %ecx,%eax
  100519:	5b                   	pop    %ebx
  10051a:	5e                   	pop    %esi
  10051b:	5f                   	pop    %edi
  10051c:	5d                   	pop    %ebp
  10051d:	c3                   	ret    
  10051e:	66 90                	xchg   %ax,%ax

00100520 <putchar>:
  100520:	56                   	push   %esi
  100521:	53                   	push   %ebx
  100522:	e8 62 fe ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  100527:	81 c3 d9 fa 00 00    	add    $0xfad9,%ebx
  10052d:	83 ec 10             	sub    $0x10,%esp
  100530:	0f be 74 24 1c       	movsbl 0x1c(%esp),%esi
  100535:	56                   	push   %esi
  100536:	e8 25 02 00 00       	call   100760 <serial_putc>
  10053b:	89 34 24             	mov    %esi,(%esp)
  10053e:	e8 0d fc ff ff       	call   100150 <video_putc>
  100543:	83 c4 14             	add    $0x14,%esp
  100546:	5b                   	pop    %ebx
  100547:	5e                   	pop    %esi
  100548:	c3                   	ret    
  100549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100550 <readline>:
{
    cons_putc(c);
}

char *readline(const char *prompt)
{
  100550:	55                   	push   %ebp
  100551:	57                   	push   %edi
  100552:	56                   	push   %esi
  100553:	53                   	push   %ebx
  100554:	e8 30 fe ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  100559:	81 c3 a7 fa 00 00    	add    $0xfaa7,%ebx
  10055f:	83 ec 1c             	sub    $0x1c,%esp
  100562:	8b 44 24 30          	mov    0x30(%esp),%eax
    int i;
    char c;

    if (prompt != NULL)
  100566:	85 c0                	test   %eax,%eax
  100568:	74 13                	je     10057d <readline+0x2d>
        dprintf("%s", prompt);
  10056a:	83 ec 08             	sub    $0x8,%esp
  10056d:	50                   	push   %eax
  10056e:	8d 83 b6 a7 ff ff    	lea    -0x584a(%ebx),%eax
  100574:	50                   	push   %eax
  100575:	e8 c6 3c 00 00       	call   104240 <dprintf>
  10057a:	83 c4 10             	add    $0x10,%esp
        } else if ((c == '\b' || c == '\x7f') && i > 0) {
            putchar('\b');
            i--;
        } else if (c >= ' ' && i < BUFLEN - 1) {
            putchar(c);
            linebuf[i++] = c;
  10057d:	8d 83 40 72 02 00    	lea    0x27240(%ebx),%eax
  100583:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  10058a:	00 
  10058b:	8d 2d 20 70 02 00    	lea    0x27020,%ebp
  100591:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100595:	8d 76 00             	lea    0x0(%esi),%esi
        c = cons.buf[cons.rpos++];
  100598:	8d 7c 1d 00          	lea    0x0(%ebp,%ebx,1),%edi
            cons.rpos = 0;
  10059c:	31 f6                	xor    %esi,%esi
  10059e:	66 90                	xchg   %ax,%ax
    serial_intr();
  1005a0:	e8 7b 01 00 00       	call   100720 <serial_intr>
    keyboard_intr();
  1005a5:	e8 e6 04 00 00       	call   100a90 <keyboard_intr>
    if (cons.rpos != cons.wpos) {
  1005aa:	8b 84 1d 00 02 00 00 	mov    0x200(%ebp,%ebx,1),%eax
  1005b1:	3b 84 1d 04 02 00 00 	cmp    0x204(%ebp,%ebx,1),%eax
  1005b8:	74 e6                	je     1005a0 <readline+0x50>
        c = cons.buf[cons.rpos++];
  1005ba:	8d 48 01             	lea    0x1(%eax),%ecx
            cons.rpos = 0;
  1005bd:	3d ff 01 00 00       	cmp    $0x1ff,%eax
        c = cons.buf[cons.rpos++];
  1005c2:	0f be 14 07          	movsbl (%edi,%eax,1),%edx
            cons.rpos = 0;
  1005c6:	0f 44 ce             	cmove  %esi,%ecx
  1005c9:	89 8c 1d 00 02 00 00 	mov    %ecx,0x200(%ebp,%ebx,1)
    while ((c = cons_getc()) == 0)
  1005d0:	84 d2                	test   %dl,%dl
  1005d2:	74 cc                	je     1005a0 <readline+0x50>
        if (c < 0) {
  1005d4:	0f 88 c9 00 00 00    	js     1006a3 <readline+0x153>
        } else if ((c == '\b' || c == '\x7f') && i > 0) {
  1005da:	80 fa 08             	cmp    $0x8,%dl
  1005dd:	0f 94 c0             	sete   %al
  1005e0:	80 fa 7f             	cmp    $0x7f,%dl
  1005e3:	0f 94 c1             	sete   %cl
  1005e6:	08 c8                	or     %cl,%al
  1005e8:	74 0c                	je     1005f6 <readline+0xa6>
  1005ea:	8b 44 24 08          	mov    0x8(%esp),%eax
  1005ee:	85 c0                	test   %eax,%eax
  1005f0:	0f 85 8a 00 00 00    	jne    100680 <readline+0x130>
        } else if (c >= ' ' && i < BUFLEN - 1) {
  1005f6:	80 fa 1f             	cmp    $0x1f,%dl
  1005f9:	7e 45                	jle    100640 <readline+0xf0>
  1005fb:	8b 7c 24 08          	mov    0x8(%esp),%edi
  1005ff:	81 ff fe 03 00 00    	cmp    $0x3fe,%edi
  100605:	7f 39                	jg     100640 <readline+0xf0>
            putchar(c);
  100607:	88 54 24 08          	mov    %dl,0x8(%esp)
  10060b:	0f be f2             	movsbl %dl,%esi
    serial_putc(c);
  10060e:	83 ec 0c             	sub    $0xc,%esp
  100611:	56                   	push   %esi
  100612:	e8 49 01 00 00       	call   100760 <serial_putc>
    video_putc(c);
  100617:	89 34 24             	mov    %esi,(%esp)
  10061a:	e8 31 fb ff ff       	call   100150 <video_putc>
            linebuf[i++] = c;
  10061f:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  100623:	0f b6 54 24 18       	movzbl 0x18(%esp),%edx
  100628:	83 c4 10             	add    $0x10,%esp
  10062b:	88 14 38             	mov    %dl,(%eax,%edi,1)
  10062e:	8d 47 01             	lea    0x1(%edi),%eax
  100631:	89 44 24 08          	mov    %eax,0x8(%esp)
  100635:	e9 5e ff ff ff       	jmp    100598 <readline+0x48>
  10063a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        } else if (c == '\n' || c == '\r') {
  100640:	80 fa 0a             	cmp    $0xa,%dl
  100643:	74 09                	je     10064e <readline+0xfe>
  100645:	80 fa 0d             	cmp    $0xd,%dl
  100648:	0f 85 4a ff ff ff    	jne    100598 <readline+0x48>
    serial_putc(c);
  10064e:	83 ec 0c             	sub    $0xc,%esp
  100651:	6a 0a                	push   $0xa
  100653:	e8 08 01 00 00       	call   100760 <serial_putc>
    video_putc(c);
  100658:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  10065f:	e8 ec fa ff ff       	call   100150 <video_putc>
            putchar('\n');
            linebuf[i] = 0;
  100664:	8b 74 24 18          	mov    0x18(%esp),%esi
  100668:	8d 83 40 72 02 00    	lea    0x27240(%ebx),%eax
            return linebuf;
  10066e:	83 c4 10             	add    $0x10,%esp
            linebuf[i] = 0;
  100671:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
        }
    }
}
  100675:	83 c4 1c             	add    $0x1c,%esp
  100678:	5b                   	pop    %ebx
  100679:	5e                   	pop    %esi
  10067a:	5f                   	pop    %edi
  10067b:	5d                   	pop    %ebp
  10067c:	c3                   	ret    
  10067d:	8d 76 00             	lea    0x0(%esi),%esi
    serial_putc(c);
  100680:	83 ec 0c             	sub    $0xc,%esp
  100683:	6a 08                	push   $0x8
  100685:	e8 d6 00 00 00       	call   100760 <serial_putc>
    video_putc(c);
  10068a:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  100691:	e8 ba fa ff ff       	call   100150 <video_putc>
            i--;
  100696:	83 6c 24 18 01       	subl   $0x1,0x18(%esp)
  10069b:	83 c4 10             	add    $0x10,%esp
  10069e:	e9 f5 fe ff ff       	jmp    100598 <readline+0x48>
            dprintf("read error: %e\n", c);
  1006a3:	83 ec 08             	sub    $0x8,%esp
  1006a6:	8d 83 0e 90 ff ff    	lea    -0x6ff2(%ebx),%eax
  1006ac:	52                   	push   %edx
  1006ad:	50                   	push   %eax
  1006ae:	e8 8d 3b 00 00       	call   104240 <dprintf>
            return NULL;
  1006b3:	83 c4 10             	add    $0x10,%esp
  1006b6:	31 c0                	xor    %eax,%eax
}
  1006b8:	83 c4 1c             	add    $0x1c,%esp
  1006bb:	5b                   	pop    %ebx
  1006bc:	5e                   	pop    %esi
  1006bd:	5f                   	pop    %edi
  1006be:	5d                   	pop    %ebp
  1006bf:	c3                   	ret    

001006c0 <__x86.get_pc_thunk.si>:
  1006c0:	8b 34 24             	mov    (%esp),%esi
  1006c3:	c3                   	ret    
  1006c4:	66 90                	xchg   %ax,%ax
  1006c6:	66 90                	xchg   %ax,%ax
  1006c8:	66 90                	xchg   %ax,%ax
  1006ca:	66 90                	xchg   %ax,%ax
  1006cc:	66 90                	xchg   %ax,%ax
  1006ce:	66 90                	xchg   %ax,%ax

001006d0 <serial_proc_data>:
    inb(0x84);
    inb(0x84);
}

static int serial_proc_data(void)
{
  1006d0:	53                   	push   %ebx
  1006d1:	e8 b3 fc ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1006d6:	81 c3 2a f9 00 00    	add    $0xf92a,%ebx
  1006dc:	83 ec 14             	sub    $0x14,%esp
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA))
  1006df:	68 fd 03 00 00       	push   $0x3fd
  1006e4:	e8 17 47 00 00       	call   104e00 <inb>
  1006e9:	83 c4 10             	add    $0x10,%esp
  1006ec:	a8 01                	test   $0x1,%al
  1006ee:	74 20                	je     100710 <serial_proc_data+0x40>
        return -1;
    return inb(COM1 + COM_RX);
  1006f0:	83 ec 0c             	sub    $0xc,%esp
  1006f3:	68 f8 03 00 00       	push   $0x3f8
  1006f8:	e8 03 47 00 00       	call   104e00 <inb>
  1006fd:	83 c4 10             	add    $0x10,%esp
  100700:	0f b6 c0             	movzbl %al,%eax
}
  100703:	83 c4 08             	add    $0x8,%esp
  100706:	5b                   	pop    %ebx
  100707:	c3                   	ret    
  100708:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10070f:	90                   	nop
        return -1;
  100710:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100715:	eb ec                	jmp    100703 <serial_proc_data+0x33>
  100717:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10071e:	66 90                	xchg   %ax,%ax

00100720 <serial_intr>:

void serial_intr(void)
{
  100720:	53                   	push   %ebx
  100721:	e8 63 fc ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  100726:	81 c3 da f8 00 00    	add    $0xf8da,%ebx
  10072c:	83 ec 08             	sub    $0x8,%esp
    if (serial_exists)
  10072f:	80 bb 40 76 02 00 00 	cmpb   $0x0,0x27640(%ebx)
  100736:	75 08                	jne    100740 <serial_intr+0x20>
        cons_intr(serial_proc_data);
}
  100738:	83 c4 08             	add    $0x8,%esp
  10073b:	5b                   	pop    %ebx
  10073c:	c3                   	ret    
  10073d:	8d 76 00             	lea    0x0(%esi),%esi
        cons_intr(serial_proc_data);
  100740:	83 ec 0c             	sub    $0xc,%esp
  100743:	8d 83 d0 06 ff ff    	lea    -0xf930(%ebx),%eax
  100749:	50                   	push   %eax
  10074a:	e8 81 fc ff ff       	call   1003d0 <cons_intr>
  10074f:	83 c4 10             	add    $0x10,%esp
}
  100752:	83 c4 08             	add    $0x8,%esp
  100755:	5b                   	pop    %ebx
  100756:	c3                   	ret    
  100757:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10075e:	66 90                	xchg   %ax,%ax

00100760 <serial_putc>:
    } else
        return 0;
}

void serial_putc(char c)
{
  100760:	57                   	push   %edi
  100761:	56                   	push   %esi
    if (!serial_exists)
        return;

    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i++)
  100762:	31 f6                	xor    %esi,%esi
{
  100764:	53                   	push   %ebx
  100765:	8b 7c 24 10          	mov    0x10(%esp),%edi
  100769:	e8 1b fc ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10076e:	81 c3 92 f8 00 00    	add    $0xf892,%ebx
    if (!serial_exists)
  100774:	80 bb 40 76 02 00 00 	cmpb   $0x0,0x27640(%ebx)
  10077b:	75 42                	jne    1007bf <serial_putc+0x5f>
  10077d:	eb 6e                	jmp    1007ed <serial_putc+0x8d>
  10077f:	90                   	nop
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i++)
  100780:	81 fe 00 32 00 00    	cmp    $0x3200,%esi
  100786:	74 4b                	je     1007d3 <serial_putc+0x73>
    inb(0x84);
  100788:	83 ec 0c             	sub    $0xc,%esp
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i++)
  10078b:	83 c6 01             	add    $0x1,%esi
    inb(0x84);
  10078e:	68 84 00 00 00       	push   $0x84
  100793:	e8 68 46 00 00       	call   104e00 <inb>
    inb(0x84);
  100798:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  10079f:	e8 5c 46 00 00       	call   104e00 <inb>
    inb(0x84);
  1007a4:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  1007ab:	e8 50 46 00 00       	call   104e00 <inb>
    inb(0x84);
  1007b0:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  1007b7:	e8 44 46 00 00       	call   104e00 <inb>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i++)
  1007bc:	83 c4 10             	add    $0x10,%esp
  1007bf:	83 ec 0c             	sub    $0xc,%esp
  1007c2:	68 fd 03 00 00       	push   $0x3fd
  1007c7:	e8 34 46 00 00       	call   104e00 <inb>
  1007cc:	83 c4 10             	add    $0x10,%esp
  1007cf:	a8 20                	test   $0x20,%al
  1007d1:	74 ad                	je     100780 <serial_putc+0x20>
    if (c == nl) {
  1007d3:	89 f8                	mov    %edi,%eax
  1007d5:	3c 0a                	cmp    $0xa,%al
  1007d7:	74 1f                	je     1007f8 <serial_putc+0x98>
        delay();

    if (!serial_reformatnewline(c, COM1 + COM_TX))
        outb(COM1 + COM_TX, c);
  1007d9:	83 ec 08             	sub    $0x8,%esp
  1007dc:	0f b6 f8             	movzbl %al,%edi
  1007df:	57                   	push   %edi
  1007e0:	68 f8 03 00 00       	push   $0x3f8
  1007e5:	e8 46 46 00 00       	call   104e30 <outb>
  1007ea:	83 c4 10             	add    $0x10,%esp
}
  1007ed:	5b                   	pop    %ebx
  1007ee:	5e                   	pop    %esi
  1007ef:	5f                   	pop    %edi
  1007f0:	c3                   	ret    
  1007f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        outb(p, cr);
  1007f8:	83 ec 08             	sub    $0x8,%esp
  1007fb:	6a 0d                	push   $0xd
  1007fd:	68 f8 03 00 00       	push   $0x3f8
  100802:	e8 29 46 00 00       	call   104e30 <outb>
        outb(p, nl);
  100807:	58                   	pop    %eax
  100808:	5a                   	pop    %edx
  100809:	6a 0a                	push   $0xa
  10080b:	68 f8 03 00 00       	push   $0x3f8
  100810:	e8 1b 46 00 00       	call   104e30 <outb>
  100815:	83 c4 10             	add    $0x10,%esp
}
  100818:	5b                   	pop    %ebx
  100819:	5e                   	pop    %esi
  10081a:	5f                   	pop    %edi
  10081b:	c3                   	ret    
  10081c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00100820 <serial_init>:

void serial_init(void)
{
  100820:	53                   	push   %ebx
  100821:	e8 63 fb ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  100826:	81 c3 da f7 00 00    	add    $0xf7da,%ebx
  10082c:	83 ec 10             	sub    $0x10,%esp
    /* turn off interrupt */
    outb(COM1 + COM_IER, 0);
  10082f:	6a 00                	push   $0x0
  100831:	68 f9 03 00 00       	push   $0x3f9
  100836:	e8 f5 45 00 00       	call   104e30 <outb>

    /* set DLAB */
    outb(COM1 + COM_LCR, COM_LCR_DLAB);
  10083b:	58                   	pop    %eax
  10083c:	5a                   	pop    %edx
  10083d:	68 80 00 00 00       	push   $0x80
  100842:	68 fb 03 00 00       	push   $0x3fb
  100847:	e8 e4 45 00 00       	call   104e30 <outb>

    /* set baud rate */
    outb(COM1 + COM_DLL, 0x0001 & 0xff);
  10084c:	59                   	pop    %ecx
  10084d:	58                   	pop    %eax
  10084e:	6a 01                	push   $0x1
  100850:	68 f8 03 00 00       	push   $0x3f8
  100855:	e8 d6 45 00 00       	call   104e30 <outb>
    outb(COM1 + COM_DLM, 0x0001 >> 8);
  10085a:	58                   	pop    %eax
  10085b:	5a                   	pop    %edx
  10085c:	6a 00                	push   $0x0
  10085e:	68 f9 03 00 00       	push   $0x3f9
  100863:	e8 c8 45 00 00       	call   104e30 <outb>

    /* Set the line status. */
    outb(COM1 + COM_LCR, COM_LCR_WLEN8 & ~COM_LCR_DLAB);
  100868:	59                   	pop    %ecx
  100869:	58                   	pop    %eax
  10086a:	6a 03                	push   $0x3
  10086c:	68 fb 03 00 00       	push   $0x3fb
  100871:	e8 ba 45 00 00       	call   104e30 <outb>

    /* Enable the FIFO. */
    outb(COM1 + COM_FCR, 0xc7);
  100876:	58                   	pop    %eax
  100877:	5a                   	pop    %edx
  100878:	68 c7 00 00 00       	push   $0xc7
  10087d:	68 fa 03 00 00       	push   $0x3fa
  100882:	e8 a9 45 00 00       	call   104e30 <outb>

    /* Turn on DTR, RTS, and OUT2. */
    outb(COM1 + COM_MCR, 0x0b);
  100887:	59                   	pop    %ecx
  100888:	58                   	pop    %eax
  100889:	6a 0b                	push   $0xb
  10088b:	68 fc 03 00 00       	push   $0x3fc
  100890:	e8 9b 45 00 00       	call   104e30 <outb>

    // Clear any preexisting overrun indications and interrupts
    // Serial COM1 doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  100895:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
  10089c:	e8 5f 45 00 00       	call   104e00 <inb>
    (void) inb(COM1 + COM_IIR);
  1008a1:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  1008a8:	3c ff                	cmp    $0xff,%al
  1008aa:	0f 95 83 40 76 02 00 	setne  0x27640(%ebx)
    (void) inb(COM1 + COM_IIR);
  1008b1:	e8 4a 45 00 00       	call   104e00 <inb>
    (void) inb(COM1 + COM_RX);
  1008b6:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
  1008bd:	e8 3e 45 00 00       	call   104e00 <inb>
}
  1008c2:	83 c4 18             	add    $0x18,%esp
  1008c5:	5b                   	pop    %ebx
  1008c6:	c3                   	ret    
  1008c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1008ce:	66 90                	xchg   %ax,%ax

001008d0 <serial_intenable>:

void serial_intenable(void)
{
  1008d0:	53                   	push   %ebx
  1008d1:	e8 b3 fa ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1008d6:	81 c3 2a f7 00 00    	add    $0xf72a,%ebx
  1008dc:	83 ec 08             	sub    $0x8,%esp
    if (serial_exists) {
  1008df:	80 bb 40 76 02 00 00 	cmpb   $0x0,0x27640(%ebx)
  1008e6:	75 08                	jne    1008f0 <serial_intenable+0x20>
        outb(COM1 + COM_IER, 1);
        serial_intr();
    }
}
  1008e8:	83 c4 08             	add    $0x8,%esp
  1008eb:	5b                   	pop    %ebx
  1008ec:	c3                   	ret    
  1008ed:	8d 76 00             	lea    0x0(%esi),%esi
        outb(COM1 + COM_IER, 1);
  1008f0:	83 ec 08             	sub    $0x8,%esp
  1008f3:	6a 01                	push   $0x1
  1008f5:	68 f9 03 00 00       	push   $0x3f9
  1008fa:	e8 31 45 00 00       	call   104e30 <outb>
    if (serial_exists)
  1008ff:	83 c4 10             	add    $0x10,%esp
  100902:	80 bb 40 76 02 00 00 	cmpb   $0x0,0x27640(%ebx)
  100909:	74 dd                	je     1008e8 <serial_intenable+0x18>
        cons_intr(serial_proc_data);
  10090b:	83 ec 0c             	sub    $0xc,%esp
  10090e:	8d 83 d0 06 ff ff    	lea    -0xf930(%ebx),%eax
  100914:	50                   	push   %eax
  100915:	e8 b6 fa ff ff       	call   1003d0 <cons_intr>
  10091a:	83 c4 10             	add    $0x10,%esp
}
  10091d:	83 c4 08             	add    $0x8,%esp
  100920:	5b                   	pop    %ebx
  100921:	c3                   	ret    
  100922:	66 90                	xchg   %ax,%ax
  100924:	66 90                	xchg   %ax,%ax
  100926:	66 90                	xchg   %ax,%ax
  100928:	66 90                	xchg   %ax,%ax
  10092a:	66 90                	xchg   %ax,%ax
  10092c:	66 90                	xchg   %ax,%ax
  10092e:	66 90                	xchg   %ax,%ax

00100930 <kbd_proc_data>:
/*
 * Get data from the keyboard. If we finish a character, return it. Else 0.
 * Return -1 if no data.
 */
static int kbd_proc_data(void)
{
  100930:	56                   	push   %esi
  100931:	53                   	push   %ebx
  100932:	e8 52 fa ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  100937:	81 c3 c9 f6 00 00    	add    $0xf6c9,%ebx
  10093d:	83 ec 10             	sub    $0x10,%esp
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0)
  100940:	6a 64                	push   $0x64
  100942:	e8 b9 44 00 00       	call   104e00 <inb>
  100947:	83 c4 10             	add    $0x10,%esp
  10094a:	a8 01                	test   $0x1,%al
  10094c:	0f 84 2e 01 00 00    	je     100a80 <kbd_proc_data+0x150>
        return -1;

    data = inb(KBDATAP);
  100952:	83 ec 0c             	sub    $0xc,%esp
  100955:	6a 60                	push   $0x60
  100957:	e8 a4 44 00 00       	call   104e00 <inb>

    if (data == 0xE0) {
  10095c:	83 c4 10             	add    $0x10,%esp
  10095f:	3c e0                	cmp    $0xe0,%al
  100961:	0f 84 89 00 00 00    	je     1009f0 <kbd_proc_data+0xc0>
        // E0 escape character
        shift |= E0ESC;
  100967:	8b 8b 44 76 02 00    	mov    0x27644(%ebx),%ecx
        return 0;
    } else if (data & 0x80) {
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  10096d:	89 ca                	mov    %ecx,%edx
  10096f:	83 e2 40             	and    $0x40,%edx
    } else if (data & 0x80) {
  100972:	84 c0                	test   %al,%al
  100974:	0f 88 8e 00 00 00    	js     100a08 <kbd_proc_data+0xd8>
        shift &= ~(shiftcode[data] | E0ESC);
        return 0;
    } else if (shift & E0ESC) {
  10097a:	85 d2                	test   %edx,%edx
  10097c:	74 06                	je     100984 <kbd_proc_data+0x54>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  10097e:	83 c8 80             	or     $0xffffff80,%eax
        shift &= ~E0ESC;
  100981:	83 e1 bf             	and    $0xffffffbf,%ecx
    }

    shift |= shiftcode[data];
  100984:	0f b6 c0             	movzbl %al,%eax
  100987:	0f b6 94 03 40 91 ff 	movzbl -0x6ec0(%ebx,%eax,1),%edx
  10098e:	ff 
  10098f:	09 ca                	or     %ecx,%edx
    shift ^= togglecode[data];
  100991:	0f b6 8c 03 40 90 ff 	movzbl -0x6fc0(%ebx,%eax,1),%ecx
  100998:	ff 
  100999:	31 ca                	xor    %ecx,%edx

    c = charcode[shift & (CTL | SHIFT)][data];
  10099b:	89 d1                	mov    %edx,%ecx
    shift ^= togglecode[data];
  10099d:	89 93 44 76 02 00    	mov    %edx,0x27644(%ebx)
    c = charcode[shift & (CTL | SHIFT)][data];
  1009a3:	83 e1 03             	and    $0x3,%ecx
  1009a6:	8b 8c 8b d8 ff ff ff 	mov    -0x28(%ebx,%ecx,4),%ecx
  1009ad:	0f b6 34 01          	movzbl (%ecx,%eax,1),%esi
    if (shift & CAPSLOCK) {
  1009b1:	f6 c2 08             	test   $0x8,%dl
  1009b4:	75 22                	jne    1009d8 <kbd_proc_data+0xa8>
        else if ('A' <= c && c <= 'Z')
            c += 'a' - 'A';
    }
    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  1009b6:	f7 d2                	not    %edx
  1009b8:	83 e2 06             	and    $0x6,%edx
  1009bb:	75 0c                	jne    1009c9 <kbd_proc_data+0x99>
  1009bd:	81 fe e9 00 00 00    	cmp    $0xe9,%esi
  1009c3:	0f 84 8f 00 00 00    	je     100a58 <kbd_proc_data+0x128>
        dprintf("Rebooting!\n");
        outb(0x92, 0x3);  // courtesy of Chris Frost
    }

    return c;
}
  1009c9:	83 c4 04             	add    $0x4,%esp
  1009cc:	89 f0                	mov    %esi,%eax
  1009ce:	5b                   	pop    %ebx
  1009cf:	5e                   	pop    %esi
  1009d0:	c3                   	ret    
  1009d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if ('a' <= c && c <= 'z')
  1009d8:	8d 46 9f             	lea    -0x61(%esi),%eax
  1009db:	83 f8 19             	cmp    $0x19,%eax
  1009de:	77 60                	ja     100a40 <kbd_proc_data+0x110>
            c += 'A' - 'a';
  1009e0:	83 ee 20             	sub    $0x20,%esi
}
  1009e3:	83 c4 04             	add    $0x4,%esp
  1009e6:	89 f0                	mov    %esi,%eax
  1009e8:	5b                   	pop    %ebx
  1009e9:	5e                   	pop    %esi
  1009ea:	c3                   	ret    
  1009eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1009ef:	90                   	nop
        shift |= E0ESC;
  1009f0:	83 8b 44 76 02 00 40 	orl    $0x40,0x27644(%ebx)
        return 0;
  1009f7:	31 f6                	xor    %esi,%esi
}
  1009f9:	83 c4 04             	add    $0x4,%esp
  1009fc:	89 f0                	mov    %esi,%eax
  1009fe:	5b                   	pop    %ebx
  1009ff:	5e                   	pop    %esi
  100a00:	c3                   	ret    
  100a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        data = (shift & E0ESC ? data : data & 0x7F);
  100a08:	89 c6                	mov    %eax,%esi
  100a0a:	83 e6 7f             	and    $0x7f,%esi
  100a0d:	85 d2                	test   %edx,%edx
  100a0f:	0f 44 c6             	cmove  %esi,%eax
        return 0;
  100a12:	31 f6                	xor    %esi,%esi
        shift &= ~(shiftcode[data] | E0ESC);
  100a14:	0f b6 c0             	movzbl %al,%eax
  100a17:	0f b6 84 03 40 91 ff 	movzbl -0x6ec0(%ebx,%eax,1),%eax
  100a1e:	ff 
  100a1f:	83 c8 40             	or     $0x40,%eax
  100a22:	0f b6 c0             	movzbl %al,%eax
  100a25:	f7 d0                	not    %eax
  100a27:	21 c8                	and    %ecx,%eax
  100a29:	89 83 44 76 02 00    	mov    %eax,0x27644(%ebx)
}
  100a2f:	83 c4 04             	add    $0x4,%esp
  100a32:	89 f0                	mov    %esi,%eax
  100a34:	5b                   	pop    %ebx
  100a35:	5e                   	pop    %esi
  100a36:	c3                   	ret    
  100a37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100a3e:	66 90                	xchg   %ax,%ax
        else if ('A' <= c && c <= 'Z')
  100a40:	8d 4e bf             	lea    -0x41(%esi),%ecx
            c += 'a' - 'A';
  100a43:	8d 46 20             	lea    0x20(%esi),%eax
  100a46:	83 f9 1a             	cmp    $0x1a,%ecx
  100a49:	0f 42 f0             	cmovb  %eax,%esi
  100a4c:	e9 65 ff ff ff       	jmp    1009b6 <kbd_proc_data+0x86>
  100a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        dprintf("Rebooting!\n");
  100a58:	83 ec 0c             	sub    $0xc,%esp
  100a5b:	8d 83 1e 90 ff ff    	lea    -0x6fe2(%ebx),%eax
  100a61:	50                   	push   %eax
  100a62:	e8 d9 37 00 00       	call   104240 <dprintf>
        outb(0x92, 0x3);  // courtesy of Chris Frost
  100a67:	58                   	pop    %eax
  100a68:	5a                   	pop    %edx
  100a69:	6a 03                	push   $0x3
  100a6b:	68 92 00 00 00       	push   $0x92
  100a70:	e8 bb 43 00 00       	call   104e30 <outb>
  100a75:	83 c4 10             	add    $0x10,%esp
  100a78:	e9 4c ff ff ff       	jmp    1009c9 <kbd_proc_data+0x99>
  100a7d:	8d 76 00             	lea    0x0(%esi),%esi
        return -1;
  100a80:	be ff ff ff ff       	mov    $0xffffffff,%esi
  100a85:	e9 3f ff ff ff       	jmp    1009c9 <kbd_proc_data+0x99>
  100a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100a90 <keyboard_intr>:

void keyboard_intr(void)
{
  100a90:	53                   	push   %ebx
  100a91:	e8 f3 f8 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  100a96:	81 c3 6a f5 00 00    	add    $0xf56a,%ebx
  100a9c:	83 ec 14             	sub    $0x14,%esp
    cons_intr(kbd_proc_data);
  100a9f:	8d 83 30 09 ff ff    	lea    -0xf6d0(%ebx),%eax
  100aa5:	50                   	push   %eax
  100aa6:	e8 25 f9 ff ff       	call   1003d0 <cons_intr>
}
  100aab:	83 c4 18             	add    $0x18,%esp
  100aae:	5b                   	pop    %ebx
  100aaf:	c3                   	ret    

00100ab0 <devinit>:
#include "tsc.h"

void intr_init(void);

void devinit(uintptr_t mbi_addr)
{
  100ab0:	56                   	push   %esi
  100ab1:	53                   	push   %ebx
  100ab2:	e8 d2 f8 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  100ab7:	81 c3 49 f5 00 00    	add    $0xf549,%ebx
  100abd:	83 ec 10             	sub    $0x10,%esp
  100ac0:	8b 74 24 1c          	mov    0x1c(%esp),%esi
    seg_init(0);
  100ac4:	6a 00                	push   $0x0
  100ac6:	e8 05 3e 00 00       	call   1048d0 <seg_init>

    enable_sse();
  100acb:	e8 e0 41 00 00       	call   104cb0 <enable_sse>

    cons_init();
  100ad0:	e8 bb f8 ff ff       	call   100390 <cons_init>

    debug_init();
  100ad5:	e8 d6 34 00 00       	call   103fb0 <debug_init>
    KERN_INFO("[BSP KERN] cons initialized.\n");
  100ada:	8d 83 40 92 ff ff    	lea    -0x6dc0(%ebx),%eax
  100ae0:	89 04 24             	mov    %eax,(%esp)
  100ae3:	e8 d8 34 00 00       	call   103fc0 <debug_info>
    KERN_INFO("[BSP KERN] devinit mbi_addr: %d\n", mbi_addr);
  100ae8:	58                   	pop    %eax
  100ae9:	8d 83 10 93 ff ff    	lea    -0x6cf0(%ebx),%eax
  100aef:	5a                   	pop    %edx
  100af0:	56                   	push   %esi
  100af1:	50                   	push   %eax
  100af2:	e8 c9 34 00 00       	call   103fc0 <debug_info>

    /* pcpu init codes */
    pcpu_init();
  100af7:	e8 c4 50 00 00       	call   105bc0 <pcpu_init>
    KERN_INFO("[BSP KERN] PCPU initialized\n");
  100afc:	8d 83 5e 92 ff ff    	lea    -0x6da2(%ebx),%eax
  100b02:	89 04 24             	mov    %eax,(%esp)
  100b05:	e8 b6 34 00 00       	call   103fc0 <debug_info>

    tsc_init();
  100b0a:	e8 81 11 00 00       	call   101c90 <tsc_init>
    KERN_INFO("[BSP KERN] TSC initialized\n");
  100b0f:	8d 83 7b 92 ff ff    	lea    -0x6d85(%ebx),%eax
  100b15:	89 04 24             	mov    %eax,(%esp)
  100b18:	e8 a3 34 00 00       	call   103fc0 <debug_info>

    intr_init();
  100b1d:	e8 ce 06 00 00       	call   1011f0 <intr_init>
    KERN_INFO("[BSP KERN] INTR initialized\n");
  100b22:	8d 83 97 92 ff ff    	lea    -0x6d69(%ebx),%eax
  100b28:	89 04 24             	mov    %eax,(%esp)
  100b2b:	e8 90 34 00 00       	call   103fc0 <debug_info>

    trap_init(0);
  100b30:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100b37:	e8 04 74 00 00       	call   107f40 <trap_init>

    pmmap_init(mbi_addr);
  100b3c:	89 34 24             	mov    %esi,(%esp)
  100b3f:	e8 3c 01 00 00       	call   100c80 <pmmap_init>
}
  100b44:	83 c4 14             	add    $0x14,%esp
  100b47:	5b                   	pop    %ebx
  100b48:	5e                   	pop    %esi
  100b49:	c3                   	ret    
  100b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100b50 <devinit_ap>:

void devinit_ap(void)
{
  100b50:	56                   	push   %esi
  100b51:	53                   	push   %ebx
  100b52:	e8 32 f8 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  100b57:	81 c3 a9 f4 00 00    	add    $0xf4a9,%ebx
  100b5d:	83 ec 04             	sub    $0x4,%esp
    /* Figure out the current (booting) kernel stack) */
    struct kstack *ks = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  100b60:	e8 7b 40 00 00       	call   104be0 <read_esp>

    KERN_ASSERT(ks != NULL);
  100b65:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  100b6a:	89 c6                	mov    %eax,%esi
  100b6c:	74 6a                	je     100bd8 <devinit_ap+0x88>
    KERN_ASSERT(1 <= ks->cpu_idx && ks->cpu_idx < 8);
  100b6e:	8b 86 1c 01 00 00    	mov    0x11c(%esi),%eax
  100b74:	8d 50 ff             	lea    -0x1(%eax),%edx
  100b77:	83 fa 06             	cmp    $0x6,%edx
  100b7a:	0f 87 89 00 00 00    	ja     100c09 <devinit_ap+0xb9>

    /* kernel stack for this cpu initialized */
    seg_init(ks->cpu_idx);
  100b80:	83 ec 0c             	sub    $0xc,%esp
  100b83:	50                   	push   %eax
  100b84:	e8 47 3d 00 00       	call   1048d0 <seg_init>

    pcpu_init();
  100b89:	e8 32 50 00 00       	call   105bc0 <pcpu_init>
    KERN_INFO("[AP%d KERN] PCPU initialized\n", ks->cpu_idx);
  100b8e:	58                   	pop    %eax
  100b8f:	8d 83 ef 92 ff ff    	lea    -0x6d11(%ebx),%eax
  100b95:	5a                   	pop    %edx
  100b96:	ff b6 1c 01 00 00    	push   0x11c(%esi)
  100b9c:	50                   	push   %eax
  100b9d:	e8 1e 34 00 00       	call   103fc0 <debug_info>

    intr_init();
  100ba2:	e8 49 06 00 00       	call   1011f0 <intr_init>
    KERN_INFO("[AP%d KERN] INTR initialized.\n", ks->cpu_idx);
  100ba7:	59                   	pop    %ecx
  100ba8:	58                   	pop    %eax
  100ba9:	8d 83 58 93 ff ff    	lea    -0x6ca8(%ebx),%eax
  100baf:	ff b6 1c 01 00 00    	push   0x11c(%esi)
  100bb5:	50                   	push   %eax
  100bb6:	e8 05 34 00 00       	call   103fc0 <debug_info>

    trap_init(ks->cpu_idx);
  100bbb:	58                   	pop    %eax
  100bbc:	ff b6 1c 01 00 00    	push   0x11c(%esi)
  100bc2:	e8 79 73 00 00       	call   107f40 <trap_init>

    paging_init_ap();
  100bc7:	e8 a4 60 00 00       	call   106c70 <paging_init_ap>
}
  100bcc:	83 c4 14             	add    $0x14,%esp
  100bcf:	5b                   	pop    %ebx
  100bd0:	5e                   	pop    %esi
  100bd1:	c3                   	ret    
  100bd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    KERN_ASSERT(ks != NULL);
  100bd8:	8d 83 b4 92 ff ff    	lea    -0x6d4c(%ebx),%eax
  100bde:	50                   	push   %eax
  100bdf:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  100be5:	50                   	push   %eax
  100be6:	8d 83 dc 92 ff ff    	lea    -0x6d24(%ebx),%eax
  100bec:	6a 31                	push   $0x31
  100bee:	50                   	push   %eax
  100bef:	e8 3c 34 00 00       	call   104030 <debug_panic>
    KERN_ASSERT(1 <= ks->cpu_idx && ks->cpu_idx < 8);
  100bf4:	8b 86 1c 01 00 00    	mov    0x11c(%esi),%eax
    KERN_ASSERT(ks != NULL);
  100bfa:	83 c4 10             	add    $0x10,%esp
    KERN_ASSERT(1 <= ks->cpu_idx && ks->cpu_idx < 8);
  100bfd:	8d 50 ff             	lea    -0x1(%eax),%edx
  100c00:	83 fa 06             	cmp    $0x6,%edx
  100c03:	0f 86 77 ff ff ff    	jbe    100b80 <devinit_ap+0x30>
  100c09:	8d 83 34 93 ff ff    	lea    -0x6ccc(%ebx),%eax
  100c0f:	50                   	push   %eax
  100c10:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  100c16:	50                   	push   %eax
  100c17:	8d 83 dc 92 ff ff    	lea    -0x6d24(%ebx),%eax
  100c1d:	6a 32                	push   $0x32
  100c1f:	50                   	push   %eax
  100c20:	e8 0b 34 00 00       	call   104030 <debug_panic>
    seg_init(ks->cpu_idx);
  100c25:	8b 86 1c 01 00 00    	mov    0x11c(%esi),%eax
  100c2b:	83 c4 10             	add    $0x10,%esp
  100c2e:	e9 4d ff ff ff       	jmp    100b80 <devinit_ap+0x30>
  100c33:	66 90                	xchg   %ax,%ax
  100c35:	66 90                	xchg   %ax,%ax
  100c37:	66 90                	xchg   %ax,%ax
  100c39:	66 90                	xchg   %ax,%ax
  100c3b:	66 90                	xchg   %ax,%ax
  100c3d:	66 90                	xchg   %ax,%ax
  100c3f:	90                   	nop

00100c40 <pmmap_alloc_slot>:
    if (unlikely(pmmap_slots_next_free == 128))
  100c40:	e8 40 f7 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  100c45:	81 c2 bb f3 00 00    	add    $0xf3bb,%edx
  100c4b:	8b 82 7c 76 02 00    	mov    0x2767c(%edx),%eax
  100c51:	3d 80 00 00 00       	cmp    $0x80,%eax
  100c56:	74 18                	je     100c70 <pmmap_alloc_slot+0x30>
    return &pmmap_slots[pmmap_slots_next_free++];
  100c58:	8d 48 01             	lea    0x1(%eax),%ecx
  100c5b:	8d 04 80             	lea    (%eax,%eax,4),%eax
  100c5e:	89 8a 7c 76 02 00    	mov    %ecx,0x2767c(%edx)
  100c64:	8d 84 82 80 76 02 00 	lea    0x27680(%edx,%eax,4),%eax
  100c6b:	c3                   	ret    
  100c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return NULL;
  100c70:	31 c0                	xor    %eax,%eax
}
  100c72:	c3                   	ret    
  100c73:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100c80 <pmmap_init>:
{
  100c80:	55                   	push   %ebp
  100c81:	e8 63 05 00 00       	call   1011e9 <__x86.get_pc_thunk.bp>
  100c86:	81 c5 7a f3 00 00    	add    $0xf37a,%ebp
  100c8c:	57                   	push   %edi
  100c8d:	56                   	push   %esi
  100c8e:	53                   	push   %ebx
  100c8f:	83 ec 48             	sub    $0x48,%esp
    KERN_INFO("\n");
  100c92:	8d 85 23 a6 ff ff    	lea    -0x59dd(%ebp),%eax
{
  100c98:	8b 74 24 5c          	mov    0x5c(%esp),%esi
    KERN_INFO("\n");
  100c9c:	89 eb                	mov    %ebp,%ebx
  100c9e:	50                   	push   %eax
  100c9f:	e8 1c 33 00 00       	call   103fc0 <debug_info>
    while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100ca4:	8b 5e 2c             	mov    0x2c(%esi),%ebx
    mboot_mmap_t *p = (mboot_mmap_t *) mbi->mmap_addr;
  100ca7:	8b 46 30             	mov    0x30(%esi),%eax
    SLIST_INIT(&pmmap_list);
  100caa:	c7 85 78 76 02 00 00 	movl   $0x0,0x27678(%ebp)
  100cb1:	00 00 00 
    SLIST_INIT(&pmmap_sublist[PMMAP_USABLE]);
  100cb4:	c7 85 68 76 02 00 00 	movl   $0x0,0x27668(%ebp)
  100cbb:	00 00 00 
    while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100cbe:	89 5c 24 24          	mov    %ebx,0x24(%esp)
  100cc2:	83 c4 10             	add    $0x10,%esp
    SLIST_INIT(&pmmap_sublist[PMMAP_RESV]);
  100cc5:	c7 85 6c 76 02 00 00 	movl   $0x0,0x2766c(%ebp)
  100ccc:	00 00 00 
    SLIST_INIT(&pmmap_sublist[PMMAP_ACPI]);
  100ccf:	c7 85 70 76 02 00 00 	movl   $0x0,0x27670(%ebp)
  100cd6:	00 00 00 
    SLIST_INIT(&pmmap_sublist[PMMAP_NVS]);
  100cd9:	c7 85 74 76 02 00 00 	movl   $0x0,0x27674(%ebp)
  100ce0:	00 00 00 
    while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100ce3:	85 db                	test   %ebx,%ebx
  100ce5:	0f 84 9f 02 00 00    	je     100f8a <pmmap_init+0x30a>
  100ceb:	ba e8 ff ff ff       	mov    $0xffffffe8,%edx
  100cf0:	31 ff                	xor    %edi,%edi
  100cf2:	c6 44 24 1f 00       	movb   $0x0,0x1f(%esp)
  100cf7:	8d 58 18             	lea    0x18(%eax),%ebx
  100cfa:	29 c2                	sub    %eax,%edx
  100cfc:	89 7c 24 10          	mov    %edi,0x10(%esp)
  100d00:	8b b5 7c 76 02 00    	mov    0x2767c(%ebp),%esi
  100d06:	c6 44 24 04 00       	movb   $0x0,0x4(%esp)
  100d0b:	89 54 24 18          	mov    %edx,0x18(%esp)
  100d0f:	90                   	nop
        uintptr_t start, end;
        uint32_t type;

        if (p->base_addr_high != 0)  /* ignore address above 4G */
  100d10:	8b 78 08             	mov    0x8(%eax),%edi
  100d13:	85 ff                	test   %edi,%edi
  100d15:	0f 85 b8 00 00 00    	jne    100dd3 <pmmap_init+0x153>
            goto next;
        else
            start = p->base_addr_low;

        if (p->length_high != 0 || p->length_low >= 0xffffffff - start)
  100d1b:	8b 48 10             	mov    0x10(%eax),%ecx
            start = p->base_addr_low;
  100d1e:	8b 50 04             	mov    0x4(%eax),%edx
            end = 0xffffffff;
  100d21:	c7 04 24 ff ff ff ff 	movl   $0xffffffff,(%esp)
        if (p->length_high != 0 || p->length_low >= 0xffffffff - start)
  100d28:	85 c9                	test   %ecx,%ecx
  100d2a:	75 13                	jne    100d3f <pmmap_init+0xbf>
        else
            end = start + p->length_low;
  100d2c:	8b 78 0c             	mov    0xc(%eax),%edi
  100d2f:	89 d1                	mov    %edx,%ecx
  100d31:	f7 d1                	not    %ecx
  100d33:	01 d7                	add    %edx,%edi
  100d35:	39 48 0c             	cmp    %ecx,0xc(%eax)
  100d38:	0f 43 3c 24          	cmovae (%esp),%edi
  100d3c:	89 3c 24             	mov    %edi,(%esp)

        type = p->type;
  100d3f:	8b 78 14             	mov    0x14(%eax),%edi
    if (unlikely(pmmap_slots_next_free == 128))
  100d42:	81 fe 80 00 00 00    	cmp    $0x80,%esi
  100d48:	0f 84 b2 f2 ff ff    	je     100000 <pmmap_init.cold>
    return &pmmap_slots[pmmap_slots_next_free++];
  100d4e:	8d 46 01             	lea    0x1(%esi),%eax
  100d51:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d55:	8d 04 b6             	lea    (%esi,%esi,4),%eax
  100d58:	c1 e0 02             	shl    $0x2,%eax
  100d5b:	8d 8c 05 80 76 02 00 	lea    0x27680(%ebp,%eax,1),%ecx
    free_slot->end = end;
  100d62:	8d 84 05 80 76 02 00 	lea    0x27680(%ebp,%eax,1),%eax
    return &pmmap_slots[pmmap_slots_next_free++];
  100d69:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    free_slot->start = start;
  100d6d:	89 11                	mov    %edx,(%ecx)
    free_slot->end = end;
  100d6f:	8d 0d 80 76 02 00    	lea    0x27680,%ecx
  100d75:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100d79:	8b 0c 24             	mov    (%esp),%ecx
    free_slot->type = type;
  100d7c:	89 78 08             	mov    %edi,0x8(%eax)
    free_slot->end = end;
  100d7f:	89 48 04             	mov    %ecx,0x4(%eax)
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100d82:	8b 44 24 10          	mov    0x10(%esp),%eax
  100d86:	85 c0                	test   %eax,%eax
  100d88:	0f 84 22 02 00 00    	je     100fb0 <pmmap_init+0x330>
    last_slot = NULL;
  100d8e:	31 ff                	xor    %edi,%edi
  100d90:	eb 11                	jmp    100da3 <pmmap_init+0x123>
  100d92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100d98:	8b 48 0c             	mov    0xc(%eax),%ecx
  100d9b:	89 c7                	mov    %eax,%edi
  100d9d:	85 c9                	test   %ecx,%ecx
  100d9f:	74 13                	je     100db4 <pmmap_init+0x134>
  100da1:	89 c8                	mov    %ecx,%eax
        if (start < slot->start)
  100da3:	3b 10                	cmp    (%eax),%edx
  100da5:	73 f1                	jae    100d98 <pmmap_init+0x118>
    if (last_slot == NULL) {
  100da7:	85 ff                	test   %edi,%edi
  100da9:	0f 84 01 02 00 00    	je     100fb0 <pmmap_init+0x330>
        SLIST_INSERT_AFTER(last_slot, free_slot, next);
  100daf:	8b 4f 0c             	mov    0xc(%edi),%ecx
  100db2:	89 f8                	mov    %edi,%eax
  100db4:	8d 14 b6             	lea    (%esi,%esi,4),%edx
  100db7:	8b 74 24 0c          	mov    0xc(%esp),%esi
  100dbb:	8d 54 95 00          	lea    0x0(%ebp,%edx,4),%edx
  100dbf:	89 4c 16 0c          	mov    %ecx,0xc(%esi,%edx,1)
  100dc3:	8b 74 24 08          	mov    0x8(%esp),%esi
  100dc7:	89 70 0c             	mov    %esi,0xc(%eax)
    return &pmmap_slots[pmmap_slots_next_free++];
  100dca:	8b 74 24 04          	mov    0x4(%esp),%esi
        SLIST_INSERT_AFTER(last_slot, free_slot, next);
  100dce:	c6 44 24 04 01       	movb   $0x1,0x4(%esp)
    while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100dd3:	8b 7c 24 18          	mov    0x18(%esp),%edi

        pmmap_insert(start, end, type);

      next:
        p = (mboot_mmap_t *) (((uint32_t) p) + sizeof(mboot_mmap_t) /* p->size */);
  100dd7:	89 d8                	mov    %ebx,%eax
    while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100dd9:	83 c3 18             	add    $0x18,%ebx
  100ddc:	8d 14 1f             	lea    (%edi,%ebx,1),%edx
  100ddf:	39 54 24 14          	cmp    %edx,0x14(%esp)
  100de3:	0f 87 27 ff ff ff    	ja     100d10 <pmmap_init+0x90>
  100de9:	80 7c 24 1f 00       	cmpb   $0x0,0x1f(%esp)
  100dee:	8b 7c 24 10          	mov    0x10(%esp),%edi
  100df2:	0f 84 48 02 00 00    	je     101040 <pmmap_init+0x3c0>
  100df8:	80 7c 24 04 00       	cmpb   $0x0,0x4(%esp)
  100dfd:	89 bd 78 76 02 00    	mov    %edi,0x27678(%ebp)
  100e03:	0f 85 44 02 00 00    	jne    10104d <pmmap_init+0x3cd>
    struct pmmap *last_slot[4] = { NULL, NULL, NULL, NULL };
  100e09:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%esp)
  100e10:	00 
  100e11:	c7 44 24 24 00 00 00 	movl   $0x0,0x24(%esp)
  100e18:	00 
  100e19:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
  100e20:	00 
  100e21:	c7 44 24 2c 00 00 00 	movl   $0x0,0x2c(%esp)
  100e28:	00 
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100e29:	85 ff                	test   %edi,%edi
  100e2b:	0f 84 59 01 00 00    	je     100f8a <pmmap_init+0x30a>
        if ((next_slot = SLIST_NEXT(slot, next)) == NULL)
  100e31:	8b 47 0c             	mov    0xc(%edi),%eax
  100e34:	85 c0                	test   %eax,%eax
  100e36:	74 2a                	je     100e62 <pmmap_init+0x1e2>
  100e38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100e3f:	90                   	nop
        if (slot->start <= next_slot->start &&
  100e40:	8b 10                	mov    (%eax),%edx
  100e42:	39 17                	cmp    %edx,(%edi)
  100e44:	77 13                	ja     100e59 <pmmap_init+0x1d9>
            slot->end >= next_slot->start &&
  100e46:	8b 4f 04             	mov    0x4(%edi),%ecx
        if (slot->start <= next_slot->start &&
  100e49:	39 ca                	cmp    %ecx,%edx
  100e4b:	77 0c                	ja     100e59 <pmmap_init+0x1d9>
            slot->end >= next_slot->start &&
  100e4d:	8b 58 08             	mov    0x8(%eax),%ebx
  100e50:	39 5f 08             	cmp    %ebx,0x8(%edi)
  100e53:	0f 84 b2 01 00 00    	je     10100b <pmmap_init+0x38b>
    while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100e59:	89 c7                	mov    %eax,%edi
        if ((next_slot = SLIST_NEXT(slot, next)) == NULL)
  100e5b:	8b 47 0c             	mov    0xc(%edi),%eax
  100e5e:	85 c0                	test   %eax,%eax
  100e60:	75 de                	jne    100e40 <pmmap_init+0x1c0>
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100e62:	8b b5 78 76 02 00    	mov    0x27678(%ebp),%esi
  100e68:	85 f6                	test   %esi,%esi
  100e6a:	0f 84 1a 01 00 00    	je     100f8a <pmmap_init+0x30a>
            SLIST_INSERT_HEAD(&pmmap_sublist[sublist_nr], slot, type_next);
  100e70:	8d bd 68 76 02 00    	lea    0x27668(%ebp),%edi
  100e76:	eb 1c                	jmp    100e94 <pmmap_init+0x214>
  100e78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100e7f:	90                   	nop
            SLIST_INSERT_AFTER(last_slot[sublist_nr], slot, type_next);
  100e80:	8b 4a 10             	mov    0x10(%edx),%ecx
        last_slot[sublist_nr] = slot;
  100e83:	89 74 84 20          	mov    %esi,0x20(%esp,%eax,4)
            SLIST_INSERT_AFTER(last_slot[sublist_nr], slot, type_next);
  100e87:	89 4e 10             	mov    %ecx,0x10(%esi)
  100e8a:	89 72 10             	mov    %esi,0x10(%edx)
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100e8d:	8b 76 0c             	mov    0xc(%esi),%esi
  100e90:	85 f6                	test   %esi,%esi
  100e92:	74 35                	je     100ec9 <pmmap_init+0x249>
        sublist_nr = PMMAP_SUBLIST_NR(slot->type);
  100e94:	8b 56 08             	mov    0x8(%esi),%edx
  100e97:	31 c0                	xor    %eax,%eax
  100e99:	83 fa 01             	cmp    $0x1,%edx
  100e9c:	74 0f                	je     100ead <pmmap_init+0x22d>
  100e9e:	8d 42 fe             	lea    -0x2(%edx),%eax
  100ea1:	83 f8 02             	cmp    $0x2,%eax
  100ea4:	0f 87 36 01 00 00    	ja     100fe0 <pmmap_init+0x360>
  100eaa:	8d 42 ff             	lea    -0x1(%edx),%eax
        if (last_slot[sublist_nr] != NULL)
  100ead:	8b 54 84 20          	mov    0x20(%esp,%eax,4),%edx
  100eb1:	85 d2                	test   %edx,%edx
  100eb3:	75 cb                	jne    100e80 <pmmap_init+0x200>
            SLIST_INSERT_HEAD(&pmmap_sublist[sublist_nr], slot, type_next);
  100eb5:	8b 14 87             	mov    (%edi,%eax,4),%edx
        last_slot[sublist_nr] = slot;
  100eb8:	89 74 84 20          	mov    %esi,0x20(%esp,%eax,4)
            SLIST_INSERT_HEAD(&pmmap_sublist[sublist_nr], slot, type_next);
  100ebc:	89 34 87             	mov    %esi,(%edi,%eax,4)
  100ebf:	89 56 10             	mov    %edx,0x10(%esi)
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100ec2:	8b 76 0c             	mov    0xc(%esi),%esi
  100ec5:	85 f6                	test   %esi,%esi
  100ec7:	75 cb                	jne    100e94 <pmmap_init+0x214>
    if (last_slot[PMMAP_USABLE] != NULL)
  100ec9:	8b 44 24 20          	mov    0x20(%esp),%eax
  100ecd:	85 c0                	test   %eax,%eax
  100ecf:	74 09                	je     100eda <pmmap_init+0x25a>
        max_usable_memory = last_slot[PMMAP_USABLE]->end;
  100ed1:	8b 40 04             	mov    0x4(%eax),%eax
  100ed4:	89 85 64 76 02 00    	mov    %eax,0x27664(%ebp)
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100eda:	8b bd 78 76 02 00    	mov    0x27678(%ebp),%edi
  100ee0:	85 ff                	test   %edi,%edi
  100ee2:	0f 84 a2 00 00 00    	je     100f8a <pmmap_init+0x30a>
        KERN_INFO("BIOS-e820: 0x%08x - 0x%08x (%s)\n",
  100ee8:	8d 85 77 93 ff ff    	lea    -0x6c89(%ebp),%eax
  100eee:	8d b5 e4 93 ff ff    	lea    -0x6c1c(%ebp),%esi
  100ef4:	89 04 24             	mov    %eax,(%esp)
  100ef7:	8d 85 8f 93 ff ff    	lea    -0x6c71(%ebp),%eax
  100efd:	89 44 24 04          	mov    %eax,0x4(%esp)
  100f01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100f08:	8b 57 08             	mov    0x8(%edi),%edx
  100f0b:	8b 04 24             	mov    (%esp),%eax
  100f0e:	83 fa 01             	cmp    $0x1,%edx
  100f11:	74 26                	je     100f39 <pmmap_init+0x2b9>
  100f13:	8b 44 24 04          	mov    0x4(%esp),%eax
  100f17:	83 fa 03             	cmp    $0x3,%edx
  100f1a:	74 1d                	je     100f39 <pmmap_init+0x2b9>
  100f1c:	8d 85 99 93 ff ff    	lea    -0x6c67(%ebp),%eax
  100f22:	83 fa 04             	cmp    $0x4,%edx
  100f25:	74 12                	je     100f39 <pmmap_init+0x2b9>
  100f27:	83 fa 02             	cmp    $0x2,%edx
  100f2a:	8d 85 7e 93 ff ff    	lea    -0x6c82(%ebp),%eax
  100f30:	8d 95 86 93 ff ff    	lea    -0x6c7a(%ebp),%edx
  100f36:	0f 44 c2             	cmove  %edx,%eax
  100f39:	8b 0f                	mov    (%edi),%ecx
  100f3b:	8b 57 04             	mov    0x4(%edi),%edx
  100f3e:	39 d1                	cmp    %edx,%ecx
  100f40:	74 0a                	je     100f4c <pmmap_init+0x2cc>
  100f42:	31 db                	xor    %ebx,%ebx
  100f44:	83 fa ff             	cmp    $0xffffffff,%edx
  100f47:	0f 95 c3             	setne  %bl
  100f4a:	29 da                	sub    %ebx,%edx
  100f4c:	50                   	push   %eax
  100f4d:	89 eb                	mov    %ebp,%ebx
  100f4f:	52                   	push   %edx
  100f50:	51                   	push   %ecx
  100f51:	56                   	push   %esi
  100f52:	e8 69 30 00 00       	call   103fc0 <debug_info>
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100f57:	8b 7f 0c             	mov    0xc(%edi),%edi
  100f5a:	83 c4 10             	add    $0x10,%esp
  100f5d:	85 ff                	test   %edi,%edi
  100f5f:	75 a7                	jne    100f08 <pmmap_init+0x288>
    pmmap_merge();
    pmmap_dump();

    /* count the number of pmmap entries */
    struct pmmap *slot;
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100f61:	8b 95 78 76 02 00    	mov    0x27678(%ebp),%edx
  100f67:	85 d2                	test   %edx,%edx
  100f69:	74 1f                	je     100f8a <pmmap_init+0x30a>
  100f6b:	8b 85 60 76 02 00    	mov    0x27660(%ebp),%eax
  100f71:	83 c0 01             	add    $0x1,%eax
  100f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100f78:	8b 52 0c             	mov    0xc(%edx),%edx
        pmmap_nentries++;
  100f7b:	89 c1                	mov    %eax,%ecx
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100f7d:	83 c0 01             	add    $0x1,%eax
  100f80:	85 d2                	test   %edx,%edx
  100f82:	75 f4                	jne    100f78 <pmmap_init+0x2f8>
  100f84:	89 8d 60 76 02 00    	mov    %ecx,0x27660(%ebp)
    }

    /* Calculate the maximum page number */
    mem_npages = rounddown(max_usable_memory, PAGESIZE) / PAGESIZE;
  100f8a:	83 ec 08             	sub    $0x8,%esp
  100f8d:	89 eb                	mov    %ebp,%ebx
  100f8f:	68 00 10 00 00       	push   $0x1000
  100f94:	ff b5 64 76 02 00    	push   0x27664(%ebp)
  100f9a:	e8 01 3c 00 00       	call   104ba0 <rounddown>
}
  100f9f:	83 c4 4c             	add    $0x4c,%esp
  100fa2:	5b                   	pop    %ebx
  100fa3:	5e                   	pop    %esi
  100fa4:	5f                   	pop    %edi
  100fa5:	5d                   	pop    %ebp
  100fa6:	c3                   	ret    
  100fa7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100fae:	66 90                	xchg   %ax,%ax
        SLIST_INSERT_HEAD(&pmmap_list, free_slot, next);
  100fb0:	8b 7c 24 10          	mov    0x10(%esp),%edi
  100fb4:	8d 04 b6             	lea    (%esi,%esi,4),%eax
  100fb7:	8b 74 24 0c          	mov    0xc(%esp),%esi
  100fbb:	c6 44 24 1f 01       	movb   $0x1,0x1f(%esp)
  100fc0:	8d 44 85 00          	lea    0x0(%ebp,%eax,4),%eax
  100fc4:	89 7c 06 0c          	mov    %edi,0xc(%esi,%eax,1)
  100fc8:	8b 44 24 08          	mov    0x8(%esp),%eax
    return &pmmap_slots[pmmap_slots_next_free++];
  100fcc:	8b 74 24 04          	mov    0x4(%esp),%esi
  100fd0:	c6 44 24 04 01       	movb   $0x1,0x4(%esp)
        SLIST_INSERT_HEAD(&pmmap_list, free_slot, next);
  100fd5:	89 44 24 10          	mov    %eax,0x10(%esp)
  100fd9:	e9 f5 fd ff ff       	jmp    100dd3 <pmmap_init+0x153>
  100fde:	66 90                	xchg   %ax,%ax
        KERN_ASSERT(sublist_nr != -1);
  100fe0:	8d 85 d0 93 ff ff    	lea    -0x6c30(%ebp),%eax
  100fe6:	89 eb                	mov    %ebp,%ebx
  100fe8:	50                   	push   %eax
  100fe9:	8d 85 bf 92 ff ff    	lea    -0x6d41(%ebp),%eax
  100fef:	50                   	push   %eax
  100ff0:	8d 85 bf 93 ff ff    	lea    -0x6c41(%ebp),%eax
  100ff6:	6a 6b                	push   $0x6b
  100ff8:	50                   	push   %eax
  100ff9:	e8 32 30 00 00       	call   104030 <debug_panic>
  100ffe:	83 c4 10             	add    $0x10,%esp
        sublist_nr = PMMAP_SUBLIST_NR(slot->type);
  101001:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101006:	e9 a2 fe ff ff       	jmp    100ead <pmmap_init+0x22d>
            slot->end = max(slot->end, next_slot->end);
  10100b:	83 ec 08             	sub    $0x8,%esp
  10100e:	ff 70 04             	push   0x4(%eax)
  101011:	89 eb                	mov    %ebp,%ebx
  101013:	51                   	push   %ecx
  101014:	e8 67 3b 00 00       	call   104b80 <max>
    SLIST_FOREACH(slot, &pmmap_list, next) {
  101019:	83 c4 10             	add    $0x10,%esp
            slot->end = max(slot->end, next_slot->end);
  10101c:	89 47 04             	mov    %eax,0x4(%edi)
            SLIST_REMOVE_AFTER(slot, next);
  10101f:	8b 47 0c             	mov    0xc(%edi),%eax
  101022:	8b 40 0c             	mov    0xc(%eax),%eax
  101025:	89 47 0c             	mov    %eax,0xc(%edi)
    SLIST_FOREACH(slot, &pmmap_list, next) {
  101028:	85 c0                	test   %eax,%eax
  10102a:	0f 84 32 fe ff ff    	je     100e62 <pmmap_init+0x1e2>
    while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  101030:	89 c7                	mov    %eax,%edi
  101032:	e9 24 fe ff ff       	jmp    100e5b <pmmap_init+0x1db>
  101037:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10103e:	66 90                	xchg   %ax,%ax
  101040:	31 ff                	xor    %edi,%edi
  101042:	80 7c 24 04 00       	cmpb   $0x0,0x4(%esp)
  101047:	0f 84 3d ff ff ff    	je     100f8a <pmmap_init+0x30a>
  10104d:	89 b5 7c 76 02 00    	mov    %esi,0x2767c(%ebp)
  101053:	e9 b1 fd ff ff       	jmp    100e09 <pmmap_init+0x189>
  101058:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10105f:	90                   	nop

00101060 <get_size>:

int get_size(void)
{
    return pmmap_nentries;
  101060:	e8 1c f3 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  101065:	05 9b ef 00 00       	add    $0xef9b,%eax
  10106a:	8b 80 60 76 02 00    	mov    0x27660(%eax),%eax
}
  101070:	c3                   	ret    
  101071:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101078:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10107f:	90                   	nop

00101080 <get_mms>:

uint32_t get_mms(int idx)
{
  101080:	53                   	push   %ebx
  101081:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  101085:	e8 ff f2 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10108a:	81 c3 76 ef 00 00    	add    $0xef76,%ebx
    int i = 0;
    struct pmmap *slot = NULL;

    SLIST_FOREACH(slot, &pmmap_list, next) {
  101090:	8b 83 78 76 02 00    	mov    0x27678(%ebx),%eax
  101096:	85 c0                	test   %eax,%eax
  101098:	74 1c                	je     1010b6 <get_mms+0x36>
    int i = 0;
  10109a:	31 d2                	xor    %edx,%edx
        if (i == idx)
  10109c:	85 c9                	test   %ecx,%ecx
  10109e:	75 0c                	jne    1010ac <get_mms+0x2c>
  1010a0:	eb 1e                	jmp    1010c0 <get_mms+0x40>
  1010a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1010a8:	39 d1                	cmp    %edx,%ecx
  1010aa:	74 14                	je     1010c0 <get_mms+0x40>
    SLIST_FOREACH(slot, &pmmap_list, next) {
  1010ac:	8b 40 0c             	mov    0xc(%eax),%eax
            break;
        i++;
  1010af:	83 c2 01             	add    $0x1,%edx
    SLIST_FOREACH(slot, &pmmap_list, next) {
  1010b2:	85 c0                	test   %eax,%eax
  1010b4:	75 f2                	jne    1010a8 <get_mms+0x28>
    }

    if (slot == NULL || i == pmmap_nentries)
        return 0;
  1010b6:	31 c9                	xor    %ecx,%ecx

    return slot->start;
}
  1010b8:	89 c8                	mov    %ecx,%eax
  1010ba:	5b                   	pop    %ebx
  1010bb:	c3                   	ret    
  1010bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return 0;
  1010c0:	31 c9                	xor    %ecx,%ecx
    if (slot == NULL || i == pmmap_nentries)
  1010c2:	39 93 60 76 02 00    	cmp    %edx,0x27660(%ebx)
  1010c8:	74 ee                	je     1010b8 <get_mms+0x38>
    return slot->start;
  1010ca:	8b 08                	mov    (%eax),%ecx
}
  1010cc:	5b                   	pop    %ebx
  1010cd:	89 c8                	mov    %ecx,%eax
  1010cf:	c3                   	ret    

001010d0 <get_mml>:

uint32_t get_mml(int idx)
{
  1010d0:	53                   	push   %ebx
  1010d1:	8b 44 24 08          	mov    0x8(%esp),%eax
  1010d5:	e8 af f2 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1010da:	81 c3 26 ef 00 00    	add    $0xef26,%ebx
    int i = 0;
    struct pmmap *slot = NULL;

    SLIST_FOREACH(slot, &pmmap_list, next) {
  1010e0:	8b 93 78 76 02 00    	mov    0x27678(%ebx),%edx
  1010e6:	85 d2                	test   %edx,%edx
  1010e8:	74 1c                	je     101106 <get_mml+0x36>
    int i = 0;
  1010ea:	31 c9                	xor    %ecx,%ecx
        if (i == idx)
  1010ec:	85 c0                	test   %eax,%eax
  1010ee:	75 0c                	jne    1010fc <get_mml+0x2c>
  1010f0:	eb 1e                	jmp    101110 <get_mml+0x40>
  1010f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1010f8:	39 c8                	cmp    %ecx,%eax
  1010fa:	74 14                	je     101110 <get_mml+0x40>
    SLIST_FOREACH(slot, &pmmap_list, next) {
  1010fc:	8b 52 0c             	mov    0xc(%edx),%edx
            break;
        i++;
  1010ff:	83 c1 01             	add    $0x1,%ecx
    SLIST_FOREACH(slot, &pmmap_list, next) {
  101102:	85 d2                	test   %edx,%edx
  101104:	75 f2                	jne    1010f8 <get_mml+0x28>
    }

    if (slot == NULL || i == pmmap_nentries)
        return 0;
  101106:	31 c0                	xor    %eax,%eax

    return slot->end - slot->start;
}
  101108:	5b                   	pop    %ebx
  101109:	c3                   	ret    
  10110a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return 0;
  101110:	31 c0                	xor    %eax,%eax
    if (slot == NULL || i == pmmap_nentries)
  101112:	39 8b 60 76 02 00    	cmp    %ecx,0x27660(%ebx)
  101118:	74 ee                	je     101108 <get_mml+0x38>
    return slot->end - slot->start;
  10111a:	8b 42 04             	mov    0x4(%edx),%eax
}
  10111d:	5b                   	pop    %ebx
    return slot->end - slot->start;
  10111e:	2b 02                	sub    (%edx),%eax
}
  101120:	c3                   	ret    
  101121:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101128:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10112f:	90                   	nop

00101130 <is_usable>:

int is_usable(int idx)
{
  101130:	53                   	push   %ebx
  101131:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  101135:	e8 4f f2 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10113a:	81 c3 c6 ee 00 00    	add    $0xeec6,%ebx
    int i = 0;
    struct pmmap *slot = NULL;

    SLIST_FOREACH(slot, &pmmap_list, next) {
  101140:	8b 83 78 76 02 00    	mov    0x27678(%ebx),%eax
  101146:	85 c0                	test   %eax,%eax
  101148:	74 1c                	je     101166 <is_usable+0x36>
    int i = 0;
  10114a:	31 d2                	xor    %edx,%edx
        if (i == idx)
  10114c:	85 c9                	test   %ecx,%ecx
  10114e:	75 0c                	jne    10115c <is_usable+0x2c>
  101150:	eb 1e                	jmp    101170 <is_usable+0x40>
  101152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101158:	39 d1                	cmp    %edx,%ecx
  10115a:	74 14                	je     101170 <is_usable+0x40>
    SLIST_FOREACH(slot, &pmmap_list, next) {
  10115c:	8b 40 0c             	mov    0xc(%eax),%eax
            break;
        i++;
  10115f:	83 c2 01             	add    $0x1,%edx
    SLIST_FOREACH(slot, &pmmap_list, next) {
  101162:	85 c0                	test   %eax,%eax
  101164:	75 f2                	jne    101158 <is_usable+0x28>
    }

    if (slot == NULL || i == pmmap_nentries)
        return 0;
  101166:	31 c9                	xor    %ecx,%ecx

    return slot->type == MEM_RAM;
}
  101168:	89 c8                	mov    %ecx,%eax
  10116a:	5b                   	pop    %ebx
  10116b:	c3                   	ret    
  10116c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return 0;
  101170:	31 c9                	xor    %ecx,%ecx
    if (slot == NULL || i == pmmap_nentries)
  101172:	39 93 60 76 02 00    	cmp    %edx,0x27660(%ebx)
  101178:	74 ee                	je     101168 <is_usable+0x38>
    return slot->type == MEM_RAM;
  10117a:	31 c9                	xor    %ecx,%ecx
  10117c:	83 78 08 01          	cmpl   $0x1,0x8(%eax)
}
  101180:	5b                   	pop    %ebx
    return slot->type == MEM_RAM;
  101181:	0f 94 c1             	sete   %cl
}
  101184:	89 c8                	mov    %ecx,%eax
  101186:	c3                   	ret    
  101187:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10118e:	66 90                	xchg   %ax,%ax

00101190 <set_cr3>:

void set_cr3(unsigned int **pdir)
{
  101190:	53                   	push   %ebx
  101191:	e8 f3 f1 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101196:	81 c3 6a ee 00 00    	add    $0xee6a,%ebx
  10119c:	83 ec 14             	sub    $0x14,%esp
    lcr3((uint32_t) pdir);
  10119f:	ff 74 24 1c          	push   0x1c(%esp)
  1011a3:	e8 28 3c 00 00       	call   104dd0 <lcr3>
}
  1011a8:	83 c4 18             	add    $0x18,%esp
  1011ab:	5b                   	pop    %ebx
  1011ac:	c3                   	ret    
  1011ad:	8d 76 00             	lea    0x0(%esi),%esi

001011b0 <enable_paging>:

void enable_paging(void)
{
  1011b0:	53                   	push   %ebx
  1011b1:	e8 d3 f1 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1011b6:	81 c3 4a ee 00 00    	add    $0xee4a,%ebx
  1011bc:	83 ec 08             	sub    $0x8,%esp
    /* enable global pages (Sec 4.10.2.4, Intel ASDM Vol3) */
    uint32_t cr4 = rcr4();
  1011bf:	e8 2c 3c 00 00       	call   104df0 <rcr4>
    cr4 |= CR4_PGE;
    lcr4(cr4);
  1011c4:	83 ec 0c             	sub    $0xc,%esp
    cr4 |= CR4_PGE;
  1011c7:	0c 80                	or     $0x80,%al
    lcr4(cr4);
  1011c9:	50                   	push   %eax
  1011ca:	e8 11 3c 00 00       	call   104de0 <lcr4>

    /* turn on paging */
    uint32_t cr0 = rcr0();
  1011cf:	e8 dc 3b 00 00       	call   104db0 <rcr0>
    cr0 |= CR0_PE | CR0_PG | CR0_AM | CR0_WP | CR0_NE | CR0_MP;
    cr0 &= ~(CR0_EM | CR0_TS);
  1011d4:	83 e0 f3             	and    $0xfffffff3,%eax
  1011d7:	0d 23 00 05 80       	or     $0x80050023,%eax
    lcr0(cr0);
  1011dc:	89 04 24             	mov    %eax,(%esp)
  1011df:	e8 bc 3b 00 00       	call   104da0 <lcr0>
}
  1011e4:	83 c4 18             	add    $0x18,%esp
  1011e7:	5b                   	pop    %ebx
  1011e8:	c3                   	ret    

001011e9 <__x86.get_pc_thunk.bp>:
  1011e9:	8b 2c 24             	mov    (%esp),%ebp
  1011ec:	c3                   	ret    
  1011ed:	66 90                	xchg   %ax,%ax
  1011ef:	90                   	nop

001011f0 <intr_init>:
{
    asm volatile ("lidt %0" :: "m" (idt_pd));
}

void intr_init(void)
{
  1011f0:	55                   	push   %ebp
  1011f1:	57                   	push   %edi
  1011f2:	56                   	push   %esi
  1011f3:	53                   	push   %ebx
  1011f4:	e8 90 f1 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1011f9:	81 c3 07 ee 00 00    	add    $0xee07,%ebx
  1011ff:	83 ec 38             	sub    $0x38,%esp
    uint32_t dummy, edx;

    cpuid(0x00000001, &dummy, &dummy, &dummy, &edx);
  101202:	8d 44 24 28          	lea    0x28(%esp),%eax
  101206:	50                   	push   %eax
  101207:	8d 44 24 28          	lea    0x28(%esp),%eax
  10120b:	50                   	push   %eax
  10120c:	50                   	push   %eax
  10120d:	50                   	push   %eax
  10120e:	6a 01                	push   $0x1
  101210:	e8 bb 3a 00 00       	call   104cd0 <cpuid>
    using_apic = (edx & CPUID_FEATURE_APIC) ? TRUE : FALSE;
  101215:	8b 44 24 3c          	mov    0x3c(%esp),%eax
    KERN_ASSERT(using_apic == TRUE);
  101219:	83 c4 20             	add    $0x20,%esp
    using_apic = (edx & CPUID_FEATURE_APIC) ? TRUE : FALSE;
  10121c:	c1 e8 09             	shr    $0x9,%eax
  10121f:	83 e0 01             	and    $0x1,%eax
  101222:	88 83 80 88 02 00    	mov    %al,0x28880(%ebx)
    KERN_ASSERT(using_apic == TRUE);
  101228:	0f b6 83 80 88 02 00 	movzbl 0x28880(%ebx),%eax
  10122f:	3c 01                	cmp    $0x1,%al
  101231:	74 1f                	je     101252 <intr_init+0x62>
  101233:	8d 83 05 94 ff ff    	lea    -0x6bfb(%ebx),%eax
  101239:	50                   	push   %eax
  10123a:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  101240:	50                   	push   %eax
  101241:	8d 83 18 94 ff ff    	lea    -0x6be8(%ebx),%eax
  101247:	6a 63                	push   $0x63
  101249:	50                   	push   %eax
  10124a:	e8 e1 2d 00 00       	call   104030 <debug_panic>
  10124f:	83 c4 10             	add    $0x10,%esp

    if (pcpu_onboot())
  101252:	e8 29 28 00 00       	call   103a80 <pcpu_onboot>
  101257:	84 c0                	test   %al,%al
  101259:	75 25                	jne    101280 <intr_init+0x90>
            intr_init_idt();
        }
    }

    /* all processors */
    if (using_apic)
  10125b:	0f b6 83 80 88 02 00 	movzbl 0x28880(%ebx),%eax
  101262:	84 c0                	test   %al,%al
  101264:	0f 85 46 05 00 00    	jne    1017b0 <intr_init+0x5c0>
    asm volatile ("lidt %0" :: "m" (idt_pd));
  10126a:	0f 01 9b 20 03 00 00 	lidtl  0x320(%ebx)
    {
        lapic_init();
    }
    intr_install_idt();
}
  101271:	83 c4 2c             	add    $0x2c,%esp
  101274:	5b                   	pop    %ebx
  101275:	5e                   	pop    %esi
  101276:	5f                   	pop    %edi
  101277:	5d                   	pop    %ebp
  101278:	c3                   	ret    
  101279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        pic_init();
  101280:	e8 3b 07 00 00       	call   1019c0 <pic_init>
        if (using_apic)
  101285:	0f b6 83 80 88 02 00 	movzbl 0x28880(%ebx),%eax
  10128c:	84 c0                	test   %al,%al
  10128e:	74 cb                	je     10125b <intr_init+0x6b>
            ioapic_init();
  101290:	e8 5b 18 00 00       	call   102af0 <ioapic_init>
        SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);
  101295:	c7 c0 0e 22 10 00    	mov    $0x10220e,%eax
  10129b:	8d 0d 80 80 02 00    	lea    0x28080,%ecx
  1012a1:	89 c6                	mov    %eax,%esi
  1012a3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1012a7:	89 c7                	mov    %eax,%edi
    for (i = 0; i < sizeof(idt) / sizeof(idt[0]); i++)
  1012a9:	31 c0                	xor    %eax,%eax
        SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);
  1012ab:	c1 ee 10             	shr    $0x10,%esi
  1012ae:	89 74 24 08          	mov    %esi,0x8(%esp)
  1012b2:	89 f5                	mov    %esi,%ebp
  1012b4:	8d b3 80 80 02 00    	lea    0x28080(%ebx),%esi
  1012ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1012c0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  1012c7:	66 89 3c c6          	mov    %di,(%esi,%eax,8)
    for (i = 0; i < sizeof(idt) / sizeof(idt[0]); i++)
  1012cb:	83 c0 01             	add    $0x1,%eax
        SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);
  1012ce:	c7 84 13 82 80 02 00 	movl   $0x8e000008,0x28082(%ebx,%edx,1)
  1012d5:	08 00 00 8e 
  1012d9:	01 da                	add    %ebx,%edx
  1012db:	66 89 6c 11 06       	mov    %bp,0x6(%ecx,%edx,1)
    for (i = 0; i < sizeof(idt) / sizeof(idt[0]); i++)
  1012e0:	3d 00 01 00 00       	cmp    $0x100,%eax
  1012e5:	75 d9                	jne    1012c0 <intr_init+0xd0>
    SETGATE(idt[T_DIVIDE],                  0, CPU_GDT_KCODE, &Xdivide,         0);
  1012e7:	c7 c0 00 21 10 00    	mov    $0x102100,%eax
    SETGATE(idt[T_FPERR],                   0, CPU_GDT_KCODE, &Xfperr,          0);
  1012ed:	ba 08 00 00 00       	mov    $0x8,%edx
    SETGATE(idt[T_DIVIDE],                  0, CPU_GDT_KCODE, &Xdivide,         0);
  1012f2:	c7 83 82 80 02 00 08 	movl   $0x8e000008,0x28082(%ebx)
  1012f9:	00 00 8e 
    SETGATE(idt[T_FPERR],                   0, CPU_GDT_KCODE, &Xfperr,          0);
  1012fc:	be 00 8e ff ff       	mov    $0xffff8e00,%esi
    SETGATE(idt[T_DEBUG],                   0, CPU_GDT_KCODE, &Xdebug,          0);
  101301:	c7 83 8a 80 02 00 08 	movl   $0x8e000008,0x2808a(%ebx)
  101308:	00 00 8e 
    SETGATE(idt[T_DIVIDE],                  0, CPU_GDT_KCODE, &Xdivide,         0);
  10130b:	66 89 04 19          	mov    %ax,(%ecx,%ebx,1)
  10130f:	c1 e8 10             	shr    $0x10,%eax
  101312:	66 89 44 19 06       	mov    %ax,0x6(%ecx,%ebx,1)
    SETGATE(idt[T_DEBUG],                   0, CPU_GDT_KCODE, &Xdebug,          0);
  101317:	c7 c0 0a 21 10 00    	mov    $0x10210a,%eax
    SETGATE(idt[T_NMI],                     0, CPU_GDT_KCODE, &Xnmi,            0);
  10131d:	c7 83 92 80 02 00 08 	movl   $0x8e000008,0x28092(%ebx)
  101324:	00 00 8e 
    SETGATE(idt[T_DEBUG],                   0, CPU_GDT_KCODE, &Xdebug,          0);
  101327:	66 89 44 19 08       	mov    %ax,0x8(%ecx,%ebx,1)
  10132c:	c1 e8 10             	shr    $0x10,%eax
  10132f:	66 89 44 19 0e       	mov    %ax,0xe(%ecx,%ebx,1)
    SETGATE(idt[T_NMI],                     0, CPU_GDT_KCODE, &Xnmi,            0);
  101334:	c7 c0 14 21 10 00    	mov    $0x102114,%eax
    SETGATE(idt[T_BRKPT],                   0, CPU_GDT_KCODE, &Xbrkpt,          3);
  10133a:	c7 83 9a 80 02 00 08 	movl   $0xee000008,0x2809a(%ebx)
  101341:	00 00 ee 
    SETGATE(idt[T_NMI],                     0, CPU_GDT_KCODE, &Xnmi,            0);
  101344:	66 89 44 19 10       	mov    %ax,0x10(%ecx,%ebx,1)
  101349:	c1 e8 10             	shr    $0x10,%eax
  10134c:	66 89 44 19 16       	mov    %ax,0x16(%ecx,%ebx,1)
    SETGATE(idt[T_BRKPT],                   0, CPU_GDT_KCODE, &Xbrkpt,          3);
  101351:	c7 c0 1e 21 10 00    	mov    $0x10211e,%eax
    SETGATE(idt[T_OFLOW],                   0, CPU_GDT_KCODE, &Xoflow,          3);
  101357:	c7 83 a2 80 02 00 08 	movl   $0xee000008,0x280a2(%ebx)
  10135e:	00 00 ee 
    SETGATE(idt[T_BRKPT],                   0, CPU_GDT_KCODE, &Xbrkpt,          3);
  101361:	66 89 44 19 18       	mov    %ax,0x18(%ecx,%ebx,1)
  101366:	c1 e8 10             	shr    $0x10,%eax
  101369:	66 89 44 19 1e       	mov    %ax,0x1e(%ecx,%ebx,1)
    SETGATE(idt[T_OFLOW],                   0, CPU_GDT_KCODE, &Xoflow,          3);
  10136e:	c7 c0 28 21 10 00    	mov    $0x102128,%eax
    SETGATE(idt[T_BOUND],                   0, CPU_GDT_KCODE, &Xbound,          0);
  101374:	c7 83 aa 80 02 00 08 	movl   $0x8e000008,0x280aa(%ebx)
  10137b:	00 00 8e 
    SETGATE(idt[T_OFLOW],                   0, CPU_GDT_KCODE, &Xoflow,          3);
  10137e:	66 89 44 19 20       	mov    %ax,0x20(%ecx,%ebx,1)
  101383:	c1 e8 10             	shr    $0x10,%eax
  101386:	66 89 44 19 26       	mov    %ax,0x26(%ecx,%ebx,1)
    SETGATE(idt[T_BOUND],                   0, CPU_GDT_KCODE, &Xbound,          0);
  10138b:	c7 c0 32 21 10 00    	mov    $0x102132,%eax
    SETGATE(idt[T_ILLOP],                   0, CPU_GDT_KCODE, &Xillop,          0);
  101391:	c7 83 b2 80 02 00 08 	movl   $0x8e000008,0x280b2(%ebx)
  101398:	00 00 8e 
    SETGATE(idt[T_BOUND],                   0, CPU_GDT_KCODE, &Xbound,          0);
  10139b:	66 89 44 19 28       	mov    %ax,0x28(%ecx,%ebx,1)
  1013a0:	c1 e8 10             	shr    $0x10,%eax
  1013a3:	66 89 44 19 2e       	mov    %ax,0x2e(%ecx,%ebx,1)
    SETGATE(idt[T_ILLOP],                   0, CPU_GDT_KCODE, &Xillop,          0);
  1013a8:	c7 c0 3c 21 10 00    	mov    $0x10213c,%eax
    SETGATE(idt[T_DEVICE],                  0, CPU_GDT_KCODE, &Xdevice,         0);
  1013ae:	c7 83 ba 80 02 00 08 	movl   $0x8e000008,0x280ba(%ebx)
  1013b5:	00 00 8e 
    SETGATE(idt[T_ILLOP],                   0, CPU_GDT_KCODE, &Xillop,          0);
  1013b8:	66 89 44 19 30       	mov    %ax,0x30(%ecx,%ebx,1)
  1013bd:	c1 e8 10             	shr    $0x10,%eax
  1013c0:	66 89 44 19 36       	mov    %ax,0x36(%ecx,%ebx,1)
    SETGATE(idt[T_DEVICE],                  0, CPU_GDT_KCODE, &Xdevice,         0);
  1013c5:	c7 c0 46 21 10 00    	mov    $0x102146,%eax
  1013cb:	66 89 44 19 38       	mov    %ax,0x38(%ecx,%ebx,1)
  1013d0:	c1 e8 10             	shr    $0x10,%eax
  1013d3:	66 89 44 19 3e       	mov    %ax,0x3e(%ecx,%ebx,1)
    SETGATE(idt[T_DBLFLT],                  0, CPU_GDT_KCODE, &Xdblflt,         0);
  1013d8:	c7 c0 50 21 10 00    	mov    $0x102150,%eax
    SETGATE(idt[T_FPERR],                   0, CPU_GDT_KCODE, &Xfperr,          0);
  1013de:	66 89 94 19 82 00 00 	mov    %dx,0x82(%ecx,%ebx,1)
  1013e5:	00 
    SETGATE(idt[T_DBLFLT],                  0, CPU_GDT_KCODE, &Xdblflt,         0);
  1013e6:	66 89 44 19 40       	mov    %ax,0x40(%ecx,%ebx,1)
  1013eb:	c1 e8 10             	shr    $0x10,%eax
  1013ee:	66 89 44 19 46       	mov    %ax,0x46(%ecx,%ebx,1)
    SETGATE(idt[T_TSS],                     0, CPU_GDT_KCODE, &Xtss,            0);
  1013f3:	c7 c0 62 21 10 00    	mov    $0x102162,%eax
    SETGATE(idt[T_DBLFLT],                  0, CPU_GDT_KCODE, &Xdblflt,         0);
  1013f9:	c7 83 c2 80 02 00 08 	movl   $0x8e000008,0x280c2(%ebx)
  101400:	00 00 8e 
    SETGATE(idt[T_TSS],                     0, CPU_GDT_KCODE, &Xtss,            0);
  101403:	66 89 44 19 50       	mov    %ax,0x50(%ecx,%ebx,1)
  101408:	c1 e8 10             	shr    $0x10,%eax
  10140b:	66 89 44 19 56       	mov    %ax,0x56(%ecx,%ebx,1)
    SETGATE(idt[T_SEGNP],                   0, CPU_GDT_KCODE, &Xsegnp,          0);
  101410:	c7 c0 6a 21 10 00    	mov    $0x10216a,%eax
    SETGATE(idt[T_TSS],                     0, CPU_GDT_KCODE, &Xtss,            0);
  101416:	c7 83 d2 80 02 00 08 	movl   $0x8e000008,0x280d2(%ebx)
  10141d:	00 00 8e 
    SETGATE(idt[T_SEGNP],                   0, CPU_GDT_KCODE, &Xsegnp,          0);
  101420:	66 89 44 19 58       	mov    %ax,0x58(%ecx,%ebx,1)
  101425:	c1 e8 10             	shr    $0x10,%eax
  101428:	66 89 44 19 5e       	mov    %ax,0x5e(%ecx,%ebx,1)
    SETGATE(idt[T_STACK],                   0, CPU_GDT_KCODE, &Xstack,          0);
  10142d:	c7 c0 72 21 10 00    	mov    $0x102172,%eax
    SETGATE(idt[T_SEGNP],                   0, CPU_GDT_KCODE, &Xsegnp,          0);
  101433:	c7 83 da 80 02 00 08 	movl   $0x8e000008,0x280da(%ebx)
  10143a:	00 00 8e 
    SETGATE(idt[T_STACK],                   0, CPU_GDT_KCODE, &Xstack,          0);
  10143d:	66 89 44 19 60       	mov    %ax,0x60(%ecx,%ebx,1)
  101442:	c1 e8 10             	shr    $0x10,%eax
  101445:	66 89 44 19 66       	mov    %ax,0x66(%ecx,%ebx,1)
    SETGATE(idt[T_GPFLT],                   0, CPU_GDT_KCODE, &Xgpflt,          0);
  10144a:	c7 c0 7a 21 10 00    	mov    $0x10217a,%eax
    SETGATE(idt[T_STACK],                   0, CPU_GDT_KCODE, &Xstack,          0);
  101450:	c7 83 e2 80 02 00 08 	movl   $0x8e000008,0x280e2(%ebx)
  101457:	00 00 8e 
    SETGATE(idt[T_GPFLT],                   0, CPU_GDT_KCODE, &Xgpflt,          0);
  10145a:	66 89 44 19 68       	mov    %ax,0x68(%ecx,%ebx,1)
  10145f:	c1 e8 10             	shr    $0x10,%eax
  101462:	66 89 44 19 6e       	mov    %ax,0x6e(%ecx,%ebx,1)
    SETGATE(idt[T_PGFLT],                   0, CPU_GDT_KCODE, &Xpgflt,          0);
  101467:	c7 c0 82 21 10 00    	mov    $0x102182,%eax
    SETGATE(idt[T_GPFLT],                   0, CPU_GDT_KCODE, &Xgpflt,          0);
  10146d:	c7 83 ea 80 02 00 08 	movl   $0x8e000008,0x280ea(%ebx)
  101474:	00 00 8e 
    SETGATE(idt[T_PGFLT],                   0, CPU_GDT_KCODE, &Xpgflt,          0);
  101477:	66 89 44 19 70       	mov    %ax,0x70(%ecx,%ebx,1)
  10147c:	c1 e8 10             	shr    $0x10,%eax
  10147f:	66 89 44 19 76       	mov    %ax,0x76(%ecx,%ebx,1)
    SETGATE(idt[T_FPERR],                   0, CPU_GDT_KCODE, &Xfperr,          0);
  101484:	c7 c0 94 21 10 00    	mov    $0x102194,%eax
    SETGATE(idt[T_PGFLT],                   0, CPU_GDT_KCODE, &Xpgflt,          0);
  10148a:	c7 83 f2 80 02 00 08 	movl   $0x8e000008,0x280f2(%ebx)
  101491:	00 00 8e 
    SETGATE(idt[T_FPERR],                   0, CPU_GDT_KCODE, &Xfperr,          0);
  101494:	66 89 84 19 80 00 00 	mov    %ax,0x80(%ecx,%ebx,1)
  10149b:	00 
  10149c:	c1 e8 10             	shr    $0x10,%eax
  10149f:	66 89 84 19 86 00 00 	mov    %ax,0x86(%ecx,%ebx,1)
  1014a6:	00 
    SETGATE(idt[T_ALIGN],                   0, CPU_GDT_KCODE, &Xalign,          0);
  1014a7:	c7 c0 9e 21 10 00    	mov    $0x10219e,%eax
    SETGATE(idt[T_FPERR],                   0, CPU_GDT_KCODE, &Xfperr,          0);
  1014ad:	66 89 b3 04 81 02 00 	mov    %si,0x28104(%ebx)
    SETGATE(idt[T_ALIGN],                   0, CPU_GDT_KCODE, &Xalign,          0);
  1014b4:	66 89 84 19 88 00 00 	mov    %ax,0x88(%ecx,%ebx,1)
  1014bb:	00 
  1014bc:	c1 e8 10             	shr    $0x10,%eax
  1014bf:	c7 83 0a 81 02 00 08 	movl   $0x8e000008,0x2810a(%ebx)
  1014c6:	00 00 8e 
  1014c9:	66 89 84 19 8e 00 00 	mov    %ax,0x8e(%ecx,%ebx,1)
  1014d0:	00 
    SETGATE(idt[T_MCHK],                    0, CPU_GDT_KCODE, &Xmchk,           0);
  1014d1:	c7 c0 a2 21 10 00    	mov    $0x1021a2,%eax
  1014d7:	c7 83 12 81 02 00 08 	movl   $0x8e000008,0x28112(%ebx)
  1014de:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL13],     0, CPU_GDT_KCODE, &Xirq_serial1,    0);
  1014e1:	c7 c2 c0 21 10 00    	mov    $0x1021c0,%edx
    SETGATE(idt[T_MCHK],                    0, CPU_GDT_KCODE, &Xmchk,           0);
  1014e7:	66 89 84 19 90 00 00 	mov    %ax,0x90(%ecx,%ebx,1)
  1014ee:	00 
  1014ef:	c1 e8 10             	shr    $0x10,%eax
  1014f2:	66 89 84 19 96 00 00 	mov    %ax,0x96(%ecx,%ebx,1)
  1014f9:	00 
    SETGATE(idt[T_IRQ0 + IRQ_TIMER],        0, CPU_GDT_KCODE, &Xirq_timer,      0);
  1014fa:	c7 c0 a8 21 10 00    	mov    $0x1021a8,%eax
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL13],     0, CPU_GDT_KCODE, &Xirq_serial1,    0);
  101500:	66 89 94 19 20 01 00 	mov    %dx,0x120(%ecx,%ebx,1)
  101507:	00 
  101508:	c1 ea 10             	shr    $0x10,%edx
    SETGATE(idt[T_IRQ0 + IRQ_TIMER],        0, CPU_GDT_KCODE, &Xirq_timer,      0);
  10150b:	66 89 84 19 00 01 00 	mov    %ax,0x100(%ecx,%ebx,1)
  101512:	00 
  101513:	c1 e8 10             	shr    $0x10,%eax
  101516:	66 89 84 19 06 01 00 	mov    %ax,0x106(%ecx,%ebx,1)
  10151d:	00 
    SETGATE(idt[T_IRQ0 + IRQ_KBD],          0, CPU_GDT_KCODE, &Xirq_kbd,        0);
  10151e:	c7 c0 ae 21 10 00    	mov    $0x1021ae,%eax
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL13],     0, CPU_GDT_KCODE, &Xirq_serial1,    0);
  101524:	66 89 94 19 26 01 00 	mov    %dx,0x126(%ecx,%ebx,1)
  10152b:	00 
    SETGATE(idt[T_IRQ0 + IRQ_KBD],          0, CPU_GDT_KCODE, &Xirq_kbd,        0);
  10152c:	66 89 84 19 08 01 00 	mov    %ax,0x108(%ecx,%ebx,1)
  101533:	00 
  101534:	c1 e8 10             	shr    $0x10,%eax
  101537:	66 89 84 19 0e 01 00 	mov    %ax,0x10e(%ecx,%ebx,1)
  10153e:	00 
    SETGATE(idt[T_IRQ0 + IRQ_SLAVE],        0, CPU_GDT_KCODE, &Xirq_slave,      0);
  10153f:	c7 c0 b4 21 10 00    	mov    $0x1021b4,%eax
    SETGATE(idt[T_IRQ0 + IRQ_TIMER],        0, CPU_GDT_KCODE, &Xirq_timer,      0);
  101545:	c7 83 82 81 02 00 08 	movl   $0x8e000008,0x28182(%ebx)
  10154c:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_SLAVE],        0, CPU_GDT_KCODE, &Xirq_slave,      0);
  10154f:	66 89 84 19 10 01 00 	mov    %ax,0x110(%ecx,%ebx,1)
  101556:	00 
  101557:	c1 e8 10             	shr    $0x10,%eax
  10155a:	66 89 84 19 16 01 00 	mov    %ax,0x116(%ecx,%ebx,1)
  101561:	00 
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL24],     0, CPU_GDT_KCODE, &Xirq_serial2,    0);
  101562:	c7 c0 ba 21 10 00    	mov    $0x1021ba,%eax
    SETGATE(idt[T_IRQ0 + IRQ_KBD],          0, CPU_GDT_KCODE, &Xirq_kbd,        0);
  101568:	c7 83 8a 81 02 00 08 	movl   $0x8e000008,0x2818a(%ebx)
  10156f:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL24],     0, CPU_GDT_KCODE, &Xirq_serial2,    0);
  101572:	66 89 84 19 18 01 00 	mov    %ax,0x118(%ecx,%ebx,1)
  101579:	00 
  10157a:	c1 e8 10             	shr    $0x10,%eax
  10157d:	66 89 84 19 1e 01 00 	mov    %ax,0x11e(%ecx,%ebx,1)
  101584:	00 
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL13],     0, CPU_GDT_KCODE, &Xirq_serial1,    0);
  101585:	8b 83 a2 81 02 00    	mov    0x281a2(%ebx),%eax
    SETGATE(idt[T_IRQ0 + IRQ_SLAVE],        0, CPU_GDT_KCODE, &Xirq_slave,      0);
  10158b:	c7 83 92 81 02 00 08 	movl   $0x8e000008,0x28192(%ebx)
  101592:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL24],     0, CPU_GDT_KCODE, &Xirq_serial2,    0);
  101595:	c7 83 9a 81 02 00 08 	movl   $0x8e000008,0x2819a(%ebx)
  10159c:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL13],     0, CPU_GDT_KCODE, &Xirq_serial1,    0);
  10159f:	25 00 00 e0 ff       	and    $0xffe00000,%eax
    SETGATE(idt[T_IRQ0 + IRQ_LPT2],         0, CPU_GDT_KCODE, &Xirq_lpt,        0);
  1015a4:	c7 83 aa 81 02 00 08 	movl   $0x8e000008,0x281aa(%ebx)
  1015ab:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL13],     0, CPU_GDT_KCODE, &Xirq_serial1,    0);
  1015ae:	83 c8 08             	or     $0x8,%eax
  1015b1:	89 83 a2 81 02 00    	mov    %eax,0x281a2(%ebx)
  1015b7:	0f b7 83 a4 81 02 00 	movzwl 0x281a4(%ebx),%eax
  1015be:	83 e0 1f             	and    $0x1f,%eax
  1015c1:	66 0d 00 8e          	or     $0x8e00,%ax
  1015c5:	66 89 83 a4 81 02 00 	mov    %ax,0x281a4(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_LPT2],         0, CPU_GDT_KCODE, &Xirq_lpt,        0);
  1015cc:	c7 c0 c6 21 10 00    	mov    $0x1021c6,%eax
  1015d2:	66 89 84 19 28 01 00 	mov    %ax,0x128(%ecx,%ebx,1)
  1015d9:	00 
  1015da:	c1 e8 10             	shr    $0x10,%eax
  1015dd:	66 89 84 19 2e 01 00 	mov    %ax,0x12e(%ecx,%ebx,1)
  1015e4:	00 
    SETGATE(idt[T_IRQ0 + IRQ_FLOPPY],       0, CPU_GDT_KCODE, &Xirq_floppy,     0);
  1015e5:	c7 c0 cc 21 10 00    	mov    $0x1021cc,%eax
  1015eb:	66 89 84 19 30 01 00 	mov    %ax,0x130(%ecx,%ebx,1)
  1015f2:	00 
  1015f3:	c1 e8 10             	shr    $0x10,%eax
    SETGATE(idt[T_IRQ0 + 11],               0, CPU_GDT_KCODE, &Xirq11,          0);
  1015f6:	c7 c2 ea 21 10 00    	mov    $0x1021ea,%edx
    SETGATE(idt[T_IRQ0 + IRQ_FLOPPY],       0, CPU_GDT_KCODE, &Xirq_floppy,     0);
  1015fc:	66 89 84 19 36 01 00 	mov    %ax,0x136(%ecx,%ebx,1)
  101603:	00 
    SETGATE(idt[T_IRQ0 + IRQ_SPURIOUS],     0, CPU_GDT_KCODE, &Xirq_spurious,   0);
  101604:	c7 c0 d2 21 10 00    	mov    $0x1021d2,%eax
    SETGATE(idt[T_IRQ0 + 11],               0, CPU_GDT_KCODE, &Xirq11,          0);
  10160a:	66 89 94 19 58 01 00 	mov    %dx,0x158(%ecx,%ebx,1)
  101611:	00 
    SETGATE(idt[T_IRQ0 + IRQ_SPURIOUS],     0, CPU_GDT_KCODE, &Xirq_spurious,   0);
  101612:	66 89 84 19 38 01 00 	mov    %ax,0x138(%ecx,%ebx,1)
  101619:	00 
  10161a:	c1 e8 10             	shr    $0x10,%eax
  10161d:	66 89 84 19 3e 01 00 	mov    %ax,0x13e(%ecx,%ebx,1)
  101624:	00 
    SETGATE(idt[T_IRQ0 + IRQ_RTC],          0, CPU_GDT_KCODE, &Xirq_rtc,        0);
  101625:	c7 c0 d8 21 10 00    	mov    $0x1021d8,%eax
    SETGATE(idt[T_IRQ0 + IRQ_FLOPPY],       0, CPU_GDT_KCODE, &Xirq_floppy,     0);
  10162b:	c7 83 b2 81 02 00 08 	movl   $0x8e000008,0x281b2(%ebx)
  101632:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_RTC],          0, CPU_GDT_KCODE, &Xirq_rtc,        0);
  101635:	66 89 84 19 40 01 00 	mov    %ax,0x140(%ecx,%ebx,1)
  10163c:	00 
  10163d:	c1 e8 10             	shr    $0x10,%eax
  101640:	66 89 84 19 46 01 00 	mov    %ax,0x146(%ecx,%ebx,1)
  101647:	00 
    SETGATE(idt[T_IRQ0 + 9],                0, CPU_GDT_KCODE, &Xirq9,           0);
  101648:	c7 c0 de 21 10 00    	mov    $0x1021de,%eax
    SETGATE(idt[T_IRQ0 + IRQ_SPURIOUS],     0, CPU_GDT_KCODE, &Xirq_spurious,   0);
  10164e:	c7 83 ba 81 02 00 08 	movl   $0x8e000008,0x281ba(%ebx)
  101655:	00 00 8e 
    SETGATE(idt[T_IRQ0 + 9],                0, CPU_GDT_KCODE, &Xirq9,           0);
  101658:	66 89 84 19 48 01 00 	mov    %ax,0x148(%ecx,%ebx,1)
  10165f:	00 
  101660:	c1 e8 10             	shr    $0x10,%eax
  101663:	66 89 84 19 4e 01 00 	mov    %ax,0x14e(%ecx,%ebx,1)
  10166a:	00 
    SETGATE(idt[T_IRQ0 + 10],               0, CPU_GDT_KCODE, &Xirq10,          0);
  10166b:	c7 c0 e4 21 10 00    	mov    $0x1021e4,%eax
    SETGATE(idt[T_IRQ0 + IRQ_RTC],          0, CPU_GDT_KCODE, &Xirq_rtc,        0);
  101671:	c7 83 c2 81 02 00 08 	movl   $0x8e000008,0x281c2(%ebx)
  101678:	00 00 8e 
    SETGATE(idt[T_IRQ0 + 10],               0, CPU_GDT_KCODE, &Xirq10,          0);
  10167b:	66 89 84 19 50 01 00 	mov    %ax,0x150(%ecx,%ebx,1)
  101682:	00 
  101683:	c1 e8 10             	shr    $0x10,%eax
  101686:	66 89 84 19 56 01 00 	mov    %ax,0x156(%ecx,%ebx,1)
  10168d:	00 
    SETGATE(idt[T_IRQ0 + 11],               0, CPU_GDT_KCODE, &Xirq11,          0);
  10168e:	8b 83 da 81 02 00    	mov    0x281da(%ebx),%eax
    SETGATE(idt[T_IRQ0 + 9],                0, CPU_GDT_KCODE, &Xirq9,           0);
  101694:	c7 83 ca 81 02 00 08 	movl   $0x8e000008,0x281ca(%ebx)
  10169b:	00 00 8e 
    SETGATE(idt[T_IRQ0 + 10],               0, CPU_GDT_KCODE, &Xirq10,          0);
  10169e:	c7 83 d2 81 02 00 08 	movl   $0x8e000008,0x281d2(%ebx)
  1016a5:	00 00 8e 
    SETGATE(idt[T_IRQ0 + 11],               0, CPU_GDT_KCODE, &Xirq11,          0);
  1016a8:	25 00 00 00 ff       	and    $0xff000000,%eax
  1016ad:	c1 ea 10             	shr    $0x10,%edx
  1016b0:	83 c8 08             	or     $0x8,%eax
  1016b3:	66 89 94 19 5e 01 00 	mov    %dx,0x15e(%ecx,%ebx,1)
  1016ba:	00 
  1016bb:	89 83 da 81 02 00    	mov    %eax,0x281da(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_MOUSE],        0, CPU_GDT_KCODE, &Xirq_mouse,      0);
  1016c1:	c7 c0 f0 21 10 00    	mov    $0x1021f0,%eax
    SETGATE(idt[T_IRQ0 + 11],               0, CPU_GDT_KCODE, &Xirq11,          0);
  1016c7:	c6 83 dd 81 02 00 8e 	movb   $0x8e,0x281dd(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_MOUSE],        0, CPU_GDT_KCODE, &Xirq_mouse,      0);
  1016ce:	66 89 84 19 60 01 00 	mov    %ax,0x160(%ecx,%ebx,1)
  1016d5:	00 
  1016d6:	c1 e8 10             	shr    $0x10,%eax
  1016d9:	66 89 84 19 66 01 00 	mov    %ax,0x166(%ecx,%ebx,1)
  1016e0:	00 
    SETGATE(idt[T_IRQ0 + IRQ_COPROCESSOR],  0, CPU_GDT_KCODE, &Xirq_coproc,     0);
  1016e1:	c7 c0 f6 21 10 00    	mov    $0x1021f6,%eax
    SETGATE(idt[T_IRQ0 + IRQ_MOUSE],        0, CPU_GDT_KCODE, &Xirq_mouse,      0);
  1016e7:	c7 83 e2 81 02 00 08 	movl   $0x8e000008,0x281e2(%ebx)
  1016ee:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_COPROCESSOR],  0, CPU_GDT_KCODE, &Xirq_coproc,     0);
  1016f1:	66 89 84 19 68 01 00 	mov    %ax,0x168(%ecx,%ebx,1)
  1016f8:	00 
  1016f9:	c1 e8 10             	shr    $0x10,%eax
  1016fc:	c7 83 ea 81 02 00 08 	movl   $0x8e000008,0x281ea(%ebx)
  101703:	00 00 8e 
  101706:	66 89 84 19 6e 01 00 	mov    %ax,0x16e(%ecx,%ebx,1)
  10170d:	00 
    SETGATE(idt[T_IRQ0 + IRQ_IDE1],         0, CPU_GDT_KCODE, &Xirq_ide1,       0);
  10170e:	c7 c0 fc 21 10 00    	mov    $0x1021fc,%eax
  101714:	c7 83 f2 81 02 00 08 	movl   $0x8e000008,0x281f2(%ebx)
  10171b:	00 00 8e 
  10171e:	66 89 84 19 70 01 00 	mov    %ax,0x170(%ecx,%ebx,1)
  101725:	00 
  101726:	c1 e8 10             	shr    $0x10,%eax
  101729:	66 89 84 19 76 01 00 	mov    %ax,0x176(%ecx,%ebx,1)
  101730:	00 
    SETGATE(idt[T_IRQ0 + IRQ_IDE2],         0, CPU_GDT_KCODE, &Xirq_ide2,       0);
  101731:	c7 c0 02 22 10 00    	mov    $0x102202,%eax
  101737:	c7 83 fa 81 02 00 08 	movl   $0x8e000008,0x281fa(%ebx)
  10173e:	00 00 8e 
  101741:	66 89 84 19 78 01 00 	mov    %ax,0x178(%ecx,%ebx,1)
  101748:	00 
  101749:	c1 e8 10             	shr    $0x10,%eax
  10174c:	66 89 84 19 7e 01 00 	mov    %ax,0x17e(%ecx,%ebx,1)
  101753:	00 
    SETGATE(idt[T_SYSCALL], 0, CPU_GDT_KCODE, &Xsyscall, 3);
  101754:	c7 c0 08 22 10 00    	mov    $0x102208,%eax
  10175a:	c7 83 02 82 02 00 08 	movl   $0xee000008,0x28202(%ebx)
  101761:	00 00 ee 
  101764:	66 89 84 19 80 01 00 	mov    %ax,0x180(%ecx,%ebx,1)
  10176b:	00 
  10176c:	c1 e8 10             	shr    $0x10,%eax
  10176f:	66 89 84 19 86 01 00 	mov    %ax,0x186(%ecx,%ebx,1)
  101776:	00 
    SETGATE(idt[T_DEFAULT], 0, CPU_GDT_KCODE, &Xdefault, 0);
  101777:	0f b7 44 24 0c       	movzwl 0xc(%esp),%eax
  10177c:	c7 83 72 88 02 00 08 	movl   $0x8e000008,0x28872(%ebx)
  101783:	00 00 8e 
  101786:	66 89 84 19 f0 07 00 	mov    %ax,0x7f0(%ecx,%ebx,1)
  10178d:	00 
  10178e:	0f b7 44 24 08       	movzwl 0x8(%esp),%eax
  101793:	66 89 84 19 f6 07 00 	mov    %ax,0x7f6(%ecx,%ebx,1)
  10179a:	00 
    if (using_apic)
  10179b:	0f b6 83 80 88 02 00 	movzbl 0x28880(%ebx),%eax
  1017a2:	84 c0                	test   %al,%al
  1017a4:	0f 84 c0 fa ff ff    	je     10126a <intr_init+0x7a>
  1017aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        lapic_init();
  1017b0:	e8 db 0d 00 00       	call   102590 <lapic_init>
  1017b5:	e9 b0 fa ff ff       	jmp    10126a <intr_init+0x7a>
  1017ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001017c0 <intr_enable>:

void intr_enable(uint8_t irq, int cpunum)
{
  1017c0:	57                   	push   %edi
  1017c1:	56                   	push   %esi
  1017c2:	53                   	push   %ebx
  1017c3:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1017c7:	e8 bd eb ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1017cc:	81 c3 34 e8 00 00    	add    $0xe834,%ebx
  1017d2:	8b 74 24 10          	mov    0x10(%esp),%esi
    KERN_ASSERT(cpunum == 0xff || (0 <= cpunum && cpunum < pcpu_ncpu()));
  1017d6:	81 ff ff 00 00 00    	cmp    $0xff,%edi
  1017dc:	74 12                	je     1017f0 <intr_enable+0x30>
  1017de:	85 ff                	test   %edi,%edi
  1017e0:	78 3e                	js     101820 <intr_enable+0x60>
  1017e2:	e8 59 22 00 00       	call   103a40 <pcpu_ncpu>
  1017e7:	39 f8                	cmp    %edi,%eax
  1017e9:	76 35                	jbe    101820 <intr_enable+0x60>
  1017eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1017ef:	90                   	nop

    if (irq >= 24)
  1017f0:	89 f0                	mov    %esi,%eax
  1017f2:	3c 17                	cmp    $0x17,%al
  1017f4:	77 26                	ja     10181c <intr_enable+0x5c>
        return;

    if (using_apic == TRUE) {
  1017f6:	0f b6 83 80 88 02 00 	movzbl 0x28880(%ebx),%eax
  1017fd:	3c 01                	cmp    $0x1,%al
  1017ff:	74 47                	je     101848 <intr_enable+0x88>
        ioapic_enable(irq, (cpunum == 0xff) ?  0xff : pcpu_cpu_lapicid(cpunum), 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
  101801:	89 f0                	mov    %esi,%eax
  101803:	3c 0f                	cmp    $0xf,%al
  101805:	0f 87 7d 00 00 00    	ja     101888 <intr_enable+0xc8>
        pic_enable(irq);
  10180b:	89 f0                	mov    %esi,%eax
  10180d:	83 ec 0c             	sub    $0xc,%esp
  101810:	0f b6 f0             	movzbl %al,%esi
  101813:	56                   	push   %esi
  101814:	e8 e7 02 00 00       	call   101b00 <pic_enable>
  101819:	83 c4 10             	add    $0x10,%esp
    }
}
  10181c:	5b                   	pop    %ebx
  10181d:	5e                   	pop    %esi
  10181e:	5f                   	pop    %edi
  10181f:	c3                   	ret    
    KERN_ASSERT(cpunum == 0xff || (0 <= cpunum && cpunum < pcpu_ncpu()));
  101820:	8d 83 34 94 ff ff    	lea    -0x6bcc(%ebx),%eax
  101826:	50                   	push   %eax
  101827:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  10182d:	50                   	push   %eax
  10182e:	8d 83 18 94 ff ff    	lea    -0x6be8(%ebx),%eax
  101834:	6a 7a                	push   $0x7a
  101836:	50                   	push   %eax
  101837:	e8 f4 27 00 00       	call   104030 <debug_panic>
  10183c:	83 c4 10             	add    $0x10,%esp
  10183f:	eb af                	jmp    1017f0 <intr_enable+0x30>
  101841:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        ioapic_enable(irq, (cpunum == 0xff) ?  0xff : pcpu_cpu_lapicid(cpunum), 0, 0);
  101848:	81 ff ff 00 00 00    	cmp    $0xff,%edi
  10184e:	75 20                	jne    101870 <intr_enable+0xb0>
  101850:	89 f0                	mov    %esi,%eax
  101852:	6a 00                	push   $0x0
  101854:	0f b6 f0             	movzbl %al,%esi
  101857:	6a 00                	push   $0x0
  101859:	57                   	push   %edi
  10185a:	56                   	push   %esi
  10185b:	e8 d0 13 00 00       	call   102c30 <ioapic_enable>
  101860:	83 c4 10             	add    $0x10,%esp
}
  101863:	5b                   	pop    %ebx
  101864:	5e                   	pop    %esi
  101865:	5f                   	pop    %edi
  101866:	c3                   	ret    
  101867:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10186e:	66 90                	xchg   %ax,%ax
        ioapic_enable(irq, (cpunum == 0xff) ?  0xff : pcpu_cpu_lapicid(cpunum), 0, 0);
  101870:	83 ec 0c             	sub    $0xc,%esp
  101873:	57                   	push   %edi
  101874:	e8 57 22 00 00       	call   103ad0 <pcpu_cpu_lapicid>
  101879:	83 c4 10             	add    $0x10,%esp
  10187c:	0f b6 f8             	movzbl %al,%edi
  10187f:	eb cf                	jmp    101850 <intr_enable+0x90>
  101881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        KERN_ASSERT(irq < 16);
  101888:	8d 83 28 94 ff ff    	lea    -0x6bd8(%ebx),%eax
  10188e:	50                   	push   %eax
  10188f:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  101895:	50                   	push   %eax
  101896:	8d 83 18 94 ff ff    	lea    -0x6be8(%ebx),%eax
  10189c:	68 82 00 00 00       	push   $0x82
  1018a1:	50                   	push   %eax
  1018a2:	e8 89 27 00 00       	call   104030 <debug_panic>
  1018a7:	83 c4 10             	add    $0x10,%esp
  1018aa:	e9 5c ff ff ff       	jmp    10180b <intr_enable+0x4b>
  1018af:	90                   	nop

001018b0 <intr_enable_lapicid>:

void intr_enable_lapicid(uint8_t irq, int lapic_id)
{
  1018b0:	56                   	push   %esi
  1018b1:	53                   	push   %ebx
  1018b2:	e8 d2 ea ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1018b7:	81 c3 49 e7 00 00    	add    $0xe749,%ebx
  1018bd:	83 ec 04             	sub    $0x4,%esp
  1018c0:	8b 44 24 10          	mov    0x10(%esp),%eax
    if (irq > 24)
  1018c4:	3c 18                	cmp    $0x18,%al
  1018c6:	77 1f                	ja     1018e7 <intr_enable_lapicid+0x37>
        return;

    if (using_apic == TRUE) {
  1018c8:	0f b6 93 80 88 02 00 	movzbl 0x28880(%ebx),%edx
        ioapic_enable(irq, (lapic_id == 0xff) ?  0xff : lapic_id, 0, 0);
  1018cf:	0f b6 f0             	movzbl %al,%esi
    if (using_apic == TRUE) {
  1018d2:	80 fa 01             	cmp    $0x1,%dl
  1018d5:	74 41                	je     101918 <intr_enable_lapicid+0x68>
    } else {
        KERN_ASSERT(irq < 16);
  1018d7:	3c 0f                	cmp    $0xf,%al
  1018d9:	77 15                	ja     1018f0 <intr_enable_lapicid+0x40>
        pic_enable(irq);
  1018db:	83 ec 0c             	sub    $0xc,%esp
  1018de:	56                   	push   %esi
  1018df:	e8 1c 02 00 00       	call   101b00 <pic_enable>
  1018e4:	83 c4 10             	add    $0x10,%esp
    }
}
  1018e7:	83 c4 04             	add    $0x4,%esp
  1018ea:	5b                   	pop    %ebx
  1018eb:	5e                   	pop    %esi
  1018ec:	c3                   	ret    
  1018ed:	8d 76 00             	lea    0x0(%esi),%esi
        KERN_ASSERT(irq < 16);
  1018f0:	8d 83 28 94 ff ff    	lea    -0x6bd8(%ebx),%eax
  1018f6:	50                   	push   %eax
  1018f7:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  1018fd:	50                   	push   %eax
  1018fe:	8d 83 18 94 ff ff    	lea    -0x6be8(%ebx),%eax
  101904:	68 8f 00 00 00       	push   $0x8f
  101909:	50                   	push   %eax
  10190a:	e8 21 27 00 00       	call   104030 <debug_panic>
  10190f:	83 c4 10             	add    $0x10,%esp
  101912:	eb c7                	jmp    1018db <intr_enable_lapicid+0x2b>
  101914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        ioapic_enable(irq, (lapic_id == 0xff) ?  0xff : lapic_id, 0, 0);
  101918:	6a 00                	push   $0x0
  10191a:	6a 00                	push   $0x0
  10191c:	0f b6 44 24 1c       	movzbl 0x1c(%esp),%eax
  101921:	50                   	push   %eax
  101922:	56                   	push   %esi
  101923:	e8 08 13 00 00       	call   102c30 <ioapic_enable>
  101928:	83 c4 10             	add    $0x10,%esp
}
  10192b:	83 c4 04             	add    $0x4,%esp
  10192e:	5b                   	pop    %ebx
  10192f:	5e                   	pop    %esi
  101930:	c3                   	ret    
  101931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101938:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10193f:	90                   	nop

00101940 <intr_eoi>:

void intr_eoi(void)
{
  101940:	53                   	push   %ebx
  101941:	e8 43 ea ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101946:	81 c3 ba e6 00 00    	add    $0xe6ba,%ebx
  10194c:	83 ec 08             	sub    $0x8,%esp
    if (using_apic == TRUE)
  10194f:	0f b6 83 80 88 02 00 	movzbl 0x28880(%ebx),%eax
  101956:	3c 01                	cmp    $0x1,%al
  101958:	74 0e                	je     101968 <intr_eoi+0x28>
        lapic_eoi();
    else
        pic_eoi();
  10195a:	e8 f1 01 00 00       	call   101b50 <pic_eoi>
}
  10195f:	83 c4 08             	add    $0x8,%esp
  101962:	5b                   	pop    %ebx
  101963:	c3                   	ret    
  101964:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        lapic_eoi();
  101968:	e8 13 0f 00 00       	call   102880 <lapic_eoi>
}
  10196d:	83 c4 08             	add    $0x8,%esp
  101970:	5b                   	pop    %ebx
  101971:	c3                   	ret    
  101972:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101980 <intr_local_enable>:

void intr_local_enable(void)
{
  101980:	53                   	push   %ebx
  101981:	e8 03 ea ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101986:	81 c3 7a e6 00 00    	add    $0xe67a,%ebx
  10198c:	83 ec 08             	sub    $0x8,%esp
    sti();
  10198f:	e8 8c 32 00 00       	call   104c20 <sti>
}
  101994:	83 c4 08             	add    $0x8,%esp
  101997:	5b                   	pop    %ebx
  101998:	c3                   	ret    
  101999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001019a0 <intr_local_disable>:

void intr_local_disable(void)
{
  1019a0:	53                   	push   %ebx
  1019a1:	e8 e3 e9 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1019a6:	81 c3 5a e6 00 00    	add    $0xe65a,%ebx
  1019ac:	83 ec 08             	sub    $0x8,%esp
    cli();
  1019af:	e8 5c 32 00 00       	call   104c10 <cli>
}
  1019b4:	83 c4 08             	add    $0x8,%esp
  1019b7:	5b                   	pop    %ebx
  1019b8:	c3                   	ret    
  1019b9:	66 90                	xchg   %ax,%ax
  1019bb:	66 90                	xchg   %ax,%ax
  1019bd:	66 90                	xchg   %ax,%ax
  1019bf:	90                   	nop

001019c0 <pic_init>:
static uint16_t irqmask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool pic_inited = FALSE;

/* Initialize the 8259A interrupt controllers. */
void pic_init(void)
{
  1019c0:	53                   	push   %ebx
  1019c1:	e8 c3 e9 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1019c6:	81 c3 3a e6 00 00    	add    $0xe63a,%ebx
  1019cc:	83 ec 08             	sub    $0x8,%esp
    if (pic_inited == TRUE)  // only do once on bootstrap CPU
  1019cf:	80 bb 81 88 02 00 01 	cmpb   $0x1,0x28881(%ebx)
  1019d6:	0f 84 df 00 00 00    	je     101abb <pic_init+0xfb>
        return;
    pic_inited = TRUE;

    /* mask all interrupts */
    outb(IO_PIC1 + 1, 0xff);
  1019dc:	83 ec 08             	sub    $0x8,%esp
    pic_inited = TRUE;
  1019df:	c6 83 81 88 02 00 01 	movb   $0x1,0x28881(%ebx)
    outb(IO_PIC1 + 1, 0xff);
  1019e6:	68 ff 00 00 00       	push   $0xff
  1019eb:	6a 21                	push   $0x21
  1019ed:	e8 3e 34 00 00       	call   104e30 <outb>
    outb(IO_PIC2 + 1, 0xff);
  1019f2:	58                   	pop    %eax
  1019f3:	5a                   	pop    %edx
  1019f4:	68 ff 00 00 00       	push   $0xff
  1019f9:	68 a1 00 00 00       	push   $0xa1
  1019fe:	e8 2d 34 00 00       	call   104e30 <outb>

    // ICW1:  0001g0hi
    //    g:  0 = edge triggering, 1 = level triggering
    //    h:  0 = cascaded PICs, 1 = master only
    //    i:  0 = no ICW4, 1 = ICW4 required
    outb(IO_PIC1, 0x11);
  101a03:	59                   	pop    %ecx
  101a04:	58                   	pop    %eax
  101a05:	6a 11                	push   $0x11
  101a07:	6a 20                	push   $0x20
  101a09:	e8 22 34 00 00       	call   104e30 <outb>

    // ICW2:  Vector offset
    outb(IO_PIC1 + 1, T_IRQ0);
  101a0e:	58                   	pop    %eax
  101a0f:	5a                   	pop    %edx
  101a10:	6a 20                	push   $0x20
  101a12:	6a 21                	push   $0x21
  101a14:	e8 17 34 00 00       	call   104e30 <outb>

    // ICW3:  bit mask of IR lines connected to slave PICs (master PIC),
    //        3-bit No of IR line at which slave connects to master (slave PIC).
    outb(IO_PIC1 + 1, 1 << IRQ_SLAVE);
  101a19:	59                   	pop    %ecx
  101a1a:	58                   	pop    %eax
  101a1b:	6a 04                	push   $0x4
  101a1d:	6a 21                	push   $0x21
  101a1f:	e8 0c 34 00 00       	call   104e30 <outb>
    //    m:  0 = slave PIC, 1 = master PIC
    //        (ignored when b is 0, as the master/slave role
    //        can be hardwired).
    //    a:  1 = Automatic EOI mode
    //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
    outb(IO_PIC1 + 1, 0x1);
  101a24:	58                   	pop    %eax
  101a25:	5a                   	pop    %edx
  101a26:	6a 01                	push   $0x1
  101a28:	6a 21                	push   $0x21
  101a2a:	e8 01 34 00 00       	call   104e30 <outb>

    // Set up slave (8259A-2)
    outb(IO_PIC2, 0x11);            // ICW1
  101a2f:	59                   	pop    %ecx
  101a30:	58                   	pop    %eax
  101a31:	6a 11                	push   $0x11
  101a33:	68 a0 00 00 00       	push   $0xa0
  101a38:	e8 f3 33 00 00       	call   104e30 <outb>
    outb(IO_PIC2 + 1, T_IRQ0 + 8);  // ICW2
  101a3d:	58                   	pop    %eax
  101a3e:	5a                   	pop    %edx
  101a3f:	6a 28                	push   $0x28
  101a41:	68 a1 00 00 00       	push   $0xa1
  101a46:	e8 e5 33 00 00       	call   104e30 <outb>
    outb(IO_PIC2 + 1, IRQ_SLAVE);   // ICW3
  101a4b:	59                   	pop    %ecx
  101a4c:	58                   	pop    %eax
  101a4d:	6a 02                	push   $0x2
  101a4f:	68 a1 00 00 00       	push   $0xa1
  101a54:	e8 d7 33 00 00       	call   104e30 <outb>
    // NB Automatic EOI mode doesn't tend to work on the slave.
    // Linux source code says it's "to be investigated".
    outb(IO_PIC2 + 1, 0x01);        // ICW4
  101a59:	58                   	pop    %eax
  101a5a:	5a                   	pop    %edx
  101a5b:	6a 01                	push   $0x1
  101a5d:	68 a1 00 00 00       	push   $0xa1
  101a62:	e8 c9 33 00 00       	call   104e30 <outb>

    // OCW3:  0ef01prs
    //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
    //    p:  0 = no polling, 1 = polling mode
    //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
    outb(IO_PIC1, 0x68);  /* clear specific mask */
  101a67:	59                   	pop    %ecx
  101a68:	58                   	pop    %eax
  101a69:	6a 68                	push   $0x68
  101a6b:	6a 20                	push   $0x20
  101a6d:	e8 be 33 00 00       	call   104e30 <outb>
    outb(IO_PIC1, 0x0a);  /* read IRR by default */
  101a72:	58                   	pop    %eax
  101a73:	5a                   	pop    %edx
  101a74:	6a 0a                	push   $0xa
  101a76:	6a 20                	push   $0x20
  101a78:	e8 b3 33 00 00       	call   104e30 <outb>

    outb(IO_PIC2, 0x68);  /* OCW3 */
  101a7d:	59                   	pop    %ecx
  101a7e:	58                   	pop    %eax
  101a7f:	6a 68                	push   $0x68
  101a81:	68 a0 00 00 00       	push   $0xa0
  101a86:	e8 a5 33 00 00       	call   104e30 <outb>
    outb(IO_PIC2, 0x0a);  /* OCW3 */
  101a8b:	58                   	pop    %eax
  101a8c:	5a                   	pop    %edx
  101a8d:	6a 0a                	push   $0xa
  101a8f:	68 a0 00 00 00       	push   $0xa0
  101a94:	e8 97 33 00 00       	call   104e30 <outb>

    // mask all interrupts
    outb(IO_PIC1 + 1, 0xFF);
  101a99:	59                   	pop    %ecx
  101a9a:	58                   	pop    %eax
  101a9b:	68 ff 00 00 00       	push   $0xff
  101aa0:	6a 21                	push   $0x21
  101aa2:	e8 89 33 00 00       	call   104e30 <outb>
    outb(IO_PIC2 + 1, 0xFF);
  101aa7:	58                   	pop    %eax
  101aa8:	5a                   	pop    %edx
  101aa9:	68 ff 00 00 00       	push   $0xff
  101aae:	68 a1 00 00 00       	push   $0xa1
  101ab3:	e8 78 33 00 00       	call   104e30 <outb>
  101ab8:	83 c4 10             	add    $0x10,%esp
}
  101abb:	83 c4 08             	add    $0x8,%esp
  101abe:	5b                   	pop    %ebx
  101abf:	c3                   	ret    

00101ac0 <pic_setmask>:

void pic_setmask(uint16_t mask)
{
  101ac0:	56                   	push   %esi
  101ac1:	53                   	push   %ebx
  101ac2:	e8 c2 e8 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101ac7:	81 c3 39 e5 00 00    	add    $0xe539,%ebx
  101acd:	83 ec 0c             	sub    $0xc,%esp
  101ad0:	8b 74 24 18          	mov    0x18(%esp),%esi
    irqmask = mask;
    outb(IO_PIC1 + 1, (char) mask);
  101ad4:	89 f0                	mov    %esi,%eax
  101ad6:	0f b6 c0             	movzbl %al,%eax
    irqmask = mask;
  101ad9:	66 89 b3 26 03 00 00 	mov    %si,0x326(%ebx)
    outb(IO_PIC1 + 1, (char) mask);
  101ae0:	50                   	push   %eax
  101ae1:	6a 21                	push   $0x21
  101ae3:	e8 48 33 00 00       	call   104e30 <outb>
    outb(IO_PIC2 + 1, (char) (mask >> 8));
  101ae8:	58                   	pop    %eax
  101ae9:	89 f0                	mov    %esi,%eax
  101aeb:	5a                   	pop    %edx
  101aec:	0f b6 f4             	movzbl %ah,%esi
  101aef:	56                   	push   %esi
  101af0:	68 a1 00 00 00       	push   $0xa1
  101af5:	e8 36 33 00 00       	call   104e30 <outb>
}
  101afa:	83 c4 14             	add    $0x14,%esp
  101afd:	5b                   	pop    %ebx
  101afe:	5e                   	pop    %esi
  101aff:	c3                   	ret    

00101b00 <pic_enable>:

void pic_enable(int irq)
{
  101b00:	56                   	push   %esi
  101b01:	53                   	push   %ebx
  101b02:	e8 82 e8 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101b07:	81 c3 f9 e4 00 00    	add    $0xe4f9,%ebx
  101b0d:	83 ec 0c             	sub    $0xc,%esp
    pic_setmask(irqmask & ~(1 << irq));
  101b10:	8b 44 24 18          	mov    0x18(%esp),%eax
  101b14:	0f b7 b3 26 03 00 00 	movzwl 0x326(%ebx),%esi
  101b1b:	0f b3 c6             	btr    %eax,%esi
    outb(IO_PIC1 + 1, (char) mask);
  101b1e:	89 f0                	mov    %esi,%eax
    irqmask = mask;
  101b20:	66 89 b3 26 03 00 00 	mov    %si,0x326(%ebx)
    outb(IO_PIC2 + 1, (char) (mask >> 8));
  101b27:	66 c1 ee 08          	shr    $0x8,%si
    outb(IO_PIC1 + 1, (char) mask);
  101b2b:	0f b6 c0             	movzbl %al,%eax
    outb(IO_PIC2 + 1, (char) (mask >> 8));
  101b2e:	0f b7 f6             	movzwl %si,%esi
    outb(IO_PIC1 + 1, (char) mask);
  101b31:	50                   	push   %eax
  101b32:	6a 21                	push   $0x21
  101b34:	e8 f7 32 00 00       	call   104e30 <outb>
    outb(IO_PIC2 + 1, (char) (mask >> 8));
  101b39:	58                   	pop    %eax
  101b3a:	5a                   	pop    %edx
  101b3b:	56                   	push   %esi
  101b3c:	68 a1 00 00 00       	push   $0xa1
  101b41:	e8 ea 32 00 00       	call   104e30 <outb>
}
  101b46:	83 c4 14             	add    $0x14,%esp
  101b49:	5b                   	pop    %ebx
  101b4a:	5e                   	pop    %esi
  101b4b:	c3                   	ret    
  101b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101b50 <pic_eoi>:

void pic_eoi(void)
{
  101b50:	53                   	push   %ebx
  101b51:	e8 33 e8 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101b56:	81 c3 aa e4 00 00    	add    $0xe4aa,%ebx
  101b5c:	83 ec 10             	sub    $0x10,%esp
    // OCW2: rse00xxx
    //   r: rotate
    //   s: specific
    //   e: end-of-interrupt
    // xxx: specific interrupt line
    outb(IO_PIC1, 0x20);
  101b5f:	6a 20                	push   $0x20
  101b61:	6a 20                	push   $0x20
  101b63:	e8 c8 32 00 00       	call   104e30 <outb>
    outb(IO_PIC2, 0x20);
  101b68:	58                   	pop    %eax
  101b69:	5a                   	pop    %edx
  101b6a:	6a 20                	push   $0x20
  101b6c:	68 a0 00 00 00       	push   $0xa0
  101b71:	e8 ba 32 00 00       	call   104e30 <outb>
}
  101b76:	83 c4 18             	add    $0x18,%esp
  101b79:	5b                   	pop    %ebx
  101b7a:	c3                   	ret    
  101b7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101b7f:	90                   	nop

00101b80 <pic_reset>:

void pic_reset(void)
{
  101b80:	53                   	push   %ebx
  101b81:	e8 03 e8 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101b86:	81 c3 7a e4 00 00    	add    $0xe47a,%ebx
  101b8c:	83 ec 10             	sub    $0x10,%esp
    // mask all interrupts
    outb(IO_PIC1 + 1, 0x00);
  101b8f:	6a 00                	push   $0x0
  101b91:	6a 21                	push   $0x21
  101b93:	e8 98 32 00 00       	call   104e30 <outb>
    outb(IO_PIC2 + 1, 0x00);
  101b98:	58                   	pop    %eax
  101b99:	5a                   	pop    %edx
  101b9a:	6a 00                	push   $0x0
  101b9c:	68 a1 00 00 00       	push   $0xa1
  101ba1:	e8 8a 32 00 00       	call   104e30 <outb>

    // ICW1:  0001g0hi
    //    g:  0 = edge triggering, 1 = level triggering
    //    h:  0 = cascaded PICs, 1 = master only
    //    i:  0 = no ICW4, 1 = ICW4 required
    outb(IO_PIC1, 0x11);
  101ba6:	59                   	pop    %ecx
  101ba7:	58                   	pop    %eax
  101ba8:	6a 11                	push   $0x11
  101baa:	6a 20                	push   $0x20
  101bac:	e8 7f 32 00 00       	call   104e30 <outb>

    // ICW2:  Vector offset
    outb(IO_PIC1 + 1, T_IRQ0);
  101bb1:	58                   	pop    %eax
  101bb2:	5a                   	pop    %edx
  101bb3:	6a 20                	push   $0x20
  101bb5:	6a 21                	push   $0x21
  101bb7:	e8 74 32 00 00       	call   104e30 <outb>

    // ICW3:  bit mask of IR lines connected to slave PICs (master PIC),
    //        3-bit No of IR line at which slave connects to master(slave PIC).
    outb(IO_PIC1 + 1, 1 << IRQ_SLAVE);
  101bbc:	59                   	pop    %ecx
  101bbd:	58                   	pop    %eax
  101bbe:	6a 04                	push   $0x4
  101bc0:	6a 21                	push   $0x21
  101bc2:	e8 69 32 00 00       	call   104e30 <outb>
    //    m:  0 = slave PIC, 1 = master PIC
    //        (ignored when b is 0, as the master/slave role
    //        can be hardwired).
    //    a:  1 = Automatic EOI mode
    //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
    outb(IO_PIC1 + 1, 0x3);
  101bc7:	58                   	pop    %eax
  101bc8:	5a                   	pop    %edx
  101bc9:	6a 03                	push   $0x3
  101bcb:	6a 21                	push   $0x21
  101bcd:	e8 5e 32 00 00       	call   104e30 <outb>

    // Set up slave (8259A-2)
    outb(IO_PIC2, 0x11);            // ICW1
  101bd2:	59                   	pop    %ecx
  101bd3:	58                   	pop    %eax
  101bd4:	6a 11                	push   $0x11
  101bd6:	68 a0 00 00 00       	push   $0xa0
  101bdb:	e8 50 32 00 00       	call   104e30 <outb>
    outb(IO_PIC2 + 1, T_IRQ0 + 8);  // ICW2
  101be0:	58                   	pop    %eax
  101be1:	5a                   	pop    %edx
  101be2:	6a 28                	push   $0x28
  101be4:	68 a1 00 00 00       	push   $0xa1
  101be9:	e8 42 32 00 00       	call   104e30 <outb>
    outb(IO_PIC2 + 1, IRQ_SLAVE);   // ICW3
  101bee:	59                   	pop    %ecx
  101bef:	58                   	pop    %eax
  101bf0:	6a 02                	push   $0x2
  101bf2:	68 a1 00 00 00       	push   $0xa1
  101bf7:	e8 34 32 00 00       	call   104e30 <outb>
    // NB Automatic EOI mode doesn't tend to work on the slave.
    // Linux source code says it's "to be investigated".
    outb(IO_PIC2 + 1, 0x01);        // ICW4
  101bfc:	58                   	pop    %eax
  101bfd:	5a                   	pop    %edx
  101bfe:	6a 01                	push   $0x1
  101c00:	68 a1 00 00 00       	push   $0xa1
  101c05:	e8 26 32 00 00       	call   104e30 <outb>

    // OCW3:  0ef01prs
    //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
    //    p:  0 = no polling, 1 = polling mode
    //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
    outb(IO_PIC1, 0x68);  /* clear specific mask */
  101c0a:	59                   	pop    %ecx
  101c0b:	58                   	pop    %eax
  101c0c:	6a 68                	push   $0x68
  101c0e:	6a 20                	push   $0x20
  101c10:	e8 1b 32 00 00       	call   104e30 <outb>
    outb(IO_PIC1, 0x0a);  /* read IRR by default */
  101c15:	58                   	pop    %eax
  101c16:	5a                   	pop    %edx
  101c17:	6a 0a                	push   $0xa
  101c19:	6a 20                	push   $0x20
  101c1b:	e8 10 32 00 00       	call   104e30 <outb>

    outb(IO_PIC2, 0x68);  /* OCW3 */
  101c20:	59                   	pop    %ecx
  101c21:	58                   	pop    %eax
  101c22:	6a 68                	push   $0x68
  101c24:	68 a0 00 00 00       	push   $0xa0
  101c29:	e8 02 32 00 00       	call   104e30 <outb>
    outb(IO_PIC2, 0x0a);  /* OCW3 */
  101c2e:	58                   	pop    %eax
  101c2f:	5a                   	pop    %edx
  101c30:	6a 0a                	push   $0xa
  101c32:	68 a0 00 00 00       	push   $0xa0
  101c37:	e8 f4 31 00 00       	call   104e30 <outb>
}
  101c3c:	83 c4 18             	add    $0x18,%esp
  101c3f:	5b                   	pop    %ebx
  101c40:	c3                   	ret    
  101c41:	66 90                	xchg   %ax,%ax
  101c43:	66 90                	xchg   %ax,%ax
  101c45:	66 90                	xchg   %ax,%ax
  101c47:	66 90                	xchg   %ax,%ax
  101c49:	66 90                	xchg   %ax,%ax
  101c4b:	66 90                	xchg   %ax,%ax
  101c4d:	66 90                	xchg   %ax,%ax
  101c4f:	90                   	nop

00101c50 <timer_hw_init>:
#define TIMER_16BIT   0x30  /* r/w counter 16 bits, LSB first */

// Initialize the programmable interval timer.

void timer_hw_init(void)
{
  101c50:	53                   	push   %ebx
  101c51:	e8 33 e7 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101c56:	81 c3 aa e3 00 00    	add    $0xe3aa,%ebx
  101c5c:	83 ec 10             	sub    $0x10,%esp
    outb(PIT_CONTROL, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  101c5f:	6a 34                	push   $0x34
  101c61:	6a 43                	push   $0x43
  101c63:	e8 c8 31 00 00       	call   104e30 <outb>
    outb(PIT_CHANNEL0, LOW8(LATCH));
  101c68:	58                   	pop    %eax
  101c69:	5a                   	pop    %edx
  101c6a:	68 9c 00 00 00       	push   $0x9c
  101c6f:	6a 40                	push   $0x40
  101c71:	e8 ba 31 00 00       	call   104e30 <outb>
    outb(PIT_CHANNEL0, HIGH8(LATCH));
  101c76:	59                   	pop    %ecx
  101c77:	58                   	pop    %eax
  101c78:	6a 2e                	push   $0x2e
  101c7a:	6a 40                	push   $0x40
  101c7c:	e8 af 31 00 00       	call   104e30 <outb>
}
  101c81:	83 c4 18             	add    $0x18,%esp
  101c84:	5b                   	pop    %ebx
  101c85:	c3                   	ret    
  101c86:	66 90                	xchg   %ax,%ax
  101c88:	66 90                	xchg   %ax,%ax
  101c8a:	66 90                	xchg   %ax,%ax
  101c8c:	66 90                	xchg   %ax,%ax
  101c8e:	66 90                	xchg   %ax,%ax

00101c90 <tsc_init>:
    delta = t2 - t1;
    return delta / ms;
}

int tsc_init(void)
{
  101c90:	55                   	push   %ebp
  101c91:	57                   	push   %edi
  101c92:	56                   	push   %esi
  101c93:	53                   	push   %ebx
  101c94:	e8 f0 e6 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  101c99:	81 c3 67 e3 00 00    	add    $0xe367,%ebx
  101c9f:	83 ec 4c             	sub    $0x4c,%esp
    uint64_t ret;
    int i;

    timer_hw_init();
  101ca2:	e8 a9 ff ff ff       	call   101c50 <timer_hw_init>

    tsc_per_ms = 0;
  101ca7:	c7 83 88 88 02 00 00 	movl   $0x0,0x28888(%ebx)
  101cae:	00 00 00 
  101cb1:	c7 83 8c 88 02 00 00 	movl   $0x0,0x2888c(%ebx)
  101cb8:	00 00 00 

    if (detect_kvm())
  101cbb:	e8 70 1e 00 00       	call   103b30 <detect_kvm>
  101cc0:	89 44 24 3c          	mov    %eax,0x3c(%esp)
  101cc4:	85 c0                	test   %eax,%eax
  101cc6:	0f 85 c1 02 00 00    	jne    101f8d <tsc_init+0x2fd>
  101ccc:	8d 83 90 94 ff ff    	lea    -0x6b70(%ebx),%eax

    /*
     * XXX: If TSC calibration fails frequently, try to increase the
     *      upper bound of loop condition, e.g. alternating 3 to 10.
     */
    for (i = 0; i < 10; i++) {
  101cd2:	c7 44 24 24 00 00 00 	movl   $0x0,0x24(%esp)
  101cd9:	00 
  101cda:	89 44 24 34          	mov    %eax,0x34(%esp)
  101cde:	8d 83 b5 94 ff ff    	lea    -0x6b4b(%ebx),%eax
  101ce4:	89 44 24 30          	mov    %eax,0x30(%esp)
        ret = tsc_calibrate(CAL_LATCH, CAL_MS, CAL_PIT_LOOPS);
        if (ret != ~(uint64_t) 0x0)
            break;
        KERN_DEBUG("[%d] Retry to calibrate TSC.\n", i + 1);
  101ce8:	8d 83 dd 94 ff ff    	lea    -0x6b23(%ebx),%eax
  101cee:	89 44 24 38          	mov    %eax,0x38(%esp)
  101cf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    outb(0x61, (inb(0x61) & ~0x02) | 0x01);
  101cf8:	83 ec 0c             	sub    $0xc,%esp
  101cfb:	6a 61                	push   $0x61
  101cfd:	e8 fe 30 00 00       	call   104e00 <inb>
  101d02:	5e                   	pop    %esi
  101d03:	5f                   	pop    %edi
  101d04:	25 fc 00 00 00       	and    $0xfc,%eax
  101d09:	83 c8 01             	or     $0x1,%eax
  101d0c:	50                   	push   %eax
  101d0d:	6a 61                	push   $0x61
  101d0f:	e8 1c 31 00 00       	call   104e30 <outb>
    outb(0x43, 0xb0);
  101d14:	5d                   	pop    %ebp
  101d15:	58                   	pop    %eax
  101d16:	68 b0 00 00 00       	push   $0xb0
  101d1b:	6a 43                	push   $0x43
    pitcnt = 0;
  101d1d:	31 ed                	xor    %ebp,%ebp
    outb(0x43, 0xb0);
  101d1f:	e8 0c 31 00 00       	call   104e30 <outb>
    outb(0x42, latch & 0xff);
  101d24:	58                   	pop    %eax
  101d25:	5a                   	pop    %edx
  101d26:	68 9b 00 00 00       	push   $0x9b
  101d2b:	6a 42                	push   $0x42
  101d2d:	e8 fe 30 00 00       	call   104e30 <outb>
    outb(0x42, latch >> 8);
  101d32:	59                   	pop    %ecx
  101d33:	5e                   	pop    %esi
  101d34:	6a 2e                	push   $0x2e
  101d36:	6a 42                	push   $0x42
  101d38:	e8 f3 30 00 00       	call   104e30 <outb>
    tsc = t1 = t2 = rdtsc();
  101d3d:	e8 5e 2f 00 00       	call   104ca0 <rdtsc>
  101d42:	89 44 24 38          	mov    %eax,0x38(%esp)
  101d46:	89 54 24 3c          	mov    %edx,0x3c(%esp)
    while ((inb(0x61) & 0x20) == 0) {
  101d4a:	83 c4 10             	add    $0x10,%esp
    tsc = t1 = t2 = rdtsc();
  101d4d:	89 44 24 18          	mov    %eax,0x18(%esp)
  101d51:	89 54 24 1c          	mov    %edx,0x1c(%esp)
    tscmax = 0;
  101d55:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  101d5c:	00 
  101d5d:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  101d64:	00 
    tscmin = ~(uint64_t) 0x0;
  101d65:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
  101d6c:	ff 
  101d6d:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  101d74:	ff 
    while ((inb(0x61) & 0x20) == 0) {
  101d75:	eb 63                	jmp    101dda <tsc_init+0x14a>
  101d77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101d7e:	66 90                	xchg   %ax,%ax
        t2 = rdtsc();
  101d80:	e8 1b 2f 00 00       	call   104ca0 <rdtsc>
        delta = t2 - tsc;
  101d85:	89 c6                	mov    %eax,%esi
  101d87:	89 d7                	mov    %edx,%edi
  101d89:	2b 74 24 18          	sub    0x18(%esp),%esi
  101d8d:	1b 7c 24 1c          	sbb    0x1c(%esp),%edi
        if (delta < tscmin)
  101d91:	89 f9                	mov    %edi,%ecx
  101d93:	3b 74 24 08          	cmp    0x8(%esp),%esi
  101d97:	1b 4c 24 0c          	sbb    0xc(%esp),%ecx
        tsc = t2;
  101d9b:	89 44 24 18          	mov    %eax,0x18(%esp)
  101d9f:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  101da3:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  101da7:	0f 42 ce             	cmovb  %esi,%ecx
  101daa:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  101dae:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  101db2:	0f 42 cf             	cmovb  %edi,%ecx
  101db5:	39 74 24 10          	cmp    %esi,0x10(%esp)
  101db9:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
        if (delta > tscmax)
  101dbd:	8b 4c 24 14          	mov    0x14(%esp),%ecx
  101dc1:	19 f9                	sbb    %edi,%ecx
  101dc3:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  101dc7:	0f 43 7c 24 14       	cmovae 0x14(%esp),%edi
  101dcc:	0f 42 ce             	cmovb  %esi,%ecx
  101dcf:	89 7c 24 14          	mov    %edi,0x14(%esp)
        pitcnt++;
  101dd3:	83 c5 01             	add    $0x1,%ebp
  101dd6:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    while ((inb(0x61) & 0x20) == 0) {
  101dda:	83 ec 0c             	sub    $0xc,%esp
  101ddd:	6a 61                	push   $0x61
  101ddf:	e8 1c 30 00 00       	call   104e00 <inb>
  101de4:	83 c4 10             	add    $0x10,%esp
  101de7:	a8 20                	test   $0x20,%al
  101de9:	74 95                	je     101d80 <tsc_init+0xf0>
    KERN_DEBUG("pitcnt=%u, tscmin=%llu, tscmax=%llu\n",
  101deb:	8b 74 24 10          	mov    0x10(%esp),%esi
  101def:	8b 7c 24 14          	mov    0x14(%esp),%edi
  101df3:	57                   	push   %edi
  101df4:	56                   	push   %esi
  101df5:	ff 74 24 14          	push   0x14(%esp)
  101df9:	ff 74 24 14          	push   0x14(%esp)
  101dfd:	55                   	push   %ebp
  101dfe:	ff 74 24 48          	push   0x48(%esp)
  101e02:	6a 39                	push   $0x39
  101e04:	ff 74 24 4c          	push   0x4c(%esp)
  101e08:	e8 e3 21 00 00       	call   103ff0 <debug_normal>
    if (pitcnt < loopmin || tscmax > 10 * tscmin)
  101e0d:	83 c4 20             	add    $0x20,%esp
  101e10:	81 fd e7 03 00 00    	cmp    $0x3e7,%ebp
  101e16:	0f 8e f4 00 00 00    	jle    101f10 <tsc_init+0x280>
  101e1c:	6b 4c 24 0c 0a       	imul   $0xa,0xc(%esp),%ecx
  101e21:	b8 0a 00 00 00       	mov    $0xa,%eax
  101e26:	f7 64 24 08          	mull   0x8(%esp)
  101e2a:	01 ca                	add    %ecx,%edx
  101e2c:	39 f0                	cmp    %esi,%eax
  101e2e:	89 d0                	mov    %edx,%eax
  101e30:	19 f8                	sbb    %edi,%eax
  101e32:	0f 82 d8 00 00 00    	jb     101f10 <tsc_init+0x280>
    delta = t2 - t1;
  101e38:	8b 44 24 18          	mov    0x18(%esp),%eax
  101e3c:	8b 54 24 1c          	mov    0x1c(%esp),%edx
    return delta / ms;
  101e40:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    delta = t2 - t1;
  101e45:	2b 44 24 28          	sub    0x28(%esp),%eax
  101e49:	1b 54 24 2c          	sbb    0x2c(%esp),%edx
    return delta / ms;
  101e4d:	89 54 24 0c          	mov    %edx,0xc(%esp)
  101e51:	89 c6                	mov    %eax,%esi
  101e53:	03 74 24 0c          	add    0xc(%esp),%esi
  101e57:	83 d6 00             	adc    $0x0,%esi
  101e5a:	89 44 24 08          	mov    %eax,0x8(%esp)
  101e5e:	89 f0                	mov    %esi,%eax
  101e60:	f7 e1                	mul    %ecx
  101e62:	8b 44 24 08          	mov    0x8(%esp),%eax
  101e66:	89 d7                	mov    %edx,%edi
  101e68:	83 e2 fc             	and    $0xfffffffc,%edx
  101e6b:	c1 ef 02             	shr    $0x2,%edi
  101e6e:	01 fa                	add    %edi,%edx
  101e70:	31 ff                	xor    %edi,%edi
  101e72:	29 d6                	sub    %edx,%esi
  101e74:	8b 54 24 0c          	mov    0xc(%esp),%edx
  101e78:	29 f0                	sub    %esi,%eax
  101e7a:	19 fa                	sbb    %edi,%edx

        timer_hw_init();
        return 1;
    } else {
        tsc_per_ms = ret;
        KERN_DEBUG("TSC freq = %u.%03u MHz.\n",tsc_per_ms / 1000, tsc_per_ms % 1000);
  101e7c:	83 ec 10             	sub    $0x10,%esp
    return delta / ms;
  101e7f:	69 f2 cd cc cc cc    	imul   $0xcccccccd,%edx,%esi
        KERN_DEBUG("TSC freq = %u.%03u MHz.\n",tsc_per_ms / 1000, tsc_per_ms % 1000);
  101e85:	6a 00                	push   $0x0
    return delta / ms;
  101e87:	69 d0 cc cc cc cc    	imul   $0xcccccccc,%eax,%edx
        KERN_DEBUG("TSC freq = %u.%03u MHz.\n",tsc_per_ms / 1000, tsc_per_ms % 1000);
  101e8d:	68 e8 03 00 00       	push   $0x3e8
    return delta / ms;
  101e92:	01 d6                	add    %edx,%esi
  101e94:	f7 e1                	mul    %ecx
  101e96:	01 f2                	add    %esi,%edx
  101e98:	0f ac d0 01          	shrd   $0x1,%edx,%eax
  101e9c:	d1 ea                	shr    %edx
        tsc_per_ms = ret;
  101e9e:	89 83 88 88 02 00    	mov    %eax,0x28888(%ebx)
  101ea4:	89 93 8c 88 02 00    	mov    %edx,0x2888c(%ebx)
        KERN_DEBUG("TSC freq = %u.%03u MHz.\n",tsc_per_ms / 1000, tsc_per_ms % 1000);
  101eaa:	8b 83 88 88 02 00    	mov    0x28888(%ebx),%eax
  101eb0:	8b 93 8c 88 02 00    	mov    0x2888c(%ebx),%edx
  101eb6:	8b b3 88 88 02 00    	mov    0x28888(%ebx),%esi
  101ebc:	8b bb 8c 88 02 00    	mov    0x2888c(%ebx),%edi
  101ec2:	52                   	push   %edx
  101ec3:	50                   	push   %eax
  101ec4:	e8 c7 62 00 00       	call   108190 <__umoddi3>
  101ec9:	83 c4 1c             	add    $0x1c,%esp
  101ecc:	52                   	push   %edx
  101ecd:	50                   	push   %eax
  101ece:	83 ec 04             	sub    $0x4,%esp
  101ed1:	6a 00                	push   $0x0
  101ed3:	68 e8 03 00 00       	push   $0x3e8
  101ed8:	57                   	push   %edi
  101ed9:	56                   	push   %esi
  101eda:	e8 91 61 00 00       	call   108070 <__udivdi3>
  101edf:	83 c4 14             	add    $0x14,%esp
  101ee2:	52                   	push   %edx
  101ee3:	50                   	push   %eax
  101ee4:	8d 83 c4 94 ff ff    	lea    -0x6b3c(%ebx),%eax
  101eea:	50                   	push   %eax
  101eeb:	6a 68                	push   $0x68
  101eed:	ff 74 24 4c          	push   0x4c(%esp)
  101ef1:	e8 fa 20 00 00       	call   103ff0 <debug_normal>

        timer_hw_init();
  101ef6:	83 c4 20             	add    $0x20,%esp
  101ef9:	e8 52 fd ff ff       	call   101c50 <timer_hw_init>
        return 0;
    }
}
  101efe:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  101f02:	83 c4 4c             	add    $0x4c,%esp
  101f05:	5b                   	pop    %ebx
  101f06:	5e                   	pop    %esi
  101f07:	5f                   	pop    %edi
  101f08:	5d                   	pop    %ebp
  101f09:	c3                   	ret    
  101f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        KERN_DEBUG("[%d] Retry to calibrate TSC.\n", i + 1);
  101f10:	83 44 24 24 01       	addl   $0x1,0x24(%esp)
  101f15:	8b 7c 24 24          	mov    0x24(%esp),%edi
  101f19:	57                   	push   %edi
  101f1a:	ff 74 24 3c          	push   0x3c(%esp)
  101f1e:	6a 5c                	push   $0x5c
  101f20:	ff 74 24 3c          	push   0x3c(%esp)
  101f24:	e8 c7 20 00 00       	call   103ff0 <debug_normal>
    for (i = 0; i < 10; i++) {
  101f29:	83 c4 10             	add    $0x10,%esp
  101f2c:	83 ff 0a             	cmp    $0xa,%edi
  101f2f:	0f 85 c3 fd ff ff    	jne    101cf8 <tsc_init+0x68>
        KERN_DEBUG("TSC calibration failed.\n");
  101f35:	83 ec 04             	sub    $0x4,%esp
  101f38:	8d 83 fb 94 ff ff    	lea    -0x6b05(%ebx),%eax
  101f3e:	50                   	push   %eax
  101f3f:	6a 60                	push   $0x60
  101f41:	8b 7c 24 3c          	mov    0x3c(%esp),%edi
  101f45:	57                   	push   %edi
  101f46:	e8 a5 20 00 00       	call   103ff0 <debug_normal>
        KERN_DEBUG("Assume TSC freq = 1 GHz.\n");
  101f4b:	83 c4 0c             	add    $0xc,%esp
  101f4e:	8d 83 14 95 ff ff    	lea    -0x6aec(%ebx),%eax
  101f54:	50                   	push   %eax
  101f55:	6a 61                	push   $0x61
  101f57:	57                   	push   %edi
  101f58:	e8 93 20 00 00       	call   103ff0 <debug_normal>
        tsc_per_ms = 1000000;
  101f5d:	c7 83 88 88 02 00 40 	movl   $0xf4240,0x28888(%ebx)
  101f64:	42 0f 00 
  101f67:	c7 83 8c 88 02 00 00 	movl   $0x0,0x2888c(%ebx)
  101f6e:	00 00 00 
        timer_hw_init();
  101f71:	e8 da fc ff ff       	call   101c50 <timer_hw_init>
        return 1;
  101f76:	83 c4 10             	add    $0x10,%esp
  101f79:	c7 44 24 3c 01 00 00 	movl   $0x1,0x3c(%esp)
  101f80:	00 
}
  101f81:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  101f85:	83 c4 4c             	add    $0x4c,%esp
  101f88:	5b                   	pop    %ebx
  101f89:	5e                   	pop    %esi
  101f8a:	5f                   	pop    %edi
  101f8b:	5d                   	pop    %ebp
  101f8c:	c3                   	ret    
		tsc_per_ms = kvm_get_tsc_hz() / 1000llu;
  101f8d:	e8 de 1c 00 00       	call   103c70 <kvm_get_tsc_hz>
  101f92:	6a 00                	push   $0x0
  101f94:	68 e8 03 00 00       	push   $0x3e8
  101f99:	52                   	push   %edx
  101f9a:	50                   	push   %eax
  101f9b:	e8 d0 60 00 00       	call   108070 <__udivdi3>
		KERN_INFO ("TSC read from KVM: %u.%03u MHz.\n",
  101fa0:	6a 00                	push   $0x0
		tsc_per_ms = kvm_get_tsc_hz() / 1000llu;
  101fa2:	89 83 88 88 02 00    	mov    %eax,0x28888(%ebx)
  101fa8:	89 93 8c 88 02 00    	mov    %edx,0x2888c(%ebx)
		KERN_INFO ("TSC read from KVM: %u.%03u MHz.\n",
  101fae:	8b 83 88 88 02 00    	mov    0x28888(%ebx),%eax
  101fb4:	8b 93 8c 88 02 00    	mov    0x2888c(%ebx),%edx
  101fba:	68 e8 03 00 00       	push   $0x3e8
  101fbf:	8b b3 88 88 02 00    	mov    0x28888(%ebx),%esi
  101fc5:	8b bb 8c 88 02 00    	mov    0x2888c(%ebx),%edi
  101fcb:	52                   	push   %edx
  101fcc:	50                   	push   %eax
  101fcd:	e8 be 61 00 00       	call   108190 <__umoddi3>
  101fd2:	83 c4 14             	add    $0x14,%esp
  101fd5:	52                   	push   %edx
  101fd6:	50                   	push   %eax
  101fd7:	83 ec 0c             	sub    $0xc,%esp
  101fda:	6a 00                	push   $0x0
  101fdc:	68 e8 03 00 00       	push   $0x3e8
  101fe1:	57                   	push   %edi
  101fe2:	56                   	push   %esi
  101fe3:	e8 88 60 00 00       	call   108070 <__udivdi3>
  101fe8:	83 c4 1c             	add    $0x1c,%esp
  101feb:	52                   	push   %edx
  101fec:	50                   	push   %eax
  101fed:	8d 83 6c 94 ff ff    	lea    -0x6b94(%ebx),%eax
  101ff3:	50                   	push   %eax
  101ff4:	e8 c7 1f 00 00       	call   103fc0 <debug_info>
		return (0);
  101ff9:	83 c4 20             	add    $0x20,%esp
  101ffc:	c7 44 24 3c 00 00 00 	movl   $0x0,0x3c(%esp)
  102003:	00 
}
  102004:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  102008:	83 c4 4c             	add    $0x4c,%esp
  10200b:	5b                   	pop    %ebx
  10200c:	5e                   	pop    %esi
  10200d:	5f                   	pop    %edi
  10200e:	5d                   	pop    %ebp
  10200f:	c3                   	ret    

00102010 <delay>:

/*
 * Wait for ms millisecond.
 */
void delay(uint32_t ms)
{
  102010:	55                   	push   %ebp
  102011:	57                   	push   %edi
  102012:	56                   	push   %esi
  102013:	53                   	push   %ebx
  102014:	e8 70 e3 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102019:	81 c3 e7 df 00 00    	add    $0xdfe7,%ebx
  10201f:	83 ec 1c             	sub    $0x1c,%esp
  102022:	8b 44 24 30          	mov    0x30(%esp),%eax
    volatile uint64_t ticks = tsc_per_ms * ms;
  102026:	8b b3 88 88 02 00    	mov    0x28888(%ebx),%esi
  10202c:	8b 8b 8c 88 02 00    	mov    0x2888c(%ebx),%ecx
  102032:	0f af c8             	imul   %eax,%ecx
  102035:	f7 e6                	mul    %esi
  102037:	01 ca                	add    %ecx,%edx
  102039:	89 04 24             	mov    %eax,(%esp)
  10203c:	89 54 24 04          	mov    %edx,0x4(%esp)
    volatile uint64_t start = rdtsc();
  102040:	e8 5b 2c 00 00       	call   104ca0 <rdtsc>
  102045:	89 44 24 08          	mov    %eax,0x8(%esp)
  102049:	89 54 24 0c          	mov    %edx,0xc(%esp)
    while (rdtsc() < start + ticks);
  10204d:	8d 76 00             	lea    0x0(%esi),%esi
  102050:	e8 4b 2c 00 00       	call   104ca0 <rdtsc>
  102055:	89 c1                	mov    %eax,%ecx
  102057:	89 d5                	mov    %edx,%ebp
  102059:	8b 44 24 08          	mov    0x8(%esp),%eax
  10205d:	8b 54 24 0c          	mov    0xc(%esp),%edx
  102061:	8b 34 24             	mov    (%esp),%esi
  102064:	8b 7c 24 04          	mov    0x4(%esp),%edi
  102068:	01 f0                	add    %esi,%eax
  10206a:	11 fa                	adc    %edi,%edx
  10206c:	39 c1                	cmp    %eax,%ecx
  10206e:	19 d5                	sbb    %edx,%ebp
  102070:	72 de                	jb     102050 <delay+0x40>
}
  102072:	83 c4 1c             	add    $0x1c,%esp
  102075:	5b                   	pop    %ebx
  102076:	5e                   	pop    %esi
  102077:	5f                   	pop    %edi
  102078:	5d                   	pop    %ebp
  102079:	c3                   	ret    
  10207a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102080 <udelay>:

/*
 * Wait for us microsecond.
 */
void udelay(uint32_t us)
{
  102080:	55                   	push   %ebp
  102081:	57                   	push   %edi
  102082:	56                   	push   %esi
  102083:	53                   	push   %ebx
  102084:	e8 00 e3 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102089:	81 c3 77 df 00 00    	add    $0xdf77,%ebx
  10208f:	83 ec 1c             	sub    $0x1c,%esp
  102092:	8b 74 24 30          	mov    0x30(%esp),%esi
    volatile uint64_t ticks = tsc_per_ms / 1000 * us;
  102096:	6a 00                	push   $0x0
  102098:	68 e8 03 00 00       	push   $0x3e8
  10209d:	8b 83 88 88 02 00    	mov    0x28888(%ebx),%eax
  1020a3:	8b 93 8c 88 02 00    	mov    0x2888c(%ebx),%edx
  1020a9:	52                   	push   %edx
  1020aa:	50                   	push   %eax
  1020ab:	e8 c0 5f 00 00       	call   108070 <__udivdi3>
  1020b0:	83 c4 10             	add    $0x10,%esp
  1020b3:	89 d1                	mov    %edx,%ecx
  1020b5:	f7 e6                	mul    %esi
  1020b7:	0f af ce             	imul   %esi,%ecx
  1020ba:	89 04 24             	mov    %eax,(%esp)
  1020bd:	01 ca                	add    %ecx,%edx
  1020bf:	89 54 24 04          	mov    %edx,0x4(%esp)
    volatile uint64_t start = rdtsc();
  1020c3:	e8 d8 2b 00 00       	call   104ca0 <rdtsc>
  1020c8:	89 44 24 08          	mov    %eax,0x8(%esp)
  1020cc:	89 54 24 0c          	mov    %edx,0xc(%esp)
    while (rdtsc() < start + ticks);
  1020d0:	e8 cb 2b 00 00       	call   104ca0 <rdtsc>
  1020d5:	89 c1                	mov    %eax,%ecx
  1020d7:	89 d5                	mov    %edx,%ebp
  1020d9:	8b 44 24 08          	mov    0x8(%esp),%eax
  1020dd:	8b 54 24 0c          	mov    0xc(%esp),%edx
  1020e1:	8b 34 24             	mov    (%esp),%esi
  1020e4:	8b 7c 24 04          	mov    0x4(%esp),%edi
  1020e8:	01 f0                	add    %esi,%eax
  1020ea:	11 fa                	adc    %edi,%edx
  1020ec:	39 c1                	cmp    %eax,%ecx
  1020ee:	19 d5                	sbb    %edx,%ebp
  1020f0:	72 de                	jb     1020d0 <udelay+0x50>
}
  1020f2:	83 c4 1c             	add    $0x1c,%esp
  1020f5:	5b                   	pop    %ebx
  1020f6:	5e                   	pop    %esi
  1020f7:	5f                   	pop    %edi
  1020f8:	5d                   	pop    %ebp
  1020f9:	c3                   	ret    
  1020fa:	66 90                	xchg   %ax,%ax
  1020fc:	66 90                	xchg   %ax,%ax
  1020fe:	66 90                	xchg   %ax,%ax

00102100 <Xdivide>:
	jmp	_alltraps

.text

/* exceptions  */
TRAPHANDLER_NOEC(Xdivide,	T_DIVIDE)
  102100:	6a 00                	push   $0x0
  102102:	6a 00                	push   $0x0
  102104:	e9 17 01 00 00       	jmp    102220 <_alltraps>
  102109:	90                   	nop

0010210a <Xdebug>:
TRAPHANDLER_NOEC(Xdebug,	T_DEBUG)
  10210a:	6a 00                	push   $0x0
  10210c:	6a 01                	push   $0x1
  10210e:	e9 0d 01 00 00       	jmp    102220 <_alltraps>
  102113:	90                   	nop

00102114 <Xnmi>:
TRAPHANDLER_NOEC(Xnmi,		T_NMI)
  102114:	6a 00                	push   $0x0
  102116:	6a 02                	push   $0x2
  102118:	e9 03 01 00 00       	jmp    102220 <_alltraps>
  10211d:	90                   	nop

0010211e <Xbrkpt>:
TRAPHANDLER_NOEC(Xbrkpt,	T_BRKPT)
  10211e:	6a 00                	push   $0x0
  102120:	6a 03                	push   $0x3
  102122:	e9 f9 00 00 00       	jmp    102220 <_alltraps>
  102127:	90                   	nop

00102128 <Xoflow>:
TRAPHANDLER_NOEC(Xoflow,	T_OFLOW)
  102128:	6a 00                	push   $0x0
  10212a:	6a 04                	push   $0x4
  10212c:	e9 ef 00 00 00       	jmp    102220 <_alltraps>
  102131:	90                   	nop

00102132 <Xbound>:
TRAPHANDLER_NOEC(Xbound,	T_BOUND)
  102132:	6a 00                	push   $0x0
  102134:	6a 05                	push   $0x5
  102136:	e9 e5 00 00 00       	jmp    102220 <_alltraps>
  10213b:	90                   	nop

0010213c <Xillop>:
TRAPHANDLER_NOEC(Xillop,	T_ILLOP)
  10213c:	6a 00                	push   $0x0
  10213e:	6a 06                	push   $0x6
  102140:	e9 db 00 00 00       	jmp    102220 <_alltraps>
  102145:	90                   	nop

00102146 <Xdevice>:
TRAPHANDLER_NOEC(Xdevice,	T_DEVICE)
  102146:	6a 00                	push   $0x0
  102148:	6a 07                	push   $0x7
  10214a:	e9 d1 00 00 00       	jmp    102220 <_alltraps>
  10214f:	90                   	nop

00102150 <Xdblflt>:
TRAPHANDLER     (Xdblflt,	T_DBLFLT)
  102150:	6a 08                	push   $0x8
  102152:	e9 c9 00 00 00       	jmp    102220 <_alltraps>
  102157:	90                   	nop

00102158 <Xcoproc>:
TRAPHANDLER_NOEC(Xcoproc,	T_COPROC)
  102158:	6a 00                	push   $0x0
  10215a:	6a 09                	push   $0x9
  10215c:	e9 bf 00 00 00       	jmp    102220 <_alltraps>
  102161:	90                   	nop

00102162 <Xtss>:
TRAPHANDLER     (Xtss,		T_TSS)
  102162:	6a 0a                	push   $0xa
  102164:	e9 b7 00 00 00       	jmp    102220 <_alltraps>
  102169:	90                   	nop

0010216a <Xsegnp>:
TRAPHANDLER     (Xsegnp,	T_SEGNP)
  10216a:	6a 0b                	push   $0xb
  10216c:	e9 af 00 00 00       	jmp    102220 <_alltraps>
  102171:	90                   	nop

00102172 <Xstack>:
TRAPHANDLER     (Xstack,	T_STACK)
  102172:	6a 0c                	push   $0xc
  102174:	e9 a7 00 00 00       	jmp    102220 <_alltraps>
  102179:	90                   	nop

0010217a <Xgpflt>:
TRAPHANDLER     (Xgpflt,	T_GPFLT)
  10217a:	6a 0d                	push   $0xd
  10217c:	e9 9f 00 00 00       	jmp    102220 <_alltraps>
  102181:	90                   	nop

00102182 <Xpgflt>:
TRAPHANDLER     (Xpgflt,	T_PGFLT)
  102182:	6a 0e                	push   $0xe
  102184:	e9 97 00 00 00       	jmp    102220 <_alltraps>
  102189:	90                   	nop

0010218a <Xres>:
TRAPHANDLER_NOEC(Xres,		T_RES)
  10218a:	6a 00                	push   $0x0
  10218c:	6a 0f                	push   $0xf
  10218e:	e9 8d 00 00 00       	jmp    102220 <_alltraps>
  102193:	90                   	nop

00102194 <Xfperr>:
TRAPHANDLER_NOEC(Xfperr,	T_FPERR)
  102194:	6a 00                	push   $0x0
  102196:	6a 10                	push   $0x10
  102198:	e9 83 00 00 00       	jmp    102220 <_alltraps>
  10219d:	90                   	nop

0010219e <Xalign>:
TRAPHANDLER     (Xalign,	T_ALIGN)
  10219e:	6a 11                	push   $0x11
  1021a0:	eb 7e                	jmp    102220 <_alltraps>

001021a2 <Xmchk>:
TRAPHANDLER_NOEC(Xmchk,		T_MCHK)
  1021a2:	6a 00                	push   $0x0
  1021a4:	6a 12                	push   $0x12
  1021a6:	eb 78                	jmp    102220 <_alltraps>

001021a8 <Xirq_timer>:

/* ISA interrupts  */
TRAPHANDLER_NOEC(Xirq_timer,	T_IRQ0 + IRQ_TIMER)
  1021a8:	6a 00                	push   $0x0
  1021aa:	6a 20                	push   $0x20
  1021ac:	eb 72                	jmp    102220 <_alltraps>

001021ae <Xirq_kbd>:
TRAPHANDLER_NOEC(Xirq_kbd,	T_IRQ0 + IRQ_KBD)
  1021ae:	6a 00                	push   $0x0
  1021b0:	6a 21                	push   $0x21
  1021b2:	eb 6c                	jmp    102220 <_alltraps>

001021b4 <Xirq_slave>:
TRAPHANDLER_NOEC(Xirq_slave,	T_IRQ0 + IRQ_SLAVE)
  1021b4:	6a 00                	push   $0x0
  1021b6:	6a 22                	push   $0x22
  1021b8:	eb 66                	jmp    102220 <_alltraps>

001021ba <Xirq_serial2>:
TRAPHANDLER_NOEC(Xirq_serial2,	T_IRQ0 + IRQ_SERIAL24)
  1021ba:	6a 00                	push   $0x0
  1021bc:	6a 23                	push   $0x23
  1021be:	eb 60                	jmp    102220 <_alltraps>

001021c0 <Xirq_serial1>:
TRAPHANDLER_NOEC(Xirq_serial1,	T_IRQ0 + IRQ_SERIAL13)
  1021c0:	6a 00                	push   $0x0
  1021c2:	6a 24                	push   $0x24
  1021c4:	eb 5a                	jmp    102220 <_alltraps>

001021c6 <Xirq_lpt>:
TRAPHANDLER_NOEC(Xirq_lpt,	T_IRQ0 + IRQ_LPT2)
  1021c6:	6a 00                	push   $0x0
  1021c8:	6a 25                	push   $0x25
  1021ca:	eb 54                	jmp    102220 <_alltraps>

001021cc <Xirq_floppy>:
TRAPHANDLER_NOEC(Xirq_floppy,	T_IRQ0 + IRQ_FLOPPY)
  1021cc:	6a 00                	push   $0x0
  1021ce:	6a 26                	push   $0x26
  1021d0:	eb 4e                	jmp    102220 <_alltraps>

001021d2 <Xirq_spurious>:
TRAPHANDLER_NOEC(Xirq_spurious,	T_IRQ0 + IRQ_SPURIOUS)
  1021d2:	6a 00                	push   $0x0
  1021d4:	6a 27                	push   $0x27
  1021d6:	eb 48                	jmp    102220 <_alltraps>

001021d8 <Xirq_rtc>:
TRAPHANDLER_NOEC(Xirq_rtc,	T_IRQ0 + IRQ_RTC)
  1021d8:	6a 00                	push   $0x0
  1021da:	6a 28                	push   $0x28
  1021dc:	eb 42                	jmp    102220 <_alltraps>

001021de <Xirq9>:
TRAPHANDLER_NOEC(Xirq9,		T_IRQ0 + 9)
  1021de:	6a 00                	push   $0x0
  1021e0:	6a 29                	push   $0x29
  1021e2:	eb 3c                	jmp    102220 <_alltraps>

001021e4 <Xirq10>:
TRAPHANDLER_NOEC(Xirq10,	T_IRQ0 + 10)
  1021e4:	6a 00                	push   $0x0
  1021e6:	6a 2a                	push   $0x2a
  1021e8:	eb 36                	jmp    102220 <_alltraps>

001021ea <Xirq11>:
TRAPHANDLER_NOEC(Xirq11,	T_IRQ0 + 11)
  1021ea:	6a 00                	push   $0x0
  1021ec:	6a 2b                	push   $0x2b
  1021ee:	eb 30                	jmp    102220 <_alltraps>

001021f0 <Xirq_mouse>:
TRAPHANDLER_NOEC(Xirq_mouse,	T_IRQ0 + IRQ_MOUSE)
  1021f0:	6a 00                	push   $0x0
  1021f2:	6a 2c                	push   $0x2c
  1021f4:	eb 2a                	jmp    102220 <_alltraps>

001021f6 <Xirq_coproc>:
TRAPHANDLER_NOEC(Xirq_coproc,	T_IRQ0 + IRQ_COPROCESSOR)
  1021f6:	6a 00                	push   $0x0
  1021f8:	6a 2d                	push   $0x2d
  1021fa:	eb 24                	jmp    102220 <_alltraps>

001021fc <Xirq_ide1>:
TRAPHANDLER_NOEC(Xirq_ide1,	T_IRQ0 + IRQ_IDE1)
  1021fc:	6a 00                	push   $0x0
  1021fe:	6a 2e                	push   $0x2e
  102200:	eb 1e                	jmp    102220 <_alltraps>

00102202 <Xirq_ide2>:
TRAPHANDLER_NOEC(Xirq_ide2,	T_IRQ0 + IRQ_IDE2)
  102202:	6a 00                	push   $0x0
  102204:	6a 2f                	push   $0x2f
  102206:	eb 18                	jmp    102220 <_alltraps>

00102208 <Xsyscall>:

/* syscall */
TRAPHANDLER_NOEC(Xsyscall,	T_SYSCALL)
  102208:	6a 00                	push   $0x0
  10220a:	6a 30                	push   $0x30
  10220c:	eb 12                	jmp    102220 <_alltraps>

0010220e <Xdefault>:

/* default ? */
TRAPHANDLER     (Xdefault,	T_DEFAULT)
  10220e:	68 fe 00 00 00       	push   $0xfe
  102213:	eb 0b                	jmp    102220 <_alltraps>
  102215:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10221c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102220 <_alltraps>:

	.globl _alltraps
	.type _alltraps, @function
	.p2align 4, 0x90	/* 16-byte alignment, nop filled */
_alltraps:
	cli			# make sure there is no nested trap
  102220:	fa                   	cli    
	cld
  102221:	fc                   	cld    

	pushl	%ds		# build context
  102222:	1e                   	push   %ds
	pushl	%es
  102223:	06                   	push   %es
	pushal
  102224:	60                   	pusha  

	movl	$CPU_GDT_KDATA, %eax	# load kernel's data segment
  102225:	b8 10 00 00 00       	mov    $0x10,%eax
	movw	%ax, %ds
  10222a:	8e d8                	mov    %eax,%ds
	movw	%ax, %es
  10222c:	8e c0                	mov    %eax,%es

	pushl	%esp		# pass pointer to this trapframe
  10222e:	54                   	push   %esp

	call	trap		# and call trap (does not return)
  10222f:	e8 fc 5a 00 00       	call   107d30 <trap>

1:	hlt			# should never get here; just spin...
  102234:	f4                   	hlt    
  102235:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10223c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102240 <trap_return>:
//
	.globl trap_return
	.type trap_return, @function
	.p2align 4, 0x90	/* 16-byte alignment, nop filled */
trap_return:
	movl	4(%esp), %esp	// reset stack pointer to point to trap frame
  102240:	8b 64 24 04          	mov    0x4(%esp),%esp
	popal			// restore general-purpose registers except esp
  102244:	61                   	popa   
	popl	%es		// restore data segment registers
  102245:	07                   	pop    %es
	popl	%ds
  102246:	1f                   	pop    %ds
	addl	$8, %esp	// skip tf_trapno and tf_errcode
  102247:	83 c4 08             	add    $0x8,%esp
	iret			// return from trap handler
  10224a:	cf                   	iret   
  10224b:	66 90                	xchg   %ax,%ax
  10224d:	66 90                	xchg   %ax,%ax
  10224f:	90                   	nop

00102250 <acpi_probe_rsdp>:

    return NULL;
}

acpi_rsdp_t *acpi_probe_rsdp(void)
{
  102250:	57                   	push   %edi
  102251:	56                   	push   %esi
  102252:	53                   	push   %ebx
    uint8_t *bda;
    uint32_t p;
    acpi_rsdp_t *rsdp;

    bda = (uint8_t *) 0x400;
    if ((p = ((bda[0x0F] << 8) | bda[0x0E]) << 4)) {
  102253:	0f b6 05 0f 04 00 00 	movzbl 0x40f,%eax
  10225a:	0f b6 15 0e 04 00 00 	movzbl 0x40e,%edx
  102261:	c1 e0 08             	shl    $0x8,%eax
  102264:	09 d0                	or     %edx,%eax
  102266:	c1 e0 04             	shl    $0x4,%eax
  102269:	74 4d                	je     1022b8 <acpi_probe_rsdp+0x68>
        if (*(uint32_t *) p == ACPI_RSDP_SIG1 &&
  10226b:	81 38 52 53 44 20    	cmpl   $0x20445352,(%eax)
    e = addr + length;
  102271:	8d 88 00 04 00 00    	lea    0x400(%eax),%ecx
        if (*(uint32_t *) p == ACPI_RSDP_SIG1 &&
  102277:	74 16                	je     10228f <acpi_probe_rsdp+0x3f>
  102279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for (p = addr; p < e; p += 16) {
  102280:	83 c0 10             	add    $0x10,%eax
  102283:	39 c1                	cmp    %eax,%ecx
  102285:	76 31                	jbe    1022b8 <acpi_probe_rsdp+0x68>
        if (*(uint32_t *) p == ACPI_RSDP_SIG1 &&
  102287:	81 38 52 53 44 20    	cmpl   $0x20445352,(%eax)
  10228d:	75 f1                	jne    102280 <acpi_probe_rsdp+0x30>
  10228f:	81 78 04 50 54 52 20 	cmpl   $0x20525450,0x4(%eax)
  102296:	75 e8                	jne    102280 <acpi_probe_rsdp+0x30>
  102298:	89 c2                	mov    %eax,%edx
    sum = 0;
  10229a:	31 db                	xor    %ebx,%ebx
  10229c:	8d 70 24             	lea    0x24(%eax),%esi
  10229f:	90                   	nop
        sum += addr[i];
  1022a0:	0f b6 3a             	movzbl (%edx),%edi
    for (i = 0; i < len; i++) {
  1022a3:	83 c2 01             	add    $0x1,%edx
        sum += addr[i];
  1022a6:	01 fb                	add    %edi,%ebx
    for (i = 0; i < len; i++) {
  1022a8:	39 d6                	cmp    %edx,%esi
  1022aa:	75 f4                	jne    1022a0 <acpi_probe_rsdp+0x50>
            *(uint32_t *) (p + 4) == ACPI_RSDP_SIG2 &&
  1022ac:	84 db                	test   %bl,%bl
  1022ae:	75 d0                	jne    102280 <acpi_probe_rsdp+0x30>
        if ((rsdp = acpi_probe_rsdp_aux((uint8_t *) p, 1024)))
            return rsdp;
    }

    return acpi_probe_rsdp_aux((uint8_t *) 0xE0000, 0x1FFFF);
}
  1022b0:	5b                   	pop    %ebx
  1022b1:	5e                   	pop    %esi
  1022b2:	5f                   	pop    %edi
  1022b3:	c3                   	ret    
  1022b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1022b8:	b8 00 00 0e 00       	mov    $0xe0000,%eax
  1022bd:	eb 0b                	jmp    1022ca <acpi_probe_rsdp+0x7a>
  1022bf:	90                   	nop
    for (p = addr; p < e; p += 16) {
  1022c0:	83 c0 10             	add    $0x10,%eax
  1022c3:	3d 00 00 10 00       	cmp    $0x100000,%eax
  1022c8:	74 38                	je     102302 <acpi_probe_rsdp+0xb2>
        if (*(uint32_t *) p == ACPI_RSDP_SIG1 &&
  1022ca:	81 38 52 53 44 20    	cmpl   $0x20445352,(%eax)
  1022d0:	75 ee                	jne    1022c0 <acpi_probe_rsdp+0x70>
  1022d2:	81 78 04 50 54 52 20 	cmpl   $0x20525450,0x4(%eax)
  1022d9:	75 e5                	jne    1022c0 <acpi_probe_rsdp+0x70>
  1022db:	89 c2                	mov    %eax,%edx
    sum = 0;
  1022dd:	31 c9                	xor    %ecx,%ecx
  1022df:	8d 70 24             	lea    0x24(%eax),%esi
  1022e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        sum += addr[i];
  1022e8:	0f b6 1a             	movzbl (%edx),%ebx
    for (i = 0; i < len; i++) {
  1022eb:	83 c2 01             	add    $0x1,%edx
        sum += addr[i];
  1022ee:	01 d9                	add    %ebx,%ecx
    for (i = 0; i < len; i++) {
  1022f0:	39 f2                	cmp    %esi,%edx
  1022f2:	75 f4                	jne    1022e8 <acpi_probe_rsdp+0x98>
            *(uint32_t *) (p + 4) == ACPI_RSDP_SIG2 &&
  1022f4:	84 c9                	test   %cl,%cl
  1022f6:	74 b8                	je     1022b0 <acpi_probe_rsdp+0x60>
    for (p = addr; p < e; p += 16) {
  1022f8:	83 c0 10             	add    $0x10,%eax
  1022fb:	3d 00 00 10 00       	cmp    $0x100000,%eax
  102300:	75 c8                	jne    1022ca <acpi_probe_rsdp+0x7a>
}
  102302:	5b                   	pop    %ebx
    return NULL;
  102303:	31 c0                	xor    %eax,%eax
}
  102305:	5e                   	pop    %esi
  102306:	5f                   	pop    %edi
  102307:	c3                   	ret    
  102308:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10230f:	90                   	nop

00102310 <acpi_probe_rsdt>:

acpi_rsdt_t *acpi_probe_rsdt(acpi_rsdp_t *rsdp)
{
  102310:	56                   	push   %esi
  102311:	53                   	push   %ebx
  102312:	e8 72 e0 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102317:	81 c3 e9 dc 00 00    	add    $0xdce9,%ebx
  10231d:	83 ec 04             	sub    $0x4,%esp
  102320:	8b 74 24 10          	mov    0x10(%esp),%esi
    KERN_ASSERT(rsdp != NULL);
  102324:	85 f6                	test   %esi,%esi
  102326:	74 50                	je     102378 <acpi_probe_rsdt+0x68>

    acpi_rsdt_t *rsdt = (acpi_rsdt_t *) (rsdp->rsdt_addr);
  102328:	8b 5e 10             	mov    0x10(%esi),%ebx
  10232b:	89 d8                	mov    %ebx,%eax
    if (rsdt == NULL)
  10232d:	85 db                	test   %ebx,%ebx
  10232f:	74 2a                	je     10235b <acpi_probe_rsdt+0x4b>
        return NULL;
    if (rsdt->sig == ACPI_RSDT_SIG && sum((uint8_t *) rsdt, rsdt->length) == 0) {
  102331:	81 3b 52 53 44 54    	cmpl   $0x54445352,(%ebx)
  102337:	75 2f                	jne    102368 <acpi_probe_rsdt+0x58>
  102339:	8b 73 04             	mov    0x4(%ebx),%esi
    for (i = 0; i < len; i++) {
  10233c:	85 f6                	test   %esi,%esi
  10233e:	7e 1b                	jle    10235b <acpi_probe_rsdt+0x4b>
  102340:	01 de                	add    %ebx,%esi
    sum = 0;
  102342:	31 d2                	xor    %edx,%edx
  102344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        sum += addr[i];
  102348:	0f b6 08             	movzbl (%eax),%ecx
    for (i = 0; i < len; i++) {
  10234b:	83 c0 01             	add    $0x1,%eax
        sum += addr[i];
  10234e:	01 ca                	add    %ecx,%edx
    for (i = 0; i < len; i++) {
  102350:	39 c6                	cmp    %eax,%esi
  102352:	75 f4                	jne    102348 <acpi_probe_rsdt+0x38>
        return NULL;
  102354:	31 c0                	xor    %eax,%eax
  102356:	84 d2                	test   %dl,%dl
  102358:	0f 45 d8             	cmovne %eax,%ebx
        return rsdt;
    }

    return NULL;
}
  10235b:	83 c4 04             	add    $0x4,%esp
  10235e:	89 d8                	mov    %ebx,%eax
  102360:	5b                   	pop    %ebx
  102361:	5e                   	pop    %esi
  102362:	c3                   	ret    
  102363:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102367:	90                   	nop
        return NULL;
  102368:	31 db                	xor    %ebx,%ebx
}
  10236a:	83 c4 04             	add    $0x4,%esp
  10236d:	89 d8                	mov    %ebx,%eax
  10236f:	5b                   	pop    %ebx
  102370:	5e                   	pop    %esi
  102371:	c3                   	ret    
  102372:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    KERN_ASSERT(rsdp != NULL);
  102378:	8d 83 2e 95 ff ff    	lea    -0x6ad2(%ebx),%eax
  10237e:	50                   	push   %eax
  10237f:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  102385:	50                   	push   %eax
  102386:	8d 83 3b 95 ff ff    	lea    -0x6ac5(%ebx),%eax
  10238c:	6a 33                	push   $0x33
  10238e:	50                   	push   %eax
  10238f:	e8 9c 1c 00 00       	call   104030 <debug_panic>
  102394:	83 c4 10             	add    $0x10,%esp
  102397:	eb 8f                	jmp    102328 <acpi_probe_rsdt+0x18>
  102399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001023a0 <acpi_probe_rsdt_ent>:

acpi_sdt_hdr_t *acpi_probe_rsdt_ent(acpi_rsdt_t *rsdt, const uint32_t sig)
{
  1023a0:	55                   	push   %ebp
  1023a1:	57                   	push   %edi
  1023a2:	56                   	push   %esi
  1023a3:	53                   	push   %ebx
  1023a4:	e8 e0 df ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1023a9:	81 c3 57 dc 00 00    	add    $0xdc57,%ebx
  1023af:	83 ec 1c             	sub    $0x1c,%esp
  1023b2:	8b 74 24 30          	mov    0x30(%esp),%esi
    KERN_ASSERT(rsdt != NULL);
  1023b6:	85 f6                	test   %esi,%esi
  1023b8:	74 62                	je     10241c <acpi_probe_rsdt_ent+0x7c>

    uint8_t *p = (uint8_t *) &rsdt->ent[0];
    uint8_t *e = (uint8_t *) rsdt + rsdt->length;
  1023ba:	8b 7e 04             	mov    0x4(%esi),%edi
    uint8_t *p = (uint8_t *) &rsdt->ent[0];
  1023bd:	8d 56 24             	lea    0x24(%esi),%edx
    uint8_t *e = (uint8_t *) rsdt + rsdt->length;
  1023c0:	01 f7                	add    %esi,%edi

    int i;
    for (i = 0; p < e; i++) {
  1023c2:	39 d7                	cmp    %edx,%edi
  1023c4:	76 4a                	jbe    102410 <acpi_probe_rsdt_ent+0x70>
  1023c6:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  1023ca:	8b 7c 24 34          	mov    0x34(%esp),%edi
  1023ce:	eb 09                	jmp    1023d9 <acpi_probe_rsdt_ent+0x39>
  1023d0:	83 c2 04             	add    $0x4,%edx
  1023d3:	39 54 24 0c          	cmp    %edx,0xc(%esp)
  1023d7:	76 37                	jbe    102410 <acpi_probe_rsdt_ent+0x70>
        acpi_sdt_hdr_t *hdr = (acpi_sdt_hdr_t *) (rsdt->ent[i]);
  1023d9:	8b 02                	mov    (%edx),%eax
  1023db:	89 c5                	mov    %eax,%ebp
        if (hdr->sig == sig && sum((uint8_t *) hdr, hdr->length) == 0) {
  1023dd:	39 38                	cmp    %edi,(%eax)
  1023df:	75 ef                	jne    1023d0 <acpi_probe_rsdt_ent+0x30>
  1023e1:	8b 70 04             	mov    0x4(%eax),%esi
    for (i = 0; i < len; i++) {
  1023e4:	85 f6                	test   %esi,%esi
  1023e6:	7e 18                	jle    102400 <acpi_probe_rsdt_ent+0x60>
  1023e8:	01 c6                	add    %eax,%esi
    sum = 0;
  1023ea:	31 c9                	xor    %ecx,%ecx
  1023ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        sum += addr[i];
  1023f0:	0f b6 18             	movzbl (%eax),%ebx
    for (i = 0; i < len; i++) {
  1023f3:	83 c0 01             	add    $0x1,%eax
        sum += addr[i];
  1023f6:	01 d9                	add    %ebx,%ecx
    for (i = 0; i < len; i++) {
  1023f8:	39 c6                	cmp    %eax,%esi
  1023fa:	75 f4                	jne    1023f0 <acpi_probe_rsdt_ent+0x50>
        if (hdr->sig == sig && sum((uint8_t *) hdr, hdr->length) == 0) {
  1023fc:	84 c9                	test   %cl,%cl
  1023fe:	75 d0                	jne    1023d0 <acpi_probe_rsdt_ent+0x30>
        }
        p = (uint8_t *) &rsdt->ent[i + 1];
    }

    return NULL;
}
  102400:	83 c4 1c             	add    $0x1c,%esp
  102403:	89 e8                	mov    %ebp,%eax
  102405:	5b                   	pop    %ebx
  102406:	5e                   	pop    %esi
  102407:	5f                   	pop    %edi
  102408:	5d                   	pop    %ebp
  102409:	c3                   	ret    
  10240a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102410:	83 c4 1c             	add    $0x1c,%esp
    return NULL;
  102413:	31 ed                	xor    %ebp,%ebp
}
  102415:	5b                   	pop    %ebx
  102416:	89 e8                	mov    %ebp,%eax
  102418:	5e                   	pop    %esi
  102419:	5f                   	pop    %edi
  10241a:	5d                   	pop    %ebp
  10241b:	c3                   	ret    
    KERN_ASSERT(rsdt != NULL);
  10241c:	8d 83 4b 95 ff ff    	lea    -0x6ab5(%ebx),%eax
  102422:	50                   	push   %eax
  102423:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  102429:	50                   	push   %eax
  10242a:	8d 83 3b 95 ff ff    	lea    -0x6ac5(%ebx),%eax
  102430:	6a 41                	push   $0x41
  102432:	50                   	push   %eax
  102433:	e8 f8 1b 00 00       	call   104030 <debug_panic>
  102438:	83 c4 10             	add    $0x10,%esp
  10243b:	e9 7a ff ff ff       	jmp    1023ba <acpi_probe_rsdt_ent+0x1a>

00102440 <acpi_probe_xsdt>:

acpi_xsdt_t *acpi_probe_xsdt(acpi_rsdp_t *rsdp)
{
  102440:	56                   	push   %esi
  102441:	53                   	push   %ebx
  102442:	e8 42 df ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102447:	81 c3 b9 db 00 00    	add    $0xdbb9,%ebx
  10244d:	83 ec 04             	sub    $0x4,%esp
  102450:	8b 74 24 10          	mov    0x10(%esp),%esi
    KERN_ASSERT(rsdp != NULL);
  102454:	85 f6                	test   %esi,%esi
  102456:	74 50                	je     1024a8 <acpi_probe_xsdt+0x68>

    acpi_xsdt_t *xsdt = (acpi_xsdt_t *) (uintptr_t) rsdp->xsdt_addr;
  102458:	8b 5e 18             	mov    0x18(%esi),%ebx
  10245b:	89 d8                	mov    %ebx,%eax
    if (xsdt == NULL)
  10245d:	85 db                	test   %ebx,%ebx
  10245f:	74 2a                	je     10248b <acpi_probe_xsdt+0x4b>
        return NULL;
    if (xsdt->sig == ACPI_XSDT_SIG && sum((uint8_t *) xsdt, xsdt->length) == 0) {
  102461:	81 3b 58 53 44 54    	cmpl   $0x54445358,(%ebx)
  102467:	75 2f                	jne    102498 <acpi_probe_xsdt+0x58>
  102469:	8b 73 04             	mov    0x4(%ebx),%esi
    for (i = 0; i < len; i++) {
  10246c:	85 f6                	test   %esi,%esi
  10246e:	7e 1b                	jle    10248b <acpi_probe_xsdt+0x4b>
  102470:	01 de                	add    %ebx,%esi
    sum = 0;
  102472:	31 d2                	xor    %edx,%edx
  102474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        sum += addr[i];
  102478:	0f b6 08             	movzbl (%eax),%ecx
    for (i = 0; i < len; i++) {
  10247b:	83 c0 01             	add    $0x1,%eax
        sum += addr[i];
  10247e:	01 ca                	add    %ecx,%edx
    for (i = 0; i < len; i++) {
  102480:	39 c6                	cmp    %eax,%esi
  102482:	75 f4                	jne    102478 <acpi_probe_xsdt+0x38>
        return NULL;
  102484:	31 c0                	xor    %eax,%eax
  102486:	84 d2                	test   %dl,%dl
  102488:	0f 45 d8             	cmovne %eax,%ebx
        return xsdt;
    }

    return NULL;
}
  10248b:	83 c4 04             	add    $0x4,%esp
  10248e:	89 d8                	mov    %ebx,%eax
  102490:	5b                   	pop    %ebx
  102491:	5e                   	pop    %esi
  102492:	c3                   	ret    
  102493:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102497:	90                   	nop
        return NULL;
  102498:	31 db                	xor    %ebx,%ebx
}
  10249a:	83 c4 04             	add    $0x4,%esp
  10249d:	89 d8                	mov    %ebx,%eax
  10249f:	5b                   	pop    %ebx
  1024a0:	5e                   	pop    %esi
  1024a1:	c3                   	ret    
  1024a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    KERN_ASSERT(rsdp != NULL);
  1024a8:	8d 83 2e 95 ff ff    	lea    -0x6ad2(%ebx),%eax
  1024ae:	50                   	push   %eax
  1024af:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  1024b5:	50                   	push   %eax
  1024b6:	8d 83 3b 95 ff ff    	lea    -0x6ac5(%ebx),%eax
  1024bc:	6a 54                	push   $0x54
  1024be:	50                   	push   %eax
  1024bf:	e8 6c 1b 00 00       	call   104030 <debug_panic>
  1024c4:	83 c4 10             	add    $0x10,%esp
  1024c7:	eb 8f                	jmp    102458 <acpi_probe_xsdt+0x18>
  1024c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001024d0 <acpi_probe_xsdt_ent>:

acpi_sdt_hdr_t *acpi_probe_xsdt_ent(acpi_xsdt_t *xsdt, const uint32_t sig)
{
  1024d0:	55                   	push   %ebp
  1024d1:	57                   	push   %edi
  1024d2:	56                   	push   %esi
  1024d3:	53                   	push   %ebx
  1024d4:	e8 b0 de ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1024d9:	81 c3 27 db 00 00    	add    $0xdb27,%ebx
  1024df:	83 ec 1c             	sub    $0x1c,%esp
  1024e2:	8b 74 24 30          	mov    0x30(%esp),%esi
    KERN_ASSERT(xsdt != NULL);
  1024e6:	85 f6                	test   %esi,%esi
  1024e8:	74 62                	je     10254c <acpi_probe_xsdt_ent+0x7c>

    uint8_t *p = (uint8_t *) &xsdt->ent[0];
    uint8_t *e = (uint8_t *) xsdt + xsdt->length;
  1024ea:	8b 7e 04             	mov    0x4(%esi),%edi
    uint8_t *p = (uint8_t *) &xsdt->ent[0];
  1024ed:	8d 56 24             	lea    0x24(%esi),%edx
    uint8_t *e = (uint8_t *) xsdt + xsdt->length;
  1024f0:	01 f7                	add    %esi,%edi

    int i;
    for (i = 0; p < e; i++) {
  1024f2:	39 d7                	cmp    %edx,%edi
  1024f4:	76 4a                	jbe    102540 <acpi_probe_xsdt_ent+0x70>
  1024f6:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  1024fa:	8b 7c 24 34          	mov    0x34(%esp),%edi
  1024fe:	eb 09                	jmp    102509 <acpi_probe_xsdt_ent+0x39>
  102500:	83 c2 08             	add    $0x8,%edx
  102503:	39 54 24 0c          	cmp    %edx,0xc(%esp)
  102507:	76 37                	jbe    102540 <acpi_probe_xsdt_ent+0x70>
        acpi_sdt_hdr_t *hdr = (acpi_sdt_hdr_t *) (uintptr_t) xsdt->ent[i];
  102509:	8b 02                	mov    (%edx),%eax
  10250b:	89 c5                	mov    %eax,%ebp
        if (hdr->sig == sig && sum((uint8_t *) hdr, hdr->length) == 0) {
  10250d:	39 38                	cmp    %edi,(%eax)
  10250f:	75 ef                	jne    102500 <acpi_probe_xsdt_ent+0x30>
  102511:	8b 70 04             	mov    0x4(%eax),%esi
    for (i = 0; i < len; i++) {
  102514:	85 f6                	test   %esi,%esi
  102516:	7e 18                	jle    102530 <acpi_probe_xsdt_ent+0x60>
  102518:	01 c6                	add    %eax,%esi
    sum = 0;
  10251a:	31 c9                	xor    %ecx,%ecx
  10251c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        sum += addr[i];
  102520:	0f b6 18             	movzbl (%eax),%ebx
    for (i = 0; i < len; i++) {
  102523:	83 c0 01             	add    $0x1,%eax
        sum += addr[i];
  102526:	01 d9                	add    %ebx,%ecx
    for (i = 0; i < len; i++) {
  102528:	39 c6                	cmp    %eax,%esi
  10252a:	75 f4                	jne    102520 <acpi_probe_xsdt_ent+0x50>
        if (hdr->sig == sig && sum((uint8_t *) hdr, hdr->length) == 0) {
  10252c:	84 c9                	test   %cl,%cl
  10252e:	75 d0                	jne    102500 <acpi_probe_xsdt_ent+0x30>
        }
        p = (uint8_t *) &xsdt->ent[i + 1];
    }

    return NULL;
}
  102530:	83 c4 1c             	add    $0x1c,%esp
  102533:	89 e8                	mov    %ebp,%eax
  102535:	5b                   	pop    %ebx
  102536:	5e                   	pop    %esi
  102537:	5f                   	pop    %edi
  102538:	5d                   	pop    %ebp
  102539:	c3                   	ret    
  10253a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102540:	83 c4 1c             	add    $0x1c,%esp
    return NULL;
  102543:	31 ed                	xor    %ebp,%ebp
}
  102545:	5b                   	pop    %ebx
  102546:	89 e8                	mov    %ebp,%eax
  102548:	5e                   	pop    %esi
  102549:	5f                   	pop    %edi
  10254a:	5d                   	pop    %ebp
  10254b:	c3                   	ret    
    KERN_ASSERT(xsdt != NULL);
  10254c:	8d 83 58 95 ff ff    	lea    -0x6aa8(%ebx),%eax
  102552:	50                   	push   %eax
  102553:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  102559:	50                   	push   %eax
  10255a:	8d 83 3b 95 ff ff    	lea    -0x6ac5(%ebx),%eax
  102560:	6a 62                	push   $0x62
  102562:	50                   	push   %eax
  102563:	e8 c8 1a 00 00       	call   104030 <debug_panic>
  102568:	83 c4 10             	add    $0x10,%esp
  10256b:	e9 7a ff ff ff       	jmp    1024ea <acpi_probe_xsdt_ent+0x1a>

00102570 <lapic_register>:
{
}

void lapic_register(uintptr_t lapic_addr)
{
    lapic = (lapic_t *) lapic_addr;
  102570:	e8 0c de ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  102575:	05 8b da 00 00       	add    $0xda8b,%eax
  10257a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10257e:	89 90 90 88 02 00    	mov    %edx,0x28890(%eax)
}
  102584:	c3                   	ret    
  102585:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10258c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102590 <lapic_init>:

/*
 * Initialize local APIC.
 */
void lapic_init()
{
  102590:	55                   	push   %ebp
  102591:	57                   	push   %edi
  102592:	56                   	push   %esi
  102593:	53                   	push   %ebx
  102594:	e8 f0 dd ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102599:	81 c3 67 da 00 00    	add    $0xda67,%ebx
  10259f:	83 ec 2c             	sub    $0x2c,%esp
    if (!lapic)
  1025a2:	8b 83 90 88 02 00    	mov    0x28890(%ebx),%eax
  1025a8:	8d 93 6e 95 ff ff    	lea    -0x6a92(%ebx),%edx
  1025ae:	89 54 24 10          	mov    %edx,0x10(%esp)
  1025b2:	85 c0                	test   %eax,%eax
  1025b4:	0f 84 9b 02 00 00    	je     102855 <lapic_init+0x2c5>
    lapic[index] = value;
  1025ba:	c7 80 f0 00 00 00 27 	movl   $0x127,0xf0(%eax)
  1025c1:	01 00 00 
    lapic[LAPIC_ID];
  1025c4:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  1025c7:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
  1025ce:	00 00 00 
    lapic[LAPIC_ID];
  1025d1:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  1025d4:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
  1025db:	00 02 00 
    lapic[LAPIC_ID];
  1025de:	8b 50 20             	mov    0x20(%eax),%edx
    int i;
    for (i = 0; i < 5; i++) {
        lapic_ticks_per_ms = lapic_calibrate_timer(CAL_LATCH, CAL_MS, CAL_PIT_LOOPS);
        if (lapic_ticks_per_ms != ~(uint32_t) 0x0)
            break;
        KERN_DEBUG("[%d] Retry to calibrate internal timer of LAPIC.\n", i);
  1025e1:	8d 93 c4 95 ff ff    	lea    -0x6a3c(%ebx),%edx
    for (i = 0; i < 5; i++) {
  1025e7:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1025ee:	00 
        KERN_DEBUG("[%d] Retry to calibrate internal timer of LAPIC.\n", i);
  1025ef:	89 54 24 1c          	mov    %edx,0x1c(%esp)
    lapic[index] = value;
  1025f3:	c7 80 80 03 00 00 ff 	movl   $0xffffffff,0x380(%eax)
  1025fa:	ff ff ff 
    outb(0x61, (inb(0x61) & ~0x02) | 0x01);
  1025fd:	83 ec 0c             	sub    $0xc,%esp
    lapic[LAPIC_ID];
  102600:	8b 40 20             	mov    0x20(%eax),%eax
    outb(0x61, (inb(0x61) & ~0x02) | 0x01);
  102603:	6a 61                	push   $0x61
  102605:	e8 f6 27 00 00       	call   104e00 <inb>
  10260a:	5a                   	pop    %edx
  10260b:	59                   	pop    %ecx
  10260c:	25 fc 00 00 00       	and    $0xfc,%eax
  102611:	83 c8 01             	or     $0x1,%eax
  102614:	50                   	push   %eax
  102615:	6a 61                	push   $0x61
  102617:	e8 14 28 00 00       	call   104e30 <outb>
    outb(0x43, 0xb0);
  10261c:	5e                   	pop    %esi
  10261d:	5f                   	pop    %edi
  10261e:	68 b0 00 00 00       	push   $0xb0
  102623:	6a 43                	push   $0x43
    timermin = ~(uint32_t) 0x0;
  102625:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    outb(0x43, 0xb0);
  10262a:	e8 01 28 00 00       	call   104e30 <outb>
    outb(0x42, latch & 0xff);
  10262f:	5d                   	pop    %ebp
  102630:	58                   	pop    %eax
  102631:	68 9b 00 00 00       	push   $0x9b
  102636:	6a 42                	push   $0x42
    timermax = 0;
  102638:	31 ed                	xor    %ebp,%ebp
    outb(0x42, latch & 0xff);
  10263a:	e8 f1 27 00 00       	call   104e30 <outb>
    outb(0x42, latch >> 8);
  10263f:	58                   	pop    %eax
  102640:	5a                   	pop    %edx
  102641:	6a 2e                	push   $0x2e
  102643:	6a 42                	push   $0x42
  102645:	e8 e6 27 00 00       	call   104e30 <outb>
    return lapic[index];
  10264a:	8b 83 90 88 02 00    	mov    0x28890(%ebx),%eax
  102650:	8b 80 90 03 00 00    	mov    0x390(%eax),%eax
  102656:	89 44 24 28          	mov    %eax,0x28(%esp)
  10265a:	89 c6                	mov    %eax,%esi
  10265c:	89 e8                	mov    %ebp,%eax
    while ((inb(0x61) & 0x20) == 0) {
  10265e:	83 c4 10             	add    $0x10,%esp
  102661:	89 fd                	mov    %edi,%ebp
  102663:	89 c7                	mov    %eax,%edi
    pitcnt = 0;
  102665:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  10266c:	00 
    while ((inb(0x61) & 0x20) == 0) {
  10266d:	eb 20                	jmp    10268f <lapic_init+0xff>
  10266f:	90                   	nop
    return lapic[index];
  102670:	8b 83 90 88 02 00    	mov    0x28890(%ebx),%eax
  102676:	8b 80 90 03 00 00    	mov    0x390(%eax),%eax
        delta = timer - timer2;
  10267c:	29 c6                	sub    %eax,%esi
        if (delta < timermin)
  10267e:	39 f5                	cmp    %esi,%ebp
  102680:	0f 47 ee             	cmova  %esi,%ebp
        if (delta > timermax)
  102683:	39 f7                	cmp    %esi,%edi
  102685:	0f 42 fe             	cmovb  %esi,%edi
        pitcnt++;
  102688:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)
        timer = timer2;
  10268d:	89 c6                	mov    %eax,%esi
    while ((inb(0x61) & 0x20) == 0) {
  10268f:	83 ec 0c             	sub    $0xc,%esp
  102692:	6a 61                	push   $0x61
  102694:	e8 67 27 00 00       	call   104e00 <inb>
  102699:	83 c4 10             	add    $0x10,%esp
  10269c:	a8 20                	test   $0x20,%al
  10269e:	74 d0                	je     102670 <lapic_init+0xe0>
    if (pitcnt < loopmin || timermax > 10 * timermin)
  1026a0:	89 f8                	mov    %edi,%eax
  1026a2:	81 7c 24 0c e7 03 00 	cmpl   $0x3e7,0xc(%esp)
  1026a9:	00 
  1026aa:	89 ef                	mov    %ebp,%edi
  1026ac:	89 c5                	mov    %eax,%ebp
  1026ae:	0f 8e 3c 01 00 00    	jle    1027f0 <lapic_init+0x260>
  1026b4:	8d 04 bf             	lea    (%edi,%edi,4),%eax
  1026b7:	01 c0                	add    %eax,%eax
  1026b9:	39 c5                	cmp    %eax,%ebp
  1026bb:	0f 87 2f 01 00 00    	ja     1027f0 <lapic_init+0x260>
    delta = timer1 - timer2;
  1026c1:	8b 54 24 18          	mov    0x18(%esp),%edx
    return delta / ms;
  1026c5:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    if (lapic_ticks_per_ms == ~(uint32_t) 0x0) {
        KERN_WARN("Failed to calibrate internal timer of LAPIC.\n");
        KERN_DEBUG("Assume LAPIC timer freq = 0.5 GHz.\n");
        lapic_ticks_per_ms = 500000;
    } else
        KERN_DEBUG("LAPIC timer freq = %llu Hz.\n",
  1026ca:	83 ec 0c             	sub    $0xc,%esp
    delta = timer1 - timer2;
  1026cd:	29 f2                	sub    %esi,%edx
    return delta / ms;
  1026cf:	89 d0                	mov    %edx,%eax
  1026d1:	f7 e1                	mul    %ecx
        KERN_DEBUG("LAPIC timer freq = %llu Hz.\n",
  1026d3:	b8 e8 03 00 00       	mov    $0x3e8,%eax
    return delta / ms;
  1026d8:	c1 ea 03             	shr    $0x3,%edx
  1026db:	89 d6                	mov    %edx,%esi
        KERN_DEBUG("LAPIC timer freq = %llu Hz.\n",
  1026dd:	f7 e2                	mul    %edx
  1026df:	52                   	push   %edx
  1026e0:	50                   	push   %eax
  1026e1:	8d 83 7f 95 ff ff    	lea    -0x6a81(%ebx),%eax
  1026e7:	50                   	push   %eax
  1026e8:	6a 7d                	push   $0x7d
  1026ea:	ff 74 24 2c          	push   0x2c(%esp)
  1026ee:	e8 fd 18 00 00       	call   103ff0 <debug_normal>
                   (uint64_t) lapic_ticks_per_ms * 1000);

    uint32_t ticr = lapic_ticks_per_ms * 1000 / LAPIC_TIMER_INTR_FREQ;
  1026f3:	69 d6 e8 03 00 00    	imul   $0x3e8,%esi,%edx
  1026f9:	b9 d3 4d 62 10       	mov    $0x10624dd3,%ecx
  1026fe:	83 c4 20             	add    $0x20,%esp
  102701:	89 d0                	mov    %edx,%eax
  102703:	f7 e1                	mul    %ecx
  102705:	c1 ea 06             	shr    $0x6,%edx
  102708:	89 d6                	mov    %edx,%esi
    KERN_DEBUG("Set LAPIC TICR = %x.\n", ticr);
  10270a:	8d 83 9c 95 ff ff    	lea    -0x6a64(%ebx),%eax
  102710:	56                   	push   %esi
  102711:	50                   	push   %eax
  102712:	68 81 00 00 00       	push   $0x81
  102717:	ff 74 24 1c          	push   0x1c(%esp)
  10271b:	e8 d0 18 00 00       	call   103ff0 <debug_normal>
    lapic[index] = value;
  102720:	8b 83 90 88 02 00    	mov    0x28890(%ebx),%eax
    lapic_write(LAPIC_LINT0, LAPIC_LINT_MASKED);
    lapic_write(LAPIC_LINT1, LAPIC_LINT_MASKED);

    // Disable performance counter overflow interrupts
    // on machines that provide that interrupt entry.
    if (((lapic_read(LAPIC_VER) >> 16) & 0xFF) >= 4)
  102726:	83 c4 10             	add    $0x10,%esp
    lapic[index] = value;
  102729:	89 b0 80 03 00 00    	mov    %esi,0x380(%eax)
    lapic[LAPIC_ID];
  10272f:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102732:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
  102739:	00 01 00 
    lapic[LAPIC_ID];
  10273c:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  10273f:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
  102746:	00 01 00 
    lapic[LAPIC_ID];
  102749:	8b 50 20             	mov    0x20(%eax),%edx
    return lapic[index];
  10274c:	8b 50 30             	mov    0x30(%eax),%edx
    if (((lapic_read(LAPIC_VER) >> 16) & 0xFF) >= 4)
  10274f:	c1 ea 10             	shr    $0x10,%edx
  102752:	81 e2 fc 00 00 00    	and    $0xfc,%edx
  102758:	74 0d                	je     102767 <lapic_init+0x1d7>
    lapic[index] = value;
  10275a:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
  102761:	00 01 00 
    lapic[LAPIC_ID];
  102764:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102767:	c7 80 e0 00 00 00 00 	movl   $0xf0000000,0xe0(%eax)
  10276e:	00 00 f0 
    lapic[LAPIC_ID];
  102771:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102774:	c7 80 d0 00 00 00 00 	movl   $0x0,0xd0(%eax)
  10277b:	00 00 00 
    lapic[LAPIC_ID];
  10277e:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102781:	c7 80 70 03 00 00 32 	movl   $0x32,0x370(%eax)
  102788:	00 00 00 
    lapic[LAPIC_ID];
  10278b:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  10278e:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  102795:	00 00 00 
    lapic[LAPIC_ID];
  102798:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  10279b:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  1027a2:	00 00 00 
    lapic[LAPIC_ID];
  1027a5:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  1027a8:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  1027af:	00 00 00 
    lapic[LAPIC_ID];
  1027b2:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  1027b5:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
  1027bc:	00 00 00 
    lapic[LAPIC_ID];
  1027bf:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  1027c2:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
  1027c9:	85 08 00 
    lapic[LAPIC_ID];
  1027cc:	8b 50 20             	mov    0x20(%eax),%edx
  1027cf:	90                   	nop
    return lapic[index];
  1027d0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx

    // Send an Init Level De-Assert to synchronise arbitration ID's.
    lapic_write(LAPIC_ICRHI, 0);
    lapic_write(LAPIC_ICRLO,
                LAPIC_ICRLO_BCAST | LAPIC_ICRLO_INIT | LAPIC_ICRLO_LEVEL);
    while (lapic_read(LAPIC_ICRLO) & LAPIC_ICRLO_DELIVS);
  1027d6:	80 e6 10             	and    $0x10,%dh
  1027d9:	75 f5                	jne    1027d0 <lapic_init+0x240>
    lapic[index] = value;
  1027db:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
  1027e2:	00 00 00 
    lapic[LAPIC_ID];
  1027e5:	8b 40 20             	mov    0x20(%eax),%eax

    // Enable interrupts on the APIC (but not on the processor).
    lapic_write(LAPIC_TPR, 0);
}
  1027e8:	83 c4 2c             	add    $0x2c,%esp
  1027eb:	5b                   	pop    %ebx
  1027ec:	5e                   	pop    %esi
  1027ed:	5f                   	pop    %edi
  1027ee:	5d                   	pop    %ebp
  1027ef:	c3                   	ret    
        KERN_DEBUG("[%d] Retry to calibrate internal timer of LAPIC.\n", i);
  1027f0:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1027f4:	57                   	push   %edi
  1027f5:	ff 74 24 20          	push   0x20(%esp)
  1027f9:	6a 75                	push   $0x75
  1027fb:	ff 74 24 1c          	push   0x1c(%esp)
  1027ff:	e8 ec 17 00 00       	call   103ff0 <debug_normal>
    for (i = 0; i < 5; i++) {
  102804:	89 f8                	mov    %edi,%eax
  102806:	83 c0 01             	add    $0x1,%eax
  102809:	89 44 24 24          	mov    %eax,0x24(%esp)
  10280d:	83 c4 10             	add    $0x10,%esp
  102810:	83 f8 05             	cmp    $0x5,%eax
  102813:	74 0b                	je     102820 <lapic_init+0x290>
    lapic[index] = value;
  102815:	8b 83 90 88 02 00    	mov    0x28890(%ebx),%eax
  10281b:	e9 d3 fd ff ff       	jmp    1025f3 <lapic_init+0x63>
        KERN_WARN("Failed to calibrate internal timer of LAPIC.\n");
  102820:	83 ec 04             	sub    $0x4,%esp
  102823:	8d 83 f8 95 ff ff    	lea    -0x6a08(%ebx),%eax
  102829:	be 20 a1 07 00       	mov    $0x7a120,%esi
  10282e:	50                   	push   %eax
  10282f:	6a 79                	push   $0x79
  102831:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
  102835:	57                   	push   %edi
  102836:	e8 c5 18 00 00       	call   104100 <debug_warn>
        KERN_DEBUG("Assume LAPIC timer freq = 0.5 GHz.\n");
  10283b:	83 c4 0c             	add    $0xc,%esp
  10283e:	8d 83 28 96 ff ff    	lea    -0x69d8(%ebx),%eax
  102844:	50                   	push   %eax
  102845:	6a 7a                	push   $0x7a
  102847:	57                   	push   %edi
  102848:	e8 a3 17 00 00       	call   103ff0 <debug_normal>
        lapic_ticks_per_ms = 500000;
  10284d:	83 c4 10             	add    $0x10,%esp
  102850:	e9 b5 fe ff ff       	jmp    10270a <lapic_init+0x17a>
        KERN_PANIC("NO LAPIC");
  102855:	83 ec 04             	sub    $0x4,%esp
  102858:	8d 83 65 95 ff ff    	lea    -0x6a9b(%ebx),%eax
  10285e:	50                   	push   %eax
  10285f:	6a 62                	push   $0x62
  102861:	ff 74 24 1c          	push   0x1c(%esp)
  102865:	e8 c6 17 00 00       	call   104030 <debug_panic>
    lapic[index] = value;
  10286a:	8b 83 90 88 02 00    	mov    0x28890(%ebx),%eax
  102870:	83 c4 10             	add    $0x10,%esp
  102873:	e9 42 fd ff ff       	jmp    1025ba <lapic_init+0x2a>
  102878:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10287f:	90                   	nop

00102880 <lapic_eoi>:
/*
 * Acknowledge the end of interrupts.
 */
void lapic_eoi(void)
{
    if (lapic)
  102880:	e8 fc da ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  102885:	05 7b d7 00 00       	add    $0xd77b,%eax
  10288a:	8b 80 90 88 02 00    	mov    0x28890(%eax),%eax
  102890:	85 c0                	test   %eax,%eax
  102892:	74 0d                	je     1028a1 <lapic_eoi+0x21>
    lapic[index] = value;
  102894:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  10289b:	00 00 00 
    lapic[LAPIC_ID];
  10289e:	8b 40 20             	mov    0x20(%eax),%eax
        lapic_write(LAPIC_EOI, 0);
}
  1028a1:	c3                   	ret    
  1028a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1028a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001028b0 <lapic_startcpu>:
/*
 * Start additional processor running bootstrap code at addr.
 * See Appendix B of MultiProcessor Specification.
 */
void lapic_startcpu(lapicid_t apicid, uintptr_t addr)
{
  1028b0:	57                   	push   %edi
  1028b1:	56                   	push   %esi
  1028b2:	53                   	push   %ebx
  1028b3:	8b 74 24 14          	mov    0x14(%esp),%esi
  1028b7:	e8 cd da ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1028bc:	81 c3 44 d7 00 00    	add    $0xd744,%ebx
  1028c2:	8b 7c 24 10          	mov    0x10(%esp),%edi
    uint16_t *wrv;

    // "The BSP must initialize CMOS shutdown code to 0AH
    // and the warm reset vector (DWORD based at 40:67) to point at
    // the AP startup code prior to the [universal startup algorithm]."
    outb(IO_RTC, 0xF);                      // offset 0xF is shutdown code
  1028c6:	83 ec 08             	sub    $0x8,%esp
    wrv[0] = 0;
    wrv[1] = addr >> 4;

    // "Universal startup algorithm."
    // Send INIT (level-triggered) interrupt to reset other CPU.
    lapic_write(LAPIC_ICRHI, apicid << 24);
  1028c9:	c1 e7 18             	shl    $0x18,%edi
    outb(IO_RTC, 0xF);                      // offset 0xF is shutdown code
  1028cc:	6a 0f                	push   $0xf
  1028ce:	6a 70                	push   $0x70
  1028d0:	e8 5b 25 00 00       	call   104e30 <outb>
    outb(IO_RTC + 1, 0x0A);
  1028d5:	58                   	pop    %eax
  1028d6:	5a                   	pop    %edx
  1028d7:	6a 0a                	push   $0xa
  1028d9:	6a 71                	push   $0x71
  1028db:	e8 50 25 00 00       	call   104e30 <outb>
    wrv[1] = addr >> 4;
  1028e0:	89 f0                	mov    %esi,%eax
    // when it is in the halted state due to an INIT. So the second
    // should be ignored, but it is part of the official Intel algorithm.
    // Bochs complains about the second one. Too bad for Bochs.
    for (i = 0; i < 2; i++) {
        lapic_write(LAPIC_ICRHI, apicid << 24);
        lapic_write(LAPIC_ICRLO, LAPIC_ICRLO_STARTUP | (addr >> 12));
  1028e2:	c1 ee 0c             	shr    $0xc,%esi
        microdelay(200);
    }
}
  1028e5:	83 c4 10             	add    $0x10,%esp
    wrv[1] = addr >> 4;
  1028e8:	c1 e8 04             	shr    $0x4,%eax
        lapic_write(LAPIC_ICRLO, LAPIC_ICRLO_STARTUP | (addr >> 12));
  1028eb:	81 ce 00 06 00 00    	or     $0x600,%esi
    wrv[0] = 0;
  1028f1:	31 c9                	xor    %ecx,%ecx
    wrv[1] = addr >> 4;
  1028f3:	66 a3 69 04 00 00    	mov    %ax,0x469
    lapic[index] = value;
  1028f9:	8b 83 90 88 02 00    	mov    0x28890(%ebx),%eax
    wrv[0] = 0;
  1028ff:	66 89 0d 67 04 00 00 	mov    %cx,0x467
    lapic[index] = value;
  102906:	89 b8 10 03 00 00    	mov    %edi,0x310(%eax)
    lapic[LAPIC_ID];
  10290c:	8b 48 20             	mov    0x20(%eax),%ecx
    lapic[index] = value;
  10290f:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
  102916:	c5 00 00 
    lapic[LAPIC_ID];
  102919:	8b 48 20             	mov    0x20(%eax),%ecx
    lapic[index] = value;
  10291c:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
  102923:	85 00 00 
    lapic[LAPIC_ID];
  102926:	8b 48 20             	mov    0x20(%eax),%ecx
    lapic[index] = value;
  102929:	89 b8 10 03 00 00    	mov    %edi,0x310(%eax)
    lapic[LAPIC_ID];
  10292f:	8b 48 20             	mov    0x20(%eax),%ecx
    lapic[index] = value;
  102932:	89 b0 00 03 00 00    	mov    %esi,0x300(%eax)
    lapic[LAPIC_ID];
  102938:	8b 48 20             	mov    0x20(%eax),%ecx
    lapic[index] = value;
  10293b:	89 b8 10 03 00 00    	mov    %edi,0x310(%eax)
    lapic[LAPIC_ID];
  102941:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102944:	89 b0 00 03 00 00    	mov    %esi,0x300(%eax)
}
  10294a:	5b                   	pop    %ebx
    lapic[LAPIC_ID];
  10294b:	8b 40 20             	mov    0x20(%eax),%eax
}
  10294e:	5e                   	pop    %esi
  10294f:	5f                   	pop    %edi
  102950:	c3                   	ret    
  102951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102958:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10295f:	90                   	nop

00102960 <lapic_read_debug>:
    return lapic[index];
  102960:	e8 1c da ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  102965:	05 9b d6 00 00       	add    $0xd69b,%eax
  10296a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10296e:	8b 80 90 88 02 00    	mov    0x28890(%eax),%eax
  102974:	8d 04 90             	lea    (%eax,%edx,4),%eax
  102977:	8b 00                	mov    (%eax),%eax

uint32_t lapic_read_debug(int index)
{
    return lapic_read(index);
}
  102979:	c3                   	ret    
  10297a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102980 <lapic_send_ipi>:
/*
 * Send an IPI.
 */
void lapic_send_ipi(lapicid_t apicid, uint8_t vector,
                    uint32_t deliver_mode, uint32_t shorthand_mode)
{
  102980:	55                   	push   %ebp
  102981:	57                   	push   %edi
  102982:	56                   	push   %esi
  102983:	53                   	push   %ebx
  102984:	e8 00 da ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102989:	81 c3 77 d6 00 00    	add    $0xd677,%ebx
  10298f:	83 ec 0c             	sub    $0xc,%esp
    KERN_ASSERT(deliver_mode != LAPIC_ICRLO_INIT &&
  102992:	8b 44 24 28          	mov    0x28(%esp),%eax
{
  102996:	8b 6c 24 20          	mov    0x20(%esp),%ebp
  10299a:	8b 74 24 24          	mov    0x24(%esp),%esi
  10299e:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
    KERN_ASSERT(deliver_mode != LAPIC_ICRLO_INIT &&
  1029a2:	2d 00 05 00 00       	sub    $0x500,%eax
  1029a7:	a9 ff fe ff ff       	test   $0xfffffeff,%eax
  1029ac:	74 5a                	je     102a08 <lapic_send_ipi+0x88>
                deliver_mode != LAPIC_ICRLO_STARTUP);
    KERN_ASSERT(vector >= T_IPI0);
  1029ae:	89 f0                	mov    %esi,%eax
  1029b0:	3c 3e                	cmp    $0x3e,%al
  1029b2:	77 11                	ja     1029c5 <lapic_send_ipi+0x45>
  1029b4:	eb 7a                	jmp    102a30 <lapic_send_ipi+0xb0>
  1029b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1029bd:	8d 76 00             	lea    0x0(%esi),%esi

    while (lapic_read(LAPIC_ICRLO) & LAPIC_ICRLO_DELIVS)
        pause();
  1029c0:	e8 9b 22 00 00       	call   104c60 <pause>
    return lapic[index];
  1029c5:	8b 83 90 88 02 00    	mov    0x28890(%ebx),%eax
  1029cb:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
    while (lapic_read(LAPIC_ICRLO) & LAPIC_ICRLO_DELIVS)
  1029d1:	80 e6 10             	and    $0x10,%dh
  1029d4:	75 ea                	jne    1029c0 <lapic_send_ipi+0x40>

    if (shorthand_mode == LAPIC_ICRLO_NOBCAST)
  1029d6:	85 ff                	test   %edi,%edi
  1029d8:	75 0c                	jne    1029e6 <lapic_send_ipi+0x66>
        lapic_write(LAPIC_ICRHI,
  1029da:	c1 e5 18             	shl    $0x18,%ebp
    lapic[index] = value;
  1029dd:	89 a8 10 03 00 00    	mov    %ebp,0x310(%eax)
    lapic[LAPIC_ID];
  1029e3:	8b 50 20             	mov    0x20(%eax),%edx
                    (apicid << LAPIC_ICRHI_DEST_SHIFT) & LAPIC_ICRHI_DEST_MASK);

    lapic_write(LAPIC_ICRLO,
                shorthand_mode |  /* LAPIC_ICRLO_LEVEL | */
                deliver_mode | (vector & LAPIC_ICRLO_VECTOR));
  1029e6:	89 f1                	mov    %esi,%ecx
  1029e8:	0f b6 f1             	movzbl %cl,%esi
  1029eb:	09 fe                	or     %edi,%esi
  1029ed:	0b 74 24 28          	or     0x28(%esp),%esi
    lapic[index] = value;
  1029f1:	89 b0 00 03 00 00    	mov    %esi,0x300(%eax)
    lapic[LAPIC_ID];
  1029f7:	8b 40 20             	mov    0x20(%eax),%eax
}
  1029fa:	83 c4 0c             	add    $0xc,%esp
  1029fd:	5b                   	pop    %ebx
  1029fe:	5e                   	pop    %esi
  1029ff:	5f                   	pop    %edi
  102a00:	5d                   	pop    %ebp
  102a01:	c3                   	ret    
  102a02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    KERN_ASSERT(deliver_mode != LAPIC_ICRLO_INIT &&
  102a08:	8d 83 4c 96 ff ff    	lea    -0x69b4(%ebx),%eax
  102a0e:	50                   	push   %eax
  102a0f:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  102a15:	50                   	push   %eax
  102a16:	8d 83 6e 95 ff ff    	lea    -0x6a92(%ebx),%eax
  102a1c:	68 e4 00 00 00       	push   $0xe4
  102a21:	50                   	push   %eax
  102a22:	e8 09 16 00 00       	call   104030 <debug_panic>
    KERN_ASSERT(vector >= T_IPI0);
  102a27:	89 f0                	mov    %esi,%eax
    KERN_ASSERT(deliver_mode != LAPIC_ICRLO_INIT &&
  102a29:	83 c4 10             	add    $0x10,%esp
    KERN_ASSERT(vector >= T_IPI0);
  102a2c:	3c 3e                	cmp    $0x3e,%al
  102a2e:	77 95                	ja     1029c5 <lapic_send_ipi+0x45>
  102a30:	8d 83 b2 95 ff ff    	lea    -0x6a4e(%ebx),%eax
  102a36:	50                   	push   %eax
  102a37:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  102a3d:	50                   	push   %eax
  102a3e:	8d 83 6e 95 ff ff    	lea    -0x6a92(%ebx),%eax
  102a44:	68 e6 00 00 00       	push   $0xe6
  102a49:	50                   	push   %eax
  102a4a:	e8 e1 15 00 00       	call   104030 <debug_panic>
  102a4f:	83 c4 10             	add    $0x10,%esp
    return lapic[index];
  102a52:	e9 6e ff ff ff       	jmp    1029c5 <lapic_send_ipi+0x45>
  102a57:	66 90                	xchg   %ax,%ax
  102a59:	66 90                	xchg   %ax,%ax
  102a5b:	66 90                	xchg   %ax,%ax
  102a5d:	66 90                	xchg   %ax,%ax
  102a5f:	90                   	nop

00102a60 <ioapic_register>:
    base->reg = reg;
    base->data = data;
}

void ioapic_register(uintptr_t addr, lapicid_t id, int g)
{
  102a60:	53                   	push   %ebx
  102a61:	e8 23 d9 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102a66:	81 c3 9a d5 00 00    	add    $0xd59a,%ebx
  102a6c:	83 ec 08             	sub    $0x8,%esp
  102a6f:	8b 54 24 14          	mov    0x14(%esp),%edx
    if (ioapic_num >= MAX_IOAPIC) {
  102a73:	8b 83 a0 88 02 00    	mov    0x288a0(%ebx),%eax
  102a79:	83 f8 0f             	cmp    $0xf,%eax
  102a7c:	7f 4a                	jg     102ac8 <ioapic_register+0x68>
        KERN_WARN("CertiKOS cannot manipulate more than %d IOAPICs.\n", MAX_IOAPIC);
        return;
    }

    ioapics[ioapic_num] = (ioapic_t *) addr;
  102a7e:	8b 83 a0 88 02 00    	mov    0x288a0(%ebx),%eax
  102a84:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  102a88:	89 8c 83 20 89 02 00 	mov    %ecx,0x28920(%ebx,%eax,4)
    ioapicid[ioapic_num] = id;
  102a8f:	8b 83 a0 88 02 00    	mov    0x288a0(%ebx),%eax
    gsi[ioapic_num] = g;
  102a95:	8b 4c 24 18          	mov    0x18(%esp),%ecx
    ioapicid[ioapic_num] = id;
  102a99:	88 94 03 00 89 02 00 	mov    %dl,0x28900(%ebx,%eax,1)
    gsi[ioapic_num] = g;
  102aa0:	8b 93 a0 88 02 00    	mov    0x288a0(%ebx),%edx
  102aa6:	8d 83 c0 88 02 00    	lea    0x288c0(%ebx),%eax
  102aac:	89 0c 90             	mov    %ecx,(%eax,%edx,4)

    ioapic_num++;
  102aaf:	8b 83 a0 88 02 00    	mov    0x288a0(%ebx),%eax
  102ab5:	83 c0 01             	add    $0x1,%eax
  102ab8:	89 83 a0 88 02 00    	mov    %eax,0x288a0(%ebx)
}
  102abe:	83 c4 08             	add    $0x8,%esp
  102ac1:	5b                   	pop    %ebx
  102ac2:	c3                   	ret    
  102ac3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102ac7:	90                   	nop
        KERN_WARN("CertiKOS cannot manipulate more than %d IOAPICs.\n", MAX_IOAPIC);
  102ac8:	8d 83 94 96 ff ff    	lea    -0x696c(%ebx),%eax
  102ace:	6a 10                	push   $0x10
  102ad0:	50                   	push   %eax
  102ad1:	8d 83 0d 97 ff ff    	lea    -0x68f3(%ebx),%eax
  102ad7:	6a 1f                	push   $0x1f
  102ad9:	50                   	push   %eax
  102ada:	e8 21 16 00 00       	call   104100 <debug_warn>
        return;
  102adf:	83 c4 10             	add    $0x10,%esp
}
  102ae2:	83 c4 08             	add    $0x8,%esp
  102ae5:	5b                   	pop    %ebx
  102ae6:	c3                   	ret    
  102ae7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102aee:	66 90                	xchg   %ax,%ax

00102af0 <ioapic_init>:

void ioapic_init(void)
{
  102af0:	55                   	push   %ebp
  102af1:	57                   	push   %edi
  102af2:	56                   	push   %esi
  102af3:	53                   	push   %ebx
  102af4:	e8 90 d8 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102af9:	81 c3 07 d5 00 00    	add    $0xd507,%ebx
  102aff:	83 ec 1c             	sub    $0x1c,%esp
    int i;
    for (i = 0; i < ioapic_num; i++) {
  102b02:	8b 83 a0 88 02 00    	mov    0x288a0(%ebx),%eax
  102b08:	89 1c 24             	mov    %ebx,(%esp)
  102b0b:	85 c0                	test   %eax,%eax
  102b0d:	0f 8e e7 00 00 00    	jle    102bfa <ioapic_init+0x10a>
  102b13:	89 d8                	mov    %ebx,%eax
  102b15:	8d 9b 00 89 02 00    	lea    0x28900(%ebx),%ebx
  102b1b:	31 ff                	xor    %edi,%edi
  102b1d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
        volatile ioapic_t *ioapic = ioapics[i];
        KERN_ASSERT(ioapic != NULL);
  102b21:	8d 98 1f 97 ff ff    	lea    -0x68e1(%eax),%ebx
  102b27:	8d 80 bf 92 ff ff    	lea    -0x6d41(%eax),%eax
  102b2d:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  102b31:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102b35:	8d 76 00             	lea    0x0(%esi),%esi
        volatile ioapic_t *ioapic = ioapics[i];
  102b38:	8b 04 24             	mov    (%esp),%eax
  102b3b:	8b b4 b8 20 89 02 00 	mov    0x28920(%eax,%edi,4),%esi
        KERN_ASSERT(ioapic != NULL);
  102b42:	85 f6                	test   %esi,%esi
  102b44:	0f 84 be 00 00 00    	je     102c08 <ioapic_init+0x118>
    base->reg = reg;
  102b4a:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
    return base->data;
  102b50:	8b 46 10             	mov    0x10(%esi),%eax

        lapicid_t id = ioapic_read(ioapic, IOAPIC_ID) >> 24;
        if (id == 0) {
  102b53:	c1 e8 18             	shr    $0x18,%eax
  102b56:	75 18                	jne    102b70 <ioapic_init+0x80>
            // I/O APIC ID not initialized yet - have to do it ourselves.
            ioapic_write(ioapic, IOAPIC_ID, ioapicid[i] << 24);
  102b58:	8b 5c 24 04          	mov    0x4(%esp),%ebx
  102b5c:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
    base->reg = reg;
  102b60:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
            ioapic_write(ioapic, IOAPIC_ID, ioapicid[i] << 24);
  102b66:	c1 e0 18             	shl    $0x18,%eax
    base->data = data;
  102b69:	89 46 10             	mov    %eax,0x10(%esi)
            id = ioapicid[i];
  102b6c:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
        }

        if (id != ioapicid[i])
  102b70:	8b 5c 24 04          	mov    0x4(%esp),%ebx
  102b74:	0f b6 14 3b          	movzbl (%ebx,%edi,1),%edx
  102b78:	38 c2                	cmp    %al,%dl
  102b7a:	74 28                	je     102ba4 <ioapic_init+0xb4>
            KERN_WARN("ioapic_init: id %d != ioapicid %d\n", id, ioapicid[i]);
  102b7c:	0f b6 14 3b          	movzbl (%ebx,%edi,1),%edx
  102b80:	83 ec 0c             	sub    $0xc,%esp
  102b83:	0f b6 c0             	movzbl %al,%eax
  102b86:	52                   	push   %edx
  102b87:	50                   	push   %eax
  102b88:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  102b8c:	8d 83 c8 96 ff ff    	lea    -0x6938(%ebx),%eax
  102b92:	50                   	push   %eax
  102b93:	8d 83 0d 97 ff ff    	lea    -0x68f3(%ebx),%eax
  102b99:	6a 39                	push   $0x39
  102b9b:	50                   	push   %eax
  102b9c:	e8 5f 15 00 00       	call   104100 <debug_warn>
  102ba1:	83 c4 20             	add    $0x20,%esp
    base->reg = reg;
  102ba4:	c7 06 01 00 00 00    	movl   $0x1,(%esi)
    return base->data;
  102baa:	8b 6e 10             	mov    0x10(%esi),%ebp

        int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;
  102bad:	c1 ed 10             	shr    $0x10,%ebp
  102bb0:	89 e8                	mov    %ebp,%eax
  102bb2:	0f b6 e8             	movzbl %al,%ebp
  102bb5:	b8 20 00 00 00       	mov    $0x20,%eax
  102bba:	83 c5 21             	add    $0x21,%ebp
  102bbd:	8d 76 00             	lea    0x0(%esi),%esi

        // Mark all interrupts edge-triggered, active high, disabled,
        // and not routed to any CPUs.
        int j;
        for (j = 0; j <= maxintr; j++) {
            ioapic_write(ioapic, IOAPIC_TABLE + 2 * j,
  102bc0:	8d 14 00             	lea    (%eax,%eax,1),%edx
                         IOAPIC_INT_DISABLED | (T_IRQ0 + j));
  102bc3:	89 c1                	mov    %eax,%ecx
        for (j = 0; j <= maxintr; j++) {
  102bc5:	83 c0 01             	add    $0x1,%eax
  102bc8:	8d 5a d0             	lea    -0x30(%edx),%ebx
                         IOAPIC_INT_DISABLED | (T_IRQ0 + j));
  102bcb:	81 c9 00 00 01 00    	or     $0x10000,%ecx
    base->reg = reg;
  102bd1:	83 ea 2f             	sub    $0x2f,%edx
  102bd4:	89 1e                	mov    %ebx,(%esi)
    base->data = data;
  102bd6:	89 4e 10             	mov    %ecx,0x10(%esi)
    base->reg = reg;
  102bd9:	89 16                	mov    %edx,(%esi)
    base->data = data;
  102bdb:	c7 46 10 00 00 00 00 	movl   $0x0,0x10(%esi)
        for (j = 0; j <= maxintr; j++) {
  102be2:	39 c5                	cmp    %eax,%ebp
  102be4:	75 da                	jne    102bc0 <ioapic_init+0xd0>
    for (i = 0; i < ioapic_num; i++) {
  102be6:	8b 04 24             	mov    (%esp),%eax
  102be9:	83 c7 01             	add    $0x1,%edi
  102bec:	8b 80 a0 88 02 00    	mov    0x288a0(%eax),%eax
  102bf2:	39 f8                	cmp    %edi,%eax
  102bf4:	0f 8f 3e ff ff ff    	jg     102b38 <ioapic_init+0x48>
            ioapic_write(ioapic, IOAPIC_TABLE + 2 * j + 1, 0);
        }
    }
}
  102bfa:	83 c4 1c             	add    $0x1c,%esp
  102bfd:	5b                   	pop    %ebx
  102bfe:	5e                   	pop    %esi
  102bff:	5f                   	pop    %edi
  102c00:	5d                   	pop    %ebp
  102c01:	c3                   	ret    
  102c02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        KERN_ASSERT(ioapic != NULL);
  102c08:	ff 74 24 08          	push   0x8(%esp)
  102c0c:	ff 74 24 10          	push   0x10(%esp)
  102c10:	6a 2f                	push   $0x2f
  102c12:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  102c16:	8d 83 0d 97 ff ff    	lea    -0x68f3(%ebx),%eax
  102c1c:	50                   	push   %eax
  102c1d:	e8 0e 14 00 00       	call   104030 <debug_panic>
  102c22:	83 c4 10             	add    $0x10,%esp
  102c25:	e9 20 ff ff ff       	jmp    102b4a <ioapic_init+0x5a>
  102c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102c30 <ioapic_enable>:

void ioapic_enable(uint8_t irq, lapicid_t apicid, bool trigger_mode, bool polarity)
{
  102c30:	55                   	push   %ebp
  102c31:	57                   	push   %edi
  102c32:	56                   	push   %esi
  102c33:	53                   	push   %ebx
  102c34:	e8 50 d7 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102c39:	81 c3 c7 d3 00 00    	add    $0xd3c7,%ebx
  102c3f:	83 ec 2c             	sub    $0x2c,%esp
  102c42:	8b 44 24 44          	mov    0x44(%esp),%eax
  102c46:	8b 4c 24 40          	mov    0x40(%esp),%ecx
  102c4a:	89 44 24 10          	mov    %eax,0x10(%esp)
  102c4e:	8b 44 24 48          	mov    0x48(%esp),%eax
  102c52:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
  102c56:	89 44 24 14          	mov    %eax,0x14(%esp)
  102c5a:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  102c5e:	89 44 24 18          	mov    %eax,0x18(%esp)
    // Mark interrupt edge-triggered, active high,
    // enabled, and routed to the given APIC ID,
    int i;
    for (i = 0; i < ioapic_num; i++) {
  102c62:	8b 83 a0 88 02 00    	mov    0x288a0(%ebx),%eax
  102c68:	85 c0                	test   %eax,%eax
  102c6a:	0f 8e d8 00 00 00    	jle    102d48 <ioapic_enable+0x118>
            break;
        }
    }

    if (i == ioapic_num)
        KERN_PANIC("Cannot enable IRQ %d on IOAPIC.\n", irq);
  102c70:	0f b6 c9             	movzbl %cl,%ecx
    for (i = 0; i < ioapic_num; i++) {
  102c73:	31 c0                	xor    %eax,%eax
  102c75:	8d b3 c0 88 02 00    	lea    0x288c0(%ebx),%esi
  102c7b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  102c7f:	90                   	nop
        ioapic_t *ioapic = ioapics[i];
  102c80:	8b 94 83 20 89 02 00 	mov    0x28920(%ebx,%eax,4),%edx
    base->reg = reg;
  102c87:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
    return base->data;
  102c8d:	8b 7a 10             	mov    0x10(%edx),%edi
        if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
  102c90:	8b 2c 86             	mov    (%esi,%eax,4),%ebp
  102c93:	3b 6c 24 0c          	cmp    0xc(%esp),%ebp
  102c97:	7f 13                	jg     102cac <ioapic_enable+0x7c>
        int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;
  102c99:	c1 ef 10             	shr    $0x10,%edi
        if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
  102c9c:	8b 2c 86             	mov    (%esi,%eax,4),%ebp
        int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;
  102c9f:	89 f9                	mov    %edi,%ecx
  102ca1:	0f b6 f9             	movzbl %cl,%edi
        if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
  102ca4:	01 ef                	add    %ebp,%edi
  102ca6:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  102caa:	7d 24                	jge    102cd0 <ioapic_enable+0xa0>
    for (i = 0; i < ioapic_num; i++) {
  102cac:	8b 93 a0 88 02 00    	mov    0x288a0(%ebx),%edx
  102cb2:	83 c0 01             	add    $0x1,%eax
  102cb5:	39 c2                	cmp    %eax,%edx
  102cb7:	7f c7                	jg     102c80 <ioapic_enable+0x50>
    if (i == ioapic_num)
  102cb9:	8b 93 a0 88 02 00    	mov    0x288a0(%ebx),%edx
  102cbf:	39 c2                	cmp    %eax,%edx
  102cc1:	74 5f                	je     102d22 <ioapic_enable+0xf2>
}
  102cc3:	83 c4 2c             	add    $0x2c,%esp
  102cc6:	5b                   	pop    %ebx
  102cc7:	5e                   	pop    %esi
  102cc8:	5f                   	pop    %edi
  102cc9:	5d                   	pop    %ebp
  102cca:	c3                   	ret    
  102ccb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102ccf:	90                   	nop
                         ((trigger_mode << 15) | (polarity << 13) | (T_IRQ0 + irq)));
  102cd0:	0f b6 6c 24 14       	movzbl 0x14(%esp),%ebp
  102cd5:	0f b6 7c 24 18       	movzbl 0x18(%esp),%edi
  102cda:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  102cde:	c1 e5 0f             	shl    $0xf,%ebp
  102ce1:	c1 e7 0d             	shl    $0xd,%edi
  102ce4:	09 ef                	or     %ebp,%edi
  102ce6:	8d 69 20             	lea    0x20(%ecx),%ebp
  102ce9:	09 fd                	or     %edi,%ebp
                         IOAPIC_TABLE + 2 * (irq - gsi[i]),
  102ceb:	8b 3c 86             	mov    (%esi,%eax,4),%edi
                         ((trigger_mode << 15) | (polarity << 13) | (T_IRQ0 + irq)));
  102cee:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
                         IOAPIC_TABLE + 2 * (irq - gsi[i]),
  102cf2:	89 cd                	mov    %ecx,%ebp
  102cf4:	29 fd                	sub    %edi,%ebp
            ioapic_write(ioapic,
  102cf6:	8d 7c 2d 10          	lea    0x10(%ebp,%ebp,1),%edi
    base->reg = reg;
  102cfa:	89 3a                	mov    %edi,(%edx)
    base->data = data;
  102cfc:	8b 7c 24 0c          	mov    0xc(%esp),%edi
  102d00:	89 7a 10             	mov    %edi,0x10(%edx)
                         IOAPIC_TABLE + 2 * (irq - gsi[i]) + 1,
  102d03:	8b 34 86             	mov    (%esi,%eax,4),%esi
                         apicid << 24);
  102d06:	8b 7c 24 10          	mov    0x10(%esp),%edi
                         IOAPIC_TABLE + 2 * (irq - gsi[i]) + 1,
  102d0a:	29 f1                	sub    %esi,%ecx
                         apicid << 24);
  102d0c:	c1 e7 18             	shl    $0x18,%edi
            ioapic_write(ioapic,
  102d0f:	8d 4c 09 11          	lea    0x11(%ecx,%ecx,1),%ecx
    base->reg = reg;
  102d13:	89 0a                	mov    %ecx,(%edx)
    base->data = data;
  102d15:	89 7a 10             	mov    %edi,0x10(%edx)
    if (i == ioapic_num)
  102d18:	8b 93 a0 88 02 00    	mov    0x288a0(%ebx),%edx
  102d1e:	39 c2                	cmp    %eax,%edx
  102d20:	75 a1                	jne    102cc3 <ioapic_enable+0x93>
        KERN_PANIC("Cannot enable IRQ %d on IOAPIC.\n", irq);
  102d22:	0f b6 44 24 1c       	movzbl 0x1c(%esp),%eax
  102d27:	50                   	push   %eax
  102d28:	8d 83 ec 96 ff ff    	lea    -0x6914(%ebx),%eax
  102d2e:	50                   	push   %eax
  102d2f:	8d 83 0d 97 ff ff    	lea    -0x68f3(%ebx),%eax
  102d35:	6a 5d                	push   $0x5d
  102d37:	50                   	push   %eax
  102d38:	e8 f3 12 00 00       	call   104030 <debug_panic>
  102d3d:	83 c4 10             	add    $0x10,%esp
}
  102d40:	83 c4 2c             	add    $0x2c,%esp
  102d43:	5b                   	pop    %ebx
  102d44:	5e                   	pop    %esi
  102d45:	5f                   	pop    %edi
  102d46:	5d                   	pop    %ebp
  102d47:	c3                   	ret    
    for (i = 0; i < ioapic_num; i++) {
  102d48:	31 c0                	xor    %eax,%eax
  102d4a:	e9 6a ff ff ff       	jmp    102cb9 <ioapic_enable+0x89>
  102d4f:	90                   	nop

00102d50 <ioapic_number>:

int ioapic_number(void)
{
    return ioapic_num;
  102d50:	e8 2c d6 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  102d55:	05 ab d2 00 00       	add    $0xd2ab,%eax
  102d5a:	8b 80 a0 88 02 00    	mov    0x288a0(%eax),%eax
}
  102d60:	c3                   	ret    
  102d61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102d68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102d6f:	90                   	nop

00102d70 <ioapic_get>:

ioapic_t *ioapic_get(uint32_t idx)
{
    if (idx >= ioapic_num)
  102d70:	e8 0c d6 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  102d75:	05 8b d2 00 00       	add    $0xd28b,%eax
{
  102d7a:	8b 54 24 04          	mov    0x4(%esp),%edx
    if (idx >= ioapic_num)
  102d7e:	8b 88 a0 88 02 00    	mov    0x288a0(%eax),%ecx
  102d84:	39 d1                	cmp    %edx,%ecx
  102d86:	76 08                	jbe    102d90 <ioapic_get+0x20>
        return NULL;
    return ioapics[idx];
  102d88:	8b 84 90 20 89 02 00 	mov    0x28920(%eax,%edx,4),%eax
  102d8f:	c3                   	ret    
        return NULL;
  102d90:	31 c0                	xor    %eax,%eax
}
  102d92:	c3                   	ret    
  102d93:	66 90                	xchg   %ax,%ax
  102d95:	66 90                	xchg   %ax,%ax
  102d97:	66 90                	xchg   %ax,%ax
  102d99:	66 90                	xchg   %ax,%ax
  102d9b:	66 90                	xchg   %ax,%ax
  102d9d:	66 90                	xchg   %ax,%ax
  102d9f:	90                   	nop

00102da0 <mpsearch1>:
    return sum;
}

/* Look for an MP structure in the len bytes at addr. */
static struct mp *mpsearch1(uint8_t *addr, int len)
{
  102da0:	55                   	push   %ebp
  102da1:	57                   	push   %edi
  102da2:	56                   	push   %esi
  102da3:	89 c6                	mov    %eax,%esi
    uint8_t *e, *p;

    e = addr + len;
  102da5:	01 d0                	add    %edx,%eax
{
  102da7:	53                   	push   %ebx
  102da8:	e8 dc d5 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102dad:	81 c3 53 d2 00 00    	add    $0xd253,%ebx
  102db3:	83 ec 1c             	sub    $0x1c,%esp
    e = addr + len;
  102db6:	89 44 24 0c          	mov    %eax,0xc(%esp)
    for (p = addr; p < e; p += sizeof(struct mp))
  102dba:	39 c6                	cmp    %eax,%esi
  102dbc:	73 5a                	jae    102e18 <mpsearch1+0x78>
  102dbe:	8d bb 2e 97 ff ff    	lea    -0x68d2(%ebx),%edi
  102dc4:	eb 12                	jmp    102dd8 <mpsearch1+0x38>
  102dc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102dcd:	8d 76 00             	lea    0x0(%esi),%esi
  102dd0:	89 ee                	mov    %ebp,%esi
  102dd2:	39 6c 24 0c          	cmp    %ebp,0xc(%esp)
  102dd6:	76 40                	jbe    102e18 <mpsearch1+0x78>
        if (memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102dd8:	83 ec 04             	sub    $0x4,%esp
  102ddb:	8d 6e 10             	lea    0x10(%esi),%ebp
  102dde:	6a 04                	push   $0x4
  102de0:	57                   	push   %edi
  102de1:	56                   	push   %esi
  102de2:	e8 79 11 00 00       	call   103f60 <memcmp>
  102de7:	83 c4 10             	add    $0x10,%esp
  102dea:	89 c2                	mov    %eax,%edx
  102dec:	85 c0                	test   %eax,%eax
  102dee:	75 e0                	jne    102dd0 <mpsearch1+0x30>
  102df0:	89 f0                	mov    %esi,%eax
  102df2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        sum += addr[i];
  102df8:	0f b6 08             	movzbl (%eax),%ecx
    for (i = 0; i < len; i++)
  102dfb:	83 c0 01             	add    $0x1,%eax
        sum += addr[i];
  102dfe:	01 ca                	add    %ecx,%edx
    for (i = 0; i < len; i++)
  102e00:	39 e8                	cmp    %ebp,%eax
  102e02:	75 f4                	jne    102df8 <mpsearch1+0x58>
        if (memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102e04:	84 d2                	test   %dl,%dl
  102e06:	75 c8                	jne    102dd0 <mpsearch1+0x30>
            return (struct mp *) p;
    return 0;
}
  102e08:	83 c4 1c             	add    $0x1c,%esp
  102e0b:	89 f0                	mov    %esi,%eax
  102e0d:	5b                   	pop    %ebx
  102e0e:	5e                   	pop    %esi
  102e0f:	5f                   	pop    %edi
  102e10:	5d                   	pop    %ebp
  102e11:	c3                   	ret    
  102e12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102e18:	83 c4 1c             	add    $0x1c,%esp
    return 0;
  102e1b:	31 c0                	xor    %eax,%eax
}
  102e1d:	5b                   	pop    %ebx
  102e1e:	5e                   	pop    %esi
  102e1f:	5f                   	pop    %edi
  102e20:	5d                   	pop    %ebp
  102e21:	c3                   	ret    
  102e22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102e30 <pcpu_mp_init>:

/*
 * Multiple processors initialization method using ACPI
 */
bool pcpu_mp_init(void)
{
  102e30:	55                   	push   %ebp
  102e31:	57                   	push   %edi
  102e32:	56                   	push   %esi
  102e33:	53                   	push   %ebx
  102e34:	e8 50 d5 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  102e39:	81 c3 c7 d1 00 00    	add    $0xd1c7,%ebx
  102e3f:	83 ec 2c             	sub    $0x2c,%esp
    acpi_xsdt_t *xsdt;
    acpi_madt_t *madt;
    uint32_t ap_idx = 1;
    bool found_bsp = FALSE;

    if (mp_inited == TRUE)
  102e42:	80 bb 61 89 02 00 01 	cmpb   $0x1,0x28961(%ebx)
  102e49:	0f 84 8a 01 00 00    	je     102fd9 <pcpu_mp_init+0x1a9>
        return TRUE;

    KERN_INFO("\n");
  102e4f:	83 ec 0c             	sub    $0xc,%esp
  102e52:	8d 83 23 a6 ff ff    	lea    -0x59dd(%ebx),%eax
  102e58:	50                   	push   %eax
  102e59:	e8 62 11 00 00       	call   103fc0 <debug_info>

    if ((rsdp = acpi_probe_rsdp()) == NULL) {
  102e5e:	e8 ed f3 ff ff       	call   102250 <acpi_probe_rsdp>
  102e63:	83 c4 10             	add    $0x10,%esp
  102e66:	89 c6                	mov    %eax,%esi
  102e68:	85 c0                	test   %eax,%eax
  102e6a:	0f 84 90 02 00 00    	je     103100 <pcpu_mp_init+0x2d0>
        KERN_DEBUG("Not found RSDP.\n");
        goto fallback;
    }

    xsdt = NULL;
    if ((xsdt = acpi_probe_xsdt(rsdp)) == NULL &&
  102e70:	83 ec 0c             	sub    $0xc,%esp
  102e73:	50                   	push   %eax
  102e74:	e8 c7 f5 ff ff       	call   102440 <acpi_probe_xsdt>
  102e79:	83 c4 10             	add    $0x10,%esp
  102e7c:	85 c0                	test   %eax,%eax
  102e7e:	0f 84 1c 02 00 00    	je     1030a0 <pcpu_mp_init+0x270>
        goto fallback;
    }

    if ((madt =
         (xsdt != NULL) ?
         (acpi_madt_t *) acpi_probe_xsdt_ent(xsdt, ACPI_MADT_SIG) :
  102e84:	83 ec 08             	sub    $0x8,%esp
  102e87:	68 41 50 49 43       	push   $0x43495041
  102e8c:	50                   	push   %eax
  102e8d:	e8 3e f6 ff ff       	call   1024d0 <acpi_probe_xsdt_ent>
  102e92:	83 c4 10             	add    $0x10,%esp
  102e95:	89 c7                	mov    %eax,%edi
    if ((madt =
  102e97:	85 ff                	test   %edi,%edi
  102e99:	0f 84 59 04 00 00    	je     1032f8 <pcpu_mp_init+0x4c8>
        KERN_DEBUG("Not found MADT.\n");
        goto fallback;
    }

    ismp = TRUE;
    lapic_register(madt->lapic_addr);
  102e9f:	83 ec 0c             	sub    $0xc,%esp
  102ea2:	ff 77 24             	push   0x24(%edi)
    ncpu = 0;

    p = (uint8_t *) madt->ent;
  102ea5:	8d 6f 2c             	lea    0x2c(%edi),%ebp
    ismp = TRUE;
  102ea8:	c6 83 60 89 02 00 01 	movb   $0x1,0x28960(%ebx)
    lapic_register(madt->lapic_addr);
  102eaf:	e8 bc f6 ff ff       	call   102570 <lapic_register>
    e = (uint8_t *) madt + madt->length;
  102eb4:	8b 77 04             	mov    0x4(%edi),%esi

    while (p < e) {
  102eb7:	83 c4 10             	add    $0x10,%esp
    ncpu = 0;
  102eba:	c7 83 64 89 02 00 00 	movl   $0x0,0x28964(%ebx)
  102ec1:	00 00 00 
    e = (uint8_t *) madt + madt->length;
  102ec4:	01 fe                	add    %edi,%esi
    while (p < e) {
  102ec6:	39 f5                	cmp    %esi,%ebp
  102ec8:	0f 83 99 00 00 00    	jae    102f67 <pcpu_mp_init+0x137>

            if (!(lapic_ent->flags & ACPI_APIC_ENABLED)) {
                break;
            }

            KERN_INFO("\tCPU%d: APIC id = %x, ", ncpu, lapic_ent->lapic_id);
  102ece:	8d 83 68 97 ff ff    	lea    -0x6898(%ebx),%eax
    bool found_bsp = FALSE;
  102ed4:	31 c9                	xor    %ecx,%ecx
            if (!found_bsp) {
                found_bsp = TRUE;
                KERN_INFO("BSP\n");
                pcpu_mp_init_cpu(0, lapic_ent->lapic_id, TRUE);
            } else {
                KERN_INFO("AP\n");
  102ed6:	89 7c 24 14          	mov    %edi,0x14(%esp)
  102eda:	89 ef                	mov    %ebp,%edi
            KERN_INFO("\tCPU%d: APIC id = %x, ", ncpu, lapic_ent->lapic_id);
  102edc:	89 44 24 10          	mov    %eax,0x10(%esp)
                KERN_INFO("AP\n");
  102ee0:	8d 83 84 97 ff ff    	lea    -0x687c(%ebx),%eax
  102ee6:	89 cd                	mov    %ecx,%ebp
    uint32_t ap_idx = 1;
  102ee8:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
  102eef:	00 
                KERN_INFO("AP\n");
  102ef0:	89 44 24 18          	mov    %eax,0x18(%esp)
  102ef4:	eb 27                	jmp    102f1d <pcpu_mp_init+0xed>
  102ef6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102efd:	8d 76 00             	lea    0x0(%esi),%esi

            ioapic_register(ioapic_ent->ioapic_addr, ioapic_ent->ioapic_id,
                            ioapic_ent->gsi);
            break;
        default:
            KERN_INFO("\tUnhandled ACPI entry (type=%x)\n", hdr->type);
  102f00:	83 ec 08             	sub    $0x8,%esp
  102f03:	50                   	push   %eax
  102f04:	8d 83 38 98 ff ff    	lea    -0x67c8(%ebx),%eax
  102f0a:	50                   	push   %eax
  102f0b:	e8 b0 10 00 00       	call   103fc0 <debug_info>
            break;
  102f10:	83 c4 10             	add    $0x10,%esp
        }

        p += hdr->length;
  102f13:	0f b6 47 01          	movzbl 0x1(%edi),%eax
  102f17:	01 c7                	add    %eax,%edi
    while (p < e) {
  102f19:	39 fe                	cmp    %edi,%esi
  102f1b:	76 46                	jbe    102f63 <pcpu_mp_init+0x133>
        switch (hdr->type) {
  102f1d:	0f b6 07             	movzbl (%edi),%eax
  102f20:	84 c0                	test   %al,%al
  102f22:	0f 84 c8 00 00 00    	je     102ff0 <pcpu_mp_init+0x1c0>
  102f28:	3c 01                	cmp    $0x1,%al
  102f2a:	75 d4                	jne    102f00 <pcpu_mp_init+0xd0>
            KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
  102f2c:	83 ec 04             	sub    $0x4,%esp
  102f2f:	ff 77 04             	push   0x4(%edi)
  102f32:	0f b6 47 02          	movzbl 0x2(%edi),%eax
  102f36:	50                   	push   %eax
  102f37:	8d 83 14 98 ff ff    	lea    -0x67ec(%ebx),%eax
  102f3d:	50                   	push   %eax
  102f3e:	e8 7d 10 00 00       	call   103fc0 <debug_info>
            ioapic_register(ioapic_ent->ioapic_addr, ioapic_ent->ioapic_id,
  102f43:	83 c4 0c             	add    $0xc,%esp
  102f46:	ff 77 08             	push   0x8(%edi)
  102f49:	0f b6 47 02          	movzbl 0x2(%edi),%eax
  102f4d:	50                   	push   %eax
  102f4e:	ff 77 04             	push   0x4(%edi)
  102f51:	e8 0a fb ff ff       	call   102a60 <ioapic_register>
        p += hdr->length;
  102f56:	0f b6 47 01          	movzbl 0x1(%edi),%eax
            break;
  102f5a:	83 c4 10             	add    $0x10,%esp
        p += hdr->length;
  102f5d:	01 c7                	add    %eax,%edi
    while (p < e) {
  102f5f:	39 fe                	cmp    %edi,%esi
  102f61:	77 ba                	ja     102f1d <pcpu_mp_init+0xed>
  102f63:	8b 7c 24 14          	mov    0x14(%esp),%edi
    /*
     * Force NMI and 8259 signals to APIC when PIC mode
     * is not implemented.
     *
     */
    if ((madt->flags & APIC_MADT_PCAT_COMPAT) == 0) {
  102f67:	f6 47 28 01          	testb  $0x1,0x28(%edi)
  102f6b:	0f 84 5f 01 00 00    	je     1030d0 <pcpu_mp_init+0x2a0>
    }

    /*
     * Copy AP boot code to 0x8000.
     */
    memmove((uint8_t *) 0x8000,
  102f71:	83 ec 04             	sub    $0x4,%esp
  102f74:	ff b3 e8 ff ff ff    	push   -0x18(%ebx)
  102f7a:	ff b3 fc ff ff ff    	push   -0x4(%ebx)
  102f80:	68 00 80 00 00       	push   $0x8000
  102f85:	e8 16 0e 00 00       	call   103da0 <memmove>
            _binary___obj_kern_init_boot_ap_start,
            (size_t) _binary___obj_kern_init_boot_ap_size);

    mp_inited = TRUE;
    return TRUE;
  102f8a:	83 c4 10             	add    $0x10,%esp
  102f8d:	b8 01 00 00 00       	mov    $0x1,%eax
    mp_inited = TRUE;
  102f92:	c6 83 61 89 02 00 01 	movb   $0x1,0x28961(%ebx)
        ismp = 0;
        ncpu = 1;
        return FALSE;
    } else
        return TRUE;
}
  102f99:	83 c4 2c             	add    $0x2c,%esp
  102f9c:	5b                   	pop    %ebx
  102f9d:	5e                   	pop    %esi
  102f9e:	5f                   	pop    %edi
  102f9f:	5d                   	pop    %ebp
  102fa0:	c3                   	ret    
  102fa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102fa8:	8b 7c 24 18          	mov    0x18(%esp),%edi
    if (mp->imcrp) {
  102fac:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
  102fb0:	0f 85 51 04 00 00    	jne    103407 <pcpu_mp_init+0x5d7>
    memcpy((uint8_t *) 0x8000,
  102fb6:	83 ec 04             	sub    $0x4,%esp
  102fb9:	ff b3 e8 ff ff ff    	push   -0x18(%ebx)
  102fbf:	ff b3 fc ff ff ff    	push   -0x4(%ebx)
  102fc5:	68 00 80 00 00       	push   $0x8000
  102fca:	e8 41 0e 00 00       	call   103e10 <memcpy>
    mp_inited = TRUE;
  102fcf:	c6 83 61 89 02 00 01 	movb   $0x1,0x28961(%ebx)
  102fd6:	83 c4 10             	add    $0x10,%esp
}
  102fd9:	83 c4 2c             	add    $0x2c,%esp
        return TRUE;
  102fdc:	b8 01 00 00 00       	mov    $0x1,%eax
}
  102fe1:	5b                   	pop    %ebx
  102fe2:	5e                   	pop    %esi
  102fe3:	5f                   	pop    %edi
  102fe4:	5d                   	pop    %ebp
  102fe5:	c3                   	ret    
  102fe6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102fed:	8d 76 00             	lea    0x0(%esi),%esi
            if (!(lapic_ent->flags & ACPI_APIC_ENABLED)) {
  102ff0:	f6 47 04 01          	testb  $0x1,0x4(%edi)
  102ff4:	0f 84 19 ff ff ff    	je     102f13 <pcpu_mp_init+0xe3>
            KERN_INFO("\tCPU%d: APIC id = %x, ", ncpu, lapic_ent->lapic_id);
  102ffa:	0f b6 47 03          	movzbl 0x3(%edi),%eax
  102ffe:	83 ec 04             	sub    $0x4,%esp
  103001:	50                   	push   %eax
  103002:	ff b3 64 89 02 00    	push   0x28964(%ebx)
  103008:	ff 74 24 1c          	push   0x1c(%esp)
  10300c:	e8 af 0f 00 00       	call   103fc0 <debug_info>
            if (!found_bsp) {
  103011:	89 e8                	mov    %ebp,%eax
  103013:	83 c4 10             	add    $0x10,%esp
  103016:	84 c0                	test   %al,%al
  103018:	74 4e                	je     103068 <pcpu_mp_init+0x238>
                KERN_INFO("AP\n");
  10301a:	83 ec 0c             	sub    $0xc,%esp
  10301d:	ff 74 24 24          	push   0x24(%esp)
  103021:	e8 9a 0f 00 00       	call   103fc0 <debug_info>
    if (idx >= NUM_CPUS)
  103026:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  10302a:	83 c4 10             	add    $0x10,%esp
  10302d:	83 f8 07             	cmp    $0x7,%eax
  103030:	77 1b                	ja     10304d <pcpu_mp_init+0x21d>
    struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);
  103032:	83 ec 0c             	sub    $0xc,%esp
                pcpu_mp_init_cpu(ap_idx, lapic_ent->lapic_id, FALSE);
  103035:	0f b6 6f 03          	movzbl 0x3(%edi),%ebp
    struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);
  103039:	50                   	push   %eax
  10303a:	e8 41 2b 00 00       	call   105b80 <get_pcpu_arch_info_pointer>
    info->lapicid = lapic_id;
  10303f:	89 e9                	mov    %ebp,%ecx
    info->bsp = is_bsp;
  103041:	83 c4 10             	add    $0x10,%esp
    info->lapicid = lapic_id;
  103044:	0f b6 c9             	movzbl %cl,%ecx
    info->bsp = is_bsp;
  103047:	c6 40 04 00          	movb   $0x0,0x4(%eax)
    info->lapicid = lapic_id;
  10304b:	89 08                	mov    %ecx,(%eax)
                ap_idx++;
  10304d:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)
            ncpu++;
  103052:	83 83 64 89 02 00 01 	addl   $0x1,0x28964(%ebx)
            break;
  103059:	bd 01 00 00 00       	mov    $0x1,%ebp
  10305e:	e9 b0 fe ff ff       	jmp    102f13 <pcpu_mp_init+0xe3>
  103063:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103067:	90                   	nop
                KERN_INFO("BSP\n");
  103068:	83 ec 0c             	sub    $0xc,%esp
  10306b:	8d 83 7f 97 ff ff    	lea    -0x6881(%ebx),%eax
  103071:	50                   	push   %eax
  103072:	e8 49 0f 00 00       	call   103fc0 <debug_info>
                pcpu_mp_init_cpu(0, lapic_ent->lapic_id, TRUE);
  103077:	0f b6 6f 03          	movzbl 0x3(%edi),%ebp
    struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);
  10307b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  103082:	e8 f9 2a 00 00       	call   105b80 <get_pcpu_arch_info_pointer>
    info->bsp = is_bsp;
  103087:	83 c4 10             	add    $0x10,%esp
    info->lapicid = lapic_id;
  10308a:	89 e9                	mov    %ebp,%ecx
    info->bsp = is_bsp;
  10308c:	c6 40 04 01          	movb   $0x1,0x4(%eax)
    info->lapicid = lapic_id;
  103090:	0f b6 e9             	movzbl %cl,%ebp
  103093:	89 28                	mov    %ebp,(%eax)
    info->bsp = is_bsp;
  103095:	eb bb                	jmp    103052 <pcpu_mp_init+0x222>
  103097:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10309e:	66 90                	xchg   %ax,%ax
        (rsdt = acpi_probe_rsdt(rsdp)) == NULL) {
  1030a0:	83 ec 0c             	sub    $0xc,%esp
  1030a3:	56                   	push   %esi
  1030a4:	e8 67 f2 ff ff       	call   102310 <acpi_probe_rsdt>
    if ((xsdt = acpi_probe_xsdt(rsdp)) == NULL &&
  1030a9:	83 c4 10             	add    $0x10,%esp
  1030ac:	85 c0                	test   %eax,%eax
  1030ae:	0f 84 83 03 00 00    	je     103437 <pcpu_mp_init+0x607>
         (acpi_madt_t *) acpi_probe_rsdt_ent(rsdt, ACPI_MADT_SIG)) == NULL) {
  1030b4:	83 ec 08             	sub    $0x8,%esp
  1030b7:	68 41 50 49 43       	push   $0x43495041
  1030bc:	50                   	push   %eax
  1030bd:	e8 de f2 ff ff       	call   1023a0 <acpi_probe_rsdt_ent>
  1030c2:	83 c4 10             	add    $0x10,%esp
  1030c5:	89 c7                	mov    %eax,%edi
  1030c7:	e9 cb fd ff ff       	jmp    102e97 <pcpu_mp_init+0x67>
  1030cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        outb(0x22, 0x70);
  1030d0:	83 ec 08             	sub    $0x8,%esp
  1030d3:	6a 70                	push   $0x70
  1030d5:	6a 22                	push   $0x22
  1030d7:	e8 54 1d 00 00       	call   104e30 <outb>
        outb(0x23, inb(0x23) | 1);
  1030dc:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
  1030e3:	e8 18 1d 00 00       	call   104e00 <inb>
  1030e8:	5e                   	pop    %esi
  1030e9:	5f                   	pop    %edi
  1030ea:	83 c8 01             	or     $0x1,%eax
  1030ed:	0f b6 c0             	movzbl %al,%eax
  1030f0:	50                   	push   %eax
  1030f1:	6a 23                	push   $0x23
  1030f3:	e8 38 1d 00 00       	call   104e30 <outb>
  1030f8:	83 c4 10             	add    $0x10,%esp
  1030fb:	e9 71 fe ff ff       	jmp    102f71 <pcpu_mp_init+0x141>
        KERN_DEBUG("Not found RSDP.\n");
  103100:	83 ec 04             	sub    $0x4,%esp
  103103:	8d 83 33 97 ff ff    	lea    -0x68cd(%ebx),%eax
  103109:	50                   	push   %eax
  10310a:	68 4f 01 00 00       	push   $0x14f
        KERN_DEBUG("Not found MADT.\n");
  10310f:	8d 83 44 97 ff ff    	lea    -0x68bc(%ebx),%eax
  103115:	89 44 24 18          	mov    %eax,0x18(%esp)
  103119:	50                   	push   %eax
  10311a:	e8 d1 0e 00 00       	call   103ff0 <debug_normal>
        goto fallback;
  10311f:	83 c4 10             	add    $0x10,%esp
    KERN_DEBUG("Use the fallback multiprocessor initialization.\n");
  103122:	8d 83 5c 98 ff ff    	lea    -0x67a4(%ebx),%eax
  103128:	83 ec 04             	sub    $0x4,%esp
  10312b:	50                   	push   %eax
  10312c:	68 ac 01 00 00       	push   $0x1ac
  103131:	ff 74 24 18          	push   0x18(%esp)
  103135:	e8 b6 0e 00 00       	call   103ff0 <debug_normal>
    if (mp_inited == TRUE)
  10313a:	83 c4 10             	add    $0x10,%esp
  10313d:	80 bb 61 89 02 00 01 	cmpb   $0x1,0x28961(%ebx)
  103144:	0f 84 8f fe ff ff    	je     102fd9 <pcpu_mp_init+0x1a9>
    if ((p = ((bda[0x0F] << 8) | bda[0x0E]) << 4)) {
  10314a:	0f b6 05 0f 04 00 00 	movzbl 0x40f,%eax
  103151:	0f b6 15 0e 04 00 00 	movzbl 0x40e,%edx
  103158:	c1 e0 08             	shl    $0x8,%eax
  10315b:	09 d0                	or     %edx,%eax
  10315d:	c1 e0 04             	shl    $0x4,%eax
  103160:	75 1b                	jne    10317d <pcpu_mp_init+0x34d>
        p = ((bda[0x14] << 8) | bda[0x13]) * 1024;
  103162:	0f b6 05 14 04 00 00 	movzbl 0x414,%eax
  103169:	0f b6 15 13 04 00 00 	movzbl 0x413,%edx
  103170:	c1 e0 08             	shl    $0x8,%eax
  103173:	09 d0                	or     %edx,%eax
  103175:	c1 e0 0a             	shl    $0xa,%eax
        if ((mp = mpsearch1((uint8_t *) p - 1024, 1024)))
  103178:	2d 00 04 00 00       	sub    $0x400,%eax
        if ((mp = mpsearch1((uint8_t *) p, 1024)))
  10317d:	ba 00 04 00 00       	mov    $0x400,%edx
  103182:	e8 19 fc ff ff       	call   102da0 <mpsearch1>
  103187:	89 c7                	mov    %eax,%edi
  103189:	85 c0                	test   %eax,%eax
  10318b:	0f 84 ef 01 00 00    	je     103380 <pcpu_mp_init+0x550>
    if ((mp = mpsearch()) == 0 || mp->physaddr == 0)
  103191:	8b 77 04             	mov    0x4(%edi),%esi
  103194:	85 f6                	test   %esi,%esi
  103196:	0f 84 e4 00 00 00    	je     103280 <pcpu_mp_init+0x450>
    if (memcmp(conf, "PCMP", 4) != 0)
  10319c:	83 ec 04             	sub    $0x4,%esp
  10319f:	8d 83 88 97 ff ff    	lea    -0x6878(%ebx),%eax
  1031a5:	6a 04                	push   $0x4
  1031a7:	50                   	push   %eax
  1031a8:	56                   	push   %esi
  1031a9:	e8 b2 0d 00 00       	call   103f60 <memcmp>
  1031ae:	83 c4 10             	add    $0x10,%esp
  1031b1:	89 c2                	mov    %eax,%edx
  1031b3:	85 c0                	test   %eax,%eax
  1031b5:	0f 85 c5 00 00 00    	jne    103280 <pcpu_mp_init+0x450>
    if (conf->version != 1 && conf->version != 4)
  1031bb:	0f b6 46 06          	movzbl 0x6(%esi),%eax
  1031bf:	3c 01                	cmp    $0x1,%al
  1031c1:	74 08                	je     1031cb <pcpu_mp_init+0x39b>
  1031c3:	3c 04                	cmp    $0x4,%al
  1031c5:	0f 85 b5 00 00 00    	jne    103280 <pcpu_mp_init+0x450>
    if (sum((uint8_t *) conf, conf->length) != 0)
  1031cb:	0f b7 6e 04          	movzwl 0x4(%esi),%ebp
    for (i = 0; i < len; i++)
  1031cf:	66 85 ed             	test   %bp,%bp
  1031d2:	74 20                	je     1031f4 <pcpu_mp_init+0x3c4>
  1031d4:	89 f0                	mov    %esi,%eax
  1031d6:	01 f5                	add    %esi,%ebp
  1031d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1031df:	90                   	nop
        sum += addr[i];
  1031e0:	0f b6 08             	movzbl (%eax),%ecx
    for (i = 0; i < len; i++)
  1031e3:	83 c0 01             	add    $0x1,%eax
        sum += addr[i];
  1031e6:	01 ca                	add    %ecx,%edx
    for (i = 0; i < len; i++)
  1031e8:	39 c5                	cmp    %eax,%ebp
  1031ea:	75 f4                	jne    1031e0 <pcpu_mp_init+0x3b0>
    if (sum((uint8_t *) conf, conf->length) != 0)
  1031ec:	84 d2                	test   %dl,%dl
  1031ee:	0f 85 8c 00 00 00    	jne    103280 <pcpu_mp_init+0x450>
    lapic_register((uintptr_t) conf->lapicaddr);
  1031f4:	83 ec 0c             	sub    $0xc,%esp
  1031f7:	ff 76 24             	push   0x24(%esi)
    for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length; p < e;) {
  1031fa:	8d 6e 2c             	lea    0x2c(%esi),%ebp
    ismp = 1;
  1031fd:	c6 83 60 89 02 00 01 	movb   $0x1,0x28960(%ebx)
    ncpu = 0;
  103204:	c7 83 64 89 02 00 00 	movl   $0x0,0x28964(%ebx)
  10320b:	00 00 00 
    lapic_register((uintptr_t) conf->lapicaddr);
  10320e:	e8 5d f3 ff ff       	call   102570 <lapic_register>
    for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length; p < e;) {
  103213:	0f b7 56 04          	movzwl 0x4(%esi),%edx
  103217:	83 c4 10             	add    $0x10,%esp
  10321a:	01 d6                	add    %edx,%esi
  10321c:	39 f5                	cmp    %esi,%ebp
  10321e:	0f 83 88 fd ff ff    	jae    102fac <pcpu_mp_init+0x17c>
            KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
  103224:	8d 83 14 98 ff ff    	lea    -0x67ec(%ebx),%eax
            KERN_WARN("mpinit: unknown config type %x\n", *p);
  10322a:	89 7c 24 18          	mov    %edi,0x18(%esp)
  10322e:	89 ef                	mov    %ebp,%edi
            KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
  103230:	89 44 24 10          	mov    %eax,0x10(%esp)
            KERN_WARN("mpinit: unknown config type %x\n", *p);
  103234:	8d 83 90 98 ff ff    	lea    -0x6770(%ebx),%eax
    uint32_t ap_idx = 1;
  10323a:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  103241:	00 
            KERN_WARN("mpinit: unknown config type %x\n", *p);
  103242:	89 44 24 14          	mov    %eax,0x14(%esp)
  103246:	eb 13                	jmp    10325b <pcpu_mp_init+0x42b>
  103248:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10324f:	90                   	nop
            p += 8;
  103250:	83 c7 08             	add    $0x8,%edi
    for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length; p < e;) {
  103253:	39 fe                	cmp    %edi,%esi
  103255:	0f 86 4d fd ff ff    	jbe    102fa8 <pcpu_mp_init+0x178>
        switch (*p) {
  10325b:	0f b6 17             	movzbl (%edi),%edx
  10325e:	80 fa 02             	cmp    $0x2,%dl
  103261:	74 5d                	je     1032c0 <pcpu_mp_init+0x490>
  103263:	77 3b                	ja     1032a0 <pcpu_mp_init+0x470>
  103265:	84 d2                	test   %dl,%dl
  103267:	75 e7                	jne    103250 <pcpu_mp_init+0x420>
            p += sizeof(struct mpproc);
  103269:	8d 6f 14             	lea    0x14(%edi),%ebp
            if (!(proc->flags & MPENAB))
  10326c:	f6 47 03 01          	testb  $0x1,0x3(%edi)
  103270:	0f 85 9a 00 00 00    	jne    103310 <pcpu_mp_init+0x4e0>
            p += sizeof(struct mpproc);
  103276:	89 ef                	mov    %ebp,%edi
  103278:	eb d9                	jmp    103253 <pcpu_mp_init+0x423>
  10327a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        ismp = 0;
  103280:	c6 83 60 89 02 00 00 	movb   $0x0,0x28960(%ebx)
        return FALSE;
  103287:	31 c0                	xor    %eax,%eax
        ncpu = 1;
  103289:	c7 83 64 89 02 00 01 	movl   $0x1,0x28964(%ebx)
  103290:	00 00 00 
}
  103293:	83 c4 2c             	add    $0x2c,%esp
  103296:	5b                   	pop    %ebx
  103297:	5e                   	pop    %esi
  103298:	5f                   	pop    %edi
  103299:	5d                   	pop    %ebp
  10329a:	c3                   	ret    
  10329b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10329f:	90                   	nop
        switch (*p) {
  1032a0:	8d 4a fd             	lea    -0x3(%edx),%ecx
  1032a3:	80 f9 01             	cmp    $0x1,%cl
  1032a6:	76 a8                	jbe    103250 <pcpu_mp_init+0x420>
            KERN_WARN("mpinit: unknown config type %x\n", *p);
  1032a8:	52                   	push   %edx
  1032a9:	ff 74 24 18          	push   0x18(%esp)
  1032ad:	68 28 01 00 00       	push   $0x128
  1032b2:	ff 74 24 18          	push   0x18(%esp)
  1032b6:	e8 45 0e 00 00       	call   104100 <debug_warn>
  1032bb:	83 c4 10             	add    $0x10,%esp
  1032be:	eb 93                	jmp    103253 <pcpu_mp_init+0x423>
            KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
  1032c0:	83 ec 04             	sub    $0x4,%esp
  1032c3:	ff 77 04             	push   0x4(%edi)
  1032c6:	0f b6 57 01          	movzbl 0x1(%edi),%edx
            p += sizeof(struct mpioapic);
  1032ca:	8d 6f 08             	lea    0x8(%edi),%ebp
            KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
  1032cd:	52                   	push   %edx
  1032ce:	ff 74 24 1c          	push   0x1c(%esp)
  1032d2:	e8 e9 0c 00 00       	call   103fc0 <debug_info>
            ioapic_register((uintptr_t) mpio->addr, mpio->apicno, 0);
  1032d7:	83 c4 0c             	add    $0xc,%esp
  1032da:	6a 00                	push   $0x0
  1032dc:	0f b6 57 01          	movzbl 0x1(%edi),%edx
  1032e0:	52                   	push   %edx
  1032e1:	ff 77 04             	push   0x4(%edi)
            p += sizeof(struct mpioapic);
  1032e4:	89 ef                	mov    %ebp,%edi
            ioapic_register((uintptr_t) mpio->addr, mpio->apicno, 0);
  1032e6:	e8 75 f7 ff ff       	call   102a60 <ioapic_register>
            continue;
  1032eb:	83 c4 10             	add    $0x10,%esp
  1032ee:	e9 60 ff ff ff       	jmp    103253 <pcpu_mp_init+0x423>
  1032f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1032f7:	90                   	nop
        KERN_DEBUG("Not found MADT.\n");
  1032f8:	83 ec 04             	sub    $0x4,%esp
  1032fb:	8d 83 57 97 ff ff    	lea    -0x68a9(%ebx),%eax
  103301:	50                   	push   %eax
  103302:	68 5e 01 00 00       	push   $0x15e
  103307:	e9 03 fe ff ff       	jmp    10310f <pcpu_mp_init+0x2df>
  10330c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            KERN_INFO("\tCPU%d: APIC id = %x, ", ncpu, proc->apicid);
  103310:	0f b6 4f 01          	movzbl 0x1(%edi),%ecx
  103314:	83 ec 04             	sub    $0x4,%esp
  103317:	51                   	push   %ecx
  103318:	8d 8b 68 97 ff ff    	lea    -0x6898(%ebx),%ecx
  10331e:	ff b3 64 89 02 00    	push   0x28964(%ebx)
  103324:	51                   	push   %ecx
  103325:	e8 96 0c 00 00       	call   103fc0 <debug_info>
            if (proc->flags & MPBOOT) {
  10332a:	83 c4 10             	add    $0x10,%esp
  10332d:	f6 47 03 02          	testb  $0x2,0x3(%edi)
  103331:	0f 85 9e 00 00 00    	jne    1033d5 <pcpu_mp_init+0x5a5>
                KERN_INFO("AP.\n");
  103337:	83 ec 0c             	sub    $0xc,%esp
  10333a:	8d 8b 93 97 ff ff    	lea    -0x686d(%ebx),%ecx
  103340:	51                   	push   %ecx
  103341:	e8 7a 0c 00 00       	call   103fc0 <debug_info>
    if (idx >= NUM_CPUS)
  103346:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  10334a:	83 c4 10             	add    $0x10,%esp
  10334d:	83 f8 07             	cmp    $0x7,%eax
  103350:	77 1b                	ja     10336d <pcpu_mp_init+0x53d>
    struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);
  103352:	83 ec 0c             	sub    $0xc,%esp
                pcpu_mp_init_cpu(ap_idx, proc->apicid, FALSE);
  103355:	0f b6 7f 01          	movzbl 0x1(%edi),%edi
    struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);
  103359:	50                   	push   %eax
  10335a:	e8 21 28 00 00       	call   105b80 <get_pcpu_arch_info_pointer>
    info->lapicid = lapic_id;
  10335f:	89 f9                	mov    %edi,%ecx
    info->bsp = is_bsp;
  103361:	83 c4 10             	add    $0x10,%esp
    info->lapicid = lapic_id;
  103364:	0f b6 d1             	movzbl %cl,%edx
    info->bsp = is_bsp;
  103367:	c6 40 04 00          	movb   $0x0,0x4(%eax)
    info->lapicid = lapic_id;
  10336b:	89 10                	mov    %edx,(%eax)
                ap_idx++;
  10336d:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
            ncpu++;
  103372:	83 83 64 89 02 00 01 	addl   $0x1,0x28964(%ebx)
            p += sizeof(struct mpproc);
  103379:	89 ef                	mov    %ebp,%edi
            continue;
  10337b:	e9 d3 fe ff ff       	jmp    103253 <pcpu_mp_init+0x423>
            break;
  103380:	bf 00 00 0f 00       	mov    $0xf0000,%edi
  103385:	8d b3 2e 97 ff ff    	lea    -0x68d2(%ebx),%esi
  10338b:	eb 11                	jmp    10339e <pcpu_mp_init+0x56e>
  10338d:	8d 76 00             	lea    0x0(%esi),%esi
    for (p = addr; p < e; p += sizeof(struct mp))
  103390:	89 ef                	mov    %ebp,%edi
  103392:	81 fd 00 00 10 00    	cmp    $0x100000,%ebp
  103398:	0f 84 e2 fe ff ff    	je     103280 <pcpu_mp_init+0x450>
        if (memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  10339e:	83 ec 04             	sub    $0x4,%esp
  1033a1:	8d 6f 10             	lea    0x10(%edi),%ebp
  1033a4:	6a 04                	push   $0x4
  1033a6:	56                   	push   %esi
  1033a7:	57                   	push   %edi
  1033a8:	e8 b3 0b 00 00       	call   103f60 <memcmp>
  1033ad:	83 c4 10             	add    $0x10,%esp
  1033b0:	85 c0                	test   %eax,%eax
  1033b2:	75 dc                	jne    103390 <pcpu_mp_init+0x560>
  1033b4:	89 fa                	mov    %edi,%edx
  1033b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1033bd:	8d 76 00             	lea    0x0(%esi),%esi
        sum += addr[i];
  1033c0:	0f b6 0a             	movzbl (%edx),%ecx
    for (i = 0; i < len; i++)
  1033c3:	83 c2 01             	add    $0x1,%edx
        sum += addr[i];
  1033c6:	01 c8                	add    %ecx,%eax
    for (i = 0; i < len; i++)
  1033c8:	39 d5                	cmp    %edx,%ebp
  1033ca:	75 f4                	jne    1033c0 <pcpu_mp_init+0x590>
        if (memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  1033cc:	84 c0                	test   %al,%al
  1033ce:	75 c0                	jne    103390 <pcpu_mp_init+0x560>
  1033d0:	e9 bc fd ff ff       	jmp    103191 <pcpu_mp_init+0x361>
                KERN_INFO("BSP.\n");
  1033d5:	83 ec 0c             	sub    $0xc,%esp
  1033d8:	8d 8b 8d 97 ff ff    	lea    -0x6873(%ebx),%ecx
  1033de:	51                   	push   %ecx
  1033df:	e8 dc 0b 00 00       	call   103fc0 <debug_info>
                pcpu_mp_init_cpu(0, proc->apicid, TRUE);
  1033e4:	0f b6 7f 01          	movzbl 0x1(%edi),%edi
    struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);
  1033e8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1033ef:	e8 8c 27 00 00       	call   105b80 <get_pcpu_arch_info_pointer>
    info->bsp = is_bsp;
  1033f4:	83 c4 10             	add    $0x10,%esp
    info->lapicid = lapic_id;
  1033f7:	89 f9                	mov    %edi,%ecx
    info->bsp = is_bsp;
  1033f9:	c6 40 04 01          	movb   $0x1,0x4(%eax)
    info->lapicid = lapic_id;
  1033fd:	0f b6 d1             	movzbl %cl,%edx
  103400:	89 10                	mov    %edx,(%eax)
    info->bsp = is_bsp;
  103402:	e9 6b ff ff ff       	jmp    103372 <pcpu_mp_init+0x542>
        outb(0x22, 0x70);
  103407:	83 ec 08             	sub    $0x8,%esp
  10340a:	6a 70                	push   $0x70
  10340c:	6a 22                	push   $0x22
  10340e:	e8 1d 1a 00 00       	call   104e30 <outb>
        outb(0x23, inb(0x23) | 1);
  103413:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
  10341a:	e8 e1 19 00 00       	call   104e00 <inb>
  10341f:	5a                   	pop    %edx
  103420:	59                   	pop    %ecx
  103421:	83 c8 01             	or     $0x1,%eax
  103424:	0f b6 c0             	movzbl %al,%eax
  103427:	50                   	push   %eax
  103428:	6a 23                	push   $0x23
  10342a:	e8 01 1a 00 00       	call   104e30 <outb>
  10342f:	83 c4 10             	add    $0x10,%esp
  103432:	e9 7f fb ff ff       	jmp    102fb6 <pcpu_mp_init+0x186>
        KERN_DEBUG("Not found either RSDT or XSDT.\n");
  103437:	83 ec 04             	sub    $0x4,%esp
  10343a:	8d 83 f4 97 ff ff    	lea    -0x680c(%ebx),%eax
  103440:	50                   	push   %eax
  103441:	68 56 01 00 00       	push   $0x156
  103446:	e9 c4 fc ff ff       	jmp    10310f <pcpu_mp_init+0x2df>
  10344b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10344f:	90                   	nop

00103450 <pcpu_boot_ap>:

int pcpu_boot_ap(uint32_t cpu_idx, void (*f)(void), uintptr_t stack_addr)
{
  103450:	57                   	push   %edi
  103451:	56                   	push   %esi
  103452:	53                   	push   %ebx
  103453:	8b 74 24 10          	mov    0x10(%esp),%esi
  103457:	e8 2d cf ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10345c:	81 c3 a4 cb 00 00    	add    $0xcba4,%ebx
  103462:	8b 7c 24 14          	mov    0x14(%esp),%edi
    KERN_ASSERT(cpu_idx > 0 && cpu_idx < pcpu_ncpu());
  103466:	85 f6                	test   %esi,%esi
  103468:	74 6e                	je     1034d8 <pcpu_boot_ap+0x88>
  10346a:	3b b3 64 89 02 00    	cmp    0x28964(%ebx),%esi
  103470:	73 66                	jae    1034d8 <pcpu_boot_ap+0x88>
    KERN_ASSERT(get_pcpu_inited_info(cpu_idx) == TRUE);
  103472:	83 ec 0c             	sub    $0xc,%esp
  103475:	56                   	push   %esi
  103476:	e8 25 27 00 00       	call   105ba0 <get_pcpu_inited_info>
  10347b:	83 c4 10             	add    $0x10,%esp
  10347e:	3c 01                	cmp    $0x1,%al
  103480:	74 22                	je     1034a4 <pcpu_boot_ap+0x54>
  103482:	8d 83 d8 98 ff ff    	lea    -0x6728(%ebx),%eax
  103488:	50                   	push   %eax
  103489:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  10348f:	50                   	push   %eax
  103490:	8d 83 44 97 ff ff    	lea    -0x68bc(%ebx),%eax
  103496:	68 b8 01 00 00       	push   $0x1b8
  10349b:	50                   	push   %eax
  10349c:	e8 8f 0b 00 00       	call   104030 <debug_panic>
  1034a1:	83 c4 10             	add    $0x10,%esp
    KERN_ASSERT(f != NULL);
  1034a4:	85 ff                	test   %edi,%edi
  1034a6:	0f 84 54 01 00 00    	je     103600 <pcpu_boot_ap+0x1b0>
    return ismp;
}

bool pcpu_onboot(void)
{
    int cpu_idx = get_pcpu_idx();
  1034ac:	e8 8f 25 00 00       	call   105a40 <get_pcpu_idx>
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  1034b1:	83 ec 0c             	sub    $0xc,%esp
  1034b4:	50                   	push   %eax
  1034b5:	e8 c6 26 00 00       	call   105b80 <get_pcpu_arch_info_pointer>
    return (mp_inited == TRUE) ? arch_info->bsp : (get_pcpu_idx() == 0);
  1034ba:	83 c4 10             	add    $0x10,%esp
  1034bd:	80 bb 61 89 02 00 01 	cmpb   $0x1,0x28961(%ebx)
  1034c4:	75 3a                	jne    103500 <pcpu_boot_ap+0xb0>
    if (pcpu_onboot() == FALSE)
  1034c6:	80 78 04 00          	cmpb   $0x0,0x4(%eax)
  1034ca:	75 3d                	jne    103509 <pcpu_boot_ap+0xb9>
}
  1034cc:	5b                   	pop    %ebx
        return 1;
  1034cd:	b8 01 00 00 00       	mov    $0x1,%eax
}
  1034d2:	5e                   	pop    %esi
  1034d3:	5f                   	pop    %edi
  1034d4:	c3                   	ret    
  1034d5:	8d 76 00             	lea    0x0(%esi),%esi
    KERN_ASSERT(cpu_idx > 0 && cpu_idx < pcpu_ncpu());
  1034d8:	8d 83 b0 98 ff ff    	lea    -0x6750(%ebx),%eax
  1034de:	50                   	push   %eax
  1034df:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  1034e5:	50                   	push   %eax
  1034e6:	8d 83 44 97 ff ff    	lea    -0x68bc(%ebx),%eax
  1034ec:	68 b7 01 00 00       	push   $0x1b7
  1034f1:	50                   	push   %eax
  1034f2:	e8 39 0b 00 00       	call   104030 <debug_panic>
  1034f7:	83 c4 10             	add    $0x10,%esp
  1034fa:	e9 73 ff ff ff       	jmp    103472 <pcpu_boot_ap+0x22>
  1034ff:	90                   	nop
    return (mp_inited == TRUE) ? arch_info->bsp : (get_pcpu_idx() == 0);
  103500:	e8 3b 25 00 00       	call   105a40 <get_pcpu_idx>
    if (pcpu_onboot() == FALSE)
  103505:	85 c0                	test   %eax,%eax
  103507:	75 c3                	jne    1034cc <pcpu_boot_ap+0x7c>
    if (get_pcpu_boot_info(cpu_idx) == TRUE)
  103509:	83 ec 0c             	sub    $0xc,%esp
  10350c:	56                   	push   %esi
  10350d:	e8 de 25 00 00       	call   105af0 <get_pcpu_boot_info>
  103512:	83 c4 10             	add    $0x10,%esp
  103515:	3c 01                	cmp    $0x1,%al
  103517:	74 7c                	je     103595 <pcpu_boot_ap+0x145>
    *(uintptr_t *) (boot - 4) = stack_addr + PAGE_SIZE;
  103519:	8b 44 24 18          	mov    0x18(%esp),%eax
}

lapicid_t pcpu_cpu_lapicid(int cpu_idx)
{
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  10351d:	83 ec 0c             	sub    $0xc,%esp
    *(uintptr_t *) (boot - 8) = (uintptr_t) f;
  103520:	89 3d f8 7f 00 00    	mov    %edi,0x7ff8
    *(uintptr_t *) (boot - 4) = stack_addr + PAGE_SIZE;
  103526:	05 00 10 00 00       	add    $0x1000,%eax
  10352b:	a3 fc 7f 00 00       	mov    %eax,0x7ffc
    *(uintptr_t *) (boot - 12) = (uintptr_t) kern_init_ap;
  103530:	c7 c0 c0 5e 10 00    	mov    $0x105ec0,%eax
  103536:	a3 f4 7f 00 00       	mov    %eax,0x7ff4
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  10353b:	56                   	push   %esi
  10353c:	e8 3f 26 00 00       	call   105b80 <get_pcpu_arch_info_pointer>
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < ncpu);
  103541:	83 c4 10             	add    $0x10,%esp
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103544:	89 c7                	mov    %eax,%edi
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < ncpu);
  103546:	85 f6                	test   %esi,%esi
  103548:	0f 88 82 00 00 00    	js     1035d0 <pcpu_boot_ap+0x180>
  10354e:	3b b3 64 89 02 00    	cmp    0x28964(%ebx),%esi
  103554:	73 7a                	jae    1035d0 <pcpu_boot_ap+0x180>
    lapic_startcpu(pcpu_cpu_lapicid(cpu_idx), (uintptr_t) boot);
  103556:	83 ec 08             	sub    $0x8,%esp
  103559:	68 00 80 00 00       	push   $0x8000
  10355e:	0f b6 07             	movzbl (%edi),%eax
  103561:	50                   	push   %eax
  103562:	e8 49 f3 ff ff       	call   1028b0 <lapic_startcpu>
    while (get_pcpu_boot_info(cpu_idx) == FALSE)
  103567:	83 c4 10             	add    $0x10,%esp
  10356a:	eb 09                	jmp    103575 <pcpu_boot_ap+0x125>
  10356c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        pause();
  103570:	e8 eb 16 00 00       	call   104c60 <pause>
    while (get_pcpu_boot_info(cpu_idx) == FALSE)
  103575:	83 ec 0c             	sub    $0xc,%esp
  103578:	56                   	push   %esi
  103579:	e8 72 25 00 00       	call   105af0 <get_pcpu_boot_info>
  10357e:	83 c4 10             	add    $0x10,%esp
  103581:	84 c0                	test   %al,%al
  103583:	74 eb                	je     103570 <pcpu_boot_ap+0x120>
    KERN_ASSERT(get_pcpu_boot_info(cpu_idx) == TRUE);
  103585:	83 ec 0c             	sub    $0xc,%esp
  103588:	56                   	push   %esi
  103589:	e8 62 25 00 00       	call   105af0 <get_pcpu_boot_info>
  10358e:	83 c4 10             	add    $0x10,%esp
  103591:	3c 01                	cmp    $0x1,%al
  103593:	75 0b                	jne    1035a0 <pcpu_boot_ap+0x150>
    return 0;
  103595:	31 c0                	xor    %eax,%eax
}
  103597:	5b                   	pop    %ebx
  103598:	5e                   	pop    %esi
  103599:	5f                   	pop    %edi
  10359a:	c3                   	ret    
  10359b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10359f:	90                   	nop
    KERN_ASSERT(get_pcpu_boot_info(cpu_idx) == TRUE);
  1035a0:	8d 83 20 99 ff ff    	lea    -0x66e0(%ebx),%eax
  1035a6:	50                   	push   %eax
  1035a7:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  1035ad:	50                   	push   %eax
  1035ae:	8d 83 44 97 ff ff    	lea    -0x68bc(%ebx),%eax
  1035b4:	68 cd 01 00 00       	push   $0x1cd
  1035b9:	50                   	push   %eax
  1035ba:	e8 71 0a 00 00       	call   104030 <debug_panic>
  1035bf:	83 c4 10             	add    $0x10,%esp
    return 0;
  1035c2:	31 c0                	xor    %eax,%eax
  1035c4:	eb d1                	jmp    103597 <pcpu_boot_ap+0x147>
  1035c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1035cd:	8d 76 00             	lea    0x0(%esi),%esi
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < ncpu);
  1035d0:	8d 83 00 99 ff ff    	lea    -0x6700(%ebx),%eax
  1035d6:	50                   	push   %eax
  1035d7:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  1035dd:	50                   	push   %eax
  1035de:	8d 83 44 97 ff ff    	lea    -0x68bc(%ebx),%eax
  1035e4:	68 ea 01 00 00       	push   $0x1ea
  1035e9:	50                   	push   %eax
  1035ea:	e8 41 0a 00 00       	call   104030 <debug_panic>
  1035ef:	83 c4 10             	add    $0x10,%esp
  1035f2:	e9 5f ff ff ff       	jmp    103556 <pcpu_boot_ap+0x106>
  1035f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1035fe:	66 90                	xchg   %ax,%ax
    KERN_ASSERT(f != NULL);
  103600:	8d 83 98 97 ff ff    	lea    -0x6868(%ebx),%eax
  103606:	50                   	push   %eax
  103607:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  10360d:	50                   	push   %eax
  10360e:	8d 83 44 97 ff ff    	lea    -0x68bc(%ebx),%eax
  103614:	68 b9 01 00 00       	push   $0x1b9
  103619:	50                   	push   %eax
  10361a:	e8 11 0a 00 00       	call   104030 <debug_panic>
  10361f:	83 c4 10             	add    $0x10,%esp
  103622:	e9 85 fe ff ff       	jmp    1034ac <pcpu_boot_ap+0x5c>
  103627:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10362e:	66 90                	xchg   %ax,%ax

00103630 <pcpu_init_cpu>:
{
  103630:	55                   	push   %ebp
  103631:	57                   	push   %edi
  103632:	56                   	push   %esi
  103633:	53                   	push   %ebx
  103634:	e8 50 cd ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  103639:	81 c3 c7 c9 00 00    	add    $0xc9c7,%ebx
  10363f:	83 ec 4c             	sub    $0x4c,%esp
    int cpu_idx = get_pcpu_idx();
  103642:	e8 f9 23 00 00       	call   105a40 <get_pcpu_idx>
    struct pcpuinfo *cpuinfo = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103647:	83 ec 0c             	sub    $0xc,%esp
  10364a:	50                   	push   %eax
  10364b:	e8 30 25 00 00       	call   105b80 <get_pcpu_arch_info_pointer>
    uint32_t *regs[4] = { &eax, &ebx, &ecx, &edx };
  103650:	8d 6c 24 34          	lea    0x34(%esp),%ebp
  103654:	8d 4c 24 3c          	lea    0x3c(%esp),%ecx
    struct pcpuinfo *cpuinfo = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103658:	89 c6                	mov    %eax,%esi
    uint32_t *regs[4] = { &eax, &ebx, &ecx, &edx };
  10365a:	8d 44 24 38          	lea    0x38(%esp),%eax
  10365e:	89 4c 24 18          	mov    %ecx,0x18(%esp)
  103662:	89 44 24 14          	mov    %eax,0x14(%esp)
  103666:	89 44 24 48          	mov    %eax,0x48(%esp)
  10366a:	89 4c 24 4c          	mov    %ecx,0x4c(%esp)
    cpuid(0x0, &eax, &ebx, &ecx, &edx);
  10366e:	89 0c 24             	mov    %ecx,(%esp)
    uint32_t *regs[4] = { &eax, &ebx, &ecx, &edx };
  103671:	89 6c 24 44          	mov    %ebp,0x44(%esp)
    cpuid(0x0, &eax, &ebx, &ecx, &edx);
  103675:	50                   	push   %eax
  103676:	55                   	push   %ebp
  103677:	8d 44 24 38          	lea    0x38(%esp),%eax
  10367b:	89 44 24 18          	mov    %eax,0x18(%esp)
  10367f:	50                   	push   %eax
  103680:	6a 00                	push   $0x0
  103682:	e8 49 16 00 00       	call   104cd0 <cpuid>
    cpuinfo->cpuid_high = eax;
  103687:	8b 44 24 40          	mov    0x40(%esp),%eax
    cpuinfo->vendor[12] = '\0';
  10368b:	c6 46 18 00          	movb   $0x0,0x18(%esi)
    cpuinfo->cpuid_high = eax;
  10368f:	89 46 08             	mov    %eax,0x8(%esi)
    ((uint32_t *) cpuinfo->vendor)[0] = ebx;
  103692:	8b 44 24 44          	mov    0x44(%esp),%eax
  103696:	89 46 0c             	mov    %eax,0xc(%esi)
    ((uint32_t *) cpuinfo->vendor)[1] = edx;
  103699:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  10369d:	89 46 10             	mov    %eax,0x10(%esi)
    ((uint32_t *) cpuinfo->vendor)[2] = ecx;
  1036a0:	8b 44 24 48          	mov    0x48(%esp),%eax
  1036a4:	89 46 14             	mov    %eax,0x14(%esi)
    if (strncmp(cpuinfo->vendor, "GenuineIntel", 20) == 0)
  1036a7:	8d 46 0c             	lea    0xc(%esi),%eax
  1036aa:	89 44 24 30          	mov    %eax,0x30(%esp)
  1036ae:	89 c7                	mov    %eax,%edi
  1036b0:	83 c4 1c             	add    $0x1c,%esp
  1036b3:	8d 83 d7 97 ff ff    	lea    -0x6829(%ebx),%eax
  1036b9:	6a 14                	push   $0x14
  1036bb:	50                   	push   %eax
  1036bc:	57                   	push   %edi
  1036bd:	e8 5e 07 00 00       	call   103e20 <strncmp>
  1036c2:	83 c4 10             	add    $0x10,%esp
  1036c5:	89 c2                	mov    %eax,%edx
  1036c7:	b8 01 00 00 00       	mov    $0x1,%eax
  1036cc:	85 d2                	test   %edx,%edx
  1036ce:	0f 85 dc 02 00 00    	jne    1039b0 <pcpu_init_cpu+0x380>
    cpuid(0x1, &eax, &ebx, &ecx, &edx);
  1036d4:	83 ec 0c             	sub    $0xc,%esp
        cpuinfo->cpu_vendor = INTEL;
  1036d7:	89 46 20             	mov    %eax,0x20(%esi)
    cpuid(0x1, &eax, &ebx, &ecx, &edx);
  1036da:	ff 74 24 14          	push   0x14(%esp)
  1036de:	ff 74 24 14          	push   0x14(%esp)
  1036e2:	55                   	push   %ebp
  1036e3:	ff 74 24 18          	push   0x18(%esp)
  1036e7:	6a 01                	push   $0x1
  1036e9:	e8 e2 15 00 00       	call   104cd0 <cpuid>
    cpuinfo->family = (eax >> 8) & 0xf;
  1036ee:	8b 44 24 40          	mov    0x40(%esp),%eax
  1036f2:	89 c2                	mov    %eax,%edx
  1036f4:	c1 ea 08             	shr    $0x8,%edx
  1036f7:	83 e2 0f             	and    $0xf,%edx
  1036fa:	88 56 24             	mov    %dl,0x24(%esi)
    cpuinfo->model = (eax >> 4) & 0xf;
  1036fd:	89 c2                	mov    %eax,%edx
  1036ff:	c0 ea 04             	shr    $0x4,%dl
  103702:	88 56 25             	mov    %dl,0x25(%esi)
    cpuinfo->step = eax & 0xf;
  103705:	89 c2                	mov    %eax,%edx
  103707:	83 e2 0f             	and    $0xf,%edx
  10370a:	88 56 26             	mov    %dl,0x26(%esi)
    cpuinfo->ext_family = (eax >> 20) & 0xff;
  10370d:	89 c2                	mov    %eax,%edx
    cpuinfo->ext_model = (eax >> 16) & 0xff;
  10370f:	c1 e8 10             	shr    $0x10,%eax
  103712:	88 46 28             	mov    %al,0x28(%esi)
    cpuinfo->brand_idx = ebx & 0xff;
  103715:	8b 44 24 44          	mov    0x44(%esp),%eax
    cpuinfo->ext_family = (eax >> 20) & 0xff;
  103719:	c1 ea 14             	shr    $0x14,%edx
  10371c:	88 56 27             	mov    %dl,0x27(%esi)
    cpuinfo->brand_idx = ebx & 0xff;
  10371f:	89 46 29             	mov    %eax,0x29(%esi)
    cpuinfo->feature1 = ecx;
  103722:	8b 44 24 48          	mov    0x48(%esp),%eax
  103726:	89 46 30             	mov    %eax,0x30(%esi)
    cpuinfo->feature2 = edx;
  103729:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    switch (cpuinfo->cpu_vendor) {
  10372d:	83 c4 20             	add    $0x20,%esp
    cpuinfo->feature2 = edx;
  103730:	89 46 34             	mov    %eax,0x34(%esi)
    switch (cpuinfo->cpu_vendor) {
  103733:	8b 46 20             	mov    0x20(%esi),%eax
  103736:	83 f8 01             	cmp    $0x1,%eax
  103739:	0f 84 31 01 00 00    	je     103870 <pcpu_init_cpu+0x240>
  10373f:	83 f8 02             	cmp    $0x2,%eax
  103742:	0f 84 d0 01 00 00    	je     103918 <pcpu_init_cpu+0x2e8>
        cpuinfo->l1_cache_size = 0;
  103748:	c7 46 38 00 00 00 00 	movl   $0x0,0x38(%esi)
        cpuinfo->l1_cache_line_size = 0;
  10374f:	c7 46 3c 00 00 00 00 	movl   $0x0,0x3c(%esi)
    cpuid(0x80000000, &eax, &ebx, &ecx, &edx);
  103756:	83 ec 0c             	sub    $0xc,%esp
  103759:	ff 74 24 14          	push   0x14(%esp)
  10375d:	ff 74 24 14          	push   0x14(%esp)
  103761:	55                   	push   %ebp
  103762:	ff 74 24 18          	push   0x18(%esp)
  103766:	68 00 00 00 80       	push   $0x80000000
  10376b:	e8 60 15 00 00       	call   104cd0 <cpuid>
    cpuinfo->cpuid_exthigh = eax;
  103770:	8b 44 24 40          	mov    0x40(%esp),%eax
    pcpu_print_cpuinfo(get_pcpu_idx(), cpuinfo);
  103774:	83 c4 20             	add    $0x20,%esp
    cpuinfo->cpuid_exthigh = eax;
  103777:	89 46 40             	mov    %eax,0x40(%esi)
    pcpu_print_cpuinfo(get_pcpu_idx(), cpuinfo);
  10377a:	e8 c1 22 00 00       	call   105a40 <get_pcpu_idx>
    KERN_INFO("CPU%d: %s, FAMILY %d(%d), MODEL %d(%d), STEP %d, "
  10377f:	8b 56 30             	mov    0x30(%esi),%edx
  103782:	8d 8b a2 97 ff ff    	lea    -0x685e(%ebx),%ecx
  103788:	8b 7e 38             	mov    0x38(%esi),%edi
    pcpu_print_cpuinfo(get_pcpu_idx(), cpuinfo);
  10378b:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    KERN_INFO("CPU%d: %s, FAMILY %d(%d), MODEL %d(%d), STEP %d, "
  10378f:	8d 83 24 a6 ff ff    	lea    -0x59dc(%ebx),%eax
  103795:	f7 c2 00 00 80 00    	test   $0x800000,%edx
  10379b:	89 3c 24             	mov    %edi,(%esp)
  10379e:	0f 44 c8             	cmove  %eax,%ecx
  1037a1:	f7 c2 00 00 10 00    	test   $0x100000,%edx
  1037a7:	89 4c 24 18          	mov    %ecx,0x18(%esp)
  1037ab:	8d 8b ab 97 ff ff    	lea    -0x6855(%ebx),%ecx
  1037b1:	89 cf                	mov    %ecx,%edi
  1037b3:	8d 8b b3 97 ff ff    	lea    -0x684d(%ebx),%ecx
  1037b9:	0f 44 f8             	cmove  %eax,%edi
  1037bc:	f7 c2 00 00 08 00    	test   $0x80000,%edx
  1037c2:	0f 44 c8             	cmove  %eax,%ecx
  1037c5:	f6 c6 02             	test   $0x2,%dh
  1037c8:	89 7c 24 14          	mov    %edi,0x14(%esp)
  1037cc:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1037d0:	8d 8b bb 97 ff ff    	lea    -0x6845(%ebx),%ecx
  1037d6:	89 cd                	mov    %ecx,%ebp
  1037d8:	8d 8b c3 97 ff ff    	lea    -0x683d(%ebx),%ecx
  1037de:	0f 44 e8             	cmove  %eax,%ebp
  1037e1:	89 cf                	mov    %ecx,%edi
  1037e3:	f6 c2 01             	test   $0x1,%dl
  1037e6:	8b 4e 34             	mov    0x34(%esi),%ecx
  1037e9:	0f 44 f8             	cmove  %eax,%edi
  1037ec:	89 6c 24 08          	mov    %ebp,0x8(%esp)
  1037f0:	f7 c1 00 00 00 04    	test   $0x4000000,%ecx
  1037f6:	8d ab ca 97 ff ff    	lea    -0x6836(%ebx),%ebp
  1037fc:	0f 44 e8             	cmove  %eax,%ebp
  1037ff:	89 7c 24 04          	mov    %edi,0x4(%esp)
  103803:	f7 c1 00 00 00 02    	test   $0x2000000,%ecx
  103809:	8d bb d1 97 ff ff    	lea    -0x682f(%ebx),%edi
  10380f:	0f 44 f8             	cmove  %eax,%edi
  103812:	83 ec 04             	sub    $0x4,%esp
  103815:	ff 76 3c             	push   0x3c(%esi)
  103818:	ff 74 24 08          	push   0x8(%esp)
  10381c:	ff 74 24 24          	push   0x24(%esp)
  103820:	ff 74 24 24          	push   0x24(%esp)
  103824:	ff 74 24 20          	push   0x20(%esp)
  103828:	ff 74 24 20          	push   0x20(%esp)
  10382c:	ff 74 24 20          	push   0x20(%esp)
  103830:	55                   	push   %ebp
  103831:	57                   	push   %edi
  103832:	51                   	push   %ecx
  103833:	52                   	push   %edx
  103834:	0f b6 46 26          	movzbl 0x26(%esi),%eax
  103838:	50                   	push   %eax
  103839:	0f b6 46 28          	movzbl 0x28(%esi),%eax
  10383d:	50                   	push   %eax
  10383e:	0f b6 46 25          	movzbl 0x25(%esi),%eax
  103842:	50                   	push   %eax
  103843:	0f b6 46 27          	movzbl 0x27(%esi),%eax
  103847:	50                   	push   %eax
  103848:	0f b6 46 24          	movzbl 0x24(%esi),%eax
  10384c:	50                   	push   %eax
  10384d:	8d 83 44 99 ff ff    	lea    -0x66bc(%ebx),%eax
  103853:	ff 74 24 54          	push   0x54(%esp)
  103857:	ff 74 24 64          	push   0x64(%esp)
  10385b:	50                   	push   %eax
  10385c:	e8 5f 07 00 00       	call   103fc0 <debug_info>
}
  103861:	81 c4 9c 00 00 00    	add    $0x9c,%esp
  103867:	5b                   	pop    %ebx
  103868:	5e                   	pop    %esi
  103869:	5f                   	pop    %edi
  10386a:	5d                   	pop    %ebp
  10386b:	c3                   	ret    
  10386c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cpuid(0x00000002, &eax, &ebx, &ecx, &edx);
  103870:	83 ec 0c             	sub    $0xc,%esp
  103873:	ff 74 24 14          	push   0x14(%esp)
  103877:	ff 74 24 14          	push   0x14(%esp)
  10387b:	55                   	push   %ebp
  10387c:	ff 74 24 18          	push   0x18(%esp)
  103880:	6a 02                	push   $0x2
  103882:	e8 49 14 00 00       	call   104cd0 <cpuid>
        i = eax & 0x000000ff;
  103887:	0f b6 44 24 40       	movzbl 0x40(%esp),%eax
        while (i--)
  10388c:	83 c4 20             	add    $0x20,%esp
  10388f:	8d 78 ff             	lea    -0x1(%eax),%edi
  103892:	85 c0                	test   %eax,%eax
  103894:	74 2d                	je     1038c3 <pcpu_init_cpu+0x293>
  103896:	89 74 24 0c          	mov    %esi,0xc(%esp)
  10389a:	89 fe                	mov    %edi,%esi
  10389c:	8b 7c 24 08          	mov    0x8(%esp),%edi
            cpuid(0x00000002, &eax, &ebx, &ecx, &edx);
  1038a0:	83 ec 0c             	sub    $0xc,%esp
        while (i--)
  1038a3:	83 ee 01             	sub    $0x1,%esi
            cpuid(0x00000002, &eax, &ebx, &ecx, &edx);
  1038a6:	57                   	push   %edi
  1038a7:	ff 74 24 14          	push   0x14(%esp)
  1038ab:	55                   	push   %ebp
  1038ac:	ff 74 24 18          	push   0x18(%esp)
  1038b0:	6a 02                	push   $0x2
  1038b2:	e8 19 14 00 00       	call   104cd0 <cpuid>
        while (i--)
  1038b7:	83 c4 20             	add    $0x20,%esp
  1038ba:	83 fe ff             	cmp    $0xffffffff,%esi
  1038bd:	75 e1                	jne    1038a0 <pcpu_init_cpu+0x270>
  1038bf:	8b 74 24 0c          	mov    0xc(%esp),%esi
  1038c3:	8d 44 24 30          	lea    0x30(%esp),%eax
  1038c7:	89 6c 24 18          	mov    %ebp,0x18(%esp)
  1038cb:	8d 8b e0 99 ff ff    	lea    -0x6620(%ebx),%ecx
  1038d1:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1038d5:	8d 44 24 40          	lea    0x40(%esp),%eax
  1038d9:	89 44 24 14          	mov    %eax,0x14(%esp)
  1038dd:	8d 44 24 20          	lea    0x20(%esp),%eax
            for (j = 0; j < 4; j++) {
  1038e1:	8d 68 04             	lea    0x4(%eax),%ebp
                cpuinfo->l1_cache_size = intel_cache_info[desc[j]][0];
  1038e4:	0f b6 10             	movzbl (%eax),%edx
            for (j = 0; j < 4; j++) {
  1038e7:	83 c0 01             	add    $0x1,%eax
                cpuinfo->l1_cache_size = intel_cache_info[desc[j]][0];
  1038ea:	8b 14 d1             	mov    (%ecx,%edx,8),%edx
  1038ed:	89 56 38             	mov    %edx,0x38(%esi)
                cpuinfo->l1_cache_line_size = intel_cache_info[desc[j]][1];
  1038f0:	0f b6 78 ff          	movzbl -0x1(%eax),%edi
  1038f4:	8b 7c f9 04          	mov    0x4(%ecx,%edi,8),%edi
  1038f8:	89 7e 3c             	mov    %edi,0x3c(%esi)
            for (j = 0; j < 4; j++) {
  1038fb:	39 c5                	cmp    %eax,%ebp
  1038fd:	75 e5                	jne    1038e4 <pcpu_init_cpu+0x2b4>
        for (i = 0; i < 4; i++) {
  1038ff:	83 44 24 0c 04       	addl   $0x4,0xc(%esp)
  103904:	8b 44 24 0c          	mov    0xc(%esp),%eax
  103908:	39 44 24 14          	cmp    %eax,0x14(%esp)
  10390c:	74 42                	je     103950 <pcpu_init_cpu+0x320>
            desc = (uint8_t *) regs[i];
  10390e:	8b 00                	mov    (%eax),%eax
  103910:	eb cf                	jmp    1038e1 <pcpu_init_cpu+0x2b1>
  103912:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cpuid(0x80000005, &eax, &ebx, &ecx, &edx);
  103918:	83 ec 0c             	sub    $0xc,%esp
  10391b:	ff 74 24 14          	push   0x14(%esp)
  10391f:	ff 74 24 14          	push   0x14(%esp)
  103923:	55                   	push   %ebp
  103924:	ff 74 24 18          	push   0x18(%esp)
  103928:	68 05 00 00 80       	push   $0x80000005
  10392d:	e8 9e 13 00 00       	call   104cd0 <cpuid>
        cpuinfo->l1_cache_size = (ecx & 0xff000000) >> 24;
  103932:	8b 44 24 48          	mov    0x48(%esp),%eax
        break;
  103936:	83 c4 20             	add    $0x20,%esp
        cpuinfo->l1_cache_size = (ecx & 0xff000000) >> 24;
  103939:	89 c2                	mov    %eax,%edx
        cpuinfo->l1_cache_line_size = (ecx & 0x000000ff);
  10393b:	25 ff 00 00 00       	and    $0xff,%eax
        cpuinfo->l1_cache_size = (ecx & 0xff000000) >> 24;
  103940:	c1 ea 18             	shr    $0x18,%edx
        cpuinfo->l1_cache_line_size = (ecx & 0x000000ff);
  103943:	89 46 3c             	mov    %eax,0x3c(%esi)
        cpuinfo->l1_cache_size = (ecx & 0xff000000) >> 24;
  103946:	89 56 38             	mov    %edx,0x38(%esi)
        break;
  103949:	e9 08 fe ff ff       	jmp    103756 <pcpu_init_cpu+0x126>
  10394e:	66 90                	xchg   %ax,%ax
        if (cpuinfo->l1_cache_size && cpuinfo->l1_cache_line_size)
  103950:	8b 6c 24 18          	mov    0x18(%esp),%ebp
  103954:	85 d2                	test   %edx,%edx
  103956:	0f 85 84 00 00 00    	jne    1039e0 <pcpu_init_cpu+0x3b0>
  10395c:	31 ff                	xor    %edi,%edi
            cpuid_subleaf(0x00000004, i, &eax, &ebx, &ecx, &edx);
  10395e:	83 ec 08             	sub    $0x8,%esp
  103961:	ff 74 24 10          	push   0x10(%esp)
  103965:	ff 74 24 10          	push   0x10(%esp)
  103969:	55                   	push   %ebp
  10396a:	ff 74 24 14          	push   0x14(%esp)
  10396e:	57                   	push   %edi
  10396f:	6a 04                	push   $0x4
  103971:	e8 9a 13 00 00       	call   104d10 <cpuid_subleaf>
            if ((eax & 0xf) == 1 && ((eax & 0xe0) >> 5) == 1)
  103976:	8b 54 24 40          	mov    0x40(%esp),%edx
  10397a:	83 c4 20             	add    $0x20,%esp
  10397d:	89 d1                	mov    %edx,%ecx
  10397f:	83 e1 0f             	and    $0xf,%ecx
  103982:	83 f9 01             	cmp    $0x1,%ecx
  103985:	74 69                	je     1039f0 <pcpu_init_cpu+0x3c0>
        for (i = 0; i < 3; i++) {
  103987:	83 c7 01             	add    $0x1,%edi
  10398a:	83 ff 03             	cmp    $0x3,%edi
  10398d:	75 cf                	jne    10395e <pcpu_init_cpu+0x32e>
            KERN_WARN("Cannot determine L1 cache size.\n");
  10398f:	83 ec 04             	sub    $0x4,%esp
  103992:	8d 83 b4 99 ff ff    	lea    -0x664c(%ebx),%eax
  103998:	50                   	push   %eax
  103999:	8d 83 44 97 ff ff    	lea    -0x68bc(%ebx),%eax
  10399f:	6a 7c                	push   $0x7c
  1039a1:	50                   	push   %eax
  1039a2:	e8 59 07 00 00       	call   104100 <debug_warn>
            break;
  1039a7:	83 c4 10             	add    $0x10,%esp
  1039aa:	e9 a7 fd ff ff       	jmp    103756 <pcpu_init_cpu+0x126>
  1039af:	90                   	nop
    else if (strncmp(cpuinfo->vendor, "AuthenticAMD", 20) == 0)
  1039b0:	83 ec 04             	sub    $0x4,%esp
  1039b3:	8d 83 e4 97 ff ff    	lea    -0x681c(%ebx),%eax
  1039b9:	6a 14                	push   $0x14
  1039bb:	50                   	push   %eax
  1039bc:	ff 74 24 1c          	push   0x1c(%esp)
  1039c0:	e8 5b 04 00 00       	call   103e20 <strncmp>
  1039c5:	83 c4 10             	add    $0x10,%esp
  1039c8:	85 c0                	test   %eax,%eax
  1039ca:	0f 94 c0             	sete   %al
  1039cd:	0f b6 c0             	movzbl %al,%eax
  1039d0:	01 c0                	add    %eax,%eax
  1039d2:	e9 fd fc ff ff       	jmp    1036d4 <pcpu_init_cpu+0xa4>
  1039d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1039de:	66 90                	xchg   %ax,%ax
        if (cpuinfo->l1_cache_size && cpuinfo->l1_cache_line_size)
  1039e0:	85 ff                	test   %edi,%edi
  1039e2:	0f 85 6e fd ff ff    	jne    103756 <pcpu_init_cpu+0x126>
  1039e8:	e9 71 ff ff ff       	jmp    10395e <pcpu_init_cpu+0x32e>
  1039ed:	8d 76 00             	lea    0x0(%esi),%esi
            if ((eax & 0xf) == 1 && ((eax & 0xe0) >> 5) == 1)
  1039f0:	c1 ea 05             	shr    $0x5,%edx
  1039f3:	83 e2 07             	and    $0x7,%edx
  1039f6:	83 fa 01             	cmp    $0x1,%edx
  1039f9:	75 8c                	jne    103987 <pcpu_init_cpu+0x357>
            (((ebx & 0xffc00000) >> 22) + 1) *  /* ways */
  1039fb:	8b 7c 24 24          	mov    0x24(%esp),%edi
            (ecx + 1) /                         /* sets */
  1039ff:	8b 54 24 28          	mov    0x28(%esp),%edx
            (((ebx & 0x00000fff)) + 1) *        /* line size */
  103a03:	89 f8                	mov    %edi,%eax
            (ecx + 1) /                         /* sets */
  103a05:	83 c2 01             	add    $0x1,%edx
            (((ebx & 0x00000fff)) + 1) *        /* line size */
  103a08:	25 ff 0f 00 00       	and    $0xfff,%eax
  103a0d:	8d 48 01             	lea    0x1(%eax),%ecx
            (((ebx & 0xffc00000) >> 22) + 1) *  /* ways */
  103a10:	89 f8                	mov    %edi,%eax
            (((ebx & 0x003ff000) >> 12) + 1) *  /* partitions */
  103a12:	c1 ef 0c             	shr    $0xc,%edi
            (((ebx & 0xffc00000) >> 22) + 1) *  /* ways */
  103a15:	c1 e8 16             	shr    $0x16,%eax
        cpuinfo->l1_cache_line_size = ((ebx & 0x00000fff)) + 1;
  103a18:	89 4e 3c             	mov    %ecx,0x3c(%esi)
            (((ebx & 0xffc00000) >> 22) + 1) *  /* ways */
  103a1b:	83 c0 01             	add    $0x1,%eax
            (((ebx & 0x00000fff)) + 1) *        /* line size */
  103a1e:	0f af c1             	imul   %ecx,%eax
  103a21:	0f af c2             	imul   %edx,%eax
            (((ebx & 0x003ff000) >> 12) + 1) *  /* partitions */
  103a24:	89 fa                	mov    %edi,%edx
  103a26:	81 e2 ff 03 00 00    	and    $0x3ff,%edx
  103a2c:	83 c2 01             	add    $0x1,%edx
            (((ebx & 0x00000fff)) + 1) *        /* line size */
  103a2f:	0f af c2             	imul   %edx,%eax
            (ecx + 1) /                         /* sets */
  103a32:	c1 e8 0a             	shr    $0xa,%eax
  103a35:	89 46 38             	mov    %eax,0x38(%esi)
        break;
  103a38:	e9 19 fd ff ff       	jmp    103756 <pcpu_init_cpu+0x126>
  103a3d:	8d 76 00             	lea    0x0(%esi),%esi

00103a40 <pcpu_ncpu>:
    return ncpu;
  103a40:	e8 3c c9 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  103a45:	05 bb c5 00 00       	add    $0xc5bb,%eax
  103a4a:	8b 80 64 89 02 00    	mov    0x28964(%eax),%eax
}
  103a50:	c3                   	ret    
  103a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103a58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103a5f:	90                   	nop

00103a60 <pcpu_is_smp>:
    return ismp;
  103a60:	e8 1c c9 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  103a65:	05 9b c5 00 00       	add    $0xc59b,%eax
  103a6a:	0f b6 80 60 89 02 00 	movzbl 0x28960(%eax),%eax
}
  103a71:	c3                   	ret    
  103a72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103a80 <pcpu_onboot>:
{
  103a80:	53                   	push   %ebx
  103a81:	e8 03 c9 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  103a86:	81 c3 7a c5 00 00    	add    $0xc57a,%ebx
  103a8c:	83 ec 08             	sub    $0x8,%esp
    int cpu_idx = get_pcpu_idx();
  103a8f:	e8 ac 1f 00 00       	call   105a40 <get_pcpu_idx>
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103a94:	83 ec 0c             	sub    $0xc,%esp
  103a97:	50                   	push   %eax
  103a98:	e8 e3 20 00 00       	call   105b80 <get_pcpu_arch_info_pointer>
    return (mp_inited == TRUE) ? arch_info->bsp : (get_pcpu_idx() == 0);
  103a9d:	83 c4 10             	add    $0x10,%esp
  103aa0:	80 bb 61 89 02 00 01 	cmpb   $0x1,0x28961(%ebx)
  103aa7:	75 0f                	jne    103ab8 <pcpu_onboot+0x38>
  103aa9:	0f b6 40 04          	movzbl 0x4(%eax),%eax
}
  103aad:	83 c4 08             	add    $0x8,%esp
  103ab0:	5b                   	pop    %ebx
  103ab1:	c3                   	ret    
  103ab2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return (mp_inited == TRUE) ? arch_info->bsp : (get_pcpu_idx() == 0);
  103ab8:	e8 83 1f 00 00       	call   105a40 <get_pcpu_idx>
  103abd:	85 c0                	test   %eax,%eax
  103abf:	0f 94 c0             	sete   %al
}
  103ac2:	83 c4 08             	add    $0x8,%esp
  103ac5:	5b                   	pop    %ebx
  103ac6:	c3                   	ret    
  103ac7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103ace:	66 90                	xchg   %ax,%ax

00103ad0 <pcpu_cpu_lapicid>:
{
  103ad0:	57                   	push   %edi
  103ad1:	56                   	push   %esi
  103ad2:	53                   	push   %ebx
  103ad3:	8b 7c 24 10          	mov    0x10(%esp),%edi
  103ad7:	e8 ad c8 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  103adc:	81 c3 24 c5 00 00    	add    $0xc524,%ebx
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103ae2:	83 ec 0c             	sub    $0xc,%esp
  103ae5:	57                   	push   %edi
  103ae6:	e8 95 20 00 00       	call   105b80 <get_pcpu_arch_info_pointer>
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < ncpu);
  103aeb:	83 c4 10             	add    $0x10,%esp
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103aee:	89 c6                	mov    %eax,%esi
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < ncpu);
  103af0:	85 ff                	test   %edi,%edi
  103af2:	78 08                	js     103afc <pcpu_cpu_lapicid+0x2c>
  103af4:	3b bb 64 89 02 00    	cmp    0x28964(%ebx),%edi
  103afa:	72 22                	jb     103b1e <pcpu_cpu_lapicid+0x4e>
  103afc:	8d 83 00 99 ff ff    	lea    -0x6700(%ebx),%eax
  103b02:	50                   	push   %eax
  103b03:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  103b09:	50                   	push   %eax
  103b0a:	8d 83 44 97 ff ff    	lea    -0x68bc(%ebx),%eax
  103b10:	68 ea 01 00 00       	push   $0x1ea
  103b15:	50                   	push   %eax
  103b16:	e8 15 05 00 00       	call   104030 <debug_panic>
  103b1b:	83 c4 10             	add    $0x10,%esp
    return arch_info->lapicid;
  103b1e:	0f b6 06             	movzbl (%esi),%eax
}
  103b21:	5b                   	pop    %ebx
  103b22:	5e                   	pop    %esi
  103b23:	5f                   	pop    %edi
  103b24:	c3                   	ret    
  103b25:	66 90                	xchg   %ax,%ax
  103b27:	66 90                	xchg   %ax,%ax
  103b29:	66 90                	xchg   %ax,%ax
  103b2b:	66 90                	xchg   %ax,%ax
  103b2d:	66 90                	xchg   %ax,%ax
  103b2f:	90                   	nop

00103b30 <detect_kvm>:
}

#define CPUID_FEATURE_HYPERVISOR	(1<<31) /* Running on a hypervisor */

int detect_kvm(void)
{
  103b30:	55                   	push   %ebp
	__asm __volatile("cpuid"
  103b31:	b8 01 00 00 00       	mov    $0x1,%eax
{
  103b36:	57                   	push   %edi
  103b37:	e8 08 02 00 00       	call   103d44 <__x86.get_pc_thunk.di>
  103b3c:	81 c7 c4 c4 00 00    	add    $0xc4c4,%edi
  103b42:	56                   	push   %esi
	__asm __volatile("cpuid"
  103b43:	31 f6                	xor    %esi,%esi
{
  103b45:	53                   	push   %ebx
	__asm __volatile("cpuid"
  103b46:	89 f1                	mov    %esi,%ecx
{
  103b48:	83 ec 2c             	sub    $0x2c,%esp
	__asm __volatile("cpuid"
  103b4b:	0f a2                	cpuid  
	uint32_t eax;

	if (cpu_has (CPUID_FEATURE_HYPERVISOR))
  103b4d:	83 e2 01             	and    $0x1,%edx
  103b50:	89 d5                	mov    %edx,%ebp
  103b52:	75 0c                	jne    103b60 <detect_kvm+0x30>
		{
			return 1;
		}
	}
	return 0;
}
  103b54:	83 c4 2c             	add    $0x2c,%esp
  103b57:	89 e8                	mov    %ebp,%eax
  103b59:	5b                   	pop    %ebx
  103b5a:	5e                   	pop    %esi
  103b5b:	5f                   	pop    %edi
  103b5c:	5d                   	pop    %ebp
  103b5d:	c3                   	ret    
  103b5e:	66 90                	xchg   %ax,%ax
		cpuid (CPUID_KVM_SIGNATURE, &eax, &hyper_vendor_id[0],
  103b60:	83 ec 0c             	sub    $0xc,%esp
  103b63:	89 fb                	mov    %edi,%ebx
  103b65:	8d 54 24 28          	lea    0x28(%esp),%edx
  103b69:	8d 44 24 20          	lea    0x20(%esp),%eax
  103b6d:	52                   	push   %edx
  103b6e:	8d 54 24 28          	lea    0x28(%esp),%edx
  103b72:	52                   	push   %edx
  103b73:	50                   	push   %eax
  103b74:	8d 54 24 28          	lea    0x28(%esp),%edx
  103b78:	89 44 24 24          	mov    %eax,0x24(%esp)
  103b7c:	52                   	push   %edx
  103b7d:	68 00 00 00 40       	push   $0x40000000
  103b82:	e8 49 11 00 00       	call   104cd0 <cpuid>
		if (!strncmp ("KVMKVMKVM", (const char *) hyper_vendor_id, 9))
  103b87:	83 c4 1c             	add    $0x1c,%esp
  103b8a:	6a 09                	push   $0x9
  103b8c:	8b 44 24 14          	mov    0x14(%esp),%eax
  103b90:	50                   	push   %eax
  103b91:	8d 87 d8 a1 ff ff    	lea    -0x5e28(%edi),%eax
  103b97:	50                   	push   %eax
  103b98:	e8 83 02 00 00       	call   103e20 <strncmp>
  103b9d:	83 c4 10             	add    $0x10,%esp
	return 0;
  103ba0:	85 c0                	test   %eax,%eax
  103ba2:	0f 45 ee             	cmovne %esi,%ebp
}
  103ba5:	83 c4 2c             	add    $0x2c,%esp
  103ba8:	5b                   	pop    %ebx
  103ba9:	5e                   	pop    %esi
  103baa:	89 e8                	mov    %ebp,%eax
  103bac:	5f                   	pop    %edi
  103bad:	5d                   	pop    %ebp
  103bae:	c3                   	ret    
  103baf:	90                   	nop

00103bb0 <kvm_has_feature>:

int
kvm_has_feature(uint32_t feature)
{
  103bb0:	53                   	push   %ebx
  103bb1:	e8 d3 c7 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  103bb6:	81 c3 4a c4 00 00    	add    $0xc44a,%ebx
  103bbc:	83 ec 24             	sub    $0x24,%esp
	uint32_t eax, ebx, ecx, edx;
	eax = 0; edx = 0;
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  103bbf:	8d 44 24 18          	lea    0x18(%esp),%eax
	eax = 0; edx = 0;
  103bc3:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  103bca:	00 
  103bcb:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  103bd2:	00 
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  103bd3:	50                   	push   %eax
  103bd4:	8d 44 24 18          	lea    0x18(%esp),%eax
  103bd8:	50                   	push   %eax
  103bd9:	8d 44 24 18          	lea    0x18(%esp),%eax
  103bdd:	50                   	push   %eax
  103bde:	8d 44 24 18          	lea    0x18(%esp),%eax
  103be2:	50                   	push   %eax
  103be3:	68 01 00 00 40       	push   $0x40000001
  103be8:	e8 e3 10 00 00       	call   104cd0 <cpuid>

	return ((eax & feature) != 0 ? 1 : 0);
  103bed:	8b 44 24 40          	mov    0x40(%esp),%eax
  103bf1:	23 44 24 20          	and    0x20(%esp),%eax
  103bf5:	85 c0                	test   %eax,%eax
  103bf7:	0f 95 c0             	setne  %al
}
  103bfa:	83 c4 38             	add    $0x38,%esp
	return ((eax & feature) != 0 ? 1 : 0);
  103bfd:	0f b6 c0             	movzbl %al,%eax
}
  103c00:	5b                   	pop    %ebx
  103c01:	c3                   	ret    
  103c02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103c10 <kvm_enable_feature>:

int
kvm_enable_feature(uint32_t feature)
{
  103c10:	53                   	push   %ebx
	uint32_t eax, ebx, ecx, edx;
	eax = 1 << feature; edx = 0;
  103c11:	b8 01 00 00 00       	mov    $0x1,%eax
  103c16:	e8 6e c7 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  103c1b:	81 c3 e5 c3 00 00    	add    $0xc3e5,%ebx
{
  103c21:	83 ec 24             	sub    $0x24,%esp
	eax = 1 << feature; edx = 0;
  103c24:	8b 4c 24 2c          	mov    0x2c(%esp),%ecx
  103c28:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  103c2f:	00 
  103c30:	d3 e0                	shl    %cl,%eax
  103c32:	89 44 24 0c          	mov    %eax,0xc(%esp)
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  103c36:	8d 44 24 18          	lea    0x18(%esp),%eax
  103c3a:	50                   	push   %eax
  103c3b:	8d 44 24 18          	lea    0x18(%esp),%eax
  103c3f:	50                   	push   %eax
  103c40:	8d 44 24 18          	lea    0x18(%esp),%eax
  103c44:	50                   	push   %eax
  103c45:	8d 44 24 18          	lea    0x18(%esp),%eax
  103c49:	50                   	push   %eax
  103c4a:	68 01 00 00 40       	push   $0x40000001
  103c4f:	e8 7c 10 00 00       	call   104cd0 <cpuid>

	return (ebx == 0 ? 1 : 0);
  103c54:	8b 54 24 24          	mov    0x24(%esp),%edx
  103c58:	31 c0                	xor    %eax,%eax
  103c5a:	85 d2                	test   %edx,%edx
  103c5c:	0f 94 c0             	sete   %al
}
  103c5f:	83 c4 38             	add    $0x38,%esp
  103c62:	5b                   	pop    %ebx
  103c63:	c3                   	ret    
  103c64:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103c6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103c6f:	90                   	nop

00103c70 <kvm_get_tsc_hz>:

uint64_t
kvm_get_tsc_hz(void)
{
  103c70:	55                   	push   %ebp
  103c71:	57                   	push   %edi
  103c72:	56                   	push   %esi
  103c73:	53                   	push   %ebx
  103c74:	e8 10 c7 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  103c79:	81 c3 87 c3 00 00    	add    $0xc387,%ebx
  103c7f:	83 ec 38             	sub    $0x38,%esp
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  103c82:	8d 44 24 28          	lea    0x28(%esp),%eax
	eax = 0; edx = 0;
  103c86:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  103c8d:	00 
  103c8e:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
  103c95:	00 
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  103c96:	50                   	push   %eax
  103c97:	8d 6c 24 28          	lea    0x28(%esp),%ebp
  103c9b:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  103c9f:	55                   	push   %ebp
  103ca0:	8d 7c 24 28          	lea    0x28(%esp),%edi
  103ca4:	57                   	push   %edi
  103ca5:	8d 74 24 28          	lea    0x28(%esp),%esi
  103ca9:	56                   	push   %esi
  103caa:	68 01 00 00 40       	push   $0x40000001
  103caf:	e8 1c 10 00 00       	call   104cd0 <cpuid>
	uint64_t tsc_hz = 0llu;
	uint32_t msr_sys_time;

	if (kvm_has_feature(KVM_FEATURE_CLOCKSOURCE2))
  103cb4:	83 c4 20             	add    $0x20,%esp
  103cb7:	f6 44 24 10 03       	testb  $0x3,0x10(%esp)
  103cbc:	75 42                	jne    103d00 <kvm_get_tsc_hz+0x90>
	eax = 0; edx = 0;
  103cbe:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  103cc5:	00 
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  103cc6:	83 ec 0c             	sub    $0xc,%esp
	eax = 0; edx = 0;
  103cc9:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
  103cd0:	00 
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  103cd1:	8b 44 24 18          	mov    0x18(%esp),%eax
  103cd5:	50                   	push   %eax
  103cd6:	55                   	push   %ebp
  103cd7:	57                   	push   %edi
	{
		msr_sys_time = MSR_KVM_SYSTEM_TIME;
	}
	else
	{
		return (0llu);
  103cd8:	31 ff                	xor    %edi,%edi
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  103cda:	56                   	push   %esi
		return (0llu);
  103cdb:	31 f6                	xor    %esi,%esi
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  103cdd:	68 01 00 00 40       	push   $0x40000001
  103ce2:	e8 e9 0f 00 00       	call   104cd0 <cpuid>
	return ((eax & feature) != 0 ? 1 : 0);
  103ce7:	83 c4 20             	add    $0x20,%esp

	/* disable update */
	wrmsr(msr_sys_time, (uint64_t) ((uint32_t) &pvclock));

	return tsc_hz;
}
  103cea:	89 f0                	mov    %esi,%eax
  103cec:	89 fa                	mov    %edi,%edx
  103cee:	83 c4 2c             	add    $0x2c,%esp
  103cf1:	5b                   	pop    %ebx
  103cf2:	5e                   	pop    %esi
  103cf3:	5f                   	pop    %edi
  103cf4:	5d                   	pop    %ebp
  103cf5:	c3                   	ret    
  103cf6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103cfd:	8d 76 00             	lea    0x0(%esi),%esi
	wrmsr(msr_sys_time, (uint64_t) ((uint32_t) &pvclock) | 0x1llu);
  103d00:	8d ab 80 89 02 00    	lea    0x28980(%ebx),%ebp
  103d06:	83 ec 04             	sub    $0x4,%esp
  103d09:	31 d2                	xor    %edx,%edx
	tsc_hz = (uint64_t) pvclock.tsc_to_system_mul;
  103d0b:	31 ff                	xor    %edi,%edi
	wrmsr(msr_sys_time, (uint64_t) ((uint32_t) &pvclock) | 0x1llu);
  103d0d:	89 e8                	mov    %ebp,%eax
  103d0f:	52                   	push   %edx
  103d10:	83 c8 01             	or     $0x1,%eax
  103d13:	50                   	push   %eax
  103d14:	68 01 4d 56 4b       	push   $0x4b564d01
  103d19:	e8 22 0f 00 00       	call   104c40 <wrmsr>
	wrmsr(msr_sys_time, (uint64_t) ((uint32_t) &pvclock));
  103d1e:	83 c4 0c             	add    $0xc,%esp
  103d21:	31 d2                	xor    %edx,%edx
	tsc_hz = (uint64_t) pvclock.tsc_to_system_mul;
  103d23:	8b b3 98 89 02 00    	mov    0x28998(%ebx),%esi
	wrmsr(msr_sys_time, (uint64_t) ((uint32_t) &pvclock));
  103d29:	52                   	push   %edx
  103d2a:	55                   	push   %ebp
  103d2b:	68 01 4d 56 4b       	push   $0x4b564d01
  103d30:	e8 0b 0f 00 00       	call   104c40 <wrmsr>
	return tsc_hz;
  103d35:	83 c4 10             	add    $0x10,%esp
}
  103d38:	89 f0                	mov    %esi,%eax
  103d3a:	89 fa                	mov    %edi,%edx
  103d3c:	83 c4 2c             	add    $0x2c,%esp
  103d3f:	5b                   	pop    %ebx
  103d40:	5e                   	pop    %esi
  103d41:	5f                   	pop    %edi
  103d42:	5d                   	pop    %ebp
  103d43:	c3                   	ret    

00103d44 <__x86.get_pc_thunk.di>:
  103d44:	8b 3c 24             	mov    (%esp),%edi
  103d47:	c3                   	ret    
  103d48:	66 90                	xchg   %ax,%ax
  103d4a:	66 90                	xchg   %ax,%ax
  103d4c:	66 90                	xchg   %ax,%ax
  103d4e:	66 90                	xchg   %ax,%ax

00103d50 <memset>:
#include "string.h"
#include "types.h"

void *memset(void *v, int c, size_t n)
{
  103d50:	57                   	push   %edi
  103d51:	56                   	push   %esi
  103d52:	53                   	push   %ebx
  103d53:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  103d57:	8b 7c 24 10          	mov    0x10(%esp),%edi
    if (n == 0)
  103d5b:	85 c9                	test   %ecx,%ecx
  103d5d:	74 28                	je     103d87 <memset+0x37>
        return v;
    if ((int) v % 4 == 0 && n % 4 == 0) {
  103d5f:	89 f8                	mov    %edi,%eax
  103d61:	09 c8                	or     %ecx,%eax
  103d63:	a8 03                	test   $0x3,%al
  103d65:	75 29                	jne    103d90 <memset+0x40>
        c &= 0xFF;
  103d67:	0f b6 5c 24 14       	movzbl 0x14(%esp),%ebx
        c = (c << 24) | (c << 16) | (c << 8) | c;
        asm volatile ("cld; rep stosl\n"
                      :: "D" (v), "a" (c), "c" (n / 4)
  103d6c:	c1 e9 02             	shr    $0x2,%ecx
        c = (c << 24) | (c << 16) | (c << 8) | c;
  103d6f:	89 da                	mov    %ebx,%edx
  103d71:	89 de                	mov    %ebx,%esi
  103d73:	89 d8                	mov    %ebx,%eax
  103d75:	c1 e2 18             	shl    $0x18,%edx
  103d78:	c1 e6 10             	shl    $0x10,%esi
  103d7b:	09 f2                	or     %esi,%edx
  103d7d:	c1 e0 08             	shl    $0x8,%eax
  103d80:	09 da                	or     %ebx,%edx
  103d82:	09 d0                	or     %edx,%eax
        asm volatile ("cld; rep stosl\n"
  103d84:	fc                   	cld    
  103d85:	f3 ab                	rep stos %eax,%es:(%edi)
    } else
        asm volatile ("cld; rep stosb\n"
                      :: "D" (v), "a" (c), "c" (n)
                      : "cc", "memory");
    return v;
}
  103d87:	89 f8                	mov    %edi,%eax
  103d89:	5b                   	pop    %ebx
  103d8a:	5e                   	pop    %esi
  103d8b:	5f                   	pop    %edi
  103d8c:	c3                   	ret    
  103d8d:	8d 76 00             	lea    0x0(%esi),%esi
        asm volatile ("cld; rep stosb\n"
  103d90:	8b 44 24 14          	mov    0x14(%esp),%eax
  103d94:	fc                   	cld    
  103d95:	f3 aa                	rep stos %al,%es:(%edi)
}
  103d97:	89 f8                	mov    %edi,%eax
  103d99:	5b                   	pop    %ebx
  103d9a:	5e                   	pop    %esi
  103d9b:	5f                   	pop    %edi
  103d9c:	c3                   	ret    
  103d9d:	8d 76 00             	lea    0x0(%esi),%esi

00103da0 <memmove>:

void *memmove(void *dst, const void *src, size_t n)
{
  103da0:	57                   	push   %edi
  103da1:	56                   	push   %esi
  103da2:	8b 44 24 0c          	mov    0xc(%esp),%eax
  103da6:	8b 74 24 10          	mov    0x10(%esp),%esi
  103daa:	8b 4c 24 14          	mov    0x14(%esp),%ecx
    const char *s;
    char *d;

    s = src;
    d = dst;
    if (s < d && s + n > d) {
  103dae:	39 c6                	cmp    %eax,%esi
  103db0:	73 26                	jae    103dd8 <memmove+0x38>
  103db2:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
  103db5:	39 c2                	cmp    %eax,%edx
  103db7:	76 1f                	jbe    103dd8 <memmove+0x38>
        s += n;
        d += n;
  103db9:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
  103dbc:	89 d6                	mov    %edx,%esi
  103dbe:	09 fe                	or     %edi,%esi
  103dc0:	09 ce                	or     %ecx,%esi
  103dc2:	83 e6 03             	and    $0x3,%esi
  103dc5:	74 39                	je     103e00 <memmove+0x60>
            asm volatile ("std; rep movsl\n"
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
                          : "cc", "memory");
        else
            asm volatile ("std; rep movsb\n"
                          :: "D" (d - 1), "S" (s - 1), "c" (n)
  103dc7:	83 ef 01             	sub    $0x1,%edi
  103dca:	8d 72 ff             	lea    -0x1(%edx),%esi
            asm volatile ("std; rep movsb\n"
  103dcd:	fd                   	std    
  103dce:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
                          : "cc", "memory");
        // Some versions of GCC rely on DF being clear
        asm volatile ("cld" ::: "cc");
  103dd0:	fc                   	cld    
            asm volatile ("cld; rep movsb\n"
                          :: "D" (d), "S" (s), "c" (n)
                          : "cc", "memory");
    }
    return dst;
}
  103dd1:	5e                   	pop    %esi
  103dd2:	5f                   	pop    %edi
  103dd3:	c3                   	ret    
  103dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
  103dd8:	89 f2                	mov    %esi,%edx
  103dda:	09 c2                	or     %eax,%edx
  103ddc:	09 ca                	or     %ecx,%edx
  103dde:	83 e2 03             	and    $0x3,%edx
  103de1:	74 0d                	je     103df0 <memmove+0x50>
            asm volatile ("cld; rep movsb\n"
  103de3:	89 c7                	mov    %eax,%edi
  103de5:	fc                   	cld    
  103de6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
}
  103de8:	5e                   	pop    %esi
  103de9:	5f                   	pop    %edi
  103dea:	c3                   	ret    
  103deb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103def:	90                   	nop
                          :: "D" (d), "S" (s), "c" (n / 4)
  103df0:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("cld; rep movsl\n"
  103df3:	89 c7                	mov    %eax,%edi
  103df5:	fc                   	cld    
  103df6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  103df8:	eb ee                	jmp    103de8 <memmove+0x48>
  103dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
  103e00:	83 ef 04             	sub    $0x4,%edi
  103e03:	8d 72 fc             	lea    -0x4(%edx),%esi
  103e06:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("std; rep movsl\n"
  103e09:	fd                   	std    
  103e0a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  103e0c:	eb c2                	jmp    103dd0 <memmove+0x30>
  103e0e:	66 90                	xchg   %ax,%ax

00103e10 <memcpy>:

void *memcpy(void *dst, const void *src, size_t n)
{
    return memmove(dst, src, n);
  103e10:	eb 8e                	jmp    103da0 <memmove>
  103e12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103e20 <strncmp>:
}

int strncmp(const char *p, const char *q, size_t n)
{
  103e20:	56                   	push   %esi
  103e21:	53                   	push   %ebx
  103e22:	8b 74 24 14          	mov    0x14(%esp),%esi
  103e26:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  103e2a:	8b 44 24 10          	mov    0x10(%esp),%eax
    while (n > 0 && *p && *p == *q)
  103e2e:	85 f6                	test   %esi,%esi
  103e30:	74 2e                	je     103e60 <strncmp+0x40>
  103e32:	01 c6                	add    %eax,%esi
  103e34:	eb 18                	jmp    103e4e <strncmp+0x2e>
  103e36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103e3d:	8d 76 00             	lea    0x0(%esi),%esi
  103e40:	38 da                	cmp    %bl,%dl
  103e42:	75 14                	jne    103e58 <strncmp+0x38>
        n--, p++, q++;
  103e44:	83 c0 01             	add    $0x1,%eax
  103e47:	83 c1 01             	add    $0x1,%ecx
    while (n > 0 && *p && *p == *q)
  103e4a:	39 f0                	cmp    %esi,%eax
  103e4c:	74 12                	je     103e60 <strncmp+0x40>
  103e4e:	0f b6 11             	movzbl (%ecx),%edx
  103e51:	0f b6 18             	movzbl (%eax),%ebx
  103e54:	84 d2                	test   %dl,%dl
  103e56:	75 e8                	jne    103e40 <strncmp+0x20>
    if (n == 0)
        return 0;
    else
        return (int) ((unsigned char) *p - (unsigned char) *q);
  103e58:	0f b6 c2             	movzbl %dl,%eax
  103e5b:	29 d8                	sub    %ebx,%eax
}
  103e5d:	5b                   	pop    %ebx
  103e5e:	5e                   	pop    %esi
  103e5f:	c3                   	ret    
        return 0;
  103e60:	31 c0                	xor    %eax,%eax
}
  103e62:	5b                   	pop    %ebx
  103e63:	5e                   	pop    %esi
  103e64:	c3                   	ret    
  103e65:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103e70 <strnlen>:

int strnlen(const char *s, size_t size)
{
  103e70:	8b 54 24 08          	mov    0x8(%esp),%edx
  103e74:	8b 4c 24 04          	mov    0x4(%esp),%ecx
    int n;

    for (n = 0; size > 0 && *s != '\0'; s++, size--)
  103e78:	31 c0                	xor    %eax,%eax
  103e7a:	85 d2                	test   %edx,%edx
  103e7c:	75 09                	jne    103e87 <strnlen+0x17>
  103e7e:	eb 10                	jmp    103e90 <strnlen+0x20>
        n++;
  103e80:	83 c0 01             	add    $0x1,%eax
    for (n = 0; size > 0 && *s != '\0'; s++, size--)
  103e83:	39 d0                	cmp    %edx,%eax
  103e85:	74 09                	je     103e90 <strnlen+0x20>
  103e87:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  103e8b:	75 f3                	jne    103e80 <strnlen+0x10>
  103e8d:	c3                   	ret    
  103e8e:	66 90                	xchg   %ax,%ax
    return n;
}
  103e90:	c3                   	ret    
  103e91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103e98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103e9f:	90                   	nop

00103ea0 <strcmp>:

int strcmp(const char *p, const char *q)
{
  103ea0:	53                   	push   %ebx
  103ea1:	8b 54 24 08          	mov    0x8(%esp),%edx
  103ea5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    while (*p && *p == *q)
  103ea9:	0f b6 02             	movzbl (%edx),%eax
  103eac:	84 c0                	test   %al,%al
  103eae:	75 18                	jne    103ec8 <strcmp+0x28>
  103eb0:	eb 30                	jmp    103ee2 <strcmp+0x42>
  103eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103eb8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        p++, q++;
  103ebc:	83 c2 01             	add    $0x1,%edx
  103ebf:	8d 59 01             	lea    0x1(%ecx),%ebx
    while (*p && *p == *q)
  103ec2:	84 c0                	test   %al,%al
  103ec4:	74 12                	je     103ed8 <strcmp+0x38>
        p++, q++;
  103ec6:	89 d9                	mov    %ebx,%ecx
    while (*p && *p == *q)
  103ec8:	0f b6 19             	movzbl (%ecx),%ebx
  103ecb:	38 c3                	cmp    %al,%bl
  103ecd:	74 e9                	je     103eb8 <strcmp+0x18>
    return (int) ((unsigned char) *p - (unsigned char) *q);
  103ecf:	29 d8                	sub    %ebx,%eax
}
  103ed1:	5b                   	pop    %ebx
  103ed2:	c3                   	ret    
  103ed3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103ed7:	90                   	nop
    return (int) ((unsigned char) *p - (unsigned char) *q);
  103ed8:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  103edc:	31 c0                	xor    %eax,%eax
  103ede:	29 d8                	sub    %ebx,%eax
}
  103ee0:	5b                   	pop    %ebx
  103ee1:	c3                   	ret    
    return (int) ((unsigned char) *p - (unsigned char) *q);
  103ee2:	0f b6 19             	movzbl (%ecx),%ebx
  103ee5:	31 c0                	xor    %eax,%eax
  103ee7:	eb e6                	jmp    103ecf <strcmp+0x2f>
  103ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103ef0 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *strchr(const char *s, char c)
{
  103ef0:	8b 44 24 04          	mov    0x4(%esp),%eax
  103ef4:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
    for (; *s; s++)
  103ef9:	0f b6 10             	movzbl (%eax),%edx
  103efc:	84 d2                	test   %dl,%dl
  103efe:	75 13                	jne    103f13 <strchr+0x23>
  103f00:	eb 1e                	jmp    103f20 <strchr+0x30>
  103f02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103f08:	0f b6 50 01          	movzbl 0x1(%eax),%edx
  103f0c:	83 c0 01             	add    $0x1,%eax
  103f0f:	84 d2                	test   %dl,%dl
  103f11:	74 0d                	je     103f20 <strchr+0x30>
        if (*s == c)
  103f13:	38 d1                	cmp    %dl,%cl
  103f15:	75 f1                	jne    103f08 <strchr+0x18>
            return (char *) s;
    return 0;
}
  103f17:	c3                   	ret    
  103f18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103f1f:	90                   	nop
    return 0;
  103f20:	31 c0                	xor    %eax,%eax
}
  103f22:	c3                   	ret    
  103f23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103f30 <memzero>:

void *memzero(void *v, size_t n)
{
  103f30:	57                   	push   %edi
  103f31:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  103f35:	8b 7c 24 08          	mov    0x8(%esp),%edi
    if (n == 0)
  103f39:	85 c9                	test   %ecx,%ecx
  103f3b:	74 0f                	je     103f4c <memzero+0x1c>
    if ((int) v % 4 == 0 && n % 4 == 0) {
  103f3d:	89 f8                	mov    %edi,%eax
  103f3f:	09 c8                	or     %ecx,%eax
  103f41:	83 e0 03             	and    $0x3,%eax
  103f44:	75 0a                	jne    103f50 <memzero+0x20>
                      :: "D" (v), "a" (c), "c" (n / 4)
  103f46:	c1 e9 02             	shr    $0x2,%ecx
        asm volatile ("cld; rep stosl\n"
  103f49:	fc                   	cld    
  103f4a:	f3 ab                	rep stos %eax,%es:(%edi)
    return memset(v, 0, n);
}
  103f4c:	89 f8                	mov    %edi,%eax
  103f4e:	5f                   	pop    %edi
  103f4f:	c3                   	ret    
        asm volatile ("cld; rep stosb\n"
  103f50:	31 c0                	xor    %eax,%eax
  103f52:	fc                   	cld    
  103f53:	f3 aa                	rep stos %al,%es:(%edi)
}
  103f55:	89 f8                	mov    %edi,%eax
  103f57:	5f                   	pop    %edi
  103f58:	c3                   	ret    
  103f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103f60 <memcmp>:

int memcmp(const void *v1, const void *v2, size_t n)
{
  103f60:	56                   	push   %esi
  103f61:	53                   	push   %ebx
  103f62:	8b 74 24 14          	mov    0x14(%esp),%esi
  103f66:	8b 54 24 0c          	mov    0xc(%esp),%edx
  103f6a:	8b 44 24 10          	mov    0x10(%esp),%eax
    const uint8_t *s1 = (const uint8_t *) v1;
    const uint8_t *s2 = (const uint8_t *) v2;

    while (n-- > 0) {
  103f6e:	85 f6                	test   %esi,%esi
  103f70:	74 2e                	je     103fa0 <memcmp+0x40>
  103f72:	01 c6                	add    %eax,%esi
  103f74:	eb 14                	jmp    103f8a <memcmp+0x2a>
  103f76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103f7d:	8d 76 00             	lea    0x0(%esi),%esi
        if (*s1 != *s2)
            return (int) *s1 - (int) *s2;
        s1++, s2++;
  103f80:	83 c0 01             	add    $0x1,%eax
  103f83:	83 c2 01             	add    $0x1,%edx
    while (n-- > 0) {
  103f86:	39 f0                	cmp    %esi,%eax
  103f88:	74 16                	je     103fa0 <memcmp+0x40>
        if (*s1 != *s2)
  103f8a:	0f b6 0a             	movzbl (%edx),%ecx
  103f8d:	0f b6 18             	movzbl (%eax),%ebx
  103f90:	38 d9                	cmp    %bl,%cl
  103f92:	74 ec                	je     103f80 <memcmp+0x20>
            return (int) *s1 - (int) *s2;
  103f94:	0f b6 c1             	movzbl %cl,%eax
  103f97:	29 d8                	sub    %ebx,%eax
    }

    return 0;
}
  103f99:	5b                   	pop    %ebx
  103f9a:	5e                   	pop    %esi
  103f9b:	c3                   	ret    
  103f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
  103fa0:	31 c0                	xor    %eax,%eax
}
  103fa2:	5b                   	pop    %ebx
  103fa3:	5e                   	pop    %esi
  103fa4:	c3                   	ret    
  103fa5:	66 90                	xchg   %ax,%ax
  103fa7:	66 90                	xchg   %ax,%ax
  103fa9:	66 90                	xchg   %ax,%ax
  103fab:	66 90                	xchg   %ax,%ax
  103fad:	66 90                	xchg   %ax,%ax
  103faf:	90                   	nop

00103fb0 <debug_init>:
#include <lib/types.h>
#include <lib/spinlock.h>

void debug_init(void)
{
}
  103fb0:	c3                   	ret    
  103fb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103fb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103fbf:	90                   	nop

00103fc0 <debug_info>:

extern int vdprintf(const char *fmt, va_list ap);

void debug_info(const char *fmt, ...)
{
  103fc0:	53                   	push   %ebx
  103fc1:	e8 c3 c3 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  103fc6:	81 c3 3a c0 00 00    	add    $0xc03a,%ebx
  103fcc:	83 ec 08             	sub    $0x8,%esp
#ifdef DEBUG_MSG
    va_list ap;
    va_start(ap, fmt);
  103fcf:	8d 44 24 14          	lea    0x14(%esp),%eax
    vdprintf(fmt, ap);
  103fd3:	83 ec 08             	sub    $0x8,%esp
  103fd6:	50                   	push   %eax
  103fd7:	ff 74 24 1c          	push   0x1c(%esp)
  103fdb:	e8 d0 01 00 00       	call   1041b0 <vdprintf>
    va_end(ap);
#endif
}
  103fe0:	83 c4 18             	add    $0x18,%esp
  103fe3:	5b                   	pop    %ebx
  103fe4:	c3                   	ret    
  103fe5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103ff0 <debug_normal>:

#ifdef DEBUG_MSG

void debug_normal(const char *file, int line, const char *fmt, ...)
{
  103ff0:	53                   	push   %ebx
  103ff1:	e8 93 c3 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  103ff6:	81 c3 0a c0 00 00    	add    $0xc00a,%ebx
  103ffc:	83 ec 0c             	sub    $0xc,%esp
    dprintf("[D] %s:%d: ", file, line);
  103fff:	ff 74 24 18          	push   0x18(%esp)
  104003:	ff 74 24 18          	push   0x18(%esp)
  104007:	8d 83 e2 a1 ff ff    	lea    -0x5e1e(%ebx),%eax
  10400d:	50                   	push   %eax
  10400e:	e8 2d 02 00 00       	call   104240 <dprintf>

    va_list ap;
    va_start(ap, fmt);
  104013:	8d 44 24 2c          	lea    0x2c(%esp),%eax
    vdprintf(fmt, ap);
  104017:	5a                   	pop    %edx
  104018:	59                   	pop    %ecx
  104019:	50                   	push   %eax
  10401a:	ff 74 24 24          	push   0x24(%esp)
  10401e:	e8 8d 01 00 00       	call   1041b0 <vdprintf>
    va_end(ap);
}
  104023:	83 c4 18             	add    $0x18,%esp
  104026:	5b                   	pop    %ebx
  104027:	c3                   	ret    
  104028:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10402f:	90                   	nop

00104030 <debug_panic>:
    for (; i < DEBUG_TRACEFRAMES; i++)
        eips[i] = 0;
}

gcc_noinline void debug_panic(const char *file, int line, const char *fmt, ...)
{
  104030:	55                   	push   %ebp
  104031:	57                   	push   %edi
  104032:	56                   	push   %esi
  104033:	53                   	push   %ebx
  104034:	e8 50 c3 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  104039:	81 c3 c7 bf 00 00    	add    $0xbfc7,%ebx
  10403f:	83 ec 40             	sub    $0x40,%esp
    int i;
    uintptr_t eips[DEBUG_TRACEFRAMES];
    va_list ap;

    dprintf("[P] %s:%d: ", file, line);
  104042:	ff 74 24 58          	push   0x58(%esp)
  104046:	ff 74 24 58          	push   0x58(%esp)
  10404a:	8d 83 ee a1 ff ff    	lea    -0x5e12(%ebx),%eax
  104050:	50                   	push   %eax
  104051:	e8 ea 01 00 00       	call   104240 <dprintf>

    va_start(ap, fmt);
  104056:	8d 44 24 6c          	lea    0x6c(%esp),%eax
    vdprintf(fmt, ap);
  10405a:	5a                   	pop    %edx
  10405b:	59                   	pop    %ecx
  10405c:	50                   	push   %eax
  10405d:	ff 74 24 64          	push   0x64(%esp)
  104061:	e8 4a 01 00 00       	call   1041b0 <vdprintf>
    va_end(ap);

    debug_trace(read_ebp(), eips);
  104066:	e8 85 0b 00 00       	call   104bf0 <read_ebp>
    for (i = 0; i < DEBUG_TRACEFRAMES && frame; i++) {
  10406b:	83 c4 10             	add    $0x10,%esp
  10406e:	31 d2                	xor    %edx,%edx
  104070:	8d 74 24 08          	lea    0x8(%esp),%esi
  104074:	85 c0                	test   %eax,%eax
  104076:	74 21                	je     104099 <debug_panic+0x69>
  104078:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10407f:	90                   	nop
        eips[i] = frame[1];              /* saved %eip */
  104080:	8b 48 04             	mov    0x4(%eax),%ecx
        frame = (uintptr_t *) frame[0];  /* saved %ebp */
  104083:	8b 00                	mov    (%eax),%eax
        eips[i] = frame[1];              /* saved %eip */
  104085:	89 0c 96             	mov    %ecx,(%esi,%edx,4)
    for (i = 0; i < DEBUG_TRACEFRAMES && frame; i++) {
  104088:	83 c2 01             	add    $0x1,%edx
  10408b:	83 fa 09             	cmp    $0x9,%edx
  10408e:	7f 04                	jg     104094 <debug_panic+0x64>
  104090:	85 c0                	test   %eax,%eax
  104092:	75 ec                	jne    104080 <debug_panic+0x50>
    for (; i < DEBUG_TRACEFRAMES; i++)
  104094:	83 fa 0a             	cmp    $0xa,%edx
  104097:	74 14                	je     1040ad <debug_panic+0x7d>
  104099:	8d 04 96             	lea    (%esi,%edx,4),%eax
  10409c:	8d 54 24 30          	lea    0x30(%esp),%edx
        eips[i] = 0;
  1040a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    for (; i < DEBUG_TRACEFRAMES; i++)
  1040a6:	83 c0 04             	add    $0x4,%eax
  1040a9:	39 d0                	cmp    %edx,%eax
  1040ab:	75 f3                	jne    1040a0 <debug_panic+0x70>
  1040ad:	8d 6c 24 30          	lea    0x30(%esp),%ebp
    for (i = 0; i < DEBUG_TRACEFRAMES && eips[i] != 0; i++)
        dprintf("\tfrom 0x%08x\n", eips[i]);
  1040b1:	8d bb fa a1 ff ff    	lea    -0x5e06(%ebx),%edi
  1040b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1040be:	66 90                	xchg   %ax,%ax
    for (i = 0; i < DEBUG_TRACEFRAMES && eips[i] != 0; i++)
  1040c0:	8b 06                	mov    (%esi),%eax
  1040c2:	85 c0                	test   %eax,%eax
  1040c4:	74 14                	je     1040da <debug_panic+0xaa>
        dprintf("\tfrom 0x%08x\n", eips[i]);
  1040c6:	83 ec 08             	sub    $0x8,%esp
    for (i = 0; i < DEBUG_TRACEFRAMES && eips[i] != 0; i++)
  1040c9:	83 c6 04             	add    $0x4,%esi
        dprintf("\tfrom 0x%08x\n", eips[i]);
  1040cc:	50                   	push   %eax
  1040cd:	57                   	push   %edi
  1040ce:	e8 6d 01 00 00       	call   104240 <dprintf>
    for (i = 0; i < DEBUG_TRACEFRAMES && eips[i] != 0; i++)
  1040d3:	83 c4 10             	add    $0x10,%esp
  1040d6:	39 f5                	cmp    %esi,%ebp
  1040d8:	75 e6                	jne    1040c0 <debug_panic+0x90>

    dprintf("Kernel Panic !!!\n");
  1040da:	83 ec 0c             	sub    $0xc,%esp
  1040dd:	8d 83 08 a2 ff ff    	lea    -0x5df8(%ebx),%eax
  1040e3:	50                   	push   %eax
  1040e4:	e8 57 01 00 00       	call   104240 <dprintf>

    halt();
  1040e9:	e8 62 0b 00 00       	call   104c50 <halt>
}
  1040ee:	83 c4 4c             	add    $0x4c,%esp
  1040f1:	5b                   	pop    %ebx
  1040f2:	5e                   	pop    %esi
  1040f3:	5f                   	pop    %edi
  1040f4:	5d                   	pop    %ebp
  1040f5:	c3                   	ret    
  1040f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1040fd:	8d 76 00             	lea    0x0(%esi),%esi

00104100 <debug_warn>:

void debug_warn(const char *file, int line, const char *fmt, ...)
{
  104100:	53                   	push   %ebx
  104101:	e8 83 c2 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  104106:	81 c3 fa be 00 00    	add    $0xbefa,%ebx
  10410c:	83 ec 0c             	sub    $0xc,%esp
    dprintf("[W] %s:%d: ", file, line);
  10410f:	ff 74 24 18          	push   0x18(%esp)
  104113:	ff 74 24 18          	push   0x18(%esp)
  104117:	8d 83 1a a2 ff ff    	lea    -0x5de6(%ebx),%eax
  10411d:	50                   	push   %eax
  10411e:	e8 1d 01 00 00       	call   104240 <dprintf>

    va_list ap;
    va_start(ap, fmt);
  104123:	8d 44 24 2c          	lea    0x2c(%esp),%eax
    vdprintf(fmt, ap);
  104127:	5a                   	pop    %edx
  104128:	59                   	pop    %ecx
  104129:	50                   	push   %eax
  10412a:	ff 74 24 24          	push   0x24(%esp)
  10412e:	e8 7d 00 00 00       	call   1041b0 <vdprintf>
    va_end(ap);
}
  104133:	83 c4 18             	add    $0x18,%esp
  104136:	5b                   	pop    %ebx
  104137:	c3                   	ret    
  104138:	66 90                	xchg   %ax,%ax
  10413a:	66 90                	xchg   %ax,%ax
  10413c:	66 90                	xchg   %ax,%ax
  10413e:	66 90                	xchg   %ax,%ax

00104140 <putch>:
        str += 1;
    }
}

static void putch(int ch, struct dprintbuf *b)
{
  104140:	57                   	push   %edi
  104141:	56                   	push   %esi
  104142:	53                   	push   %ebx
  104143:	8b 74 24 14          	mov    0x14(%esp),%esi
  104147:	e8 3d c2 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10414c:	81 c3 b4 be 00 00    	add    $0xbeb4,%ebx
    b->buf[b->idx++] = ch;
  104152:	8b 54 24 10          	mov    0x10(%esp),%edx
  104156:	8b 0e                	mov    (%esi),%ecx
  104158:	8d 41 01             	lea    0x1(%ecx),%eax
  10415b:	89 06                	mov    %eax,(%esi)
  10415d:	88 54 0e 08          	mov    %dl,0x8(%esi,%ecx,1)
    if (b->idx == CONSOLE_BUFFER_SIZE - 1) {
  104161:	3d ff 01 00 00       	cmp    $0x1ff,%eax
  104166:	74 08                	je     104170 <putch+0x30>
        b->buf[b->idx] = 0;
        cputs(b->buf);
        b->idx = 0;
    }
    b->cnt++;
  104168:	83 46 04 01          	addl   $0x1,0x4(%esi)
}
  10416c:	5b                   	pop    %ebx
  10416d:	5e                   	pop    %esi
  10416e:	5f                   	pop    %edi
  10416f:	c3                   	ret    
    while (*str) {
  104170:	0f be 46 08          	movsbl 0x8(%esi),%eax
        b->buf[b->idx] = 0;
  104174:	c6 86 07 02 00 00 00 	movb   $0x0,0x207(%esi)
        cputs(b->buf);
  10417b:	8d 7e 08             	lea    0x8(%esi),%edi
    while (*str) {
  10417e:	84 c0                	test   %al,%al
  104180:	74 1c                	je     10419e <putch+0x5e>
  104182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cons_putc(*str);
  104188:	83 ec 0c             	sub    $0xc,%esp
        str += 1;
  10418b:	83 c7 01             	add    $0x1,%edi
        cons_putc(*str);
  10418e:	50                   	push   %eax
  10418f:	e8 fc c2 ff ff       	call   100490 <cons_putc>
    while (*str) {
  104194:	0f be 07             	movsbl (%edi),%eax
  104197:	83 c4 10             	add    $0x10,%esp
  10419a:	84 c0                	test   %al,%al
  10419c:	75 ea                	jne    104188 <putch+0x48>
    b->cnt++;
  10419e:	83 46 04 01          	addl   $0x1,0x4(%esi)
        b->idx = 0;
  1041a2:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
}
  1041a8:	5b                   	pop    %ebx
  1041a9:	5e                   	pop    %esi
  1041aa:	5f                   	pop    %edi
  1041ab:	c3                   	ret    
  1041ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001041b0 <vdprintf>:

int vdprintf(const char *fmt, va_list ap)
{
  1041b0:	56                   	push   %esi
  1041b1:	53                   	push   %ebx
  1041b2:	e8 d2 c1 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1041b7:	81 c3 49 be 00 00    	add    $0xbe49,%ebx
  1041bd:	81 ec 14 02 00 00    	sub    $0x214,%esp
    struct dprintbuf b;

    b.idx = 0;
  1041c3:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1041ca:	00 
    b.cnt = 0;
  1041cb:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1041d2:	00 
    vprintfmt((void *) putch, &b, fmt, ap);
  1041d3:	ff b4 24 24 02 00 00 	push   0x224(%esp)
  1041da:	ff b4 24 24 02 00 00 	push   0x224(%esp)
  1041e1:	8d 44 24 10          	lea    0x10(%esp),%eax
  1041e5:	50                   	push   %eax
  1041e6:	8d 83 40 41 ff ff    	lea    -0xbec0(%ebx),%eax
  1041ec:	50                   	push   %eax
  1041ed:	e8 4e 01 00 00       	call   104340 <vprintfmt>

    b.buf[b.idx] = 0;
  1041f2:	8b 44 24 18          	mov    0x18(%esp),%eax
  1041f6:	c6 44 04 20 00       	movb   $0x0,0x20(%esp,%eax,1)
    while (*str) {
  1041fb:	0f be 44 24 20       	movsbl 0x20(%esp),%eax
  104200:	83 c4 10             	add    $0x10,%esp
  104203:	84 c0                	test   %al,%al
  104205:	74 1f                	je     104226 <vdprintf+0x76>
  104207:	8d 74 24 10          	lea    0x10(%esp),%esi
  10420b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10420f:	90                   	nop
        cons_putc(*str);
  104210:	83 ec 0c             	sub    $0xc,%esp
        str += 1;
  104213:	83 c6 01             	add    $0x1,%esi
        cons_putc(*str);
  104216:	50                   	push   %eax
  104217:	e8 74 c2 ff ff       	call   100490 <cons_putc>
    while (*str) {
  10421c:	0f be 06             	movsbl (%esi),%eax
  10421f:	83 c4 10             	add    $0x10,%esp
  104222:	84 c0                	test   %al,%al
  104224:	75 ea                	jne    104210 <vdprintf+0x60>
    cputs(b.buf);

    return b.cnt;
}
  104226:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10422a:	81 c4 14 02 00 00    	add    $0x214,%esp
  104230:	5b                   	pop    %ebx
  104231:	5e                   	pop    %esi
  104232:	c3                   	ret    
  104233:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10423a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104240 <dprintf>:

int dprintf(const char *fmt, ...)
{
  104240:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    int cnt;

    va_start(ap, fmt);
  104243:	8d 44 24 14          	lea    0x14(%esp),%eax
    cnt = vdprintf(fmt, ap);
  104247:	83 ec 08             	sub    $0x8,%esp
  10424a:	50                   	push   %eax
  10424b:	ff 74 24 1c          	push   0x1c(%esp)
  10424f:	e8 5c ff ff ff       	call   1041b0 <vdprintf>
    va_end(ap);

    return cnt;
}
  104254:	83 c4 1c             	add    $0x1c,%esp
  104257:	c3                   	ret    
  104258:	66 90                	xchg   %ax,%ax
  10425a:	66 90                	xchg   %ax,%ax
  10425c:	66 90                	xchg   %ax,%ax
  10425e:	66 90                	xchg   %ax,%ax

00104260 <printnum>:
 * Print a number (base <= 16) in reverse order,
 * using specified putch function and associated pointer putdat.
 */
static void printnum(putch_t putch, void *putdat, unsigned long long num,
                     unsigned base, int width, int padc)
{
  104260:	e8 de 05 00 00       	call   104843 <__x86.get_pc_thunk.cx>
  104265:	81 c1 9b bd 00 00    	add    $0xbd9b,%ecx
  10426b:	55                   	push   %ebp
  10426c:	57                   	push   %edi
  10426d:	89 d7                	mov    %edx,%edi
  10426f:	56                   	push   %esi
  104270:	89 c6                	mov    %eax,%esi
  104272:	53                   	push   %ebx
  104273:	83 ec 2c             	sub    $0x2c,%esp
  104276:	8b 54 24 44          	mov    0x44(%esp),%edx
  10427a:	8b 44 24 40          	mov    0x40(%esp),%eax
  10427e:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    /* first recursively print all preceding (more significant) digits */
    if (num >= base) {
        printnum(putch, putdat, num / base, base, width - 1, padc);
    } else {
        /* print any needed pad characters before first digit */
        while (--width > 0)
  104282:	8b 4c 24 4c          	mov    0x4c(%esp),%ecx
{
  104286:	8b 5c 24 50          	mov    0x50(%esp),%ebx
    if (num >= base) {
  10428a:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  104291:	00 
{
  104292:	89 54 24 0c          	mov    %edx,0xc(%esp)
  104296:	8b 54 24 48          	mov    0x48(%esp),%edx
  10429a:	89 44 24 08          	mov    %eax,0x8(%esp)
    if (num >= base) {
  10429e:	8b 44 24 0c          	mov    0xc(%esp),%eax
        while (--width > 0)
  1042a2:	8d 69 ff             	lea    -0x1(%ecx),%ebp
    if (num >= base) {
  1042a5:	39 54 24 08          	cmp    %edx,0x8(%esp)
  1042a9:	1b 44 24 14          	sbb    0x14(%esp),%eax
  1042ad:	89 54 24 10          	mov    %edx,0x10(%esp)
  1042b1:	73 55                	jae    104308 <printnum+0xa8>
        while (--width > 0)
  1042b3:	85 ed                	test   %ebp,%ebp
  1042b5:	7e 18                	jle    1042cf <printnum+0x6f>
  1042b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1042be:	66 90                	xchg   %ax,%ax
            putch(padc, putdat);
  1042c0:	83 ec 08             	sub    $0x8,%esp
  1042c3:	57                   	push   %edi
  1042c4:	53                   	push   %ebx
  1042c5:	ff d6                	call   *%esi
        while (--width > 0)
  1042c7:	83 c4 10             	add    $0x10,%esp
  1042ca:	83 ed 01             	sub    $0x1,%ebp
  1042cd:	75 f1                	jne    1042c0 <printnum+0x60>
    }

    // then print this (the least significant) digit
    putch("0123456789abcdef"[num % base], putdat);
  1042cf:	89 7c 24 44          	mov    %edi,0x44(%esp)
  1042d3:	ff 74 24 14          	push   0x14(%esp)
  1042d7:	ff 74 24 14          	push   0x14(%esp)
  1042db:	ff 74 24 14          	push   0x14(%esp)
  1042df:	ff 74 24 14          	push   0x14(%esp)
  1042e3:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
  1042e7:	e8 a4 3e 00 00       	call   108190 <__umoddi3>
  1042ec:	0f be 84 03 26 a2 ff 	movsbl -0x5dda(%ebx,%eax,1),%eax
  1042f3:	ff 
  1042f4:	89 44 24 50          	mov    %eax,0x50(%esp)
}
  1042f8:	83 c4 3c             	add    $0x3c,%esp
    putch("0123456789abcdef"[num % base], putdat);
  1042fb:	89 f0                	mov    %esi,%eax
}
  1042fd:	5b                   	pop    %ebx
  1042fe:	5e                   	pop    %esi
  1042ff:	5f                   	pop    %edi
  104300:	5d                   	pop    %ebp
    putch("0123456789abcdef"[num % base], putdat);
  104301:	ff e0                	jmp    *%eax
  104303:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104307:	90                   	nop
        printnum(putch, putdat, num / base, base, width - 1, padc);
  104308:	83 ec 0c             	sub    $0xc,%esp
  10430b:	53                   	push   %ebx
  10430c:	55                   	push   %ebp
  10430d:	52                   	push   %edx
  10430e:	83 ec 08             	sub    $0x8,%esp
  104311:	ff 74 24 34          	push   0x34(%esp)
  104315:	ff 74 24 34          	push   0x34(%esp)
  104319:	ff 74 24 34          	push   0x34(%esp)
  10431d:	ff 74 24 34          	push   0x34(%esp)
  104321:	8b 5c 24 4c          	mov    0x4c(%esp),%ebx
  104325:	e8 46 3d 00 00       	call   108070 <__udivdi3>
  10432a:	83 c4 18             	add    $0x18,%esp
  10432d:	52                   	push   %edx
  10432e:	89 fa                	mov    %edi,%edx
  104330:	50                   	push   %eax
  104331:	89 f0                	mov    %esi,%eax
  104333:	e8 28 ff ff ff       	call   104260 <printnum>
  104338:	83 c4 20             	add    $0x20,%esp
  10433b:	eb 92                	jmp    1042cf <printnum+0x6f>
  10433d:	8d 76 00             	lea    0x0(%esi),%esi

00104340 <vprintfmt>:
    else
        return va_arg(*ap, int);
}

void vprintfmt(putch_t putch, void *putdat, const char *fmt, va_list ap)
{
  104340:	e8 3c c0 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  104345:	05 bb bc 00 00       	add    $0xbcbb,%eax
  10434a:	55                   	push   %ebp
  10434b:	57                   	push   %edi
  10434c:	56                   	push   %esi
  10434d:	53                   	push   %ebx
  10434e:	83 ec 3c             	sub    $0x3c,%esp
  104351:	8b 74 24 50          	mov    0x50(%esp),%esi
  104355:	8b 6c 24 54          	mov    0x54(%esp),%ebp
  104359:	89 44 24 14          	mov    %eax,0x14(%esp)
        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL)
                p = "(null)";
            if (width > 0 && padc != '-')
                for (width -= strnlen(p, precision); width > 0; width--)
  10435d:	8d 80 37 a2 ff ff    	lea    -0x5dc9(%eax),%eax
  104363:	89 44 24 24          	mov    %eax,0x24(%esp)
{
  104367:	8b 7c 24 58          	mov    0x58(%esp),%edi
        while ((ch = *(unsigned char *) fmt++) != '%') {
  10436b:	0f b6 07             	movzbl (%edi),%eax
  10436e:	8d 5f 01             	lea    0x1(%edi),%ebx
  104371:	83 f8 25             	cmp    $0x25,%eax
  104374:	75 20                	jne    104396 <vprintfmt+0x56>
  104376:	eb 30                	jmp    1043a8 <vprintfmt+0x68>
  104378:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10437f:	90                   	nop
            putch(ch, putdat);
  104380:	83 ec 08             	sub    $0x8,%esp
        while ((ch = *(unsigned char *) fmt++) != '%') {
  104383:	83 c3 01             	add    $0x1,%ebx
            putch(ch, putdat);
  104386:	55                   	push   %ebp
  104387:	50                   	push   %eax
  104388:	ff d6                	call   *%esi
        while ((ch = *(unsigned char *) fmt++) != '%') {
  10438a:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
  10438e:	83 c4 10             	add    $0x10,%esp
  104391:	83 f8 25             	cmp    $0x25,%eax
  104394:	74 12                	je     1043a8 <vprintfmt+0x68>
            if (ch == '\0')
  104396:	85 c0                	test   %eax,%eax
  104398:	75 e6                	jne    104380 <vprintfmt+0x40>
            for (fmt--; fmt[-1] != '%'; fmt--)
                /* do nothing */ ;
            break;
        }
    }
}
  10439a:	83 c4 3c             	add    $0x3c,%esp
  10439d:	5b                   	pop    %ebx
  10439e:	5e                   	pop    %esi
  10439f:	5f                   	pop    %edi
  1043a0:	5d                   	pop    %ebp
  1043a1:	c3                   	ret    
  1043a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        precision = -1;
  1043a8:	ba ff ff ff ff       	mov    $0xffffffff,%edx
        padc = ' ';
  1043ad:	c6 44 24 18 20       	movb   $0x20,0x18(%esp)
        altflag = 0;
  1043b2:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1043b9:	00 
        width = -1;
  1043ba:	c7 44 24 10 ff ff ff 	movl   $0xffffffff,0x10(%esp)
  1043c1:	ff 
        lflag = 0;
  1043c2:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%esp)
  1043c9:	00 
  1043ca:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  1043ce:	89 74 24 50          	mov    %esi,0x50(%esp)
        switch (ch = *(unsigned char *) fmt++) {
  1043d2:	0f b6 0b             	movzbl (%ebx),%ecx
  1043d5:	8d 7b 01             	lea    0x1(%ebx),%edi
  1043d8:	8d 41 dd             	lea    -0x23(%ecx),%eax
  1043db:	3c 55                	cmp    $0x55,%al
  1043dd:	77 19                	ja     1043f8 <.L18>
  1043df:	8b 54 24 14          	mov    0x14(%esp),%edx
  1043e3:	0f b6 c0             	movzbl %al,%eax
  1043e6:	8b b4 82 40 a2 ff ff 	mov    -0x5dc0(%edx,%eax,4),%esi
  1043ed:	01 d6                	add    %edx,%esi
  1043ef:	ff e6                	jmp    *%esi
  1043f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001043f8 <.L18>:
            putch('%', putdat);
  1043f8:	8b 74 24 50          	mov    0x50(%esp),%esi
  1043fc:	83 ec 08             	sub    $0x8,%esp
            for (fmt--; fmt[-1] != '%'; fmt--)
  1043ff:	89 df                	mov    %ebx,%edi
            putch('%', putdat);
  104401:	55                   	push   %ebp
  104402:	6a 25                	push   $0x25
  104404:	ff d6                	call   *%esi
            for (fmt--; fmt[-1] != '%'; fmt--)
  104406:	83 c4 10             	add    $0x10,%esp
  104409:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
  10440d:	0f 84 58 ff ff ff    	je     10436b <vprintfmt+0x2b>
  104413:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104417:	90                   	nop
  104418:	83 ef 01             	sub    $0x1,%edi
  10441b:	80 7f ff 25          	cmpb   $0x25,-0x1(%edi)
  10441f:	75 f7                	jne    104418 <.L18+0x20>
  104421:	e9 45 ff ff ff       	jmp    10436b <vprintfmt+0x2b>
  104426:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10442d:	8d 76 00             	lea    0x0(%esi),%esi

00104430 <.L27>:
                ch = *fmt;
  104430:	0f be 43 01          	movsbl 0x1(%ebx),%eax
                precision = precision * 10 + ch - '0';
  104434:	8d 51 d0             	lea    -0x30(%ecx),%edx
        switch (ch = *(unsigned char *) fmt++) {
  104437:	89 fb                	mov    %edi,%ebx
                precision = precision * 10 + ch - '0';
  104439:	89 54 24 1c          	mov    %edx,0x1c(%esp)
                if (ch < '0' || ch > '9')
  10443d:	8d 48 d0             	lea    -0x30(%eax),%ecx
  104440:	83 f9 09             	cmp    $0x9,%ecx
  104443:	77 28                	ja     10446d <.L27+0x3d>
        switch (ch = *(unsigned char *) fmt++) {
  104445:	8b 74 24 50          	mov    0x50(%esp),%esi
  104449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            for (precision = 0;; ++fmt) {
  104450:	83 c3 01             	add    $0x1,%ebx
                precision = precision * 10 + ch - '0';
  104453:	8d 14 92             	lea    (%edx,%edx,4),%edx
  104456:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
                ch = *fmt;
  10445a:	0f be 03             	movsbl (%ebx),%eax
                if (ch < '0' || ch > '9')
  10445d:	8d 48 d0             	lea    -0x30(%eax),%ecx
  104460:	83 f9 09             	cmp    $0x9,%ecx
  104463:	76 eb                	jbe    104450 <.L27+0x20>
  104465:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  104469:	89 74 24 50          	mov    %esi,0x50(%esp)
            if (width < 0)
  10446d:	8b 74 24 10          	mov    0x10(%esp),%esi
  104471:	85 f6                	test   %esi,%esi
  104473:	0f 89 59 ff ff ff    	jns    1043d2 <vprintfmt+0x92>
                width = precision, precision = -1;
  104479:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  10447d:	c7 44 24 1c ff ff ff 	movl   $0xffffffff,0x1c(%esp)
  104484:	ff 
  104485:	89 44 24 10          	mov    %eax,0x10(%esp)
  104489:	e9 44 ff ff ff       	jmp    1043d2 <vprintfmt+0x92>

0010448e <.L23>:
            putch('0', putdat);
  10448e:	8b 74 24 50          	mov    0x50(%esp),%esi
  104492:	83 ec 08             	sub    $0x8,%esp
  104495:	55                   	push   %ebp
  104496:	6a 30                	push   $0x30
  104498:	ff d6                	call   *%esi
            putch('x', putdat);
  10449a:	59                   	pop    %ecx
  10449b:	5b                   	pop    %ebx
  10449c:	55                   	push   %ebp
  10449d:	6a 78                	push   $0x78
            num = (unsigned long long) (uintptr_t) va_arg(ap, void *);
  10449f:	31 db                	xor    %ebx,%ebx
            putch('x', putdat);
  1044a1:	ff d6                	call   *%esi
            num = (unsigned long long) (uintptr_t) va_arg(ap, void *);
  1044a3:	8b 44 24 6c          	mov    0x6c(%esp),%eax
            goto number;
  1044a7:	ba 10 00 00 00       	mov    $0x10,%edx
            num = (unsigned long long) (uintptr_t) va_arg(ap, void *);
  1044ac:	8b 08                	mov    (%eax),%ecx
            goto number;
  1044ae:	83 c4 10             	add    $0x10,%esp
            num = (unsigned long long) (uintptr_t) va_arg(ap, void *);
  1044b1:	83 c0 04             	add    $0x4,%eax
  1044b4:	89 44 24 5c          	mov    %eax,0x5c(%esp)
            printnum(putch, putdat, num, base, width, padc);
  1044b8:	83 ec 0c             	sub    $0xc,%esp
  1044bb:	0f be 44 24 24       	movsbl 0x24(%esp),%eax
  1044c0:	50                   	push   %eax
  1044c1:	89 f0                	mov    %esi,%eax
  1044c3:	ff 74 24 20          	push   0x20(%esp)
  1044c7:	52                   	push   %edx
  1044c8:	89 ea                	mov    %ebp,%edx
  1044ca:	53                   	push   %ebx
  1044cb:	51                   	push   %ecx
  1044cc:	e8 8f fd ff ff       	call   104260 <printnum>
            break;
  1044d1:	83 c4 20             	add    $0x20,%esp
  1044d4:	e9 92 fe ff ff       	jmp    10436b <vprintfmt+0x2b>

001044d9 <.L32>:
            altflag = 1;
  1044d9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  1044e0:	00 
        switch (ch = *(unsigned char *) fmt++) {
  1044e1:	89 fb                	mov    %edi,%ebx
            goto reswitch;
  1044e3:	e9 ea fe ff ff       	jmp    1043d2 <vprintfmt+0x92>

001044e8 <.L31>:
            putch(ch, putdat);
  1044e8:	8b 74 24 50          	mov    0x50(%esp),%esi
  1044ec:	83 ec 08             	sub    $0x8,%esp
  1044ef:	55                   	push   %ebp
  1044f0:	6a 25                	push   $0x25
  1044f2:	ff d6                	call   *%esi
            break;
  1044f4:	83 c4 10             	add    $0x10,%esp
  1044f7:	e9 6f fe ff ff       	jmp    10436b <vprintfmt+0x2b>

001044fc <.L30>:
            precision = va_arg(ap, int);
  1044fc:	8b 44 24 5c          	mov    0x5c(%esp),%eax
        switch (ch = *(unsigned char *) fmt++) {
  104500:	89 fb                	mov    %edi,%ebx
            precision = va_arg(ap, int);
  104502:	8b 00                	mov    (%eax),%eax
  104504:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  104508:	8b 44 24 5c          	mov    0x5c(%esp),%eax
  10450c:	83 c0 04             	add    $0x4,%eax
  10450f:	89 44 24 5c          	mov    %eax,0x5c(%esp)
            goto process_precision;
  104513:	e9 55 ff ff ff       	jmp    10446d <.L27+0x3d>

00104518 <.L29>:
            if (width < 0)
  104518:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  10451c:	31 c0                	xor    %eax,%eax
        switch (ch = *(unsigned char *) fmt++) {
  10451e:	89 fb                	mov    %edi,%ebx
  104520:	85 c9                	test   %ecx,%ecx
  104522:	0f 49 c1             	cmovns %ecx,%eax
  104525:	89 44 24 10          	mov    %eax,0x10(%esp)
            goto reswitch;
  104529:	e9 a4 fe ff ff       	jmp    1043d2 <vprintfmt+0x92>

0010452e <.L22>:
            if ((p = va_arg(ap, char *)) == NULL)
  10452e:	8b 44 24 5c          	mov    0x5c(%esp),%eax
            if (width > 0 && padc != '-')
  104532:	8b 5c 24 10          	mov    0x10(%esp),%ebx
            if ((p = va_arg(ap, char *)) == NULL)
  104536:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  10453a:	8b 74 24 50          	mov    0x50(%esp),%esi
  10453e:	83 c0 04             	add    $0x4,%eax
            if (width > 0 && padc != '-')
  104541:	85 db                	test   %ebx,%ebx
            if ((p = va_arg(ap, char *)) == NULL)
  104543:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  104547:	8b 44 24 5c          	mov    0x5c(%esp),%eax
  10454b:	8b 08                	mov    (%eax),%ecx
            if (width > 0 && padc != '-')
  10454d:	0f 9f c0             	setg   %al
  104550:	80 7c 24 18 2d       	cmpb   $0x2d,0x18(%esp)
  104555:	0f 95 c3             	setne  %bl
  104558:	21 d8                	and    %ebx,%eax
            if ((p = va_arg(ap, char *)) == NULL)
  10455a:	85 c9                	test   %ecx,%ecx
  10455c:	0f 84 e4 01 00 00    	je     104746 <.L28+0xc>
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  104562:	8d 59 01             	lea    0x1(%ecx),%ebx
  104565:	89 5c 24 20          	mov    %ebx,0x20(%esp)
            if (width > 0 && padc != '-')
  104569:	84 c0                	test   %al,%al
  10456b:	0f 85 04 02 00 00    	jne    104775 <.L28+0x3b>
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  104571:	0f be 09             	movsbl (%ecx),%ecx
  104574:	89 c8                	mov    %ecx,%eax
  104576:	85 c9                	test   %ecx,%ecx
  104578:	0f 84 24 01 00 00    	je     1046a2 <.L24+0x18>
  10457e:	89 74 24 50          	mov    %esi,0x50(%esp)
  104582:	89 d6                	mov    %edx,%esi
  104584:	89 7c 24 58          	mov    %edi,0x58(%esp)
  104588:	8b 7c 24 10          	mov    0x10(%esp),%edi
  10458c:	eb 2b                	jmp    1045b9 <.L22+0x8b>
  10458e:	66 90                	xchg   %ax,%ax
                if (altflag && (ch < ' ' || ch > '~'))
  104590:	83 e8 20             	sub    $0x20,%eax
  104593:	83 f8 5e             	cmp    $0x5e,%eax
  104596:	76 36                	jbe    1045ce <.L22+0xa0>
                    putch('?', putdat);
  104598:	83 ec 08             	sub    $0x8,%esp
  10459b:	55                   	push   %ebp
  10459c:	6a 3f                	push   $0x3f
  10459e:	ff 54 24 60          	call   *0x60(%esp)
  1045a2:	83 c4 10             	add    $0x10,%esp
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  1045a5:	0f be 03             	movsbl (%ebx),%eax
  1045a8:	83 c3 01             	add    $0x1,%ebx
                 width--)
  1045ab:	83 ef 01             	sub    $0x1,%edi
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  1045ae:	0f be c8             	movsbl %al,%ecx
  1045b1:	85 c9                	test   %ecx,%ecx
  1045b3:	0f 84 dd 00 00 00    	je     104696 <.L24+0xc>
  1045b9:	85 f6                	test   %esi,%esi
  1045bb:	78 09                	js     1045c6 <.L22+0x98>
  1045bd:	83 ee 01             	sub    $0x1,%esi
  1045c0:	0f 82 d0 00 00 00    	jb     104696 <.L24+0xc>
                if (altflag && (ch < ' ' || ch > '~'))
  1045c6:	8b 54 24 08          	mov    0x8(%esp),%edx
  1045ca:	85 d2                	test   %edx,%edx
  1045cc:	75 c2                	jne    104590 <.L22+0x62>
                    putch(ch, putdat);
  1045ce:	83 ec 08             	sub    $0x8,%esp
  1045d1:	55                   	push   %ebp
  1045d2:	51                   	push   %ecx
  1045d3:	ff 54 24 60          	call   *0x60(%esp)
  1045d7:	83 c4 10             	add    $0x10,%esp
  1045da:	eb c9                	jmp    1045a5 <.L22+0x77>

001045dc <.L21>:
    if (lflag >= 2)
  1045dc:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
  1045e1:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, unsigned long long);
  1045e5:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
  1045e9:	0f 8f de 00 00 00    	jg     1046cd <.L24+0x43>
        return va_arg(*ap, unsigned long);
  1045ef:	8b 4c 24 5c          	mov    0x5c(%esp),%ecx
            precision = va_arg(ap, int);
  1045f3:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
  1045f6:	31 db                	xor    %ebx,%ebx
  1045f8:	ba 0a 00 00 00       	mov    $0xa,%edx
  1045fd:	8b 09                	mov    (%ecx),%ecx
  1045ff:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  104603:	e9 b0 fe ff ff       	jmp    1044b8 <.L23+0x2a>

00104608 <.L19>:
    if (lflag >= 2)
  104608:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
  10460d:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, unsigned long long);
  104611:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
  104615:	0f 8f c0 00 00 00    	jg     1046db <.L24+0x51>
        return va_arg(*ap, unsigned long);
  10461b:	8b 4c 24 5c          	mov    0x5c(%esp),%ecx
            precision = va_arg(ap, int);
  10461f:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
  104622:	31 db                	xor    %ebx,%ebx
  104624:	ba 10 00 00 00       	mov    $0x10,%edx
  104629:	8b 09                	mov    (%ecx),%ecx
  10462b:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  10462f:	e9 84 fe ff ff       	jmp    1044b8 <.L23+0x2a>

00104634 <.L26>:
            putch(va_arg(ap, int), putdat);
  104634:	8b 44 24 5c          	mov    0x5c(%esp),%eax
  104638:	8b 74 24 50          	mov    0x50(%esp),%esi
  10463c:	83 ec 08             	sub    $0x8,%esp
  10463f:	55                   	push   %ebp
  104640:	8d 58 04             	lea    0x4(%eax),%ebx
  104643:	8b 44 24 68          	mov    0x68(%esp),%eax
  104647:	ff 30                	push   (%eax)
  104649:	ff d6                	call   *%esi
  10464b:	89 5c 24 6c          	mov    %ebx,0x6c(%esp)
            break;
  10464f:	83 c4 10             	add    $0x10,%esp
  104652:	e9 14 fd ff ff       	jmp    10436b <vprintfmt+0x2b>

00104657 <.L25>:
    if (lflag >= 2)
  104657:	83 7c 24 20 01       	cmpl   $0x1,0x20(%esp)
  10465c:	8b 74 24 50          	mov    0x50(%esp),%esi
        return va_arg(*ap, long long);
  104660:	8b 44 24 5c          	mov    0x5c(%esp),%eax
    if (lflag >= 2)
  104664:	0f 8f 87 00 00 00    	jg     1046f1 <.L24+0x67>
        return va_arg(*ap, long);
  10466a:	8b 00                	mov    (%eax),%eax
            precision = va_arg(ap, int);
  10466c:	83 44 24 5c 04       	addl   $0x4,0x5c(%esp)
        return va_arg(*ap, long);
  104671:	89 c3                	mov    %eax,%ebx
  104673:	89 c1                	mov    %eax,%ecx
  104675:	c1 fb 1f             	sar    $0x1f,%ebx
            if ((long long) num < 0) {
  104678:	85 db                	test   %ebx,%ebx
  10467a:	0f 88 82 00 00 00    	js     104702 <.L24+0x78>
        return va_arg(*ap, unsigned long long);
  104680:	ba 0a 00 00 00       	mov    $0xa,%edx
  104685:	e9 2e fe ff ff       	jmp    1044b8 <.L23+0x2a>

0010468a <.L24>:
            lflag++;
  10468a:	83 44 24 20 01       	addl   $0x1,0x20(%esp)
        switch (ch = *(unsigned char *) fmt++) {
  10468f:	89 fb                	mov    %edi,%ebx
            goto reswitch;
  104691:	e9 3c fd ff ff       	jmp    1043d2 <vprintfmt+0x92>
  104696:	89 7c 24 10          	mov    %edi,0x10(%esp)
  10469a:	8b 74 24 50          	mov    0x50(%esp),%esi
  10469e:	8b 7c 24 58          	mov    0x58(%esp),%edi
            for (; width > 0; width--)
  1046a2:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  1046a6:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1046aa:	85 c9                	test   %ecx,%ecx
  1046ac:	7e 12                	jle    1046c0 <.L24+0x36>
  1046ae:	66 90                	xchg   %ax,%ax
                putch(' ', putdat);
  1046b0:	83 ec 08             	sub    $0x8,%esp
  1046b3:	55                   	push   %ebp
  1046b4:	6a 20                	push   $0x20
  1046b6:	ff d6                	call   *%esi
            for (; width > 0; width--)
  1046b8:	83 c4 10             	add    $0x10,%esp
  1046bb:	83 eb 01             	sub    $0x1,%ebx
  1046be:	75 f0                	jne    1046b0 <.L24+0x26>
            if ((p = va_arg(ap, char *)) == NULL)
  1046c0:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  1046c4:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  1046c8:	e9 9e fc ff ff       	jmp    10436b <vprintfmt+0x2b>
        return va_arg(*ap, unsigned long long);
  1046cd:	8b 08                	mov    (%eax),%ecx
  1046cf:	8b 58 04             	mov    0x4(%eax),%ebx
  1046d2:	83 c0 08             	add    $0x8,%eax
  1046d5:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  1046d9:	eb a5                	jmp    104680 <.L25+0x29>
  1046db:	8b 08                	mov    (%eax),%ecx
  1046dd:	8b 58 04             	mov    0x4(%eax),%ebx
  1046e0:	83 c0 08             	add    $0x8,%eax
  1046e3:	ba 10 00 00 00       	mov    $0x10,%edx
  1046e8:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  1046ec:	e9 c7 fd ff ff       	jmp    1044b8 <.L23+0x2a>
        return va_arg(*ap, long long);
  1046f1:	8b 08                	mov    (%eax),%ecx
  1046f3:	8b 58 04             	mov    0x4(%eax),%ebx
  1046f6:	83 c0 08             	add    $0x8,%eax
  1046f9:	89 44 24 5c          	mov    %eax,0x5c(%esp)
  1046fd:	e9 76 ff ff ff       	jmp    104678 <.L25+0x21>
  104702:	89 4c 24 08          	mov    %ecx,0x8(%esp)
                putch('-', putdat);
  104706:	83 ec 08             	sub    $0x8,%esp
  104709:	89 5c 24 14          	mov    %ebx,0x14(%esp)
  10470d:	55                   	push   %ebp
  10470e:	6a 2d                	push   $0x2d
  104710:	ff d6                	call   *%esi
                num = -(long long) num;
  104712:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  104716:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  10471a:	ba 0a 00 00 00       	mov    $0xa,%edx
  10471f:	f7 d9                	neg    %ecx
  104721:	83 d3 00             	adc    $0x0,%ebx
  104724:	83 c4 10             	add    $0x10,%esp
  104727:	f7 db                	neg    %ebx
  104729:	e9 8a fd ff ff       	jmp    1044b8 <.L23+0x2a>

0010472e <.L58>:
            padc = '-';
  10472e:	c6 44 24 18 2d       	movb   $0x2d,0x18(%esp)
        switch (ch = *(unsigned char *) fmt++) {
  104733:	89 fb                	mov    %edi,%ebx
  104735:	e9 98 fc ff ff       	jmp    1043d2 <vprintfmt+0x92>

0010473a <.L28>:
  10473a:	c6 44 24 18 30       	movb   $0x30,0x18(%esp)
  10473f:	89 fb                	mov    %edi,%ebx
  104741:	e9 8c fc ff ff       	jmp    1043d2 <vprintfmt+0x92>
            if (width > 0 && padc != '-')
  104746:	84 c0                	test   %al,%al
  104748:	0f 85 9f 00 00 00    	jne    1047ed <.L28+0xb3>
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  10474e:	8b 44 24 14          	mov    0x14(%esp),%eax
  104752:	89 74 24 50          	mov    %esi,0x50(%esp)
  104756:	b9 28 00 00 00       	mov    $0x28,%ecx
  10475b:	89 d6                	mov    %edx,%esi
  10475d:	89 7c 24 58          	mov    %edi,0x58(%esp)
  104761:	8b 7c 24 10          	mov    0x10(%esp),%edi
  104765:	8d 98 38 a2 ff ff    	lea    -0x5dc8(%eax),%ebx
  10476b:	b8 28 00 00 00       	mov    $0x28,%eax
  104770:	e9 44 fe ff ff       	jmp    1045b9 <.L22+0x8b>
                for (width -= strnlen(p, precision); width > 0; width--)
  104775:	83 ec 08             	sub    $0x8,%esp
  104778:	52                   	push   %edx
  104779:	89 54 24 38          	mov    %edx,0x38(%esp)
  10477d:	51                   	push   %ecx
  10477e:	8b 5c 24 24          	mov    0x24(%esp),%ebx
  104782:	89 4c 24 38          	mov    %ecx,0x38(%esp)
  104786:	e8 e5 f6 ff ff       	call   103e70 <strnlen>
  10478b:	29 44 24 20          	sub    %eax,0x20(%esp)
  10478f:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  104793:	83 c4 10             	add    $0x10,%esp
  104796:	8b 54 24 2c          	mov    0x2c(%esp),%edx
  10479a:	85 c9                	test   %ecx,%ecx
  10479c:	8b 4c 24 28          	mov    0x28(%esp),%ecx
  1047a0:	7e 34                	jle    1047d6 <.L28+0x9c>
                    putch(padc, putdat);
  1047a2:	0f be 5c 24 18       	movsbl 0x18(%esp),%ebx
  1047a7:	89 4c 24 28          	mov    %ecx,0x28(%esp)
  1047ab:	89 54 24 18          	mov    %edx,0x18(%esp)
  1047af:	89 7c 24 58          	mov    %edi,0x58(%esp)
  1047b3:	8b 7c 24 10          	mov    0x10(%esp),%edi
  1047b7:	83 ec 08             	sub    $0x8,%esp
  1047ba:	55                   	push   %ebp
  1047bb:	53                   	push   %ebx
  1047bc:	ff d6                	call   *%esi
                for (width -= strnlen(p, precision); width > 0; width--)
  1047be:	83 c4 10             	add    $0x10,%esp
  1047c1:	83 ef 01             	sub    $0x1,%edi
  1047c4:	75 f1                	jne    1047b7 <.L28+0x7d>
  1047c6:	8b 54 24 18          	mov    0x18(%esp),%edx
  1047ca:	8b 4c 24 28          	mov    0x28(%esp),%ecx
  1047ce:	89 7c 24 10          	mov    %edi,0x10(%esp)
  1047d2:	8b 7c 24 58          	mov    0x58(%esp),%edi
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  1047d6:	0f be 01             	movsbl (%ecx),%eax
  1047d9:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  1047dd:	0f be c8             	movsbl %al,%ecx
  1047e0:	85 c9                	test   %ecx,%ecx
  1047e2:	0f 85 96 fd ff ff    	jne    10457e <.L22+0x50>
  1047e8:	e9 d3 fe ff ff       	jmp    1046c0 <.L24+0x36>
                for (width -= strnlen(p, precision); width > 0; width--)
  1047ed:	83 ec 08             	sub    $0x8,%esp
  1047f0:	52                   	push   %edx
  1047f1:	89 54 24 34          	mov    %edx,0x34(%esp)
  1047f5:	ff 74 24 30          	push   0x30(%esp)
  1047f9:	8b 5c 24 24          	mov    0x24(%esp),%ebx
  1047fd:	e8 6e f6 ff ff       	call   103e70 <strnlen>
  104802:	29 44 24 20          	sub    %eax,0x20(%esp)
  104806:	8b 44 24 20          	mov    0x20(%esp),%eax
  10480a:	83 c4 10             	add    $0x10,%esp
                p = "(null)";
  10480d:	8b 54 24 24          	mov    0x24(%esp),%edx
  104811:	89 d1                	mov    %edx,%ecx
  104813:	83 c2 01             	add    $0x1,%edx
                for (width -= strnlen(p, precision); width > 0; width--)
  104816:	85 c0                	test   %eax,%eax
  104818:	89 54 24 20          	mov    %edx,0x20(%esp)
  10481c:	8b 54 24 28          	mov    0x28(%esp),%edx
  104820:	7f 80                	jg     1047a2 <.L28+0x68>
  104822:	89 74 24 50          	mov    %esi,0x50(%esp)
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  104826:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  10482a:	b9 28 00 00 00       	mov    $0x28,%ecx
  10482f:	89 d6                	mov    %edx,%esi
  104831:	89 7c 24 58          	mov    %edi,0x58(%esp)
  104835:	b8 28 00 00 00       	mov    $0x28,%eax
  10483a:	8b 7c 24 10          	mov    0x10(%esp),%edi
  10483e:	e9 76 fd ff ff       	jmp    1045b9 <.L22+0x8b>

00104843 <__x86.get_pc_thunk.cx>:
  104843:	8b 0c 24             	mov    (%esp),%ecx
  104846:	c3                   	ret    
  104847:	66 90                	xchg   %ax,%ax
  104849:	66 90                	xchg   %ax,%ax
  10484b:	66 90                	xchg   %ax,%ax
  10484d:	66 90                	xchg   %ax,%ax
  10484f:	90                   	nop

00104850 <kstack_switch>:
#include "seg.h"

#define offsetof(type, member) __builtin_offsetof(type, member)

void kstack_switch(uint32_t pid)
{
  104850:	56                   	push   %esi
  104851:	53                   	push   %ebx
  104852:	e8 32 bb ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  104857:	81 c3 a9 b7 00 00    	add    $0xb7a9,%ebx
  10485d:	83 ec 04             	sub    $0x4,%esp
    int cpu_idx = get_pcpu_idx();
  104860:	e8 db 11 00 00       	call   105a40 <get_pcpu_idx>
    struct kstack *ks = (struct kstack *) get_pcpu_kstack_pointer(cpu_idx);
  104865:	83 ec 0c             	sub    $0xc,%esp
  104868:	50                   	push   %eax
  104869:	e8 32 12 00 00       	call   105aa0 <get_pcpu_kstack_pointer>

    /*
     * Switch to the new TSS.
     */
    ks->tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  10486e:	8b 74 24 20          	mov    0x20(%esp),%esi
  104872:	c7 c1 00 90 13 00    	mov    $0x139000,%ecx
  104878:	8d 56 01             	lea    0x1(%esi),%edx
  10487b:	c1 e2 0c             	shl    $0xc,%edx
  10487e:	8d 34 0a             	lea    (%edx,%ecx,1),%esi
    ks->tss.ts_ss0 = CPU_GDT_KDATA;
    ks->gdt[CPU_GDT_TSS >> 3] =
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  104881:	8d 94 0a 30 f0 ff ff 	lea    -0xfd0(%edx,%ecx,1),%edx
    ks->gdt[CPU_GDT_TSS >> 3] =
  104888:	b9 eb 00 00 00       	mov    $0xeb,%ecx
    ks->tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  10488d:	89 70 34             	mov    %esi,0x34(%eax)
    ks->tss.ts_ss0 = CPU_GDT_KDATA;
  104890:	be 10 00 00 00       	mov    $0x10,%esi
    ks->gdt[CPU_GDT_TSS >> 3] =
  104895:	66 89 48 28          	mov    %cx,0x28(%eax)
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  104899:	89 d1                	mov    %edx,%ecx
    ks->tss.ts_ss0 = CPU_GDT_KDATA;
  10489b:	66 89 70 38          	mov    %si,0x38(%eax)
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  10489f:	c1 e9 10             	shr    $0x10,%ecx
    ks->gdt[CPU_GDT_TSS >> 3] =
  1048a2:	be 89 40 00 00       	mov    $0x4089,%esi
  1048a7:	66 89 50 2a          	mov    %dx,0x2a(%eax)
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  1048ab:	c1 ea 18             	shr    $0x18,%edx
    ks->gdt[CPU_GDT_TSS >> 3] =
  1048ae:	66 89 70 2d          	mov    %si,0x2d(%eax)
  1048b2:	88 48 2c             	mov    %cl,0x2c(%eax)
  1048b5:	88 50 2f             	mov    %dl,0x2f(%eax)
    ks->gdt[CPU_GDT_TSS >> 3].sd_s = 0;
    ltr(CPU_GDT_TSS);
  1048b8:	c7 04 24 28 00 00 00 	movl   $0x28,(%esp)
  1048bf:	e8 cc 04 00 00       	call   104d90 <ltr>
}
  1048c4:	83 c4 14             	add    $0x14,%esp
  1048c7:	5b                   	pop    %ebx
  1048c8:	5e                   	pop    %esi
  1048c9:	c3                   	ret    
  1048ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001048d0 <seg_init>:

void seg_init(int cpu_idx)
{
  1048d0:	55                   	push   %ebp
  1048d1:	57                   	push   %edi
  1048d2:	56                   	push   %esi
  1048d3:	53                   	push   %ebx
  1048d4:	e8 b0 ba ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1048d9:	81 c3 27 b7 00 00    	add    $0xb727,%ebx
  1048df:	83 ec 2c             	sub    $0x2c,%esp
  1048e2:	8b 7c 24 40          	mov    0x40(%esp),%edi
  1048e6:	c7 c6 00 90 17 00    	mov    $0x179000,%esi
    /* clear BSS */
    if (cpu_idx == 0) {
  1048ec:	85 ff                	test   %edi,%edi
  1048ee:	0f 84 1c 01 00 00    	je     104a10 <seg_init+0x140>
    /* 0x20: user data */
    bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
        SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

    /* setup TSS */
    bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  1048f4:	8d 57 01             	lea    0x1(%edi),%edx
  1048f7:	89 f8                	mov    %edi,%eax
    bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  1048f9:	bd eb 00 00 00       	mov    $0xeb,%ebp
  1048fe:	c1 e2 0c             	shl    $0xc,%edx
    bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  104901:	c1 e0 0c             	shl    $0xc,%eax
  104904:	01 f0                	add    %esi,%eax
  104906:	8d 0c 16             	lea    (%esi,%edx,1),%ecx
        SEGDESC16(STS_T32A, (uint32_t) &bsp_kstack[cpu_idx].tss, sizeof(tss_t) - 1, 0);
  104909:	89 54 24 0c          	mov    %edx,0xc(%esp)
    bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  10490d:	89 48 34             	mov    %ecx,0x34(%eax)
    bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  104910:	b9 10 00 00 00       	mov    $0x10,%ecx
  104915:	66 89 48 38          	mov    %cx,0x38(%eax)
        SEGDESC16(STS_T32A, (uint32_t) &bsp_kstack[cpu_idx].tss, sizeof(tss_t) - 1, 0);
  104919:	8d 8c 16 30 f0 ff ff 	lea    -0xfd0(%esi,%edx,1),%ecx
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  104920:	66 89 68 28          	mov    %bp,0x28(%eax)
        SEGDESC16(STS_T32A, (uint32_t) &bsp_kstack[cpu_idx].tss, sizeof(tss_t) - 1, 0);
  104924:	89 cd                	mov    %ecx,%ebp
  104926:	c1 ed 10             	shr    $0x10,%ebp
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  104929:	66 89 48 2a          	mov    %cx,0x2a(%eax)
        SEGDESC16(STS_T32A, (uint32_t) &bsp_kstack[cpu_idx].tss, sizeof(tss_t) - 1, 0);
  10492d:	c1 e9 18             	shr    $0x18,%ecx
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  104930:	89 ea                	mov    %ebp,%edx
    bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  104932:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  104938:	88 50 2c             	mov    %dl,0x2c(%eax)
  10493b:	8b 68 2c             	mov    0x2c(%eax),%ebp
    /* Set the KSTACK_MAGIC value when we initialize the kstack */
    bsp_kstack[cpu_idx].magic = KSTACK_MAGIC;

    pseudodesc_t gdt_desc = {
        .pd_lim   = sizeof(bsp_kstack[cpu_idx].gdt) - 1,
        .pd_base  = (uint32_t) bsp_kstack[cpu_idx].gdt
  10493e:	8b 54 24 0c          	mov    0xc(%esp),%edx
    bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  104942:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  104949:	81 e5 ff 10 c0 ff    	and    $0xffc010ff,%ebp
    bsp_kstack[cpu_idx].gdt[CPU_GDT_KCODE >> 3] =
  10494f:	c7 40 08 ff ff 00 00 	movl   $0xffff,0x8(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  104956:	81 cd 00 89 00 00    	or     $0x8900,%ebp
    bsp_kstack[cpu_idx].gdt[CPU_GDT_KCODE >> 3] =
  10495c:	c7 40 0c 00 9a cf 00 	movl   $0xcf9a00,0xc(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  104963:	89 68 2c             	mov    %ebp,0x2c(%eax)
  104966:	88 48 2f             	mov    %cl,0x2f(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3].sd_s = 0;
  104969:	8b 48 2c             	mov    0x2c(%eax),%ecx
    bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
  10496c:	c7 40 10 ff ff 00 00 	movl   $0xffff,0x10(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3].sd_s = 0;
  104973:	81 e1 ff ef 3f ff    	and    $0xff3fefff,%ecx
    bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
  104979:	c7 40 14 00 92 cf 00 	movl   $0xcf9200,0x14(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3].sd_s = 0;
  104980:	81 c9 00 00 40 00    	or     $0x400000,%ecx
    bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
  104986:	c7 40 18 ff ff 00 00 	movl   $0xffff,0x18(%eax)
  10498d:	c7 40 1c 00 fa cf 00 	movl   $0xcffa00,0x1c(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
  104994:	c7 40 20 ff ff 00 00 	movl   $0xffff,0x20(%eax)
  10499b:	c7 40 24 00 f2 cf 00 	movl   $0xcff200,0x24(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3].sd_s = 0;
  1049a2:	89 48 2c             	mov    %ecx,0x2c(%eax)
    bsp_kstack[cpu_idx].magic = KSTACK_MAGIC;
  1049a5:	c7 80 20 01 00 00 32 	movl   $0x98765432,0x120(%eax)
  1049ac:	54 76 98 
    pseudodesc_t gdt_desc = {
  1049af:	b8 2f 00 00 00       	mov    $0x2f,%eax
  1049b4:	66 89 44 24 1a       	mov    %ax,0x1a(%esp)
        .pd_base  = (uint32_t) bsp_kstack[cpu_idx].gdt
  1049b9:	8d 84 16 00 f0 ff ff 	lea    -0x1000(%esi,%edx,1),%eax
  1049c0:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    };
    asm volatile ("lgdt %0" :: "m" (gdt_desc));
  1049c4:	0f 01 54 24 1a       	lgdtl  0x1a(%esp)
    asm volatile ("movw %%ax,%%gs" :: "a" (CPU_GDT_KDATA));
  1049c9:	b8 10 00 00 00       	mov    $0x10,%eax
  1049ce:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax,%%fs" :: "a" (CPU_GDT_KDATA));
  1049d0:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax,%%es" :: "a" (CPU_GDT_KDATA));
  1049d2:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax,%%ds" :: "a" (CPU_GDT_KDATA));
  1049d4:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax,%%ss" :: "a" (CPU_GDT_KDATA));
  1049d6:	8e d0                	mov    %eax,%ss
    /* reload %cs */
    asm volatile ("ljmp %0,$1f\n 1:\n" :: "i" (CPU_GDT_KCODE));
  1049d8:	ea df 49 10 00 08 00 	ljmp   $0x8,$0x1049df

    /*
     * Load a null LDT.
     */
    lldt(0);
  1049df:	83 ec 0c             	sub    $0xc,%esp
  1049e2:	6a 00                	push   $0x0
  1049e4:	e8 17 02 00 00       	call   104c00 <lldt>

    /*
     * Load the bootstrap TSS.
     */
    ltr(CPU_GDT_TSS);
  1049e9:	c7 04 24 28 00 00 00 	movl   $0x28,(%esp)
  1049f0:	e8 9b 03 00 00       	call   104d90 <ltr>

    /*
     * Load IDT.
     */
    extern pseudodesc_t idt_pd;
    asm volatile ("lidt %0" :: "m" (idt_pd));
  1049f5:	c7 c0 20 03 11 00    	mov    $0x110320,%eax
  1049fb:	0f 01 18             	lidtl  (%eax)

    /*
     * Initialize all TSS structures for processes.
     */
    if (cpu_idx == 0) {
  1049fe:	83 c4 10             	add    $0x10,%esp
  104a01:	85 ff                	test   %edi,%edi
  104a03:	74 4b                	je     104a50 <seg_init+0x180>
        memzero(&bsp_kstack[1], sizeof(struct kstack) * 7);
        memzero(proc_kstack, sizeof(struct kstack) * 64);
    }
}
  104a05:	83 c4 2c             	add    $0x2c,%esp
  104a08:	5b                   	pop    %ebx
  104a09:	5e                   	pop    %esi
  104a0a:	5f                   	pop    %edi
  104a0b:	5d                   	pop    %ebp
  104a0c:	c3                   	ret    
  104a0d:	8d 76 00             	lea    0x0(%esi),%esi
        memzero(edata, ((uint8_t *) &bsp_kstack[0]) - edata);
  104a10:	c7 c0 92 6d 13 00    	mov    $0x136d92,%eax
  104a16:	89 f2                	mov    %esi,%edx
  104a18:	83 ec 08             	sub    $0x8,%esp
  104a1b:	29 c2                	sub    %eax,%edx
  104a1d:	52                   	push   %edx
  104a1e:	50                   	push   %eax
  104a1f:	e8 0c f5 ff ff       	call   103f30 <memzero>
        memzero(((uint8_t *) &bsp_kstack[0]) + 4096, end - ((uint8_t *) &bsp_kstack[0]) - 4096);
  104a24:	58                   	pop    %eax
  104a25:	c7 c0 a4 5d e0 00    	mov    $0xe05da4,%eax
  104a2b:	5a                   	pop    %edx
  104a2c:	29 f0                	sub    %esi,%eax
  104a2e:	2d 00 10 00 00       	sub    $0x1000,%eax
  104a33:	50                   	push   %eax
  104a34:	8d 86 00 10 00 00    	lea    0x1000(%esi),%eax
  104a3a:	50                   	push   %eax
  104a3b:	e8 f0 f4 ff ff       	call   103f30 <memzero>
  104a40:	83 c4 10             	add    $0x10,%esp
  104a43:	e9 ac fe ff ff       	jmp    1048f4 <seg_init+0x24>
  104a48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104a4f:	90                   	nop
        memzero(&bsp_kstack[1], sizeof(struct kstack) * 7);
  104a50:	83 ec 08             	sub    $0x8,%esp
  104a53:	8d 86 00 10 00 00    	lea    0x1000(%esi),%eax
  104a59:	68 00 70 00 00       	push   $0x7000
  104a5e:	50                   	push   %eax
  104a5f:	e8 cc f4 ff ff       	call   103f30 <memzero>
        memzero(proc_kstack, sizeof(struct kstack) * 64);
  104a64:	58                   	pop    %eax
  104a65:	5a                   	pop    %edx
  104a66:	68 00 00 04 00       	push   $0x40000
  104a6b:	ff b3 f4 ff ff ff    	push   -0xc(%ebx)
  104a71:	e8 ba f4 ff ff       	call   103f30 <memzero>
  104a76:	83 c4 10             	add    $0x10,%esp
}
  104a79:	83 c4 2c             	add    $0x2c,%esp
  104a7c:	5b                   	pop    %ebx
  104a7d:	5e                   	pop    %esi
  104a7e:	5f                   	pop    %edi
  104a7f:	5d                   	pop    %ebp
  104a80:	c3                   	ret    
  104a81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104a88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104a8f:	90                   	nop

00104a90 <seg_init_proc>:

/* initialize the kernel stack for each process */
void seg_init_proc(int cpu_idx, int pid)
{
  104a90:	55                   	push   %ebp
        SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

    /* setup TSS */
    proc_kstack[pid].tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
    proc_kstack[pid].tss.ts_ss0 = CPU_GDT_KDATA;
    proc_kstack[pid].tss.ts_iomb = offsetof(tss_t, ts_iopm);
  104a91:	ba 68 00 00 00       	mov    $0x68,%edx
{
  104a96:	57                   	push   %edi
  104a97:	56                   	push   %esi
  104a98:	53                   	push   %ebx
  104a99:	e8 eb b8 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  104a9e:	81 c3 62 b5 00 00    	add    $0xb562,%ebx
  104aa4:	83 ec 14             	sub    $0x14,%esp
  104aa7:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
  104aab:	89 fe                	mov    %edi,%esi
  104aad:	83 c7 01             	add    $0x1,%edi
  104ab0:	c7 c5 00 90 13 00    	mov    $0x139000,%ebp
  104ab6:	c1 e7 0c             	shl    $0xc,%edi
  104ab9:	c1 e6 0c             	shl    $0xc,%esi
  104abc:	01 ee                	add    %ebp,%esi
    proc_kstack[pid].tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  104abe:	8d 04 2f             	lea    (%edi,%ebp,1),%eax
  104ac1:	89 46 34             	mov    %eax,0x34(%esi)
    proc_kstack[pid].tss.ts_ss0 = CPU_GDT_KDATA;
  104ac4:	b8 10 00 00 00       	mov    $0x10,%eax
  104ac9:	66 89 46 38          	mov    %ax,0x38(%esi)
    memzero (proc_kstack[pid].tss.ts_iopm, sizeof(uint8_t) * 128);
  104acd:	8d 84 2f 98 f0 ff ff 	lea    -0xf68(%edi,%ebp,1),%eax
    proc_kstack[pid].tss.ts_iomb = offsetof(tss_t, ts_iopm);
  104ad4:	66 89 96 96 00 00 00 	mov    %dx,0x96(%esi)
    proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  104adb:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  104ae1:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
    proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
  104ae8:	c7 46 08 ff ff 00 00 	movl   $0xffff,0x8(%esi)
  104aef:	c7 46 0c 00 9a cf 00 	movl   $0xcf9a00,0xc(%esi)
    proc_kstack[pid].gdt[CPU_GDT_KDATA >> 3] =
  104af6:	c7 46 10 ff ff 00 00 	movl   $0xffff,0x10(%esi)
  104afd:	c7 46 14 00 92 cf 00 	movl   $0xcf9200,0x14(%esi)
    proc_kstack[pid].gdt[CPU_GDT_UCODE >> 3] =
  104b04:	c7 46 18 ff ff 00 00 	movl   $0xffff,0x18(%esi)
  104b0b:	c7 46 1c 00 fa cf 00 	movl   $0xcffa00,0x1c(%esi)
    proc_kstack[pid].gdt[CPU_GDT_UDATA >> 3] =
  104b12:	c7 46 20 ff ff 00 00 	movl   $0xffff,0x20(%esi)
  104b19:	c7 46 24 00 f2 cf 00 	movl   $0xcff200,0x24(%esi)
    memzero (proc_kstack[pid].tss.ts_iopm, sizeof(uint8_t) * 128);
  104b20:	68 80 00 00 00       	push   $0x80
  104b25:	50                   	push   %eax
  104b26:	e8 05 f4 ff ff       	call   103f30 <memzero>
    proc_kstack[pid].tss.ts_iopm[128] = 0xff;

    proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
  104b2b:	bb 89 40 00 00       	mov    $0x4089,%ebx
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  104b30:	8d 84 2f 30 f0 ff ff 	lea    -0xfd0(%edi,%ebp,1),%eax
    proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
  104b37:	b9 eb 00 00 00       	mov    $0xeb,%ecx
  104b3c:	66 89 46 2a          	mov    %ax,0x2a(%esi)
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  104b40:	89 c2                	mov    %eax,%edx
  104b42:	c1 e8 18             	shr    $0x18,%eax
    proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
  104b45:	88 46 2f             	mov    %al,0x2f(%esi)
    proc_kstack[pid].gdt[CPU_GDT_TSS >> 3].sd_s = 0;

    /* other fields */
    proc_kstack[pid].magic = KSTACK_MAGIC;
    proc_kstack[pid].cpu_idx = cpu_idx;
  104b48:	8b 44 24 30          	mov    0x30(%esp),%eax
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  104b4c:	c1 ea 10             	shr    $0x10,%edx
    proc_kstack[pid].tss.ts_iopm[128] = 0xff;
  104b4f:	c6 86 18 01 00 00 ff 	movb   $0xff,0x118(%esi)
    proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
  104b56:	66 89 4e 28          	mov    %cx,0x28(%esi)
  104b5a:	88 56 2c             	mov    %dl,0x2c(%esi)
  104b5d:	66 89 5e 2d          	mov    %bx,0x2d(%esi)
    proc_kstack[pid].magic = KSTACK_MAGIC;
  104b61:	c7 86 20 01 00 00 32 	movl   $0x98765432,0x120(%esi)
  104b68:	54 76 98 
    proc_kstack[pid].cpu_idx = cpu_idx;
  104b6b:	89 86 1c 01 00 00    	mov    %eax,0x11c(%esi)
}
  104b71:	83 c4 1c             	add    $0x1c,%esp
  104b74:	5b                   	pop    %ebx
  104b75:	5e                   	pop    %esi
  104b76:	5f                   	pop    %edi
  104b77:	5d                   	pop    %ebp
  104b78:	c3                   	ret    
  104b79:	66 90                	xchg   %ax,%ax
  104b7b:	66 90                	xchg   %ax,%ax
  104b7d:	66 90                	xchg   %ax,%ax
  104b7f:	90                   	nop

00104b80 <max>:
#include "types.h"

uint32_t max(uint32_t a, uint32_t b)
{
  104b80:	8b 44 24 08          	mov    0x8(%esp),%eax
    return (a > b) ? a : b;
  104b84:	8b 54 24 04          	mov    0x4(%esp),%edx
  104b88:	39 d0                	cmp    %edx,%eax
  104b8a:	0f 42 c2             	cmovb  %edx,%eax
}
  104b8d:	c3                   	ret    
  104b8e:	66 90                	xchg   %ax,%ax

00104b90 <min>:

uint32_t min(uint32_t a, uint32_t b)
{
  104b90:	8b 44 24 08          	mov    0x8(%esp),%eax
    return (a < b) ? a : b;
  104b94:	8b 54 24 04          	mov    0x4(%esp),%edx
  104b98:	39 d0                	cmp    %edx,%eax
  104b9a:	0f 47 c2             	cmova  %edx,%eax
}
  104b9d:	c3                   	ret    
  104b9e:	66 90                	xchg   %ax,%ax

00104ba0 <rounddown>:

uint32_t rounddown(uint32_t a, uint32_t n)
{
  104ba0:	8b 4c 24 04          	mov    0x4(%esp),%ecx
    return a - a % n;
  104ba4:	31 d2                	xor    %edx,%edx
  104ba6:	89 c8                	mov    %ecx,%eax
  104ba8:	f7 74 24 08          	divl   0x8(%esp)
  104bac:	89 c8                	mov    %ecx,%eax
  104bae:	29 d0                	sub    %edx,%eax
}
  104bb0:	c3                   	ret    
  104bb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104bb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104bbf:	90                   	nop

00104bc0 <roundup>:

uint32_t roundup(uint32_t a, uint32_t n)
{
  104bc0:	53                   	push   %ebx
  104bc1:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
    return a - a % n;
  104bc5:	31 d2                	xor    %edx,%edx
    return rounddown(a + n - 1, n);
  104bc7:	8d 4b ff             	lea    -0x1(%ebx),%ecx
  104bca:	03 4c 24 08          	add    0x8(%esp),%ecx
    return a - a % n;
  104bce:	89 c8                	mov    %ecx,%eax
  104bd0:	f7 f3                	div    %ebx
  104bd2:	89 c8                	mov    %ecx,%eax
}
  104bd4:	5b                   	pop    %ebx
    return a - a % n;
  104bd5:	29 d0                	sub    %edx,%eax
}
  104bd7:	c3                   	ret    
  104bd8:	66 90                	xchg   %ax,%ax
  104bda:	66 90                	xchg   %ax,%ax
  104bdc:	66 90                	xchg   %ax,%ax
  104bde:	66 90                	xchg   %ax,%ax

00104be0 <read_esp>:
#include "x86.h"

gcc_inline uintptr_t read_esp(void)
{
    uint32_t esp;
    __asm __volatile ("movl %%esp,%0" : "=rm" (esp));
  104be0:	89 e0                	mov    %esp,%eax
    return esp;
}
  104be2:	c3                   	ret    
  104be3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104bf0 <read_ebp>:

gcc_inline uint32_t read_ebp(void)
{
    uint32_t ebp;
    __asm __volatile ("movl %%ebp,%0" : "=rm" (ebp));
  104bf0:	89 e8                	mov    %ebp,%eax
    return ebp;
}
  104bf2:	c3                   	ret    
  104bf3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104c00 <lldt>:

gcc_inline void lldt(uint16_t sel)
{
    __asm __volatile ("lldt %0" :: "r" (sel));
  104c00:	0f b7 44 24 04       	movzwl 0x4(%esp),%eax
  104c05:	0f 00 d0             	lldt   %ax
}
  104c08:	c3                   	ret    
  104c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104c10 <cli>:

gcc_inline void cli(void)
{
    __asm __volatile ("cli" ::: "memory");
  104c10:	fa                   	cli    
}
  104c11:	c3                   	ret    
  104c12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104c20 <sti>:

gcc_inline void sti(void)
{
    __asm __volatile ("sti; nop");
  104c20:	fb                   	sti    
  104c21:	90                   	nop
}
  104c22:	c3                   	ret    
  104c23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104c30 <rdmsr>:

gcc_inline uint64_t rdmsr(uint32_t msr)
{
    uint64_t rv;
    __asm __volatile ("rdmsr"
  104c30:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  104c34:	0f 32                	rdmsr  
                      : "=A" (rv)
                      : "c" (msr));
    return rv;
}
  104c36:	c3                   	ret    
  104c37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104c3e:	66 90                	xchg   %ax,%ax

00104c40 <wrmsr>:

gcc_inline void wrmsr(uint32_t msr, uint64_t newval)
{
    __asm __volatile ("wrmsr" :: "A" (newval), "c" (msr));
  104c40:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  104c44:	8b 44 24 08          	mov    0x8(%esp),%eax
  104c48:	8b 54 24 0c          	mov    0xc(%esp),%edx
  104c4c:	0f 30                	wrmsr  
}
  104c4e:	c3                   	ret    
  104c4f:	90                   	nop

00104c50 <halt>:

gcc_inline void halt(void)
{
    __asm __volatile ("hlt");
  104c50:	f4                   	hlt    
}
  104c51:	c3                   	ret    
  104c52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104c60 <pause>:

gcc_inline void pause(void)
{
    __asm __volatile ("pause" ::: "memory");
  104c60:	f3 90                	pause  
}
  104c62:	c3                   	ret    
  104c63:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104c70 <xchg>:

gcc_inline uint32_t xchg(volatile uint32_t *addr, uint32_t newval)
{
  104c70:	8b 54 24 04          	mov    0x4(%esp),%edx
    uint32_t result;

    __asm __volatile ("lock; xchgl %0, %1"
  104c74:	8b 44 24 08          	mov    0x8(%esp),%eax
  104c78:	f0 87 02             	lock xchg %eax,(%edx)
                      : "+m" (*addr), "=a" (result)
                      : "1" (newval)
                      : "cc");

    return result;
}
  104c7b:	c3                   	ret    
  104c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104c80 <cmpxchg>:

gcc_inline uint32_t cmpxchg(volatile uint32_t *addr, uint32_t oldval, uint32_t newval)
{
  104c80:	8b 4c 24 04          	mov    0x4(%esp),%ecx
    uint32_t result;

    __asm __volatile ("lock; cmpxchgl %2, %0"
  104c84:	8b 44 24 08          	mov    0x8(%esp),%eax
  104c88:	8b 54 24 0c          	mov    0xc(%esp),%edx
  104c8c:	f0 0f b1 11          	lock cmpxchg %edx,(%ecx)
                      : "+m" (*addr), "=a" (result)
                      : "r" (newval), "a" (oldval)
                      : "memory", "cc");

    return result;
}
  104c90:	c3                   	ret    
  104c91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104c98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104c9f:	90                   	nop

00104ca0 <rdtsc>:

gcc_inline uint64_t rdtsc(void)
{
    uint64_t rv;

    __asm __volatile ("rdtsc" : "=A" (rv));
  104ca0:	0f 31                	rdtsc  
    return (rv);
}
  104ca2:	c3                   	ret    
  104ca3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104cb0 <enable_sse>:
}

gcc_inline uint32_t rcr4(void)
{
    uint32_t cr4;
    __asm __volatile ("movl %%cr4,%0" : "=r" (cr4));
  104cb0:	0f 20 e0             	mov    %cr4,%eax
    FENCE();
  104cb3:	0f ae f0             	mfence 
    cr4 = rcr4() | CR4_OSFXSR | CR4_OSXMMEXCPT;
  104cb6:	80 cc 06             	or     $0x6,%ah
    __asm __volatile ("movl %0,%%cr4" :: "r" (val));
  104cb9:	0f 22 e0             	mov    %eax,%cr4
    __asm __volatile ("movl %%cr0,%0" : "=r" (val));
  104cbc:	0f 20 c0             	mov    %cr0,%eax
    FENCE();
  104cbf:	0f ae f0             	mfence 
}
  104cc2:	c3                   	ret    
  104cc3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104cd0 <cpuid>:
{
  104cd0:	55                   	push   %ebp
  104cd1:	57                   	push   %edi
  104cd2:	56                   	push   %esi
  104cd3:	53                   	push   %ebx
  104cd4:	8b 44 24 14          	mov    0x14(%esp),%eax
  104cd8:	8b 74 24 18          	mov    0x18(%esp),%esi
  104cdc:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
  104ce0:	8b 6c 24 20          	mov    0x20(%esp),%ebp
    __asm __volatile ("cpuid"
  104ce4:	0f a2                	cpuid  
    if (eaxp)
  104ce6:	85 f6                	test   %esi,%esi
  104ce8:	74 02                	je     104cec <cpuid+0x1c>
        *eaxp = eax;
  104cea:	89 06                	mov    %eax,(%esi)
    if (ebxp)
  104cec:	85 ff                	test   %edi,%edi
  104cee:	74 02                	je     104cf2 <cpuid+0x22>
        *ebxp = ebx;
  104cf0:	89 1f                	mov    %ebx,(%edi)
    if (ecxp)
  104cf2:	85 ed                	test   %ebp,%ebp
  104cf4:	74 03                	je     104cf9 <cpuid+0x29>
        *ecxp = ecx;
  104cf6:	89 4d 00             	mov    %ecx,0x0(%ebp)
    if (edxp)
  104cf9:	8b 44 24 24          	mov    0x24(%esp),%eax
  104cfd:	85 c0                	test   %eax,%eax
  104cff:	74 06                	je     104d07 <cpuid+0x37>
        *edxp = edx;
  104d01:	8b 44 24 24          	mov    0x24(%esp),%eax
  104d05:	89 10                	mov    %edx,(%eax)
}
  104d07:	5b                   	pop    %ebx
  104d08:	5e                   	pop    %esi
  104d09:	5f                   	pop    %edi
  104d0a:	5d                   	pop    %ebp
  104d0b:	c3                   	ret    
  104d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104d10 <cpuid_subleaf>:
{
  104d10:	55                   	push   %ebp
  104d11:	57                   	push   %edi
  104d12:	56                   	push   %esi
  104d13:	53                   	push   %ebx
  104d14:	8b 74 24 1c          	mov    0x1c(%esp),%esi
  104d18:	8b 7c 24 20          	mov    0x20(%esp),%edi
  104d1c:	8b 6c 24 24          	mov    0x24(%esp),%ebp
    asm volatile ("cpuid"
  104d20:	8b 44 24 14          	mov    0x14(%esp),%eax
  104d24:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  104d28:	0f a2                	cpuid  
    if (eaxp)
  104d2a:	85 f6                	test   %esi,%esi
  104d2c:	74 02                	je     104d30 <cpuid_subleaf+0x20>
        *eaxp = eax;
  104d2e:	89 06                	mov    %eax,(%esi)
    if (ebxp)
  104d30:	85 ff                	test   %edi,%edi
  104d32:	74 02                	je     104d36 <cpuid_subleaf+0x26>
        *ebxp = ebx;
  104d34:	89 1f                	mov    %ebx,(%edi)
    if (ecxp)
  104d36:	85 ed                	test   %ebp,%ebp
  104d38:	74 03                	je     104d3d <cpuid_subleaf+0x2d>
        *ecxp = ecx;
  104d3a:	89 4d 00             	mov    %ecx,0x0(%ebp)
    if (edxp)
  104d3d:	8b 44 24 28          	mov    0x28(%esp),%eax
  104d41:	85 c0                	test   %eax,%eax
  104d43:	74 06                	je     104d4b <cpuid_subleaf+0x3b>
        *edxp = edx;
  104d45:	8b 44 24 28          	mov    0x28(%esp),%eax
  104d49:	89 10                	mov    %edx,(%eax)
}
  104d4b:	5b                   	pop    %ebx
  104d4c:	5e                   	pop    %esi
  104d4d:	5f                   	pop    %edi
  104d4e:	5d                   	pop    %ebp
  104d4f:	c3                   	ret    

00104d50 <rcr3>:
    __asm __volatile ("movl %%cr3,%0" : "=r" (val));
  104d50:	0f 20 d8             	mov    %cr3,%eax
}
  104d53:	c3                   	ret    
  104d54:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104d5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104d5f:	90                   	nop

00104d60 <outl>:
    __asm __volatile ("outl %0,%w1" :: "a" (data), "d" (port));
  104d60:	8b 54 24 04          	mov    0x4(%esp),%edx
  104d64:	8b 44 24 08          	mov    0x8(%esp),%eax
  104d68:	ef                   	out    %eax,(%dx)
}
  104d69:	c3                   	ret    
  104d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104d70 <inl>:
    __asm __volatile ("inl %w1,%0" : "=a" (data) : "d" (port));
  104d70:	8b 54 24 04          	mov    0x4(%esp),%edx
  104d74:	ed                   	in     (%dx),%eax
}
  104d75:	c3                   	ret    
  104d76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104d7d:	8d 76 00             	lea    0x0(%esi),%esi

00104d80 <smp_wmb>:
}
  104d80:	c3                   	ret    
  104d81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104d88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104d8f:	90                   	nop

00104d90 <ltr>:
    __asm __volatile ("ltr %0" :: "r" (sel));
  104d90:	0f b7 44 24 04       	movzwl 0x4(%esp),%eax
  104d95:	0f 00 d8             	ltr    %ax
}
  104d98:	c3                   	ret    
  104d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104da0 <lcr0>:
    __asm __volatile ("movl %0,%%cr0" :: "r" (val));
  104da0:	8b 44 24 04          	mov    0x4(%esp),%eax
  104da4:	0f 22 c0             	mov    %eax,%cr0
}
  104da7:	c3                   	ret    
  104da8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104daf:	90                   	nop

00104db0 <rcr0>:
    __asm __volatile ("movl %%cr0,%0" : "=r" (val));
  104db0:	0f 20 c0             	mov    %cr0,%eax
}
  104db3:	c3                   	ret    
  104db4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104dbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104dbf:	90                   	nop

00104dc0 <rcr2>:
    __asm __volatile ("movl %%cr2,%0" : "=r" (val));
  104dc0:	0f 20 d0             	mov    %cr2,%eax
}
  104dc3:	c3                   	ret    
  104dc4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104dcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104dcf:	90                   	nop

00104dd0 <lcr3>:
    __asm __volatile ("movl %0,%%cr3" :: "r" (val));
  104dd0:	8b 44 24 04          	mov    0x4(%esp),%eax
  104dd4:	0f 22 d8             	mov    %eax,%cr3
}
  104dd7:	c3                   	ret    
  104dd8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104ddf:	90                   	nop

00104de0 <lcr4>:
    __asm __volatile ("movl %0,%%cr4" :: "r" (val));
  104de0:	8b 44 24 04          	mov    0x4(%esp),%eax
  104de4:	0f 22 e0             	mov    %eax,%cr4
}
  104de7:	c3                   	ret    
  104de8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104def:	90                   	nop

00104df0 <rcr4>:
    __asm __volatile ("movl %%cr4,%0" : "=r" (cr4));
  104df0:	0f 20 e0             	mov    %cr4,%eax
    return cr4;
}
  104df3:	c3                   	ret    
  104df4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104dfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104dff:	90                   	nop

00104e00 <inb>:

gcc_inline uint8_t inb(int port)
{
    uint8_t data;
    __asm __volatile ("inb %w1,%0"
  104e00:	8b 54 24 04          	mov    0x4(%esp),%edx
  104e04:	ec                   	in     (%dx),%al
                      : "=a" (data)
                      : "d" (port));
    return data;
}
  104e05:	c3                   	ret    
  104e06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104e0d:	8d 76 00             	lea    0x0(%esi),%esi

00104e10 <insl>:

gcc_inline void insl(int port, void *addr, int cnt)
{
  104e10:	57                   	push   %edi
    __asm __volatile ("cld\n\trepne\n\tinsl"
  104e11:	8b 7c 24 0c          	mov    0xc(%esp),%edi
  104e15:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  104e19:	8b 54 24 08          	mov    0x8(%esp),%edx
  104e1d:	fc                   	cld    
  104e1e:	f2 6d                	repnz insl (%dx),%es:(%edi)
                      : "=D" (addr), "=c" (cnt)
                      : "d" (port), "0" (addr), "1" (cnt)
                      : "memory", "cc");
}
  104e20:	5f                   	pop    %edi
  104e21:	c3                   	ret    
  104e22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104e30 <outb>:

gcc_inline void outb(int port, uint8_t data)
{
    __asm __volatile ("outb %0,%w1" :: "a" (data), "d" (port));
  104e30:	8b 54 24 04          	mov    0x4(%esp),%edx
  104e34:	0f b6 44 24 08       	movzbl 0x8(%esp),%eax
  104e39:	ee                   	out    %al,(%dx)
}
  104e3a:	c3                   	ret    
  104e3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104e3f:	90                   	nop

00104e40 <outsw>:

gcc_inline void outsw(int port, const void *addr, int cnt)
{
  104e40:	56                   	push   %esi
    __asm __volatile ("cld\n\trepne\n\toutsw"
  104e41:	8b 74 24 0c          	mov    0xc(%esp),%esi
  104e45:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  104e49:	8b 54 24 08          	mov    0x8(%esp),%edx
  104e4d:	fc                   	cld    
  104e4e:	f2 66 6f             	repnz outsw %ds:(%esi),(%dx)
                      : "=S" (addr), "=c" (cnt)
                      : "d" (port), "0" (addr), "1" (cnt)
                      : "cc");
}
  104e51:	5e                   	pop    %esi
  104e52:	c3                   	ret    
  104e53:	66 90                	xchg   %ax,%ax
  104e55:	66 90                	xchg   %ax,%ax
  104e57:	66 90                	xchg   %ax,%ax
  104e59:	66 90                	xchg   %ax,%ax
  104e5b:	66 90                	xchg   %ax,%ax
  104e5d:	66 90                	xchg   %ax,%ax
  104e5f:	90                   	nop

00104e60 <mon_help>:

#define NCOMMANDS (sizeof(commands) / sizeof(commands[0]))

/***** Implementations of basic kernel monitor commands *****/
int mon_help(int argc, char **argv, struct Trapframe *tf)
{
  104e60:	56                   	push   %esi
  104e61:	53                   	push   %ebx
  104e62:	e8 22 b5 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  104e67:	81 c3 99 b1 00 00    	add    $0xb199,%ebx
  104e6d:	83 ec 08             	sub    $0x8,%esp
    int i;

    for (i = 0; i < NCOMMANDS; i++)
        dprintf("%s - %s\n", commands[i].name, commands[i].desc);
  104e70:	8d 83 98 a3 ff ff    	lea    -0x5c68(%ebx),%eax
  104e76:	8d b3 bb a3 ff ff    	lea    -0x5c45(%ebx),%esi
  104e7c:	50                   	push   %eax
  104e7d:	8d 83 b6 a3 ff ff    	lea    -0x5c4a(%ebx),%eax
  104e83:	50                   	push   %eax
  104e84:	56                   	push   %esi
  104e85:	e8 b6 f3 ff ff       	call   104240 <dprintf>
  104e8a:	83 c4 0c             	add    $0xc,%esp
  104e8d:	8d 83 60 a4 ff ff    	lea    -0x5ba0(%ebx),%eax
  104e93:	50                   	push   %eax
  104e94:	8d 83 c4 a3 ff ff    	lea    -0x5c3c(%ebx),%eax
  104e9a:	50                   	push   %eax
  104e9b:	56                   	push   %esi
  104e9c:	e8 9f f3 ff ff       	call   104240 <dprintf>
    return 0;
}
  104ea1:	83 c4 14             	add    $0x14,%esp
  104ea4:	31 c0                	xor    %eax,%eax
  104ea6:	5b                   	pop    %ebx
  104ea7:	5e                   	pop    %esi
  104ea8:	c3                   	ret    
  104ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104eb0 <mon_kerninfo>:

int mon_kerninfo(int argc, char **argv, struct Trapframe *tf)
{
  104eb0:	57                   	push   %edi
  104eb1:	56                   	push   %esi
  104eb2:	53                   	push   %ebx
  104eb3:	e8 d1 b4 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  104eb8:	81 c3 48 b1 00 00    	add    $0xb148,%ebx
    extern uint8_t start[], etext[], edata[], end[];

    dprintf("Special kernel symbols:\n");
  104ebe:	83 ec 0c             	sub    $0xc,%esp
  104ec1:	8d 83 cd a3 ff ff    	lea    -0x5c33(%ebx),%eax
  104ec7:	50                   	push   %eax
  104ec8:	e8 73 f3 ff ff       	call   104240 <dprintf>
    dprintf("  start  %08x\n", start);
  104ecd:	c7 c7 f0 5e 10 00    	mov    $0x105ef0,%edi
  104ed3:	58                   	pop    %eax
  104ed4:	8d 83 e6 a3 ff ff    	lea    -0x5c1a(%ebx),%eax
  104eda:	5a                   	pop    %edx
  104edb:	57                   	push   %edi
  104edc:	50                   	push   %eax
  104edd:	e8 5e f3 ff ff       	call   104240 <dprintf>
    dprintf("  etext  %08x\n", etext);
  104ee2:	8d 83 f5 a3 ff ff    	lea    -0x5c0b(%ebx),%eax
  104ee8:	59                   	pop    %ecx
  104ee9:	5e                   	pop    %esi
  104eea:	ff b3 f8 ff ff ff    	push   -0x8(%ebx)
  104ef0:	50                   	push   %eax
  104ef1:	e8 4a f3 ff ff       	call   104240 <dprintf>
    dprintf("  edata  %08x\n", edata);
  104ef6:	58                   	pop    %eax
  104ef7:	8d 83 04 a4 ff ff    	lea    -0x5bfc(%ebx),%eax
  104efd:	5a                   	pop    %edx
  104efe:	ff b3 f0 ff ff ff    	push   -0x10(%ebx)
  104f04:	50                   	push   %eax
  104f05:	e8 36 f3 ff ff       	call   104240 <dprintf>
    dprintf("  end    %08x\n", end);
  104f0a:	59                   	pop    %ecx
  104f0b:	5e                   	pop    %esi
  104f0c:	8d 83 13 a4 ff ff    	lea    -0x5bed(%ebx),%eax
  104f12:	c7 c6 a4 5d e0 00    	mov    $0xe05da4,%esi
  104f18:	56                   	push   %esi
    dprintf("Kernel executable memory footprint: %dKB\n",
            ROUNDUP(end - start, 1024) / 1024);
  104f19:	29 fe                	sub    %edi,%esi
    dprintf("  end    %08x\n", end);
  104f1b:	50                   	push   %eax
  104f1c:	e8 1f f3 ff ff       	call   104240 <dprintf>
            ROUNDUP(end - start, 1024) / 1024);
  104f21:	8d 86 ff 03 00 00    	lea    0x3ff(%esi),%eax
    dprintf("Kernel executable memory footprint: %dKB\n",
  104f27:	5f                   	pop    %edi
  104f28:	5a                   	pop    %edx
            ROUNDUP(end - start, 1024) / 1024);
  104f29:	89 c1                	mov    %eax,%ecx
  104f2b:	c1 f9 1f             	sar    $0x1f,%ecx
  104f2e:	c1 e9 16             	shr    $0x16,%ecx
  104f31:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  104f34:	81 e2 ff 03 00 00    	and    $0x3ff,%edx
  104f3a:	29 ca                	sub    %ecx,%edx
  104f3c:	29 d0                	sub    %edx,%eax
    dprintf("Kernel executable memory footprint: %dKB\n",
  104f3e:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  104f44:	0f 48 c2             	cmovs  %edx,%eax
  104f47:	c1 f8 0a             	sar    $0xa,%eax
  104f4a:	50                   	push   %eax
  104f4b:	8d 83 88 a4 ff ff    	lea    -0x5b78(%ebx),%eax
  104f51:	50                   	push   %eax
  104f52:	e8 e9 f2 ff ff       	call   104240 <dprintf>
    return 0;
  104f57:	83 c4 10             	add    $0x10,%esp
}
  104f5a:	31 c0                	xor    %eax,%eax
  104f5c:	5b                   	pop    %ebx
  104f5d:	5e                   	pop    %esi
  104f5e:	5f                   	pop    %edi
  104f5f:	c3                   	ret    

00104f60 <monitor>:
    dprintf("Unknown command '%s'\n", argv[0]);
    return 0;
}

void monitor(struct Trapframe *tf)
{
  104f60:	55                   	push   %ebp
  104f61:	57                   	push   %edi
  104f62:	56                   	push   %esi
  104f63:	53                   	push   %ebx
  104f64:	e8 20 b4 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  104f69:	81 c3 97 b0 00 00    	add    $0xb097,%ebx
  104f6f:	83 ec 68             	sub    $0x68,%esp
    char *buf;

    dprintf("\n****************************************\n\n");
  104f72:	8d b3 b4 a4 ff ff    	lea    -0x5b4c(%ebx),%esi
  104f78:	56                   	push   %esi
  104f79:	e8 c2 f2 ff ff       	call   104240 <dprintf>
    dprintf("Welcome to the mCertiKOS kernel monitor!\n");
  104f7e:	8d 83 e0 a4 ff ff    	lea    -0x5b20(%ebx),%eax
  104f84:	89 04 24             	mov    %eax,(%esp)
  104f87:	e8 b4 f2 ff ff       	call   104240 <dprintf>
    dprintf("\n****************************************\n\n");
  104f8c:	89 34 24             	mov    %esi,(%esp)
        while (*buf && strchr(WHITESPACE, *buf))
  104f8f:	8d b3 26 a4 ff ff    	lea    -0x5bda(%ebx),%esi
    dprintf("\n****************************************\n\n");
  104f95:	e8 a6 f2 ff ff       	call   104240 <dprintf>
    dprintf("Type 'help' for a list of commands.\n");
  104f9a:	8d 83 0c a5 ff ff    	lea    -0x5af4(%ebx),%eax
  104fa0:	89 04 24             	mov    %eax,(%esp)
  104fa3:	e8 98 f2 ff ff       	call   104240 <dprintf>
  104fa8:	83 c4 10             	add    $0x10,%esp
  104fab:	8d 83 22 a4 ff ff    	lea    -0x5bde(%ebx),%eax
  104fb1:	89 04 24             	mov    %eax,(%esp)
  104fb4:	8d 83 b6 a3 ff ff    	lea    -0x5c4a(%ebx),%eax
  104fba:	89 44 24 08          	mov    %eax,0x8(%esp)
  104fbe:	8d 44 24 10          	lea    0x10(%esp),%eax
  104fc2:	89 44 24 0c          	mov    %eax,0xc(%esp)
  104fc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104fcd:	8d 76 00             	lea    0x0(%esi),%esi

    while (1) {
        buf = (char *) readline("$> ");
  104fd0:	83 ec 0c             	sub    $0xc,%esp
  104fd3:	ff 74 24 0c          	push   0xc(%esp)
  104fd7:	e8 74 b5 ff ff       	call   100550 <readline>
        if (buf != NULL)
  104fdc:	83 c4 10             	add    $0x10,%esp
        buf = (char *) readline("$> ");
  104fdf:	89 c5                	mov    %eax,%ebp
        if (buf != NULL)
  104fe1:	85 c0                	test   %eax,%eax
  104fe3:	74 eb                	je     104fd0 <monitor+0x70>
    argv[argc] = 0;
  104fe5:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  104fec:	00 
  104fed:	0f be 10             	movsbl (%eax),%edx
    argc = 0;
  104ff0:	31 c9                	xor    %ecx,%ecx
  104ff2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        while (*buf && strchr(WHITESPACE, *buf))
  104ff8:	84 d2                	test   %dl,%dl
  104ffa:	75 74                	jne    105070 <monitor+0x110>
    if (argc == 0)
  104ffc:	85 c9                	test   %ecx,%ecx
    argv[argc] = 0;
  104ffe:	c7 44 8c 10 00 00 00 	movl   $0x0,0x10(%esp,%ecx,4)
  105005:	00 
    if (argc == 0)
  105006:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  10500a:	74 c4                	je     104fd0 <monitor+0x70>
        if (strcmp(argv[0], commands[i].name) == 0)
  10500c:	83 ec 08             	sub    $0x8,%esp
  10500f:	ff 74 24 10          	push   0x10(%esp)
  105013:	ff 74 24 1c          	push   0x1c(%esp)
  105017:	e8 84 ee ff ff       	call   103ea0 <strcmp>
  10501c:	83 c4 10             	add    $0x10,%esp
  10501f:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  105023:	85 c0                	test   %eax,%eax
  105025:	0f 84 db 00 00 00    	je     105106 <monitor+0x1a6>
  10502b:	83 ec 08             	sub    $0x8,%esp
  10502e:	8d 83 c4 a3 ff ff    	lea    -0x5c3c(%ebx),%eax
  105034:	50                   	push   %eax
  105035:	ff 74 24 1c          	push   0x1c(%esp)
  105039:	e8 62 ee ff ff       	call   103ea0 <strcmp>
  10503e:	83 c4 10             	add    $0x10,%esp
  105041:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  105045:	85 c0                	test   %eax,%eax
  105047:	0f 84 e0 00 00 00    	je     10512d <monitor+0x1cd>
    dprintf("Unknown command '%s'\n", argv[0]);
  10504d:	83 ec 08             	sub    $0x8,%esp
  105050:	8d 83 48 a4 ff ff    	lea    -0x5bb8(%ebx),%eax
  105056:	ff 74 24 18          	push   0x18(%esp)
  10505a:	50                   	push   %eax
  10505b:	e8 e0 f1 ff ff       	call   104240 <dprintf>
    return 0;
  105060:	83 c4 10             	add    $0x10,%esp
  105063:	e9 68 ff ff ff       	jmp    104fd0 <monitor+0x70>
  105068:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10506f:	90                   	nop
  105070:	89 4c 24 04          	mov    %ecx,0x4(%esp)
        while (*buf && strchr(WHITESPACE, *buf))
  105074:	83 ec 08             	sub    $0x8,%esp
  105077:	52                   	push   %edx
  105078:	56                   	push   %esi
  105079:	e8 72 ee ff ff       	call   103ef0 <strchr>
  10507e:	83 c4 10             	add    $0x10,%esp
  105081:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  105085:	85 c0                	test   %eax,%eax
  105087:	74 17                	je     1050a0 <monitor+0x140>
            *buf++ = 0;
  105089:	8d 45 01             	lea    0x1(%ebp),%eax
  10508c:	c6 45 00 00          	movb   $0x0,0x0(%ebp)
  105090:	89 cf                	mov    %ecx,%edi
  105092:	89 c5                	mov    %eax,%ebp
  105094:	0f be 55 00          	movsbl 0x0(%ebp),%edx
  105098:	89 f9                	mov    %edi,%ecx
  10509a:	e9 59 ff ff ff       	jmp    104ff8 <monitor+0x98>
  10509f:	90                   	nop
        if (*buf == 0)
  1050a0:	80 7d 00 00          	cmpb   $0x0,0x0(%ebp)
  1050a4:	0f 84 52 ff ff ff    	je     104ffc <monitor+0x9c>
        if (argc == MAXARGS - 1) {
  1050aa:	83 f9 0f             	cmp    $0xf,%ecx
  1050ad:	74 3e                	je     1050ed <monitor+0x18d>
        argv[argc++] = buf;
  1050af:	89 6c 8c 10          	mov    %ebp,0x10(%esp,%ecx,4)
        while (*buf && !strchr(WHITESPACE, *buf))
  1050b3:	0f be 55 00          	movsbl 0x0(%ebp),%edx
        argv[argc++] = buf;
  1050b7:	8d 79 01             	lea    0x1(%ecx),%edi
        while (*buf && !strchr(WHITESPACE, *buf))
  1050ba:	0f be c2             	movsbl %dl,%eax
  1050bd:	84 d2                	test   %dl,%dl
  1050bf:	74 d7                	je     105098 <monitor+0x138>
  1050c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1050c8:	83 ec 08             	sub    $0x8,%esp
  1050cb:	50                   	push   %eax
  1050cc:	56                   	push   %esi
  1050cd:	e8 1e ee ff ff       	call   103ef0 <strchr>
  1050d2:	83 c4 10             	add    $0x10,%esp
  1050d5:	85 c0                	test   %eax,%eax
  1050d7:	75 bb                	jne    105094 <monitor+0x134>
  1050d9:	0f be 45 01          	movsbl 0x1(%ebp),%eax
            buf++;
  1050dd:	83 c5 01             	add    $0x1,%ebp
        while (*buf && !strchr(WHITESPACE, *buf))
  1050e0:	84 c0                	test   %al,%al
  1050e2:	75 e4                	jne    1050c8 <monitor+0x168>
  1050e4:	31 d2                	xor    %edx,%edx
            *buf++ = 0;
  1050e6:	89 f9                	mov    %edi,%ecx
  1050e8:	e9 0b ff ff ff       	jmp    104ff8 <monitor+0x98>
            dprintf("Too many arguments (max %d)\n", MAXARGS);
  1050ed:	83 ec 08             	sub    $0x8,%esp
  1050f0:	8d 83 2b a4 ff ff    	lea    -0x5bd5(%ebx),%eax
  1050f6:	6a 10                	push   $0x10
  1050f8:	50                   	push   %eax
  1050f9:	e8 42 f1 ff ff       	call   104240 <dprintf>
            return 0;
  1050fe:	83 c4 10             	add    $0x10,%esp
  105101:	e9 ca fe ff ff       	jmp    104fd0 <monitor+0x70>
        if (strcmp(argv[0], commands[i].name) == 0)
  105106:	8d 83 60 4e ff ff    	lea    -0xb1a0(%ebx),%eax
            return commands[i].func(argc, argv, tf);
  10510c:	83 ec 04             	sub    $0x4,%esp
  10510f:	ff 74 24 74          	push   0x74(%esp)
  105113:	ff 74 24 14          	push   0x14(%esp)
  105117:	51                   	push   %ecx
  105118:	ff d0                	call   *%eax
            if (runcmd(buf, tf) < 0)
  10511a:	83 c4 10             	add    $0x10,%esp
  10511d:	85 c0                	test   %eax,%eax
  10511f:	0f 89 ab fe ff ff    	jns    104fd0 <monitor+0x70>
                break;
    }
}
  105125:	83 c4 5c             	add    $0x5c,%esp
  105128:	5b                   	pop    %ebx
  105129:	5e                   	pop    %esi
  10512a:	5f                   	pop    %edi
  10512b:	5d                   	pop    %ebp
  10512c:	c3                   	ret    
        if (strcmp(argv[0], commands[i].name) == 0)
  10512d:	8d 83 b0 4e ff ff    	lea    -0xb150(%ebx),%eax
  105133:	eb d7                	jmp    10510c <monitor+0x1ac>
  105135:	66 90                	xchg   %ax,%ax
  105137:	66 90                	xchg   %ax,%ax
  105139:	66 90                	xchg   %ax,%ax
  10513b:	66 90                	xchg   %ax,%ax
  10513d:	66 90                	xchg   %ax,%ax
  10513f:	90                   	nop

00105140 <pt_copyin>:
                       unsigned int perm);
extern unsigned int get_ptbl_entry_by_va(unsigned int pid,
                                         unsigned int vaddr);

size_t pt_copyin(uint32_t pmap_id, uintptr_t uva, void *kva, size_t len)
{
  105140:	55                   	push   %ebp
    if (!(VM_USERLO <= uva && uva + len <= VM_USERHI))
        return 0;
  105141:	31 ed                	xor    %ebp,%ebp
{
  105143:	57                   	push   %edi
  105144:	56                   	push   %esi
  105145:	53                   	push   %ebx
  105146:	e8 3e b2 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10514b:	81 c3 b5 ae 00 00    	add    $0xaeb5,%ebx
  105151:	83 ec 1c             	sub    $0x1c,%esp
  105154:	8b 7c 24 34          	mov    0x34(%esp),%edi
  105158:	8b 74 24 3c          	mov    0x3c(%esp),%esi
    if (!(VM_USERLO <= uva && uva + len <= VM_USERHI))
  10515c:	81 ff ff ff ff 3f    	cmp    $0x3fffffff,%edi
  105162:	0f 86 b4 00 00 00    	jbe    10521c <pt_copyin+0xdc>
  105168:	8d 04 37             	lea    (%edi,%esi,1),%eax
  10516b:	3d 00 00 00 f0       	cmp    $0xf0000000,%eax
  105170:	0f 87 a6 00 00 00    	ja     10521c <pt_copyin+0xdc>

    if ((uintptr_t) kva + len > VM_USERHI)
  105176:	8b 44 24 38          	mov    0x38(%esp),%eax
  10517a:	01 f0                	add    %esi,%eax
  10517c:	3d 00 00 00 f0       	cmp    $0xf0000000,%eax
  105181:	0f 87 95 00 00 00    	ja     10521c <pt_copyin+0xdc>
        return 0;

    size_t copied = 0;

    while (len) {
  105187:	85 f6                	test   %esi,%esi
  105189:	0f 84 8d 00 00 00    	je     10521c <pt_copyin+0xdc>
            uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
        }

        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);

        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  10518f:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  105193:	8b 6c 24 38          	mov    0x38(%esp),%ebp
  105197:	eb 44                	jmp    1051dd <pt_copyin+0x9d>
  105199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  1051a0:	89 f9                	mov    %edi,%ecx
        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1051a2:	ba 00 10 00 00       	mov    $0x1000,%edx
        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  1051a7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  1051ac:	81 e1 ff 0f 00 00    	and    $0xfff,%ecx
        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1051b2:	29 ca                	sub    %ecx,%edx
        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  1051b4:	09 c8                	or     %ecx,%eax
        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1051b6:	39 f2                	cmp    %esi,%edx
  1051b8:	0f 47 d6             	cmova  %esi,%edx
            len : PAGESIZE - uva_pa % PAGESIZE;

        memcpy(kva, (void *) uva_pa, size);
  1051bb:	83 ec 04             	sub    $0x4,%esp
  1051be:	52                   	push   %edx
  1051bf:	89 54 24 10          	mov    %edx,0x10(%esp)
  1051c3:	50                   	push   %eax
  1051c4:	55                   	push   %ebp
  1051c5:	e8 46 ec ff ff       	call   103e10 <memcpy>

        len -= size;
        uva += size;
  1051ca:	8b 54 24 18          	mov    0x18(%esp),%edx
        kva += size;
        copied += size;
  1051ce:	01 54 24 1c          	add    %edx,0x1c(%esp)
    while (len) {
  1051d2:	83 c4 10             	add    $0x10,%esp
        uva += size;
  1051d5:	01 d7                	add    %edx,%edi
        kva += size;
  1051d7:	01 d5                	add    %edx,%ebp
    while (len) {
  1051d9:	29 d6                	sub    %edx,%esi
  1051db:	74 3b                	je     105218 <pt_copyin+0xd8>
        uintptr_t uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
  1051dd:	83 ec 08             	sub    $0x8,%esp
  1051e0:	57                   	push   %edi
  1051e1:	ff 74 24 3c          	push   0x3c(%esp)
  1051e5:	e8 f6 15 00 00       	call   1067e0 <get_ptbl_entry_by_va>
        if ((uva_pa & PTE_P) == 0) {
  1051ea:	83 c4 10             	add    $0x10,%esp
  1051ed:	a8 01                	test   $0x1,%al
  1051ef:	75 af                	jne    1051a0 <pt_copyin+0x60>
            alloc_page(pmap_id, uva, PTE_P | PTE_U | PTE_W);
  1051f1:	83 ec 04             	sub    $0x4,%esp
  1051f4:	6a 07                	push   $0x7
  1051f6:	57                   	push   %edi
  1051f7:	ff 74 24 3c          	push   0x3c(%esp)
  1051fb:	e8 90 1a 00 00       	call   106c90 <alloc_page>
            uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
  105200:	58                   	pop    %eax
  105201:	5a                   	pop    %edx
  105202:	57                   	push   %edi
  105203:	ff 74 24 3c          	push   0x3c(%esp)
  105207:	e8 d4 15 00 00       	call   1067e0 <get_ptbl_entry_by_va>
  10520c:	83 c4 10             	add    $0x10,%esp
  10520f:	eb 8f                	jmp    1051a0 <pt_copyin+0x60>
  105211:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105218:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
    }

    return copied;
}
  10521c:	83 c4 1c             	add    $0x1c,%esp
  10521f:	89 e8                	mov    %ebp,%eax
  105221:	5b                   	pop    %ebx
  105222:	5e                   	pop    %esi
  105223:	5f                   	pop    %edi
  105224:	5d                   	pop    %ebp
  105225:	c3                   	ret    
  105226:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10522d:	8d 76 00             	lea    0x0(%esi),%esi

00105230 <pt_copyout>:

size_t pt_copyout(void *kva, uint32_t pmap_id, uintptr_t uva, size_t len)
{
  105230:	55                   	push   %ebp
    if (!(VM_USERLO <= uva && uva + len <= VM_USERHI))
        return 0;
  105231:	31 ed                	xor    %ebp,%ebp
{
  105233:	57                   	push   %edi
  105234:	56                   	push   %esi
  105235:	53                   	push   %ebx
  105236:	e8 4e b1 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10523b:	81 c3 c5 ad 00 00    	add    $0xadc5,%ebx
  105241:	83 ec 1c             	sub    $0x1c,%esp
  105244:	8b 7c 24 38          	mov    0x38(%esp),%edi
  105248:	8b 74 24 3c          	mov    0x3c(%esp),%esi
    if (!(VM_USERLO <= uva && uva + len <= VM_USERHI))
  10524c:	81 ff ff ff ff 3f    	cmp    $0x3fffffff,%edi
  105252:	0f 86 b4 00 00 00    	jbe    10530c <pt_copyout+0xdc>
  105258:	8d 04 37             	lea    (%edi,%esi,1),%eax
  10525b:	3d 00 00 00 f0       	cmp    $0xf0000000,%eax
  105260:	0f 87 a6 00 00 00    	ja     10530c <pt_copyout+0xdc>

    if ((uintptr_t) kva + len > VM_USERHI)
  105266:	8b 44 24 30          	mov    0x30(%esp),%eax
  10526a:	01 f0                	add    %esi,%eax
  10526c:	3d 00 00 00 f0       	cmp    $0xf0000000,%eax
  105271:	0f 87 95 00 00 00    	ja     10530c <pt_copyout+0xdc>
        return 0;

    size_t copied = 0;

    while (len) {
  105277:	85 f6                	test   %esi,%esi
  105279:	0f 84 8d 00 00 00    	je     10530c <pt_copyout+0xdc>
            uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
        }

        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);

        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  10527f:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  105283:	8b 6c 24 30          	mov    0x30(%esp),%ebp
  105287:	eb 44                	jmp    1052cd <pt_copyout+0x9d>
  105289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  105290:	89 f9                	mov    %edi,%ecx
        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  105292:	ba 00 10 00 00       	mov    $0x1000,%edx
        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  105297:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  10529c:	81 e1 ff 0f 00 00    	and    $0xfff,%ecx
        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1052a2:	29 ca                	sub    %ecx,%edx
        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  1052a4:	09 c8                	or     %ecx,%eax
        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1052a6:	39 f2                	cmp    %esi,%edx
  1052a8:	0f 47 d6             	cmova  %esi,%edx
            len : PAGESIZE - uva_pa % PAGESIZE;

        memcpy((void *) uva_pa, kva, size);
  1052ab:	83 ec 04             	sub    $0x4,%esp
  1052ae:	52                   	push   %edx
  1052af:	89 54 24 10          	mov    %edx,0x10(%esp)
  1052b3:	55                   	push   %ebp
  1052b4:	50                   	push   %eax
  1052b5:	e8 56 eb ff ff       	call   103e10 <memcpy>

        len -= size;
        uva += size;
  1052ba:	8b 54 24 18          	mov    0x18(%esp),%edx
        kva += size;
        copied += size;
  1052be:	01 54 24 1c          	add    %edx,0x1c(%esp)
    while (len) {
  1052c2:	83 c4 10             	add    $0x10,%esp
        uva += size;
  1052c5:	01 d7                	add    %edx,%edi
        kva += size;
  1052c7:	01 d5                	add    %edx,%ebp
    while (len) {
  1052c9:	29 d6                	sub    %edx,%esi
  1052cb:	74 3b                	je     105308 <pt_copyout+0xd8>
        uintptr_t uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
  1052cd:	83 ec 08             	sub    $0x8,%esp
  1052d0:	57                   	push   %edi
  1052d1:	ff 74 24 40          	push   0x40(%esp)
  1052d5:	e8 06 15 00 00       	call   1067e0 <get_ptbl_entry_by_va>
        if ((uva_pa & PTE_P) == 0) {
  1052da:	83 c4 10             	add    $0x10,%esp
  1052dd:	a8 01                	test   $0x1,%al
  1052df:	75 af                	jne    105290 <pt_copyout+0x60>
            alloc_page(pmap_id, uva, PTE_P | PTE_U | PTE_W);
  1052e1:	83 ec 04             	sub    $0x4,%esp
  1052e4:	6a 07                	push   $0x7
  1052e6:	57                   	push   %edi
  1052e7:	ff 74 24 40          	push   0x40(%esp)
  1052eb:	e8 a0 19 00 00       	call   106c90 <alloc_page>
            uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
  1052f0:	58                   	pop    %eax
  1052f1:	5a                   	pop    %edx
  1052f2:	57                   	push   %edi
  1052f3:	ff 74 24 40          	push   0x40(%esp)
  1052f7:	e8 e4 14 00 00       	call   1067e0 <get_ptbl_entry_by_va>
  1052fc:	83 c4 10             	add    $0x10,%esp
  1052ff:	eb 8f                	jmp    105290 <pt_copyout+0x60>
  105301:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105308:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
    }

    return copied;
}
  10530c:	83 c4 1c             	add    $0x1c,%esp
  10530f:	89 e8                	mov    %ebp,%eax
  105311:	5b                   	pop    %ebx
  105312:	5e                   	pop    %esi
  105313:	5f                   	pop    %edi
  105314:	5d                   	pop    %ebp
  105315:	c3                   	ret    
  105316:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10531d:	8d 76 00             	lea    0x0(%esi),%esi

00105320 <pt_memset>:

size_t pt_memset(uint32_t pmap_id, uintptr_t va, char c, size_t len)
{
  105320:	55                   	push   %ebp
  105321:	57                   	push   %edi
  105322:	56                   	push   %esi
  105323:	53                   	push   %ebx
  105324:	e8 60 b0 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105329:	81 c3 d7 ac 00 00    	add    $0xacd7,%ebx
  10532f:	83 ec 1c             	sub    $0x1c,%esp
  105332:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  105336:	8b 7c 24 34          	mov    0x34(%esp),%edi
  10533a:	8b 44 24 38          	mov    0x38(%esp),%eax
    size_t set = 0;

    while (len) {
  10533e:	85 f6                	test   %esi,%esi
  105340:	0f 84 8a 00 00 00    	je     1053d0 <pt_memset+0xb0>
        pa = (pa & 0xfffff000) + (va % PAGESIZE);

        size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
            len : PAGESIZE - pa % PAGESIZE;

        memset((void *) pa, c, size);
  105346:	0f be c0             	movsbl %al,%eax
    size_t set = 0;
  105349:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  105350:	00 
        memset((void *) pa, c, size);
  105351:	89 44 24 0c          	mov    %eax,0xc(%esp)
  105355:	eb 41                	jmp    105398 <pt_memset+0x78>
  105357:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10535e:	66 90                	xchg   %ax,%ax
        pa = (pa & 0xfffff000) + (va % PAGESIZE);
  105360:	89 f9                	mov    %edi,%ecx
        size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
  105362:	ba 00 10 00 00       	mov    $0x1000,%edx
        pa = (pa & 0xfffff000) + (va % PAGESIZE);
  105367:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  10536c:	81 e1 ff 0f 00 00    	and    $0xfff,%ecx
        size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
  105372:	29 ca                	sub    %ecx,%edx
        pa = (pa & 0xfffff000) + (va % PAGESIZE);
  105374:	09 c8                	or     %ecx,%eax
        size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
  105376:	39 f2                	cmp    %esi,%edx
  105378:	0f 47 d6             	cmova  %esi,%edx
        memset((void *) pa, c, size);
  10537b:	83 ec 04             	sub    $0x4,%esp
  10537e:	52                   	push   %edx
        size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
  10537f:	89 d5                	mov    %edx,%ebp
        memset((void *) pa, c, size);
  105381:	ff 74 24 14          	push   0x14(%esp)

        len -= size;
        va += size;
  105385:	01 ef                	add    %ebp,%edi
        memset((void *) pa, c, size);
  105387:	50                   	push   %eax
  105388:	e8 c3 e9 ff ff       	call   103d50 <memset>
        set += size;
  10538d:	01 6c 24 18          	add    %ebp,0x18(%esp)
    while (len) {
  105391:	83 c4 10             	add    $0x10,%esp
  105394:	29 ee                	sub    %ebp,%esi
  105396:	74 40                	je     1053d8 <pt_memset+0xb8>
        uintptr_t pa = get_ptbl_entry_by_va(pmap_id, va);
  105398:	83 ec 08             	sub    $0x8,%esp
  10539b:	57                   	push   %edi
  10539c:	ff 74 24 3c          	push   0x3c(%esp)
  1053a0:	e8 3b 14 00 00       	call   1067e0 <get_ptbl_entry_by_va>
        if ((pa & PTE_P) == 0) {
  1053a5:	83 c4 10             	add    $0x10,%esp
  1053a8:	a8 01                	test   $0x1,%al
  1053aa:	75 b4                	jne    105360 <pt_memset+0x40>
            alloc_page(pmap_id, va, PTE_P | PTE_U | PTE_W);
  1053ac:	83 ec 04             	sub    $0x4,%esp
  1053af:	6a 07                	push   $0x7
  1053b1:	57                   	push   %edi
  1053b2:	ff 74 24 3c          	push   0x3c(%esp)
  1053b6:	e8 d5 18 00 00       	call   106c90 <alloc_page>
            pa = get_ptbl_entry_by_va(pmap_id, va);
  1053bb:	58                   	pop    %eax
  1053bc:	5a                   	pop    %edx
  1053bd:	57                   	push   %edi
  1053be:	ff 74 24 3c          	push   0x3c(%esp)
  1053c2:	e8 19 14 00 00       	call   1067e0 <get_ptbl_entry_by_va>
  1053c7:	83 c4 10             	add    $0x10,%esp
  1053ca:	eb 94                	jmp    105360 <pt_memset+0x40>
  1053cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    size_t set = 0;
  1053d0:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1053d7:	00 
    }

    return set;
}
  1053d8:	8b 44 24 08          	mov    0x8(%esp),%eax
  1053dc:	83 c4 1c             	add    $0x1c,%esp
  1053df:	5b                   	pop    %ebx
  1053e0:	5e                   	pop    %esi
  1053e1:	5f                   	pop    %edi
  1053e2:	5d                   	pop    %ebp
  1053e3:	c3                   	ret    
  1053e4:	66 90                	xchg   %ax,%ax
  1053e6:	66 90                	xchg   %ax,%ax
  1053e8:	66 90                	xchg   %ax,%ax
  1053ea:	66 90                	xchg   %ax,%ax
  1053ec:	66 90                	xchg   %ax,%ax
  1053ee:	66 90                	xchg   %ax,%ax

001053f0 <elf_load>:

/*
 * Load elf execution file exe to the virtual address space pmap.
 */
void elf_load(void *exe_ptr, int pid)
{
  1053f0:	55                   	push   %ebp
  1053f1:	57                   	push   %edi
  1053f2:	56                   	push   %esi
  1053f3:	53                   	push   %ebx
  1053f4:	e8 90 af ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1053f9:	81 c3 07 ac 00 00    	add    $0xac07,%ebx
  1053ff:	83 ec 2c             	sub    $0x2c,%esp
    char *strtab __attribute__((unused));
    uintptr_t exe = (uintptr_t) exe_ptr;

    eh = (elfhdr *) exe;

    KERN_ASSERT(eh->e_magic == ELF_MAGIC);
  105402:	8b 44 24 40          	mov    0x40(%esp),%eax
  105406:	81 38 7f 45 4c 46    	cmpl   $0x464c457f,(%eax)
  10540c:	74 1f                	je     10542d <elf_load+0x3d>
  10540e:	8d 83 31 a5 ff ff    	lea    -0x5acf(%ebx),%eax
  105414:	50                   	push   %eax
  105415:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  10541b:	50                   	push   %eax
  10541c:	8d 83 4a a5 ff ff    	lea    -0x5ab6(%ebx),%eax
  105422:	6a 1e                	push   $0x1e
  105424:	50                   	push   %eax
  105425:	e8 06 ec ff ff       	call   104030 <debug_panic>
  10542a:	83 c4 10             	add    $0x10,%esp
    KERN_ASSERT(eh->e_shstrndx != ELF_SHN_UNDEF);
  10542d:	8b 44 24 40          	mov    0x40(%esp),%eax
  105431:	0f b7 40 32          	movzwl 0x32(%eax),%eax
  105435:	66 85 c0             	test   %ax,%ax
  105438:	0f 84 92 01 00 00    	je     1055d0 <elf_load+0x1e0>

    sh = (sechdr *) ((uintptr_t) eh + eh->e_shoff);
    esh = sh + eh->e_shnum;

    strtab = (char *) (exe + sh[eh->e_shstrndx].sh_offset);
    KERN_ASSERT(sh[eh->e_shstrndx].sh_type == ELF_SHT_STRTAB);
  10543e:	8b 4c 24 40          	mov    0x40(%esp),%ecx
  105442:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105445:	8d 04 c1             	lea    (%ecx,%eax,8),%eax
  105448:	03 41 20             	add    0x20(%ecx),%eax
  10544b:	83 78 04 03          	cmpl   $0x3,0x4(%eax)
  10544f:	74 1f                	je     105470 <elf_load+0x80>
  105451:	8d 83 7c a5 ff ff    	lea    -0x5a84(%ebx),%eax
  105457:	50                   	push   %eax
  105458:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  10545e:	50                   	push   %eax
  10545f:	8d 83 4a a5 ff ff    	lea    -0x5ab6(%ebx),%eax
  105465:	6a 25                	push   $0x25
  105467:	50                   	push   %eax
  105468:	e8 c3 eb ff ff       	call   104030 <debug_panic>
  10546d:	83 c4 10             	add    $0x10,%esp

    ph = (proghdr *) ((uintptr_t) eh + eh->e_phoff);
  105470:	8b 44 24 40          	mov    0x40(%esp),%eax
  105474:	8b 68 1c             	mov    0x1c(%eax),%ebp
  105477:	01 c5                	add    %eax,%ebp
    eph = ph + eh->e_phnum;
  105479:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  10547d:	c1 e0 05             	shl    $0x5,%eax
  105480:	01 e8                	add    %ebp,%eax
  105482:	89 44 24 18          	mov    %eax,0x18(%esp)

    for (; ph < eph; ph++) {
  105486:	39 c5                	cmp    %eax,%ebp
  105488:	72 13                	jb     10549d <elf_load+0xad>
  10548a:	e9 32 01 00 00       	jmp    1055c1 <elf_load+0x1d1>
  10548f:	90                   	nop
  105490:	83 c5 20             	add    $0x20,%ebp
  105493:	39 6c 24 18          	cmp    %ebp,0x18(%esp)
  105497:	0f 86 24 01 00 00    	jbe    1055c1 <elf_load+0x1d1>
        uintptr_t fa;
        uint32_t va, zva, eva, perm;

        if (ph->p_type != ELF_PROG_LOAD)
  10549d:	83 7d 00 01          	cmpl   $0x1,0x0(%ebp)
  1054a1:	75 ed                	jne    105490 <elf_load+0xa0>
            continue;

        fa = (uintptr_t) eh + rounddown(ph->p_offset, PAGESIZE);
  1054a3:	83 ec 08             	sub    $0x8,%esp
  1054a6:	68 00 10 00 00       	push   $0x1000
  1054ab:	ff 75 04             	push   0x4(%ebp)
  1054ae:	e8 ed f6 ff ff       	call   104ba0 <rounddown>
  1054b3:	03 44 24 50          	add    0x50(%esp),%eax
        va = rounddown(ph->p_va, PAGESIZE);
  1054b7:	5f                   	pop    %edi
        fa = (uintptr_t) eh + rounddown(ph->p_offset, PAGESIZE);
  1054b8:	89 c6                	mov    %eax,%esi
        va = rounddown(ph->p_va, PAGESIZE);
  1054ba:	58                   	pop    %eax
  1054bb:	68 00 10 00 00       	push   $0x1000
  1054c0:	ff 75 08             	push   0x8(%ebp)
  1054c3:	e8 d8 f6 ff ff       	call   104ba0 <rounddown>
        zva = ph->p_va + ph->p_filesz;
  1054c8:	8b 4d 10             	mov    0x10(%ebp),%ecx
        va = rounddown(ph->p_va, PAGESIZE);
  1054cb:	89 c7                	mov    %eax,%edi
        zva = ph->p_va + ph->p_filesz;
  1054cd:	8b 45 08             	mov    0x8(%ebp),%eax
  1054d0:	01 c1                	add    %eax,%ecx
  1054d2:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
        eva = roundup(ph->p_va + ph->p_memsz, PAGESIZE);
  1054d6:	5a                   	pop    %edx
  1054d7:	59                   	pop    %ecx
  1054d8:	68 00 10 00 00       	push   $0x1000
  1054dd:	03 45 14             	add    0x14(%ebp),%eax
  1054e0:	50                   	push   %eax
  1054e1:	e8 da f6 ff ff       	call   104bc0 <roundup>
  1054e6:	89 44 24 20          	mov    %eax,0x20(%esp)
  1054ea:	89 c1                	mov    %eax,%ecx

        perm = PTE_U | PTE_P;
        if (ph->p_flags & ELF_PROG_FLAG_WRITE)
  1054ec:	8b 45 18             	mov    0x18(%ebp),%eax
  1054ef:	83 c4 10             	add    $0x10,%esp
  1054f2:	83 e0 02             	and    $0x2,%eax
            perm |= PTE_W;
  1054f5:	83 f8 01             	cmp    $0x1,%eax
  1054f8:	19 d2                	sbb    %edx,%edx
  1054fa:	83 e2 fe             	and    $0xfffffffe,%edx
  1054fd:	83 c2 07             	add    $0x7,%edx
  105500:	89 54 24 14          	mov    %edx,0x14(%esp)

        for (; va < eva; va += PAGESIZE, fa += PAGESIZE) {
  105504:	39 cf                	cmp    %ecx,%edi
  105506:	73 88                	jae    105490 <elf_load+0xa0>
  105508:	89 6c 24 1c          	mov    %ebp,0x1c(%esp)
  10550c:	8b 6c 24 44          	mov    0x44(%esp),%ebp
  105510:	eb 3a                	jmp    10554c <elf_load+0x15c>
  105512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            alloc_page(pid, va, perm);

            if (va < rounddown(zva, PAGESIZE)) {
                /* copy a complete page */
                pt_copyout((void *) fa, pid, va, PAGESIZE);
            } else if (va < zva && ph->p_filesz) {
  105518:	39 7c 24 0c          	cmp    %edi,0xc(%esp)
  10551c:	76 0b                	jbe    105529 <elf_load+0x139>
  10551e:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  105522:	8b 40 10             	mov    0x10(%eax),%eax
  105525:	85 c0                	test   %eax,%eax
  105527:	75 5f                	jne    105588 <elf_load+0x198>
                /* copy a partial page */
                pt_memset(pid, va, 0, PAGESIZE);
                pt_copyout((void *) fa, pid, va, zva - va);
            } else {
                /* zero a page */
                pt_memset(pid, va, 0, PAGESIZE);
  105529:	68 00 10 00 00       	push   $0x1000
  10552e:	6a 00                	push   $0x0
  105530:	57                   	push   %edi
  105531:	55                   	push   %ebp
  105532:	e8 e9 fd ff ff       	call   105320 <pt_memset>
  105537:	83 c4 10             	add    $0x10,%esp
        for (; va < eva; va += PAGESIZE, fa += PAGESIZE) {
  10553a:	81 c7 00 10 00 00    	add    $0x1000,%edi
  105540:	81 c6 00 10 00 00    	add    $0x1000,%esi
  105546:	39 7c 24 10          	cmp    %edi,0x10(%esp)
  10554a:	76 64                	jbe    1055b0 <elf_load+0x1c0>
            alloc_page(pid, va, perm);
  10554c:	83 ec 04             	sub    $0x4,%esp
  10554f:	ff 74 24 18          	push   0x18(%esp)
  105553:	57                   	push   %edi
  105554:	55                   	push   %ebp
  105555:	e8 36 17 00 00       	call   106c90 <alloc_page>
            if (va < rounddown(zva, PAGESIZE)) {
  10555a:	5a                   	pop    %edx
  10555b:	59                   	pop    %ecx
  10555c:	68 00 10 00 00       	push   $0x1000
  105561:	ff 74 24 18          	push   0x18(%esp)
  105565:	e8 36 f6 ff ff       	call   104ba0 <rounddown>
  10556a:	83 c4 10             	add    $0x10,%esp
  10556d:	39 f8                	cmp    %edi,%eax
  10556f:	76 a7                	jbe    105518 <elf_load+0x128>
                pt_copyout((void *) fa, pid, va, PAGESIZE);
  105571:	68 00 10 00 00       	push   $0x1000
  105576:	57                   	push   %edi
  105577:	55                   	push   %ebp
  105578:	56                   	push   %esi
  105579:	e8 b2 fc ff ff       	call   105230 <pt_copyout>
  10557e:	83 c4 10             	add    $0x10,%esp
  105581:	eb b7                	jmp    10553a <elf_load+0x14a>
  105583:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  105587:	90                   	nop
                pt_memset(pid, va, 0, PAGESIZE);
  105588:	68 00 10 00 00       	push   $0x1000
  10558d:	6a 00                	push   $0x0
  10558f:	57                   	push   %edi
  105590:	55                   	push   %ebp
  105591:	e8 8a fd ff ff       	call   105320 <pt_memset>
                pt_copyout((void *) fa, pid, va, zva - va);
  105596:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  10559a:	29 f8                	sub    %edi,%eax
  10559c:	50                   	push   %eax
  10559d:	57                   	push   %edi
  10559e:	55                   	push   %ebp
  10559f:	56                   	push   %esi
  1055a0:	e8 8b fc ff ff       	call   105230 <pt_copyout>
  1055a5:	83 c4 20             	add    $0x20,%esp
  1055a8:	eb 90                	jmp    10553a <elf_load+0x14a>
  1055aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1055b0:	8b 6c 24 1c          	mov    0x1c(%esp),%ebp
    for (; ph < eph; ph++) {
  1055b4:	83 c5 20             	add    $0x20,%ebp
  1055b7:	39 6c 24 18          	cmp    %ebp,0x18(%esp)
  1055bb:	0f 87 dc fe ff ff    	ja     10549d <elf_load+0xad>
            }
        }
    }
}
  1055c1:	83 c4 2c             	add    $0x2c,%esp
  1055c4:	5b                   	pop    %ebx
  1055c5:	5e                   	pop    %esi
  1055c6:	5f                   	pop    %edi
  1055c7:	5d                   	pop    %ebp
  1055c8:	c3                   	ret    
  1055c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    KERN_ASSERT(eh->e_shstrndx != ELF_SHN_UNDEF);
  1055d0:	8d 83 5c a5 ff ff    	lea    -0x5aa4(%ebx),%eax
  1055d6:	50                   	push   %eax
  1055d7:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  1055dd:	50                   	push   %eax
  1055de:	8d 83 4a a5 ff ff    	lea    -0x5ab6(%ebx),%eax
  1055e4:	6a 1f                	push   $0x1f
  1055e6:	50                   	push   %eax
  1055e7:	e8 44 ea ff ff       	call   104030 <debug_panic>
    strtab = (char *) (exe + sh[eh->e_shstrndx].sh_offset);
  1055ec:	8b 44 24 50          	mov    0x50(%esp),%eax
  1055f0:	83 c4 10             	add    $0x10,%esp
  1055f3:	0f b7 40 32          	movzwl 0x32(%eax),%eax
  1055f7:	e9 42 fe ff ff       	jmp    10543e <elf_load+0x4e>
  1055fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00105600 <elf_entry>:

uintptr_t elf_entry(void *exe_ptr)
{
  105600:	56                   	push   %esi
  105601:	53                   	push   %ebx
  105602:	e8 82 ad ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105607:	81 c3 f9 a9 00 00    	add    $0xa9f9,%ebx
  10560d:	83 ec 04             	sub    $0x4,%esp
  105610:	8b 74 24 10          	mov    0x10(%esp),%esi
    uintptr_t exe = (uintptr_t) exe_ptr;
    elfhdr *eh = (elfhdr *) exe;
    KERN_ASSERT(eh->e_magic == ELF_MAGIC);
  105614:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10561a:	74 1f                	je     10563b <elf_entry+0x3b>
  10561c:	8d 83 31 a5 ff ff    	lea    -0x5acf(%ebx),%eax
  105622:	50                   	push   %eax
  105623:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  105629:	50                   	push   %eax
  10562a:	8d 83 4a a5 ff ff    	lea    -0x5ab6(%ebx),%eax
  105630:	6a 50                	push   $0x50
  105632:	50                   	push   %eax
  105633:	e8 f8 e9 ff ff       	call   104030 <debug_panic>
  105638:	83 c4 10             	add    $0x10,%esp
    return (uintptr_t) eh->e_entry;
  10563b:	8b 46 18             	mov    0x18(%esi),%eax
}
  10563e:	83 c4 04             	add    $0x4,%esp
  105641:	5b                   	pop    %ebx
  105642:	5e                   	pop    %esi
  105643:	c3                   	ret    
  105644:	66 90                	xchg   %ax,%ax
  105646:	66 90                	xchg   %ax,%ax
  105648:	66 90                	xchg   %ax,%ax
  10564a:	66 90                	xchg   %ax,%ax
  10564c:	66 90                	xchg   %ax,%ax
  10564e:	66 90                	xchg   %ax,%ax

00105650 <get_kstack_pointer>:

struct kstack bsp_kstack[NUM_CPUS];
struct kstack proc_kstack[NUM_IDS];

uintptr_t *get_kstack_pointer(void)
{
  105650:	53                   	push   %ebx
  105651:	e8 33 ad ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105656:	81 c3 aa a9 00 00    	add    $0xa9aa,%ebx
  10565c:	83 ec 08             	sub    $0x8,%esp
    return (uintptr_t *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  10565f:	e8 7c f5 ff ff       	call   104be0 <read_esp>
}
  105664:	83 c4 08             	add    $0x8,%esp
    return (uintptr_t *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  105667:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
  10566c:	5b                   	pop    %ebx
  10566d:	c3                   	ret    
  10566e:	66 90                	xchg   %ax,%ax

00105670 <get_kstack_cpu_idx>:

int get_kstack_cpu_idx(void)
{
  105670:	53                   	push   %ebx
  105671:	e8 13 ad ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105676:	81 c3 8a a9 00 00    	add    $0xa98a,%ebx
  10567c:	83 ec 08             	sub    $0x8,%esp
    return (uintptr_t *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  10567f:	e8 5c f5 ff ff       	call   104be0 <read_esp>
  105684:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    struct kstack *ks = (struct kstack *) get_kstack_pointer();
    return ks->cpu_idx;
  105689:	8b 80 1c 01 00 00    	mov    0x11c(%eax),%eax
}
  10568f:	83 c4 08             	add    $0x8,%esp
  105692:	5b                   	pop    %ebx
  105693:	c3                   	ret    
  105694:	66 90                	xchg   %ax,%ax
  105696:	66 90                	xchg   %ax,%ax
  105698:	66 90                	xchg   %ax,%ax
  10569a:	66 90                	xchg   %ax,%ax
  10569c:	66 90                	xchg   %ax,%ax
  10569e:	66 90                	xchg   %ax,%ax

001056a0 <spinlock_init>:
#include "spinlock.h"

extern volatile uint64_t tsc_per_ms;

void gcc_inline spinlock_init(spinlock_t *lk)
{
  1056a0:	8b 44 24 04          	mov    0x4(%esp),%eax
    lk->lock_holder = NUM_CPUS + 1;
  1056a4:	c7 00 09 00 00 00    	movl   $0x9,(%eax)
    lk->lock = 0;
  1056aa:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
}
  1056b1:	c3                   	ret    
  1056b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1056b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001056c0 <spinlock_holding>:

bool gcc_inline spinlock_holding(spinlock_t *lk)
{
  1056c0:	57                   	push   %edi
  1056c1:	31 c0                	xor    %eax,%eax
  1056c3:	56                   	push   %esi
  1056c4:	53                   	push   %ebx
  1056c5:	8b 74 24 10          	mov    0x10(%esp),%esi
  1056c9:	e8 bb ac ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1056ce:	81 c3 32 a9 00 00    	add    $0xa932,%ebx
    if (!lk->lock)
  1056d4:	8b 56 04             	mov    0x4(%esi),%edx
  1056d7:	85 d2                	test   %edx,%edx
  1056d9:	75 05                	jne    1056e0 <spinlock_holding+0x20>
        return FALSE;

    struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
    KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
    return lk->lock_holder == kstack->cpu_idx;
}
  1056db:	5b                   	pop    %ebx
  1056dc:	5e                   	pop    %esi
  1056dd:	5f                   	pop    %edi
  1056de:	c3                   	ret    
  1056df:	90                   	nop
    struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  1056e0:	e8 fb f4 ff ff       	call   104be0 <read_esp>
  1056e5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  1056ea:	81 b8 20 01 00 00 32 	cmpl   $0x98765432,0x120(%eax)
  1056f1:	54 76 98 
    struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  1056f4:	89 c7                	mov    %eax,%edi
    KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  1056f6:	74 1f                	je     105717 <spinlock_holding+0x57>
  1056f8:	8d 83 a9 a5 ff ff    	lea    -0x5a57(%ebx),%eax
  1056fe:	50                   	push   %eax
  1056ff:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  105705:	50                   	push   %eax
  105706:	8d 83 c7 a5 ff ff    	lea    -0x5a39(%ebx),%eax
  10570c:	6a 16                	push   $0x16
  10570e:	50                   	push   %eax
  10570f:	e8 1c e9 ff ff       	call   104030 <debug_panic>
  105714:	83 c4 10             	add    $0x10,%esp
    return lk->lock_holder == kstack->cpu_idx;
  105717:	8b 87 1c 01 00 00    	mov    0x11c(%edi),%eax
  10571d:	39 06                	cmp    %eax,(%esi)
}
  10571f:	5b                   	pop    %ebx
    return lk->lock_holder == kstack->cpu_idx;
  105720:	0f 94 c0             	sete   %al
}
  105723:	5e                   	pop    %esi
  105724:	5f                   	pop    %edi
  105725:	c3                   	ret    
  105726:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10572d:	8d 76 00             	lea    0x0(%esi),%esi

00105730 <spinlock_acquire>:

    return spinlock_try_acquire_A(lk);
}
#else   /* DEBUG_LOCKHOLDING */
void gcc_inline spinlock_acquire(spinlock_t *lk)
{
  105730:	57                   	push   %edi
  105731:	56                   	push   %esi
  105732:	53                   	push   %ebx
  105733:	8b 7c 24 10          	mov    0x10(%esp),%edi
    while (xchg(&lk->lock, 1) != 0)
  105737:	e8 4d ac ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10573c:	81 c3 c4 a8 00 00    	add    $0xa8c4,%ebx
  105742:	8d 77 04             	lea    0x4(%edi),%esi
  105745:	eb 0e                	jmp    105755 <spinlock_acquire+0x25>
  105747:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10574e:	66 90                	xchg   %ax,%ax
        pause();
  105750:	e8 0b f5 ff ff       	call   104c60 <pause>
    while (xchg(&lk->lock, 1) != 0)
  105755:	83 ec 08             	sub    $0x8,%esp
  105758:	6a 01                	push   $0x1
  10575a:	56                   	push   %esi
  10575b:	e8 10 f5 ff ff       	call   104c70 <xchg>
  105760:	83 c4 10             	add    $0x10,%esp
  105763:	85 c0                	test   %eax,%eax
  105765:	75 e9                	jne    105750 <spinlock_acquire+0x20>
    struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  105767:	e8 74 f4 ff ff       	call   104be0 <read_esp>
  10576c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  105771:	81 b8 20 01 00 00 32 	cmpl   $0x98765432,0x120(%eax)
  105778:	54 76 98 
    struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  10577b:	89 c6                	mov    %eax,%esi
    KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  10577d:	74 1f                	je     10579e <spinlock_acquire+0x6e>
  10577f:	8d 83 a9 a5 ff ff    	lea    -0x5a57(%ebx),%eax
  105785:	50                   	push   %eax
  105786:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  10578c:	50                   	push   %eax
  10578d:	8d 83 c7 a5 ff ff    	lea    -0x5a39(%ebx),%eax
  105793:	6a 2f                	push   $0x2f
  105795:	50                   	push   %eax
  105796:	e8 95 e8 ff ff       	call   104030 <debug_panic>
  10579b:	83 c4 10             	add    $0x10,%esp
    lk->lock_holder = kstack->cpu_idx;
  10579e:	8b 86 1c 01 00 00    	mov    0x11c(%esi),%eax
  1057a4:	89 07                	mov    %eax,(%edi)
    spinlock_acquire_A(lk);
}
  1057a6:	5b                   	pop    %ebx
  1057a7:	5e                   	pop    %esi
  1057a8:	5f                   	pop    %edi
  1057a9:	c3                   	ret    
  1057aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001057b0 <spinlock_release>:

void gcc_inline spinlock_release(spinlock_t *lk)
{
  1057b0:	53                   	push   %ebx
  1057b1:	e8 d3 ab ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1057b6:	81 c3 4a a8 00 00    	add    $0xa84a,%ebx
  1057bc:	83 ec 10             	sub    $0x10,%esp
  1057bf:	8b 44 24 18          	mov    0x18(%esp),%eax
    lk->lock_holder = NUM_CPUS + 1;
  1057c3:	c7 00 09 00 00 00    	movl   $0x9,(%eax)
    xchg(&lk->lock, 0);
  1057c9:	83 c0 04             	add    $0x4,%eax
  1057cc:	6a 00                	push   $0x0
  1057ce:	50                   	push   %eax
  1057cf:	e8 9c f4 ff ff       	call   104c70 <xchg>
    spinlock_release_A(lk);
}
  1057d4:	83 c4 18             	add    $0x18,%esp
  1057d7:	5b                   	pop    %ebx
  1057d8:	c3                   	ret    
  1057d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001057e0 <spinlock_try_acquire>:

int gcc_inline spinlock_try_acquire(spinlock_t *lk)
{
  1057e0:	55                   	push   %ebp
  1057e1:	57                   	push   %edi
  1057e2:	56                   	push   %esi
  1057e3:	53                   	push   %ebx
  1057e4:	e8 a0 ab ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1057e9:	81 c3 17 a8 00 00    	add    $0xa817,%ebx
  1057ef:	83 ec 14             	sub    $0x14,%esp
  1057f2:	8b 7c 24 28          	mov    0x28(%esp),%edi
    uint32_t old_val = xchg(&lk->lock, 1);
  1057f6:	6a 01                	push   $0x1
  1057f8:	8d 47 04             	lea    0x4(%edi),%eax
  1057fb:	50                   	push   %eax
  1057fc:	e8 6f f4 ff ff       	call   104c70 <xchg>
    if (old_val == 0) {
  105801:	83 c4 10             	add    $0x10,%esp
    uint32_t old_val = xchg(&lk->lock, 1);
  105804:	89 c6                	mov    %eax,%esi
    if (old_val == 0) {
  105806:	85 c0                	test   %eax,%eax
  105808:	74 0e                	je     105818 <spinlock_try_acquire+0x38>
    return spinlock_try_acquire_A(lk);
}
  10580a:	83 c4 0c             	add    $0xc,%esp
  10580d:	89 f0                	mov    %esi,%eax
  10580f:	5b                   	pop    %ebx
  105810:	5e                   	pop    %esi
  105811:	5f                   	pop    %edi
  105812:	5d                   	pop    %ebp
  105813:	c3                   	ret    
  105814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  105818:	e8 c3 f3 ff ff       	call   104be0 <read_esp>
  10581d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
        KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  105822:	81 b8 20 01 00 00 32 	cmpl   $0x98765432,0x120(%eax)
  105829:	54 76 98 
        struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  10582c:	89 c5                	mov    %eax,%ebp
        KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  10582e:	75 18                	jne    105848 <spinlock_try_acquire+0x68>
        lk->lock_holder = kstack->cpu_idx;
  105830:	8b 85 1c 01 00 00    	mov    0x11c(%ebp),%eax
  105836:	89 07                	mov    %eax,(%edi)
}
  105838:	83 c4 0c             	add    $0xc,%esp
  10583b:	89 f0                	mov    %esi,%eax
  10583d:	5b                   	pop    %ebx
  10583e:	5e                   	pop    %esi
  10583f:	5f                   	pop    %edi
  105840:	5d                   	pop    %ebp
  105841:	c3                   	ret    
  105842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  105848:	8d 83 a9 a5 ff ff    	lea    -0x5a57(%ebx),%eax
  10584e:	50                   	push   %eax
  10584f:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  105855:	50                   	push   %eax
  105856:	8d 83 c7 a5 ff ff    	lea    -0x5a39(%ebx),%eax
  10585c:	6a 39                	push   $0x39
  10585e:	50                   	push   %eax
  10585f:	e8 cc e7 ff ff       	call   104030 <debug_panic>
        lk->lock_holder = kstack->cpu_idx;
  105864:	8b 85 1c 01 00 00    	mov    0x11c(%ebp),%eax
        KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  10586a:	83 c4 10             	add    $0x10,%esp
        lk->lock_holder = kstack->cpu_idx;
  10586d:	89 07                	mov    %eax,(%edi)
  10586f:	eb c7                	jmp    105838 <spinlock_try_acquire+0x58>
  105871:	66 90                	xchg   %ax,%ax
  105873:	66 90                	xchg   %ax,%ax
  105875:	66 90                	xchg   %ax,%ax
  105877:	66 90                	xchg   %ax,%ax
  105879:	66 90                	xchg   %ax,%ax
  10587b:	66 90                	xchg   %ax,%ax
  10587d:	66 90                	xchg   %ax,%ax
  10587f:	90                   	nop

00105880 <reentrantlock_init>:
#include "reentrant_lock.h"

#define UNLOCKED    0xFFFFFFFF

void reentrantlock_init(reentrantlock *lk)
{
  105880:	8b 44 24 04          	mov    0x4(%esp),%eax
    lk->lock = UNLOCKED;
  105884:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    lk->count = 0u;
  10588a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
}
  105891:	c3                   	ret    
  105892:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001058a0 <reentrantlock_holding>:

bool reentrantlock_holding(reentrantlock *lk)
{
    if (lk->count > 0u)
  1058a0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1058a4:	8b 40 04             	mov    0x4(%eax),%eax
  1058a7:	85 c0                	test   %eax,%eax
  1058a9:	0f 95 c0             	setne  %al
        return TRUE;
    else
        return FALSE;
}
  1058ac:	c3                   	ret    
  1058ad:	8d 76 00             	lea    0x0(%esi),%esi

001058b0 <reentrantlock_acquire>:

void reentrantlock_acquire(reentrantlock *lk)
{
  1058b0:	57                   	push   %edi
  1058b1:	56                   	push   %esi
  1058b2:	53                   	push   %ebx
  1058b3:	8b 7c 24 10          	mov    0x10(%esp),%edi
  1058b7:	e8 cd aa ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1058bc:	81 c3 44 a7 00 00    	add    $0xa744,%ebx
    uint32_t cpuid = get_kstack_cpu_idx();
  1058c2:	e8 a9 fd ff ff       	call   105670 <get_kstack_cpu_idx>
  1058c7:	89 c6                	mov    %eax,%esi
  1058c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uint32_t lv;

    do {
        lv = cmpxchg(&lk->lock, UNLOCKED, cpuid);
  1058d0:	83 ec 04             	sub    $0x4,%esp
  1058d3:	56                   	push   %esi
  1058d4:	6a ff                	push   $0xffffffff
  1058d6:	57                   	push   %edi
  1058d7:	e8 a4 f3 ff ff       	call   104c80 <cmpxchg>
    } while (lv != cpuid && lv != UNLOCKED);
  1058dc:	83 c4 10             	add    $0x10,%esp
  1058df:	39 c6                	cmp    %eax,%esi
  1058e1:	74 05                	je     1058e8 <reentrantlock_acquire+0x38>
  1058e3:	83 f8 ff             	cmp    $0xffffffff,%eax
  1058e6:	75 e8                	jne    1058d0 <reentrantlock_acquire+0x20>
    lk->count++;
  1058e8:	8b 47 04             	mov    0x4(%edi),%eax
  1058eb:	83 c0 01             	add    $0x1,%eax
  1058ee:	89 47 04             	mov    %eax,0x4(%edi)
}
  1058f1:	5b                   	pop    %ebx
  1058f2:	5e                   	pop    %esi
  1058f3:	5f                   	pop    %edi
  1058f4:	c3                   	ret    
  1058f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1058fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00105900 <reentrantlock_try_acquire>:

int reentrantlock_try_acquire(reentrantlock *lk)
{
  105900:	57                   	push   %edi
  105901:	56                   	push   %esi
  105902:	53                   	push   %ebx
  105903:	8b 7c 24 10          	mov    0x10(%esp),%edi
  105907:	e8 7d aa ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10590c:	81 c3 f4 a6 00 00    	add    $0xa6f4,%ebx
    uint32_t cpuid = get_kstack_cpu_idx();
  105912:	e8 59 fd ff ff       	call   105670 <get_kstack_cpu_idx>
    uint32_t lv;

    lv = cmpxchg(&lk->lock, UNLOCKED, cpuid);
  105917:	83 ec 04             	sub    $0x4,%esp
  10591a:	50                   	push   %eax
    uint32_t cpuid = get_kstack_cpu_idx();
  10591b:	89 c6                	mov    %eax,%esi
    lv = cmpxchg(&lk->lock, UNLOCKED, cpuid);
  10591d:	6a ff                	push   $0xffffffff
  10591f:	57                   	push   %edi
  105920:	e8 5b f3 ff ff       	call   104c80 <cmpxchg>

    if (lv == cpuid || lv == UNLOCKED) {
  105925:	83 c4 10             	add    $0x10,%esp
  105928:	39 c6                	cmp    %eax,%esi
  10592a:	74 14                	je     105940 <reentrantlock_try_acquire+0x40>
        lk->count++;
        return 1;
    } else
        return 0;
  10592c:	31 d2                	xor    %edx,%edx
    if (lv == cpuid || lv == UNLOCKED) {
  10592e:	83 f8 ff             	cmp    $0xffffffff,%eax
  105931:	74 0d                	je     105940 <reentrantlock_try_acquire+0x40>
}
  105933:	5b                   	pop    %ebx
  105934:	89 d0                	mov    %edx,%eax
  105936:	5e                   	pop    %esi
  105937:	5f                   	pop    %edi
  105938:	c3                   	ret    
  105939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        lk->count++;
  105940:	8b 47 04             	mov    0x4(%edi),%eax
        return 1;
  105943:	ba 01 00 00 00       	mov    $0x1,%edx
        lk->count++;
  105948:	83 c0 01             	add    $0x1,%eax
  10594b:	89 47 04             	mov    %eax,0x4(%edi)
}
  10594e:	89 d0                	mov    %edx,%eax
  105950:	5b                   	pop    %ebx
  105951:	5e                   	pop    %esi
  105952:	5f                   	pop    %edi
  105953:	c3                   	ret    
  105954:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10595b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10595f:	90                   	nop

00105960 <reentrantlock_release>:

void reentrantlock_release(reentrantlock *lk)
{
  105960:	53                   	push   %ebx
  105961:	e8 23 aa ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105966:	81 c3 9a a6 00 00    	add    $0xa69a,%ebx
  10596c:	83 ec 08             	sub    $0x8,%esp
  10596f:	8b 44 24 10          	mov    0x10(%esp),%eax
    lk->count--;
  105973:	8b 50 04             	mov    0x4(%eax),%edx
  105976:	83 ea 01             	sub    $0x1,%edx
  105979:	89 50 04             	mov    %edx,0x4(%eax)
    if (lk->count == 0u) {
  10597c:	8b 50 04             	mov    0x4(%eax),%edx
  10597f:	85 d2                	test   %edx,%edx
  105981:	74 0d                	je     105990 <reentrantlock_release+0x30>
        xchg(&lk->lock, UNLOCKED);
    }
}
  105983:	83 c4 08             	add    $0x8,%esp
  105986:	5b                   	pop    %ebx
  105987:	c3                   	ret    
  105988:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10598f:	90                   	nop
        xchg(&lk->lock, UNLOCKED);
  105990:	83 ec 08             	sub    $0x8,%esp
  105993:	6a ff                	push   $0xffffffff
  105995:	50                   	push   %eax
  105996:	e8 d5 f2 ff ff       	call   104c70 <xchg>
  10599b:	83 c4 10             	add    $0x10,%esp
}
  10599e:	83 c4 08             	add    $0x8,%esp
  1059a1:	5b                   	pop    %ebx
  1059a2:	c3                   	ret    
  1059a3:	66 90                	xchg   %ax,%ax
  1059a5:	66 90                	xchg   %ax,%ax
  1059a7:	66 90                	xchg   %ax,%ax
  1059a9:	66 90                	xchg   %ax,%ax
  1059ab:	66 90                	xchg   %ax,%ax
  1059ad:	66 90                	xchg   %ax,%ax
  1059af:	90                   	nop

001059b0 <pcpu_set_zero>:
struct pcpu pcpu[NUM_CPUS];

extern int get_kstack_cpu_idx(void);

void pcpu_set_zero()
{
  1059b0:	53                   	push   %ebx
  1059b1:	e8 d3 a9 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1059b6:	81 c3 4a a6 00 00    	add    $0xa64a,%ebx
  1059bc:	83 ec 10             	sub    $0x10,%esp
    memzero(pcpu, sizeof(struct pcpu) * NUM_CPUS);
  1059bf:	68 80 02 00 00       	push   $0x280
  1059c4:	8d 83 00 10 07 00    	lea    0x71000(%ebx),%eax
  1059ca:	50                   	push   %eax
  1059cb:	e8 60 e5 ff ff       	call   103f30 <memzero>
}
  1059d0:	83 c4 18             	add    $0x18,%esp
  1059d3:	5b                   	pop    %ebx
  1059d4:	c3                   	ret    
  1059d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1059dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001059e0 <pcpu_fields_init>:

void pcpu_fields_init(int cpu_idx)
{
    pcpu[cpu_idx].inited = TRUE;
  1059e0:	e8 5e ee ff ff       	call   104843 <__x86.get_pc_thunk.cx>
  1059e5:	81 c1 1b a6 00 00    	add    $0xa61b,%ecx
{
  1059eb:	8b 54 24 04          	mov    0x4(%esp),%edx
    pcpu[cpu_idx].inited = TRUE;
  1059ef:	8d 04 92             	lea    (%edx,%edx,4),%eax
  1059f2:	c1 e0 04             	shl    $0x4,%eax
  1059f5:	c6 84 01 00 10 07 00 	movb   $0x1,0x71000(%ecx,%eax,1)
  1059fc:	01 
    pcpu[cpu_idx].cpu_idx = cpu_idx;
  1059fd:	89 94 01 4c 10 07 00 	mov    %edx,0x7104c(%ecx,%eax,1)
}
  105a04:	c3                   	ret    
  105a05:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00105a10 <pcpu_cur>:

struct pcpu *pcpu_cur(void)
{
  105a10:	53                   	push   %ebx
  105a11:	e8 73 a9 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105a16:	81 c3 ea a5 00 00    	add    $0xa5ea,%ebx
  105a1c:	83 ec 08             	sub    $0x8,%esp
    int cpu_idx = get_kstack_cpu_idx();
  105a1f:	e8 4c fc ff ff       	call   105670 <get_kstack_cpu_idx>
    return &pcpu[cpu_idx];
}
  105a24:	83 c4 08             	add    $0x8,%esp
    return &pcpu[cpu_idx];
  105a27:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105a2a:	c1 e0 04             	shl    $0x4,%eax
  105a2d:	8d 84 03 00 10 07 00 	lea    0x71000(%ebx,%eax,1),%eax
}
  105a34:	5b                   	pop    %ebx
  105a35:	c3                   	ret    
  105a36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105a3d:	8d 76 00             	lea    0x0(%esi),%esi

00105a40 <get_pcpu_idx>:

int get_pcpu_idx(void)
{
  105a40:	53                   	push   %ebx
  105a41:	e8 43 a9 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105a46:	81 c3 ba a5 00 00    	add    $0xa5ba,%ebx
  105a4c:	83 ec 08             	sub    $0x8,%esp
    int cpu_idx = get_kstack_cpu_idx();
  105a4f:	e8 1c fc ff ff       	call   105670 <get_kstack_cpu_idx>
    return pcpu_cur()->cpu_idx;
  105a54:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105a57:	c1 e0 04             	shl    $0x4,%eax
  105a5a:	8b 84 03 4c 10 07 00 	mov    0x7104c(%ebx,%eax,1),%eax
}
  105a61:	83 c4 08             	add    $0x8,%esp
  105a64:	5b                   	pop    %ebx
  105a65:	c3                   	ret    
  105a66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105a6d:	8d 76 00             	lea    0x0(%esi),%esi

00105a70 <set_pcpu_idx>:

void set_pcpu_idx(int index, int cpu_idx)
{
    pcpu[index].cpu_idx = cpu_idx;
  105a70:	e8 10 a9 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  105a75:	81 c2 8b a5 00 00    	add    $0xa58b,%edx
{
  105a7b:	8b 44 24 04          	mov    0x4(%esp),%eax
    pcpu[index].cpu_idx = cpu_idx;
  105a7f:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  105a83:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105a86:	c1 e0 04             	shl    $0x4,%eax
  105a89:	89 8c 02 4c 10 07 00 	mov    %ecx,0x7104c(%edx,%eax,1)
}
  105a90:	c3                   	ret    
  105a91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105a98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105a9f:	90                   	nop

00105aa0 <get_pcpu_kstack_pointer>:

uintptr_t *get_pcpu_kstack_pointer(int cpu_idx)
{
    return pcpu[cpu_idx].kstack;
  105aa0:	e8 e0 a8 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  105aa5:	81 c2 5b a5 00 00    	add    $0xa55b,%edx
{
  105aab:	8b 44 24 04          	mov    0x4(%esp),%eax
    return pcpu[cpu_idx].kstack;
  105aaf:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105ab2:	c1 e0 04             	shl    $0x4,%eax
  105ab5:	8b 84 02 04 10 07 00 	mov    0x71004(%edx,%eax,1),%eax
}
  105abc:	c3                   	ret    
  105abd:	8d 76 00             	lea    0x0(%esi),%esi

00105ac0 <set_pcpu_kstack_pointer>:

void set_pcpu_kstack_pointer(int cpu_idx, uintptr_t *ks)
{
    pcpu[cpu_idx].kstack = ks;
  105ac0:	e8 c0 a8 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  105ac5:	81 c2 3b a5 00 00    	add    $0xa53b,%edx
{
  105acb:	8b 44 24 04          	mov    0x4(%esp),%eax
    pcpu[cpu_idx].kstack = ks;
  105acf:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  105ad3:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105ad6:	c1 e0 04             	shl    $0x4,%eax
  105ad9:	89 8c 02 04 10 07 00 	mov    %ecx,0x71004(%edx,%eax,1)
}
  105ae0:	c3                   	ret    
  105ae1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105ae8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105aef:	90                   	nop

00105af0 <get_pcpu_boot_info>:

volatile bool get_pcpu_boot_info(int cpu_idx)
{
    return pcpu[cpu_idx].booted;
  105af0:	e8 90 a8 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  105af5:	81 c2 0b a5 00 00    	add    $0xa50b,%edx
{
  105afb:	8b 44 24 04          	mov    0x4(%esp),%eax
    return pcpu[cpu_idx].booted;
  105aff:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105b02:	c1 e0 04             	shl    $0x4,%eax
  105b05:	8d 84 02 00 10 07 00 	lea    0x71000(%edx,%eax,1),%eax
  105b0c:	0f b6 40 01          	movzbl 0x1(%eax),%eax
}
  105b10:	c3                   	ret    
  105b11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105b18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105b1f:	90                   	nop

00105b20 <set_pcpu_boot_info>:

void set_pcpu_boot_info(int cpu_idx, volatile bool boot_info)
{
    pcpu[cpu_idx].booted = boot_info;
  105b20:	e8 1e ed ff ff       	call   104843 <__x86.get_pc_thunk.cx>
  105b25:	81 c1 db a4 00 00    	add    $0xa4db,%ecx
{
  105b2b:	83 ec 04             	sub    $0x4,%esp
  105b2e:	8b 44 24 08          	mov    0x8(%esp),%eax
  105b32:	8b 54 24 0c          	mov    0xc(%esp),%edx
    pcpu[cpu_idx].booted = boot_info;
  105b36:	8d 04 80             	lea    (%eax,%eax,4),%eax
{
  105b39:	88 14 24             	mov    %dl,(%esp)
    pcpu[cpu_idx].booted = boot_info;
  105b3c:	0f b6 14 24          	movzbl (%esp),%edx
  105b40:	c1 e0 04             	shl    $0x4,%eax
  105b43:	8d 84 01 00 10 07 00 	lea    0x71000(%ecx,%eax,1),%eax
  105b4a:	88 50 01             	mov    %dl,0x1(%eax)
}
  105b4d:	83 c4 04             	add    $0x4,%esp
  105b50:	c3                   	ret    
  105b51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105b58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105b5f:	90                   	nop

00105b60 <get_pcpu_cpu_vendor>:

cpu_vendor get_pcpu_cpu_vendor(int cpu_idx)
{
    return pcpu[cpu_idx].arch_info.cpu_vendor;
  105b60:	e8 20 a8 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  105b65:	81 c2 9b a4 00 00    	add    $0xa49b,%edx
{
  105b6b:	8b 44 24 04          	mov    0x4(%esp),%eax
    return pcpu[cpu_idx].arch_info.cpu_vendor;
  105b6f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105b72:	c1 e0 04             	shl    $0x4,%eax
  105b75:	8b 84 02 28 10 07 00 	mov    0x71028(%edx,%eax,1),%eax
}
  105b7c:	c3                   	ret    
  105b7d:	8d 76 00             	lea    0x0(%esi),%esi

00105b80 <get_pcpu_arch_info_pointer>:

uintptr_t *get_pcpu_arch_info_pointer(int cpu_idx)
{
    return (uintptr_t *) &pcpu[cpu_idx].arch_info;
  105b80:	e8 00 a8 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  105b85:	81 c2 7b a4 00 00    	add    $0xa47b,%edx
{
  105b8b:	8b 44 24 04          	mov    0x4(%esp),%eax
    return (uintptr_t *) &pcpu[cpu_idx].arch_info;
  105b8f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105b92:	c1 e0 04             	shl    $0x4,%eax
  105b95:	8d 84 02 08 10 07 00 	lea    0x71008(%edx,%eax,1),%eax
}
  105b9c:	c3                   	ret    
  105b9d:	8d 76 00             	lea    0x0(%esi),%esi

00105ba0 <get_pcpu_inited_info>:

bool get_pcpu_inited_info(int cpu_idx)
{
    return pcpu[cpu_idx].inited;
  105ba0:	e8 e0 a7 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  105ba5:	81 c2 5b a4 00 00    	add    $0xa45b,%edx
{
  105bab:	8b 44 24 04          	mov    0x4(%esp),%eax
    return pcpu[cpu_idx].inited;
  105baf:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105bb2:	c1 e0 04             	shl    $0x4,%eax
  105bb5:	0f b6 84 02 00 10 07 	movzbl 0x71000(%edx,%eax,1),%eax
  105bbc:	00 
}
  105bbd:	c3                   	ret    
  105bbe:	66 90                	xchg   %ax,%ax

00105bc0 <pcpu_init>:
#include "import.h"

static bool pcpu_inited = FALSE;

void pcpu_init(void)
{
  105bc0:	55                   	push   %ebp
  105bc1:	57                   	push   %edi
  105bc2:	56                   	push   %esi
  105bc3:	53                   	push   %ebx
  105bc4:	e8 c0 a7 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105bc9:	81 c3 37 a4 00 00    	add    $0xa437,%ebx
  105bcf:	83 ec 0c             	sub    $0xc,%esp
    struct kstack *ks = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  105bd2:	e8 09 f0 ff ff       	call   104be0 <read_esp>
  105bd7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    int cpu_idx = ks->cpu_idx;
  105bdc:	8b b8 1c 01 00 00    	mov    0x11c(%eax),%edi
    struct kstack *ks = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  105be2:	89 c5                	mov    %eax,%ebp
    int i;

    if (cpu_idx == 0) {
  105be4:	85 ff                	test   %edi,%edi
  105be6:	75 33                	jne    105c1b <pcpu_init+0x5b>
        if (pcpu_inited == TRUE)
  105be8:	80 bb 80 12 07 00 01 	cmpb   $0x1,0x71280(%ebx)
  105bef:	74 4f                	je     105c40 <pcpu_init+0x80>
            return;

        pcpu_set_zero();
  105bf1:	e8 ba fd ff ff       	call   1059b0 <pcpu_set_zero>

        /* Probe SMP. */
        pcpu_mp_init();

        for (i = 0; i < NUM_CPUS; i++) {
  105bf6:	31 f6                	xor    %esi,%esi
        pcpu_mp_init();
  105bf8:	e8 33 d2 ff ff       	call   102e30 <pcpu_mp_init>
        for (i = 0; i < NUM_CPUS; i++) {
  105bfd:	8d 76 00             	lea    0x0(%esi),%esi
            pcpu_fields_init(i);
  105c00:	83 ec 0c             	sub    $0xc,%esp
  105c03:	56                   	push   %esi
        for (i = 0; i < NUM_CPUS; i++) {
  105c04:	83 c6 01             	add    $0x1,%esi
            pcpu_fields_init(i);
  105c07:	e8 d4 fd ff ff       	call   1059e0 <pcpu_fields_init>
        for (i = 0; i < NUM_CPUS; i++) {
  105c0c:	83 c4 10             	add    $0x10,%esp
  105c0f:	83 fe 08             	cmp    $0x8,%esi
  105c12:	75 ec                	jne    105c00 <pcpu_init+0x40>
        }

        pcpu_inited = TRUE;
  105c14:	c6 83 80 12 07 00 01 	movb   $0x1,0x71280(%ebx)
    }

    set_pcpu_idx(cpu_idx, cpu_idx);
  105c1b:	83 ec 08             	sub    $0x8,%esp
  105c1e:	57                   	push   %edi
  105c1f:	57                   	push   %edi
  105c20:	e8 4b fe ff ff       	call   105a70 <set_pcpu_idx>
    set_pcpu_kstack_pointer(cpu_idx, (uintptr_t *) ks);
  105c25:	58                   	pop    %eax
  105c26:	5a                   	pop    %edx
  105c27:	55                   	push   %ebp
  105c28:	57                   	push   %edi
  105c29:	e8 92 fe ff ff       	call   105ac0 <set_pcpu_kstack_pointer>
    set_pcpu_boot_info(cpu_idx, TRUE);
  105c2e:	59                   	pop    %ecx
  105c2f:	5e                   	pop    %esi
  105c30:	6a 01                	push   $0x1
  105c32:	57                   	push   %edi
  105c33:	e8 e8 fe ff ff       	call   105b20 <set_pcpu_boot_info>
    pcpu_init_cpu();
  105c38:	e8 f3 d9 ff ff       	call   103630 <pcpu_init_cpu>
  105c3d:	83 c4 10             	add    $0x10,%esp
}
  105c40:	83 c4 0c             	add    $0xc,%esp
  105c43:	5b                   	pop    %ebx
  105c44:	5e                   	pop    %esi
  105c45:	5f                   	pop    %edi
  105c46:	5d                   	pop    %ebp
  105c47:	c3                   	ret    
  105c48:	66 90                	xchg   %ax,%ax
  105c4a:	66 90                	xchg   %ax,%ax
  105c4c:	66 90                	xchg   %ax,%ax
  105c4e:	66 90                	xchg   %ax,%ax

00105c50 <kern_main_ap>:
    dprintf("\nTest complete. Please Use Ctrl-a x to exit qemu.");
#endif
}

static void kern_main_ap(void)
{
  105c50:	55                   	push   %ebp
  105c51:	57                   	push   %edi
  105c52:	56                   	push   %esi
  105c53:	53                   	push   %ebx
  105c54:	e8 30 a7 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105c59:	81 c3 a7 a3 00 00    	add    $0xa3a7,%ebx
  105c5f:	83 ec 0c             	sub    $0xc,%esp
    unsigned int pid, pid2;
    int cpu_idx = get_pcpu_idx();
  105c62:	e8 d9 fd ff ff       	call   105a40 <get_pcpu_idx>

    set_pcpu_boot_info(cpu_idx, TRUE);
  105c67:	83 ec 08             	sub    $0x8,%esp
  105c6a:	6a 01                	push   $0x1
    int cpu_idx = get_pcpu_idx();
  105c6c:	89 c6                	mov    %eax,%esi
    set_pcpu_boot_info(cpu_idx, TRUE);
  105c6e:	50                   	push   %eax
  105c6f:	e8 ac fe ff ff       	call   105b20 <set_pcpu_boot_info>

    while (all_ready == FALSE);
  105c74:	83 c4 10             	add    $0x10,%esp
  105c77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105c7e:	66 90                	xchg   %ax,%ax
  105c80:	8b 83 84 12 07 00    	mov    0x71284(%ebx),%eax
  105c86:	85 c0                	test   %eax,%eax
  105c88:	74 f6                	je     105c80 <kern_main_ap+0x30>

    KERN_INFO("[AP%d KERN] kernel_main_ap\n", cpu_idx);
  105c8a:	83 ec 08             	sub    $0x8,%esp
  105c8d:	8d 83 db a5 ff ff    	lea    -0x5a25(%ebx),%eax
  105c93:	56                   	push   %esi
  105c94:	50                   	push   %eax
  105c95:	e8 26 e3 ff ff       	call   103fc0 <debug_info>

    cpu_booted++;
  105c9a:	8b 83 88 12 07 00    	mov    0x71288(%ebx),%eax

#ifndef TEST
    if (cpu_idx == 1) {
  105ca0:	83 c4 10             	add    $0x10,%esp
    cpu_booted++;
  105ca3:	83 c0 01             	add    $0x1,%eax
  105ca6:	89 83 88 12 07 00    	mov    %eax,0x71288(%ebx)
    if (cpu_idx == 1) {
  105cac:	83 fe 01             	cmp    $0x1,%esi
  105caf:	0f 84 c3 00 00 00    	je     105d78 <kern_main_ap+0x128>
        KERN_INFO("CPU%d: process ping1 %d is created.\n", cpu_idx, pid);
        pid2 = proc_create(_binary___obj_user_pingpong_ping_start, 1000);
        KERN_INFO("CPU%d: process ping2 %d is created.\n", cpu_idx, pid2);
        proc_create(_binary___obj_user_idle_idle_start, 1000);
    }
    else if (cpu_idx == 2) {
  105cb5:	83 fe 02             	cmp    $0x2,%esi
  105cb8:	74 0e                	je     105cc8 <kern_main_ap+0x78>
    set_curid(pid);
    kctx_switch(0, pid);

    KERN_PANIC("kern_main_ap() should never reach here.\n");
#endif
}
  105cba:	83 c4 0c             	add    $0xc,%esp
  105cbd:	5b                   	pop    %ebx
  105cbe:	5e                   	pop    %esi
  105cbf:	5f                   	pop    %edi
  105cc0:	5d                   	pop    %ebp
  105cc1:	c3                   	ret    
  105cc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        pid = proc_create(_binary___obj_user_pingpong_pong_start, 1000);
  105cc8:	c7 c5 6a 38 12 00    	mov    $0x12386a,%ebp
  105cce:	83 ec 08             	sub    $0x8,%esp
  105cd1:	68 e8 03 00 00       	push   $0x3e8
  105cd6:	55                   	push   %ebp
  105cd7:	e8 a4 17 00 00       	call   107480 <proc_create>
        KERN_INFO("CPU%d: process pong1 %d is created.\n", cpu_idx, pid);
  105cdc:	83 c4 0c             	add    $0xc,%esp
  105cdf:	50                   	push   %eax
        pid = proc_create(_binary___obj_user_pingpong_pong_start, 1000);
  105ce0:	89 c7                	mov    %eax,%edi
        KERN_INFO("CPU%d: process pong1 %d is created.\n", cpu_idx, pid);
  105ce2:	8d 83 a8 a6 ff ff    	lea    -0x5958(%ebx),%eax
  105ce8:	6a 02                	push   $0x2
  105cea:	50                   	push   %eax
  105ceb:	e8 d0 e2 ff ff       	call   103fc0 <debug_info>
        pid2 = proc_create(_binary___obj_user_pingpong_pong_start, 1000);
  105cf0:	58                   	pop    %eax
  105cf1:	5a                   	pop    %edx
  105cf2:	68 e8 03 00 00       	push   $0x3e8
  105cf7:	55                   	push   %ebp
  105cf8:	e8 83 17 00 00       	call   107480 <proc_create>
        KERN_INFO("CPU%d: process pong2 %d is created.\n", cpu_idx, pid2);
  105cfd:	83 c4 0c             	add    $0xc,%esp
  105d00:	50                   	push   %eax
  105d01:	8d 83 d0 a6 ff ff    	lea    -0x5930(%ebx),%eax
  105d07:	6a 02                	push   $0x2
  105d09:	50                   	push   %eax
    tqueue_remove(NUM_IDS + cpu_idx, pid);
  105d0a:	83 c6 40             	add    $0x40,%esi
        KERN_INFO("CPU%d: process pong2 %d is created.\n", cpu_idx, pid2);
  105d0d:	e8 ae e2 ff ff       	call   103fc0 <debug_info>
        proc_create(_binary___obj_user_idle_idle_start, 1000);
  105d12:	58                   	pop    %eax
  105d13:	5a                   	pop    %edx
  105d14:	68 e8 03 00 00       	push   $0x3e8
  105d19:	ff b3 ec ff ff ff    	push   -0x14(%ebx)
  105d1f:	e8 5c 17 00 00       	call   107480 <proc_create>
  105d24:	83 c4 10             	add    $0x10,%esp
    tqueue_remove(NUM_IDS + cpu_idx, pid);
  105d27:	83 ec 08             	sub    $0x8,%esp
  105d2a:	57                   	push   %edi
  105d2b:	56                   	push   %esi
  105d2c:	e8 af 14 00 00       	call   1071e0 <tqueue_remove>
    tcb_set_state(pid, TSTATE_RUN);
  105d31:	59                   	pop    %ecx
  105d32:	5e                   	pop    %esi
  105d33:	6a 01                	push   $0x1
  105d35:	57                   	push   %edi
  105d36:	e8 35 11 00 00       	call   106e70 <tcb_set_state>
    set_curid(pid);
  105d3b:	89 3c 24             	mov    %edi,(%esp)
  105d3e:	e8 ad 15 00 00       	call   1072f0 <set_curid>
    kctx_switch(0, pid);
  105d43:	5d                   	pop    %ebp
  105d44:	58                   	pop    %eax
  105d45:	57                   	push   %edi
  105d46:	6a 00                	push   $0x0
  105d48:	e8 03 10 00 00       	call   106d50 <kctx_switch>
    KERN_PANIC("kern_main_ap() should never reach here.\n");
  105d4d:	83 c4 0c             	add    $0xc,%esp
  105d50:	8d 83 f8 a6 ff ff    	lea    -0x5908(%ebx),%eax
  105d56:	50                   	push   %eax
  105d57:	8d 83 f7 a5 ff ff    	lea    -0x5a09(%ebx),%eax
  105d5d:	68 81 00 00 00       	push   $0x81
  105d62:	50                   	push   %eax
  105d63:	e8 c8 e2 ff ff       	call   104030 <debug_panic>
  105d68:	83 c4 10             	add    $0x10,%esp
}
  105d6b:	83 c4 0c             	add    $0xc,%esp
  105d6e:	5b                   	pop    %ebx
  105d6f:	5e                   	pop    %esi
  105d70:	5f                   	pop    %edi
  105d71:	5d                   	pop    %ebp
  105d72:	c3                   	ret    
  105d73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  105d77:	90                   	nop
        pid = proc_create(_binary___obj_user_pingpong_ping_start, 1000);
  105d78:	c7 c5 3e 9d 11 00    	mov    $0x119d3e,%ebp
  105d7e:	83 ec 08             	sub    $0x8,%esp
  105d81:	68 e8 03 00 00       	push   $0x3e8
  105d86:	55                   	push   %ebp
  105d87:	e8 f4 16 00 00       	call   107480 <proc_create>
        KERN_INFO("CPU%d: process ping1 %d is created.\n", cpu_idx, pid);
  105d8c:	83 c4 0c             	add    $0xc,%esp
  105d8f:	50                   	push   %eax
        pid = proc_create(_binary___obj_user_pingpong_ping_start, 1000);
  105d90:	89 c7                	mov    %eax,%edi
        KERN_INFO("CPU%d: process ping1 %d is created.\n", cpu_idx, pid);
  105d92:	8d 83 58 a6 ff ff    	lea    -0x59a8(%ebx),%eax
  105d98:	6a 01                	push   $0x1
  105d9a:	50                   	push   %eax
  105d9b:	e8 20 e2 ff ff       	call   103fc0 <debug_info>
        pid2 = proc_create(_binary___obj_user_pingpong_ping_start, 1000);
  105da0:	59                   	pop    %ecx
  105da1:	58                   	pop    %eax
  105da2:	68 e8 03 00 00       	push   $0x3e8
  105da7:	55                   	push   %ebp
  105da8:	e8 d3 16 00 00       	call   107480 <proc_create>
        KERN_INFO("CPU%d: process ping2 %d is created.\n", cpu_idx, pid2);
  105dad:	83 c4 0c             	add    $0xc,%esp
  105db0:	50                   	push   %eax
  105db1:	8d 83 80 a6 ff ff    	lea    -0x5980(%ebx),%eax
  105db7:	6a 01                	push   $0x1
  105db9:	e9 4b ff ff ff       	jmp    105d09 <kern_main_ap+0xb9>
  105dbe:	66 90                	xchg   %ax,%ax

00105dc0 <kern_init>:

void kern_init(uintptr_t mbi_addr)
{
  105dc0:	55                   	push   %ebp
  105dc1:	57                   	push   %edi
  105dc2:	56                   	push   %esi
    for (i = 1; i < pcpu_ncpu(); i++) {
  105dc3:	be 01 00 00 00       	mov    $0x1,%esi
{
  105dc8:	53                   	push   %ebx
  105dc9:	e8 bb a5 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105dce:	81 c3 32 a2 00 00    	add    $0xa232,%ebx
  105dd4:	83 ec 28             	sub    $0x28,%esp
    thread_init(mbi_addr);
  105dd7:	ff 74 24 3c          	push   0x3c(%esp)
  105ddb:	e8 40 15 00 00       	call   107320 <thread_init>
    KERN_INFO("[BSP KERN] Kernel initialized.\n");
  105de0:	8d 83 24 a7 ff ff    	lea    -0x58dc(%ebx),%eax
        KERN_INFO("[BSP KERN] Boot CPU %d .... \n", i);
  105de6:	8d ab 25 a6 ff ff    	lea    -0x59db(%ebx),%ebp
    KERN_INFO("[BSP KERN] Kernel initialized.\n");
  105dec:	89 04 24             	mov    %eax,(%esp)
  105def:	e8 cc e1 ff ff       	call   103fc0 <debug_info>
    KERN_INFO("[BSP KERN] In kernel main.\n\n");
  105df4:	8d 83 08 a6 ff ff    	lea    -0x59f8(%ebx),%eax
  105dfa:	89 04 24             	mov    %eax,(%esp)
  105dfd:	e8 be e1 ff ff       	call   103fc0 <debug_info>
    KERN_INFO("[BSP KERN] Number of CPUs in this system: %d. \n", pcpu_ncpu());
  105e02:	e8 39 dc ff ff       	call   103a40 <pcpu_ncpu>
  105e07:	5a                   	pop    %edx
  105e08:	59                   	pop    %ecx
  105e09:	50                   	push   %eax
  105e0a:	8d 83 44 a7 ff ff    	lea    -0x58bc(%ebx),%eax
  105e10:	50                   	push   %eax
  105e11:	e8 aa e1 ff ff       	call   103fc0 <debug_info>
    int cpu_idx = get_pcpu_idx();
  105e16:	e8 25 fc ff ff       	call   105a40 <get_pcpu_idx>
    all_ready = FALSE;
  105e1b:	c7 c0 00 90 17 00    	mov    $0x179000,%eax
    for (i = 1; i < pcpu_ncpu(); i++) {
  105e21:	83 c4 10             	add    $0x10,%esp
    all_ready = FALSE;
  105e24:	c7 83 84 12 07 00 00 	movl   $0x0,0x71284(%ebx)
  105e2b:	00 00 00 
    for (i = 1; i < pcpu_ncpu(); i++) {
  105e2e:	8d b8 00 10 00 00    	lea    0x1000(%eax),%edi
        pcpu_boot_ap(i, kern_main_ap, (uintptr_t) &bsp_kstack[i]);
  105e34:	8d 83 50 5c ff ff    	lea    -0xa3b0(%ebx),%eax
  105e3a:	89 44 24 0c          	mov    %eax,0xc(%esp)
    for (i = 1; i < pcpu_ncpu(); i++) {
  105e3e:	e8 fd db ff ff       	call   103a40 <pcpu_ncpu>
  105e43:	39 f0                	cmp    %esi,%eax
  105e45:	76 65                	jbe    105eac <kern_init+0xec>
  105e47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105e4e:	66 90                	xchg   %ax,%ax
        KERN_INFO("[BSP KERN] Boot CPU %d .... \n", i);
  105e50:	83 ec 08             	sub    $0x8,%esp
  105e53:	56                   	push   %esi
  105e54:	55                   	push   %ebp
  105e55:	e8 66 e1 ff ff       	call   103fc0 <debug_info>
        pcpu_boot_ap(i, kern_main_ap, (uintptr_t) &bsp_kstack[i]);
  105e5a:	83 c4 0c             	add    $0xc,%esp
        bsp_kstack[i].cpu_idx = i;
  105e5d:	89 b7 1c 01 00 00    	mov    %esi,0x11c(%edi)
        pcpu_boot_ap(i, kern_main_ap, (uintptr_t) &bsp_kstack[i]);
  105e63:	57                   	push   %edi
  105e64:	ff 74 24 14          	push   0x14(%esp)
  105e68:	56                   	push   %esi
  105e69:	e8 e2 d5 ff ff       	call   103450 <pcpu_boot_ap>
        while (get_pcpu_boot_info(i) == FALSE);
  105e6e:	83 c4 10             	add    $0x10,%esp
  105e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105e78:	83 ec 0c             	sub    $0xc,%esp
  105e7b:	56                   	push   %esi
  105e7c:	e8 6f fc ff ff       	call   105af0 <get_pcpu_boot_info>
  105e81:	83 c4 10             	add    $0x10,%esp
  105e84:	84 c0                	test   %al,%al
  105e86:	74 f0                	je     105e78 <kern_init+0xb8>
        KERN_INFO("[BSP KERN] done.\n");
  105e88:	83 ec 0c             	sub    $0xc,%esp
  105e8b:	8d 83 43 a6 ff ff    	lea    -0x59bd(%ebx),%eax
    for (i = 1; i < pcpu_ncpu(); i++) {
  105e91:	83 c6 01             	add    $0x1,%esi
  105e94:	81 c7 00 10 00 00    	add    $0x1000,%edi
        KERN_INFO("[BSP KERN] done.\n");
  105e9a:	50                   	push   %eax
  105e9b:	e8 20 e1 ff ff       	call   103fc0 <debug_info>
    for (i = 1; i < pcpu_ncpu(); i++) {
  105ea0:	83 c4 10             	add    $0x10,%esp
  105ea3:	e8 98 db ff ff       	call   103a40 <pcpu_ncpu>
  105ea8:	39 f0                	cmp    %esi,%eax
  105eaa:	77 a4                	ja     105e50 <kern_init+0x90>
    all_ready = TRUE;
  105eac:	c7 83 84 12 07 00 01 	movl   $0x1,0x71284(%ebx)
  105eb3:	00 00 00 
    kern_main();
}
  105eb6:	83 c4 1c             	add    $0x1c,%esp
  105eb9:	5b                   	pop    %ebx
  105eba:	5e                   	pop    %esi
  105ebb:	5f                   	pop    %edi
  105ebc:	5d                   	pop    %ebp
  105ebd:	c3                   	ret    
  105ebe:	66 90                	xchg   %ax,%ax

00105ec0 <kern_init_ap>:

void kern_init_ap(void (*f)(void))
{
  105ec0:	56                   	push   %esi
  105ec1:	53                   	push   %ebx
  105ec2:	e8 c2 a4 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105ec7:	81 c3 39 a1 00 00    	add    $0xa139,%ebx
  105ecd:	83 ec 04             	sub    $0x4,%esp
  105ed0:	8b 74 24 10          	mov    0x10(%esp),%esi
    devinit_ap();
  105ed4:	e8 77 ac ff ff       	call   100b50 <devinit_ap>
    f();
}
  105ed9:	83 c4 04             	add    $0x4,%esp
    f();
  105edc:	89 f0                	mov    %esi,%eax
}
  105ede:	5b                   	pop    %ebx
  105edf:	5e                   	pop    %esi
    f();
  105ee0:	ff e0                	jmp    *%eax
  105ee2:	66 90                	xchg   %ax,%ax
  105ee4:	02 b0 ad 1b 03 00    	add    0x31bad(%eax),%dh
  105eea:	00 00                	add    %al,(%eax)
  105eec:	fb                   	sti    
  105eed:	4f                   	dec    %edi
  105eee:	52                   	push   %edx
  105eef:	e4                   	.byte 0xe4

00105ef0 <start>:
	.long CHECKSUM

	/* this is the entry of the kernel */
	.globl start
start:
	cli
  105ef0:	fa                   	cli    

	/* check whether the bootloader provide multiboot information */
	cmpl	$MULTIBOOT_BOOTLOADER_MAGIC, %eax
  105ef1:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
	jne	spin
  105ef6:	75 27                	jne    105f1f <spin>
	movl	%ebx, multiboot_ptr
  105ef8:	89 1d 20 5f 10 00    	mov    %ebx,0x105f20

	/* tell BIOS to warmboot next time */
	movw	$0x1234, 0x472
  105efe:	66 c7 05 72 04 00 00 	movw   $0x1234,0x472
  105f05:	34 12 

	/* clear EFLAGS */
	pushl	$0x2
  105f07:	6a 02                	push   $0x2
	popfl
  105f09:	9d                   	popf   

	/* prepare the kernel stack */
	movl	$0x0, %ebp
  105f0a:	bd 00 00 00 00       	mov    $0x0,%ebp
	movl	$(bsp_kstack + 4096), %esp
  105f0f:	bc 00 a0 17 00       	mov    $0x17a000,%esp

	/* jump to the C code */
	push	multiboot_ptr
  105f14:	ff 35 20 5f 10 00    	push   0x105f20
	call	kern_init
  105f1a:	e8 a1 fe ff ff       	call   105dc0 <kern_init>

00105f1f <spin>:

	/* should not be here */
spin:
	hlt
  105f1f:	f4                   	hlt    

00105f20 <multiboot_ptr>:
  105f20:	00 00                	add    %al,(%eax)
  105f22:	00 00                	add    %al,(%eax)
  105f24:	66 90                	xchg   %ax,%ax
  105f26:	66 90                	xchg   %ax,%ax
  105f28:	66 90                	xchg   %ax,%ax
  105f2a:	66 90                	xchg   %ax,%ax
  105f2c:	66 90                	xchg   %ax,%ax
  105f2e:	66 90                	xchg   %ax,%ax

00105f30 <mem_spinlock_init>:
 * So it may have up to 2^20 physical pages,
 * with the page size being 4KB.
 */
static struct ATStruct AT[1 << 20];

void mem_spinlock_init(void) {
  105f30:	53                   	push   %ebx
  105f31:	e8 53 a4 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105f36:	81 c3 ca a0 00 00    	add    $0xa0ca,%ebx
  105f3c:	83 ec 14             	sub    $0x14,%esp
    spinlock_init(&mem_lk);
  105f3f:	8d 83 a4 12 87 00    	lea    0x8712a4(%ebx),%eax
  105f45:	50                   	push   %eax
  105f46:	e8 55 f7 ff ff       	call   1056a0 <spinlock_init>
}
  105f4b:	83 c4 18             	add    $0x18,%esp
  105f4e:	5b                   	pop    %ebx
  105f4f:	c3                   	ret    

00105f50 <mem_lock>:

void mem_lock(void) {
  105f50:	53                   	push   %ebx
  105f51:	e8 33 a4 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105f56:	81 c3 aa a0 00 00    	add    $0xa0aa,%ebx
  105f5c:	83 ec 14             	sub    $0x14,%esp
    spinlock_acquire(&mem_lk);
  105f5f:	8d 83 a4 12 87 00    	lea    0x8712a4(%ebx),%eax
  105f65:	50                   	push   %eax
  105f66:	e8 c5 f7 ff ff       	call   105730 <spinlock_acquire>
}
  105f6b:	83 c4 18             	add    $0x18,%esp
  105f6e:	5b                   	pop    %ebx
  105f6f:	c3                   	ret    

00105f70 <mem_unlock>:

void mem_unlock(void) {
  105f70:	53                   	push   %ebx
  105f71:	e8 13 a4 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  105f76:	81 c3 8a a0 00 00    	add    $0xa08a,%ebx
  105f7c:	83 ec 14             	sub    $0x14,%esp
    spinlock_release(&mem_lk);
  105f7f:	8d 83 a4 12 87 00    	lea    0x8712a4(%ebx),%eax
  105f85:	50                   	push   %eax
  105f86:	e8 25 f8 ff ff       	call   1057b0 <spinlock_release>
}
  105f8b:	83 c4 18             	add    $0x18,%esp
  105f8e:	5b                   	pop    %ebx
  105f8f:	c3                   	ret    

00105f90 <get_nps>:

// The getter function for NUM_PAGES.
unsigned int get_nps(void)
{
    return NUM_PAGES;
  105f90:	e8 ec a3 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  105f95:	05 6b a0 00 00       	add    $0xa06b,%eax
  105f9a:	8b 80 a0 12 87 00    	mov    0x8712a0(%eax),%eax
}
  105fa0:	c3                   	ret    
  105fa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105fa8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105faf:	90                   	nop

00105fb0 <set_nps>:

// The setter function for NUM_PAGES.
void set_nps(unsigned int nps)
{
    NUM_PAGES = nps;
  105fb0:	e8 cc a3 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  105fb5:	05 4b a0 00 00       	add    $0xa04b,%eax
  105fba:	8b 54 24 04          	mov    0x4(%esp),%edx
  105fbe:	89 90 a0 12 87 00    	mov    %edx,0x8712a0(%eax)
}
  105fc4:	c3                   	ret    
  105fc5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00105fd0 <at_is_norm>:
        perm = 1;
    } else {
        perm = 0;
    }

    return perm;
  105fd0:	e8 ac a3 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  105fd5:	05 2b a0 00 00       	add    $0xa02b,%eax
    if (perm > 1) {
  105fda:	8b 54 24 04          	mov    0x4(%esp),%edx
  105fde:	83 bc d0 a0 12 07 00 	cmpl   $0x1,0x712a0(%eax,%edx,8)
  105fe5:	01 
  105fe6:	0f 97 c0             	seta   %al
  105fe9:	0f b6 c0             	movzbl %al,%eax
}
  105fec:	c3                   	ret    
  105fed:	8d 76 00             	lea    0x0(%esi),%esi

00105ff0 <at_set_perm>:
 * Sets the permission of the page with given index.
 * It also marks the page as unallocated.
 */
void at_set_perm(unsigned int page_index, unsigned int perm)
{
    AT[page_index].perm = perm;
  105ff0:	e8 8c a3 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  105ff5:	05 0b a0 00 00       	add    $0xa00b,%eax
{
  105ffa:	8b 54 24 04          	mov    0x4(%esp),%edx
    AT[page_index].perm = perm;
  105ffe:	8b 4c 24 08          	mov    0x8(%esp),%ecx
    AT[page_index].allocated = 0;
  106002:	c7 84 d0 a4 12 07 00 	movl   $0x0,0x712a4(%eax,%edx,8)
  106009:	00 00 00 00 
    AT[page_index].perm = perm;
  10600d:	89 8c d0 a0 12 07 00 	mov    %ecx,0x712a0(%eax,%edx,8)
}
  106014:	c3                   	ret    
  106015:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10601c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106020 <at_is_allocated>:
    allocated = AT[page_index].allocated;
    if (allocated > 0) {
        allocated = 1;
    }

    return allocated;
  106020:	e8 5c a3 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  106025:	05 db 9f 00 00       	add    $0x9fdb,%eax
    if (allocated > 0) {
  10602a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10602e:	8b 84 d0 a4 12 07 00 	mov    0x712a4(%eax,%edx,8),%eax
  106035:	85 c0                	test   %eax,%eax
  106037:	0f 95 c0             	setne  %al
  10603a:	0f b6 c0             	movzbl %al,%eax
}
  10603d:	c3                   	ret    
  10603e:	66 90                	xchg   %ax,%ax

00106040 <at_set_allocated>:
 * The setter function for the physical page allocation flag.
 * Set the flag of the page with given index to the given value.
 */
void at_set_allocated(unsigned int page_index, unsigned int allocated)
{
    AT[page_index].allocated = allocated;
  106040:	e8 3c a3 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  106045:	05 bb 9f 00 00       	add    $0x9fbb,%eax
  10604a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10604e:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  106052:	89 8c d0 a4 12 07 00 	mov    %ecx,0x712a4(%eax,%edx,8)
}
  106059:	c3                   	ret    
  10605a:	66 90                	xchg   %ax,%ax
  10605c:	66 90                	xchg   %ax,%ax
  10605e:	66 90                	xchg   %ax,%ax

00106060 <pmem_init>:
 *    based on the information available in the physical memory map table.
 *    Review import.h in the current directory for the list of available
 *    getter and setter functions.
 */
void pmem_init(unsigned int mbi_addr)
{
  106060:	55                   	push   %ebp
  106061:	57                   	push   %edi
  106062:	56                   	push   %esi
  106063:	53                   	push   %ebx
  106064:	e8 20 a3 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106069:	81 c3 97 9f 00 00    	add    $0x9f97,%ebx
  10606f:	83 ec 38             	sub    $0x38,%esp
    unsigned int pg_idx, pmmap_size, cur_addr, highest_addr;
    unsigned int entry_idx, flag, isnorm, start, len;

    // Calls the lower layer initialization primitive.
    // The parameter mbi_addr should not be used in the further code.
    devinit(mbi_addr);
  106072:	ff 74 24 4c          	push   0x4c(%esp)
  106076:	e8 35 aa ff ff       	call   100ab0 <devinit>
    mem_spinlock_init();
  10607b:	e8 b0 fe ff ff       	call   105f30 <mem_spinlock_init>
     * Hint: Think of it as the highest address in the ranges of the memory map table,
     *       divided by the page size.
     */
    nps = 0;
    entry_idx = 0;
    pmmap_size = get_size();
  106080:	e8 db af ff ff       	call   101060 <get_size>
  106085:	89 44 24 18          	mov    %eax,0x18(%esp)
    while (entry_idx < pmmap_size) {
  106089:	83 c4 10             	add    $0x10,%esp
  10608c:	85 c0                	test   %eax,%eax
  10608e:	0f 84 62 01 00 00    	je     1061f6 <pmem_init+0x196>
    entry_idx = 0;
  106094:	31 ff                	xor    %edi,%edi
    nps = 0;
  106096:	31 f6                	xor    %esi,%esi
  106098:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10609f:	90                   	nop
        cur_addr = get_mms(entry_idx) + get_mml(entry_idx);
  1060a0:	83 ec 0c             	sub    $0xc,%esp
  1060a3:	57                   	push   %edi
  1060a4:	e8 d7 af ff ff       	call   101080 <get_mms>
  1060a9:	89 3c 24             	mov    %edi,(%esp)
  1060ac:	89 c5                	mov    %eax,%ebp
  1060ae:	e8 1d b0 ff ff       	call   1010d0 <get_mml>
  1060b3:	01 e8                	add    %ebp,%eax
  1060b5:	39 c6                	cmp    %eax,%esi
  1060b7:	0f 42 f0             	cmovb  %eax,%esi
    while (entry_idx < pmmap_size) {
  1060ba:	83 c4 10             	add    $0x10,%esp
        if (nps < cur_addr) {
            nps = cur_addr;
        }
        entry_idx++;
  1060bd:	83 c7 01             	add    $0x1,%edi
    while (entry_idx < pmmap_size) {
  1060c0:	39 7c 24 08          	cmp    %edi,0x8(%esp)
  1060c4:	75 da                	jne    1060a0 <pmem_init+0x40>
    }

    nps = ROUNDDOWN(nps, PAGESIZE) / PAGESIZE;
  1060c6:	89 f5                	mov    %esi,%ebp
    set_nps(nps);  // Setting the value computed above to NUM_PAGES.
  1060c8:	83 ec 0c             	sub    $0xc,%esp
    nps = ROUNDDOWN(nps, PAGESIZE) / PAGESIZE;
  1060cb:	c1 ed 0c             	shr    $0xc,%ebp
  1060ce:	89 6c 24 28          	mov    %ebp,0x28(%esp)
    set_nps(nps);  // Setting the value computed above to NUM_PAGES.
  1060d2:	55                   	push   %ebp
  1060d3:	e8 d8 fe ff ff       	call   105fb0 <set_nps>
     *    not aligned by pages, so it may be possible that for some pages, only some of
     *    the addresses are in a usable range. Currently, we do not utilize partial pages,
     *    so in that case, you should consider those pages as unavailable.
     */
    pg_idx = 0;
    while (pg_idx < nps) {
  1060d8:	83 c4 10             	add    $0x10,%esp
  1060db:	85 ed                	test   %ebp,%ebp
  1060dd:	0f 84 f2 00 00 00    	je     1061d5 <pmem_init+0x175>
  1060e3:	31 c0                	xor    %eax,%eax
    pg_idx = 0;
  1060e5:	89 7c 24 10          	mov    %edi,0x10(%esp)
  1060e9:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1060f0:	00 
  1060f1:	89 c7                	mov    %eax,%edi
  1060f3:	eb 25                	jmp    10611a <pmem_init+0xba>
  1060f5:	8d 76 00             	lea    0x0(%esi),%esi
        if (pg_idx < VM_USERLO_PI || VM_USERHI_PI <= pg_idx) {
            at_set_perm(pg_idx, 1);
  1060f8:	83 ec 08             	sub    $0x8,%esp
  1060fb:	6a 01                	push   $0x1
  1060fd:	51                   	push   %ecx
  1060fe:	e8 ed fe ff ff       	call   105ff0 <at_set_perm>
  106103:	83 c4 10             	add    $0x10,%esp
    while (pg_idx < nps) {
  106106:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  10610a:	81 c7 00 10 00 00    	add    $0x1000,%edi
  106110:	39 54 24 08          	cmp    %edx,0x8(%esp)
  106114:	0f 84 bb 00 00 00    	je     1061d5 <pmem_init+0x175>
        if (pg_idx < VM_USERLO_PI || VM_USERHI_PI <= pg_idx) {
  10611a:	8b 44 24 08          	mov    0x8(%esp),%eax
  10611e:	89 c1                	mov    %eax,%ecx
  106120:	89 44 24 18          	mov    %eax,0x18(%esp)
            isnorm = 0;
            while (entry_idx < pmmap_size && !flag) {
                isnorm = is_usable(entry_idx);
                start = get_mms(entry_idx);
                len = get_mml(entry_idx);
                if (start <= pg_idx * PAGESIZE && (pg_idx + 1) * PAGESIZE <= start + len) {
  106124:	83 c0 01             	add    $0x1,%eax
  106127:	89 44 24 08          	mov    %eax,0x8(%esp)
        if (pg_idx < VM_USERLO_PI || VM_USERHI_PI <= pg_idx) {
  10612b:	8d 81 00 00 fc ff    	lea    -0x40000(%ecx),%eax
  106131:	3d ff ff 0a 00       	cmp    $0xaffff,%eax
  106136:	77 c0                	ja     1060f8 <pmem_init+0x98>
            while (entry_idx < pmmap_size && !flag) {
  106138:	8b 44 24 08          	mov    0x8(%esp),%eax
            entry_idx = 0;
  10613c:	31 f6                	xor    %esi,%esi
  10613e:	c1 e0 0c             	shl    $0xc,%eax
  106141:	89 44 24 14          	mov    %eax,0x14(%esp)
  106145:	eb 27                	jmp    10616e <pmem_init+0x10e>
  106147:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10614e:	66 90                	xchg   %ax,%ax
                if (start <= pg_idx * PAGESIZE && (pg_idx + 1) * PAGESIZE <= start + len) {
  106150:	8d 54 05 00          	lea    0x0(%ebp,%eax,1),%edx
  106154:	3b 54 24 14          	cmp    0x14(%esp),%edx
  106158:	0f 93 c2             	setae  %dl
  10615b:	0f 92 c0             	setb   %al
                    flag = 1;
                }
                entry_idx++;
  10615e:	83 c6 01             	add    $0x1,%esi
                if (start <= pg_idx * PAGESIZE && (pg_idx + 1) * PAGESIZE <= start + len) {
  106161:	0f b6 d2             	movzbl %dl,%edx
            while (entry_idx < pmmap_size && !flag) {
  106164:	3b 74 24 10          	cmp    0x10(%esp),%esi
  106168:	73 3a                	jae    1061a4 <pmem_init+0x144>
  10616a:	84 c0                	test   %al,%al
  10616c:	74 36                	je     1061a4 <pmem_init+0x144>
                isnorm = is_usable(entry_idx);
  10616e:	83 ec 0c             	sub    $0xc,%esp
  106171:	56                   	push   %esi
  106172:	e8 b9 af ff ff       	call   101130 <is_usable>
                start = get_mms(entry_idx);
  106177:	89 34 24             	mov    %esi,(%esp)
                isnorm = is_usable(entry_idx);
  10617a:	89 44 24 1c          	mov    %eax,0x1c(%esp)
                start = get_mms(entry_idx);
  10617e:	e8 fd ae ff ff       	call   101080 <get_mms>
                len = get_mml(entry_idx);
  106183:	89 34 24             	mov    %esi,(%esp)
                start = get_mms(entry_idx);
  106186:	89 c5                	mov    %eax,%ebp
                len = get_mml(entry_idx);
  106188:	e8 43 af ff ff       	call   1010d0 <get_mml>
                if (start <= pg_idx * PAGESIZE && (pg_idx + 1) * PAGESIZE <= start + len) {
  10618d:	83 c4 10             	add    $0x10,%esp
  106190:	39 ef                	cmp    %ebp,%edi
  106192:	73 bc                	jae    106150 <pmem_init+0xf0>
  106194:	b8 01 00 00 00       	mov    $0x1,%eax
  106199:	31 d2                	xor    %edx,%edx
                entry_idx++;
  10619b:	83 c6 01             	add    $0x1,%esi
            while (entry_idx < pmmap_size && !flag) {
  10619e:	3b 74 24 10          	cmp    0x10(%esp),%esi
  1061a2:	72 c6                	jb     10616a <pmem_init+0x10a>
            }

            if (flag && isnorm) {
  1061a4:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1061a8:	85 c0                	test   %eax,%eax
  1061aa:	74 34                	je     1061e0 <pmem_init+0x180>
  1061ac:	85 d2                	test   %edx,%edx
  1061ae:	74 30                	je     1061e0 <pmem_init+0x180>
                at_set_perm(pg_idx, 2);
  1061b0:	83 ec 08             	sub    $0x8,%esp
    while (pg_idx < nps) {
  1061b3:	81 c7 00 10 00 00    	add    $0x1000,%edi
                at_set_perm(pg_idx, 2);
  1061b9:	6a 02                	push   $0x2
  1061bb:	ff 74 24 24          	push   0x24(%esp)
  1061bf:	e8 2c fe ff ff       	call   105ff0 <at_set_perm>
  1061c4:	83 c4 10             	add    $0x10,%esp
    while (pg_idx < nps) {
  1061c7:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  1061cb:	39 54 24 08          	cmp    %edx,0x8(%esp)
  1061cf:	0f 85 45 ff ff ff    	jne    10611a <pmem_init+0xba>
                at_set_perm(pg_idx, 0);
            }
        }
        pg_idx++;
    }
}
  1061d5:	83 c4 2c             	add    $0x2c,%esp
  1061d8:	5b                   	pop    %ebx
  1061d9:	5e                   	pop    %esi
  1061da:	5f                   	pop    %edi
  1061db:	5d                   	pop    %ebp
  1061dc:	c3                   	ret    
  1061dd:	8d 76 00             	lea    0x0(%esi),%esi
                at_set_perm(pg_idx, 0);
  1061e0:	83 ec 08             	sub    $0x8,%esp
  1061e3:	6a 00                	push   $0x0
  1061e5:	ff 74 24 24          	push   0x24(%esp)
  1061e9:	e8 02 fe ff ff       	call   105ff0 <at_set_perm>
  1061ee:	83 c4 10             	add    $0x10,%esp
  1061f1:	e9 10 ff ff ff       	jmp    106106 <pmem_init+0xa6>
    set_nps(nps);  // Setting the value computed above to NUM_PAGES.
  1061f6:	83 ec 0c             	sub    $0xc,%esp
  1061f9:	6a 00                	push   $0x0
  1061fb:	e8 b0 fd ff ff       	call   105fb0 <set_nps>
  106200:	83 c4 10             	add    $0x10,%esp
}
  106203:	83 c4 2c             	add    $0x2c,%esp
  106206:	5b                   	pop    %ebx
  106207:	5e                   	pop    %esi
  106208:	5f                   	pop    %edi
  106209:	5d                   	pop    %ebp
  10620a:	c3                   	ret    
  10620b:	66 90                	xchg   %ax,%ax
  10620d:	66 90                	xchg   %ax,%ax
  10620f:	90                   	nop

00106210 <palloc>:
 *    return 0.
 * 2. Optimize the code using memoization so that you do not have to
 *    scan the allocation table from scratch every time.
 */
unsigned int palloc()
{
  106210:	55                   	push   %ebp
  106211:	57                   	push   %edi
  106212:	56                   	push   %esi
  106213:	53                   	push   %ebx
  106214:	e8 70 a1 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106219:	81 c3 e7 9d 00 00    	add    $0x9de7,%ebx
  10621f:	83 ec 0c             	sub    $0xc,%esp
    unsigned int nps;
    unsigned int palloc_index;
    unsigned int palloc_free_index;
    bool first;

    mem_lock();
  106222:	e8 29 fd ff ff       	call   105f50 <mem_lock>

    nps = get_nps();
  106227:	e8 64 fd ff ff       	call   105f90 <get_nps>
    palloc_index = last_palloc_index;
  10622c:	8b b3 28 03 00 00    	mov    0x328(%ebx),%esi
    nps = get_nps();
  106232:	89 c7                	mov    %eax,%edi
    palloc_free_index = nps;
    first = TRUE;

    while ((palloc_index != last_palloc_index || first) && palloc_free_index == nps) {
  106234:	eb 1a                	jmp    106250 <palloc+0x40>
  106236:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10623d:	8d 76 00             	lea    0x0(%esi),%esi
  106240:	3d 00 00 04 00       	cmp    $0x40000,%eax
  106245:	74 30                	je     106277 <palloc+0x67>
  106247:	be 00 00 04 00       	mov    $0x40000,%esi
  10624c:	39 fd                	cmp    %edi,%ebp
  10624e:	75 68                	jne    1062b8 <palloc+0xa8>
        first = FALSE;
        if (at_is_norm(palloc_index) && !at_is_allocated(palloc_index)) {
  106250:	83 ec 0c             	sub    $0xc,%esp
  106253:	89 fd                	mov    %edi,%ebp
  106255:	56                   	push   %esi
  106256:	e8 75 fd ff ff       	call   105fd0 <at_is_norm>
  10625b:	83 c4 10             	add    $0x10,%esp
  10625e:	85 c0                	test   %eax,%eax
  106260:	75 3e                	jne    1062a0 <palloc+0x90>
            palloc_free_index = palloc_index;
        }
        palloc_index++;
  106262:	83 c6 01             	add    $0x1,%esi
    while ((palloc_index != last_palloc_index || first) && palloc_free_index == nps) {
  106265:	8b 83 28 03 00 00    	mov    0x328(%ebx),%eax
        if (palloc_index >= VM_USERHI_PI) {
  10626b:	81 fe ff ff 0e 00    	cmp    $0xeffff,%esi
  106271:	77 cd                	ja     106240 <palloc+0x30>
    while ((palloc_index != last_palloc_index || first) && palloc_free_index == nps) {
  106273:	39 c6                	cmp    %eax,%esi
  106275:	75 d5                	jne    10624c <palloc+0x3c>
            palloc_index = VM_USERLO_PI;
        }
    }

    if (palloc_free_index == nps) {
  106277:	39 fd                	cmp    %edi,%ebp
  106279:	75 3d                	jne    1062b8 <palloc+0xa8>
  10627b:	b8 00 00 04 00       	mov    $0x40000,%eax
        palloc_free_index = 0;
  106280:	31 ed                	xor    %ebp,%ebp
        last_palloc_index = VM_USERLO_PI;
  106282:	89 83 28 03 00 00    	mov    %eax,0x328(%ebx)
    } else {
        at_set_allocated(palloc_free_index, 1);
        last_palloc_index = palloc_free_index;
    }

    mem_unlock();
  106288:	e8 e3 fc ff ff       	call   105f70 <mem_unlock>

    return palloc_free_index;
}
  10628d:	83 c4 0c             	add    $0xc,%esp
  106290:	89 e8                	mov    %ebp,%eax
  106292:	5b                   	pop    %ebx
  106293:	5e                   	pop    %esi
  106294:	5f                   	pop    %edi
  106295:	5d                   	pop    %ebp
  106296:	c3                   	ret    
  106297:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10629e:	66 90                	xchg   %ax,%ax
        if (at_is_norm(palloc_index) && !at_is_allocated(palloc_index)) {
  1062a0:	83 ec 0c             	sub    $0xc,%esp
  1062a3:	89 f5                	mov    %esi,%ebp
  1062a5:	56                   	push   %esi
  1062a6:	e8 75 fd ff ff       	call   106020 <at_is_allocated>
  1062ab:	83 c4 10             	add    $0x10,%esp
  1062ae:	85 c0                	test   %eax,%eax
  1062b0:	0f 45 ef             	cmovne %edi,%ebp
  1062b3:	eb ad                	jmp    106262 <palloc+0x52>
  1062b5:	8d 76 00             	lea    0x0(%esi),%esi
        at_set_allocated(palloc_free_index, 1);
  1062b8:	83 ec 08             	sub    $0x8,%esp
  1062bb:	6a 01                	push   $0x1
  1062bd:	55                   	push   %ebp
  1062be:	e8 7d fd ff ff       	call   106040 <at_set_allocated>
  1062c3:	83 c4 10             	add    $0x10,%esp
  1062c6:	89 e8                	mov    %ebp,%eax
  1062c8:	eb b8                	jmp    106282 <palloc+0x72>
  1062ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001062d0 <pfree>:
 * in the allocation table.
 *
 * Hint: Simple.
 */
void pfree(unsigned int pfree_index)
{
  1062d0:	53                   	push   %ebx
  1062d1:	e8 b3 a0 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1062d6:	81 c3 2a 9d 00 00    	add    $0x9d2a,%ebx
  1062dc:	83 ec 08             	sub    $0x8,%esp
    mem_lock();
  1062df:	e8 6c fc ff ff       	call   105f50 <mem_lock>
    at_set_allocated(pfree_index, 0);
  1062e4:	83 ec 08             	sub    $0x8,%esp
  1062e7:	6a 00                	push   $0x0
  1062e9:	ff 74 24 1c          	push   0x1c(%esp)
  1062ed:	e8 4e fd ff ff       	call   106040 <at_set_allocated>
    mem_unlock();
  1062f2:	e8 79 fc ff ff       	call   105f70 <mem_unlock>
}
  1062f7:	83 c4 18             	add    $0x18,%esp
  1062fa:	5b                   	pop    %ebx
  1062fb:	c3                   	ret    
  1062fc:	66 90                	xchg   %ax,%ax
  1062fe:	66 90                	xchg   %ax,%ax

00106300 <container_init>:
/**
 * Initializes the container data for the root process (the one with index 0).
 * The root process is the one that gets spawned first by the kernel.
 */
void container_init(unsigned int mbi_addr)
{
  106300:	55                   	push   %ebp
  106301:	57                   	push   %edi
  106302:	56                   	push   %esi
  106303:	53                   	push   %ebx
  106304:	e8 80 a0 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106309:	81 c3 f7 9c 00 00    	add    $0x9cf7,%ebx
  10630f:	83 ec 18             	sub    $0x18,%esp
    unsigned int real_quota;
    unsigned int nps, idx;

    pmem_init(mbi_addr);
  106312:	ff 74 24 2c          	push   0x2c(%esp)
  106316:	e8 45 fd ff ff       	call   106060 <pmem_init>
    /**
     * Compute the available quota and store it into the variable real_quota.
     * It should be the number of the unallocated pages with the normal permission
     * in the physical memory allocation table.
     */
    nps = get_nps();
  10631b:	e8 70 fc ff ff       	call   105f90 <get_nps>
    idx = 1;
    while (idx < nps) {
  106320:	83 c4 10             	add    $0x10,%esp
  106323:	83 f8 01             	cmp    $0x1,%eax
  106326:	0f 86 b7 00 00 00    	jbe    1063e3 <container_init+0xe3>
  10632c:	89 c6                	mov    %eax,%esi
    idx = 1;
  10632e:	bd 01 00 00 00       	mov    $0x1,%ebp
    real_quota = 0;
  106333:	31 ff                	xor    %edi,%edi
  106335:	eb 10                	jmp    106347 <container_init+0x47>
  106337:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10633e:	66 90                	xchg   %ax,%ax
        if (at_is_norm(idx) && !at_is_allocated(idx)) {
            real_quota++;
        }
        idx++;
  106340:	83 c5 01             	add    $0x1,%ebp
    while (idx < nps) {
  106343:	39 ee                	cmp    %ebp,%esi
  106345:	74 29                	je     106370 <container_init+0x70>
        if (at_is_norm(idx) && !at_is_allocated(idx)) {
  106347:	83 ec 0c             	sub    $0xc,%esp
  10634a:	55                   	push   %ebp
  10634b:	e8 80 fc ff ff       	call   105fd0 <at_is_norm>
  106350:	83 c4 10             	add    $0x10,%esp
  106353:	85 c0                	test   %eax,%eax
  106355:	74 e9                	je     106340 <container_init+0x40>
  106357:	83 ec 0c             	sub    $0xc,%esp
  10635a:	55                   	push   %ebp
  10635b:	e8 c0 fc ff ff       	call   106020 <at_is_allocated>
  106360:	83 c4 10             	add    $0x10,%esp
            real_quota++;
  106363:	83 f8 01             	cmp    $0x1,%eax
  106366:	83 d7 00             	adc    $0x0,%edi
        idx++;
  106369:	83 c5 01             	add    $0x1,%ebp
    while (idx < nps) {
  10636c:	39 ee                	cmp    %ebp,%esi
  10636e:	75 d7                	jne    106347 <container_init+0x47>
    }

    KERN_DEBUG("\nreal quota: %d\n\n", real_quota);

    CONTAINER[0].quota = real_quota;
  106370:	89 fe                	mov    %edi,%esi
    KERN_DEBUG("\nreal quota: %d\n\n", real_quota);
  106372:	8d 83 74 a7 ff ff    	lea    -0x588c(%ebx),%eax
  106378:	57                   	push   %edi
  106379:	50                   	push   %eax
  10637a:	8d 83 88 a7 ff ff    	lea    -0x5878(%ebx),%eax
  106380:	6a 2c                	push   $0x2c
  106382:	50                   	push   %eax
  106383:	e8 68 dc ff ff       	call   103ff0 <debug_normal>
    CONTAINER[0].quota = real_quota;
  106388:	89 b3 c0 14 87 00    	mov    %esi,0x8714c0(%ebx)
    CONTAINER[0].usage = 0;
  10638e:	83 c4 10             	add    $0x10,%esp
  106391:	8d b3 c0 12 87 00    	lea    0x8712c0(%ebx),%esi
  106397:	c7 83 c4 14 87 00 00 	movl   $0x0,0x8714c4(%ebx)
  10639e:	00 00 00 
    CONTAINER[0].parent = 0;
  1063a1:	8d be 00 02 00 00    	lea    0x200(%esi),%edi
  1063a7:	c7 83 c8 14 87 00 00 	movl   $0x0,0x8714c8(%ebx)
  1063ae:	00 00 00 
    CONTAINER[0].nchildren = 0;
  1063b1:	c7 83 cc 14 87 00 00 	movl   $0x0,0x8714cc(%ebx)
  1063b8:	00 00 00 
    CONTAINER[0].used = 1;
  1063bb:	c7 83 d0 14 87 00 01 	movl   $0x1,0x8714d0(%ebx)
  1063c2:	00 00 00 

    for (idx = 0; idx < NUM_IDS; idx++) {
  1063c5:	8d 76 00             	lea    0x0(%esi),%esi
        spinlock_init(&container_lks[idx]);
  1063c8:	83 ec 0c             	sub    $0xc,%esp
  1063cb:	56                   	push   %esi
    for (idx = 0; idx < NUM_IDS; idx++) {
  1063cc:	83 c6 08             	add    $0x8,%esi
        spinlock_init(&container_lks[idx]);
  1063cf:	e8 cc f2 ff ff       	call   1056a0 <spinlock_init>
    for (idx = 0; idx < NUM_IDS; idx++) {
  1063d4:	83 c4 10             	add    $0x10,%esp
  1063d7:	39 fe                	cmp    %edi,%esi
  1063d9:	75 ed                	jne    1063c8 <container_init+0xc8>
    }
}
  1063db:	83 c4 0c             	add    $0xc,%esp
  1063de:	5b                   	pop    %ebx
  1063df:	5e                   	pop    %esi
  1063e0:	5f                   	pop    %edi
  1063e1:	5d                   	pop    %ebp
  1063e2:	c3                   	ret    
    while (idx < nps) {
  1063e3:	31 f6                	xor    %esi,%esi
    real_quota = 0;
  1063e5:	31 ff                	xor    %edi,%edi
  1063e7:	eb 89                	jmp    106372 <container_init+0x72>
  1063e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001063f0 <container_get_parent>:

// Get the id of parent process of process # [id].
unsigned int container_get_parent(unsigned int id)
{
    return CONTAINER[id].parent;
  1063f0:	e8 90 9f ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  1063f5:	81 c2 0b 9c 00 00    	add    $0x9c0b,%edx
{
  1063fb:	8b 44 24 04          	mov    0x4(%esp),%eax
    return CONTAINER[id].parent;
  1063ff:	8d 04 80             	lea    (%eax,%eax,4),%eax
  106402:	8b 84 82 c8 14 87 00 	mov    0x8714c8(%edx,%eax,4),%eax
}
  106409:	c3                   	ret    
  10640a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106410 <container_get_nchildren>:

// Get the number of children of process # [id].
unsigned int container_get_nchildren(unsigned int id)
{
    return CONTAINER[id].nchildren;
  106410:	e8 70 9f ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106415:	81 c2 eb 9b 00 00    	add    $0x9beb,%edx
{
  10641b:	8b 44 24 04          	mov    0x4(%esp),%eax
    return CONTAINER[id].nchildren;
  10641f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  106422:	8b 84 82 cc 14 87 00 	mov    0x8714cc(%edx,%eax,4),%eax
}
  106429:	c3                   	ret    
  10642a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106430 <container_get_quota>:

// Get the maximum memory quota of process # [id].
unsigned int container_get_quota(unsigned int id)
{
    return CONTAINER[id].quota;
  106430:	e8 50 9f ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106435:	81 c2 cb 9b 00 00    	add    $0x9bcb,%edx
{
  10643b:	8b 44 24 04          	mov    0x4(%esp),%eax
    return CONTAINER[id].quota;
  10643f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  106442:	8b 84 82 c0 14 87 00 	mov    0x8714c0(%edx,%eax,4),%eax
}
  106449:	c3                   	ret    
  10644a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106450 <container_get_usage>:

// Get the current memory usage of process # [id].
unsigned int container_get_usage(unsigned int id)
{
    return CONTAINER[id].usage;
  106450:	e8 30 9f ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106455:	81 c2 ab 9b 00 00    	add    $0x9bab,%edx
{
  10645b:	8b 44 24 04          	mov    0x4(%esp),%eax
    return CONTAINER[id].usage;
  10645f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  106462:	8b 84 82 c4 14 87 00 	mov    0x8714c4(%edx,%eax,4),%eax
}
  106469:	c3                   	ret    
  10646a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106470 <container_can_consume>:

// Determines whether the process # [id] can consume an extra
// [n] pages of memory. If so, returns 1, otherwise, returns 0.
unsigned int container_can_consume(unsigned int id, unsigned int n)
{
    return CONTAINER[id].usage + n <= CONTAINER[id].quota;
  106470:	e8 ce e3 ff ff       	call   104843 <__x86.get_pc_thunk.cx>
  106475:	81 c1 8b 9b 00 00    	add    $0x9b8b,%ecx
{
  10647b:	8b 44 24 04          	mov    0x4(%esp),%eax
    return CONTAINER[id].usage + n <= CONTAINER[id].quota;
  10647f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  106482:	c1 e0 02             	shl    $0x2,%eax
  106485:	8b 94 01 c4 14 87 00 	mov    0x8714c4(%ecx,%eax,1),%edx
  10648c:	03 54 24 08          	add    0x8(%esp),%edx
  106490:	3b 94 01 c0 14 87 00 	cmp    0x8714c0(%ecx,%eax,1),%edx
  106497:	0f 96 c0             	setbe  %al
  10649a:	0f b6 c0             	movzbl %al,%eax
}
  10649d:	c3                   	ret    
  10649e:	66 90                	xchg   %ax,%ax

001064a0 <container_split>:
 * You can assume it is safe to allocate [quota] pages
 * (the check is already done outside before calling this function).
 * Returns the container index for the new child process.
 */
unsigned int container_split(unsigned int id, unsigned int quota)
{
  1064a0:	55                   	push   %ebp
  1064a1:	57                   	push   %edi
  1064a2:	56                   	push   %esi
  1064a3:	53                   	push   %ebx
  1064a4:	e8 e0 9e ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1064a9:	81 c3 57 9b 00 00    	add    $0x9b57,%ebx
  1064af:	83 ec 28             	sub    $0x28,%esp
  1064b2:	8b 74 24 3c          	mov    0x3c(%esp),%esi
    unsigned int child, nc;

    spinlock_acquire(&container_lks[id]);

    nc = CONTAINER[id].nchildren;
    child = id * MAX_CHILDREN + 1 + nc;  // container index for the child process
  1064b6:	8d 7c 76 01          	lea    0x1(%esi,%esi,2),%edi
    spinlock_acquire(&container_lks[id]);
  1064ba:	8d ac f3 c0 12 87 00 	lea    0x8712c0(%ebx,%esi,8),%ebp
  1064c1:	55                   	push   %ebp
  1064c2:	e8 69 f2 ff ff       	call   105730 <spinlock_acquire>
    nc = CONTAINER[id].nchildren;
  1064c7:	8d 04 b6             	lea    (%esi,%esi,4),%eax

    if (NUM_IDS <= child) {
  1064ca:	83 c4 10             	add    $0x10,%esp
    nc = CONTAINER[id].nchildren;
  1064cd:	8d 84 83 c0 14 87 00 	lea    0x8714c0(%ebx,%eax,4),%eax
    child = id * MAX_CHILDREN + 1 + nc;  // container index for the child process
  1064d4:	03 78 0c             	add    0xc(%eax),%edi
    if (NUM_IDS <= child) {
  1064d7:	83 ff 3f             	cmp    $0x3f,%edi
  1064da:	77 54                	ja     106530 <container_split+0x90>
    }

    /**
     * Update the container structure of both parent and child process appropriately.
     */
    CONTAINER[child].used = 1;
  1064dc:	8d 14 bf             	lea    (%edi,%edi,4),%edx
    CONTAINER[child].nchildren = 0;

    CONTAINER[id].usage += quota;
    CONTAINER[id].nchildren++;

    spinlock_release(&container_lks[id]);
  1064df:	83 ec 0c             	sub    $0xc,%esp
    CONTAINER[child].used = 1;
  1064e2:	c1 e2 02             	shl    $0x2,%edx
  1064e5:	8d 8c 13 c0 14 87 00 	lea    0x8714c0(%ebx,%edx,1),%ecx
  1064ec:	89 54 24 18          	mov    %edx,0x18(%esp)
    CONTAINER[child].quota = quota;
  1064f0:	8b 54 24 40          	mov    0x40(%esp),%edx
    CONTAINER[child].usage = 0;
  1064f4:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
    CONTAINER[child].parent = id;
  1064fb:	89 71 08             	mov    %esi,0x8(%ecx)
    CONTAINER[child].nchildren = 0;
  1064fe:	c7 41 0c 00 00 00 00 	movl   $0x0,0xc(%ecx)
    CONTAINER[child].used = 1;
  106505:	c7 41 10 01 00 00 00 	movl   $0x1,0x10(%ecx)
    CONTAINER[id].nchildren++;
  10650c:	83 40 0c 01          	addl   $0x1,0xc(%eax)
    CONTAINER[child].quota = quota;
  106510:	89 11                	mov    %edx,(%ecx)
    CONTAINER[id].usage += quota;
  106512:	8b 4c 24 40          	mov    0x40(%esp),%ecx
  106516:	01 48 04             	add    %ecx,0x4(%eax)
    spinlock_release(&container_lks[id]);
  106519:	55                   	push   %ebp
  10651a:	e8 91 f2 ff ff       	call   1057b0 <spinlock_release>

    return child;
  10651f:	83 c4 10             	add    $0x10,%esp
}
  106522:	89 f8                	mov    %edi,%eax
  106524:	83 c4 1c             	add    $0x1c,%esp
  106527:	5b                   	pop    %ebx
  106528:	5e                   	pop    %esi
  106529:	5f                   	pop    %edi
  10652a:	5d                   	pop    %ebp
  10652b:	c3                   	ret    
  10652c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  106530:	83 c4 1c             	add    $0x1c,%esp
        return NUM_IDS;
  106533:	bf 40 00 00 00       	mov    $0x40,%edi
}
  106538:	5b                   	pop    %ebx
  106539:	89 f8                	mov    %edi,%eax
  10653b:	5e                   	pop    %esi
  10653c:	5f                   	pop    %edi
  10653d:	5d                   	pop    %ebp
  10653e:	c3                   	ret    
  10653f:	90                   	nop

00106540 <container_alloc>:
 * Allocates one more page for process # [id], given that this will not exceed the quota.
 * The container structure should be updated accordingly after the allocation.
 * Returns the page index of the allocated page, or 0 in the case of failure.
 */
unsigned int container_alloc(unsigned int id)
{
  106540:	57                   	push   %edi
  106541:	56                   	push   %esi
  106542:	53                   	push   %ebx
  106543:	8b 74 24 10          	mov    0x10(%esp),%esi
  106547:	e8 3d 9e ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10654c:	81 c3 b4 9a 00 00    	add    $0x9ab4,%ebx
    unsigned int page_index = 0;

    spinlock_acquire(&container_lks[id]);
  106552:	83 ec 0c             	sub    $0xc,%esp
  106555:	8d bc f3 c0 12 87 00 	lea    0x8712c0(%ebx,%esi,8),%edi
  10655c:	57                   	push   %edi
  10655d:	e8 ce f1 ff ff       	call   105730 <spinlock_acquire>

    if (CONTAINER[id].usage + 1 <= CONTAINER[id].quota) {
  106562:	8d 14 b6             	lea    (%esi,%esi,4),%edx
  106565:	83 c4 10             	add    $0x10,%esp
  106568:	31 f6                	xor    %esi,%esi
  10656a:	c1 e2 02             	shl    $0x2,%edx
  10656d:	8d 8c 13 c0 14 87 00 	lea    0x8714c0(%ebx,%edx,1),%ecx
  106574:	8b 41 04             	mov    0x4(%ecx),%eax
  106577:	3b 84 13 c0 14 87 00 	cmp    0x8714c0(%ebx,%edx,1),%eax
  10657e:	7c 18                	jl     106598 <container_alloc+0x58>
        CONTAINER[id].usage++;
        page_index = palloc();
    }

    spinlock_release(&container_lks[id]);
  106580:	83 ec 0c             	sub    $0xc,%esp
  106583:	57                   	push   %edi
  106584:	e8 27 f2 ff ff       	call   1057b0 <spinlock_release>

    return page_index;
  106589:	83 c4 10             	add    $0x10,%esp
}
  10658c:	89 f0                	mov    %esi,%eax
  10658e:	5b                   	pop    %ebx
  10658f:	5e                   	pop    %esi
  106590:	5f                   	pop    %edi
  106591:	c3                   	ret    
  106592:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        CONTAINER[id].usage++;
  106598:	83 c0 01             	add    $0x1,%eax
  10659b:	89 41 04             	mov    %eax,0x4(%ecx)
        page_index = palloc();
  10659e:	e8 6d fc ff ff       	call   106210 <palloc>
  1065a3:	89 c6                	mov    %eax,%esi
  1065a5:	eb d9                	jmp    106580 <container_alloc+0x40>
  1065a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1065ae:	66 90                	xchg   %ax,%ax

001065b0 <container_free>:

// Frees the physical page and reduces the usage by 1.
void container_free(unsigned int id, unsigned int page_index)
{
  1065b0:	55                   	push   %ebp
  1065b1:	57                   	push   %edi
  1065b2:	56                   	push   %esi
  1065b3:	53                   	push   %ebx
  1065b4:	e8 d0 9d ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1065b9:	81 c3 47 9a 00 00    	add    $0x9a47,%ebx
  1065bf:	83 ec 18             	sub    $0x18,%esp
  1065c2:	8b 74 24 2c          	mov    0x2c(%esp),%esi
  1065c6:	8b 7c 24 30          	mov    0x30(%esp),%edi
    spinlock_acquire(&container_lks[id]);
  1065ca:	8d ac f3 c0 12 87 00 	lea    0x8712c0(%ebx,%esi,8),%ebp
  1065d1:	55                   	push   %ebp
  1065d2:	e8 59 f1 ff ff       	call   105730 <spinlock_acquire>

    if (at_is_allocated(page_index)) {
  1065d7:	89 3c 24             	mov    %edi,(%esp)
  1065da:	e8 41 fa ff ff       	call   106020 <at_is_allocated>
  1065df:	83 c4 10             	add    $0x10,%esp
  1065e2:	85 c0                	test   %eax,%eax
  1065e4:	75 1a                	jne    106600 <container_free+0x50>
        if (CONTAINER[id].usage > 0) {
            CONTAINER[id].usage--;
        }
    }

    spinlock_release(&container_lks[id]);
  1065e6:	83 ec 0c             	sub    $0xc,%esp
  1065e9:	55                   	push   %ebp
  1065ea:	e8 c1 f1 ff ff       	call   1057b0 <spinlock_release>
}
  1065ef:	83 c4 1c             	add    $0x1c,%esp
  1065f2:	5b                   	pop    %ebx
  1065f3:	5e                   	pop    %esi
  1065f4:	5f                   	pop    %edi
  1065f5:	5d                   	pop    %ebp
  1065f6:	c3                   	ret    
  1065f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1065fe:	66 90                	xchg   %ax,%ax
        pfree(page_index);
  106600:	83 ec 0c             	sub    $0xc,%esp
  106603:	57                   	push   %edi
  106604:	e8 c7 fc ff ff       	call   1062d0 <pfree>
        if (CONTAINER[id].usage > 0) {
  106609:	8d 04 b6             	lea    (%esi,%esi,4),%eax
  10660c:	83 c4 10             	add    $0x10,%esp
  10660f:	8d 94 83 c0 14 87 00 	lea    0x8714c0(%ebx,%eax,4),%edx
  106616:	8b 42 04             	mov    0x4(%edx),%eax
  106619:	85 c0                	test   %eax,%eax
  10661b:	7e c9                	jle    1065e6 <container_free+0x36>
            CONTAINER[id].usage--;
  10661d:	83 e8 01             	sub    $0x1,%eax
  106620:	89 42 04             	mov    %eax,0x4(%edx)
  106623:	eb c1                	jmp    1065e6 <container_free+0x36>
  106625:	66 90                	xchg   %ax,%ax
  106627:	66 90                	xchg   %ax,%ax
  106629:	66 90                	xchg   %ax,%ax
  10662b:	66 90                	xchg   %ax,%ax
  10662d:	66 90                	xchg   %ax,%ax
  10662f:	90                   	nop

00106630 <set_pdir_base>:
 */
unsigned int IDPTbl[1024][1024] gcc_aligned(PAGESIZE);

// Sets the CR3 register with the start address of the page structure for process # [index].
void set_pdir_base(unsigned int index)
{
  106630:	53                   	push   %ebx
  106631:	e8 53 9d ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106636:	81 c3 ca 99 00 00    	add    $0x99ca,%ebx
  10663c:	83 ec 14             	sub    $0x14,%esp
    set_cr3(PDirPool[index]);
  10663f:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  106643:	c1 e0 0c             	shl    $0xc,%eax
  106646:	8d 84 03 00 20 c7 00 	lea    0xc72000(%ebx,%eax,1),%eax
  10664d:	50                   	push   %eax
  10664e:	e8 3d ab ff ff       	call   101190 <set_cr3>
}
  106653:	83 c4 18             	add    $0x18,%esp
  106656:	5b                   	pop    %ebx
  106657:	c3                   	ret    
  106658:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10665f:	90                   	nop

00106660 <get_pdir_entry>:

// Returns the page directory entry # [pde_index] of the process # [proc_index].
// This can be used to test whether the page directory entry is mapped.
unsigned int get_pdir_entry(unsigned int proc_index, unsigned int pde_index)
{
    return (unsigned int) PDirPool[proc_index][pde_index];
  106660:	e8 20 9d ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106665:	81 c2 9b 99 00 00    	add    $0x999b,%edx
  10666b:	8b 44 24 04          	mov    0x4(%esp),%eax
  10666f:	c1 e0 0a             	shl    $0xa,%eax
  106672:	03 44 24 08          	add    0x8(%esp),%eax
  106676:	8b 84 82 00 20 c7 00 	mov    0xc72000(%edx,%eax,4),%eax
}
  10667d:	c3                   	ret    
  10667e:	66 90                	xchg   %ax,%ax

00106680 <set_pdir_entry>:
// You should also set the permissions PTE_P, PTE_W, and PTE_U.
void set_pdir_entry(unsigned int proc_index, unsigned int pde_index,
                    unsigned int page_index)
{
    unsigned int addr = page_index << 12;
    PDirPool[proc_index][pde_index] = (unsigned int *) (addr | PT_PERM_PTU);
  106680:	e8 be e1 ff ff       	call   104843 <__x86.get_pc_thunk.cx>
  106685:	81 c1 7b 99 00 00    	add    $0x997b,%ecx
    unsigned int addr = page_index << 12;
  10668b:	8b 54 24 0c          	mov    0xc(%esp),%edx
    PDirPool[proc_index][pde_index] = (unsigned int *) (addr | PT_PERM_PTU);
  10668f:	8b 44 24 04          	mov    0x4(%esp),%eax
    unsigned int addr = page_index << 12;
  106693:	c1 e2 0c             	shl    $0xc,%edx
    PDirPool[proc_index][pde_index] = (unsigned int *) (addr | PT_PERM_PTU);
  106696:	c1 e0 0a             	shl    $0xa,%eax
  106699:	03 44 24 08          	add    0x8(%esp),%eax
  10669d:	83 ca 07             	or     $0x7,%edx
  1066a0:	89 94 81 00 20 c7 00 	mov    %edx,0xc72000(%ecx,%eax,4)
}
  1066a7:	c3                   	ret    
  1066a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1066af:	90                   	nop

001066b0 <set_pdir_entry_identity>:
// with the initial address of page directory # [pde_index] in IDPTbl.
// You should also set the permissions PTE_P, PTE_W, and PTE_U.
// This will be used to map a page directory entry to an identity page table.
void set_pdir_entry_identity(unsigned int proc_index, unsigned int pde_index)
{
    unsigned int addr = (unsigned int) IDPTbl[pde_index];
  1066b0:	e8 8e e1 ff ff       	call   104843 <__x86.get_pc_thunk.cx>
  1066b5:	81 c1 4b 99 00 00    	add    $0x994b,%ecx
    PDirPool[proc_index][pde_index] = (unsigned int *) (addr | PT_PERM_PTU);
  1066bb:	8b 44 24 04          	mov    0x4(%esp),%eax
{
  1066bf:	8b 54 24 08          	mov    0x8(%esp),%edx
    PDirPool[proc_index][pde_index] = (unsigned int *) (addr | PT_PERM_PTU);
  1066c3:	c1 e0 0a             	shl    $0xa,%eax
  1066c6:	01 d0                	add    %edx,%eax
    unsigned int addr = (unsigned int) IDPTbl[pde_index];
  1066c8:	c1 e2 0c             	shl    $0xc,%edx
  1066cb:	8d 94 11 00 20 87 00 	lea    0x872000(%ecx,%edx,1),%edx
    PDirPool[proc_index][pde_index] = (unsigned int *) (addr | PT_PERM_PTU);
  1066d2:	83 ca 07             	or     $0x7,%edx
  1066d5:	89 94 81 00 20 c7 00 	mov    %edx,0xc72000(%ecx,%eax,4)
}
  1066dc:	c3                   	ret    
  1066dd:	8d 76 00             	lea    0x0(%esi),%esi

001066e0 <rmv_pdir_entry>:

// Removes the specified page directory entry (sets the page directory entry to 0).
// Don't forget to cast the value to (unsigned int *).
void rmv_pdir_entry(unsigned int proc_index, unsigned int pde_index)
{
    PDirPool[proc_index][pde_index] = (unsigned int *) 0;
  1066e0:	e8 a0 9c ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  1066e5:	81 c2 1b 99 00 00    	add    $0x991b,%edx
  1066eb:	8b 44 24 04          	mov    0x4(%esp),%eax
  1066ef:	c1 e0 0a             	shl    $0xa,%eax
  1066f2:	03 44 24 08          	add    0x8(%esp),%eax
  1066f6:	c7 84 82 00 20 c7 00 	movl   $0x0,0xc72000(%edx,%eax,4)
  1066fd:	00 00 00 00 
}
  106701:	c3                   	ret    
  106702:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00106710 <get_ptbl_entry>:
// Do not forget that the permission info is also stored in the page directory entries.
unsigned int get_ptbl_entry(unsigned int proc_index, unsigned int pde_index,
                            unsigned int pte_index)
{
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
    return pt[pte_index];
  106710:	e8 70 9c ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106715:	81 c2 eb 98 00 00    	add    $0x98eb,%edx
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  10671b:	8b 44 24 04          	mov    0x4(%esp),%eax
  10671f:	c1 e0 0a             	shl    $0xa,%eax
  106722:	03 44 24 08          	add    0x8(%esp),%eax
  106726:	8b 84 82 00 20 c7 00 	mov    0xc72000(%edx,%eax,4),%eax
    return pt[pte_index];
  10672d:	8b 54 24 0c          	mov    0xc(%esp),%edx
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  106731:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    return pt[pte_index];
  106736:	8b 04 90             	mov    (%eax,%edx,4),%eax
}
  106739:	c3                   	ret    
  10673a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106740 <set_ptbl_entry>:
void set_ptbl_entry(unsigned int proc_index, unsigned int pde_index,
                    unsigned int pte_index, unsigned int page_index,
                    unsigned int perm)
{
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
    pt[pte_index] = (page_index << 12) | perm;
  106740:	e8 40 9c ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106745:	81 c2 bb 98 00 00    	add    $0x98bb,%edx
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  10674b:	8b 44 24 04          	mov    0x4(%esp),%eax
    pt[pte_index] = (page_index << 12) | perm;
  10674f:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  106753:	c1 e0 0a             	shl    $0xa,%eax
  106756:	03 44 24 08          	add    0x8(%esp),%eax
  10675a:	8b 94 82 00 20 c7 00 	mov    0xc72000(%edx,%eax,4),%edx
    pt[pte_index] = (page_index << 12) | perm;
  106761:	8b 44 24 10          	mov    0x10(%esp),%eax
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  106765:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
    pt[pte_index] = (page_index << 12) | perm;
  10676b:	c1 e0 0c             	shl    $0xc,%eax
  10676e:	0b 44 24 14          	or     0x14(%esp),%eax
  106772:	89 04 8a             	mov    %eax,(%edx,%ecx,4)
}
  106775:	c3                   	ret    
  106776:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10677d:	8d 76 00             	lea    0x0(%esi),%esi

00106780 <set_ptbl_entry_identity>:

// Sets up the specified page table entry in IDPTbl as the identity map.
// You should also set the given permission.
void set_ptbl_entry_identity(unsigned int pde_index, unsigned int pte_index,
                             unsigned int perm)
{
  106780:	53                   	push   %ebx
  106781:	8b 54 24 08          	mov    0x8(%esp),%edx
  106785:	e8 ff 9b ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10678a:	81 c3 76 98 00 00    	add    $0x9876,%ebx
  106790:	8b 44 24 0c          	mov    0xc(%esp),%eax
    unsigned int addr = (pde_index << 22) | (pte_index << 12);
    IDPTbl[pde_index][pte_index] = addr | perm;
  106794:	89 d1                	mov    %edx,%ecx
    unsigned int addr = (pde_index << 22) | (pte_index << 12);
  106796:	c1 e2 16             	shl    $0x16,%edx
    IDPTbl[pde_index][pte_index] = addr | perm;
  106799:	c1 e1 0a             	shl    $0xa,%ecx
  10679c:	01 c1                	add    %eax,%ecx
    unsigned int addr = (pde_index << 22) | (pte_index << 12);
  10679e:	c1 e0 0c             	shl    $0xc,%eax
    IDPTbl[pde_index][pte_index] = addr | perm;
  1067a1:	0b 44 24 10          	or     0x10(%esp),%eax
  1067a5:	09 d0                	or     %edx,%eax
  1067a7:	89 84 8b 00 20 87 00 	mov    %eax,0x872000(%ebx,%ecx,4)
}
  1067ae:	5b                   	pop    %ebx
  1067af:	c3                   	ret    

001067b0 <rmv_ptbl_entry>:
// Sets the specified page table entry to 0.
void rmv_ptbl_entry(unsigned int proc_index, unsigned int pde_index,
                    unsigned int pte_index)
{
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
    pt[pte_index] = 0;
  1067b0:	e8 d0 9b ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  1067b5:	81 c2 4b 98 00 00    	add    $0x984b,%edx
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  1067bb:	8b 44 24 04          	mov    0x4(%esp),%eax
  1067bf:	c1 e0 0a             	shl    $0xa,%eax
  1067c2:	03 44 24 08          	add    0x8(%esp),%eax
  1067c6:	8b 84 82 00 20 c7 00 	mov    0xc72000(%edx,%eax,4),%eax
    pt[pte_index] = 0;
  1067cd:	8b 54 24 0c          	mov    0xc(%esp),%edx
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  1067d1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    pt[pte_index] = 0;
  1067d6:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
}
  1067dd:	c3                   	ret    
  1067de:	66 90                	xchg   %ax,%ax

001067e0 <get_ptbl_entry_by_va>:
 * Returns the page table entry corresponding to the virtual address,
 * according to the page structure of process # [proc_index].
 * Returns 0 if the mapping does not exist.
 */
unsigned int get_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  1067e0:	55                   	push   %ebp
  1067e1:	57                   	push   %edi
  1067e2:	56                   	push   %esi
  1067e3:	53                   	push   %ebx
  1067e4:	e8 a0 9b ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1067e9:	81 c3 17 98 00 00    	add    $0x9817,%ebx
  1067ef:	83 ec 14             	sub    $0x14,%esp
  1067f2:	8b 74 24 2c          	mov    0x2c(%esp),%esi
  1067f6:	8b 7c 24 28          	mov    0x28(%esp),%edi
    unsigned int pde_index = PDE_ADDR(vaddr);
  1067fa:	89 f5                	mov    %esi,%ebp
  1067fc:	c1 ed 16             	shr    $0x16,%ebp
    if (get_pdir_entry(proc_index, pde_index) != 0) {
  1067ff:	55                   	push   %ebp
  106800:	57                   	push   %edi
  106801:	e8 5a fe ff ff       	call   106660 <get_pdir_entry>
  106806:	83 c4 10             	add    $0x10,%esp
  106809:	85 c0                	test   %eax,%eax
  10680b:	75 0b                	jne    106818 <get_ptbl_entry_by_va+0x38>
        return get_ptbl_entry(proc_index, pde_index, PTE_ADDR(vaddr));
    } else {
        return 0;
    }
}
  10680d:	83 c4 0c             	add    $0xc,%esp
  106810:	5b                   	pop    %ebx
  106811:	5e                   	pop    %esi
  106812:	5f                   	pop    %edi
  106813:	5d                   	pop    %ebp
  106814:	c3                   	ret    
  106815:	8d 76 00             	lea    0x0(%esi),%esi
        return get_ptbl_entry(proc_index, pde_index, PTE_ADDR(vaddr));
  106818:	c1 ee 0c             	shr    $0xc,%esi
  10681b:	83 ec 04             	sub    $0x4,%esp
  10681e:	81 e6 ff 03 00 00    	and    $0x3ff,%esi
  106824:	56                   	push   %esi
  106825:	55                   	push   %ebp
  106826:	57                   	push   %edi
  106827:	e8 e4 fe ff ff       	call   106710 <get_ptbl_entry>
  10682c:	83 c4 10             	add    $0x10,%esp
}
  10682f:	83 c4 0c             	add    $0xc,%esp
  106832:	5b                   	pop    %ebx
  106833:	5e                   	pop    %esi
  106834:	5f                   	pop    %edi
  106835:	5d                   	pop    %ebp
  106836:	c3                   	ret    
  106837:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10683e:	66 90                	xchg   %ax,%ax

00106840 <get_pdir_entry_by_va>:

// Returns the page directory entry corresponding to the given virtual address.
unsigned int get_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  106840:	53                   	push   %ebx
  106841:	e8 43 9b ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106846:	81 c3 ba 97 00 00    	add    $0x97ba,%ebx
  10684c:	83 ec 10             	sub    $0x10,%esp
    return get_pdir_entry(proc_index, PDE_ADDR(vaddr));
  10684f:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  106853:	c1 e8 16             	shr    $0x16,%eax
  106856:	50                   	push   %eax
  106857:	ff 74 24 1c          	push   0x1c(%esp)
  10685b:	e8 00 fe ff ff       	call   106660 <get_pdir_entry>
}
  106860:	83 c4 18             	add    $0x18,%esp
  106863:	5b                   	pop    %ebx
  106864:	c3                   	ret    
  106865:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10686c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106870 <rmv_ptbl_entry_by_va>:

// Removes the page table entry for the given virtual address.
void rmv_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  106870:	55                   	push   %ebp
  106871:	57                   	push   %edi
  106872:	56                   	push   %esi
  106873:	53                   	push   %ebx
  106874:	e8 10 9b ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106879:	81 c3 87 97 00 00    	add    $0x9787,%ebx
  10687f:	83 ec 14             	sub    $0x14,%esp
  106882:	8b 74 24 2c          	mov    0x2c(%esp),%esi
  106886:	8b 7c 24 28          	mov    0x28(%esp),%edi
    unsigned int pde_index = PDE_ADDR(vaddr);
  10688a:	89 f5                	mov    %esi,%ebp
  10688c:	c1 ed 16             	shr    $0x16,%ebp
    if (get_pdir_entry(proc_index, pde_index) != 0) {
  10688f:	55                   	push   %ebp
  106890:	57                   	push   %edi
  106891:	e8 ca fd ff ff       	call   106660 <get_pdir_entry>
  106896:	83 c4 10             	add    $0x10,%esp
  106899:	85 c0                	test   %eax,%eax
  10689b:	75 0b                	jne    1068a8 <rmv_ptbl_entry_by_va+0x38>
        rmv_ptbl_entry(proc_index, pde_index, PTE_ADDR(vaddr));
    }
}
  10689d:	83 c4 0c             	add    $0xc,%esp
  1068a0:	5b                   	pop    %ebx
  1068a1:	5e                   	pop    %esi
  1068a2:	5f                   	pop    %edi
  1068a3:	5d                   	pop    %ebp
  1068a4:	c3                   	ret    
  1068a5:	8d 76 00             	lea    0x0(%esi),%esi
        rmv_ptbl_entry(proc_index, pde_index, PTE_ADDR(vaddr));
  1068a8:	c1 ee 0c             	shr    $0xc,%esi
  1068ab:	83 ec 04             	sub    $0x4,%esp
  1068ae:	81 e6 ff 03 00 00    	and    $0x3ff,%esi
  1068b4:	56                   	push   %esi
  1068b5:	55                   	push   %ebp
  1068b6:	57                   	push   %edi
  1068b7:	e8 f4 fe ff ff       	call   1067b0 <rmv_ptbl_entry>
  1068bc:	83 c4 10             	add    $0x10,%esp
}
  1068bf:	83 c4 0c             	add    $0xc,%esp
  1068c2:	5b                   	pop    %ebx
  1068c3:	5e                   	pop    %esi
  1068c4:	5f                   	pop    %edi
  1068c5:	5d                   	pop    %ebp
  1068c6:	c3                   	ret    
  1068c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1068ce:	66 90                	xchg   %ax,%ax

001068d0 <rmv_pdir_entry_by_va>:

// Removes the page directory entry for the given virtual address.
void rmv_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  1068d0:	53                   	push   %ebx
  1068d1:	e8 b3 9a ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1068d6:	81 c3 2a 97 00 00    	add    $0x972a,%ebx
  1068dc:	83 ec 10             	sub    $0x10,%esp
    rmv_pdir_entry(proc_index, PDE_ADDR(vaddr));
  1068df:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  1068e3:	c1 e8 16             	shr    $0x16,%eax
  1068e6:	50                   	push   %eax
  1068e7:	ff 74 24 1c          	push   0x1c(%esp)
  1068eb:	e8 f0 fd ff ff       	call   1066e0 <rmv_pdir_entry>
}
  1068f0:	83 c4 18             	add    $0x18,%esp
  1068f3:	5b                   	pop    %ebx
  1068f4:	c3                   	ret    
  1068f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1068fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106900 <set_ptbl_entry_by_va>:

// Maps the virtual address [vaddr] to the physical page # [page_index] with permission [perm].
// You do not need to worry about the page directory entry. just map the page table entry.
void set_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr,
                          unsigned int page_index, unsigned int perm)
{
  106900:	53                   	push   %ebx
  106901:	e8 83 9a ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106906:	81 c3 fa 96 00 00    	add    $0x96fa,%ebx
  10690c:	83 ec 14             	sub    $0x14,%esp
  10690f:	8b 44 24 20          	mov    0x20(%esp),%eax
    set_ptbl_entry(proc_index, PDE_ADDR(vaddr), PTE_ADDR(vaddr), page_index, perm);
  106913:	ff 74 24 28          	push   0x28(%esp)
  106917:	ff 74 24 28          	push   0x28(%esp)
  10691b:	89 c2                	mov    %eax,%edx
  10691d:	c1 e8 16             	shr    $0x16,%eax
  106920:	c1 ea 0c             	shr    $0xc,%edx
  106923:	81 e2 ff 03 00 00    	and    $0x3ff,%edx
  106929:	52                   	push   %edx
  10692a:	50                   	push   %eax
  10692b:	ff 74 24 2c          	push   0x2c(%esp)
  10692f:	e8 0c fe ff ff       	call   106740 <set_ptbl_entry>
}
  106934:	83 c4 28             	add    $0x28,%esp
  106937:	5b                   	pop    %ebx
  106938:	c3                   	ret    
  106939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00106940 <set_pdir_entry_by_va>:

// Registers the mapping from [vaddr] to physical page # [page_index] in the page directory.
void set_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr,
                          unsigned int page_index)
{
  106940:	53                   	push   %ebx
  106941:	e8 43 9a ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106946:	81 c3 ba 96 00 00    	add    $0x96ba,%ebx
  10694c:	83 ec 0c             	sub    $0xc,%esp
    set_pdir_entry(proc_index, PDE_ADDR(vaddr), page_index);
  10694f:	ff 74 24 1c          	push   0x1c(%esp)
  106953:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  106957:	c1 e8 16             	shr    $0x16,%eax
  10695a:	50                   	push   %eax
  10695b:	ff 74 24 1c          	push   0x1c(%esp)
  10695f:	e8 1c fd ff ff       	call   106680 <set_pdir_entry>
}
  106964:	83 c4 18             	add    $0x18,%esp
  106967:	5b                   	pop    %ebx
  106968:	c3                   	ret    
  106969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00106970 <idptbl_init>:

// Initializes the identity page table.
// The permission for the kernel memory should be PTE_P, PTE_W, and PTE_G,
// While the permission for the rest should be PTE_P and PTE_W.
void idptbl_init(unsigned int mbi_addr)
{
  106970:	55                   	push   %ebp
    unsigned int pde_index, pte_index, perm;
    container_init(mbi_addr);

    // Set up IDPTbl
    for (pde_index = 0; pde_index < 1024; pde_index++) {
  106971:	31 ed                	xor    %ebp,%ebp
{
  106973:	57                   	push   %edi
  106974:	56                   	push   %esi
  106975:	53                   	push   %ebx
  106976:	e8 0e 9a ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10697b:	81 c3 85 96 00 00    	add    $0x9685,%ebx
  106981:	83 ec 18             	sub    $0x18,%esp
    container_init(mbi_addr);
  106984:	ff 74 24 2c          	push   0x2c(%esp)
  106988:	e8 73 f9 ff ff       	call   106300 <container_init>
  10698d:	83 c4 10             	add    $0x10,%esp
        if ((pde_index < VM_USERLO_PDE) || (VM_USERHI_PDE <= pde_index)) {
  106990:	8d 85 00 ff ff ff    	lea    -0x100(%ebp),%eax
            // kernel mapping
            perm = PTE_P | PTE_W | PTE_G;
        } else {
            // normal memory
            perm = PTE_P | PTE_W;
  106996:	3d c0 02 00 00       	cmp    $0x2c0,%eax
  10699b:	19 ff                	sbb    %edi,%edi
        }

        for (pte_index = 0; pte_index < 1024; pte_index++) {
  10699d:	31 f6                	xor    %esi,%esi
            perm = PTE_P | PTE_W;
  10699f:	81 e7 00 ff ff ff    	and    $0xffffff00,%edi
  1069a5:	81 c7 03 01 00 00    	add    $0x103,%edi
        for (pte_index = 0; pte_index < 1024; pte_index++) {
  1069ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1069af:	90                   	nop
            set_ptbl_entry_identity(pde_index, pte_index, perm);
  1069b0:	83 ec 04             	sub    $0x4,%esp
  1069b3:	57                   	push   %edi
  1069b4:	56                   	push   %esi
        for (pte_index = 0; pte_index < 1024; pte_index++) {
  1069b5:	83 c6 01             	add    $0x1,%esi
            set_ptbl_entry_identity(pde_index, pte_index, perm);
  1069b8:	55                   	push   %ebp
  1069b9:	e8 c2 fd ff ff       	call   106780 <set_ptbl_entry_identity>
        for (pte_index = 0; pte_index < 1024; pte_index++) {
  1069be:	83 c4 10             	add    $0x10,%esp
  1069c1:	81 fe 00 04 00 00    	cmp    $0x400,%esi
  1069c7:	75 e7                	jne    1069b0 <idptbl_init+0x40>
    for (pde_index = 0; pde_index < 1024; pde_index++) {
  1069c9:	83 c5 01             	add    $0x1,%ebp
  1069cc:	81 fd 00 04 00 00    	cmp    $0x400,%ebp
  1069d2:	75 bc                	jne    106990 <idptbl_init+0x20>
        }
    }
}
  1069d4:	83 c4 0c             	add    $0xc,%esp
  1069d7:	5b                   	pop    %ebx
  1069d8:	5e                   	pop    %esi
  1069d9:	5f                   	pop    %edi
  1069da:	5d                   	pop    %ebp
  1069db:	c3                   	ret    
  1069dc:	66 90                	xchg   %ax,%ax
  1069de:	66 90                	xchg   %ax,%ax

001069e0 <pdir_init>:
 * For each process from id 0 to NUM_IDS - 1,
 * set up the page directory entries so that the kernel portion of the map is
 * the identity map, and the rest of the page directories are unmapped.
 */
void pdir_init(unsigned int mbi_addr)
{
  1069e0:	57                   	push   %edi
    unsigned int proc_index, pde_index;
    idptbl_init(mbi_addr);

    for (proc_index = 0; proc_index < NUM_IDS; proc_index++) {
  1069e1:	31 ff                	xor    %edi,%edi
{
  1069e3:	56                   	push   %esi
  1069e4:	53                   	push   %ebx
  1069e5:	e8 9f 99 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1069ea:	81 c3 16 96 00 00    	add    $0x9616,%ebx
    idptbl_init(mbi_addr);
  1069f0:	83 ec 0c             	sub    $0xc,%esp
  1069f3:	ff 74 24 1c          	push   0x1c(%esp)
  1069f7:	e8 74 ff ff ff       	call   106970 <idptbl_init>
  1069fc:	83 c4 10             	add    $0x10,%esp
        for (pde_index = 0; pde_index < 1024; pde_index++) {
  1069ff:	31 c0                	xor    %eax,%eax
  106a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            if ((pde_index < VM_USERLO_PDE) || (VM_USERHI_PDE <= pde_index)) {
  106a08:	8d 90 00 ff ff ff    	lea    -0x100(%eax),%edx
        for (pde_index = 0; pde_index < 1024; pde_index++) {
  106a0e:	8d 70 01             	lea    0x1(%eax),%esi
            if ((pde_index < VM_USERLO_PDE) || (VM_USERHI_PDE <= pde_index)) {
  106a11:	81 fa bf 02 00 00    	cmp    $0x2bf,%edx
  106a17:	77 11                	ja     106a2a <pdir_init+0x4a>
                set_pdir_entry_identity(proc_index, pde_index);
            } else {
                rmv_pdir_entry(proc_index, pde_index);
  106a19:	83 ec 08             	sub    $0x8,%esp
  106a1c:	50                   	push   %eax
  106a1d:	57                   	push   %edi
  106a1e:	e8 bd fc ff ff       	call   1066e0 <rmv_pdir_entry>
  106a23:	83 c4 10             	add    $0x10,%esp
        for (pde_index = 0; pde_index < 1024; pde_index++) {
  106a26:	89 f0                	mov    %esi,%eax
  106a28:	eb de                	jmp    106a08 <pdir_init+0x28>
                set_pdir_entry_identity(proc_index, pde_index);
  106a2a:	83 ec 08             	sub    $0x8,%esp
  106a2d:	50                   	push   %eax
  106a2e:	57                   	push   %edi
  106a2f:	e8 7c fc ff ff       	call   1066b0 <set_pdir_entry_identity>
        for (pde_index = 0; pde_index < 1024; pde_index++) {
  106a34:	83 c4 10             	add    $0x10,%esp
  106a37:	81 fe 00 04 00 00    	cmp    $0x400,%esi
  106a3d:	75 e7                	jne    106a26 <pdir_init+0x46>
    for (proc_index = 0; proc_index < NUM_IDS; proc_index++) {
  106a3f:	83 c7 01             	add    $0x1,%edi
  106a42:	83 ff 40             	cmp    $0x40,%edi
  106a45:	75 b8                	jne    1069ff <pdir_init+0x1f>
            }
        }
    }
}
  106a47:	5b                   	pop    %ebx
  106a48:	5e                   	pop    %esi
  106a49:	5f                   	pop    %edi
  106a4a:	c3                   	ret    
  106a4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  106a4f:	90                   	nop

00106a50 <alloc_ptbl>:
 * and clears (set to 0) all page table entries for this newly mapped page table.
 * It returns the page index of the newly allocated physical page.
 * In the case when there's no physical page available, it returns 0.
 */
unsigned int alloc_ptbl(unsigned int proc_index, unsigned int vaddr)
{
  106a50:	55                   	push   %ebp
  106a51:	57                   	push   %edi
  106a52:	56                   	push   %esi
  106a53:	53                   	push   %ebx
  106a54:	e8 30 99 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106a59:	81 c3 a7 95 00 00    	add    $0x95a7,%ebx
  106a5f:	83 ec 28             	sub    $0x28,%esp
  106a62:	8b 74 24 3c          	mov    0x3c(%esp),%esi
    unsigned int page_index = container_alloc(proc_index);
  106a66:	56                   	push   %esi
  106a67:	e8 d4 fa ff ff       	call   106540 <container_alloc>
  106a6c:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    unsigned int pde_index = PDE_ADDR(vaddr);
    unsigned int pte_index;

    if (page_index == 0) {
  106a70:	83 c4 10             	add    $0x10,%esp
  106a73:	85 c0                	test   %eax,%eax
  106a75:	75 0c                	jne    106a83 <alloc_ptbl+0x33>
            rmv_ptbl_entry(proc_index, pde_index, pte_index);
        }

        return page_index;
    }
}
  106a77:	8b 44 24 0c          	mov    0xc(%esp),%eax
  106a7b:	83 c4 1c             	add    $0x1c,%esp
  106a7e:	5b                   	pop    %ebx
  106a7f:	5e                   	pop    %esi
  106a80:	5f                   	pop    %edi
  106a81:	5d                   	pop    %ebp
  106a82:	c3                   	ret    
    unsigned int pde_index = PDE_ADDR(vaddr);
  106a83:	8b 7c 24 34          	mov    0x34(%esp),%edi
        set_pdir_entry_by_va(proc_index, vaddr, page_index);
  106a87:	83 ec 04             	sub    $0x4,%esp
        for (pte_index = 0; pte_index < 1024; pte_index++) {
  106a8a:	31 ed                	xor    %ebp,%ebp
        set_pdir_entry_by_va(proc_index, vaddr, page_index);
  106a8c:	50                   	push   %eax
  106a8d:	ff 74 24 3c          	push   0x3c(%esp)
    unsigned int pde_index = PDE_ADDR(vaddr);
  106a91:	c1 ef 16             	shr    $0x16,%edi
        set_pdir_entry_by_va(proc_index, vaddr, page_index);
  106a94:	56                   	push   %esi
  106a95:	e8 a6 fe ff ff       	call   106940 <set_pdir_entry_by_va>
  106a9a:	83 c4 10             	add    $0x10,%esp
  106a9d:	8d 76 00             	lea    0x0(%esi),%esi
            rmv_ptbl_entry(proc_index, pde_index, pte_index);
  106aa0:	83 ec 04             	sub    $0x4,%esp
  106aa3:	55                   	push   %ebp
        for (pte_index = 0; pte_index < 1024; pte_index++) {
  106aa4:	83 c5 01             	add    $0x1,%ebp
            rmv_ptbl_entry(proc_index, pde_index, pte_index);
  106aa7:	57                   	push   %edi
  106aa8:	56                   	push   %esi
  106aa9:	e8 02 fd ff ff       	call   1067b0 <rmv_ptbl_entry>
        for (pte_index = 0; pte_index < 1024; pte_index++) {
  106aae:	83 c4 10             	add    $0x10,%esp
  106ab1:	81 fd 00 04 00 00    	cmp    $0x400,%ebp
  106ab7:	75 e7                	jne    106aa0 <alloc_ptbl+0x50>
}
  106ab9:	8b 44 24 0c          	mov    0xc(%esp),%eax
  106abd:	83 c4 1c             	add    $0x1c,%esp
  106ac0:	5b                   	pop    %ebx
  106ac1:	5e                   	pop    %esi
  106ac2:	5f                   	pop    %edi
  106ac3:	5d                   	pop    %ebp
  106ac4:	c3                   	ret    
  106ac5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00106ad0 <free_ptbl>:

// Reverse operation of alloc_ptbl.
// Removes corresponding the page directory entry,
// and frees the page for the page table entries (with container_free).
void free_ptbl(unsigned int proc_index, unsigned int vaddr)
{
  106ad0:	55                   	push   %ebp
  106ad1:	57                   	push   %edi
  106ad2:	56                   	push   %esi
  106ad3:	53                   	push   %ebx
  106ad4:	e8 b0 98 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106ad9:	81 c3 27 95 00 00    	add    $0x9527,%ebx
  106adf:	83 ec 14             	sub    $0x14,%esp
  106ae2:	8b 6c 24 28          	mov    0x28(%esp),%ebp
  106ae6:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
    unsigned int page_index = get_pdir_entry_by_va(proc_index, vaddr) >> 12;
  106aea:	57                   	push   %edi

    rmv_pdir_entry(proc_index, PDE_ADDR(vaddr));
  106aeb:	c1 ef 16             	shr    $0x16,%edi
    unsigned int page_index = get_pdir_entry_by_va(proc_index, vaddr) >> 12;
  106aee:	55                   	push   %ebp
  106aef:	e8 4c fd ff ff       	call   106840 <get_pdir_entry_by_va>
  106af4:	89 c6                	mov    %eax,%esi
    rmv_pdir_entry(proc_index, PDE_ADDR(vaddr));
  106af6:	58                   	pop    %eax
  106af7:	5a                   	pop    %edx
  106af8:	57                   	push   %edi
  106af9:	55                   	push   %ebp
    unsigned int page_index = get_pdir_entry_by_va(proc_index, vaddr) >> 12;
  106afa:	c1 ee 0c             	shr    $0xc,%esi
    rmv_pdir_entry(proc_index, PDE_ADDR(vaddr));
  106afd:	e8 de fb ff ff       	call   1066e0 <rmv_pdir_entry>
    container_free(proc_index, page_index);
  106b02:	59                   	pop    %ecx
  106b03:	5f                   	pop    %edi
  106b04:	56                   	push   %esi
  106b05:	55                   	push   %ebp
  106b06:	e8 a5 fa ff ff       	call   1065b0 <container_free>
}
  106b0b:	83 c4 1c             	add    $0x1c,%esp
  106b0e:	5b                   	pop    %ebx
  106b0f:	5e                   	pop    %esi
  106b10:	5f                   	pop    %edi
  106b11:	5d                   	pop    %ebp
  106b12:	c3                   	ret    
  106b13:	66 90                	xchg   %ax,%ax
  106b15:	66 90                	xchg   %ax,%ax
  106b17:	66 90                	xchg   %ax,%ax
  106b19:	66 90                	xchg   %ax,%ax
  106b1b:	66 90                	xchg   %ax,%ax
  106b1d:	66 90                	xchg   %ax,%ax
  106b1f:	90                   	nop

00106b20 <pdir_init_kern>:
/**
 * Sets the entire page map for process 0 as the identity map.
 * Note that part of the task is already completed by pdir_init.
 */
void pdir_init_kern(unsigned int mbi_addr)
{
  106b20:	56                   	push   %esi
    unsigned int pde_index;

    pdir_init(mbi_addr);

    // Set identity map for user PDEs
    for (pde_index = VM_USERLO_PDE; pde_index < VM_USERHI_PDE; pde_index++) {
  106b21:	be 00 01 00 00       	mov    $0x100,%esi
{
  106b26:	53                   	push   %ebx
  106b27:	e8 5d 98 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106b2c:	81 c3 d4 94 00 00    	add    $0x94d4,%ebx
  106b32:	83 ec 10             	sub    $0x10,%esp
    pdir_init(mbi_addr);
  106b35:	ff 74 24 1c          	push   0x1c(%esp)
  106b39:	e8 a2 fe ff ff       	call   1069e0 <pdir_init>
  106b3e:	83 c4 10             	add    $0x10,%esp
  106b41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        set_pdir_entry_identity(0, pde_index);
  106b48:	83 ec 08             	sub    $0x8,%esp
  106b4b:	56                   	push   %esi
    for (pde_index = VM_USERLO_PDE; pde_index < VM_USERHI_PDE; pde_index++) {
  106b4c:	83 c6 01             	add    $0x1,%esi
        set_pdir_entry_identity(0, pde_index);
  106b4f:	6a 00                	push   $0x0
  106b51:	e8 5a fb ff ff       	call   1066b0 <set_pdir_entry_identity>
    for (pde_index = VM_USERLO_PDE; pde_index < VM_USERHI_PDE; pde_index++) {
  106b56:	83 c4 10             	add    $0x10,%esp
  106b59:	81 fe c0 03 00 00    	cmp    $0x3c0,%esi
  106b5f:	75 e7                	jne    106b48 <pdir_init_kern+0x28>
    }
}
  106b61:	83 c4 04             	add    $0x4,%esp
  106b64:	5b                   	pop    %ebx
  106b65:	5e                   	pop    %esi
  106b66:	c3                   	ret    
  106b67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106b6e:	66 90                	xchg   %ax,%ax

00106b70 <map_page>:
 * otherwise, it returns the physical page index registered in the page directory,
 * (the return value of get_pdir_entry_by_va or alloc_ptbl).
 */
unsigned int map_page(unsigned int proc_index, unsigned int vaddr,
                      unsigned int page_index, unsigned int perm)
{
  106b70:	55                   	push   %ebp
  106b71:	57                   	push   %edi
  106b72:	56                   	push   %esi
  106b73:	53                   	push   %ebx
  106b74:	e8 10 98 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106b79:	81 c3 87 94 00 00    	add    $0x9487,%ebx
  106b7f:	83 ec 14             	sub    $0x14,%esp
  106b82:	8b 7c 24 28          	mov    0x28(%esp),%edi
  106b86:	8b 6c 24 2c          	mov    0x2c(%esp),%ebp
    unsigned int pde_entry = get_pdir_entry_by_va(proc_index, vaddr);
  106b8a:	55                   	push   %ebp
  106b8b:	57                   	push   %edi
  106b8c:	e8 af fc ff ff       	call   106840 <get_pdir_entry_by_va>
    unsigned int pde_page_index = pde_entry >> 12;

    if (pde_entry == 0) {
  106b91:	83 c4 10             	add    $0x10,%esp
  106b94:	85 c0                	test   %eax,%eax
  106b96:	74 28                	je     106bc0 <map_page+0x50>
    unsigned int pde_page_index = pde_entry >> 12;
  106b98:	c1 e8 0c             	shr    $0xc,%eax
  106b9b:	89 c6                	mov    %eax,%esi
        if (pde_page_index == 0) {
            return MagicNumber;
        }
    }

    set_ptbl_entry_by_va(proc_index, vaddr, page_index, perm);
  106b9d:	ff 74 24 2c          	push   0x2c(%esp)
  106ba1:	ff 74 24 2c          	push   0x2c(%esp)
  106ba5:	55                   	push   %ebp
  106ba6:	57                   	push   %edi
  106ba7:	e8 54 fd ff ff       	call   106900 <set_ptbl_entry_by_va>
    return pde_page_index;
  106bac:	83 c4 10             	add    $0x10,%esp
}
  106baf:	89 f0                	mov    %esi,%eax
  106bb1:	83 c4 0c             	add    $0xc,%esp
  106bb4:	5b                   	pop    %ebx
  106bb5:	5e                   	pop    %esi
  106bb6:	5f                   	pop    %edi
  106bb7:	5d                   	pop    %ebp
  106bb8:	c3                   	ret    
  106bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        pde_page_index = alloc_ptbl(proc_index, vaddr);
  106bc0:	83 ec 08             	sub    $0x8,%esp
  106bc3:	55                   	push   %ebp
  106bc4:	57                   	push   %edi
  106bc5:	e8 86 fe ff ff       	call   106a50 <alloc_ptbl>
        if (pde_page_index == 0) {
  106bca:	83 c4 10             	add    $0x10,%esp
        pde_page_index = alloc_ptbl(proc_index, vaddr);
  106bcd:	89 c6                	mov    %eax,%esi
        if (pde_page_index == 0) {
  106bcf:	85 c0                	test   %eax,%eax
  106bd1:	75 ca                	jne    106b9d <map_page+0x2d>
}
  106bd3:	83 c4 0c             	add    $0xc,%esp
            return MagicNumber;
  106bd6:	be 01 00 10 00       	mov    $0x100001,%esi
}
  106bdb:	5b                   	pop    %ebx
  106bdc:	89 f0                	mov    %esi,%eax
  106bde:	5e                   	pop    %esi
  106bdf:	5f                   	pop    %edi
  106be0:	5d                   	pop    %ebp
  106be1:	c3                   	ret    
  106be2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00106bf0 <unmap_page>:
 * Nothing should be done if the mapping no longer exists.
 * You do not need to unmap the page table from the page directory.
 * It should return the corresponding page table entry.
 */
unsigned int unmap_page(unsigned int proc_index, unsigned int vaddr)
{
  106bf0:	57                   	push   %edi
  106bf1:	56                   	push   %esi
  106bf2:	53                   	push   %ebx
  106bf3:	e8 91 97 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106bf8:	81 c3 08 94 00 00    	add    $0x9408,%ebx
  106bfe:	83 ec 18             	sub    $0x18,%esp
  106c01:	8b 74 24 28          	mov    0x28(%esp),%esi
  106c05:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
    unsigned int pte_entry = get_ptbl_entry_by_va(proc_index, vaddr);
  106c09:	57                   	push   %edi
  106c0a:	56                   	push   %esi
  106c0b:	e8 d0 fb ff ff       	call   1067e0 <get_ptbl_entry_by_va>
    if (pte_entry != 0) {
  106c10:	83 c4 10             	add    $0x10,%esp
  106c13:	85 c0                	test   %eax,%eax
  106c15:	75 09                	jne    106c20 <unmap_page+0x30>
        rmv_ptbl_entry_by_va(proc_index, vaddr);
    }
    return pte_entry;
}
  106c17:	83 c4 10             	add    $0x10,%esp
  106c1a:	5b                   	pop    %ebx
  106c1b:	5e                   	pop    %esi
  106c1c:	5f                   	pop    %edi
  106c1d:	c3                   	ret    
  106c1e:	66 90                	xchg   %ax,%ax
  106c20:	89 44 24 0c          	mov    %eax,0xc(%esp)
        rmv_ptbl_entry_by_va(proc_index, vaddr);
  106c24:	83 ec 08             	sub    $0x8,%esp
  106c27:	57                   	push   %edi
  106c28:	56                   	push   %esi
  106c29:	e8 42 fc ff ff       	call   106870 <rmv_ptbl_entry_by_va>
  106c2e:	83 c4 10             	add    $0x10,%esp
  106c31:	8b 44 24 0c          	mov    0xc(%esp),%eax
}
  106c35:	83 c4 10             	add    $0x10,%esp
  106c38:	5b                   	pop    %ebx
  106c39:	5e                   	pop    %esi
  106c3a:	5f                   	pop    %edi
  106c3b:	c3                   	ret    
  106c3c:	66 90                	xchg   %ax,%ax
  106c3e:	66 90                	xchg   %ax,%ax

00106c40 <paging_init>:
/**
 * Initializes the page structures, moves to the kernel page structure (0),
 * and turns on the paging.
 */
void paging_init(unsigned int mbi_addr)
{
  106c40:	53                   	push   %ebx
  106c41:	e8 43 97 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106c46:	81 c3 ba 93 00 00    	add    $0x93ba,%ebx
  106c4c:	83 ec 14             	sub    $0x14,%esp
    pdir_init_kern(mbi_addr);
  106c4f:	ff 74 24 1c          	push   0x1c(%esp)
  106c53:	e8 c8 fe ff ff       	call   106b20 <pdir_init_kern>
    set_pdir_base(0);
  106c58:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  106c5f:	e8 cc f9 ff ff       	call   106630 <set_pdir_base>
    enable_paging();
  106c64:	e8 47 a5 ff ff       	call   1011b0 <enable_paging>
}
  106c69:	83 c4 18             	add    $0x18,%esp
  106c6c:	5b                   	pop    %ebx
  106c6d:	c3                   	ret    
  106c6e:	66 90                	xchg   %ax,%ax

00106c70 <paging_init_ap>:

void paging_init_ap(void)
{
  106c70:	53                   	push   %ebx
  106c71:	e8 13 97 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106c76:	81 c3 8a 93 00 00    	add    $0x938a,%ebx
  106c7c:	83 ec 14             	sub    $0x14,%esp
    set_pdir_base(0);
  106c7f:	6a 00                	push   $0x0
  106c81:	e8 aa f9 ff ff       	call   106630 <set_pdir_base>
    enable_paging();
  106c86:	e8 25 a5 ff ff       	call   1011b0 <enable_paging>
}
  106c8b:	83 c4 18             	add    $0x18,%esp
  106c8e:	5b                   	pop    %ebx
  106c8f:	c3                   	ret    

00106c90 <alloc_page>:
 * return value from map_page.
 * In the case of error, it should return the constant MagicNumber.
 */
unsigned int alloc_page(unsigned int proc_index, unsigned int vaddr,
                        unsigned int perm)
{
  106c90:	56                   	push   %esi
  106c91:	53                   	push   %ebx
  106c92:	e8 f2 96 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106c97:	81 c3 69 93 00 00    	add    $0x9369,%ebx
  106c9d:	83 ec 10             	sub    $0x10,%esp
  106ca0:	8b 74 24 1c          	mov    0x1c(%esp),%esi
    unsigned int page_index = container_alloc(proc_index);
  106ca4:	56                   	push   %esi
  106ca5:	e8 96 f8 ff ff       	call   106540 <container_alloc>
    if (page_index != 0) {
  106caa:	83 c4 10             	add    $0x10,%esp
  106cad:	ba 01 00 10 00       	mov    $0x100001,%edx
  106cb2:	85 c0                	test   %eax,%eax
  106cb4:	74 14                	je     106cca <alloc_page+0x3a>
        return map_page(proc_index, vaddr, page_index, perm);
  106cb6:	ff 74 24 18          	push   0x18(%esp)
  106cba:	50                   	push   %eax
  106cbb:	ff 74 24 1c          	push   0x1c(%esp)
  106cbf:	56                   	push   %esi
  106cc0:	e8 ab fe ff ff       	call   106b70 <map_page>
  106cc5:	83 c4 10             	add    $0x10,%esp
  106cc8:	89 c2                	mov    %eax,%edx
    } else {
        return MagicNumber;
    }
}
  106cca:	83 c4 04             	add    $0x4,%esp
  106ccd:	89 d0                	mov    %edx,%eax
  106ccf:	5b                   	pop    %ebx
  106cd0:	5e                   	pop    %esi
  106cd1:	c3                   	ret    
  106cd2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00106ce0 <alloc_mem_quota>:

/**
 * Designate some memory quota for the next child process.
 */
unsigned int alloc_mem_quota(unsigned int id, unsigned int quota)
{
  106ce0:	53                   	push   %ebx
  106ce1:	e8 a3 96 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106ce6:	81 c3 1a 93 00 00    	add    $0x931a,%ebx
  106cec:	83 ec 10             	sub    $0x10,%esp
    unsigned int child;
    child = container_split(id, quota);
  106cef:	ff 74 24 1c          	push   0x1c(%esp)
  106cf3:	ff 74 24 1c          	push   0x1c(%esp)
  106cf7:	e8 a4 f7 ff ff       	call   1064a0 <container_split>
    return child;
}
  106cfc:	83 c4 18             	add    $0x18,%esp
  106cff:	5b                   	pop    %ebx
  106d00:	c3                   	ret    
  106d01:	66 90                	xchg   %ax,%ax
  106d03:	66 90                	xchg   %ax,%ax
  106d05:	66 90                	xchg   %ax,%ax
  106d07:	66 90                	xchg   %ax,%ax
  106d09:	66 90                	xchg   %ax,%ax
  106d0b:	66 90                	xchg   %ax,%ax
  106d0d:	66 90                	xchg   %ax,%ax
  106d0f:	90                   	nop

00106d10 <kctx_set_esp>:
// Memory to save the NUM_IDS kernel thread states.
struct kctx kctx_pool[NUM_IDS];

void kctx_set_esp(unsigned int pid, void *esp)
{
    kctx_pool[pid].esp = esp;
  106d10:	e8 70 96 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106d15:	81 c2 eb 92 00 00    	add    $0x92eb,%edx
{
  106d1b:	8b 44 24 04          	mov    0x4(%esp),%eax
    kctx_pool[pid].esp = esp;
  106d1f:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  106d23:	8d 04 40             	lea    (%eax,%eax,2),%eax
  106d26:	89 8c c2 00 20 cb 00 	mov    %ecx,0xcb2000(%edx,%eax,8)
}
  106d2d:	c3                   	ret    
  106d2e:	66 90                	xchg   %ax,%ax

00106d30 <kctx_set_eip>:

void kctx_set_eip(unsigned int pid, void *eip)
{
    kctx_pool[pid].eip = eip;
  106d30:	e8 50 96 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106d35:	81 c2 cb 92 00 00    	add    $0x92cb,%edx
{
  106d3b:	8b 44 24 04          	mov    0x4(%esp),%eax
    kctx_pool[pid].eip = eip;
  106d3f:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  106d43:	8d 04 40             	lea    (%eax,%eax,2),%eax
  106d46:	89 8c c2 14 20 cb 00 	mov    %ecx,0xcb2014(%edx,%eax,8)
}
  106d4d:	c3                   	ret    
  106d4e:	66 90                	xchg   %ax,%ax

00106d50 <kctx_switch>:
/**
 * Saves the states for thread # [from_pid] and restores the states
 * for thread # [to_pid].
 */
void kctx_switch(unsigned int from_pid, unsigned int to_pid)
{
  106d50:	53                   	push   %ebx
  106d51:	e8 33 96 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106d56:	81 c3 aa 92 00 00    	add    $0x92aa,%ebx
  106d5c:	83 ec 10             	sub    $0x10,%esp
  106d5f:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  106d63:	8b 54 24 18          	mov    0x18(%esp),%edx
    cswitch(&kctx_pool[from_pid], &kctx_pool[to_pid]);
  106d67:	8d 0c 40             	lea    (%eax,%eax,2),%ecx
  106d6a:	8d 14 52             	lea    (%edx,%edx,2),%edx
  106d6d:	8d 83 00 20 cb 00    	lea    0xcb2000(%ebx),%eax
  106d73:	8d 0c c8             	lea    (%eax,%ecx,8),%ecx
  106d76:	8d 04 d0             	lea    (%eax,%edx,8),%eax
  106d79:	51                   	push   %ecx
  106d7a:	50                   	push   %eax
  106d7b:	e8 05 00 00 00       	call   106d85 <cswitch>
}
  106d80:	83 c4 18             	add    $0x18,%esp
  106d83:	5b                   	pop    %ebx
  106d84:	c3                   	ret    

00106d85 <cswitch>:
/*
 * void cswitch(struct kctx *from, struct kctx *to);
 */
	.globl cswitch
cswitch:
	movl	4(%esp), %eax	/* %eax <- from */
  106d85:	8b 44 24 04          	mov    0x4(%esp),%eax
	movl	8(%esp), %edx	/* %edx <- to */
  106d89:	8b 54 24 08          	mov    0x8(%esp),%edx

	/* save the old kernel context */
	movl	0(%esp), %ecx
  106d8d:	8b 0c 24             	mov    (%esp),%ecx
	movl	%ecx, 20(%eax)
  106d90:	89 48 14             	mov    %ecx,0x14(%eax)
	movl	%ebp, 16(%eax)
  106d93:	89 68 10             	mov    %ebp,0x10(%eax)
	movl	%ebx, 12(%eax)
  106d96:	89 58 0c             	mov    %ebx,0xc(%eax)
	movl	%esi, 8(%eax)
  106d99:	89 70 08             	mov    %esi,0x8(%eax)
	movl	%edi, 4(%eax)
  106d9c:	89 78 04             	mov    %edi,0x4(%eax)
	movl	%esp, 0(%eax)
  106d9f:	89 20                	mov    %esp,(%eax)

	/* load the new kernel context */
	movl	0(%edx), %esp
  106da1:	8b 22                	mov    (%edx),%esp
	movl	4(%edx), %edi
  106da3:	8b 7a 04             	mov    0x4(%edx),%edi
	movl	8(%edx), %esi
  106da6:	8b 72 08             	mov    0x8(%edx),%esi
	movl	12(%edx), %ebx
  106da9:	8b 5a 0c             	mov    0xc(%edx),%ebx
	movl	16(%edx), %ebp
  106dac:	8b 6a 10             	mov    0x10(%edx),%ebp
	movl	20(%edx), %ecx
  106daf:	8b 4a 14             	mov    0x14(%edx),%ecx
	movl	%ecx, 0(%esp)
  106db2:	89 0c 24             	mov    %ecx,(%esp)

	xor	%eax, %eax
  106db5:	31 c0                	xor    %eax,%eax
	ret
  106db7:	c3                   	ret    
  106db8:	66 90                	xchg   %ax,%ax
  106dba:	66 90                	xchg   %ax,%ax
  106dbc:	66 90                	xchg   %ax,%ax
  106dbe:	66 90                	xchg   %ax,%ax

00106dc0 <kctx_new>:
 * Don't forget the stack is going down from high address to low.
 * We do not care about the rest of states when a new thread starts.
 * The function returns the child thread (process) id.
 */
unsigned int kctx_new(void *entry, unsigned int id, unsigned int quota)
{
  106dc0:	55                   	push   %ebp
  106dc1:	57                   	push   %edi
  106dc2:	56                   	push   %esi
    unsigned int pid = NUM_IDS;
  106dc3:	be 40 00 00 00       	mov    $0x40,%esi
{
  106dc8:	53                   	push   %ebx
  106dc9:	e8 bb 95 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106dce:	81 c3 32 92 00 00    	add    $0x9232,%ebx
  106dd4:	83 ec 14             	sub    $0x14,%esp
  106dd7:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
  106ddb:	8b 6c 24 30          	mov    0x30(%esp),%ebp

    if (container_can_consume(id, quota)) {
  106ddf:	55                   	push   %ebp
  106de0:	57                   	push   %edi
  106de1:	e8 8a f6 ff ff       	call   106470 <container_can_consume>
  106de6:	83 c4 10             	add    $0x10,%esp
  106de9:	85 c0                	test   %eax,%eax
  106deb:	75 13                	jne    106e00 <kctx_new+0x40>
            kctx_set_eip(pid, entry);
        }
    }

    return pid;
}
  106ded:	83 c4 0c             	add    $0xc,%esp
  106df0:	89 f0                	mov    %esi,%eax
  106df2:	5b                   	pop    %ebx
  106df3:	5e                   	pop    %esi
  106df4:	5f                   	pop    %edi
  106df5:	5d                   	pop    %ebp
  106df6:	c3                   	ret    
  106df7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106dfe:	66 90                	xchg   %ax,%ax
        pid = alloc_mem_quota(id, quota);
  106e00:	83 ec 08             	sub    $0x8,%esp
  106e03:	55                   	push   %ebp
  106e04:	57                   	push   %edi
  106e05:	e8 d6 fe ff ff       	call   106ce0 <alloc_mem_quota>
        if (pid != NUM_IDS) {
  106e0a:	83 c4 10             	add    $0x10,%esp
        pid = alloc_mem_quota(id, quota);
  106e0d:	89 c6                	mov    %eax,%esi
        if (pid != NUM_IDS) {
  106e0f:	83 f8 40             	cmp    $0x40,%eax
  106e12:	74 d9                	je     106ded <kctx_new+0x2d>
            kctx_set_esp(pid, proc_kstack[pid].kstack_hi);
  106e14:	8d 40 01             	lea    0x1(%eax),%eax
  106e17:	83 ec 08             	sub    $0x8,%esp
  106e1a:	c1 e0 0c             	shl    $0xc,%eax
  106e1d:	81 c0 00 90 13 00    	add    $0x139000,%eax
  106e23:	50                   	push   %eax
  106e24:	56                   	push   %esi
  106e25:	e8 e6 fe ff ff       	call   106d10 <kctx_set_esp>
            kctx_set_eip(pid, entry);
  106e2a:	58                   	pop    %eax
  106e2b:	5a                   	pop    %edx
  106e2c:	ff 74 24 28          	push   0x28(%esp)
  106e30:	56                   	push   %esi
  106e31:	e8 fa fe ff ff       	call   106d30 <kctx_set_eip>
  106e36:	83 c4 10             	add    $0x10,%esp
}
  106e39:	89 f0                	mov    %esi,%eax
  106e3b:	83 c4 0c             	add    $0xc,%esp
  106e3e:	5b                   	pop    %ebx
  106e3f:	5e                   	pop    %esi
  106e40:	5f                   	pop    %edi
  106e41:	5d                   	pop    %ebp
  106e42:	c3                   	ret    
  106e43:	66 90                	xchg   %ax,%ax
  106e45:	66 90                	xchg   %ax,%ax
  106e47:	66 90                	xchg   %ax,%ax
  106e49:	66 90                	xchg   %ax,%ax
  106e4b:	66 90                	xchg   %ax,%ax
  106e4d:	66 90                	xchg   %ax,%ax
  106e4f:	90                   	nop

00106e50 <tcb_get_state>:

struct TCB TCBPool[NUM_IDS];

unsigned int tcb_get_state(unsigned int pid)
{
    return TCBPool[pid].state;
  106e50:	e8 30 95 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106e55:	81 c2 ab 91 00 00    	add    $0x91ab,%edx
  106e5b:	8b 44 24 04          	mov    0x4(%esp),%eax
  106e5f:	c1 e0 04             	shl    $0x4,%eax
  106e62:	8b 84 02 00 26 cb 00 	mov    0xcb2600(%edx,%eax,1),%eax
}
  106e69:	c3                   	ret    
  106e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106e70 <tcb_set_state>:

void tcb_set_state(unsigned int pid, unsigned int state)
{
    TCBPool[pid].state = state;
  106e70:	e8 10 95 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106e75:	81 c2 8b 91 00 00    	add    $0x918b,%edx
  106e7b:	8b 44 24 04          	mov    0x4(%esp),%eax
  106e7f:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  106e83:	c1 e0 04             	shl    $0x4,%eax
  106e86:	89 8c 02 00 26 cb 00 	mov    %ecx,0xcb2600(%edx,%eax,1)
}
  106e8d:	c3                   	ret    
  106e8e:	66 90                	xchg   %ax,%ax

00106e90 <tcb_get_cpu>:

unsigned int tcb_get_cpu(unsigned int pid)
{
    return TCBPool[pid].cpuid;
  106e90:	e8 f0 94 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106e95:	81 c2 6b 91 00 00    	add    $0x916b,%edx
  106e9b:	8b 44 24 04          	mov    0x4(%esp),%eax
  106e9f:	c1 e0 04             	shl    $0x4,%eax
  106ea2:	8b 84 02 04 26 cb 00 	mov    0xcb2604(%edx,%eax,1),%eax
}
  106ea9:	c3                   	ret    
  106eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106eb0 <tcb_set_cpu>:

void tcb_set_cpu(unsigned int pid, unsigned int cpu)
{
    TCBPool[pid].cpuid = cpu;
  106eb0:	e8 d0 94 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106eb5:	81 c2 4b 91 00 00    	add    $0x914b,%edx
  106ebb:	8b 44 24 04          	mov    0x4(%esp),%eax
  106ebf:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  106ec3:	c1 e0 04             	shl    $0x4,%eax
  106ec6:	89 8c 02 04 26 cb 00 	mov    %ecx,0xcb2604(%edx,%eax,1)
}
  106ecd:	c3                   	ret    
  106ece:	66 90                	xchg   %ax,%ax

00106ed0 <tcb_get_prev>:

unsigned int tcb_get_prev(unsigned int pid)
{
    return TCBPool[pid].prev;
  106ed0:	e8 b0 94 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106ed5:	81 c2 2b 91 00 00    	add    $0x912b,%edx
  106edb:	8b 44 24 04          	mov    0x4(%esp),%eax
  106edf:	c1 e0 04             	shl    $0x4,%eax
  106ee2:	8b 84 02 08 26 cb 00 	mov    0xcb2608(%edx,%eax,1),%eax
}
  106ee9:	c3                   	ret    
  106eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106ef0 <tcb_set_prev>:

void tcb_set_prev(unsigned int pid, unsigned int prev_pid)
{
    TCBPool[pid].prev = prev_pid;
  106ef0:	e8 90 94 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106ef5:	81 c2 0b 91 00 00    	add    $0x910b,%edx
  106efb:	8b 44 24 04          	mov    0x4(%esp),%eax
  106eff:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  106f03:	c1 e0 04             	shl    $0x4,%eax
  106f06:	89 8c 02 08 26 cb 00 	mov    %ecx,0xcb2608(%edx,%eax,1)
}
  106f0d:	c3                   	ret    
  106f0e:	66 90                	xchg   %ax,%ax

00106f10 <tcb_get_next>:

unsigned int tcb_get_next(unsigned int pid)
{
    return TCBPool[pid].next;
  106f10:	e8 70 94 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106f15:	81 c2 eb 90 00 00    	add    $0x90eb,%edx
  106f1b:	8b 44 24 04          	mov    0x4(%esp),%eax
  106f1f:	c1 e0 04             	shl    $0x4,%eax
  106f22:	8b 84 02 0c 26 cb 00 	mov    0xcb260c(%edx,%eax,1),%eax
}
  106f29:	c3                   	ret    
  106f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106f30 <tcb_set_next>:

void tcb_set_next(unsigned int pid, unsigned int next_pid)
{
    TCBPool[pid].next = next_pid;
  106f30:	e8 50 94 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106f35:	81 c2 cb 90 00 00    	add    $0x90cb,%edx
  106f3b:	8b 44 24 04          	mov    0x4(%esp),%eax
  106f3f:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  106f43:	c1 e0 04             	shl    $0x4,%eax
  106f46:	89 8c 02 0c 26 cb 00 	mov    %ecx,0xcb260c(%edx,%eax,1)
}
  106f4d:	c3                   	ret    
  106f4e:	66 90                	xchg   %ax,%ax

00106f50 <tcb_init_at_id>:

void tcb_init_at_id(unsigned int pid)
{
    TCBPool[pid].state = TSTATE_DEAD;
  106f50:	e8 30 94 ff ff       	call   100385 <__x86.get_pc_thunk.dx>
  106f55:	81 c2 ab 90 00 00    	add    $0x90ab,%edx
  106f5b:	8b 44 24 04          	mov    0x4(%esp),%eax
  106f5f:	c1 e0 04             	shl    $0x4,%eax
  106f62:	c7 84 02 00 26 cb 00 	movl   $0x3,0xcb2600(%edx,%eax,1)
  106f69:	03 00 00 00 
    TCBPool[pid].cpuid = NUM_CPUS;
  106f6d:	8d 84 02 00 26 cb 00 	lea    0xcb2600(%edx,%eax,1),%eax
  106f74:	c7 40 04 08 00 00 00 	movl   $0x8,0x4(%eax)
    TCBPool[pid].prev = NUM_IDS;
  106f7b:	c7 40 08 40 00 00 00 	movl   $0x40,0x8(%eax)
    TCBPool[pid].next = NUM_IDS;
  106f82:	c7 40 0c 40 00 00 00 	movl   $0x40,0xc(%eax)
}
  106f89:	c3                   	ret    
  106f8a:	66 90                	xchg   %ax,%ax
  106f8c:	66 90                	xchg   %ax,%ax
  106f8e:	66 90                	xchg   %ax,%ax

00106f90 <tcb_init>:
/**
 * Initializes the TCB for all NUM_IDS threads with the state TSTATE_DEAD,
 * and with two indices being NUM_IDS (which represents NULL).
 */
void tcb_init(unsigned int mbi_addr)
{
  106f90:	56                   	push   %esi
    unsigned int pid = 0;
  106f91:	31 f6                	xor    %esi,%esi
{
  106f93:	53                   	push   %ebx
  106f94:	e8 f0 93 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  106f99:	81 c3 67 90 00 00    	add    $0x9067,%ebx
  106f9f:	83 ec 10             	sub    $0x10,%esp
    paging_init(mbi_addr);
  106fa2:	ff 74 24 1c          	push   0x1c(%esp)
  106fa6:	e8 95 fc ff ff       	call   106c40 <paging_init>
  106fab:	83 c4 10             	add    $0x10,%esp
  106fae:	66 90                	xchg   %ax,%ax

    while (pid < NUM_IDS) {
        tcb_init_at_id(pid);
  106fb0:	83 ec 0c             	sub    $0xc,%esp
  106fb3:	56                   	push   %esi
        pid++;
  106fb4:	83 c6 01             	add    $0x1,%esi
        tcb_init_at_id(pid);
  106fb7:	e8 94 ff ff ff       	call   106f50 <tcb_init_at_id>
    while (pid < NUM_IDS) {
  106fbc:	83 c4 10             	add    $0x10,%esp
  106fbf:	83 fe 40             	cmp    $0x40,%esi
  106fc2:	75 ec                	jne    106fb0 <tcb_init+0x20>
    }
}
  106fc4:	83 c4 04             	add    $0x4,%esp
  106fc7:	5b                   	pop    %ebx
  106fc8:	5e                   	pop    %esi
  106fc9:	c3                   	ret    
  106fca:	66 90                	xchg   %ax,%ax
  106fcc:	66 90                	xchg   %ax,%ax
  106fce:	66 90                	xchg   %ax,%ax

00106fd0 <tqueue_get_head>:
 */
struct TQueue TQueuePool[NUM_IDS + NUM_CPUS];

unsigned int tqueue_get_head(unsigned int chid)
{
    return TQueuePool[chid].head;
  106fd0:	e8 ac 93 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  106fd5:	05 2b 90 00 00       	add    $0x902b,%eax
  106fda:	8b 54 24 04          	mov    0x4(%esp),%edx
  106fde:	8b 84 d0 20 2a cb 00 	mov    0xcb2a20(%eax,%edx,8),%eax
}
  106fe5:	c3                   	ret    
  106fe6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106fed:	8d 76 00             	lea    0x0(%esi),%esi

00106ff0 <tqueue_set_head>:

void tqueue_set_head(unsigned int chid, unsigned int head)
{
    TQueuePool[chid].head = head;
  106ff0:	e8 8c 93 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  106ff5:	05 0b 90 00 00       	add    $0x900b,%eax
  106ffa:	8b 54 24 04          	mov    0x4(%esp),%edx
  106ffe:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  107002:	89 8c d0 20 2a cb 00 	mov    %ecx,0xcb2a20(%eax,%edx,8)
}
  107009:	c3                   	ret    
  10700a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107010 <tqueue_get_tail>:

unsigned int tqueue_get_tail(unsigned int chid)
{
    return TQueuePool[chid].tail;
  107010:	e8 6c 93 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  107015:	05 eb 8f 00 00       	add    $0x8feb,%eax
  10701a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10701e:	8b 84 d0 24 2a cb 00 	mov    0xcb2a24(%eax,%edx,8),%eax
}
  107025:	c3                   	ret    
  107026:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10702d:	8d 76 00             	lea    0x0(%esi),%esi

00107030 <tqueue_set_tail>:

void tqueue_set_tail(unsigned int chid, unsigned int tail)
{
    TQueuePool[chid].tail = tail;
  107030:	e8 4c 93 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  107035:	05 cb 8f 00 00       	add    $0x8fcb,%eax
  10703a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10703e:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  107042:	89 8c d0 24 2a cb 00 	mov    %ecx,0xcb2a24(%eax,%edx,8)
}
  107049:	c3                   	ret    
  10704a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107050 <tqueue_init_at_id>:

void tqueue_init_at_id(unsigned int chid)
{
    TQueuePool[chid].head = NUM_IDS;
  107050:	e8 2c 93 ff ff       	call   100381 <__x86.get_pc_thunk.ax>
  107055:	05 ab 8f 00 00       	add    $0x8fab,%eax
{
  10705a:	8b 54 24 04          	mov    0x4(%esp),%edx
    TQueuePool[chid].head = NUM_IDS;
  10705e:	c7 84 d0 20 2a cb 00 	movl   $0x40,0xcb2a20(%eax,%edx,8)
  107065:	40 00 00 00 
    TQueuePool[chid].tail = NUM_IDS;
  107069:	c7 84 d0 24 2a cb 00 	movl   $0x40,0xcb2a24(%eax,%edx,8)
  107070:	40 00 00 00 
}
  107074:	c3                   	ret    
  107075:	66 90                	xchg   %ax,%ax
  107077:	66 90                	xchg   %ax,%ax
  107079:	66 90                	xchg   %ax,%ax
  10707b:	66 90                	xchg   %ax,%ax
  10707d:	66 90                	xchg   %ax,%ax
  10707f:	90                   	nop

00107080 <tqueue_init>:

/**
 * Initializes all the thread queues with tqueue_init_at_id.
 */
void tqueue_init(unsigned int mbi_addr)
{
  107080:	56                   	push   %esi
    unsigned int cpu_idx, chid;
    tcb_init(mbi_addr);

    chid = 0;
  107081:	31 f6                	xor    %esi,%esi
{
  107083:	53                   	push   %ebx
  107084:	e8 00 93 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107089:	81 c3 77 8f 00 00    	add    $0x8f77,%ebx
  10708f:	83 ec 10             	sub    $0x10,%esp
    tcb_init(mbi_addr);
  107092:	ff 74 24 1c          	push   0x1c(%esp)
  107096:	e8 f5 fe ff ff       	call   106f90 <tcb_init>
  10709b:	83 c4 10             	add    $0x10,%esp
  10709e:	66 90                	xchg   %ax,%ax
    while (chid < NUM_IDS + NUM_CPUS) {
        tqueue_init_at_id(chid);
  1070a0:	83 ec 0c             	sub    $0xc,%esp
  1070a3:	56                   	push   %esi
        chid++;
  1070a4:	83 c6 01             	add    $0x1,%esi
        tqueue_init_at_id(chid);
  1070a7:	e8 a4 ff ff ff       	call   107050 <tqueue_init_at_id>
    while (chid < NUM_IDS + NUM_CPUS) {
  1070ac:	83 c4 10             	add    $0x10,%esp
  1070af:	83 fe 48             	cmp    $0x48,%esi
  1070b2:	75 ec                	jne    1070a0 <tqueue_init+0x20>
    }
}
  1070b4:	83 c4 04             	add    $0x4,%esp
  1070b7:	5b                   	pop    %ebx
  1070b8:	5e                   	pop    %esi
  1070b9:	c3                   	ret    
  1070ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001070c0 <tqueue_enqueue>:
 * Recall that the doubly linked list is index based.
 * So you only need to insert the index.
 * Hint: there are multiple cases in this function.
 */
void tqueue_enqueue(unsigned int chid, unsigned int pid)
{
  1070c0:	55                   	push   %ebp
  1070c1:	57                   	push   %edi
  1070c2:	56                   	push   %esi
  1070c3:	53                   	push   %ebx
  1070c4:	e8 c0 92 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1070c9:	81 c3 37 8f 00 00    	add    $0x8f37,%ebx
  1070cf:	83 ec 18             	sub    $0x18,%esp
  1070d2:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
  1070d6:	8b 74 24 30          	mov    0x30(%esp),%esi
    unsigned int tail = tqueue_get_tail(chid);
  1070da:	57                   	push   %edi
  1070db:	e8 30 ff ff ff       	call   107010 <tqueue_get_tail>

    if (tail == NUM_IDS) {
  1070e0:	83 c4 10             	add    $0x10,%esp
  1070e3:	83 f8 40             	cmp    $0x40,%eax
  1070e6:	74 38                	je     107120 <tqueue_enqueue+0x60>
        tcb_set_prev(pid, NUM_IDS);
        tcb_set_next(pid, NUM_IDS);
        tqueue_set_head(chid, pid);
        tqueue_set_tail(chid, pid);
    } else {
        tcb_set_next(tail, pid);
  1070e8:	83 ec 08             	sub    $0x8,%esp
  1070eb:	89 c5                	mov    %eax,%ebp
  1070ed:	56                   	push   %esi
  1070ee:	50                   	push   %eax
  1070ef:	e8 3c fe ff ff       	call   106f30 <tcb_set_next>
        tcb_set_prev(pid, tail);
  1070f4:	59                   	pop    %ecx
  1070f5:	58                   	pop    %eax
  1070f6:	55                   	push   %ebp
  1070f7:	56                   	push   %esi
  1070f8:	e8 f3 fd ff ff       	call   106ef0 <tcb_set_prev>
        tcb_set_next(pid, NUM_IDS);
  1070fd:	58                   	pop    %eax
  1070fe:	5a                   	pop    %edx
  1070ff:	6a 40                	push   $0x40
  107101:	56                   	push   %esi
  107102:	e8 29 fe ff ff       	call   106f30 <tcb_set_next>
        tqueue_set_tail(chid, pid);
  107107:	58                   	pop    %eax
  107108:	5a                   	pop    %edx
  107109:	56                   	push   %esi
  10710a:	57                   	push   %edi
  10710b:	e8 20 ff ff ff       	call   107030 <tqueue_set_tail>
  107110:	83 c4 10             	add    $0x10,%esp
    }
}
  107113:	83 c4 0c             	add    $0xc,%esp
  107116:	5b                   	pop    %ebx
  107117:	5e                   	pop    %esi
  107118:	5f                   	pop    %edi
  107119:	5d                   	pop    %ebp
  10711a:	c3                   	ret    
  10711b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10711f:	90                   	nop
        tcb_set_prev(pid, NUM_IDS);
  107120:	83 ec 08             	sub    $0x8,%esp
  107123:	6a 40                	push   $0x40
  107125:	56                   	push   %esi
  107126:	e8 c5 fd ff ff       	call   106ef0 <tcb_set_prev>
        tcb_set_next(pid, NUM_IDS);
  10712b:	59                   	pop    %ecx
  10712c:	5d                   	pop    %ebp
  10712d:	6a 40                	push   $0x40
  10712f:	56                   	push   %esi
  107130:	e8 fb fd ff ff       	call   106f30 <tcb_set_next>
        tqueue_set_head(chid, pid);
  107135:	58                   	pop    %eax
  107136:	5a                   	pop    %edx
  107137:	56                   	push   %esi
  107138:	57                   	push   %edi
  107139:	e8 b2 fe ff ff       	call   106ff0 <tqueue_set_head>
        tqueue_set_tail(chid, pid);
  10713e:	eb c7                	jmp    107107 <tqueue_enqueue+0x47>

00107140 <tqueue_dequeue>:
 * Reverse action of tqueue_enqueue, i.e. pops a TCB from the head of the specified queue.
 * It returns the popped thread's id, or NUM_IDS if the queue is empty.
 * Hint: there are multiple cases in this function.
 */
unsigned int tqueue_dequeue(unsigned int chid)
{
  107140:	55                   	push   %ebp
  107141:	57                   	push   %edi
  107142:	56                   	push   %esi
  107143:	53                   	push   %ebx
  107144:	e8 40 92 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107149:	81 c3 b7 8e 00 00    	add    $0x8eb7,%ebx
  10714f:	83 ec 18             	sub    $0x18,%esp
  107152:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
    unsigned int head, next, pid;

    pid = NUM_IDS;
    head = tqueue_get_head(chid);
  107156:	57                   	push   %edi
  107157:	e8 74 fe ff ff       	call   106fd0 <tqueue_get_head>

    if (head != NUM_IDS) {
  10715c:	83 c4 10             	add    $0x10,%esp
    head = tqueue_get_head(chid);
  10715f:	89 c6                	mov    %eax,%esi
    if (head != NUM_IDS) {
  107161:	83 f8 40             	cmp    $0x40,%eax
  107164:	74 42                	je     1071a8 <tqueue_dequeue+0x68>
        pid = head;
        next = tcb_get_next(head);
  107166:	83 ec 0c             	sub    $0xc,%esp
  107169:	50                   	push   %eax
  10716a:	e8 a1 fd ff ff       	call   106f10 <tcb_get_next>

        if (next == NUM_IDS) {
  10716f:	83 c4 10             	add    $0x10,%esp
        next = tcb_get_next(head);
  107172:	89 c5                	mov    %eax,%ebp
        if (next == NUM_IDS) {
  107174:	83 f8 40             	cmp    $0x40,%eax
  107177:	74 3f                	je     1071b8 <tqueue_dequeue+0x78>
            tqueue_set_head(chid, NUM_IDS);
            tqueue_set_tail(chid, NUM_IDS);
        } else {
            tcb_set_prev(next, NUM_IDS);
  107179:	83 ec 08             	sub    $0x8,%esp
  10717c:	6a 40                	push   $0x40
  10717e:	50                   	push   %eax
  10717f:	e8 6c fd ff ff       	call   106ef0 <tcb_set_prev>
            tqueue_set_head(chid, next);
  107184:	59                   	pop    %ecx
  107185:	58                   	pop    %eax
  107186:	55                   	push   %ebp
  107187:	57                   	push   %edi
  107188:	e8 63 fe ff ff       	call   106ff0 <tqueue_set_head>
  10718d:	83 c4 10             	add    $0x10,%esp
        }
        tcb_set_prev(pid, NUM_IDS);
  107190:	83 ec 08             	sub    $0x8,%esp
  107193:	6a 40                	push   $0x40
  107195:	56                   	push   %esi
  107196:	e8 55 fd ff ff       	call   106ef0 <tcb_set_prev>
        tcb_set_next(pid, NUM_IDS);
  10719b:	58                   	pop    %eax
  10719c:	5a                   	pop    %edx
  10719d:	6a 40                	push   $0x40
  10719f:	56                   	push   %esi
  1071a0:	e8 8b fd ff ff       	call   106f30 <tcb_set_next>
  1071a5:	83 c4 10             	add    $0x10,%esp
    }

    return pid;
}
  1071a8:	83 c4 0c             	add    $0xc,%esp
  1071ab:	89 f0                	mov    %esi,%eax
  1071ad:	5b                   	pop    %ebx
  1071ae:	5e                   	pop    %esi
  1071af:	5f                   	pop    %edi
  1071b0:	5d                   	pop    %ebp
  1071b1:	c3                   	ret    
  1071b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            tqueue_set_head(chid, NUM_IDS);
  1071b8:	83 ec 08             	sub    $0x8,%esp
  1071bb:	6a 40                	push   $0x40
  1071bd:	57                   	push   %edi
  1071be:	e8 2d fe ff ff       	call   106ff0 <tqueue_set_head>
            tqueue_set_tail(chid, NUM_IDS);
  1071c3:	58                   	pop    %eax
  1071c4:	5a                   	pop    %edx
  1071c5:	6a 40                	push   $0x40
  1071c7:	57                   	push   %edi
  1071c8:	e8 63 fe ff ff       	call   107030 <tqueue_set_tail>
  1071cd:	83 c4 10             	add    $0x10,%esp
  1071d0:	eb be                	jmp    107190 <tqueue_dequeue+0x50>
  1071d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1071d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001071e0 <tqueue_remove>:
/**
 * Removes the TCB #pid from the queue #chid.
 * Hint: there are many cases in this function.
 */
void tqueue_remove(unsigned int chid, unsigned int pid)
{
  1071e0:	55                   	push   %ebp
  1071e1:	57                   	push   %edi
  1071e2:	56                   	push   %esi
  1071e3:	53                   	push   %ebx
  1071e4:	e8 a0 91 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1071e9:	81 c3 17 8e 00 00    	add    $0x8e17,%ebx
  1071ef:	83 ec 18             	sub    $0x18,%esp
  1071f2:	8b 7c 24 30          	mov    0x30(%esp),%edi
    unsigned int prev, next;

    prev = tcb_get_prev(pid);
  1071f6:	57                   	push   %edi
  1071f7:	e8 d4 fc ff ff       	call   106ed0 <tcb_get_prev>
    next = tcb_get_next(pid);
  1071fc:	89 3c 24             	mov    %edi,(%esp)
    prev = tcb_get_prev(pid);
  1071ff:	89 c5                	mov    %eax,%ebp
    next = tcb_get_next(pid);
  107201:	e8 0a fd ff ff       	call   106f10 <tcb_get_next>

    if (prev == NUM_IDS) {
  107206:	83 c4 10             	add    $0x10,%esp
    next = tcb_get_next(pid);
  107209:	89 c6                	mov    %eax,%esi
    if (prev == NUM_IDS) {
  10720b:	83 fd 40             	cmp    $0x40,%ebp
  10720e:	74 50                	je     107260 <tqueue_remove+0x80>
        } else {
            tcb_set_prev(next, NUM_IDS);
            tqueue_set_head(chid, next);
        }
    } else {
        if (next == NUM_IDS) {
  107210:	83 f8 40             	cmp    $0x40,%eax
  107213:	74 73                	je     107288 <tqueue_remove+0xa8>
            tcb_set_next(prev, NUM_IDS);
            tqueue_set_tail(chid, prev);
        } else {
            if (prev != next)
  107215:	39 c5                	cmp    %eax,%ebp
  107217:	75 2f                	jne    107248 <tqueue_remove+0x68>
                tcb_set_next(prev, next);
            tcb_set_prev(next, prev);
  107219:	83 ec 08             	sub    $0x8,%esp
  10721c:	55                   	push   %ebp
  10721d:	56                   	push   %esi
  10721e:	e8 cd fc ff ff       	call   106ef0 <tcb_set_prev>
  107223:	83 c4 10             	add    $0x10,%esp
        }
    }
    tcb_set_prev(pid, NUM_IDS);
  107226:	83 ec 08             	sub    $0x8,%esp
  107229:	6a 40                	push   $0x40
  10722b:	57                   	push   %edi
  10722c:	e8 bf fc ff ff       	call   106ef0 <tcb_set_prev>
    tcb_set_next(pid, NUM_IDS);
  107231:	58                   	pop    %eax
  107232:	5a                   	pop    %edx
  107233:	6a 40                	push   $0x40
  107235:	57                   	push   %edi
  107236:	e8 f5 fc ff ff       	call   106f30 <tcb_set_next>
}
  10723b:	83 c4 1c             	add    $0x1c,%esp
  10723e:	5b                   	pop    %ebx
  10723f:	5e                   	pop    %esi
  107240:	5f                   	pop    %edi
  107241:	5d                   	pop    %ebp
  107242:	c3                   	ret    
  107243:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  107247:	90                   	nop
                tcb_set_next(prev, next);
  107248:	83 ec 08             	sub    $0x8,%esp
  10724b:	50                   	push   %eax
  10724c:	55                   	push   %ebp
  10724d:	e8 de fc ff ff       	call   106f30 <tcb_set_next>
  107252:	83 c4 10             	add    $0x10,%esp
  107255:	eb c2                	jmp    107219 <tqueue_remove+0x39>
  107257:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10725e:	66 90                	xchg   %ax,%ax
        if (next == NUM_IDS) {
  107260:	83 f8 40             	cmp    $0x40,%eax
  107263:	74 43                	je     1072a8 <tqueue_remove+0xc8>
            tcb_set_prev(next, NUM_IDS);
  107265:	83 ec 08             	sub    $0x8,%esp
  107268:	6a 40                	push   $0x40
  10726a:	50                   	push   %eax
  10726b:	e8 80 fc ff ff       	call   106ef0 <tcb_set_prev>
            tqueue_set_head(chid, next);
  107270:	5d                   	pop    %ebp
  107271:	58                   	pop    %eax
  107272:	56                   	push   %esi
  107273:	ff 74 24 2c          	push   0x2c(%esp)
  107277:	e8 74 fd ff ff       	call   106ff0 <tqueue_set_head>
  10727c:	83 c4 10             	add    $0x10,%esp
  10727f:	eb a5                	jmp    107226 <tqueue_remove+0x46>
  107281:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            tcb_set_next(prev, NUM_IDS);
  107288:	83 ec 08             	sub    $0x8,%esp
  10728b:	6a 40                	push   $0x40
  10728d:	55                   	push   %ebp
  10728e:	e8 9d fc ff ff       	call   106f30 <tcb_set_next>
            tqueue_set_tail(chid, prev);
  107293:	59                   	pop    %ecx
  107294:	5e                   	pop    %esi
  107295:	55                   	push   %ebp
  107296:	ff 74 24 2c          	push   0x2c(%esp)
  10729a:	e8 91 fd ff ff       	call   107030 <tqueue_set_tail>
  10729f:	83 c4 10             	add    $0x10,%esp
  1072a2:	eb 82                	jmp    107226 <tqueue_remove+0x46>
  1072a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            tqueue_set_head(chid, NUM_IDS);
  1072a8:	83 ec 08             	sub    $0x8,%esp
  1072ab:	6a 40                	push   $0x40
  1072ad:	ff 74 24 2c          	push   0x2c(%esp)
  1072b1:	e8 3a fd ff ff       	call   106ff0 <tqueue_set_head>
            tqueue_set_tail(chid, NUM_IDS);
  1072b6:	58                   	pop    %eax
  1072b7:	5a                   	pop    %edx
  1072b8:	6a 40                	push   $0x40
  1072ba:	ff 74 24 2c          	push   0x2c(%esp)
  1072be:	e8 6d fd ff ff       	call   107030 <tqueue_set_tail>
  1072c3:	83 c4 10             	add    $0x10,%esp
  1072c6:	e9 5b ff ff ff       	jmp    107226 <tqueue_remove+0x46>
  1072cb:	66 90                	xchg   %ax,%ax
  1072cd:	66 90                	xchg   %ax,%ax
  1072cf:	90                   	nop

001072d0 <get_curid>:
#include <pcpu/PCPUIntro/export.h>

unsigned int CURID[NUM_CPUS];

unsigned int get_curid(void)
{
  1072d0:	53                   	push   %ebx
  1072d1:	e8 b3 90 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1072d6:	81 c3 2a 8d 00 00    	add    $0x8d2a,%ebx
  1072dc:	83 ec 08             	sub    $0x8,%esp
    return CURID[get_pcpu_idx()];
  1072df:	e8 5c e7 ff ff       	call   105a40 <get_pcpu_idx>
  1072e4:	8b 84 83 60 2c cb 00 	mov    0xcb2c60(%ebx,%eax,4),%eax
}
  1072eb:	83 c4 08             	add    $0x8,%esp
  1072ee:	5b                   	pop    %ebx
  1072ef:	c3                   	ret    

001072f0 <set_curid>:

void set_curid(unsigned int curid)
{
  1072f0:	53                   	push   %ebx
  1072f1:	e8 93 90 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1072f6:	81 c3 0a 8d 00 00    	add    $0x8d0a,%ebx
  1072fc:	83 ec 08             	sub    $0x8,%esp
    CURID[get_pcpu_idx()] = curid;
  1072ff:	e8 3c e7 ff ff       	call   105a40 <get_pcpu_idx>
  107304:	8b 54 24 10          	mov    0x10(%esp),%edx
  107308:	89 94 83 60 2c cb 00 	mov    %edx,0xcb2c60(%ebx,%eax,4)
}
  10730f:	83 c4 08             	add    $0x8,%esp
  107312:	5b                   	pop    %ebx
  107313:	c3                   	ret    
  107314:	66 90                	xchg   %ax,%ax
  107316:	66 90                	xchg   %ax,%ax
  107318:	66 90                	xchg   %ax,%ax
  10731a:	66 90                	xchg   %ax,%ax
  10731c:	66 90                	xchg   %ax,%ax
  10731e:	66 90                	xchg   %ax,%ax

00107320 <thread_init>:
#include <pcpu/PCPUIntro/export.h>

#include "import.h"

void thread_init(unsigned int mbi_addr)
{
  107320:	53                   	push   %ebx
  107321:	e8 63 90 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107326:	81 c3 da 8c 00 00    	add    $0x8cda,%ebx
  10732c:	83 ec 14             	sub    $0x14,%esp
    tqueue_init(mbi_addr);
  10732f:	ff 74 24 1c          	push   0x1c(%esp)
  107333:	e8 48 fd ff ff       	call   107080 <tqueue_init>
    set_curid(0);
  107338:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10733f:	e8 ac ff ff ff       	call   1072f0 <set_curid>
    tcb_set_state(0, TSTATE_RUN);
  107344:	58                   	pop    %eax
  107345:	5a                   	pop    %edx
  107346:	6a 01                	push   $0x1
  107348:	6a 00                	push   $0x0
  10734a:	e8 21 fb ff ff       	call   106e70 <tcb_set_state>
}
  10734f:	83 c4 18             	add    $0x18,%esp
  107352:	5b                   	pop    %ebx
  107353:	c3                   	ret    
  107354:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10735b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10735f:	90                   	nop

00107360 <thread_spawn>:
 * Allocates a new child thread context, sets the state of the new child thread
 * to ready, and pushes it to the ready queue.
 * It returns the child thread id.
 */
unsigned int thread_spawn(void *entry, unsigned int id, unsigned int quota)
{
  107360:	56                   	push   %esi
  107361:	53                   	push   %ebx
  107362:	e8 22 90 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107367:	81 c3 99 8c 00 00    	add    $0x8c99,%ebx
  10736d:	83 ec 08             	sub    $0x8,%esp
    unsigned int pid = kctx_new(entry, id, quota);
  107370:	ff 74 24 1c          	push   0x1c(%esp)
  107374:	ff 74 24 1c          	push   0x1c(%esp)
  107378:	ff 74 24 1c          	push   0x1c(%esp)
  10737c:	e8 3f fa ff ff       	call   106dc0 <kctx_new>
    if (pid != NUM_IDS) {
  107381:	83 c4 10             	add    $0x10,%esp
    unsigned int pid = kctx_new(entry, id, quota);
  107384:	89 c6                	mov    %eax,%esi
    if (pid != NUM_IDS) {
  107386:	83 f8 40             	cmp    $0x40,%eax
  107389:	74 2d                	je     1073b8 <thread_spawn+0x58>
        tcb_set_cpu(pid, get_pcpu_idx());
  10738b:	e8 b0 e6 ff ff       	call   105a40 <get_pcpu_idx>
  107390:	83 ec 08             	sub    $0x8,%esp
  107393:	50                   	push   %eax
  107394:	56                   	push   %esi
  107395:	e8 16 fb ff ff       	call   106eb0 <tcb_set_cpu>
        tcb_set_state(pid, TSTATE_READY);
  10739a:	58                   	pop    %eax
  10739b:	5a                   	pop    %edx
  10739c:	6a 00                	push   $0x0
  10739e:	56                   	push   %esi
  10739f:	e8 cc fa ff ff       	call   106e70 <tcb_set_state>
        tqueue_enqueue(NUM_IDS + get_pcpu_idx(), pid);
  1073a4:	e8 97 e6 ff ff       	call   105a40 <get_pcpu_idx>
  1073a9:	59                   	pop    %ecx
  1073aa:	5a                   	pop    %edx
  1073ab:	56                   	push   %esi
  1073ac:	83 c0 40             	add    $0x40,%eax
  1073af:	50                   	push   %eax
  1073b0:	e8 0b fd ff ff       	call   1070c0 <tqueue_enqueue>
  1073b5:	83 c4 10             	add    $0x10,%esp
    }

    return pid;
}
  1073b8:	83 c4 04             	add    $0x4,%esp
  1073bb:	89 f0                	mov    %esi,%eax
  1073bd:	5b                   	pop    %ebx
  1073be:	5e                   	pop    %esi
  1073bf:	c3                   	ret    

001073c0 <thread_yield>:
 * current thread id, and switch to the new kernel context.
 * Hint: If you are the only thread that is ready to run,
 * do you need to switch to yourself?
 */
void thread_yield(void)
{
  1073c0:	57                   	push   %edi
  1073c1:	56                   	push   %esi
  1073c2:	53                   	push   %ebx
  1073c3:	e8 c1 8f ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1073c8:	81 c3 38 8c 00 00    	add    $0x8c38,%ebx
    unsigned int new_cur_pid;
    unsigned int old_cur_pid = get_curid();
  1073ce:	e8 fd fe ff ff       	call   1072d0 <get_curid>

    tcb_set_state(old_cur_pid, TSTATE_READY);
  1073d3:	83 ec 08             	sub    $0x8,%esp
  1073d6:	6a 00                	push   $0x0
    unsigned int old_cur_pid = get_curid();
  1073d8:	89 c6                	mov    %eax,%esi
    tcb_set_state(old_cur_pid, TSTATE_READY);
  1073da:	50                   	push   %eax
  1073db:	e8 90 fa ff ff       	call   106e70 <tcb_set_state>
    tqueue_enqueue(NUM_IDS + get_pcpu_idx(), old_cur_pid);
  1073e0:	e8 5b e6 ff ff       	call   105a40 <get_pcpu_idx>
  1073e5:	5a                   	pop    %edx
  1073e6:	59                   	pop    %ecx
  1073e7:	56                   	push   %esi
  1073e8:	83 c0 40             	add    $0x40,%eax
  1073eb:	50                   	push   %eax
  1073ec:	e8 cf fc ff ff       	call   1070c0 <tqueue_enqueue>

    new_cur_pid = tqueue_dequeue(NUM_IDS + get_pcpu_idx());
  1073f1:	e8 4a e6 ff ff       	call   105a40 <get_pcpu_idx>
  1073f6:	83 c0 40             	add    $0x40,%eax
  1073f9:	89 04 24             	mov    %eax,(%esp)
  1073fc:	e8 3f fd ff ff       	call   107140 <tqueue_dequeue>
    tcb_set_state(new_cur_pid, TSTATE_RUN);
  107401:	5a                   	pop    %edx
  107402:	59                   	pop    %ecx
  107403:	6a 01                	push   $0x1
  107405:	50                   	push   %eax
    new_cur_pid = tqueue_dequeue(NUM_IDS + get_pcpu_idx());
  107406:	89 c7                	mov    %eax,%edi
    tcb_set_state(new_cur_pid, TSTATE_RUN);
  107408:	e8 63 fa ff ff       	call   106e70 <tcb_set_state>
    set_curid(new_cur_pid);
  10740d:	89 3c 24             	mov    %edi,(%esp)
  107410:	e8 db fe ff ff       	call   1072f0 <set_curid>

    if (old_cur_pid != new_cur_pid) {
  107415:	83 c4 10             	add    $0x10,%esp
  107418:	39 fe                	cmp    %edi,%esi
  10741a:	74 0d                	je     107429 <thread_yield+0x69>
        kctx_switch(old_cur_pid, new_cur_pid);
  10741c:	83 ec 08             	sub    $0x8,%esp
  10741f:	57                   	push   %edi
  107420:	56                   	push   %esi
  107421:	e8 2a f9 ff ff       	call   106d50 <kctx_switch>
  107426:	83 c4 10             	add    $0x10,%esp
    }
}
  107429:	5b                   	pop    %ebx
  10742a:	5e                   	pop    %esi
  10742b:	5f                   	pop    %edi
  10742c:	c3                   	ret    
  10742d:	66 90                	xchg   %ax,%ax
  10742f:	90                   	nop

00107430 <proc_start_user>:
extern tf_t uctx_pool[NUM_IDS];

extern unsigned int last_active[NUM_CPUS];

void proc_start_user(void)
{
  107430:	57                   	push   %edi
  107431:	56                   	push   %esi
  107432:	53                   	push   %ebx
  107433:	e8 51 8f ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107438:	81 c3 c8 8b 00 00    	add    $0x8bc8,%ebx
    unsigned int cur_pid = get_curid();
  10743e:	e8 8d fe ff ff       	call   1072d0 <get_curid>
  107443:	89 c6                	mov    %eax,%esi
    unsigned int cpu_idx = get_pcpu_idx();
  107445:	e8 f6 e5 ff ff       	call   105a40 <get_pcpu_idx>

    kstack_switch(cur_pid);
  10744a:	83 ec 0c             	sub    $0xc,%esp
  10744d:	56                   	push   %esi
    unsigned int cpu_idx = get_pcpu_idx();
  10744e:	89 c7                	mov    %eax,%edi
    kstack_switch(cur_pid);
  107450:	e8 fb d3 ff ff       	call   104850 <kstack_switch>
    set_pdir_base(cur_pid);
  107455:	89 34 24             	mov    %esi,(%esp)
  107458:	e8 d3 f1 ff ff       	call   106630 <set_pdir_base>
    last_active[cpu_idx] = cur_pid;
  10745d:	c7 c0 80 3d e0 00    	mov    $0xe03d80,%eax
  107463:	89 34 b8             	mov    %esi,(%eax,%edi,4)

    trap_return((void *) &uctx_pool[cur_pid]);
  107466:	6b f6 44             	imul   $0x44,%esi,%esi
  107469:	81 c6 80 2c dc 00    	add    $0xdc2c80,%esi
  10746f:	89 34 24             	mov    %esi,(%esp)
  107472:	e8 c9 ad ff ff       	call   102240 <trap_return>
}
  107477:	83 c4 10             	add    $0x10,%esp
  10747a:	5b                   	pop    %ebx
  10747b:	5e                   	pop    %esi
  10747c:	5f                   	pop    %edi
  10747d:	c3                   	ret    
  10747e:	66 90                	xchg   %ax,%ax

00107480 <proc_create>:

unsigned int proc_create(void *elf_addr, unsigned int quota)
{
  107480:	57                   	push   %edi
  107481:	56                   	push   %esi
  107482:	53                   	push   %ebx
  107483:	e8 01 8f ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107488:	81 c3 78 8b 00 00    	add    $0x8b78,%ebx
    unsigned int pid, id;

    id = get_curid();
  10748e:	e8 3d fe ff ff       	call   1072d0 <get_curid>
    pid = thread_spawn((void *) proc_start_user, id, quota);
  107493:	83 ec 04             	sub    $0x4,%esp
  107496:	ff 74 24 18          	push   0x18(%esp)
  10749a:	50                   	push   %eax
  10749b:	8d 83 30 74 ff ff    	lea    -0x8bd0(%ebx),%eax
  1074a1:	50                   	push   %eax
  1074a2:	e8 b9 fe ff ff       	call   107360 <thread_spawn>

    if (pid != NUM_IDS) {
  1074a7:	83 c4 10             	add    $0x10,%esp
    pid = thread_spawn((void *) proc_start_user, id, quota);
  1074aa:	89 c6                	mov    %eax,%esi
    if (pid != NUM_IDS) {
  1074ac:	83 f8 40             	cmp    $0x40,%eax
  1074af:	74 66                	je     107517 <proc_create+0x97>
        elf_load(elf_addr, pid);
  1074b1:	83 ec 08             	sub    $0x8,%esp

        uctx_pool[pid].es = CPU_GDT_UDATA | 3;
  1074b4:	6b fe 44             	imul   $0x44,%esi,%edi
        elf_load(elf_addr, pid);
  1074b7:	50                   	push   %eax
  1074b8:	ff 74 24 1c          	push   0x1c(%esp)
  1074bc:	e8 2f df ff ff       	call   1053f0 <elf_load>
        uctx_pool[pid].es = CPU_GDT_UDATA | 3;
  1074c1:	81 c7 80 2c dc 00    	add    $0xdc2c80,%edi
  1074c7:	b8 23 00 00 00       	mov    $0x23,%eax
        uctx_pool[pid].ds = CPU_GDT_UDATA | 3;
  1074cc:	ba 23 00 00 00       	mov    $0x23,%edx
        uctx_pool[pid].es = CPU_GDT_UDATA | 3;
  1074d1:	66 89 47 20          	mov    %ax,0x20(%edi)
        uctx_pool[pid].cs = CPU_GDT_UCODE | 3;
  1074d5:	b9 1b 00 00 00       	mov    $0x1b,%ecx
        uctx_pool[pid].ss = CPU_GDT_UDATA | 3;
  1074da:	b8 23 00 00 00       	mov    $0x23,%eax
        uctx_pool[pid].ds = CPU_GDT_UDATA | 3;
  1074df:	66 89 57 24          	mov    %dx,0x24(%edi)
        uctx_pool[pid].cs = CPU_GDT_UCODE | 3;
  1074e3:	66 89 4f 34          	mov    %cx,0x34(%edi)
        uctx_pool[pid].ss = CPU_GDT_UDATA | 3;
  1074e7:	66 89 47 40          	mov    %ax,0x40(%edi)
        uctx_pool[pid].esp = VM_USERHI;
  1074eb:	c7 47 3c 00 00 00 f0 	movl   $0xf0000000,0x3c(%edi)
        uctx_pool[pid].eflags = FL_IF;
  1074f2:	c7 47 38 00 02 00 00 	movl   $0x200,0x38(%edi)
        uctx_pool[pid].eip = elf_entry(elf_addr);
  1074f9:	58                   	pop    %eax
  1074fa:	ff 74 24 1c          	push   0x1c(%esp)
  1074fe:	e8 fd e0 ff ff       	call   105600 <elf_entry>
  107503:	89 47 30             	mov    %eax,0x30(%edi)

        seg_init_proc(get_pcpu_idx(), pid);
  107506:	e8 35 e5 ff ff       	call   105a40 <get_pcpu_idx>
  10750b:	5a                   	pop    %edx
  10750c:	59                   	pop    %ecx
  10750d:	56                   	push   %esi
  10750e:	50                   	push   %eax
  10750f:	e8 7c d5 ff ff       	call   104a90 <seg_init_proc>
  107514:	83 c4 10             	add    $0x10,%esp
    }

    return pid;
}
  107517:	89 f0                	mov    %esi,%eax
  107519:	5b                   	pop    %ebx
  10751a:	5e                   	pop    %esi
  10751b:	5f                   	pop    %edi
  10751c:	c3                   	ret    
  10751d:	66 90                	xchg   %ax,%ax
  10751f:	90                   	nop

00107520 <syscall_get_arg1>:
 * Retrieves the system call arguments from uctx_pool that get
 * passed in from the current running process' system call.
 */
unsigned int syscall_get_arg1(tf_t *tf)
{
    return tf->regs.eax;
  107520:	8b 44 24 04          	mov    0x4(%esp),%eax
  107524:	8b 40 1c             	mov    0x1c(%eax),%eax
}
  107527:	c3                   	ret    
  107528:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10752f:	90                   	nop

00107530 <syscall_get_arg2>:

unsigned int syscall_get_arg2(tf_t *tf)
{
    return tf->regs.ebx;
  107530:	8b 44 24 04          	mov    0x4(%esp),%eax
  107534:	8b 40 10             	mov    0x10(%eax),%eax
}
  107537:	c3                   	ret    
  107538:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10753f:	90                   	nop

00107540 <syscall_get_arg3>:

unsigned int syscall_get_arg3(tf_t *tf)
{
    return tf->regs.ecx;
  107540:	8b 44 24 04          	mov    0x4(%esp),%eax
  107544:	8b 40 18             	mov    0x18(%eax),%eax
}
  107547:	c3                   	ret    
  107548:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10754f:	90                   	nop

00107550 <syscall_get_arg4>:

unsigned int syscall_get_arg4(tf_t *tf)
{
    return tf->regs.edx;
  107550:	8b 44 24 04          	mov    0x4(%esp),%eax
  107554:	8b 40 14             	mov    0x14(%eax),%eax
}
  107557:	c3                   	ret    
  107558:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10755f:	90                   	nop

00107560 <syscall_get_arg5>:

unsigned int syscall_get_arg5(tf_t *tf)
{
    return tf->regs.esi;
  107560:	8b 44 24 04          	mov    0x4(%esp),%eax
  107564:	8b 40 04             	mov    0x4(%eax),%eax
}
  107567:	c3                   	ret    
  107568:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10756f:	90                   	nop

00107570 <syscall_get_arg6>:

unsigned int syscall_get_arg6(tf_t *tf)
{
    return tf->regs.edi;
  107570:	8b 44 24 04          	mov    0x4(%esp),%eax
  107574:	8b 00                	mov    (%eax),%eax
}
  107576:	c3                   	ret    
  107577:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10757e:	66 90                	xchg   %ax,%ax

00107580 <syscall_set_errno>:
 * Sets the error number in uctx_pool that gets passed
 * to the current running process when we return to it.
 */
void syscall_set_errno(tf_t *tf, unsigned int errno)
{
    tf->regs.eax = errno;
  107580:	8b 44 24 04          	mov    0x4(%esp),%eax
  107584:	8b 54 24 08          	mov    0x8(%esp),%edx
  107588:	89 50 1c             	mov    %edx,0x1c(%eax)
}
  10758b:	c3                   	ret    
  10758c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107590 <syscall_set_retval1>:
 * Sets the return values in uctx_pool that get passed
 * to the current running process when we return to it.
 */
void syscall_set_retval1(tf_t *tf, unsigned int retval)
{
    tf->regs.ebx = retval;
  107590:	8b 44 24 04          	mov    0x4(%esp),%eax
  107594:	8b 54 24 08          	mov    0x8(%esp),%edx
  107598:	89 50 10             	mov    %edx,0x10(%eax)
}
  10759b:	c3                   	ret    
  10759c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001075a0 <syscall_set_retval2>:

void syscall_set_retval2(tf_t *tf, unsigned int retval)
{
    tf->regs.ecx = retval;
  1075a0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1075a4:	8b 54 24 08          	mov    0x8(%esp),%edx
  1075a8:	89 50 18             	mov    %edx,0x18(%eax)
}
  1075ab:	c3                   	ret    
  1075ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001075b0 <syscall_set_retval3>:

void syscall_set_retval3(tf_t *tf, unsigned int retval)
{
    tf->regs.edx = retval;
  1075b0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1075b4:	8b 54 24 08          	mov    0x8(%esp),%edx
  1075b8:	89 50 14             	mov    %edx,0x14(%eax)
}
  1075bb:	c3                   	ret    
  1075bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001075c0 <syscall_set_retval4>:

void syscall_set_retval4(tf_t *tf, unsigned int retval)
{
    tf->regs.esi = retval;
  1075c0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1075c4:	8b 54 24 08          	mov    0x8(%esp),%edx
  1075c8:	89 50 04             	mov    %edx,0x4(%eax)
}
  1075cb:	c3                   	ret    
  1075cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001075d0 <syscall_set_retval5>:

void syscall_set_retval5(tf_t *tf, unsigned int retval)
{
    tf->regs.edi = retval;
  1075d0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1075d4:	8b 54 24 08          	mov    0x8(%esp),%edx
  1075d8:	89 10                	mov    %edx,(%eax)
}
  1075da:	c3                   	ret    
  1075db:	66 90                	xchg   %ax,%ax
  1075dd:	66 90                	xchg   %ax,%ax
  1075df:	90                   	nop

001075e0 <sys_puts>:
/**
 * Copies a string from user into buffer and prints it to the screen.
 * This is called by the user level "printf" library as a system call.
 */
void sys_puts(tf_t *tf)
{
  1075e0:	55                   	push   %ebp
  1075e1:	57                   	push   %edi
  1075e2:	56                   	push   %esi
  1075e3:	53                   	push   %ebx
  1075e4:	e8 a0 8d ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1075e9:	81 c3 17 8a 00 00    	add    $0x8a17,%ebx
  1075ef:	83 ec 1c             	sub    $0x1c,%esp
    unsigned int cur_pid;
    unsigned int str_uva, str_len;
    unsigned int remain, cur_pos, nbytes;

    cur_pid = get_curid();
  1075f2:	e8 d9 fc ff ff       	call   1072d0 <get_curid>
    str_uva = syscall_get_arg2(tf);
  1075f7:	83 ec 0c             	sub    $0xc,%esp
    cur_pid = get_curid();
  1075fa:	89 44 24 14          	mov    %eax,0x14(%esp)
    str_uva = syscall_get_arg2(tf);
  1075fe:	ff 74 24 3c          	push   0x3c(%esp)
  107602:	e8 29 ff ff ff       	call   107530 <syscall_get_arg2>
  107607:	89 c7                	mov    %eax,%edi
    str_len = syscall_get_arg3(tf);
  107609:	58                   	pop    %eax
  10760a:	ff 74 24 3c          	push   0x3c(%esp)
  10760e:	e8 2d ff ff ff       	call   107540 <syscall_get_arg3>

    if (!(VM_USERLO <= str_uva && str_uva + str_len <= VM_USERHI)) {
  107613:	83 c4 10             	add    $0x10,%esp
  107616:	81 ff ff ff ff 3f    	cmp    $0x3fffffff,%edi
  10761c:	0f 86 f6 00 00 00    	jbe    107718 <sys_puts+0x138>
  107622:	01 c7                	add    %eax,%edi
  107624:	89 c5                	mov    %eax,%ebp
  107626:	81 ff 00 00 00 f0    	cmp    $0xf0000000,%edi
  10762c:	0f 87 e6 00 00 00    	ja     107718 <sys_puts+0x138>
    }

    remain = str_len;
    cur_pos = str_uva;

    while (remain) {
  107632:	85 c0                	test   %eax,%eax
  107634:	0f 84 c0 00 00 00    	je     1076fa <sys_puts+0x11a>
        if (remain < PAGESIZE - 1)
            nbytes = remain;
        else
            nbytes = PAGESIZE - 1;

        if (pt_copyin(cur_pid, cur_pos, sys_buf[cur_pid], nbytes) != nbytes) {
  10763a:	8b 74 24 08          	mov    0x8(%esp),%esi
  10763e:	8d 83 80 3d cb 00    	lea    0xcb3d80(%ebx),%eax
  107644:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107648:	c1 e6 0c             	shl    $0xc,%esi
  10764b:	01 c6                	add    %eax,%esi
  10764d:	eb 43                	jmp    107692 <sys_puts+0xb2>
  10764f:	90                   	nop
  107650:	68 ff 0f 00 00       	push   $0xfff
  107655:	56                   	push   %esi
  107656:	50                   	push   %eax
  107657:	ff 74 24 14          	push   0x14(%esp)
  10765b:	e8 e0 da ff ff       	call   105140 <pt_copyin>
  107660:	83 c4 10             	add    $0x10,%esp
  107663:	3d ff 0f 00 00       	cmp    $0xfff,%eax
  107668:	75 47                	jne    1076b1 <sys_puts+0xd1>
            syscall_set_errno(tf, E_MEM);
            return;
        }

        sys_buf[cur_pid][nbytes] = '\0';
  10766a:	c6 86 ff 0f 00 00 00 	movb   $0x0,0xfff(%esi)
        KERN_INFO("From cpu %d: %s", get_pcpu_idx(), sys_buf[cur_pid]);
  107671:	e8 ca e3 ff ff       	call   105a40 <get_pcpu_idx>
  107676:	83 ec 04             	sub    $0x4,%esp
  107679:	56                   	push   %esi
  10767a:	50                   	push   %eax
  10767b:	8d 83 a9 a7 ff ff    	lea    -0x5857(%ebx),%eax
  107681:	50                   	push   %eax
  107682:	e8 39 c9 ff ff       	call   103fc0 <debug_info>
    while (remain) {
  107687:	83 c4 10             	add    $0x10,%esp
  10768a:	81 ed ff 0f 00 00    	sub    $0xfff,%ebp
  107690:	74 68                	je     1076fa <sys_puts+0x11a>
  107692:	89 f8                	mov    %edi,%eax
  107694:	29 e8                	sub    %ebp,%eax
        if (remain < PAGESIZE - 1)
  107696:	81 fd fe 0f 00 00    	cmp    $0xffe,%ebp
  10769c:	77 b2                	ja     107650 <sys_puts+0x70>
        if (pt_copyin(cur_pid, cur_pos, sys_buf[cur_pid], nbytes) != nbytes) {
  10769e:	55                   	push   %ebp
  10769f:	56                   	push   %esi
  1076a0:	50                   	push   %eax
  1076a1:	ff 74 24 14          	push   0x14(%esp)
  1076a5:	e8 96 da ff ff       	call   105140 <pt_copyin>
  1076aa:	83 c4 10             	add    $0x10,%esp
  1076ad:	39 c5                	cmp    %eax,%ebp
  1076af:	74 1f                	je     1076d0 <sys_puts+0xf0>
            syscall_set_errno(tf, E_MEM);
  1076b1:	83 ec 08             	sub    $0x8,%esp
  1076b4:	6a 01                	push   $0x1
  1076b6:	ff 74 24 3c          	push   0x3c(%esp)
  1076ba:	e8 c1 fe ff ff       	call   107580 <syscall_set_errno>
            return;
  1076bf:	83 c4 10             	add    $0x10,%esp
        remain -= nbytes;
        cur_pos += nbytes;
    }

    syscall_set_errno(tf, E_SUCC);
}
  1076c2:	83 c4 1c             	add    $0x1c,%esp
  1076c5:	5b                   	pop    %ebx
  1076c6:	5e                   	pop    %esi
  1076c7:	5f                   	pop    %edi
  1076c8:	5d                   	pop    %ebp
  1076c9:	c3                   	ret    
  1076ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        sys_buf[cur_pid][nbytes] = '\0';
  1076d0:	8b 44 24 08          	mov    0x8(%esp),%eax
  1076d4:	c1 e0 0c             	shl    $0xc,%eax
  1076d7:	01 c5                	add    %eax,%ebp
  1076d9:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1076dd:	c6 04 28 00          	movb   $0x0,(%eax,%ebp,1)
        KERN_INFO("From cpu %d: %s", get_pcpu_idx(), sys_buf[cur_pid]);
  1076e1:	e8 5a e3 ff ff       	call   105a40 <get_pcpu_idx>
  1076e6:	83 ec 04             	sub    $0x4,%esp
  1076e9:	56                   	push   %esi
  1076ea:	50                   	push   %eax
  1076eb:	8d 83 a9 a7 ff ff    	lea    -0x5857(%ebx),%eax
  1076f1:	50                   	push   %eax
  1076f2:	e8 c9 c8 ff ff       	call   103fc0 <debug_info>
  1076f7:	83 c4 10             	add    $0x10,%esp
    syscall_set_errno(tf, E_SUCC);
  1076fa:	83 ec 08             	sub    $0x8,%esp
  1076fd:	6a 00                	push   $0x0
  1076ff:	ff 74 24 3c          	push   0x3c(%esp)
  107703:	e8 78 fe ff ff       	call   107580 <syscall_set_errno>
  107708:	83 c4 10             	add    $0x10,%esp
}
  10770b:	83 c4 1c             	add    $0x1c,%esp
  10770e:	5b                   	pop    %ebx
  10770f:	5e                   	pop    %esi
  107710:	5f                   	pop    %edi
  107711:	5d                   	pop    %ebp
  107712:	c3                   	ret    
  107713:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  107717:	90                   	nop
        syscall_set_errno(tf, E_INVAL_ADDR);
  107718:	83 ec 08             	sub    $0x8,%esp
  10771b:	6a 04                	push   $0x4
  10771d:	ff 74 24 3c          	push   0x3c(%esp)
  107721:	e8 5a fe ff ff       	call   107580 <syscall_set_errno>
        return;
  107726:	83 c4 10             	add    $0x10,%esp
}
  107729:	83 c4 1c             	add    $0x1c,%esp
  10772c:	5b                   	pop    %ebx
  10772d:	5e                   	pop    %esi
  10772e:	5f                   	pop    %edi
  10772f:	5d                   	pop    %ebp
  107730:	c3                   	ret    
  107731:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107738:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10773f:	90                   	nop

00107740 <sys_spawn>:
 * NUM_IDS with the error number E_INVAL_PID. The same error case apply
 * when the proc_create fails.
 * Otherwise, you should mark it as successful, and return the new child process id.
 */
void sys_spawn(tf_t *tf)
{
  107740:	57                   	push   %edi
  107741:	56                   	push   %esi
  107742:	53                   	push   %ebx
  107743:	8b 7c 24 10          	mov    0x10(%esp),%edi
  107747:	e8 3d 8c ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10774c:	81 c3 b4 88 00 00    	add    $0x88b4,%ebx
    unsigned int new_pid;
    unsigned int elf_id, quota;
    void *elf_addr;

    elf_id = syscall_get_arg2(tf);
  107752:	83 ec 0c             	sub    $0xc,%esp
  107755:	57                   	push   %edi
  107756:	e8 d5 fd ff ff       	call   107530 <syscall_get_arg2>
    quota = syscall_get_arg3(tf);
  10775b:	89 3c 24             	mov    %edi,(%esp)
    elf_id = syscall_get_arg2(tf);
  10775e:	89 c6                	mov    %eax,%esi
    quota = syscall_get_arg3(tf);
  107760:	e8 db fd ff ff       	call   107540 <syscall_get_arg3>

    switch (elf_id) {
  107765:	83 c4 10             	add    $0x10,%esp
  107768:	83 fe 02             	cmp    $0x2,%esi
  10776b:	74 73                	je     1077e0 <sys_spawn+0xa0>
  10776d:	83 fe 03             	cmp    $0x3,%esi
  107770:	74 26                	je     107798 <sys_spawn+0x58>
  107772:	83 fe 01             	cmp    $0x1,%esi
  107775:	74 59                	je     1077d0 <sys_spawn+0x90>
    }

    new_pid = proc_create(elf_addr, quota);

    if (new_pid == NUM_IDS) {
        syscall_set_errno(tf, E_INVAL_PID);
  107777:	83 ec 08             	sub    $0x8,%esp
  10777a:	6a 05                	push   $0x5
  10777c:	57                   	push   %edi
  10777d:	e8 fe fd ff ff       	call   107580 <syscall_set_errno>
        syscall_set_retval1(tf, NUM_IDS);
  107782:	59                   	pop    %ecx
  107783:	5e                   	pop    %esi
  107784:	6a 40                	push   $0x40
  107786:	57                   	push   %edi
  107787:	e8 04 fe ff ff       	call   107590 <syscall_set_retval1>
  10778c:	83 c4 10             	add    $0x10,%esp
    } else {
        syscall_set_errno(tf, E_SUCC);
        syscall_set_retval1(tf, new_pid);
    }
}
  10778f:	5b                   	pop    %ebx
  107790:	5e                   	pop    %esi
  107791:	5f                   	pop    %edi
  107792:	c3                   	ret    
  107793:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  107797:	90                   	nop
        elf_addr = _binary___obj_user_pingpong_ding_start;
  107798:	c7 c2 4a d3 12 00    	mov    $0x12d34a,%edx
    new_pid = proc_create(elf_addr, quota);
  10779e:	83 ec 08             	sub    $0x8,%esp
  1077a1:	50                   	push   %eax
  1077a2:	52                   	push   %edx
  1077a3:	e8 d8 fc ff ff       	call   107480 <proc_create>
    if (new_pid == NUM_IDS) {
  1077a8:	83 c4 10             	add    $0x10,%esp
    new_pid = proc_create(elf_addr, quota);
  1077ab:	89 c6                	mov    %eax,%esi
    if (new_pid == NUM_IDS) {
  1077ad:	83 f8 40             	cmp    $0x40,%eax
  1077b0:	74 c5                	je     107777 <sys_spawn+0x37>
        syscall_set_errno(tf, E_SUCC);
  1077b2:	83 ec 08             	sub    $0x8,%esp
  1077b5:	6a 00                	push   $0x0
  1077b7:	57                   	push   %edi
  1077b8:	e8 c3 fd ff ff       	call   107580 <syscall_set_errno>
        syscall_set_retval1(tf, new_pid);
  1077bd:	58                   	pop    %eax
  1077be:	5a                   	pop    %edx
  1077bf:	56                   	push   %esi
  1077c0:	57                   	push   %edi
  1077c1:	e8 ca fd ff ff       	call   107590 <syscall_set_retval1>
  1077c6:	83 c4 10             	add    $0x10,%esp
}
  1077c9:	5b                   	pop    %ebx
  1077ca:	5e                   	pop    %esi
  1077cb:	5f                   	pop    %edi
  1077cc:	c3                   	ret    
  1077cd:	8d 76 00             	lea    0x0(%esi),%esi
        elf_addr = _binary___obj_user_pingpong_ping_start;
  1077d0:	c7 c2 3e 9d 11 00    	mov    $0x119d3e,%edx
  1077d6:	eb c6                	jmp    10779e <sys_spawn+0x5e>
  1077d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1077df:	90                   	nop
    switch (elf_id) {
  1077e0:	c7 c2 6a 38 12 00    	mov    $0x12386a,%edx
  1077e6:	eb b6                	jmp    10779e <sys_spawn+0x5e>
  1077e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1077ef:	90                   	nop

001077f0 <sys_yield>:
 * The user level library function sys_yield (defined in user/include/syscall.h)
 * does not take any argument and does not have any return values.
 * Do not forget to set the error number as E_SUCC.
 */
void sys_yield(tf_t *tf)
{
  1077f0:	53                   	push   %ebx
  1077f1:	e8 93 8b ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1077f6:	81 c3 0a 88 00 00    	add    $0x880a,%ebx
  1077fc:	83 ec 08             	sub    $0x8,%esp
    thread_yield();
  1077ff:	e8 bc fb ff ff       	call   1073c0 <thread_yield>
    syscall_set_errno(tf, E_SUCC);
  107804:	83 ec 08             	sub    $0x8,%esp
  107807:	6a 00                	push   $0x0
  107809:	ff 74 24 1c          	push   0x1c(%esp)
  10780d:	e8 6e fd ff ff       	call   107580 <syscall_set_errno>
}
  107812:	83 c4 18             	add    $0x18,%esp
  107815:	5b                   	pop    %ebx
  107816:	c3                   	ret    
  107817:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10781e:	66 90                	xchg   %ax,%ax

00107820 <sys_produce>:

void sys_produce(tf_t *tf)
{
  107820:	55                   	push   %ebp
  107821:	57                   	push   %edi
  107822:	56                   	push   %esi
    unsigned int i;
    for (i = 0; i < 5; i++) {
  107823:	31 f6                	xor    %esi,%esi
{
  107825:	53                   	push   %ebx
  107826:	e8 5e 8b ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10782b:	81 c3 d5 87 00 00    	add    $0x87d5,%ebx
  107831:	83 ec 1c             	sub    $0x1c,%esp
  107834:	8d 83 b9 a7 ff ff    	lea    -0x5847(%ebx),%eax
  10783a:	8d ab d8 a7 ff ff    	lea    -0x5828(%ebx),%ebp
  107840:	89 44 24 0c          	mov    %eax,0xc(%esp)
        KERN_DEBUG("CPU %d: Process %d: Produced %d\n", get_pcpu_idx(), get_curid(), i);
  107844:	e8 87 fa ff ff       	call   1072d0 <get_curid>
  107849:	89 c7                	mov    %eax,%edi
  10784b:	e8 f0 e1 ff ff       	call   105a40 <get_pcpu_idx>
  107850:	83 ec 08             	sub    $0x8,%esp
  107853:	56                   	push   %esi
    for (i = 0; i < 5; i++) {
  107854:	83 c6 01             	add    $0x1,%esi
        KERN_DEBUG("CPU %d: Process %d: Produced %d\n", get_pcpu_idx(), get_curid(), i);
  107857:	57                   	push   %edi
  107858:	50                   	push   %eax
  107859:	55                   	push   %ebp
  10785a:	68 83 00 00 00       	push   $0x83
  10785f:	ff 74 24 28          	push   0x28(%esp)
  107863:	e8 88 c7 ff ff       	call   103ff0 <debug_normal>
    for (i = 0; i < 5; i++) {
  107868:	83 c4 20             	add    $0x20,%esp
  10786b:	83 fe 05             	cmp    $0x5,%esi
  10786e:	75 d4                	jne    107844 <sys_produce+0x24>
    }
    syscall_set_errno(tf, E_SUCC);
  107870:	83 ec 08             	sub    $0x8,%esp
  107873:	6a 00                	push   $0x0
  107875:	ff 74 24 3c          	push   0x3c(%esp)
  107879:	e8 02 fd ff ff       	call   107580 <syscall_set_errno>
}
  10787e:	83 c4 2c             	add    $0x2c,%esp
  107881:	5b                   	pop    %ebx
  107882:	5e                   	pop    %esi
  107883:	5f                   	pop    %edi
  107884:	5d                   	pop    %ebp
  107885:	c3                   	ret    
  107886:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10788d:	8d 76 00             	lea    0x0(%esi),%esi

00107890 <sys_consume>:

void sys_consume(tf_t *tf)
{
  107890:	55                   	push   %ebp
  107891:	57                   	push   %edi
  107892:	56                   	push   %esi
    unsigned int i;
    for (i = 0; i < 5; i++) {
  107893:	31 f6                	xor    %esi,%esi
{
  107895:	53                   	push   %ebx
  107896:	e8 ee 8a ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  10789b:	81 c3 65 87 00 00    	add    $0x8765,%ebx
  1078a1:	83 ec 1c             	sub    $0x1c,%esp
  1078a4:	8d 83 b9 a7 ff ff    	lea    -0x5847(%ebx),%eax
  1078aa:	8d ab fc a7 ff ff    	lea    -0x5804(%ebx),%ebp
  1078b0:	89 44 24 0c          	mov    %eax,0xc(%esp)
        KERN_DEBUG("CPU %d: Process %d: Consumed %d\n", get_pcpu_idx(), get_curid(), i);
  1078b4:	e8 17 fa ff ff       	call   1072d0 <get_curid>
  1078b9:	89 c7                	mov    %eax,%edi
  1078bb:	e8 80 e1 ff ff       	call   105a40 <get_pcpu_idx>
  1078c0:	83 ec 08             	sub    $0x8,%esp
  1078c3:	56                   	push   %esi
    for (i = 0; i < 5; i++) {
  1078c4:	83 c6 01             	add    $0x1,%esi
        KERN_DEBUG("CPU %d: Process %d: Consumed %d\n", get_pcpu_idx(), get_curid(), i);
  1078c7:	57                   	push   %edi
  1078c8:	50                   	push   %eax
  1078c9:	55                   	push   %ebp
  1078ca:	68 8c 00 00 00       	push   $0x8c
  1078cf:	ff 74 24 28          	push   0x28(%esp)
  1078d3:	e8 18 c7 ff ff       	call   103ff0 <debug_normal>
    for (i = 0; i < 5; i++) {
  1078d8:	83 c4 20             	add    $0x20,%esp
  1078db:	83 fe 05             	cmp    $0x5,%esi
  1078de:	75 d4                	jne    1078b4 <sys_consume+0x24>
    }
    syscall_set_errno(tf, E_SUCC);
  1078e0:	83 ec 08             	sub    $0x8,%esp
  1078e3:	6a 00                	push   $0x0
  1078e5:	ff 74 24 3c          	push   0x3c(%esp)
  1078e9:	e8 92 fc ff ff       	call   107580 <syscall_set_errno>
}
  1078ee:	83 c4 2c             	add    $0x2c,%esp
  1078f1:	5b                   	pop    %ebx
  1078f2:	5e                   	pop    %esi
  1078f3:	5f                   	pop    %edi
  1078f4:	5d                   	pop    %ebp
  1078f5:	c3                   	ret    
  1078f6:	66 90                	xchg   %ax,%ax
  1078f8:	66 90                	xchg   %ax,%ax
  1078fa:	66 90                	xchg   %ax,%ax
  1078fc:	66 90                	xchg   %ax,%ax
  1078fe:	66 90                	xchg   %ax,%ax

00107900 <syscall_dispatch>:
#include <pcpu/PCPUIntro/export.h>

#include "import.h"

void syscall_dispatch(tf_t *tf)
{
  107900:	56                   	push   %esi
  107901:	53                   	push   %ebx
  107902:	e8 82 8a ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107907:	81 c3 f9 86 00 00    	add    $0x86f9,%ebx
  10790d:	83 ec 10             	sub    $0x10,%esp
  107910:	8b 74 24 1c          	mov    0x1c(%esp),%esi
    unsigned int nr;

    nr = syscall_get_arg1(tf);
  107914:	56                   	push   %esi
  107915:	e8 06 fc ff ff       	call   107520 <syscall_get_arg1>

    switch (nr) {
  10791a:	83 c4 10             	add    $0x10,%esp
  10791d:	83 f8 04             	cmp    $0x4,%eax
  107920:	0f 87 84 00 00 00    	ja     1079aa <.L6+0x12>
  107926:	8b 94 83 20 a8 ff ff 	mov    -0x57e0(%ebx,%eax,4),%edx
  10792d:	01 da                	add    %ebx,%edx
  10792f:	ff e2                	jmp    *%edx
  107931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00107938 <.L5>:
         *   None.
         */
        sys_yield(tf);
        break;
    case SYS_produce:
        sys_produce(tf);
  107938:	83 ec 0c             	sub    $0xc,%esp
  10793b:	56                   	push   %esi
  10793c:	e8 df fe ff ff       	call   107820 <sys_produce>
        break;
  107941:	83 c4 10             	add    $0x10,%esp
        sys_consume(tf);
        break;
    default:
        syscall_set_errno(tf, E_INVAL_CALLNR);
    }
}
  107944:	83 c4 04             	add    $0x4,%esp
  107947:	5b                   	pop    %ebx
  107948:	5e                   	pop    %esi
  107949:	c3                   	ret    
  10794a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107950 <.L3>:
        sys_consume(tf);
  107950:	83 ec 0c             	sub    $0xc,%esp
  107953:	56                   	push   %esi
  107954:	e8 37 ff ff ff       	call   107890 <sys_consume>
        break;
  107959:	83 c4 10             	add    $0x10,%esp
}
  10795c:	83 c4 04             	add    $0x4,%esp
  10795f:	5b                   	pop    %ebx
  107960:	5e                   	pop    %esi
  107961:	c3                   	ret    
  107962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107968 <.L8>:
        sys_puts(tf);
  107968:	83 ec 0c             	sub    $0xc,%esp
  10796b:	56                   	push   %esi
  10796c:	e8 6f fc ff ff       	call   1075e0 <sys_puts>
        break;
  107971:	83 c4 10             	add    $0x10,%esp
}
  107974:	83 c4 04             	add    $0x4,%esp
  107977:	5b                   	pop    %ebx
  107978:	5e                   	pop    %esi
  107979:	c3                   	ret    
  10797a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107980 <.L7>:
        sys_spawn(tf);
  107980:	83 ec 0c             	sub    $0xc,%esp
  107983:	56                   	push   %esi
  107984:	e8 b7 fd ff ff       	call   107740 <sys_spawn>
        break;
  107989:	83 c4 10             	add    $0x10,%esp
}
  10798c:	83 c4 04             	add    $0x4,%esp
  10798f:	5b                   	pop    %ebx
  107990:	5e                   	pop    %esi
  107991:	c3                   	ret    
  107992:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107998 <.L6>:
        sys_yield(tf);
  107998:	83 ec 0c             	sub    $0xc,%esp
  10799b:	56                   	push   %esi
  10799c:	e8 4f fe ff ff       	call   1077f0 <sys_yield>
        break;
  1079a1:	83 c4 10             	add    $0x10,%esp
}
  1079a4:	83 c4 04             	add    $0x4,%esp
  1079a7:	5b                   	pop    %ebx
  1079a8:	5e                   	pop    %esi
  1079a9:	c3                   	ret    
        syscall_set_errno(tf, E_INVAL_CALLNR);
  1079aa:	83 ec 08             	sub    $0x8,%esp
  1079ad:	6a 03                	push   $0x3
  1079af:	56                   	push   %esi
  1079b0:	e8 cb fb ff ff       	call   107580 <syscall_set_errno>
  1079b5:	83 c4 10             	add    $0x10,%esp
}
  1079b8:	83 c4 04             	add    $0x4,%esp
  1079bb:	5b                   	pop    %ebx
  1079bc:	5e                   	pop    %esi
  1079bd:	c3                   	ret    
  1079be:	66 90                	xchg   %ax,%ax

001079c0 <trap_dump>:
#include <thread/PThread/export.h>

#include "import.h"

static void trap_dump(tf_t *tf)
{
  1079c0:	55                   	push   %ebp
  1079c1:	57                   	push   %edi
  1079c2:	56                   	push   %esi
  1079c3:	53                   	push   %ebx
  1079c4:	e8 c0 89 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  1079c9:	81 c3 37 86 00 00    	add    $0x8637,%ebx
  1079cf:	83 ec 0c             	sub    $0xc,%esp
    if (tf == NULL)
  1079d2:	85 c0                	test   %eax,%eax
  1079d4:	0f 84 c0 01 00 00    	je     107b9a <trap_dump+0x1da>
  1079da:	89 c6                	mov    %eax,%esi
        return;

    uintptr_t base = (uintptr_t) tf;

    KERN_DEBUG("trapframe at %x\n", base);
  1079dc:	8d bb b8 a9 ff ff    	lea    -0x5648(%ebx),%edi
  1079e2:	50                   	push   %eax
  1079e3:	8d 83 34 a8 ff ff    	lea    -0x57cc(%ebx),%eax
  1079e9:	50                   	push   %eax
    KERN_DEBUG("\t%08x:\tedi:   \t\t%08x\n", &tf->regs.edi, tf->regs.edi);
    KERN_DEBUG("\t%08x:\tesi:   \t\t%08x\n", &tf->regs.esi, tf->regs.esi);
    KERN_DEBUG("\t%08x:\tebp:   \t\t%08x\n", &tf->regs.ebp, tf->regs.ebp);
    KERN_DEBUG("\t%08x:\tesp:   \t\t%08x\n", &tf->regs.oesp, tf->regs.oesp);
  1079ea:	8d ab 87 a8 ff ff    	lea    -0x5779(%ebx),%ebp
    KERN_DEBUG("trapframe at %x\n", base);
  1079f0:	6a 16                	push   $0x16
  1079f2:	57                   	push   %edi
  1079f3:	e8 f8 c5 ff ff       	call   103ff0 <debug_normal>
    KERN_DEBUG("\t%08x:\tedi:   \t\t%08x\n", &tf->regs.edi, tf->regs.edi);
  1079f8:	58                   	pop    %eax
  1079f9:	8d 83 45 a8 ff ff    	lea    -0x57bb(%ebx),%eax
  1079ff:	ff 36                	push   (%esi)
  107a01:	56                   	push   %esi
  107a02:	50                   	push   %eax
  107a03:	6a 17                	push   $0x17
  107a05:	57                   	push   %edi
  107a06:	e8 e5 c5 ff ff       	call   103ff0 <debug_normal>
    KERN_DEBUG("\t%08x:\tesi:   \t\t%08x\n", &tf->regs.esi, tf->regs.esi);
  107a0b:	83 c4 14             	add    $0x14,%esp
  107a0e:	8d 46 04             	lea    0x4(%esi),%eax
  107a11:	ff 76 04             	push   0x4(%esi)
  107a14:	50                   	push   %eax
  107a15:	8d 83 5b a8 ff ff    	lea    -0x57a5(%ebx),%eax
  107a1b:	50                   	push   %eax
  107a1c:	6a 18                	push   $0x18
  107a1e:	57                   	push   %edi
  107a1f:	e8 cc c5 ff ff       	call   103ff0 <debug_normal>
    KERN_DEBUG("\t%08x:\tebp:   \t\t%08x\n", &tf->regs.ebp, tf->regs.ebp);
  107a24:	83 c4 14             	add    $0x14,%esp
  107a27:	8d 46 08             	lea    0x8(%esi),%eax
  107a2a:	ff 76 08             	push   0x8(%esi)
  107a2d:	50                   	push   %eax
  107a2e:	8d 83 71 a8 ff ff    	lea    -0x578f(%ebx),%eax
  107a34:	50                   	push   %eax
  107a35:	6a 19                	push   $0x19
  107a37:	57                   	push   %edi
  107a38:	e8 b3 c5 ff ff       	call   103ff0 <debug_normal>
    KERN_DEBUG("\t%08x:\tesp:   \t\t%08x\n", &tf->regs.oesp, tf->regs.oesp);
  107a3d:	83 c4 14             	add    $0x14,%esp
  107a40:	8d 46 0c             	lea    0xc(%esi),%eax
  107a43:	ff 76 0c             	push   0xc(%esi)
  107a46:	50                   	push   %eax
  107a47:	55                   	push   %ebp
  107a48:	6a 1a                	push   $0x1a
  107a4a:	57                   	push   %edi
  107a4b:	e8 a0 c5 ff ff       	call   103ff0 <debug_normal>
    KERN_DEBUG("\t%08x:\tebx:   \t\t%08x\n", &tf->regs.ebx, tf->regs.ebx);
  107a50:	83 c4 14             	add    $0x14,%esp
  107a53:	8d 46 10             	lea    0x10(%esi),%eax
  107a56:	ff 76 10             	push   0x10(%esi)
  107a59:	50                   	push   %eax
  107a5a:	8d 83 9d a8 ff ff    	lea    -0x5763(%ebx),%eax
  107a60:	50                   	push   %eax
  107a61:	6a 1b                	push   $0x1b
  107a63:	57                   	push   %edi
  107a64:	e8 87 c5 ff ff       	call   103ff0 <debug_normal>
    KERN_DEBUG("\t%08x:\tedx:   \t\t%08x\n", &tf->regs.edx, tf->regs.edx);
  107a69:	83 c4 14             	add    $0x14,%esp
  107a6c:	8d 46 14             	lea    0x14(%esi),%eax
  107a6f:	ff 76 14             	push   0x14(%esi)
  107a72:	50                   	push   %eax
  107a73:	8d 83 b3 a8 ff ff    	lea    -0x574d(%ebx),%eax
  107a79:	50                   	push   %eax
  107a7a:	6a 1c                	push   $0x1c
  107a7c:	57                   	push   %edi
  107a7d:	e8 6e c5 ff ff       	call   103ff0 <debug_normal>
    KERN_DEBUG("\t%08x:\tecx:   \t\t%08x\n", &tf->regs.ecx, tf->regs.ecx);
  107a82:	83 c4 14             	add    $0x14,%esp
  107a85:	8d 46 18             	lea    0x18(%esi),%eax
  107a88:	ff 76 18             	push   0x18(%esi)
  107a8b:	50                   	push   %eax
  107a8c:	8d 83 c9 a8 ff ff    	lea    -0x5737(%ebx),%eax
  107a92:	50                   	push   %eax
  107a93:	6a 1d                	push   $0x1d
  107a95:	57                   	push   %edi
  107a96:	e8 55 c5 ff ff       	call   103ff0 <debug_normal>
    KERN_DEBUG("\t%08x:\teax:   \t\t%08x\n", &tf->regs.eax, tf->regs.eax);
  107a9b:	83 c4 14             	add    $0x14,%esp
  107a9e:	8d 46 1c             	lea    0x1c(%esi),%eax
  107aa1:	ff 76 1c             	push   0x1c(%esi)
  107aa4:	50                   	push   %eax
  107aa5:	8d 83 df a8 ff ff    	lea    -0x5721(%ebx),%eax
  107aab:	50                   	push   %eax
  107aac:	6a 1e                	push   $0x1e
  107aae:	57                   	push   %edi
  107aaf:	e8 3c c5 ff ff       	call   103ff0 <debug_normal>
    KERN_DEBUG("\t%08x:\tes:    \t\t%08x\n", &tf->es, tf->es);
  107ab4:	0f b7 46 20          	movzwl 0x20(%esi),%eax
  107ab8:	83 c4 14             	add    $0x14,%esp
  107abb:	50                   	push   %eax
  107abc:	8d 46 20             	lea    0x20(%esi),%eax
  107abf:	50                   	push   %eax
  107ac0:	8d 83 f5 a8 ff ff    	lea    -0x570b(%ebx),%eax
  107ac6:	50                   	push   %eax
  107ac7:	6a 1f                	push   $0x1f
  107ac9:	57                   	push   %edi
  107aca:	e8 21 c5 ff ff       	call   103ff0 <debug_normal>
    KERN_DEBUG("\t%08x:\tds:    \t\t%08x\n", &tf->ds, tf->ds);
  107acf:	0f b7 46 24          	movzwl 0x24(%esi),%eax
  107ad3:	83 c4 14             	add    $0x14,%esp
  107ad6:	50                   	push   %eax
  107ad7:	8d 46 24             	lea    0x24(%esi),%eax
  107ada:	50                   	push   %eax
  107adb:	8d 83 0b a9 ff ff    	lea    -0x56f5(%ebx),%eax
  107ae1:	50                   	push   %eax
  107ae2:	6a 20                	push   $0x20
  107ae4:	57                   	push   %edi
  107ae5:	e8 06 c5 ff ff       	call   103ff0 <debug_normal>
    KERN_DEBUG("\t%08x:\ttrapno:\t\t%08x\n", &tf->trapno, tf->trapno);
  107aea:	83 c4 14             	add    $0x14,%esp
  107aed:	8d 46 28             	lea    0x28(%esi),%eax
  107af0:	ff 76 28             	push   0x28(%esi)
  107af3:	50                   	push   %eax
  107af4:	8d 83 21 a9 ff ff    	lea    -0x56df(%ebx),%eax
  107afa:	50                   	push   %eax
  107afb:	6a 21                	push   $0x21
  107afd:	57                   	push   %edi
  107afe:	e8 ed c4 ff ff       	call   103ff0 <debug_normal>
    KERN_DEBUG("\t%08x:\terr:   \t\t%08x\n", &tf->err, tf->err);
  107b03:	83 c4 14             	add    $0x14,%esp
  107b06:	8d 46 2c             	lea    0x2c(%esi),%eax
  107b09:	ff 76 2c             	push   0x2c(%esi)
  107b0c:	50                   	push   %eax
  107b0d:	8d 83 37 a9 ff ff    	lea    -0x56c9(%ebx),%eax
  107b13:	50                   	push   %eax
  107b14:	6a 22                	push   $0x22
  107b16:	57                   	push   %edi
  107b17:	e8 d4 c4 ff ff       	call   103ff0 <debug_normal>
    KERN_DEBUG("\t%08x:\teip:   \t\t%08x\n", &tf->eip, tf->eip);
  107b1c:	83 c4 14             	add    $0x14,%esp
  107b1f:	8d 46 30             	lea    0x30(%esi),%eax
  107b22:	ff 76 30             	push   0x30(%esi)
  107b25:	50                   	push   %eax
  107b26:	8d 83 4d a9 ff ff    	lea    -0x56b3(%ebx),%eax
  107b2c:	50                   	push   %eax
  107b2d:	6a 23                	push   $0x23
  107b2f:	57                   	push   %edi
  107b30:	e8 bb c4 ff ff       	call   103ff0 <debug_normal>
    KERN_DEBUG("\t%08x:\tcs:    \t\t%08x\n", &tf->cs, tf->cs);
  107b35:	0f b7 46 34          	movzwl 0x34(%esi),%eax
  107b39:	83 c4 14             	add    $0x14,%esp
  107b3c:	50                   	push   %eax
  107b3d:	8d 46 34             	lea    0x34(%esi),%eax
  107b40:	50                   	push   %eax
  107b41:	8d 83 63 a9 ff ff    	lea    -0x569d(%ebx),%eax
  107b47:	50                   	push   %eax
  107b48:	6a 24                	push   $0x24
  107b4a:	57                   	push   %edi
  107b4b:	e8 a0 c4 ff ff       	call   103ff0 <debug_normal>
    KERN_DEBUG("\t%08x:\teflags:\t\t%08x\n", &tf->eflags, tf->eflags);
  107b50:	83 c4 14             	add    $0x14,%esp
  107b53:	8d 46 38             	lea    0x38(%esi),%eax
  107b56:	ff 76 38             	push   0x38(%esi)
  107b59:	50                   	push   %eax
  107b5a:	8d 83 79 a9 ff ff    	lea    -0x5687(%ebx),%eax
  107b60:	50                   	push   %eax
  107b61:	6a 25                	push   $0x25
  107b63:	57                   	push   %edi
  107b64:	e8 87 c4 ff ff       	call   103ff0 <debug_normal>
    KERN_DEBUG("\t%08x:\tesp:   \t\t%08x\n", &tf->esp, tf->esp);
  107b69:	83 c4 14             	add    $0x14,%esp
  107b6c:	8d 46 3c             	lea    0x3c(%esi),%eax
  107b6f:	ff 76 3c             	push   0x3c(%esi)
  107b72:	50                   	push   %eax
  107b73:	55                   	push   %ebp
  107b74:	6a 26                	push   $0x26
  107b76:	57                   	push   %edi
  107b77:	e8 74 c4 ff ff       	call   103ff0 <debug_normal>
    KERN_DEBUG("\t%08x:\tss:    \t\t%08x\n", &tf->ss, tf->ss);
  107b7c:	0f b7 46 40          	movzwl 0x40(%esi),%eax
  107b80:	83 c4 14             	add    $0x14,%esp
  107b83:	83 c6 40             	add    $0x40,%esi
  107b86:	50                   	push   %eax
  107b87:	8d 83 8f a9 ff ff    	lea    -0x5671(%ebx),%eax
  107b8d:	56                   	push   %esi
  107b8e:	50                   	push   %eax
  107b8f:	6a 27                	push   $0x27
  107b91:	57                   	push   %edi
  107b92:	e8 59 c4 ff ff       	call   103ff0 <debug_normal>
  107b97:	83 c4 20             	add    $0x20,%esp
}
  107b9a:	83 c4 0c             	add    $0xc,%esp
  107b9d:	5b                   	pop    %ebx
  107b9e:	5e                   	pop    %esi
  107b9f:	5f                   	pop    %edi
  107ba0:	5d                   	pop    %ebp
  107ba1:	c3                   	ret    
  107ba2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00107bb0 <default_exception_handler>:

void default_exception_handler(tf_t *tf)
{
  107bb0:	56                   	push   %esi
  107bb1:	53                   	push   %ebx
  107bb2:	e8 d2 87 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107bb7:	81 c3 49 84 00 00    	add    $0x8449,%ebx
  107bbd:	83 ec 04             	sub    $0x4,%esp
  107bc0:	8b 74 24 10          	mov    0x10(%esp),%esi
    unsigned int cur_pid;

    cur_pid = get_curid();
  107bc4:	e8 07 f7 ff ff       	call   1072d0 <get_curid>
    trap_dump(tf);
  107bc9:	89 f0                	mov    %esi,%eax
  107bcb:	e8 f0 fd ff ff       	call   1079c0 <trap_dump>

    KERN_PANIC("Trap %d @ 0x%08x.\n", tf->trapno, tf->eip);
  107bd0:	83 ec 0c             	sub    $0xc,%esp
  107bd3:	8d 83 a5 a9 ff ff    	lea    -0x565b(%ebx),%eax
  107bd9:	ff 76 30             	push   0x30(%esi)
  107bdc:	ff 76 28             	push   0x28(%esi)
  107bdf:	50                   	push   %eax
  107be0:	8d 83 b8 a9 ff ff    	lea    -0x5648(%ebx),%eax
  107be6:	6a 31                	push   $0x31
  107be8:	50                   	push   %eax
  107be9:	e8 42 c4 ff ff       	call   104030 <debug_panic>
}
  107bee:	83 c4 24             	add    $0x24,%esp
  107bf1:	5b                   	pop    %ebx
  107bf2:	5e                   	pop    %esi
  107bf3:	c3                   	ret    
  107bf4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107bfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  107bff:	90                   	nop

00107c00 <pgflt_handler>:

void pgflt_handler(tf_t *tf)
{
  107c00:	55                   	push   %ebp
  107c01:	57                   	push   %edi
  107c02:	56                   	push   %esi
  107c03:	53                   	push   %ebx
  107c04:	e8 80 87 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107c09:	81 c3 f7 83 00 00    	add    $0x83f7,%ebx
  107c0f:	83 ec 0c             	sub    $0xc,%esp
    unsigned int cur_pid;
    unsigned int errno;
    unsigned int fault_va;

    cur_pid = get_curid();
  107c12:	e8 b9 f6 ff ff       	call   1072d0 <get_curid>
  107c17:	89 c6                	mov    %eax,%esi
    errno = tf->err;
  107c19:	8b 44 24 20          	mov    0x20(%esp),%eax
  107c1d:	8b 78 2c             	mov    0x2c(%eax),%edi
    fault_va = rcr2();
  107c20:	e8 9b d1 ff ff       	call   104dc0 <rcr2>
  107c25:	89 c5                	mov    %eax,%ebp

    // Uncomment this line to see information about the page fault
    // KERN_DEBUG("Page fault: VA 0x%08x, errno 0x%08x, process %d, EIP 0x%08x.\n",
    //            fault_va, errno, cur_pid, uctx_pool[cur_pid].eip);

    if (errno & PFE_PR) {
  107c27:	f7 c7 01 00 00 00    	test   $0x1,%edi
  107c2d:	75 21                	jne    107c50 <pgflt_handler+0x50>
        KERN_PANIC("Permission denied: va = 0x%08x, errno = 0x%08x.\n",
                   fault_va, errno);
        return;
    }

    if (alloc_page(cur_pid, fault_va, PTE_W | PTE_U | PTE_P) == MagicNumber) {
  107c2f:	83 ec 04             	sub    $0x4,%esp
  107c32:	6a 07                	push   $0x7
  107c34:	50                   	push   %eax
  107c35:	56                   	push   %esi
  107c36:	e8 55 f0 ff ff       	call   106c90 <alloc_page>
  107c3b:	83 c4 10             	add    $0x10,%esp
  107c3e:	3d 01 00 10 00       	cmp    $0x100001,%eax
  107c43:	74 33                	je     107c78 <pgflt_handler+0x78>
        KERN_PANIC("Page allocation failed: va = 0x%08x, errno = 0x%08x.\n",
                   fault_va, errno);
    }
}
  107c45:	83 c4 0c             	add    $0xc,%esp
  107c48:	5b                   	pop    %ebx
  107c49:	5e                   	pop    %esi
  107c4a:	5f                   	pop    %edi
  107c4b:	5d                   	pop    %ebp
  107c4c:	c3                   	ret    
  107c4d:	8d 76 00             	lea    0x0(%esi),%esi
        KERN_PANIC("Permission denied: va = 0x%08x, errno = 0x%08x.\n",
  107c50:	83 ec 0c             	sub    $0xc,%esp
  107c53:	57                   	push   %edi
  107c54:	50                   	push   %eax
  107c55:	8d 83 e0 a9 ff ff    	lea    -0x5620(%ebx),%eax
  107c5b:	50                   	push   %eax
  107c5c:	8d 83 b8 a9 ff ff    	lea    -0x5648(%ebx),%eax
  107c62:	6a 43                	push   $0x43
  107c64:	50                   	push   %eax
  107c65:	e8 c6 c3 ff ff       	call   104030 <debug_panic>
        return;
  107c6a:	83 c4 20             	add    $0x20,%esp
}
  107c6d:	83 c4 0c             	add    $0xc,%esp
  107c70:	5b                   	pop    %ebx
  107c71:	5e                   	pop    %esi
  107c72:	5f                   	pop    %edi
  107c73:	5d                   	pop    %ebp
  107c74:	c3                   	ret    
  107c75:	8d 76 00             	lea    0x0(%esi),%esi
        KERN_PANIC("Page allocation failed: va = 0x%08x, errno = 0x%08x.\n",
  107c78:	83 ec 0c             	sub    $0xc,%esp
  107c7b:	8d 83 14 aa ff ff    	lea    -0x55ec(%ebx),%eax
  107c81:	57                   	push   %edi
  107c82:	55                   	push   %ebp
  107c83:	50                   	push   %eax
  107c84:	8d 83 b8 a9 ff ff    	lea    -0x5648(%ebx),%eax
  107c8a:	6a 49                	push   $0x49
  107c8c:	50                   	push   %eax
  107c8d:	e8 9e c3 ff ff       	call   104030 <debug_panic>
  107c92:	83 c4 20             	add    $0x20,%esp
}
  107c95:	83 c4 0c             	add    $0xc,%esp
  107c98:	5b                   	pop    %ebx
  107c99:	5e                   	pop    %esi
  107c9a:	5f                   	pop    %edi
  107c9b:	5d                   	pop    %ebp
  107c9c:	c3                   	ret    
  107c9d:	8d 76 00             	lea    0x0(%esi),%esi

00107ca0 <exception_handler>:
/**
 * We currently only handle the page fault exception.
 * All other exceptions should be routed to the default exception handler.
 */
void exception_handler(tf_t *tf)
{
  107ca0:	56                   	push   %esi
  107ca1:	53                   	push   %ebx
  107ca2:	e8 e2 86 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107ca7:	81 c3 59 83 00 00    	add    $0x8359,%ebx
  107cad:	83 ec 04             	sub    $0x4,%esp
  107cb0:	8b 74 24 10          	mov    0x10(%esp),%esi
    if (tf->trapno == T_PGFLT)
  107cb4:	83 7e 28 0e          	cmpl   $0xe,0x28(%esi)
  107cb8:	74 36                	je     107cf0 <exception_handler+0x50>
    cur_pid = get_curid();
  107cba:	e8 11 f6 ff ff       	call   1072d0 <get_curid>
    trap_dump(tf);
  107cbf:	89 f0                	mov    %esi,%eax
  107cc1:	e8 fa fc ff ff       	call   1079c0 <trap_dump>
    KERN_PANIC("Trap %d @ 0x%08x.\n", tf->trapno, tf->eip);
  107cc6:	83 ec 0c             	sub    $0xc,%esp
  107cc9:	8d 83 a5 a9 ff ff    	lea    -0x565b(%ebx),%eax
  107ccf:	ff 76 30             	push   0x30(%esi)
  107cd2:	ff 76 28             	push   0x28(%esi)
  107cd5:	50                   	push   %eax
  107cd6:	8d 83 b8 a9 ff ff    	lea    -0x5648(%ebx),%eax
  107cdc:	6a 31                	push   $0x31
  107cde:	50                   	push   %eax
  107cdf:	e8 4c c3 ff ff       	call   104030 <debug_panic>
        pgflt_handler(tf);
    else
        default_exception_handler(tf);
}
  107ce4:	83 c4 24             	add    $0x24,%esp
  107ce7:	5b                   	pop    %ebx
  107ce8:	5e                   	pop    %esi
  107ce9:	c3                   	ret    
  107cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        pgflt_handler(tf);
  107cf0:	89 74 24 10          	mov    %esi,0x10(%esp)
}
  107cf4:	83 c4 04             	add    $0x4,%esp
  107cf7:	5b                   	pop    %ebx
  107cf8:	5e                   	pop    %esi
        pgflt_handler(tf);
  107cf9:	e9 02 ff ff ff       	jmp    107c00 <pgflt_handler>
  107cfe:	66 90                	xchg   %ax,%ax

00107d00 <interrupt_handler>:
/**
 * Any interrupt request other than the spurious or timer should be
 * routed to the default interrupt handler.
 */
void interrupt_handler(tf_t *tf)
{
  107d00:	53                   	push   %ebx
  107d01:	e8 83 86 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107d06:	81 c3 fa 82 00 00    	add    $0x82fa,%ebx
  107d0c:	83 ec 08             	sub    $0x8,%esp
    switch (tf->trapno) {
  107d0f:	8b 44 24 10          	mov    0x10(%esp),%eax
  107d13:	83 78 28 27          	cmpl   $0x27,0x28(%eax)
  107d17:	74 05                	je     107d1e <interrupt_handler+0x1e>
    intr_eoi();
  107d19:	e8 22 9c ff ff       	call   101940 <intr_eoi>
        timer_intr_handler();
        break;
    default:
        default_intr_handler();
    }
}
  107d1e:	83 c4 08             	add    $0x8,%esp
  107d21:	5b                   	pop    %ebx
  107d22:	c3                   	ret    
  107d23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107d30 <trap>:

unsigned int last_active[NUM_CPUS];

void trap(tf_t *tf)
{
  107d30:	55                   	push   %ebp
  107d31:	57                   	push   %edi
  107d32:	56                   	push   %esi
  107d33:	53                   	push   %ebx
  107d34:	e8 50 86 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107d39:	81 c3 c7 82 00 00    	add    $0x82c7,%ebx
  107d3f:	83 ec 1c             	sub    $0x1c,%esp
    unsigned int cur_pid = get_curid();
  107d42:	e8 89 f5 ff ff       	call   1072d0 <get_curid>
    unsigned int cpu_idx = get_pcpu_idx();
    trap_cb_t handler;

    unsigned int last_pid = last_active[cpu_idx];
  107d47:	8d ab 80 3d cf 00    	lea    0xcf3d80(%ebx),%ebp
    unsigned int cur_pid = get_curid();
  107d4d:	89 44 24 0c          	mov    %eax,0xc(%esp)
    unsigned int cpu_idx = get_pcpu_idx();
  107d51:	e8 ea dc ff ff       	call   105a40 <get_pcpu_idx>
    unsigned int last_pid = last_active[cpu_idx];
  107d56:	8b 7c 85 00          	mov    0x0(%ebp,%eax,4),%edi
    unsigned int cpu_idx = get_pcpu_idx();
  107d5a:	89 c6                	mov    %eax,%esi

    if (last_pid != 0)
  107d5c:	85 ff                	test   %edi,%edi
  107d5e:	75 48                	jne    107da8 <trap+0x78>
    {
        set_pdir_base(0);  // switch to the kernel's page table
        last_active[cpu_idx] = 0;
    }

    handler = TRAP_HANDLER[get_pcpu_idx()][tf->trapno];
  107d60:	e8 db dc ff ff       	call   105a40 <get_pcpu_idx>
  107d65:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  107d69:	c1 e0 08             	shl    $0x8,%eax
  107d6c:	8b 51 28             	mov    0x28(%ecx),%edx
  107d6f:	c7 c1 a0 3d e0 00    	mov    $0xe03da0,%ecx
  107d75:	01 d0                	add    %edx,%eax
  107d77:	8b 04 81             	mov    (%ecx,%eax,4),%eax

    if (handler) {
  107d7a:	85 c0                	test   %eax,%eax
  107d7c:	74 62                	je     107de0 <trap+0xb0>
        handler(tf);
  107d7e:	83 ec 0c             	sub    $0xc,%esp
  107d81:	ff 74 24 3c          	push   0x3c(%esp)
  107d85:	ff d0                	call   *%eax
  107d87:	83 c4 10             	add    $0x10,%esp
    } else {
        KERN_WARN("No handler for user trap 0x%x, process %d, eip 0x%08x.\n",
                  tf->trapno, cur_pid, tf->eip);
    }
    
    if (last_pid != 0)
  107d8a:	85 ff                	test   %edi,%edi
  107d8c:	75 32                	jne    107dc0 <trap+0x90>
        kstack_switch(cur_pid);
        set_pdir_base(cur_pid);
        last_active[cpu_idx] = last_pid;
    }

    trap_return((void *) tf);
  107d8e:	83 ec 0c             	sub    $0xc,%esp
  107d91:	ff 74 24 3c          	push   0x3c(%esp)
  107d95:	e8 a6 a4 ff ff       	call   102240 <trap_return>
}
  107d9a:	83 c4 2c             	add    $0x2c,%esp
  107d9d:	5b                   	pop    %ebx
  107d9e:	5e                   	pop    %esi
  107d9f:	5f                   	pop    %edi
  107da0:	5d                   	pop    %ebp
  107da1:	c3                   	ret    
  107da2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        set_pdir_base(0);  // switch to the kernel's page table
  107da8:	83 ec 0c             	sub    $0xc,%esp
  107dab:	6a 00                	push   $0x0
  107dad:	e8 7e e8 ff ff       	call   106630 <set_pdir_base>
        last_active[cpu_idx] = 0;
  107db2:	c7 44 b5 00 00 00 00 	movl   $0x0,0x0(%ebp,%esi,4)
  107db9:	00 
  107dba:	83 c4 10             	add    $0x10,%esp
  107dbd:	eb a1                	jmp    107d60 <trap+0x30>
  107dbf:	90                   	nop
        kstack_switch(cur_pid);
  107dc0:	83 ec 0c             	sub    $0xc,%esp
  107dc3:	ff 74 24 18          	push   0x18(%esp)
  107dc7:	e8 84 ca ff ff       	call   104850 <kstack_switch>
        set_pdir_base(cur_pid);
  107dcc:	58                   	pop    %eax
  107dcd:	ff 74 24 18          	push   0x18(%esp)
  107dd1:	e8 5a e8 ff ff       	call   106630 <set_pdir_base>
        last_active[cpu_idx] = last_pid;
  107dd6:	89 7c b5 00          	mov    %edi,0x0(%ebp,%esi,4)
  107dda:	83 c4 10             	add    $0x10,%esp
  107ddd:	eb af                	jmp    107d8e <trap+0x5e>
  107ddf:	90                   	nop
        KERN_WARN("No handler for user trap 0x%x, process %d, eip 0x%08x.\n",
  107de0:	83 ec 08             	sub    $0x8,%esp
  107de3:	8b 44 24 38          	mov    0x38(%esp),%eax
  107de7:	ff 70 30             	push   0x30(%eax)
  107dea:	8d 83 4c aa ff ff    	lea    -0x55b4(%ebx),%eax
  107df0:	ff 74 24 18          	push   0x18(%esp)
  107df4:	52                   	push   %edx
  107df5:	50                   	push   %eax
  107df6:	8d 83 b8 a9 ff ff    	lea    -0x5648(%ebx),%eax
  107dfc:	68 92 00 00 00       	push   $0x92
  107e01:	50                   	push   %eax
  107e02:	e8 f9 c2 ff ff       	call   104100 <debug_warn>
  107e07:	83 c4 20             	add    $0x20,%esp
  107e0a:	e9 7b ff ff ff       	jmp    107d8a <trap+0x5a>
  107e0f:	90                   	nop

00107e10 <trap_init_array>:
int inited = FALSE;

trap_cb_t TRAP_HANDLER[NUM_CPUS][256];

void trap_init_array(void)
{
  107e10:	53                   	push   %ebx
  107e11:	e8 73 85 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107e16:	81 c3 ea 81 00 00    	add    $0x81ea,%ebx
  107e1c:	83 ec 08             	sub    $0x8,%esp
    KERN_ASSERT(inited == FALSE);
  107e1f:	8b 83 a0 5d cf 00    	mov    0xcf5da0(%ebx),%eax
  107e25:	85 c0                	test   %eax,%eax
  107e27:	75 27                	jne    107e50 <trap_init_array+0x40>
    memzero(&TRAP_HANDLER, sizeof(trap_cb_t) * 8 * 256);
  107e29:	83 ec 08             	sub    $0x8,%esp
  107e2c:	8d 83 a0 3d cf 00    	lea    0xcf3da0(%ebx),%eax
  107e32:	68 00 20 00 00       	push   $0x2000
  107e37:	50                   	push   %eax
  107e38:	e8 f3 c0 ff ff       	call   103f30 <memzero>
    inited = TRUE;
  107e3d:	c7 83 a0 5d cf 00 01 	movl   $0x1,0xcf5da0(%ebx)
  107e44:	00 00 00 
}
  107e47:	83 c4 18             	add    $0x18,%esp
  107e4a:	5b                   	pop    %ebx
  107e4b:	c3                   	ret    
  107e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    KERN_ASSERT(inited == FALSE);
  107e50:	8d 83 84 aa ff ff    	lea    -0x557c(%ebx),%eax
  107e56:	50                   	push   %eax
  107e57:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  107e5d:	50                   	push   %eax
  107e5e:	8d 83 fc aa ff ff    	lea    -0x5504(%ebx),%eax
  107e64:	6a 11                	push   $0x11
  107e66:	50                   	push   %eax
  107e67:	e8 c4 c1 ff ff       	call   104030 <debug_panic>
  107e6c:	83 c4 10             	add    $0x10,%esp
  107e6f:	eb b8                	jmp    107e29 <trap_init_array+0x19>
  107e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107e78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107e7f:	90                   	nop

00107e80 <trap_handler_register>:

void trap_handler_register(int cpu_idx, int trapno, trap_cb_t cb)
{
  107e80:	55                   	push   %ebp
  107e81:	57                   	push   %edi
  107e82:	56                   	push   %esi
  107e83:	53                   	push   %ebx
  107e84:	e8 00 85 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107e89:	81 c3 77 81 00 00    	add    $0x8177,%ebx
  107e8f:	83 ec 0c             	sub    $0xc,%esp
  107e92:	8b 74 24 20          	mov    0x20(%esp),%esi
  107e96:	8b 6c 24 24          	mov    0x24(%esp),%ebp
  107e9a:	8b 7c 24 28          	mov    0x28(%esp),%edi
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  107e9e:	83 fe 07             	cmp    $0x7,%esi
  107ea1:	77 25                	ja     107ec8 <trap_handler_register+0x48>
    KERN_ASSERT(0 <= trapno && trapno < 256);
  107ea3:	81 fd ff 00 00 00    	cmp    $0xff,%ebp
  107ea9:	77 44                	ja     107eef <trap_handler_register+0x6f>
    KERN_ASSERT(cb != NULL);
  107eab:	85 ff                	test   %edi,%edi
  107ead:	74 63                	je     107f12 <trap_handler_register+0x92>

    TRAP_HANDLER[cpu_idx][trapno] = cb;
  107eaf:	c1 e6 08             	shl    $0x8,%esi
  107eb2:	01 ee                	add    %ebp,%esi
  107eb4:	89 bc b3 a0 3d cf 00 	mov    %edi,0xcf3da0(%ebx,%esi,4)
}
  107ebb:	83 c4 0c             	add    $0xc,%esp
  107ebe:	5b                   	pop    %ebx
  107ebf:	5e                   	pop    %esi
  107ec0:	5f                   	pop    %edi
  107ec1:	5d                   	pop    %ebp
  107ec2:	c3                   	ret    
  107ec3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  107ec7:	90                   	nop
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  107ec8:	8d 83 94 aa ff ff    	lea    -0x556c(%ebx),%eax
  107ece:	50                   	push   %eax
  107ecf:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  107ed5:	50                   	push   %eax
  107ed6:	8d 83 fc aa ff ff    	lea    -0x5504(%ebx),%eax
  107edc:	6a 18                	push   $0x18
  107ede:	50                   	push   %eax
  107edf:	e8 4c c1 ff ff       	call   104030 <debug_panic>
  107ee4:	83 c4 10             	add    $0x10,%esp
    KERN_ASSERT(0 <= trapno && trapno < 256);
  107ee7:	81 fd ff 00 00 00    	cmp    $0xff,%ebp
  107eed:	76 bc                	jbe    107eab <trap_handler_register+0x2b>
  107eef:	8d 83 b0 aa ff ff    	lea    -0x5550(%ebx),%eax
  107ef5:	50                   	push   %eax
  107ef6:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  107efc:	50                   	push   %eax
  107efd:	8d 83 fc aa ff ff    	lea    -0x5504(%ebx),%eax
  107f03:	6a 19                	push   $0x19
  107f05:	50                   	push   %eax
  107f06:	e8 25 c1 ff ff       	call   104030 <debug_panic>
  107f0b:	83 c4 10             	add    $0x10,%esp
    KERN_ASSERT(cb != NULL);
  107f0e:	85 ff                	test   %edi,%edi
  107f10:	75 9d                	jne    107eaf <trap_handler_register+0x2f>
  107f12:	8d 83 cc aa ff ff    	lea    -0x5534(%ebx),%eax
  107f18:	50                   	push   %eax
  107f19:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  107f1f:	50                   	push   %eax
  107f20:	8d 83 fc aa ff ff    	lea    -0x5504(%ebx),%eax
  107f26:	6a 1a                	push   $0x1a
  107f28:	50                   	push   %eax
  107f29:	e8 02 c1 ff ff       	call   104030 <debug_panic>
  107f2e:	83 c4 10             	add    $0x10,%esp
  107f31:	e9 79 ff ff ff       	jmp    107eaf <trap_handler_register+0x2f>
  107f36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  107f3d:	8d 76 00             	lea    0x0(%esi),%esi

00107f40 <trap_init>:

void trap_init(unsigned int cpu_idx)
{
  107f40:	57                   	push   %edi
  107f41:	56                   	push   %esi
  107f42:	53                   	push   %ebx
  107f43:	8b 74 24 10          	mov    0x10(%esp),%esi
  107f47:	e8 3d 84 ff ff       	call   100389 <__x86.get_pc_thunk.bx>
  107f4c:	81 c3 b4 80 00 00    	add    $0x80b4,%ebx
    if (cpu_idx == 0) {
  107f52:	85 f6                	test   %esi,%esi
  107f54:	74 62                	je     107fb8 <trap_init+0x78>
        trap_init_array();
    }

    KERN_INFO_CPU("Register trap handlers...\n", cpu_idx);
  107f56:	83 ec 08             	sub    $0x8,%esp
  107f59:	8d 83 68 ab ff ff    	lea    -0x5498(%ebx),%eax

    // TODO: for CPU # [cpu_idx], register appropriate trap handler for each trap number,
    // with trap_handler_register function defined above.

    KERN_INFO_CPU("Done.\n", cpu_idx);
  107f5f:	8d bb e9 aa ff ff    	lea    -0x5517(%ebx),%edi
    KERN_INFO_CPU("Register trap handlers...\n", cpu_idx);
  107f65:	56                   	push   %esi
  107f66:	50                   	push   %eax
  107f67:	e8 54 c0 ff ff       	call   103fc0 <debug_info>
    KERN_INFO_CPU("Done.\n", cpu_idx);
  107f6c:	58                   	pop    %eax
  107f6d:	5a                   	pop    %edx
  107f6e:	56                   	push   %esi
  107f6f:	57                   	push   %edi
  107f70:	e8 4b c0 ff ff       	call   103fc0 <debug_info>
    KERN_INFO_CPU("Enabling interrupts...\n", cpu_idx);
  107f75:	59                   	pop    %ecx
  107f76:	58                   	pop    %eax
  107f77:	8d 83 90 ab ff ff    	lea    -0x5470(%ebx),%eax
  107f7d:	56                   	push   %esi
  107f7e:	50                   	push   %eax
  107f7f:	e8 3c c0 ff ff       	call   103fc0 <debug_info>

    /* enable interrupts */
    intr_enable(IRQ_TIMER, cpu_idx);
  107f84:	58                   	pop    %eax
  107f85:	5a                   	pop    %edx
  107f86:	56                   	push   %esi
  107f87:	6a 00                	push   $0x0
  107f89:	e8 32 98 ff ff       	call   1017c0 <intr_enable>
    intr_enable(IRQ_KBD, cpu_idx);
  107f8e:	59                   	pop    %ecx
  107f8f:	58                   	pop    %eax
  107f90:	56                   	push   %esi
  107f91:	6a 01                	push   $0x1
  107f93:	e8 28 98 ff ff       	call   1017c0 <intr_enable>
    intr_enable(IRQ_SERIAL13, cpu_idx);
  107f98:	58                   	pop    %eax
  107f99:	5a                   	pop    %edx
  107f9a:	56                   	push   %esi
  107f9b:	6a 04                	push   $0x4
  107f9d:	e8 1e 98 ff ff       	call   1017c0 <intr_enable>

    KERN_INFO_CPU("Done.\n", cpu_idx);
  107fa2:	59                   	pop    %ecx
  107fa3:	58                   	pop    %eax
  107fa4:	56                   	push   %esi
  107fa5:	57                   	push   %edi
  107fa6:	e8 15 c0 ff ff       	call   103fc0 <debug_info>
  107fab:	83 c4 10             	add    $0x10,%esp
}
  107fae:	5b                   	pop    %ebx
  107faf:	5e                   	pop    %esi
  107fb0:	5f                   	pop    %edi
  107fb1:	c3                   	ret    
  107fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    KERN_ASSERT(inited == FALSE);
  107fb8:	8b 8b a0 5d cf 00    	mov    0xcf5da0(%ebx),%ecx
  107fbe:	85 c9                	test   %ecx,%ecx
  107fc0:	75 7e                	jne    108040 <trap_init+0x100>
    memzero(&TRAP_HANDLER, sizeof(trap_cb_t) * 8 * 256);
  107fc2:	83 ec 08             	sub    $0x8,%esp
  107fc5:	8d 83 a0 3d cf 00    	lea    0xcf3da0(%ebx),%eax
    KERN_INFO_CPU("Done.\n", cpu_idx);
  107fcb:	8d b3 d7 aa ff ff    	lea    -0x5529(%ebx),%esi
    memzero(&TRAP_HANDLER, sizeof(trap_cb_t) * 8 * 256);
  107fd1:	68 00 20 00 00       	push   $0x2000
  107fd6:	50                   	push   %eax
  107fd7:	e8 54 bf ff ff       	call   103f30 <memzero>
    KERN_INFO_CPU("Register trap handlers...\n", cpu_idx);
  107fdc:	8d 83 1c ab ff ff    	lea    -0x54e4(%ebx),%eax
    inited = TRUE;
  107fe2:	c7 83 a0 5d cf 00 01 	movl   $0x1,0xcf5da0(%ebx)
  107fe9:	00 00 00 
    KERN_INFO_CPU("Register trap handlers...\n", cpu_idx);
  107fec:	89 04 24             	mov    %eax,(%esp)
  107fef:	e8 cc bf ff ff       	call   103fc0 <debug_info>
    KERN_INFO_CPU("Done.\n", cpu_idx);
  107ff4:	89 34 24             	mov    %esi,(%esp)
  107ff7:	e8 c4 bf ff ff       	call   103fc0 <debug_info>
    KERN_INFO_CPU("Enabling interrupts...\n", cpu_idx);
  107ffc:	8d 83 44 ab ff ff    	lea    -0x54bc(%ebx),%eax
  108002:	89 04 24             	mov    %eax,(%esp)
  108005:	e8 b6 bf ff ff       	call   103fc0 <debug_info>
    intr_enable(IRQ_TIMER, cpu_idx);
  10800a:	58                   	pop    %eax
  10800b:	5a                   	pop    %edx
  10800c:	6a 00                	push   $0x0
  10800e:	6a 00                	push   $0x0
  108010:	e8 ab 97 ff ff       	call   1017c0 <intr_enable>
    intr_enable(IRQ_KBD, cpu_idx);
  108015:	59                   	pop    %ecx
  108016:	5f                   	pop    %edi
  108017:	6a 00                	push   $0x0
  108019:	6a 01                	push   $0x1
  10801b:	e8 a0 97 ff ff       	call   1017c0 <intr_enable>
    intr_enable(IRQ_SERIAL13, cpu_idx);
  108020:	58                   	pop    %eax
  108021:	5a                   	pop    %edx
  108022:	6a 00                	push   $0x0
  108024:	6a 04                	push   $0x4
  108026:	e8 95 97 ff ff       	call   1017c0 <intr_enable>
    KERN_INFO_CPU("Done.\n", cpu_idx);
  10802b:	89 34 24             	mov    %esi,(%esp)
  10802e:	e8 8d bf ff ff       	call   103fc0 <debug_info>
  108033:	83 c4 10             	add    $0x10,%esp
}
  108036:	5b                   	pop    %ebx
  108037:	5e                   	pop    %esi
  108038:	5f                   	pop    %edi
  108039:	c3                   	ret    
  10803a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    KERN_ASSERT(inited == FALSE);
  108040:	8d 83 84 aa ff ff    	lea    -0x557c(%ebx),%eax
  108046:	50                   	push   %eax
  108047:	8d 83 bf 92 ff ff    	lea    -0x6d41(%ebx),%eax
  10804d:	50                   	push   %eax
  10804e:	8d 83 fc aa ff ff    	lea    -0x5504(%ebx),%eax
  108054:	6a 11                	push   $0x11
  108056:	50                   	push   %eax
  108057:	e8 d4 bf ff ff       	call   104030 <debug_panic>
  10805c:	83 c4 10             	add    $0x10,%esp
  10805f:	e9 5e ff ff ff       	jmp    107fc2 <trap_init+0x82>
  108064:	66 90                	xchg   %ax,%ax
  108066:	66 90                	xchg   %ax,%ax
  108068:	66 90                	xchg   %ax,%ax
  10806a:	66 90                	xchg   %ax,%ax
  10806c:	66 90                	xchg   %ax,%ax
  10806e:	66 90                	xchg   %ax,%ax

00108070 <__udivdi3>:
  108070:	f3 0f 1e fb          	endbr32 
  108074:	55                   	push   %ebp
  108075:	57                   	push   %edi
  108076:	56                   	push   %esi
  108077:	53                   	push   %ebx
  108078:	83 ec 1c             	sub    $0x1c,%esp
  10807b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  10807f:	8b 6c 24 30          	mov    0x30(%esp),%ebp
  108083:	8b 74 24 34          	mov    0x34(%esp),%esi
  108087:	8b 5c 24 38          	mov    0x38(%esp),%ebx
  10808b:	85 c0                	test   %eax,%eax
  10808d:	75 19                	jne    1080a8 <__udivdi3+0x38>
  10808f:	39 f3                	cmp    %esi,%ebx
  108091:	76 4d                	jbe    1080e0 <__udivdi3+0x70>
  108093:	31 ff                	xor    %edi,%edi
  108095:	89 e8                	mov    %ebp,%eax
  108097:	89 f2                	mov    %esi,%edx
  108099:	f7 f3                	div    %ebx
  10809b:	89 fa                	mov    %edi,%edx
  10809d:	83 c4 1c             	add    $0x1c,%esp
  1080a0:	5b                   	pop    %ebx
  1080a1:	5e                   	pop    %esi
  1080a2:	5f                   	pop    %edi
  1080a3:	5d                   	pop    %ebp
  1080a4:	c3                   	ret    
  1080a5:	8d 76 00             	lea    0x0(%esi),%esi
  1080a8:	39 f0                	cmp    %esi,%eax
  1080aa:	76 14                	jbe    1080c0 <__udivdi3+0x50>
  1080ac:	31 ff                	xor    %edi,%edi
  1080ae:	31 c0                	xor    %eax,%eax
  1080b0:	89 fa                	mov    %edi,%edx
  1080b2:	83 c4 1c             	add    $0x1c,%esp
  1080b5:	5b                   	pop    %ebx
  1080b6:	5e                   	pop    %esi
  1080b7:	5f                   	pop    %edi
  1080b8:	5d                   	pop    %ebp
  1080b9:	c3                   	ret    
  1080ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1080c0:	0f bd f8             	bsr    %eax,%edi
  1080c3:	83 f7 1f             	xor    $0x1f,%edi
  1080c6:	75 48                	jne    108110 <__udivdi3+0xa0>
  1080c8:	39 f0                	cmp    %esi,%eax
  1080ca:	72 06                	jb     1080d2 <__udivdi3+0x62>
  1080cc:	31 c0                	xor    %eax,%eax
  1080ce:	39 eb                	cmp    %ebp,%ebx
  1080d0:	77 de                	ja     1080b0 <__udivdi3+0x40>
  1080d2:	b8 01 00 00 00       	mov    $0x1,%eax
  1080d7:	eb d7                	jmp    1080b0 <__udivdi3+0x40>
  1080d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1080e0:	89 d9                	mov    %ebx,%ecx
  1080e2:	85 db                	test   %ebx,%ebx
  1080e4:	75 0b                	jne    1080f1 <__udivdi3+0x81>
  1080e6:	b8 01 00 00 00       	mov    $0x1,%eax
  1080eb:	31 d2                	xor    %edx,%edx
  1080ed:	f7 f3                	div    %ebx
  1080ef:	89 c1                	mov    %eax,%ecx
  1080f1:	31 d2                	xor    %edx,%edx
  1080f3:	89 f0                	mov    %esi,%eax
  1080f5:	f7 f1                	div    %ecx
  1080f7:	89 c6                	mov    %eax,%esi
  1080f9:	89 e8                	mov    %ebp,%eax
  1080fb:	89 f7                	mov    %esi,%edi
  1080fd:	f7 f1                	div    %ecx
  1080ff:	89 fa                	mov    %edi,%edx
  108101:	83 c4 1c             	add    $0x1c,%esp
  108104:	5b                   	pop    %ebx
  108105:	5e                   	pop    %esi
  108106:	5f                   	pop    %edi
  108107:	5d                   	pop    %ebp
  108108:	c3                   	ret    
  108109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  108110:	89 f9                	mov    %edi,%ecx
  108112:	ba 20 00 00 00       	mov    $0x20,%edx
  108117:	29 fa                	sub    %edi,%edx
  108119:	d3 e0                	shl    %cl,%eax
  10811b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10811f:	89 d1                	mov    %edx,%ecx
  108121:	89 d8                	mov    %ebx,%eax
  108123:	d3 e8                	shr    %cl,%eax
  108125:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  108129:	09 c1                	or     %eax,%ecx
  10812b:	89 f0                	mov    %esi,%eax
  10812d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  108131:	89 f9                	mov    %edi,%ecx
  108133:	d3 e3                	shl    %cl,%ebx
  108135:	89 d1                	mov    %edx,%ecx
  108137:	d3 e8                	shr    %cl,%eax
  108139:	89 f9                	mov    %edi,%ecx
  10813b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  10813f:	89 eb                	mov    %ebp,%ebx
  108141:	d3 e6                	shl    %cl,%esi
  108143:	89 d1                	mov    %edx,%ecx
  108145:	d3 eb                	shr    %cl,%ebx
  108147:	09 f3                	or     %esi,%ebx
  108149:	89 c6                	mov    %eax,%esi
  10814b:	89 f2                	mov    %esi,%edx
  10814d:	89 d8                	mov    %ebx,%eax
  10814f:	f7 74 24 08          	divl   0x8(%esp)
  108153:	89 d6                	mov    %edx,%esi
  108155:	89 c3                	mov    %eax,%ebx
  108157:	f7 64 24 0c          	mull   0xc(%esp)
  10815b:	39 d6                	cmp    %edx,%esi
  10815d:	72 19                	jb     108178 <__udivdi3+0x108>
  10815f:	89 f9                	mov    %edi,%ecx
  108161:	d3 e5                	shl    %cl,%ebp
  108163:	39 c5                	cmp    %eax,%ebp
  108165:	73 04                	jae    10816b <__udivdi3+0xfb>
  108167:	39 d6                	cmp    %edx,%esi
  108169:	74 0d                	je     108178 <__udivdi3+0x108>
  10816b:	89 d8                	mov    %ebx,%eax
  10816d:	31 ff                	xor    %edi,%edi
  10816f:	e9 3c ff ff ff       	jmp    1080b0 <__udivdi3+0x40>
  108174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  108178:	8d 43 ff             	lea    -0x1(%ebx),%eax
  10817b:	31 ff                	xor    %edi,%edi
  10817d:	e9 2e ff ff ff       	jmp    1080b0 <__udivdi3+0x40>
  108182:	66 90                	xchg   %ax,%ax
  108184:	66 90                	xchg   %ax,%ax
  108186:	66 90                	xchg   %ax,%ax
  108188:	66 90                	xchg   %ax,%ax
  10818a:	66 90                	xchg   %ax,%ax
  10818c:	66 90                	xchg   %ax,%ax
  10818e:	66 90                	xchg   %ax,%ax

00108190 <__umoddi3>:
  108190:	f3 0f 1e fb          	endbr32 
  108194:	55                   	push   %ebp
  108195:	57                   	push   %edi
  108196:	56                   	push   %esi
  108197:	53                   	push   %ebx
  108198:	83 ec 1c             	sub    $0x1c,%esp
  10819b:	8b 74 24 30          	mov    0x30(%esp),%esi
  10819f:	8b 5c 24 34          	mov    0x34(%esp),%ebx
  1081a3:	8b 7c 24 3c          	mov    0x3c(%esp),%edi
  1081a7:	8b 6c 24 38          	mov    0x38(%esp),%ebp
  1081ab:	89 f0                	mov    %esi,%eax
  1081ad:	89 da                	mov    %ebx,%edx
  1081af:	85 ff                	test   %edi,%edi
  1081b1:	75 15                	jne    1081c8 <__umoddi3+0x38>
  1081b3:	39 dd                	cmp    %ebx,%ebp
  1081b5:	76 39                	jbe    1081f0 <__umoddi3+0x60>
  1081b7:	f7 f5                	div    %ebp
  1081b9:	89 d0                	mov    %edx,%eax
  1081bb:	31 d2                	xor    %edx,%edx
  1081bd:	83 c4 1c             	add    $0x1c,%esp
  1081c0:	5b                   	pop    %ebx
  1081c1:	5e                   	pop    %esi
  1081c2:	5f                   	pop    %edi
  1081c3:	5d                   	pop    %ebp
  1081c4:	c3                   	ret    
  1081c5:	8d 76 00             	lea    0x0(%esi),%esi
  1081c8:	39 df                	cmp    %ebx,%edi
  1081ca:	77 f1                	ja     1081bd <__umoddi3+0x2d>
  1081cc:	0f bd cf             	bsr    %edi,%ecx
  1081cf:	83 f1 1f             	xor    $0x1f,%ecx
  1081d2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  1081d6:	75 40                	jne    108218 <__umoddi3+0x88>
  1081d8:	39 df                	cmp    %ebx,%edi
  1081da:	72 04                	jb     1081e0 <__umoddi3+0x50>
  1081dc:	39 f5                	cmp    %esi,%ebp
  1081de:	77 dd                	ja     1081bd <__umoddi3+0x2d>
  1081e0:	89 da                	mov    %ebx,%edx
  1081e2:	89 f0                	mov    %esi,%eax
  1081e4:	29 e8                	sub    %ebp,%eax
  1081e6:	19 fa                	sbb    %edi,%edx
  1081e8:	eb d3                	jmp    1081bd <__umoddi3+0x2d>
  1081ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1081f0:	89 e9                	mov    %ebp,%ecx
  1081f2:	85 ed                	test   %ebp,%ebp
  1081f4:	75 0b                	jne    108201 <__umoddi3+0x71>
  1081f6:	b8 01 00 00 00       	mov    $0x1,%eax
  1081fb:	31 d2                	xor    %edx,%edx
  1081fd:	f7 f5                	div    %ebp
  1081ff:	89 c1                	mov    %eax,%ecx
  108201:	89 d8                	mov    %ebx,%eax
  108203:	31 d2                	xor    %edx,%edx
  108205:	f7 f1                	div    %ecx
  108207:	89 f0                	mov    %esi,%eax
  108209:	f7 f1                	div    %ecx
  10820b:	89 d0                	mov    %edx,%eax
  10820d:	31 d2                	xor    %edx,%edx
  10820f:	eb ac                	jmp    1081bd <__umoddi3+0x2d>
  108211:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  108218:	8b 44 24 04          	mov    0x4(%esp),%eax
  10821c:	ba 20 00 00 00       	mov    $0x20,%edx
  108221:	29 c2                	sub    %eax,%edx
  108223:	89 c1                	mov    %eax,%ecx
  108225:	89 e8                	mov    %ebp,%eax
  108227:	d3 e7                	shl    %cl,%edi
  108229:	89 d1                	mov    %edx,%ecx
  10822b:	89 54 24 0c          	mov    %edx,0xc(%esp)
  10822f:	d3 e8                	shr    %cl,%eax
  108231:	89 c1                	mov    %eax,%ecx
  108233:	8b 44 24 04          	mov    0x4(%esp),%eax
  108237:	09 f9                	or     %edi,%ecx
  108239:	89 df                	mov    %ebx,%edi
  10823b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  10823f:	89 c1                	mov    %eax,%ecx
  108241:	d3 e5                	shl    %cl,%ebp
  108243:	89 d1                	mov    %edx,%ecx
  108245:	d3 ef                	shr    %cl,%edi
  108247:	89 c1                	mov    %eax,%ecx
  108249:	89 f0                	mov    %esi,%eax
  10824b:	d3 e3                	shl    %cl,%ebx
  10824d:	89 d1                	mov    %edx,%ecx
  10824f:	89 fa                	mov    %edi,%edx
  108251:	d3 e8                	shr    %cl,%eax
  108253:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
  108258:	09 d8                	or     %ebx,%eax
  10825a:	f7 74 24 08          	divl   0x8(%esp)
  10825e:	89 d3                	mov    %edx,%ebx
  108260:	d3 e6                	shl    %cl,%esi
  108262:	f7 e5                	mul    %ebp
  108264:	89 c7                	mov    %eax,%edi
  108266:	89 d1                	mov    %edx,%ecx
  108268:	39 d3                	cmp    %edx,%ebx
  10826a:	72 06                	jb     108272 <__umoddi3+0xe2>
  10826c:	75 0e                	jne    10827c <__umoddi3+0xec>
  10826e:	39 c6                	cmp    %eax,%esi
  108270:	73 0a                	jae    10827c <__umoddi3+0xec>
  108272:	29 e8                	sub    %ebp,%eax
  108274:	1b 54 24 08          	sbb    0x8(%esp),%edx
  108278:	89 d1                	mov    %edx,%ecx
  10827a:	89 c7                	mov    %eax,%edi
  10827c:	89 f5                	mov    %esi,%ebp
  10827e:	8b 74 24 04          	mov    0x4(%esp),%esi
  108282:	29 fd                	sub    %edi,%ebp
  108284:	19 cb                	sbb    %ecx,%ebx
  108286:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
  10828b:	89 d8                	mov    %ebx,%eax
  10828d:	d3 e0                	shl    %cl,%eax
  10828f:	89 f1                	mov    %esi,%ecx
  108291:	d3 ed                	shr    %cl,%ebp
  108293:	d3 eb                	shr    %cl,%ebx
  108295:	09 e8                	or     %ebp,%eax
  108297:	89 da                	mov    %ebx,%edx
  108299:	83 c4 1c             	add    $0x1c,%esp
  10829c:	5b                   	pop    %ebx
  10829d:	5e                   	pop    %esi
  10829e:	5f                   	pop    %edi
  10829f:	5d                   	pop    %ebp
  1082a0:	c3                   	ret    
