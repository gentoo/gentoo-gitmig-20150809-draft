# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/gcc.eclass,v 1.3 2002/09/11 00:40:39 azarah Exp $
# This eclass contains (or should) functions to get common info about gcc
ECLASS=gcc
INHERITED="$INHERITED $ECLASS"

newdepend sys-devel/gcc

DESCRIPTION="Based on the ${ECLASS} eclass"


# NOTE: To force gcc3 if multi ver install, do:  export WANT_GCC_3="yes"
[ -z "${WANT_GCC_3}" ] && export WANT_GCC_3="no"

gcc-getCC() {

	local CC="gcc"

	if [ "$(${CC} -dumpversion | cut -f1 -d.)" -ne 3 ] && \
	   [ "${WANT_GCC_3}" = "yes" ]
	then
		# We use the dual/multiple install of gcc-3.x if the user
		# have 2.95.3 as base
		if [ -x /usr/bin/gcc-3.2 ]
		then
			CC="gcc-3.2"
		elif [ -x /usr/bin/gcc-3.1 ]
		then
			CC="gcc-3.1"
		elif [ -x /usr/bin/gcc-3.0 ]
		then
			CC="gcc-3.0"
		fi
	fi

	echo "${CC}"
}

gcc-getCXX() {

	CC="$(gcc-getCC)"
	
	if [ "$(${CC} -dumpversion | cut -f1 -d.)" -eq 3 ]
	then
		echo "${CC/gcc/g++}"
	else
		echo "${CC}"
	fi
}

gcc-fullversion() {

	echo "$($(gcc-getCC) -dumpversion)"
}

gcc-version() {

	echo "$(gcc-fullversion | cut -f1,2 -d.)"
}

gcc-major-version() {

	echo "$(gcc-version | cut -f1 -d.)"
}

gcc-minor-version() {

	echo "$(gcc-version | cut -f2 -d.)"
}

gcc-micro-version() {

	echo "$(gcc-fullversion | cut -f3 -d.)"
}

gcc-libpath() {

	echo "/usr/lib/gcc-lib/$($(gcc-getCC) -dumpmachine)/$(gcc-fullversion)"
}

gcc-libstdc-version() {

	if [ "$(gcc-major-version)" -ge 3 ]
	then
		local libstdc="$(ls $(gcc-libpath)/libstdc++.so.?.?.?)"

		libstdc="${libstdc##*/}"
		echo "${libstdc/libstdc++.so.}"
	else
		echo
	fi
}

gcc-libstdc-major-version() {

	echo "$(echo $(gcc-libstdc-version) | cut -f1 -d.)"
}

