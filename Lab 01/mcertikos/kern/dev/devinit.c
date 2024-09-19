#include <lib/x86.h>
#include <lib/types.h>
#include <lib/debug.h>
#include <lib/seg.h>

#include "console.h"
#include "mboot.h"

void devinit(uintptr_t mbi_addr)
{
    seg_init();

    enable_sse();

    cons_init();
    KERN_DEBUG("cons initialized.\n");
    KERN_DEBUG("devinit mbi_addr: %d\n", mbi_addr);

    pmmap_init(mbi_addr);
}
