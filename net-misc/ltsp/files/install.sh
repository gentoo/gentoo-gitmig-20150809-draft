#!/bin/sh

# This is meant to take over the work done by the install.sh files provided
# with the ltsp downloads.

SOURCE_DIR=$1
DEST_DIR=$2

if test x$SOURCE_DIR = x -o \! -d $SOURCE_DIR ; then
	echo "*** Bad source dir!"
	exit 1
fi

if test x$DEST_DIR = x -o \! -d $SOURCE_DIR ; then
	echo "*** Bad dest dir!"
	exit 1
fi

# do the actual copy

find $SOURCE_DIR -print | cpio -pmud --quiet $DEST_DIR
RS=$?
if test $RS -ne 0 ; then
	echo "*** ERROR COPYING $SOURCE_DIR to $DEST_DIR"
	exit 1
fi


