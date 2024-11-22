#ifndef _KERN_THREAD_PTCBINIT_H_
#define _KERN_THREAD_PTCBINIT_H_

#ifdef _KERN_

void paging_init(unsigned int mbi_addr);
void tcb_init_at_id(unsigned int pid);

#endif  /* _KERN_ */

#endif  /* !_KERN_THREAD_PTCBINIT_H_ */
