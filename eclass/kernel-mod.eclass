# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kernel-mod.eclass,v 1.3 2003/08/27 10:55:55 stuart Exp $

# This eclass provides help for compiling external kernel modules from
# source.
#
# This eclass differs from kmod.eclass because it doesn't require modules
# to be added to the kernel source tree first.

ECLASS=kernel-mod
INHERITED="$INHERITED $ECLASS"
S=${WORKDIR}/${P}
DESCRIPTION="Based on the $ECLASS eclass"

SRC_URI="${SRC_URI:-unknown - please fix me!!}"
KERNEL_DIR="${KERNEL_DIR:-/usr/src/linux}"

kernel-mod_getmakefilevar ()
{
	grep $1 $2 | head -n 1 | cut -d = -f 2- | awk '{ print $1 }'
}

kernel-mod_getversion ()
{
	# yes, this is horrible, but it is effective
	#
	# KV_DIR contains the real directory name of the directory containing
	# the Linux kernel that we are going to compile against

	if [ -h ${KERNEL_DIR} ] ; then
		einfo "${KERNEL_DIR} is a symbolic link"
		einfo "Determining the real directory of the Linux kernel source code"
		KV_DIR="`ls -ld ${KERNEL_DIR} | awk '{ print $11 }'`"
	elif [ -d ${KERNEL_DIR} ] ; then
		einfo "${KERNEL_DIR} is a real directory"
		KV_DIR="`ls -ld ${KERNEL_DIR} | awk '{ print $9 }'`"
	else
		eerror "Directory '${KERNEL_DIR}' cannot be found"
		die
	fi
	KV_DIR="`basename $KV_DIR`"

	# now, we need to break that down into versions

	KV_DIR_VERSION_FULL="`echo $KV_DIR | cut -f 2- -d -`"

	KV_DIR_MAJOR="`echo $KV_DIR_VERSION_FULL | cut -f 1 -d .`"
	KV_DIR_MINOR="`echo $KV_DIR_VERSION_FULL | cut -f 2 -d .`"
	KV_DIR_PATCH="`echo $KV_DIR_VERSION_FULL | cut -f 3 -d . | cut -f 3 -d -`"
	KV_DIR_TYPE="`echo $KV_DIR_VERSION_FULL | cut -f 2- -d -`"

	# sanity check - do the settings in the kernel's makefile match
	# the directory that the kernel src is stored in?

	KV_MK_FILE="${KERNEL_DIR}/Makefile"
	KV_MK_MAJOR="`kernel-mod_getmakefilevar VERSION $KV_MK_FILE`"
	KV_MK_MINOR="`kernel-mod_getmakefilevar PATCHLEVEL $KV_MK_FILE`"
	KV_MK_PATCH="`kernel-mod_getmakefilevar SUBLEVEL $KV_MK_FILE`"
	KV_MK_TYPE="`kernel-mod_getmakefilevar EXTRAVERSION $KV_MK_FILE`"

	KV_MK_VERSION_FULL="$KV_MK_MAJOR.$KV_MK_MINOR.$KV_MK_PATCH$KV_MK_TYPE"

	if [ "$KV_MK_VERSION_FULL" != "$KV_DIR_VERSION_FULL" ]; then
		ewarn
		ewarn "The kernel Makefile says that this is a $KV_MK_VERSION_FULL kernel"
		ewarn "but the source is in a directory for a $KV_DIR_VERSION_FULL kernel."
		ewarn
		ewarn "This goes against the recommended Gentoo naming convention."
		ewarn "Please rename your source directory to 'linux-${KV_MK_VERSION_FULL}'"
		ewarn
	fi

	# these variables can be used by ebuilds to determine whether they
	# will work with the targetted kernel or not
	#
	# do not rely on any of the variables above being available

	KV_VERSION_FULL="$KV_MK_VERSION_FULL"
	KV_MAJOR="$KV_MK_MAJOR"
	KV_MINOR="$KV_MK_MINOR"
	KV_PATCH="$KV_MK_PATCH"
	KV_TYPE="$KV_MK_TYPE"

	einfo "Building for Linux ${KV_VERSION_FULL} found in ${KERNEL_DIR}"
}

kernel-mod_src_compile ()
{
	emake KERNEL_DIR=${KERNEL_DIR} || die
}

EXPORT_FUNCTIONS src_compile
