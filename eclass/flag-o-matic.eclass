# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/eclass/flag-o-matic.eclass
ECLASS=flag-o-matic

#
#Remove particular flags from C[XX]FLAGS
#
filter-flags () {

	for x in $1; do
		CFLAGS="${CFLAGS/$x}"
		CXXFLAGS="${CXXFLAGS/$x}"
	done

}

#
#Add flags to the current C[XX]FLAGS
#
append-flags () {


	CFLAGS="$CFLAGS $1"
	CXXFLAGS="$CXXFLAGS $1"

}

max-optim () {

	for x in $CFLAGS; do
		echo $x
	done

}
