#ifndef _USER_SYSCALL_H_
#define _USER_SYSCALL_H_

#include <lib/syscall.h>

#include <debug.h>
#include <gcc.h>
#include <proc.h>
#include <types.h>
#include <x86.h>

static gcc_inline void sys_puts(const char *s, size_t len)
{
    asm volatile ("int %0"
                  :: "i" (T_SYSCALL),
                     "a" (SYS_puts),
                     "b" (s),
                     "c" (len)
                  : "cc", "memory");
}

static gcc_inline pid_t sys_spawn(unsigned int elf_id, unsigned int quota)
{
    int errno;
    pid_t pid;

    asm volatile ("int %2"
                  : "=a" (errno), "=b" (pid)
                  : "i" (T_SYSCALL),
                    "a" (SYS_spawn),
                    "b" (elf_id),
                    "c" (quota)
                  : "cc", "memory");

    return errno ? -1 : pid;
}

static gcc_inline void sys_yield(void)
{
    asm volatile ("int %0"
                  :: "i" (T_SYSCALL),
                     "a" (SYS_yield)
                  : "cc", "memory");
}

static gcc_inline pid_t sys_fork(void)
{
    int errno;
    pid_t pid;

    asm volatile ("int %2"
                  : "=a" (errno), "=b" (pid)
                  : "i" (T_SYSCALL),
                    "a" (SYS_fork)
                  : "cc", "memory");

    return pid;
}

#endif  /* !_USER_SYSCALL_H_ */
