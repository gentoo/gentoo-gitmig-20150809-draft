/*
 * This program manages various PaX related flags for ELF and a.out binaries.
 * The flags only have effect when running the patched Linux kernel.
 *
 * Written by Solar Designer and placed in the public domain.
 *
 * Adapted to PaX by the PaX Team
 * 
 * Nov 10 2002 : Added multi{options,files} cmdline, zeroflag, nicer output 
 * (+ double output if flags are changed and -v is specified), more error 
 * handling.
 *
 * Dec 11 2002 : Explicit error messages and return value, even more
 * error handling . (-jv)
 *
 */
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <linux/elf.h>
#include <linux/a.out.h>

#define HF_PAX_PAGEEXEC         1    /* 0: Paging based non-exec pages */
#define HF_PAX_EMUTRAMP         2    /* 0: Emulate trampolines */
#define HF_PAX_MPROTECT         4    /* 0: Restrict mprotect() */
#define HF_PAX_RANDMMAP         8    /* 0: Randomize mmap() base */
#define HF_PAX_RANDEXEC         16   /* 1: Randomize ET_EXEC base */
#define HF_PAX_SEGMEXEC         32   /* 0: Segmentation based non-exec pages */

#define	XCLOSE(fd)		\
do				\
{				\
 if (close(fd))			\
   perror("close");		\
}				\
while (0)

static struct elf32_hdr	header_elf;
static struct exec	header_aout;
static void		*header;
static int		header_size;
static int		fd;

static unsigned long	(*get_flags)();
static void		(*put_flags)(unsigned long);


static void		print_flags(unsigned long flags)
{
  printf(" * Paging based PAGE_EXEC       : %s \n"
	 " * Trampolines                  : %s \n"
	 " * mprotect()                   : %s \n"
	 " * mmap() base                  : %s \n"
	 " * ET_EXEC base                 : %s \n"
	 " * Segmentation based PAGE_EXEC : %s \n",
	 flags & HF_PAX_PAGEEXEC
	 ? "disabled" : flags & HF_PAX_SEGMEXEC ? "enabled" : "enabled (overridden)",
	 flags & HF_PAX_EMUTRAMP
	 ? "emulated" : "not emulated",
	 flags & HF_PAX_MPROTECT
	 ? "not restricted" : "restricted",
	 flags & HF_PAX_RANDMMAP
	 ? "not randomized" : "randomized",
	 flags & HF_PAX_RANDEXEC
	 ? "randomized" : "not randomized",
	 flags & HF_PAX_SEGMEXEC
	 ? "disabled" : "enabled");
}

static unsigned long	get_flags_elf()
{
  return (header_elf.e_flags);
}

static void		put_flags_elf(unsigned long flags)
{
  header_elf.e_flags = flags;
}

static unsigned long	get_flags_aout()
{
  return (N_FLAGS(header_aout));
}

static void		put_flags_aout(unsigned long flags)
{
  N_SET_FLAGS(header_aout, flags & ~HF_PAX_RANDMMAP);
}

static int		read_header(char *name, int mode)
{
  char			*ptr;
  int			size;
  int			block;

  if ((fd = open(name, mode)) < 0)
    return 1;

  ptr = (char *) &header_elf;
  size = sizeof (header_elf);

  do
    {
      block = read(fd, ptr, size);
      if (block <= 0)
	return (block ? 1 : 2);
      ptr += block; size -= block;
    }
  while (size > 0);

  memcpy(&header_aout, &header_elf, sizeof(header_aout));

  if (!strncmp(header_elf.e_ident, ELFMAG, SELFMAG))
    {
      if (header_elf.e_type != ET_EXEC && header_elf.e_type != ET_DYN)
	return 2;
      if (header_elf.e_machine != EM_386)
	return 3;
      header = &header_elf;
      header_size = sizeof(header_elf);
      get_flags = get_flags_elf;
      put_flags = put_flags_elf;
    }

  else if (N_MAGIC(header_aout) == NMAGIC ||
	   N_MAGIC(header_aout) == ZMAGIC ||
	   N_MAGIC(header_aout) == QMAGIC)
    {
      if (N_MACHTYPE(header_aout) != M_386)
	return 3;
      header = &header_aout;
      header_size = 4;
      get_flags = get_flags_aout; 
      put_flags = put_flags_aout;
    }

  else
    return (2);

  return (0);
}

