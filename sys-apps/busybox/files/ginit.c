/*
 * simple init to bootstrap sep-/usr
 *
 * Copyright (C) 2012 Mike Frysinger <vapier@gentoo.org>
 *
 * Licensed under GPLv2 or later
 */

//applet:IF_INIT(APPLET(ginit, BB_DIR_SBIN, BB_SUID_DROP))

//kbuild:lib-$(CONFIG_GINIT) += ginit.o

//config:config GINIT
//config:	bool "ginit"
//config:	default y
//config:	help
//config:	  sep-/usr bootstrapper

//usage:#define ginit_trivial_usage NOUSAGE_STR
//usage:#define ginit_full_usage ""

#include "libbb.h"

#define eprintf(fmt, args...) printf("%s" fmt, "sep-usr init: ", ## args)

static void process_args(char **args)
{
	size_t i;

	eprintf("running: ");
	for (i = 0; args[i]; ++i) {
		/* String needs to be writable, so dupe it */
		args[i] = xstrdup(args[i]);
		printf("'%s' ", args[i]);
	}
	printf("\n");
}

int ginit_main(int argc UNUSED_PARAM, char **argv) MAIN_EXTERNALLY_VISIBLE;
int ginit_main(int argc UNUSED_PARAM, char **argv)
{
	FILE *mntlist;
	bool ismnted_dev, ismnted_sys, ismnted_usr;
	struct mntent *mntent;

	/*
	int fd = open("/dev/console", O_RDWR);
	if (fd >= 0) {
		dup2(fd, 0);
		dup2(fd, 1);
		dup2(fd, 2);
	}
	*/

	/* If given an argv[] with an applet name, run it instead.
	 * Makes recovering simple by doing: init=/ginit bb
	 */
	if (argv[1] && argv[1][0] != '/') {
		eprintf("running user requested applet %s\n", argv[1]);
		return spawn_and_wait(argv+1);
	}

#define _spawn_and_wait(argv...) \
	({ \
		static const char *args[] = { argv, NULL }; \
		/* These casts are fine -- see process_args for mem setup */ \
		process_args((void *)args); \
		spawn_and_wait((void *)args); \
	})

	/* We need /proc in order to see what's already been mounted */
	if (access("/proc/mounts", F_OK) != 0) {
		if (_spawn_and_wait("mount", "-n", "/proc"))
			_spawn_and_wait("mount", "-n", "-t", "proc", "proc", "/proc");
	}

	/* Look up all the existing mount points */
	ismnted_dev = ismnted_sys = ismnted_usr = false;
	mntlist = setmntent("/proc/mounts", "re");
	if (mntlist) {
		while ((mntent = getmntent(mntlist))) {
			if (!strcmp(mntent->mnt_dir, "/dev"))
				ismnted_dev = true;
			else if (!strcmp(mntent->mnt_dir, "/sys"))
				ismnted_sys = true;
			else if (!strcmp(mntent->mnt_dir, "/usr"))
				ismnted_usr = true;
		}
		endmntent(mntlist);
	}

	/* First setup basic /dev */
	if (!ismnted_dev) {
		if (_spawn_and_wait("mount", "-n", "/dev"))
			if (_spawn_and_wait("mount", "-n", "-t", "devtmpfs", "devtmpfs", "/dev"))
				_spawn_and_wait("mount", "-n", "-t", "tmpfs", "dev", "/dev");
	} else {
		eprintf("%s appears to be mounted; skipping its setup\n", "/dev");
	}

	/* If /dev is empty (e.g. tmpfs), run mdev to seed things */
	if (access("/dev/console", F_OK) != 0) {
		if (!ismnted_sys) {
			if (_spawn_and_wait("mount", "-n", "/sys"))
				_spawn_and_wait("mount", "-n", "-t", "sysfs", "sysfs", "/sys");
		} else {
			eprintf("%s appears to be mounted; skipping its setup\n", "/sys");
		}
		_spawn_and_wait("mdev", "-s");
	}

	/* Then seed the stuff we care about */
	_spawn_and_wait("mkdir", "-p", "/dev/pts", "/dev/shm");

	/* Then mount /usr */
	if (!ismnted_usr) {
		_spawn_and_wait("mount", "-n", "/usr", "-o", "ro");
	} else {
		eprintf("%s appears to be mounted; skipping its setup\n", "/usr");
	}

	/* Now that we're all done, exec the real init */
	if (!argv[1]) {
		argv[0] = (void *)"/sbin/init";
		argv[1] = NULL;
	} else
		++argv;
	process_args(argv);
	return execv(argv[0], argv);
}
