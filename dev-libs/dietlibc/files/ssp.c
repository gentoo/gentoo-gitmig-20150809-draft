/*
 * Distributed under the terms of the GNU General Public License v2
 * $Header: /var/cvsroot/gentoo-x86/dev-libs/dietlibc/files/ssp.c,v 1.2 2004/12/05 19:25:40 solar Exp $
 *
 * This is a modified version of Hiroaki Etoh's stack smashing routines
 * implemented for glibc.
 *
 * The following people have contributed input to this code.
 * Ned Ludd - <solar[@]gentoo.org>
 * Alexander Gabert - <pappy[@]gentoo.org>
 * The PaX Team - <pageexec[@]freemail.hu>
 * Peter S. Mazinger - <ps.m[@]gmx.net>
 * Yoann Vandoorselaere - <yoann[@]prelude-ids.org>
 * Robert Connolly - <robert[@]linuxfromscratch.org>
 * Cory Visi <cory@visi.name>
 *
 */

#ifdef HAVE_CONFIG_H
# include <config.h>
#endif

#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <sys/time.h>

#ifdef __PROPOLICE_BLOCK_SEGV__
#define SSP_SIGTYPE SIGSEGV
#elif __PROPOLICE_BLOCK_KILL__
#define SSP_SIGTYPE SIGKILL
#else
#define SSP_SIGTYPE SIGABRT
#endif

unsigned long __guard = 0UL;

void
__guard_setup (void)
{
  size_t size;
  if (__guard != 0UL)
    return;

#ifndef __SSP_QUICK_CANARY__
  /* 
   * Attempt to open kernel pseudo random device if one exists before 
   * opening urandom to avoid system entropy depletion.
   */
  {
    int fd;
#ifdef HAVE_DEV_ERANDOM
    if ((fd = open ("/dev/erandom", O_RDONLY)) == (-1))
#endif
      fd = open ("/dev/urandom", O_RDONLY);
    if (fd != (-1))
      {
	size = read (fd, (char *) &__guard, sizeof (__guard));
	close (fd);
	if (size == sizeof (__guard))
	  return;
      }
  }
#endif

  /* If sysctl was unsuccessful, use the "terminator canary". */
  __guard = 0xFF0A0D00UL;

  {
    /* Everything failed? Or we are using a weakened model of the 
     * terminator canary */
    struct timeval tv;

    gettimeofday (&tv, NULL);
    __guard ^= tv.tv_usec ^ tv.tv_sec;
  }
}

void
__stack_smash_handler (char func[], int damaged)
{
  struct sigaction sa;
  const char message[] = ": stack smashing attack in function ";
  int bufsz, len;
  char buf[512];
  static char *__progname = "dietapp";

  sigset_t mask;
  sigfillset (&mask);

  sigdelset (&mask, SSP_SIGTYPE);	/* Block all signal handlers */
  sigprocmask (SIG_BLOCK, &mask, NULL);	/* except SIGABRT */

  bufsz = sizeof (buf);
  strcpy (buf, "<2>");
  len = 3;

  strncat (buf, __progname, sizeof (buf) - 4);
  len = strlen (buf);

  if (bufsz > len)
    {
      strncat (buf, message, bufsz - len - 1);
      len = strlen (buf);
    }
  if (bufsz > len)
    {
      strncat (buf, func, bufsz - len - 1);
      len = strlen (buf);
    }

  /* print error message */
  write (STDERR_FILENO, buf + 3, len - 3);
  write (STDERR_FILENO, "()\n", 3);

  /* Make sure the default handler is associated with the our signal handler */
  memset (&sa, 0, sizeof (struct sigaction));
  sigfillset (&sa.sa_mask);	/* Block all signals */
  sa.sa_flags = 0;
  sa.sa_handler = SIG_DFL;
  sigaction (SSP_SIGTYPE, &sa, NULL);
  (void) kill (getpid (), SSP_SIGTYPE);
  _exit (127);
}
