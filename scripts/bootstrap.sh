#!/bin/bash
# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/scripts/bootstrap.sh,v 1.54 2004/04/06 06:43:10 vapier Exp $

# IMPORTANT NOTE:
# This script no longer accepts an optional argument.
# It was removed by the same person who added it -- me, drobbins -- when I optimized
# bootstrap to complete 20 mins to 2 hours faster, depending on CPU. I did this by 
# merging both stages of bootstrap into a single stage. We no longer compile gcc and
# binutils twice. Doing this is unnecessary and a holdover from very early versions
# of Gentoo, where we were being ultra-paranoid.

# (drobbins, 06 Jun 2003)

unset STRAP_EMERGE_OPTS 
STRAP_RUN=1
if [ "$1" = "--fetchonly" -o "$1" = "-f" ]
then
	echo "Running in fetch-only mode..."
	STRAP_EMERGE_OPTS="-f"
	unset STRAP_RUN
elif [ "$1" = "-h" -o "$1" = "--help" ]
then
	echo "bootstrap.sh: Please run with no arguments to start bootstrap, or specify"
	echo "--fetchonly or -f to download source archives only. -h/--help displays this"
	echo "help."
	exit 1
fi

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

echo
echo -e "${GOOD}Gentoo Linux${GENTOO_VERS}; \e[34;01mhttp://www.gentoo.org/${NORMAL}"
echo -e "Copyright 1999-2004 Gentoo Technologies, Inc.; Distributed under the GPL"
if [ "${STRAP_EMERGE_OPTS}" = "-f" ]
then
	echo "Fetching all bootstrap-related archives..."
else
	echo "Starting Bootstrap of base system ..."
fi
echo

# This should not be set to get glibc to build properly. See bug #7652.
LD_LIBRARY_PATH=

# We do not want stray $TMP, $TMPDIR or $TEMP settings
unset TMP TMPDIR TEMP

cleanup() {
	if [ -n "${STRAP_RUN}" ]
	then
		if [ -f /etc/make.conf.build ]
		then
			mv -f /etc/make.conf.build /etc/make.conf
		fi
	fi
	exit $1
}

# Trap ctrl-c and stuff.  This should fix the users make.conf
# not being restored.
if [ -n "${STRAP_RUN}" ]
then
	cp -f /etc/make.conf /etc/make.conf.build
fi

#TSTP messes ^Z of bootstrap up, so we don't trap it anymore.
trap "cleanup" TERM KILL INT QUIT ABRT

# USE may be set from the environment so we back it up for later.
export ORIGUSE="`${PYTHON} -c 'import portage; print portage.settings["USE"];'`"

# Check for 'build' or 'bootstrap' in USE ...
INVALID_USE="`gawk -v ORIGUSE="${ORIGUSE}" '
	BEGIN { 
		if (ORIGUSE ~ /[[:space:]]*(build|bootstrap)[[:space:]]*/)
			print "yes"
	}'`"

# Do not do the check for stage build scripts ...
if [ "${INVALID_USE}" = "yes" ]
then
	echo
	eerror "You have 'build' or 'bootstrap' in your USE flags. Please"
	eerror "remove it before trying to continue, since these USE flags"
	eerror "are used for internal purposes and shouldn't be specified"
	eerror "by you."
	echo
	cleanup 1
fi

# We really need to upgrade baselayout now that it's possible:
myBASELAYOUT=`cat ${MYPROFILEDIR}/packages | grep -v '^#' | grep sys-apps/baselayout | sed 's:^\*::'`
myPORTAGE=`cat ${MYPROFILEDIR}/packages | grep -v '^#' | grep sys-apps/portage | sed 's:^\*::'`
myGETTEXT=`cat ${MYPROFILEDIR}/packages | grep -v '^#' | grep sys-devel/gettext | sed 's:^\*::'`
# Not all profiles have gettest in the system profile anymore ...
[ -z "${myGETTEXT}" ] && myGETTEXT="sys-devel/gettext"
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

echo "Configuring environment..."
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
#to make it easier to get experimental bootstraps:
export ACCEPT_KEYWORDS="`${PYTHON} -c 'import portage; print portage.settings["ACCEPT_KEYWORDS"];'`"

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
if [ -x /usr/bin/gcc-config ]
then
	GCC_CONFIG="/usr/bin/gcc-config"

elif [ -x /usr/sbin/gcc-config ]
then
	GCC_CONFIG="/usr/sbin/gcc-config"
fi

# Disable autoclean, or it b0rks
export AUTOCLEAN="no"

# Allow portage to overwrite stuff
export CONFIG_PROTECT="-*"
	
USE="-* build bootstrap" emerge ${STRAP_EMERGE_OPTS} ${myPORTAGE} || cleanup 1

export USE="${ORIGUSE} bootstrap"
emerge ${STRAP_EMERGE_OPTS} ${myTEXINFO} ${myGETTEXT} ${myBINUTILS} || cleanup 1

# If say both gcc and binutils was build for i486, and we then merge
# binutils for i686 without removing the i486 version (Note that this is
# _only_ when its exactly the same version of binutils ... if we have say
# 2.14.90.0.6 build for i486, and bootstrap then merge 2.14.90.0.7 for i686,
# we will not have issues.  More below ...), gcc's search path will
# still have
#
#   /usr/lib/gcc-lib/i486-pc-linux-gnu/<gcc_version>/../../../../i486-pc-linux-gnu/bin/
#
# before /usr/bin, and thus it will use the i486 versions of binutils binaries
# which causes issues.  The reason for this issues is that when bootstrap merge
# exactly the same version for i686, both will have installed the same files to
# /usr/lib, and thus also USE the same libraries, cause as/ld to fail with
# unresolved symbols during compiling/linking.
#
# More info on this can be found by looking at bug #32140:
#
#   http://bugs.gentoo.org/show_bug.cgi?id=32140
#
# We now thus run an 'emerge clean' just after merging binutils ...
#
# NB: thanks to <rac@gentoo.org> for bringing me on the right track
#     (http://forums.gentoo.org/viewtopic.php?t=100263)
#
# <azarah@gentoo.org> (1 Nov 2003)
if [ -n "${STRAP_RUN}" ]
then
    emerge clean || cleanup 1
fi

emerge ${STRAP_EMERGE_OPTS} ${myGCC} || cleanup 1

# Basic support for gcc multi version/arch scheme ...
if [ -n "${STRAP_RUN}" ]
then
	if test -x ${GCC_CONFIG} &>/dev/null && \
	   ${GCC_CONFIG} --get-current-profile &>/dev/null
	then
		# Make sure we get the old gcc unmerged ...
		emerge clean || cleanup 1
		# Make sure the profile and /lib/cpp and /usr/bin/cc are valid ...
		${GCC_CONFIG} "`${GCC_CONFIG} --get-current-profile`" &>/dev/null
	fi
fi

emerge ${STRAP_EMERGE_OPTS} ${myGLIBC} ${myBASELAYOUT} ${myZLIB} || cleanup 1
# ncurses-5.3 and up also build c++ bindings, so we need to rebuild it
export USE="${ORIGUSE}"
emerge ${STRAP_EMERGE_OPTS} ${myNCURSES} || cleanup 1

# Restore original make.conf
cleanup 0

