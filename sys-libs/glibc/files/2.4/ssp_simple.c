/*
 * Just do:
 * # gcc -fno-stack-protector -s -shared -fPIC ssp_simple.c -o /lib/libssp_simple.so
 * # echo '/lib/libssp_simple.so' > /etc/ld.so.preload
 * # emerge glibc
 * # rm -f /lib/libssp_simple.so /etc/ld.so.preload
 */

#include <syslog.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/param.h>
#include <sys/sysctl.h>

unsigned long __guard = 0UL; static void __guard_setup(void) __attribute__ ((constructor));
void __stack_smash_handler(char func[], int damaged __attribute__ ((unused)));
static void __guard_setup(void) { if (__guard != 0UL) return; __guard = 0xFF0A0D00UL; }

void __stack_smash_handler(char func[], int damaged) { 
	syslog(LOG_CRIT, "stack overflow in function %s(); %s=%p __guard_setup=%p __guard=%p " \
		"PPID=%d PID=%d UID=%d EUID=%d GID=%d EGID=%d", 
		func, func, __guard_setup, __guard,
		getppid(), getpid(), getuid(), geteuid(), getgid(), getegid());
	_exit(127);
}
