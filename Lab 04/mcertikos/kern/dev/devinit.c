#include <lib/x86.h>
#include <lib/types.h>
#include <lib/debug.h>
#include <lib/seg.h>
#include <pcpu/PCPUInit/export.h>
#include <lib/kstack.h>
#include <lib/trap.h>
#include <vmm/MPTInit/export.h>

#include "console.h"
#include "mboot.h"
#include "intr.h"
#include "tsc.h"

void intr_init(void);

void devinit(uintptr_t mbi_addr)
{
    seg_init(0);

    enable_sse();

    cons_init();

    debug_init();
    KERN_INFO("[BSP KERN] cons initialized.\n");
    KERN_INFO("[BSP KERN] devinit mbi_addr: %d\n", mbi_addr);

    /* pcpu init codes */
    pcpu_init();
    KERN_INFO("[BSP KERN] PCPU initialized\n");

    tsc_init();
    KERN_INFO("[BSP KERN] TSC initialized\n");

    intr_init();
    KERN_INFO("[BSP KERN] INTR initialized\n");

    trap_init(0);

    pmmap_init(mbi_addr);
}

void devinit_ap(void)
{
    /* Figure out the current (booting) kernel stack) */
    struct kstack *ks = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);

    KERN_ASSERT(ks != NULL);
    KERN_ASSERT(1 <= ks->cpu_idx && ks->cpu_idx < 8);

    /* kernel stack for this cpu initialized */
    seg_init(ks->cpu_idx);

    pcpu_init();
    KERN_INFO("[AP%d KERN] PCPU initialized\n", ks->cpu_idx);

    intr_init();
    KERN_INFO("[AP%d KERN] INTR initialized.\n", ks->cpu_idx);

    trap_init(ks->cpu_idx);

    paging_init_ap();
}
