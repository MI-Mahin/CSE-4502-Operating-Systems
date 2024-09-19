#include <lib/gcc.h>

// Number of physical pages that are actually available in the machine.
static unsigned int NUM_PAGES;

/**
 * Structure representing information for one physical page.
 */
struct ATStruct {
    /**
     * The permission of the page.
     * 0: Reserved by the BIOS.
     * 1: Kernel only.
     * >1: Normal (available).
     */
    unsigned int perm;
    /**
     * Whether the page is allocated.
     * 0: unallocated
     * >0: allocated
     */
    unsigned int allocated;
};

/**
 * A 32 bit machine may have up to 4GB of memory.
 * So it may have up to 2^20 physical pages,
 * with the page size being 4KB.
 */
static struct ATStruct AT[1 << 20];

// The getter function for NUM_PAGES.
unsigned int get_nps(void)
{
    return NUM_PAGES;
}

// The setter function for NUM_PAGES.
void set_nps(unsigned int nps)
{
    NUM_PAGES = nps;
}

/**
 * The getter function for the page permission.
 * If the page with the given index has the normal permission,
 * then returns 1, otherwise returns 0.
 */
unsigned int at_is_norm(unsigned int page_index)
{
    // TODO
    return 0;
}

/**
 * The setter function for the physical page permission.
 * Sets the permission of the page with given index.
 * It also marks the page as unallocated.
 */
void at_set_perm(unsigned int page_index, unsigned int perm)
{
    // TODO
}

/**
 * The getter function for the physical page allocation flag.
 * Returns 0 if the page is not allocated, otherwise returns 1.
 */
unsigned int at_is_allocated(unsigned int page_index)
{
    // TODO
    return 0;
}

/**
 * The setter function for the physical page allocation flag.
 * Set the flag of the page with given index to the given value.
 */
void at_set_allocated(unsigned int page_index, unsigned int allocated)
{
    // TODO
}
