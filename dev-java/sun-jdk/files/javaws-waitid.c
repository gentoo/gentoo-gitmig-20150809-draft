/* Quick and dirty pre-loaded DSO to make buggy javawsbin
   in JDK 1.4.2_07 work on Linux with kernel 2.6.x and
   glibc 2.3.4.

    Compilation:
     gcc -O2 -fPIC -g0 -shared -o mywait.so mywait.c

    Usage (Bash):
     LD_PRELOAD=/path/to/mywait.so /path/to/javaws <Launcher URL>
	 
	
	 Taken from: http://www.advogato.org/person/rmathew/diary.html?start=71
   */
#include <dlfcn.h>
#include <sys/wait.h>

 int (*real_waitid)( idtype_t, id_t, siginfo_t *, int);

 int
waitid( idtype_t idtype, id_t id, siginfo_t *infop, int options)
{
  int retVal = -1;

   void *handle = dlopen( "/lib/libc.so.6", RTLD_LAZY);
  real_waitid = dlsym( handle, "waitid");

   options = (options == 0) ? WEXITED : options;
  retVal = (*real_waitid)( idtype, id, infop, options);

   dlclose( handle);

   return retVal;
} /* End pseudo-waitid() */
