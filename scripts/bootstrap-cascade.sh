#!/bin/bash
# Copyright 1999-2004 Gento Foundation.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/scripts/bootstrap-cascade.sh,v 1.7 2004/07/19 05:02:32 solar Exp $

# drobbins optimized this script at some point which made a bootstrap
# to complete 20 mins to 2 hours faster, depending on CPU. He did this
# by merging both stages of bootstrap into a single stage. In doing so
# we no longer compile gcc and binutils twice.  Doing this is said to be
# unnecessary and a holdover from very early versions of Gentoo.

# (drobbins, 06 Jun 2003)
# (solar, Jul 2004)

unset STRAP_EMERGE_OPTS 
STRAP_RUN=1

for opt in $* ; do
	case $opt in
		--fetchonly|-f)
			echo "Running in fetch-only mode..."
			STRAP_EMERGE_OPTS="-f"
			unset STRAP_RUN;;
		-h|--help)
			echo "bootstrap-cascade.sh: Please run with no arguments to start bootstrap, or specify"
			echo "--fetchonly or -f to download source archives only. -h/--help displays this"
			echo "help."
			exit 1;;
		--info) STRAP_EMERGE_OPTS="${STRAP_EMERGE_OPTS} --info"   ; unset STRAP_RUN ;;
		--pretend|-p) STRAP_EMERGE_OPTS="${STRAP_EMERGE_OPTS} -p" ; unset STRAP_RUN ;;
		--verbose|-v) STRAP_EMERGE_OPTS="${STRAP_EMERGE_OPTS} -v";;
		--debug|-d) STRAP_EMERGE_OPTS="${STRAP_EMERGE_OPTS} --debug"; DEBUG=1;;
		*) ;;
	esac
done

MYPROFILEDIR="`readlink -f /etc/make.profile`"
if [ ! -d ${MYPROFILEDIR} ]; then
	echo "!!! Error:  ${MYPROFILEDIR} does not exist. Exiting."
	exit 1
fi

# spython is 1.0_rc6 and earlier and python is 1.0 and later
[ -e /usr/bin/spython ] && PYTHON="/usr/bin/spython" || PYTHON="/usr/bin/python"

if [ -e /etc/init.d/functions.sh ]; then
	source /etc/init.d/functions.sh

	# Use our own custom script, else logger cause things to
	# 'freeze' if we do not have a system logger running
	esyslog() {
		echo &> /dev/null
	}
fi

[ -e /etc/profile ] && source /etc/profile

echo -e "\n${GOOD}Gentoo Linux${GENTOO_VERS}; \e[34;01mhttp://www.gentoo.org/${NORMAL}"
echo -e "Copyright 2001-2004 Gentoo Foundation.; Distributed under the GPL"
if [ "${STRAP_EMERGE_OPTS:0:2}" = "-f" ]; then
	echo "Fetching all bootstrap-related archives..."
else
	echo "Starting Bootstrap of base system ..."
fi
echo -------------------------------------------------------------------------------

# This should not be set to get glibc to build properly. See bug #7652.
unset LD_LIBRARY_PATH

# We do not want stray $TMP, $TMPDIR or $TEMP settings
unset TMP TMPDIR TEMP

cleanup() {
	if [ -n "${STRAP_RUN}" ]; then
		if [ -f /etc/make.conf.build ]; then
			mv -f /etc/make.conf.build /etc/make.conf
		fi
	fi
	exit $1
}

pycmd() {
	[ "${DEBUG}" = 1 ] && echo ${PYTHON} -c "$*" > /dev/stderr
	${PYTHON} -c "$*"
}

# Trap ctrl-c and stuff.  This should fix the users make.conf
# not being restored.
[ -n "${STRAP_RUN}" ] && cp -f /etc/make.conf /etc/make.conf.build

#TSTP messes ^Z of bootstrap up, so we don't trap it anymore.
trap "cleanup" TERM KILL INT QUIT ABRT

# USE may be set from the environment so we back it up for later.
export ORIGUSE="$(pycmd 'import portage; print portage.settings["USE"];')"

# Check for 'build' or 'bootstrap' in USE ...
INVALID_USE="`gawk -v ORIGUSE="${ORIGUSE}" '
	BEGIN { 
		if (ORIGUSE ~ /[[:space:]]*(build|bootstrap)[[:space:]]*/)
			print "yes"
	}'`"

# Do not do the check for stage build scripts ...
if [ "${INVALID_USE}" = "yes" ]; then
	echo
	eerror "You have 'build' or 'bootstrap' in your USE flags. Please"
	eerror "remove it before trying to continue, since these USE flags"
	eerror "are used for internal purposes and shouldn't be specified"
	eerror "by you."
	echo
	cleanup 1
fi

# bug #50158 (don't use `which` in a bootstrap).
if ! type -path portageq &>/dev/null; then
	echo
	eerror "Your portage version is too old.  Please use a later stage1 image."
	echo
	cleanup 1
fi

# gettext should only be needed when used with nls
for opt in ${ORIGUSE} ; do
	case "${opt}" in
		nls) myGETTEXT="gettext";;
		nptl)
			if [ -z "`portageq best_visible / '>=sys-kernel/linux26-headers-2.6.0'`" ]; then
				eerror "You need to have >=sys-kernel/linux26-headers-2.6.0 unmasked!"
				eerror "Please edit the latest >=sys-kernel/linux26-headers-2.6.0 package,"
				eerror "and add your ARCH to KEYWORDS."
				echo
				cleanup 1
			fi
			USE_NPTL=1
		;;
	esac
done

