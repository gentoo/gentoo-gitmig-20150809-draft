# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/gcc.eclass,v 1.6 2002/09/11 00:57:55 azarah Exp $
# This eclass contains (or should) functions to get common info about gcc
ECLASS=gcc
INHERITED="$INHERITED $ECLASS"

newdepend sys-devel/gcc

DESCRIPTION="Based on the ${ECLASS} eclass"


# NOTE: To force gcc3 if multi ver install, do:  export WANT_GCC_3="yes"
[ -z "${WANT_GCC_3}" ] && export WANT_GCC_3="no"

# Returns the name of the C compiler binary
gcc-getCC() {

	if [ "${WANT_GCC_3}" = "yes" -o -z "${CC}" ]
	then
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
	fi

	echo "${CC}"
}

# Returns the name of the C++ compiler binary
gcc-getCXX() {

	if [ "${WANT_GCC_3}" = "yes" -o -z "${CXX}" ]
	then
		local CC="$(gcc-getCC)"
	
		if [ "$(${CC} -dumpversion | cut -f1 -d.)" -ge 3 ]
		then
			echo "${CC/gcc/g++}"
		else
			echo "${CC}"
		fi
	else
		echo "${CXX}"
	fi
}

# Returns the version as by `$CC -dumpversion`
gcc-fullversion() {

	echo "$($(gcc-getCC) -dumpversion)"
}

# Returns the version, but only the <major>.<minor>
gcc-version() {

	echo "$(gcc-fullversion | cut -f1,2 -d.)"
}

# Returns the Major version
gcc-major-version() {

	echo "$(gcc-version | cut -f1 -d.)"
}

# Returns the Minor version
gcc-minor-version() {

	echo "$(gcc-version | cut -f2 -d.)"
}

# Returns the Micro version
gcc-micro-version() {

	echo "$(gcc-fullversion | cut -f3 -d.)"
}

# Returns gcc's internal library path
gcc-libpath() {

	echo "/usr/lib/gcc-lib/$($(gcc-getCC) -dumpmachine)/$(gcc-fullversion)"
}

# Returns the full version of libstdc++.so
gcc-libstdcxx-version() {

	if [ "$(gcc-major-version)" -ge 3 ]
	then
		local libstdcxx="$(ls $(gcc-libpath)/libstdc++.so.?.?.?)"

		libstdcxx="${libstdcxx##*/}"
		echo "${libstdcxx/libstdc++.so.}"
	else
		echo
	fi
}

# Returns the Major version of libstdc++.so
gcc-libstdcxx-major-version() {

	echo "$(echo $(gcc-libstdcxx-version) | cut -f1 -d.)"
}

