#include <stdio.h>

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <fcntl.h>
#include <unistd.h>
#include <getopt.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <linux/fs.h>
#include "loop.h"

#define NUMDRIVES (6)

/*drobbins notes (11 Dec 2000)
	device=(major*256)+minor
	mount /proc
	turn off module ickyness
		echo "0 0 0 0" > /proc/sys/kernel/printk
	use this info to set the new root fs
		echo 0x902>/proc/sys/kernel/real-root-dev
	umount /proc
*/
int set_loop(const char *device, const char *file, int offset, int loopro)
{
	struct loop_info loopinfo;
	int	fd, ffd, mode, i;
	char	*pass;

	mode = loopro ? O_RDONLY : O_RDWR;
	if ((ffd = open (file, mode)) < 0 && !loopro
	    && (errno != EROFS || (ffd = open (file, mode = O_RDONLY)) < 0)) {
	  perror (file);
	  return 0;
	}
	if ((fd = open (device, mode)) < 0) {
	  perror (device);
	  return 0;
	}
	loopro = (mode == O_RDONLY);

	memset(&loopinfo, 0, sizeof(loopinfo));
	strncpy(loopinfo.lo_name, file, LO_NAME_SIZE);
	loopinfo.lo_name[LO_NAME_SIZE-1] = 0;
	loopinfo.lo_offset = offset;
	loopinfo.lo_encrypt_key_size = 0;
	if (ioctl(fd, LOOP_SET_FD, ffd) < 0) {
		perror("ioctl: LOOP_SET_FD");
		exit(1);
	}
	if (ioctl(fd, LOOP_SET_STATUS, &loopinfo) < 0) {
		(void) ioctl(fd, LOOP_CLR_FD, 0);
		perror("ioctl: LOOP_SET_STATUS");
		exit(1);
	}
	close(fd);
	close(ffd);
	return 1;
}

int main(void) {
	char *drives[]={ "/dev/hdc","/dev/hdd","/dev/hdb","/dev/hda","/dev/scd0","/dev/scd1"};
	char *mymtab="/dev/loop0 / ext2 ro 0 0\n"; 
	int i,mresult;
	FILE *distfile,*mycdfile;
	char mychar;
	
	printf("\033c\033[36;01mGentoo Linux CD-ROM mounter \033[32;01m\nCopyright 1999-2000 Daniel Robbins\n-=Distributed under the GPL=-\n\n\033[0m");

	i=0;
	while ( i < NUMDRIVES ) {
		printf("Trying %s...",drives[i]);
		sleep(1);
		mresult=mount(drives[i],"/distcd","iso9660",MS_MGC_VAL|MS_RDONLY,NULL);
		if ((mresult==-1) && (errno==123)) {
			//medium not found
			mychar=' ';
			while (mychar==' ') {
				printf("\nEmpty CD-ROM detected at %s.\nYou can either insert the Gentoo Linux CD and press <space> to mount,\nor press any other key to continue probing CD-ROM devices.\n\n", drives[i]);
				mychar=getchar();
				if (mychar!=' ') 
				 	i++; 
				continue;
			}	
		} else if (mresult==0) {
			//success - a CD of some kind was found
			printf("\n\033[36;01mCD found...\033[0m\n");
			while ((distfile=fopen("/distcd/version","r"))==NULL) {
				printf("This does not appear to be the Gentoo Linux distribution disc.\n");
				printf("You can either insert Gentoo Linux CD into %s and press <space> to remount,\n",drives[i]);
				printf("or you can press any other key to continue probing CD-ROM devices.\n\n");					
				umount(drives[i]);
				mychar=getchar();	
				if (mychar!=' ')
					i++;
				continue;
			}
			printf("\033[32;01mGentoo Linux distribution CD found!\033[0m\n");
			fclose(distfile);
			break;
		} else {
			//failure
			printf(" error %i\n",errno);
			i++;
		}
	}
	if (mresult) {
		//couldn't mount cd :/		
		printf("\nCould not mount CD.  Ouch!\n");
		exit(1);
	}


	mycdfile=fopen("/mycd","a");
	if (mycdfile) {
		fputs(drives[i],mycdfile);
		putc('\n',mycdfile);
		fclose(mycdfile);
	} else {
		printf("Error writing mycd info!\n");
	}		

	printf("Associating loopback CD-ROM filesystem...\n");
	if(!(set_loop("/dev/loop0","/distcd/images/boot.img",0,0))) {
		printf("Error associating loopback CD-ROM filesystem.  This program is stuck!\n");
		exit(1);
	}
	printf("Success!\n");		
	mount("/dev/loop0","/","ext2",MS_MGC_VAL|MS_RDONLY,0);
	mycdfile=fopen("/etc/mtab","a");
	fwrite(mymtab,1,strlen(mymtab),mycdfile);
	fclose(mycdfile);
}

