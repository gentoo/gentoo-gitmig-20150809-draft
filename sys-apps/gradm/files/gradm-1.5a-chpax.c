/*
 * This program manages various PaX related flags for ELF and a.out binaries.
 * The flags only have effect when running the patched Linux kernel.
 *
 * Written by Solar Designer and placed in the public domain.
 *
 * Adapted to PaX by the PaX Team.
 */

#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <linux/elf.h>
#include <linux/a.out.h>

#define HF_PAX_PAGEEXEC         1       /* 0: Paging based non-executable pages */
#define HF_PAX_EMUTRAMP         2       /* 0: Emulate trampolines */
#define HF_PAX_MPROTECT         4       /* 0: Restrict mprotect() */
#define HF_PAX_RANDMMAP         8       /* 0: Randomize mmap() base */
#define HF_PAX_RANDEXEC         16      /* 1: Randomize ET_EXEC base */
#define HF_PAX_SEGMEXEC         32      /* 0: Segmentation based non-executable pages */

static struct elf32_hdr header_elf;
static struct exec header_aout;
static void *header;
static int header_size;
static int fd;

static unsigned long (*get_flags)();
static void (*put_flags)(unsigned long);

static unsigned long get_flags_elf()
{
	return header_elf.e_flags;
}

static void put_flags_elf(unsigned long flags)
{
	header_elf.e_flags = flags;
}

static unsigned long get_flags_aout()
{
	return N_FLAGS(header_aout);
}

static void put_flags_aout(unsigned long flags)
{
	N_SET_FLAGS(header_aout, flags & ~HF_PAX_RANDMMAP);
}

static int read_header(char *name, int mode)
{
	char *ptr;
	int size, block;

	if ((fd = open(name, mode)) < 0) return 1;

	ptr = (char *)&header_elf;
	size = sizeof(header_elf);
	do {
		block = read(fd, ptr, size);
		if (block <= 0) {
			close(fd);
			return block ? 1 : 2;
		}
		ptr += block; size -= block;
	} while (size > 0);

	memcpy(&header_aout, &header_elf, sizeof(header_aout));

	if (!strncmp(header_elf.e_ident, ELFMAG, SELFMAG)) {
		if (header_elf.e_type != ET_EXEC && header_elf.e_type != ET_DYN) return 2;
		if (header_elf.e_machine != EM_386) return 3;
		header = &header_elf; header_size = sizeof(header_elf);
		get_flags = get_flags_elf; put_flags = put_flags_elf;
	} else
	if (N_MAGIC(header_aout) == NMAGIC ||
	    N_MAGIC(header_aout) == ZMAGIC ||
	    N_MAGIC(header_aout) == QMAGIC) {
		if (N_MACHTYPE(header_aout) != M_386) return 3;
		header = &header_aout; header_size = 4;
		get_flags = get_flags_aout; put_flags = put_flags_aout;
	} else return 2;

	return 0;
}

int write_header()
{
	char *ptr;
	int size, block;

	if (lseek(fd, 0, SEEK_SET)) return 1;

	ptr = (char *)header;
	size = header_size;
	do {
		block = write(fd, ptr, size);
		if (block <= 0) break;
		ptr += block; size -= block;
	} while (size > 0);

	return size;
}

#define USAGE \
"Usage: %s OPTIONS FILE...\n" \
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
"  -v\tview current flag state\n\n" \
"The flags only have effect when running the patched Linux kernel.\n"

void usage(char *name)
{
	printf(USAGE, name ? name : "chpax");
	exit(1);
}

int main(int argc, char **argv)
{
	char **current;
	unsigned long flags;
	int error = 0;
	int mode;

	if (argc < 3) usage(argv[0]);
	if (strlen(argv[1]) != 2) usage(argv[0]);
	if (argv[1][0] != '-' || !strchr("pPeEmMrRxXsSv", argv[1][1])) usage(argv[0]);

	current = &argv[2];
	do {
		mode = argv[1][1] == 'v' ? O_RDONLY : O_RDWR;
		switch (read_header(*current, mode)) {
		case 1:
			perror(*current);
			error = 1; continue;

		case 2:
			printf("%s: Unknown file type\n", *current);
			error = 1; continue;

		case 3:
			printf("%s: Wrong architecture\n", *current);
			error = 1; continue;
		}

		flags = get_flags();

		switch (argv[1][1]) {
		case 'p':
			put_flags(flags | HF_PAX_PAGEEXEC);
			break;

		case 'P':
			put_flags((flags & ~HF_PAX_PAGEEXEC)|HF_PAX_SEGMEXEC);
			break;

		case 'E':
			put_flags(flags | HF_PAX_EMUTRAMP);
			break;

		case 'e':
			put_flags(flags & ~HF_PAX_EMUTRAMP);
			break;

		case 'm':
			put_flags(flags | HF_PAX_MPROTECT);
			break;

		case 'M':
			put_flags(flags & ~HF_PAX_MPROTECT);
			break;

		case 'r':
			put_flags(flags | HF_PAX_RANDMMAP);
			break;

		case 'R':
			put_flags(flags & ~HF_PAX_RANDMMAP);
			break;

		case 'X':
			put_flags(flags | HF_PAX_RANDEXEC);
			break;

		case 'x':
			put_flags(flags & ~HF_PAX_RANDEXEC);
			break;

		case 's':
			put_flags(flags | HF_PAX_SEGMEXEC);
			break;

		case 'S':
			put_flags((flags & ~HF_PAX_SEGMEXEC)|HF_PAX_PAGEEXEC);
			break;

		default:
			printf("%s: "
			       "paging based PAGE_EXEC is %s, "
			       "trampolines are %s, "
			       "mprotect() is %s, "
			       "mmap() base is %s, "
			       "ET_EXEC base is %s, "
			       "segmentation based PAGE_EXEC is %s\n", *current,
				(flags & HF_PAX_PAGEEXEC) || !(flags & HF_PAX_SEGMEXEC)
				? "disabled" : "enabled",
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

		if (flags != get_flags())
		if (write_header()) {
			perror(*current);
			error = 1;
		}

		close(fd);
	} while (*++current);

	return error;
}
