#!/bin/bash

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

if [ ! -r ${AWKDIR}/getlibdirs.awk ]
then
	eerror "${0##*/}: ${AWKDIR}/getlibdirs.awk does not exist!"
	exit 1
fi

/bin/gawk -v OLDVER="$1" -f ${AWKDIR}/getlibdirs.awk

