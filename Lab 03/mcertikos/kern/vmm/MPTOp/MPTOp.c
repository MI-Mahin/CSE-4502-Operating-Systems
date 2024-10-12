#include <lib/x86.h>

#include "import.h"

/**
 * Returns the page table entry corresponding to the virtual address,
 * according to the page structure of process # [proc_index].
 * Returns 0 if the mapping does not exist.
 */
unsigned int get_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    // TODO
    return 0;
}

// Returns the page directory entry corresponding to the given virtual address.
unsigned int get_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    // TODO
    return 0;
}

// Removes the page table entry for the given virtual address.
void rmv_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    // TODO
}

// Removes the page directory entry for the given virtual address.
void rmv_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    // TODO
}

// Maps the virtual address [vaddr] to the physical page # [page_index] with permission [perm].
// You do not need to worry about the page directory entry. just map the page table entry.
void set_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr,
                          unsigned int page_index, unsigned int perm)
{
    // TODO
}

// Registers the mapping from [vaddr] to physical page # [page_index] in the page directory.
void set_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr,
                          unsigned int page_index)
{
    // TODO
}

// Initializes the identity page table.
// The permission for the kernel memory should be PTE_P, PTE_W, and PTE_G,
// While the permission for the rest should be PTE_P and PTE_W.
void idptbl_init(unsigned int mbi_addr)
{
    // TODO: Define your local variables here.

    container_init(mbi_addr);

    // TODO
}
