# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the term of the GNU General Public License v2
# Author: Zachary T Welch
# $Header: /var/cvsroot/gentoo-x86/eclass/crosscompile.eclass,v 1.3 2003/04/17 22:55:13 zwelch Exp $

ECLASS=crosscompile
INHERITED="$INHERITED $ECLASS"

DESCRIPTION="Based on the ${ECLASS} eclass"

# CBUILD is the --build for configure
# CHOST is the --host for configure
# CCHOST is the --target for configure

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
	[ -n "${CBUILD}" ] && [ "${CBUILD}" != "${CHOST}" ]
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
	[ -n "${CCHOST}" ] && [ "${CHOST}" != "${CCHOST}" ]
}


# cross-setslot sets the SLOT for a cross-targetable ebuild
#  this prevents portage from unmerging the native version
cross-setslot() {
	cross-target && SLOT="${CCHOST}-${1}" || SLOT="${1}"
}

# The compiler will need to be able to find the header files
# and libs from $ROOT
cross-setflags() {
	CFLAGS="${CFLAGS} -I${ROOT}/usr/include -L${ROOT}lib -L${ROOT}usr/lib"
	CXXFLAGS=${CFLAGS}
}

# this function should be called by all packages that want
#  to be cross-compile compatible and safe about it.
#  Right now, we take away a couple of obvious bullets from the
#  guns aimed at users' toes... what others remain?
cross-check() {
	if cross-build
	then
		# if we're cross compiling, 
		#  be sure to set ROOT or risk overwriting native versions
		if [ "${ROOT}" = "/" ]; then
			eerror "You are cross-compiling and have not set ROOT"
			die
		fi

		# Sets CC and CXX to the correct compilers
		CC=${CHOST}-gcc
		CXX=${CHOST}-gcc

		# For want of a better way I am using filter-flags to
		# invalidate and march or mcpu flags then strip-flags
		# removes any invalid flags.
		# -march=athlonx-xp won't work when targeting something
		# other than an athlon-xp.
		# The correct CFLAGS really needs to get set for CHOST.
		filter-flags "-march= -mcpu="
		strip-flags
	fi
}

# This function is just for diagnostic purposes. It prints the
# environment flags to do with building packages then abort
# the emerge. Saves me having to put a lot of echos in an
# ebuild just to check a few environment variables.
#   Aiken 31/03/2003
cross-diag() {
	cat <<-__EOD__
		CATEGORY = ${CATEGORY}
		DEPEND = ${DEPEND}
		CBUILD = ${CBUILD}
		CHOST = ${CHOST}
		CCHOST = ${CCHOST}
		CC = ${CC}
		CXX = ${CXX}
		CFLAGS = ${CFLAGS}
		CXXFLAGS = ${CXXFLAGS}
		CPPFLAGS = ${CPPFLAGS}
		LDPATH = ${LDPATH}
		PV = ${PV}
		SLOT = ${SLOT}
		ROOT = ${ROOT}
		PATH = ${PATH}
__EOD__
	die "Diagnostics complete"
}

# Create a config.cache that works in the cross compile case.
# Not all packages need this which is good. Generate a local
# config cache then remove information that is specific to 
# building for the host.
#   Aiken 31/03/2003
cross-configure() {
	# Run configure to generate a config.cache
	CC=gcc ./configure --cache-file=config.cache
	mv config.cache config.cache-orig
	make distclean

	# Remove the host specific information.
	grep -v \
		-e bigendian \
		-e ac_cv_env_CC \
		-e ac_cv_env_build_alias \
		-e ac_cv_env_host_alias \
		-e ac_cv_env_target_alias \
		-e ac_cv_env_CFLAGS \
		-e ac_cv_host \
		-e ac_cv_host_alias \
		-e ac_cv_lib_termcap_tgetent \
		-e ac_cv_prog_AR \
		-e ac_cv_prog_CPP \
		-e ac_cv_prog_ac_ct_CC \
		-e ac_cv_prog_ac_ct_RANLIB \
		-e _cv_termcap_lib \
		config.cache-orig > config.cache
}
