/* Syslog listener for systems where /dev/log is a Unix domain socket. */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/time.h>
#include <pwd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <sys/un.h>
#include <errno.h>

#define SIZE 1024
#define SOCKNAME "/dev/log"
#define RUNUSER "daemon"

int main(int argc, char **argv){
	char buf[SIZE];
	ssize_t r, w;
	struct sockaddr_un sa1;
	int s1;
	fd_set fs;
	int fd[2];
	pid_t child;
	struct passwd *userinfo;

	if(argc<2){
		fprintf(stderr, "No logger specified\n");
		exit(1);
	}

	/* Assume that it's ok to grab /dev/log. */
	if ((s1 = open("/proc/kmsg",O_RDONLY)) == -1) {
		perror("/proc/kmsg");
		exit(1);
	}
	/* Dropping privileges here 
	userinfo=getpwnam(RUNUSER);      
	if(userinfo){
		setuid(userinfo->pw_uid);
		seteuid(userinfo->pw_uid);
	} else {
		fprintf(stderr, "No such user: %s\n", RUNUSER);
		exit(1);
	}
*/
	if(pipe(fd)==-1){
		perror("pipe");
		exit(1);
	}
	if((child=fork())==-1){
		perror("fork");
		exit(1);
	}
	if(child==0){ /* We are the child */
		close(fd[1]); /* Child will only be reading from, not writing to parent */
		dup2(fd[0], 0);
		/* Execute logger */
		//execlp("multilog", "multilog", "/tmp/test", NULL);
		argv++;
		execvp(argv[0], argv);
	}

	/* We are Parent */
	close(fd[0]); /* Write to the child */

	for(;;) {
		r = read(s1, buf, SIZE);
		if (r < 0) {
			if (errno!=EINTR)
				perror("read");
			continue;
		}
		while (r) {
			w = write(fd[1], buf, r);
			if (w < 0) {
				if (errno!=EINTR)
					perror("write");
				exit(1);
			}
			r -= w;
		}
	}
}
