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
#include <linux/loop.h>

#define NUMDRIVES (6)

char *blurb="    Gentoo Linux CD mounter - Copyright 1999-2001 Gentoo Technologies, Inc.     ";
char *color="\033[36;01m";
char *off="\033[0m";
char readbuf[80];

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

//does a mount and performs some error checking/debugging too
//2=success; 1=no media; 0=failure
int domount(const char *dev, 
			const char *loc, 
			const char *fstype, 
			unsigned long flags, 
			const void *data) 
{
	int result;
	result=mount(dev,loc,fstype,0,flags,data);
	if (result==-1) {
		if (errno==ENOMEDIUM) {
			printf("Media not found in %s\n",dev);
			return 1;
		}
		printf("Error mounting %s at %s of type %s:\n",dev,loc,fstype);
		perror("mount");
		return 0;
	}
	return 2;
}

//writes data to a file and performs some error checking
//1=success; 0=failure
int writefile(const char *myfile, char *mystring) {
	FILE *myf;
	int result;
	myf=fopen(myfile,"w");
	if (myf==NULL) {
		printf("Error opening file %s: errno %d\n",myfile,errno);
		perror("fopen");
		return 0;
	}
	fwrite(mystring,1,strlen(mystring),myf);
	fclose(myf);
	return 1;
}


int getspace(char *dev) {
	char mychar;
	printf("\n1) Try %s again\n2) Continue looking\n\n%s> %s",dev,color,off);
	mychar=fgetc(stdin);
	if (mychar=='1')
		return 1;
	return 0;
}
int main(void) {
	char *drives[]={ "/dev/hdc","/dev/hdd","/dev/hdb2","/dev/hda","/dev/scd0","/dev/scd1"};
	int i,mresult;
	char mychar;
	FILE *distfile;	
//	printf("\n\0337\033[01;23r\033[24;01f\033[01;44;32m%s\033[0m\0338\033[A",blurb); 
	//printf("\nRemounting root fs read-write...\n");
	//should be rw anyway but it's not?
	//domount("/dev/ram0","/","ext2",MS_MGC_VAL|MS_REMOUNT,NULL);
	printf("%sLet's begin...%s\n\n",color,off);
//	printf("%sMounting /proc...%s\n",color,off);
	//mount /proc filesystem
//	domount("proc","/proc","proc",MS_MGC_VAL|MS_NOEXEC,NULL);
	//turn off kernel logging to console
//	writefile("/proc/sys/kernel/printk","0 0 0 0");
	
	i=0;
	while ( 1 ) {
		printf("Trying %s...",drives[i]);
		sleep(1);
		mresult=domount(drives[i],"/distcd","reiserfs",MS_MGC_VAL|MS_RDONLY,NULL);
		if (mresult==2) {
			//a CD of some kind was found
			printf("\n%sCD found...%s\n",color,off);
			if ((distfile=fopen("/distcd/version","r"))==NULL) {
				printf("%sThis does not appear to be the Gentoo Linux distribution disc.%s\n",color,off);
				umount(drives[i]);
				if (!getspace(drives[i]))
					i++;
					if (i>NUMDRIVES)
						i=0;
				continue;
			} else {
				fclose(distfile);
				break;
				//success!
			}
		} else if (mresult==1) {
			if (!getspace(drives[i]))
				i++;
				if (i>NUMDRIVES)
					i=0;
			continue;
		} else {
			i++;
			if (i>NUMDRIVES)
				i=0;
		}
	}
	printf("%sAssociating loopback CD-ROM filesystem...%s\n",color,off);
	if(!(set_loop("/dev/loop0","/distcd/images/boot.img",0,0))) {
		printf("%sError associating loopback CD-ROM filesystem.  This program is stuck!%s\n",color,off);
		exit(1);
	}

	printf("%sSuccess!%s\n",color,off);		
	mount("/dev/loop0","/mnt/cdrom","ext2",0,MS_MGC_VAL|MS_RDONLY,0);

	//set real root device to /dev/loop0 (major 7, minor 0)
//	writefile("/proc/sys/kernel/real-root-dev","0x700");
	
	//umount /proc
//	umount("proc");

	//turn bottom bar off
//	printf("\0337\033[r\033[24;01f\033[K\0338");
}

