#!/bin/bash
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/scripts/bootstrap.sh,v 1.43 2003/06/06 06:09:26 drobbins Exp $

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

if [ -e /etc/init.d/functions.sh ]
then
	source /etc/init.d/functions.sh

	# Use our own custom script, else logger cause things to
	# 'freeze' if we do not have a system logger running
	esyslog() {
		echo &> /dev/null
	}
fi
if [ -e /etc/profile ]
then
	source /etc/profile
fi

if [ "$!" = "" ]
then
    echo
    echo -e "${GOOD}Gentoo Linux${GENTOO_VERS}; \e[34;01mhttp://www.gentoo.org/${NORMAL}"
    echo -e " Copyright 2001-2003 Gentoo Technologies, Inc.; Distributed under the GPL"
    echo
    einfo "Starting Bootstrap of base system ..."
    echo
    echo
fi

# This should not be set to get glibc to build properly. See bug #7652.
LD_LIBRARY_PATH=""

# We do not want stray $TMP, $TMPDIR or $TEMP settings
unset TMP TMPDIR TEMP

cleanup() {
	if [ -f /etc/make.conf.build ]
	then
		mv -f /etc/make.conf.build /etc/make.conf
	fi

	exit $1
}

# Trap ctrl-c and stuff.  This should fix the users make.conf
# not being restored.
cp -f /etc/make.conf /etc/make.conf.build
trap "cleanup" TERM KILL INT QUIT ABRT
#TSTP messes ^Z of bootstrap up, so we don't trap it anymore.

# USE may be set from the environment so we back it up for later.
export ORIGUSE="`${PYTHON} -c 'import portage; print portage.settings["USE"];'`"

# Check for 'build' or 'bootstrap' in USE ...
INVALID_USE="`gawk -v ORIGUSE="${ORIGUSE}" '
	BEGIN { 
		if (ORIGUSE ~ /[[:space:]]*(build|bootstrap)[[:space:]]*/)
			print "yes"
	}'`"

# Do not do the check for stage build scripts ...
if [ "$1" = "" ] && [ "${INVALID_USE}" = "yes" ]
then
	echo
	eerror "You have 'build' or 'bootstrap' in your USE flags!  Please"
	eerror "remove it before trying to continue ..."
	echo
	cleanup 1
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
echo

export GENTOO_MIRRORS="`${PYTHON} -c 'import portage; print portage.settings["GENTOO_MIRRORS"];'`"

export PORTDIR="`${PYTHON} -c 'import portage; print portage.settings["PORTDIR"];'`"
export DISTDIR="`${PYTHON} -c 'import portage; print portage.settings["DISTDIR"];'`"
export PKGDIR="`${PYTHON} -c 'import portage; print portage.settings["PKGDIR"];'`"
export PORTAGE_TMPDIR="`${PYTHON} -c 'import portage; print portage.settings["PORTAGE_TMPDIR"];'`"

# Get correct CFLAGS, CHOST, CXXFLAGS, MAKEOPTS since make.conf will be
# overwritten
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
	
USE="-* build bootstrap" emerge ${myPORTAGE} || cleanup 1

if [ -x /usr/bin/gcc-config ]
then
	GCC_CONFIG="/usr/bin/gcc-config"
	
elif [ -x /usr/sbin/gcc-config ]
then
	GCC_CONFIG="/usr/sbin/gcc-config"
fi

# Basic support for gcc multi version/arch scheme ...
if test -x ${GCC_CONFIG} &> /dev/null && \
   ${GCC_CONFIG} --get-current-profile &> /dev/null
then
	# Make sure we get the old gcc unmerged ...
	emerge clean || cleanup 1
	# Make sure the profile and /lib/cpp and /usr/bin/cc are valid ...
	${GCC_CONFIG} "`${GCC_CONFIG} --get-current-profile`" &> /dev/null
fi

export USE="${ORIGUSE} bootstrap"
for x in ${myTEXINFO} ${myGETTEXT} ${myBINUTILS} ${myGCC} ${myGLIBC} ${MYBASELAYOUT} ${myZLIB} 
do
	emerge $x || cleanup 1
done
# ncurses-5.3 and up also build c++ bindings, so we need to rebuild it
export USE="${ORIGUSE}"
emerge ${myNCURSES} || cleanup 1

# Restore original make.conf
cleanup 0