# With cascading profiles, the packages profile at the leaf is not a
# complete system, just the restrictions to it for the specific profile.
# The complete profile consists of an aggregate of the leaf and all its
# parents.  So we now call portage to read the aggregate profile and store
# that into a variable.

eval $(pycmd 'import portage; print portage.settings.packages;' |
sed 's/[][,]//g; s/ /\n/g; s/\*//g' | while read p; do n=${p##*/}; n=${n%\'};
n=${n%%-[0-9]*}; echo "my$(tr a-z- A-Z_ <<<$n)=$p; "; done)

# this stuff should never fail but will if not enough is installed.
[ "${myBASELAYOUT}" = "" ] && myBASELAYOUT="$(portageq best_version / virtual/baselayout)"
[ "${myBASELAYOUT}" = "" ] && myBASELAYOUT="baselayout"
[ "${myPORTAGE}" = "" ] && myPORTAGE="portage"
[ "${myBINUTILS}" = "" ] && myBINUTILS="binutils"
[ "${myGCC}" = "" ] && myGCC="gcc"
#[ "${myGETTEXT}" = "" ] && myGETTEXT="gettext" ; # We only gettext if nls is desired.
[ "${myLIBC}" = "" ] && myLIBC="virtual/libc"
# texinfo; category/PN combo due to app-xemacs/texinfo
[ "${myTEXINFO}" = "" ] && myTEXINFO="sys-apps/texinfo"
[ "${myZLIB}" = "" ] && myZLIB="zlib"
[ "${myNCURSES}" = "" ] && myNCURSES="ncurses"

# Do we really have no 2.4.x nptl kernels in portage?
[ "${USE_NPTL}" = 1 ] && myOS_HEADERS="$(portageq best_visible / '>=sys-kernel/linux26-headers-2.6.0')"
[ "${myOS_HEADERS}" = "" ] && myOS_HEADERS="virtual/os-headers"

einfo "Using baselayout : ${myBASELAYOUT}"
einfo "Using portage    : ${myPORTAGE}"
einfo "Using os-headers : ${myOS_HEADERS}"
einfo "Using binutils   : ${myBINUTILS}"
einfo "Using gcc        : ${myGCC}"
[ "${myGETTEXT}" != "" ] && einfo "Using gettext    : ${myGETTEXT}"
einfo "Using libc       : ${myLIBC}"
einfo "Using texinfo    : ${myTEXINFO}"
einfo "Using zlib       : ${myZLIB}"
einfo "Using ncurses    : ${myNCURSES}"
echo -------------------------------------------------------------------------------
echo "Configuring environment..."

# Get correct CFLAGS, CHOST, CXXFLAGS, MAKEOPTS since make.conf will be
# overwritten.

ENV_EXPORTS="GENTOO_MIRRORS PORTDIR DISTDIR PKGDIR PORTAGE_TMPDIR
	CFLAGS CHOST CXXFLAGS MAKEOPTS ACCEPT_KEYWORDS PROXY HTTP_PROXY
	FTP_PROXY FEATURES"

for opt in ${ENV_EXPORTS}; do
	val=$(pycmd 'import portage; print portage.settings["'${opt}'"];' )
	if [ "${val}" != "" ]; then
		einfo "${opt}='${val}'"
		export ${opt}="${val}"
	fi
done
echo -------------------------------------------------------------------------------

[ -x /usr/sbin/gcc-config ] && GCC_CONFIG="/usr/sbin/gcc-config"
[ -x /usr/bin/gcc-config  ] && GCC_CONFIG="/usr/bin/gcc-config"

# Disable autoclean, or it b0rks
export AUTOCLEAN="no"

# Allow portage to overwrite stuff
export CONFIG_PROTECT="-*"

# disable collision-protection
export FEATURES="${FEATURES} -collision-protect"

USE="-* build bootstrap" emerge ${STRAP_EMERGE_OPTS} ${myPORTAGE} || cleanup 1
echo -------------------------------------------------------------------------------
export USE="${ORIGUSE} bootstrap"
#emerge ${STRAP_EMERGE_OPTS} -C virtual/os-headers || cleanup 1
emerge ${STRAP_EMERGE_OPTS} ${myOS_HEADERS} ${myTEXINFO} ${myGETTEXT} ${myBINUTILS} || cleanup 1
echo -------------------------------------------------------------------------------

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
if [ -n "${STRAP_RUN}" ]; then
    emerge clean || cleanup 1
fi

emerge ${STRAP_EMERGE_OPTS} ${myGCC} || cleanup 1
echo -------------------------------------------------------------------------------

# Basic support for gcc multi version/arch scheme ...
if [ -n "${STRAP_RUN}" ]; then
	if test -x ${GCC_CONFIG} &>/dev/null && \
	   ${GCC_CONFIG} --get-current-profile &>/dev/null
	then
		# Make sure we get the old gcc unmerged ...
		emerge clean || cleanup 1
		# Make sure the profile and /lib/cpp and /usr/bin/cc are valid ...
		${GCC_CONFIG} "`${GCC_CONFIG} --get-current-profile`" &>/dev/null
	fi
fi

emerge ${STRAP_EMERGE_OPTS} ${myLIBC} ${myBASELAYOUT} ${myZLIB} || cleanup 1
echo -------------------------------------------------------------------------------

# ncurses-5.3 and up also build c++ bindings, so we need to rebuild it
export USE="${ORIGUSE}"
emerge ${STRAP_EMERGE_OPTS} ${myNCURSES} || cleanup 1
echo -------------------------------------------------------------------------------

# Restore original make.conf
cleanup 0
