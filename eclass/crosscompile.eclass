# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the term of the GNU General Public License v2
# Author: Zachary T Welch
# $Header: /var/cvsroot/gentoo-x86/eclass/crosscompile.eclass,v 1.1 2003/03/19 02:50:39 zwelch Exp $

ECLASS=crosscompile
INHERITED="$INHERITED $ECLASS"

DESCRIPTION="Based on the ${ECLASS} eclass"

# set default CBUILD and CCHOST if not set
# CBUILD is the --build for configure
# CCHOST is the --target for configure
[ -n "${CBUILD}" ] || export CBUILD="${CHOST}"
[ -n "${CCHOST}" ] || export CCHOST="${CHOST}"

extract-arch() {
	local ISSPARC=$(expr "${1}" : sparc64)

        if [ $(expr "${1}" : 'i[3456]86') -eq 4 ]; then 
		echo "i386"
	elif [ $(expr "${1}" : alpha) -eq 5 ]; then
		echo "alpha"
	elif [ $(expr "${1}" : arm) -eq 3 ]; then
		echo "arm"
	elif [ $(expr "${1}" : hppa) -eq 4 ]; then
		echo "parisc"
	elif [ $(expr "${1}" : mips) -eq 4 ]; then
		echo "mips"
	elif [ $(expr "${1}" : powerpc) -eq 7 ]; then
		echo "ppc"
	elif  [ ${ISSPARC} -eq 5 ]; then
		echo "sparc"
	elif  [ ${ISSPARC} -eq 7 ]; then
		echo "sparc64"
	else
		echo "unknown"
	fi
}

build-arch() {
	extract-arch "${CBUILD}"
}
chost-arch() {
	extract-arch "${CHOST}"
}
target-arch() {
	extract-arch "${CCHOST}"
}


# this function tests to see if we are currently 
#  building something for another host
cross-build() {
	test "${CBUILD}" != "${CHOST}"
}

# this function tests to see if we are currently
#  building something that targets another host
#  this is useful primarily for cross-compiling tools
#  These tools are typically available in parallel
#  or in extension to the native toolchain(s).
# NOTE: ebuilds must presently handle this type of 
#  parallel installs themselves, but most packages
#  that support --target should provide most of it
cross-target() {
	test "${CHOST}" != "${CCHOST}"
}


# this function should be called by all packages that want
#  to be cross-compile compatible and safe about it.
#  Right now, we take away a couple of obvious bullets from the
#  guns aimed at users' toes... what others remain?
cross-check() {
	# if we're cross compiling, 
	#  be sure to set ROOT or risk overwriting native versions
	if cross-build && [ "${ROOT}" = "/" ]; then
		eerror "You are cross-compiling and have not set ROOT"
		die
	fi

	# if we're targeting another host, 
	#  modify SLOT for parallel install
	if cross-target; then 
		# einfo ">>> Building for --target=${CCHOST}..."
		SLOT="${CCHOST}-${1}"
	else
		SLOT="${1}"
	fi
}

