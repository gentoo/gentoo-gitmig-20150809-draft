# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/gcc.eclass,v 1.1 2002/09/09 21:14:07 azarah Exp $
# This eclass contains (or should) functions to get common info about gcc
ECLASS=gcc
INHERITED="$INHERITED $ECLASS"

newdepend sys-devel/gcc

DESCRIPTION="Based on the ${ECLASS} eclass"


gcc-version() {

	local CC="gcc"
	
	if [ "$(eval echo \$\(${CC} -dumpversion\) | cut -f1 -d.)" -ne 3 ]
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
	
	echo "$(${CC} -dumpversion | cut -f1,2 -d.)"
}

gcc-fullversion() {

	local CC="gcc"

	if [ "$(eval echo \$\(${CC} -dumpversion\) | cut -f1 -d.)" -ne 3 ]
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

	echo "`${CC} -dumpversion`"
}

gcc-libpath() {

	local CC="gcc"

	if [ "$(eval echo \$\(${CC} -dumpversion\) | cut -f1 -d.)" -ne 3 ]
	then
		# We use the dual/multiple install of gcc-3.x if the user
		# have 2.95.3 as base
		if [ -x /usr/bin/gcc-3.1 ]
		then
			CC="gcc-3.1"
		elif [ -x /usr/bin/gcc-3.0 ]
		then 
			CC="gcc-3.0"
		fi
	fi

	echo "/usr/lib/gcc-lib/$(${CC} -dumpmachine)/$(gcc-fullversion)"
}

