# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/multilib.eclass,v 1.1 2005/01/12 00:21:53 eradicator Exp $
#
# Author: Jeremy Huddleston <eradicator@gentoo.org>
#
# This eclass is for all functions pertaining to handling multilib.
# configurations.

ECLASS=multilib
INHERITED="$INHERITED $ECLASS"

DESCRIPTION="Based on the ${ECLASS} eclass"

# This function simply returns the desired lib directory. With portage
# 2.0.51, we now have support for installing libraries to lib32/lib64
# to accomidate the needs of multilib systems. It's no longer a good idea
# to assume all libraries will end up in lib. Replace any (sane) instances
# where lib is named directly with $(get_libdir) if possible.
#
# Travis Tilley <lv@gentoo.org> (24 Aug 2004)
#
# Jeremy Huddleston <eradicator@gentoo.org> (23 Dec 2004):
#   Added support for ${ABI} and ${DEFAULT_ABI}.  If they're both not set,
#   fall back on old behavior.  Any profile that has these set should also
#   depend on a newer version of portage (not yet released) which uses these
#   over CONF_LIBDIR in econf, dolib, etc...
get_libdir() {
	LIBDIR_TEST=$(type econf)
	if [ ! -z "${CONF_LIBDIR_OVERRIDE}" ] ; then
		# if there is an override, we want to use that... always.
		CONF_LIBDIR="${CONF_LIBDIR_OVERRIDE}"
	# We don't need to know the verison of portage. We only need to know
	# if there is support for CONF_LIBDIR in econf and co.
	# Danny van Dyk <kugelfang@gentoo.org> 2004/17/09 
	#elif portageq has_version / '<sys-apps/portage-2.0.51_pre20' ; then
	#	# and if there isnt an override, and we're using a version of
	#	# portage without CONF_LIBDIR support, force the use of lib. dolib
	#	# and friends from portage 2.0.50 wont be too happy otherwise.
	#	CONF_LIBDIR="lib"
	#fi
	elif [ -n "$(get_abi_LIBDIR)" ]; then # Using eradicator's LIBDIR_<abi> approach...
		CONF_LIBDIR="$(get_abi_LIBDIR)"
	elif [ "${LIBDIR_TEST/CONF_LIBDIR}" == "${LIBDIR_TEST}" ]; then # we don't have CONF_LIBDIR support
		# will be <portage-2.0.51_pre20
		CONF_LIBDIR="lib"
	fi
	# and of course, default to lib if CONF_LIBDIR isnt set
	echo ${CONF_LIBDIR:=lib}
	unset LIBDIR_TEST
}

get_multilibdir() {
	if [ -n "$(get_abi_LIBDIR)" ]; then
		eerror "get_multilibdir called, but it shouldn't be needed with the new multilib approach.  Please file a bug at http://bugs.gentoo.org and assign it to eradicator@gentoo.org"
		exit 1
	fi
	echo ${CONF_MULTILIBDIR:=lib32}
}

# Sometimes you need to override the value returned by get_libdir. A good
# example of this is xorg-x11, where lib32 isnt a supported configuration,
# and where lib64 -must- be used on amd64 (for applications that need lib
# to be 32bit, such as adobe acrobat). Note that this override also bypasses
# portage version sanity checking.
# get_libdir_override expects one argument, the result get_libdir should
# return:
#
#   get_libdir_override lib64
#
# Travis Tilley <lv@gentoo.org> (31 Aug 2004)
get_libdir_override() {
	if [ -n "$(get_abi_LIBDIR)" ]; then
		eerror "get_libdir_override called, but it shouldn't be needed with the new multilib approach.  Please file a bug at http://bugs.gentoo.org and assign it to eradicator@gentoo.org"
		exit 1
	fi
	CONF_LIBDIR="$1"
	CONF_LIBDIR_OVERRIDE="$1"
}

# get_abi_var <VAR> [<ABI>]
# returns the value of ${<VAR>_<ABI>} which should be set in make.defaults
#
# ex:
# CFLAGS=$(get_abi_var CFLAGS sparc32) # CFLAGS=-m32
#
# Note that the prefered method is to set CC="$(tc-getCC) $(get_abi_CFLAGS)"
# This will hopefully be added to portage soon...
#
# If <ABI> is not specified, ${ABI} is used.
# If <ABI> is not specified and ${ABI} is not defined, ${DEFAULT_ABI} is used.
# If <ABI> is not specified and ${ABI} and ${DEFAULT_ABI} are not defined, we return an empty string.
#
# Jeremy Huddleston <eradicator@gentoo.org>
get_abi_var() {
	local flag=${1}
	local abi
	if [ $# -gt 1 ]; then
		abi=${2}
	elif [ -n "${ABI}" ]; then
		abi=${ABI}
	elif [ -n "${DEFAULT_ABI}" ]; then
		abi=${DEFAULT_ABI}
	else
		return 1
	fi

	local var="${flag}_${abi}"
	echo ${!var}
}

get_abi_CFLAGS() { get_abi_var CFLAGS ${@}; }
get_abi_CXXFLAGS() { get_abi_var CXXFLAGS ${@}; }
get_abi_ASFLAGS() { get_abi_var ASFLAGS ${@}; }
get_abi_LIBDIR() { get_abi_var LIBDIR ${@}; }

# get_all_libdir()
# Returns a list of all the libdirs used by this profile
get_all_libdirs() {
	local libdirs
	if [ -n "${MULTILIB_ABIS}" ]; then
		for abi in ${MULTILIB_ABIS}; do
			libdirs="${libdirs} $(get_abi_LIBDIR ${abi})"
		done
		libdirs="${libdirs:1}"
	elif [ -n "${CONF_LIBDIR}" ]; then
		libdirs="${CONF_LIBDIR} ${CONF_MULTILIBDIR:=lib32}"
	else
		libdirs="lib"
	fi

	echo "${libdirs}"
}
