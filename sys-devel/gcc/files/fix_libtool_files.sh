#!/bin/bash
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author:  Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/files/fix_libtool_files.sh,v 1.9 2004/02/10 21:51:16 seemant Exp $

usage() {
cat << "USAGE_END"
Usage: fix_libtool_files.sh <old-gcc-version> [--oldarch <old-CHOST>]

    Where <old-gcc-version> is the version number of the
    previous gcc version.  For example, if you updated to
    gcc-3.2.1, and you had gcc-3.2 installed, run:

      # fix_libtool_files.sh 3.2

    If you updated to gcc-3.2.3, and the old CHOST was i586-pc-linux-gnu
    but you now have CHOST as i686-pc-linux-gnu, run:

      # fix_libtool_files.sh 3.2 --oldarch i586-pc-linux-gnu

    Note that if only the CHOST and not the version changed, you can run
    it with the current version and the '--oldarch <old-CHOST>' arguments,
    and it will do the expected:

      # fix_libtool_files.sh `gcc -dumpversion` --oldarch i586-pc-linux-gnu


USAGE_END

        exit 1
}

if [ "$2" != "--oldarch" -a "$#" -ne 1 ] || \
   [ "$2" = "--oldarch" -a "$#" -ne 3 ]
then
	usage
fi

ARGV1="$1"
ARGV2="$2"
ARGV3="$3"

source /etc/profile
source /sbin/functions.sh

if [ "`id -u`" -ne 0 ]
then
	eerror "${0##*/}: Must be root."
	exit 1
fi

if [ "${ARGV2}" = "--oldarch" -a "x${ARGV3}" != "x" ]
then
	OLDCHOST="${ARGV3}"
else
	OLDCHOST=
fi

AWKDIR="/lib/rcscripts/awk"

if [ ! -r "${AWKDIR}/fixlafiles.awk" ]
then
	eerror "${0##*/}: ${AWKDIR}/fixlafiles.awk does not exist!"
	exit 1
fi

OLDVER="${ARGV1}"

export OLDVER OLDCHOST

einfo "Scanning libtool files for hardcoded gcc library paths..."
/bin/gawk -f "${AWKDIR}/fixlafiles.awk"


# vim:ts=4
