# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/eclass/flag-o-matic.eclass
ECLASS=flag-o-matic
INHERITED="$INHERITED $ECLASS"
#
#### filter-flags <flag> ####
# Remove particular flags from C[XX]FLAGS
#
#### append-flags <flag> ####
# Add extra flags to your current C[XX]FLAGS
#
#### replace-flags <orig.flag> <new.flag> ###
# Replace a flag by another one
#
#### is-flag <flag> ####
# Returns "true" if flag is set in C[XX]FLAGS
# Matches only complete flag
#

filter-flags () {

	for x in $1; do
		CFLAGS="${CFLAGS/$x}"
		CXXFLAGS="${CXXFLAGS/$x}"
	done

}

append-flags () {


	CFLAGS="$CFLAGS $1"
	CXXFLAGS="$CXXFLAGS $1"

}

replace-flags () {

	CFLAGS="${CFLAGS/${1}/${2}}"
	CXXFLAGS="${CXXFLAGS/${1}/${2}}"

}

is-flag() {

	for x in $CFLAGS $CXXFLAGS; do
	    if [ "$x" == "$1" ]; then
		echo true
		break
	    fi
	done

}
