# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/multilib.eclass,v 1.2 2005/01/12 11:13:28 eradicator Exp $
#
# Author: Jeremy Huddleston <eradicator@gentoo.org>
#
# This eclass is for all functions pertaining to handling multilib.
# configurations.

ECLASS=multilib
INHERITED="$INHERITED $ECLASS"

DESCRIPTION="Based on the ${ECLASS} eclass"

DEPEND="!build? ( sys-apps/sed sys-apps/findutils sys-apps/coreutils )"

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
	elif [ -n "$(get_abi_LIBDIR)" ]; then
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
get_abi_CDEFINE() { get_abi_var CDEFINE ${@}; }
get_abi_LIBDIR() { get_abi_var LIBDIR ${@}; }

# Return a list of the ABIs we want to install for with 
# the last one in the list being the default.
get_abi_order() {
	local order=""

	if [ -z "${MULTILIB_ABIS}" ]; then
		echo "NOMULTILIB"
		return 1
	fi

	if hasq multilib-pkg-force ${RESTRICT} || 
	   { hasq multilib-pkg ${FEATURES} && hasq multilib-pkg ${RESTRICT}; }; then
		for x in ${MULTILIB_ABIS}; do
			if [ "${x}" != "${DEFAULT_ABI}" ]; then
				hasq ${x} ${ABI_DENY} || ordera="${ordera} ${x}"
			fi
		done
		hasq ${DEFAULT_ABI} ${ABI_DENY} || order="${ordera} ${DEFAULT_ABI}"

		if [ -n "${ABI_ALLOW}" ]; then
			local ordera=""
			for x in ${order}; do
				if hasq ${x} ${ABI_ALLOW}; then
					ordera="${ordera} ${x}"
				fi
			done
			order="${ordera}"
		fi
	else
		order="${DEFAULT_ABI}"
	fi

	if [ -z "${order}" ]; then
		die "The ABI list is empty.  Are you using a proper multilib profile?  Perhaps your USE flags or MULTILIB_ABIS are too restrictive for this package."
	fi

	echo ${order}
	return 0
}

# get_all_libdir()
# Returns a list of all the libdirs used by this profile.  This includes
# those that might not be touched by the current ebuild.
get_all_libdirs() {
	local libdirs="lib"
	local abi
	local dir

	if [ -n "${MULTILIB_ABIS}" ]; then
		for abi in ${MULTILIB_ABIS}; do
			[ "$(get_abi_LIBDIR ${abi})" != "lib" ] && libdirs="${libdirs} $(get_abi_LIBDIR ${abi})"
		done
	elif [ -n "${CONF_LIBDIR}" ]; then
		for dir in ${CONF_LIBDIR} ${CONF_MULTILIBDIR:=lib32}; do
			[ "${dir}" != "lib" ] && libdirs="${libdirs} ${dir}"
		done
	fi

	echo "${libdirs}"
}

