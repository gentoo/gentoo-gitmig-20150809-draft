#!/bin/bash
# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author:  Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/files/fix_libtool_files.sh,v 1.4 2002/11/25 06:45:53 azarah Exp $

source /etc/profile
source /etc/init.d/functions.sh

if [ "`id -u`" -ne 0 ]
then
        eerror "${0##*/}: Must be root."
        exit 1
fi

usage() {
cat << "USAGE_END"
Usage: fix_libtool_files.sh <old-gcc-version>

    Where <old-gcc-version> is the version number of the
    previous gcc version.  For example, if you updated to
    gcc-3.2.1, and you had gcc-3.2 installed, run:

      # fix_libtool_files.sh 3.2

USAGE_END

        exit 1
}

if [ "$#" -ne 1 ]
then
	usage
fi

PORTDIR="`/usr/bin/python -c 'import portage; print portage.settings[\"PORTDIR\"];'`"

AWKDIR="${PORTDIR}/sys-devel/gcc/files/awk"

if [ ! -r ${AWKDIR}/fixlafiles.awk ]
then
	eerror "${0##*/}: ${AWKDIR}/fixlafiles.awk does not exist!"
	exit 1
fi

/bin/gawk -v OLDVER="$1" -f ${AWKDIR}/fixlafiles.awk


# vim:ts=4
