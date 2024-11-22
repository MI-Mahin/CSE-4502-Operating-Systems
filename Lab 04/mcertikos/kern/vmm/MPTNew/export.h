#ifndef _KERN_VMM_MPTNEW_H_
#define _KERN_VMM_MPTNEW_H_

#ifdef _KERN_

unsigned int alloc_page(unsigned int proc_index, unsigned int vaddr,
                        unsigned int perm);
unsigned int alloc_mem_quota(unsigned int id, unsigned int quota);

#endif  /* _KERN_ */

#endif  /* !_KERN_VMM_MPTNEW_H_ */