# Return true if ${ABI} is the last ABI on our list (or if we're not
# using the new multilib configuration.  This can be used to determine
# if we're in the last (or only) run through src_{unpack,compile,install}
is_final_abi() {
	[ -z "${ABI}" ] && return 0
	local ALL_ABIS=$(get_abi_order)
	local LAST_ABI=${ALL_ABIS/* /}
	[ "${LAST_ABI}" = "${ABI}" ]
}

# echo the number of ABIs we will be installing for
number_abis() {
	get_abi_order | wc -w
}

# prep_ml_includes:
#
# Some includes (include/asm, glibc, etc) are ABI dependent.  In this case,
# We can install them in different locations for each ABI and create a common
# header which includes the right one based on CDEFINE_${ABI}.  If your
# package installs ABI-specific headers, just add 'prep_ml_includes' to the
# end of your src_install().  It takes a list of directories that include
# files are installed in (default is /usr/include if none are passed).
#
# Example:
# src_install() {
#    ...
#    prep_ml_includes /usr/qt/3/include
# }

prep_ml_includes() {
	local dirs
	if [ ${#} -eq 0 ]; then
		dirs="/usr/include"
	else
		dirs="${@}"
	fi

	if [ $(number_abis) -gt 1 ]; then
		local dir
		for dir in ${dirs}; do
			mv ${D}/${dir} ${D}/${dir}.${ABI}
		done

		if is_final_abi; then
			for dir in ${dirs}; do
				local args="${dir}"
				local abi
				for abi in $(get_abi_order); do
					args="${args} $(get_abi_CDEFINE ${abi})${dir}.${abi}"
				done
				create_ml_includes ${args}
			done
		fi
	fi
}

# If you need more control than prep_ml_includes can offer (like linux-headers
# for the asm-* dirs, then use create_ml_includes.  The firs argument is the
# common dir.  The remaining args are of the form <symbol>:<dir> where
# <symbol> is what is put in the #ifdef for choosing that dir.
#
# Ideas for this code came from debian's sparc-linux headers package.
#
# Example:
# create_ml_includes /usr/include/asm __sparc__:/usr/include/asm-sparc __sparc64__:/usr/include/asm-sparc64
# create_ml_includes /usr/include/asm __i386__:/usr/include/asm-i386 __x86_64__:/usr/include/asm-x86_64
create_ml_includes() {
	local dest="${1}"
	shift
	local mlinfo="${@}"
	local basedirs=$(create_ml_includes-listdirs ${mlinfo})

	create_ml_includes-makedestdirs ${dest} ${basedirs}

	local file
	for file in $(create_ml_includes-allfiles ${basedirs}); do
		local name="$(echo $file | tr a-z A-Z | sed 's:[^A-Z]:_:g')"
		{
			echo "/* Common header file autogenerated by create_ml_includes in multilib.eclass */"
			echo "#ifndef __CREATE_ML_INCLUDES_STUB_${name}__"
			echo "#define __CREATE_ML_INCLUDES_STUB_${name}__"
			echo ""

			local dir
			for dir in ${basedirs}; do
				if [ -f "${D}/${dir}/${file}" ]; then
					echo "#ifdef $(create_ml_includes-sym_for_dir ${dir} ${mlinfo})"
					echo "#include \"$(create_ml_includes-relative_between ${dest} ${dir})/${file}\""
					echo "#endif /* $(create_ml_includes-sym_for_dir ${dir} ${mlinfo}) */"
					echo ""
				fi
			done

			echo "#endif /* __CREATE_ML_INCLUDES_STUB_${name}__ */"
		} > ${D}/${dest}/${file}
	done
}

# Helper function for create_ml_includes
# TODO: This needs to be updated to spit out relative paths...
create_ml_includes-relative_between() {
	local from=${1}
	local to=${2}
	
	echo "${ROOT}${to}"
}

# Helper function for create_ml_includes
create_ml_includes-listdirs() {
	local dirs
	local data
	for data in ${@}; do
		dirs="${dirs} ${data/*:/}"
	done
	echo ${dirs:1}
}

# Helper function for create_ml_includes
create_ml_includes-makedestdirs() {
	local dest=${1}
	shift
	local basedirs=${@}

	dodir ${dest}

	local basedir
	for basedir in ${basedirs}; do
		local dir
		for dir in $(find ${D}/${basedir} -type d); do
			dodir ${dest}/${dir/${D}\/${basedir}/}
		done
	done
}

# Helper function for create_ml_includes
create_ml_includes-allfiles() {
	local basedirs=${@}

	local files
	for basedir in ${basedirs}; do
		local file
		for file in $(find ${D}/${basedir} -type f); do
			echo ${file/${D}\/${basedir}\//}
		done
	done | sort | uniq
}

# Helper function for create_ml_includes
create_ml_includes-sym_for_dir() {
	local dir="${1}"
	shift
	local data
	for data in ${@}; do
		if [ "${dir}" = "${data/*:/}" ]; then
			echo ${data/:*/}
			return 0
		fi
	done
	echo "Should be here -- create_ml_includes-sym_for_dir ${1} ${@}"
	# exit because we'll likely be called from a subshell
	exit 1
}
