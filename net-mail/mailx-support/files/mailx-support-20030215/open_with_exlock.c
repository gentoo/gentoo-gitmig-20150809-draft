#include <fcntl.h>

int open_with_exlock(const char *path, int flags, mode_t mode)
{
	int fd;
	fd = open(path, flags, mode);
	if (fd == -1)
		return -1;
	if (flock(fd, LOCK_EX) == -1)
		return -1;
	return fd;
}

