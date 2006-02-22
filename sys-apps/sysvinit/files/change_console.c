#include "initreq.h"
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <getopt.h>
#include <unistd.h>

void signal_handler(int sig) {
	exit(0);
}

int main(int argc, char **argv) {
	int foreground = 0, reset = 0, fd, x = 1;
	char *device = NULL;
	struct init_request req;
	
	while (x < argc) {
		if (!strcmp(argv[x], "-f")) {
			foreground = 1;
		} else if (!strcmp(argv[x], "-r")) {
			reset = 1;
		} else {
			device = argv[x];
		}
		x++;
	}
	if (!device)
		device = ttyname(0);

	memset(&req, 0, sizeof(req));
	req.magic = INIT_MAGIC;
	req.cmd = INIT_CMD_CHANGECONS;
	if (!reset)
		snprintf(req.i.bsd.reserved, 127, device);
	else
		req.i.bsd.reserved[0] = '\0';
	signal(SIGALRM, signal_handler);
	alarm(3);
	if ((fd = open(INIT_FIFO, O_WRONLY)) >= 0) {
		write(fd, &req, sizeof(req)) == sizeof(req);
		close(fd);
	}
	alarm(0);
	if (foreground)
		pause();
	return 0;
}