int	write_header()
{
  char	*ptr;
  int	size;
  int	block;

  if (lseek(fd, 0, SEEK_SET))
    return 1;

  ptr = (char *) header;
  size = header_size;

  do
    {
      block = write(fd, ptr, size);
      if (block <= 0)
	break;
      ptr += block;
      size -= block;
    }
  while (size > 0);

  return size;
}


#define USAGE \
"Usage: %s OPTIONS FILE1 FILE2 FILEN ...\n" \
"Manage PaX flags for binaries\n\n" \
"  -P\tenforce paging based non-executable pages\n" \
"  -p\tdo not enforce paging based non-executable pages\n" \
"  -E\temulate trampolines\n" \
"  -e\tdo not emulate trampolines\n" \
"  -M\trestrict mprotect()\n" \
"  -m\tdo not restrict mprotect()\n" \
"  -R\trandomize mmap() base [ELF only]\n" \
"  -r\tdo not randomize mmap() base [ELF only]\n" \
"  -X\trandomize ET_EXEC base [ELF only]\n" \
"  -x\tdo not randomize ET_EXEC base [ELF only]\n" \
"  -S\tenforce segmentation based non-executable pages\n" \
"  -s\tdo not enforce segmentation based non-executable pages\n" \
"  -v\tview current flag mask \n" \
"  -z\tzero flag mask (next flags still apply)\n\n" \
"The flags only have effect when running the patched Linux kernel.\n"


void	usage(char *name)
{
  printf(USAGE, (name ? name : "chpax"));
  exit(1);
}

unsigned long	   scan_flags(unsigned long flags, char **argv, int *view)
{
  int		   index;

  for (index = 1; argv[1][index]; index++)
    switch (argv[1][index])
      {

      case 'p':
	flags |= HF_PAX_PAGEEXEC;
	continue ;

      case 'P':
	flags = (flags & ~HF_PAX_PAGEEXEC) | HF_PAX_SEGMEXEC;
	continue ;

      case 'E':
	flags |= HF_PAX_EMUTRAMP;
	continue ;

      case 'e':
	flags = (flags & ~HF_PAX_EMUTRAMP);
	continue ;

      case 'm':
	flags |= HF_PAX_MPROTECT;
	continue ;

      case 'M':
	flags = (flags & ~HF_PAX_MPROTECT);
	continue ;

      case 'r':
	flags |= HF_PAX_RANDMMAP;
	continue ;

      case 'R':
	flags = (flags & ~HF_PAX_RANDMMAP);
	continue ;

      case 'X':
	flags |= HF_PAX_RANDEXEC;
	continue ;

      case 'x':
	flags = (flags & ~HF_PAX_RANDEXEC);
	continue ;

      case 's':
	flags |= HF_PAX_SEGMEXEC;
	continue ;

      case 'S':
	flags = (flags & ~HF_PAX_SEGMEXEC) | HF_PAX_PAGEEXEC;
	continue ;

      case 'v':
	*view = 1;
	continue ;

      case 'z':
	flags = 0;
	continue ;

      default:
	fprintf(stderr, "Unknown option %c \n", argv[1][index]);
	usage(argv[0]);
      }

  return (flags);
}


int		main(int argc, char **argv)
{
  unsigned long flags;
  unsigned long	aflags;
  unsigned int	index;
  int		mode;
  char		*current;
  int		error = 0;
  int		view = 0;

  if (argc < 3 || argv[1][0] != '-')
    usage(argv[0]);

   for (index = 2, current = argv[index]; current; current = argv[++index])
    {

      mode = (argc == 3 && !strcmp(argv[1], "-v") ? O_RDONLY : O_RDWR);

      error = read_header(current, mode);
      switch (error)
	{
	case 1:
	  perror(current);
	  continue ;
	case 2:
	  fprintf(stderr, "%s: Unknown file type (passed) \n", current);
	  XCLOSE(fd);
	  continue ;
	case 3:
	  fprintf(stderr, "%s: Wrong architecture (passed) \n", current);
	  XCLOSE(fd);
	  continue ;
	}

      aflags = get_flags();
      flags = scan_flags(aflags, argv, &view);

      if (view)
	{
	  printf("\n----[ Current flags for %s ]---- \n\n", current);
	  print_flags(aflags);
	  puts("");
	}

      put_flags(flags);

      if (flags != aflags && write_header())
	{
	  perror(current);
	  error = 4;
	}

      if (error)
	fprintf(stderr, "%s : Flags were not updated . \n", current);
      else if (view && aflags != flags)
	{
	  printf("\n----[ Updated flags for %s ]---- \n\n", current);
	  print_flags(flags);
	  puts("");
	}

      XCLOSE(fd);
    }

  return (error);
}
