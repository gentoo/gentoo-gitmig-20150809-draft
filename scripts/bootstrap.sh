#!/bin/sh
# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/scripts/bootstrap.sh,v 1.38 2003/01/23 15:41:01 gerk Exp $

# IMPORTANT NOTE:
# This script now accepts an optional argument.
# Without an argument, it executes normally.
# With a "1.5" argument, it will execute only the first half of the build process.
# With a "2" argument, it will execute only the second half of the build process.
# Please ensure that this is maintained properly, as it is needed for my stage-building tools
# (drobbins, 06 Jan 2003)

MYPROFILEDIR="`readlink -f /etc/make.profile`"
if [ ! -d ${MYPROFILEDIR} ]
then
	echo "!!! Error:  ${MYPROFILEDIR} does not exist. Exiting."
	exit 1
fi
 
if [ -e /usr/bin/spython ]
then
	# 1.0_rc6 and earlier
	PYTHON="/usr/bin/spython"
else
	# 1.0 and later
	PYTHON="/usr/bin/python"
fi

# We really need to upgrade baselayout now that it's possible:
myBASELAYOUT=`cat ${MYPROFILEDIR}/packages | grep -v '^#' | grep sys-apps/baselayout | sed 's:^\*::'`
myPORTAGE=`cat ${MYPROFILEDIR}/packages | grep -v '^#' | grep sys-apps/portage | sed 's:^\*::'`
myGETTEXT=`cat ${MYPROFILEDIR}/packages | grep -v '^#' | grep sys-devel/gettext | sed 's:^\*::'`
myBINUTILS=`cat ${MYPROFILEDIR}/packages | grep -v '^#' | grep sys-devel/binutils | sed 's:^\*::'`
myGCC=`cat ${MYPROFILEDIR}/packages | grep -v '^#' | grep sys-devel/gcc | sed 's:^\*::'`
myGLIBC=`cat ${MYPROFILEDIR}/packages | grep -v '^#' | grep sys-libs/glibc | sed 's:^\*::'`
myTEXINFO=`cat ${MYPROFILEDIR}/packages|grep -v '^#'|grep sys-apps/texinfo |sed 's:^\*::'`
myZLIB=`cat ${MYPROFILEDIR}/packages|grep -v '^#'|grep sys-libs/zlib |sed 's:^\*::'`
myNCURSES=`cat ${MYPROFILEDIR}/packages|grep -v '^#'|grep sys-libs/ncurses |sed 's:^\*::'`

echo "Using ${myBASELAYOUT}"
echo "Using ${myPORTAGE}"
echo "Using ${myBINUTILS}"
echo "Using ${myGCC}"
echo "Using ${myGETTEXT}"
echo "Using ${myGLIBC}"
echo "Using ${myTEXINFO}"
echo "Using ${myZLIB}"
echo "Using ${myNCURSES}"

# This should not be set to get glibc to build properly. See bug #7652.
LD_LIBRARY_PATH=""

# We do not want stray $TMP or $TMPDIR settings
unset TMP TMPDIR

cleanup() {
	if [ -f /etc/make.conf.build ]
	then
		mv -f /etc/make.conf.build /etc/make.conf
	fi
	exit $1
}

# Trap ctrl-c and stuff.  This should fix the users make.conf
# not being restored.
trap "cleanup" INT QUIT
#TSTP messes ^Z of bootstrap up, so we don't trap it anymore.

# USE may be set from the environment so we back it up for later.
export ORIGUSE="`${PYTHON} -c 'import portage; print portage.settings["USE"];'`"
export GENTOO_MIRRORS="`${PYTHON} -c 'import portage; print portage.settings["GENTOO_MIRRORS"];'`"

export PORTDIR="`${PYTHON} -c 'import portage; print portage.settings["PORTDIR"];'`"
export DISTDIR="`${PYTHON} -c 'import portage; print portage.settings["DISTDIR"];'`"
export PKGDIR="`${PYTHON} -c 'import portage; print portage.settings["PKGDIR"];'`"
export PORTAGE_TMPDIR="`${PYTHON} -c 'import portage; print portage.settings["PORTAGE_TMPDIR"];'`"

# Get correct CFLAGS, CHOST, CXXFLAGS, MAKEOPTS since make.conf will be
# overwritten
cp -f /etc/make.conf /etc/make.conf.build
export CFLAGS="`${PYTHON} -c 'import portage; print portage.settings["CFLAGS"];'`"
export CHOST="`${PYTHON} -c 'import portage; print portage.settings["CHOST"];'`"
export CXXFLAGS="`${PYTHON} -c 'import portage; print portage.settings["CXXFLAGS"];'`"
export MAKEOPTS="`${PYTHON} -c 'import portage; print portage.settings["MAKEOPTS"];'`"
PROXY="`${PYTHON} -c 'import portage; print portage.settings["PROXY"];'`"
if [ -n "${PROXY}" ] 
then
	echo "exporting PROXY=${PROXY}"
	export PROXY
fi
HTTP_PROXY="`${PYTHON} -c 'import portage; print portage.settings["HTTP_PROXY"];'`"
if [ -n "${HTTP_PROXY}" ] 
then
	echo "exporting HTTP_PROXY=${HTTP_PROXY}"
	export HTTP_PROXY
fi
FTP_PROXY="`${PYTHON} -c 'import portage; print portage.settings["FTP_PROXY"];'`"
if [ -n "${FTP_PROXY}" ] 
then
	echo "exporting FTP_PROXY=${FTP_PROXY}"
	export FTP_PROXY
fi

# Disable autoclean, or it b0rks
export AUTOCLEAN="no"

# Allow portage to overwrite stuff
export CONFIG_PROTECT="-*"


if [ "$1" = "" ] || [ "$1" = "1.5" ]
then
export USE="-* build bootstrap"
#
# First stage of bootstrap (aka build stage)
#
cd /usr/portage
# Separate, so that the next command uses the *new* emerge
emerge ${myPORTAGE} || cleanup 1
emerge ${myBASELAYOUT} ${myTEXINFO} ${myGETTEXT} ${myBINUTILS} ${myGCC} || cleanup 1
# make.conf has been overwritten, so we explicitly export our original settings
fi

# Basic support for gcc multi version/arch scheme ...
if test -f /usr/sbin/gcc-config &> /dev/null && \
   /usr/sbin/gcc-config --get-current-profile &> /dev/null
then
	# Make sure we get the old gcc unmerged ...
	emerge clean || cleanup 1
	# Make sure the profile and /lib/cpp and /usr/bin/cc are valid ...
	/usr/sbin/gcc-config "`/usr/sbin/gcc-config --get-current-profile`" &> /dev/null
fi

if [ "$1" = "" ] || [ "$1" = "2" ]
then
#
# Second stage of boostrap
#
export USE="${ORIGUSE} bootstrap"
emerge ${myGLIBC} ${myBASELAYOUT} ${myTEXINFO} ${myGETTEXT} ${myZLIB} ${myBINUTILS} ${myGCC} || cleanup 1
# ncurses-5.3 and up also build c++ bindings, so we need to rebuild it
export USE="${ORIGUSE}"
emerge ${myNCURSES} || cleanup 1
fi
# Restore original make.conf
cleanup 0

