# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/toolchain-funcs.eclass,v 1.6 2004/10/26 13:01:58 vapier Exp $
#
# Author: Toolchain Ninjas <ninjas@gentoo.org>
#
# This eclass contains (or should) functions to get common info 
# about the toolchain (libc/compiler/binutils/etc...)

inherit eutils

ECLASS=toolchain-funcs
INHERITED="$INHERITED $ECLASS"

DESCRIPTION="Based on the ${ECLASS} eclass"

tc-getPROG() {
	local var="$1"
	local prog="$2"
	local search=""

	if [ -n "${!var}" ] ; then
		echo "${!var}"
		return 0
	fi

	# how should we handle the host/target/build ?
	if [ -n "${CTARGET}" ] ; then
		search="$(type -p "${CTARGET}-${prog}")"
	else
		if [ -n "${CHOST}" ] ; then
			search="$(type -p "${CHOST}-${prog}")"
		fi
	fi

	if [ -n "${search}" ] ; then
		prog="${search##*/}"
	fi
	export ${var}="${prog}"
	echo "${!var}"
}

# Returns the name of the archiver
tc-getAR() { tc-getPROG AR ar; }
# Returns the name of the assembler
tc-getAS() { tc-getPROG AS as; }
# Returns the name of the C compiler
tc-getCC() { tc-getPROG CC gcc; }
# Returns the name of the C++ compiler
tc-getCXX() { tc-getPROG CXX g++; }
# Returns the name of the linker
tc-getLD() { tc-getPROG LD ld; }
# Returns the name of the symbol/object thingy
tc-getNM() { tc-getPROG NM nm; }
# Returns the name of the archiver indexer
tc-getRANLIB() { tc-getPROG RANLIB ranlib; }

# Returns the name of the C compiler for build
tc-getBUILD_CC() {
	if [ -n "${CC_FOR_BUILD}" ] ; then
		echo "${CC_FOR_BUILD}"
		return 0
	fi

	if [ -n "${CBUILD}" ] ; then
		local cc="$(type -p "${CBUILD}-gcc")"
		if [ -n "${cc}" ] ; then
			echo "${cc}"
		fi
	fi

	echo "gcc"
}


# Returns the version as by `$CC -dumpversion`
gcc-fullversion() {
	echo "$($(tc-getCC) -dumpversion)"
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
