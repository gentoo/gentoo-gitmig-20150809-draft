# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/eclass/flag-o-matic.eclass
ECLASS=flag-o-matic

filter-flags () {

	for x in $1; do
		CFLAGS="${CFLAGS/$x}"
		CXXFLAGS="${CXXFLAGS/$x}"
	done

}

max-optim () {

	for x in $CFLAGS; do
		echo $x
	done

}
