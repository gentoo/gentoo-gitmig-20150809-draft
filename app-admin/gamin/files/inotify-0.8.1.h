/*
 * Inode based directory notification for Linux
 *
 * Copyright (C) 2004 John McCutchan
 *
 * Signed-off-by: John McCutchan ttb@tentacle.dhs.org
 */

#ifndef _LINUX_INOTIFY_H
#define _LINUX_INOTIFY_H

struct inode;
struct dentry;
struct super_block;

struct inotify_event {
	int wd;
	int mask;
	char filename[256];
	/* When you are watching a directory you will get the filenames
	 * for events like IN_CREATE, IN_DELETE, IN_OPEN, IN_CLOSE, etc.. 
	 */
};
/* When reading from the device you must provide a buffer 
 * that is a multiple of the sizeof(inotify_event)
 */

#define IN_ACCESS	0x00000001	/* File was accessed */
#define IN_MODIFY	0x00000002	/* File was modified */
#define IN_CREATE	0x00000004	/* File was created */
#define IN_DELETE	0x00000008	/* File was deleted */
#define IN_RENAME	0x00000010	/* File was renamed */
#define IN_ATTRIB	0x00000020	/* File changed attributes */
#define IN_MOVE		0x00000040	/* File was moved */
#define IN_UNMOUNT	0x00000080	/* Device file was on, was unmounted */
#define IN_CLOSE	0x00000100	/* File was closed */
#define IN_OPEN		0x00000200	/* File was opened */
#define IN_IGNORED	0x00000400	/* File was ignored */
#define IN_ALL_EVENTS	0xffffffff	/* All the events */

/* ioctl */

/* Fill this and pass it to INOTIFY_WATCH ioctl */
struct inotify_watch_request {
	char *dirname; // directory name
	unsigned long mask; // event mask
};

#define INOTIFY_IOCTL_MAGIC 'Q'
#define INOTIFY_IOCTL_MAXNR 4

#define INOTIFY_WATCH  		_IOR(INOTIFY_IOCTL_MAGIC, 1, struct inotify_watch_request)
#define INOTIFY_IGNORE 		_IOR(INOTIFY_IOCTL_MAGIC, 2, int)
#define INOTIFY_STATS		_IOR(INOTIFY_IOCTL_MAGIC, 3, int)
#define INOTIFY_SETDEBUG	_IOR(INOTIFY_IOCTL_MAGIC, 4, int)

#define INOTIFY_DEBUG_NONE   0x00000000
#define INOTIFY_DEBUG_ALLOC  0x00000001
#define INOTIFY_DEBUG_EVENTS 0x00000002
#define INOTIFY_DEBUG_INODE  0x00000004
#define INOTIFY_DEBUG_ERRORS 0x00000008
#define INOTIFY_DEBUG_FILEN  0x00000010
#define INOTIFY_DEBUG_ALL    0xffffffff

/* Kernel API */
/* Adds events to all watchers on inode that are interested in mask */
void inotify_inode_queue_event (struct inode *inode, unsigned long mask, const char *filename);
/* Same as above but uses dentry's inode */
void inotify_dentry_parent_queue_event (struct dentry *dentry, unsigned long mask, const char *filename);
/* This will remove all watchers from all inodes on the superblock */
void inotify_super_block_umount (struct super_block *sb);

#endif

