# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kernel-mod.eclass,v 1.1 2003/08/26 13:32:23 stuart Exp $

# This eclass provides help for compiling external kernel modules from
# source.
#
# This eclass differs from kmod.eclass because it doesn't require modules
# to be added to the kernel source tree first.

ECLASS=kernel-mod
INHERITED="$INHERITED $ECLASS"
S=${WORKDIR}/${P}
DESCRIPTION="Based on the $ECLASS eclass"

SRC_URI="unknown - please fix me!!"
KERNEL_DIR="${KERNEL_DIR:-/usr/src/linux}"

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
	else
		einfo "${KERNEL_DIR} is a real directory"
		KV_DIR="`ls -ld ${KERNEL_DIR} | awk '{ print $9 }'`"
	fi
	KV_DIR="`basename $KV_FULL_DIR`"

	# now, we need to break that down into versions

	KV_VERSION_FULL="`echo $KV_DIR | cut -f 2- -d -`"
	einfo "Building for Linux ${KV_VERSION_FULL} found in ${KERNEL_DIR}"

	KV_MAJOR="`echo $KV_VERSION_FULL | cut -f 1 -d .`"
	KV_MINOR="`echo $KV_VERSION_FULL | cut -f 2 -d .`"
	KV_PATCH="`echo $KV_VERSION_FULL | cut -f 3 -d . | cut -f 3 -d -`"
	KV_TYPE="`echo $KV_VERSION_FULL | cut -f 2- -d -`"

	# these variables can be used by ebuilds to determine whether they
	# will work with the targetted kernel or not
}

kernel-mod_src_compile ()
{
	emake KERNEL_DIR=${KERNEL_DIR} || die
}

EXPORT_FUNCTIONS src_compile
