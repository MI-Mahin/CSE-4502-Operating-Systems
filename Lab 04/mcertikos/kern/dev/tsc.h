#ifndef _KERN_DEV_TSC_H_
#define _KERN_DEV_TSC_H_

#ifdef _KERN_

#include <lib/types.h>

extern volatile uint64_t tsc_per_ms;  /* TSC ticks per millisecond */

int tsc_init(void);
void delay(uint32_t ms);
void udelay(uint32_t us);

#endif  /* _KERN_ */

#endif  /* !_KERN_DEV_TSC_H_ */
