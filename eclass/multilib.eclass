# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/multilib.eclass,v 1.31 2005/08/08 20:07:43 kito Exp $
#
# Author: Jeremy Huddleston <eradicator@gentoo.org>
#
# This eclass is for all functions pertaining to handling multilib.
# configurations.


DESCRIPTION="Based on the ${ECLASS} eclass"

# has_multilib_profile:
# Return true if the current profile is a multilib profile and lists more than
# one abi in ${MULTILIB_ABIS}.  You might want to use this like
# 'use multilib || has_multilib_profile' until all profiles utilizing the
# 'multilib' use flag are removed from portage

# is_final_abi:
# Return true if ${ABI} is the final abi to be installed (and thus we are
# on our last run through a src_* function.

# number_abis:
# echo the number of ABIs we will be installing for

# get_install_abis:
# Return a list of the ABIs we want to install for with
# the last one in the list being the default.

# get_all_abis:
# Return a list of the ABIs supported by this profile.
# the last one in the list being the default.

# get_all_libdirs:
# Returns a list of all the libdirs used by this profile.  This includes
# those that might not be touched by the current ebuild and always includes
# "lib".

# get_libdir:
# Returns the libdir for the selected ABI.  This is backwards compatible
# and simply calls get_abi_LIBDIR() on newer profiles.  You should use this
# to determine where to install shared objects (ex: /usr/$(get_libdir))

# get_abi_var <VAR> [<ABI>]:
# returns the value of ${<VAR>_<ABI>} which should be set in make.defaults
#
# get_abi_CFLAGS:
# get_abi_CDEFINE:
# get_abi_LIBDIR:
# Aliases for 'get_abi_var CFLAGS', etc.

# get_ml_incdir [<include dir> [<ABI>]]
# include dir defaults to /usr/include
# ABI defaults to ${ABI} or ${DEFAULT_ABI}
#
# If a multilib include dir is associated with the passed include dir, then
# we return it, otherwise, we just echo back the include dir.  This is
# neccessary when a built script greps header files rather than testing them
# via #include (like perl) to figure out features.

# prep_ml_includes:
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

# create_ml_includes <include dir> <symbol 1>:<dir 1> [<symbol 2>:<dir 2> ...]
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

# get_libname [version]
# returns libname with proper suffix {.so,.dylib} and optionally supplied version 
# for ELF/MACH-O shared objects
#
# Example:
# get_libname libfoo ${PV}
# Returns: libfoo.so.${PV} (ELF) || libfoo.${PV}.dylib (MACH)

### END DOCUMENTATION ###

# Defaults:
export MULTILIB_ABIS=${MULTILIB_ABIS:-"default"}
export DEFAULT_ABI=${DEFAULT_ABI:-"default"}
# This causes econf to set --libdir=/usr/lib where it didn't before
#export ABI=${ABI:-"default"}
export CFLAGS_default
export LDFLAGS_default
export CHOST_default=${CHOST_default:-${CHOST}}
export LIBDIR_default=${CONF_LIBDIR:-"lib"}
export CDEFINE_default="__unix__"

# has_multilib_profile()
has_multilib_profile() {
	[ -n "${MULTILIB_ABIS}" -a "${MULTILIB_ABIS}" != "${MULTILIB_ABIS/ /}" ]
}

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
	local CONF_LIBDIR
	if [ -n  "${CONF_LIBDIR_OVERRIDE}" ] ; then
		# if there is an override, we want to use that... always.
		echo ${CONF_LIBDIR_OVERRIDE}
	else
		get_abi_LIBDIR
	fi
}

get_multilibdir() {
	if has_multilib_profile; then
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
	if has_multilib_profile; then
		eerror "get_libdir_override called, but it shouldn't be needed with the new multilib approach.  Please file a bug at http://bugs.gentoo.org and assign it to eradicator@gentoo.org"
		exit 1
	fi
	CONF_LIBDIR="$1"
	CONF_LIBDIR_OVERRIDE="$1"
	LIBDIR_default="$1"
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
		abi="default"
	fi

	local var="${flag}_${abi}"
	echo ${!var}
}

get_abi_CFLAGS() { get_abi_var CFLAGS "${@}"; }
get_abi_LDFLAGS() { get_abi_var LDFLAGS "${@}"; }
get_abi_CHOST() { get_abi_var CHOST "${@}"; }
get_abi_FAKE_TARGETS() { get_abi_var FAKE_TARGETS "${@}"; }
get_abi_CDEFINE() { get_abi_var CDEFINE "${@}"; }
get_abi_LIBDIR() { get_abi_var LIBDIR "${@}"; }

# Return a list of the ABIs we want to install for with
# the last one in the list being the default.
get_install_abis() {
	local order=""

	if [ -z "${MULTILIB_ABIS}" ]; then
		echo "default"
		return 0
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

# Return a list of the ABIs supported by this profile.
# the last one in the list being the default.
get_all_abis() {
	local order=""

	if [ -z "${MULTILIB_ABIS}" ]; then
		echo "default"
		return 0
	fi

	for x in ${MULTILIB_ABIS}; do
		if [ "${x}" != "${DEFAULT_ABI}" ]; then
			order="${order:+${order }}${x}"
		fi
	done
	order="${order:+${order} }${DEFAULT_ABI}"

	echo ${order}
	return 0
}

# get_all_libdirs()
# Returns a list of all the libdirs used by this profile.  This includes
# those that might not be touched by the current ebuild.
get_all_libdirs() {
	local libdirs="lib"
	local abi
	local dir

	if has_multilib_profile; then
		for abi in ${MULTILIB_ABIS}; do
			[ "$(get_abi_LIBDIR ${abi})" != "lib" ] && libdirs="${libdirs} $(get_abi_LIBDIR ${abi})"
		done
	elif [ -n "${CONF_LIBDIR}" ]; then
		for dir in ${CONF_LIBDIR} ${CONF_MULTILIBDIR:-lib32}; do
			[ "${dir}" != "lib" ] && libdirs="${libdirs} ${dir}"
		done
	fi

	echo "${libdirs}"
}

# Return true if ${ABI} is the last ABI on our list (or if we're not
# using the new multilib configuration.  This can be used to determine
# if we're in the last (or only) run through src_{unpack,compile,install}
is_final_abi() {
	has_multilib_profile || return 0
	local ALL_ABIS=$(get_install_abis)
	local LAST_ABI=${ALL_ABIS/* /}
	[[ ${LAST_ABI} == ${ABI} ]]
}

# echo the number of ABIs we will be installing for
number_abis() {
	get_install_abis | wc -w
}

# get_ml_incdir [<include dir> [<ABI>]]
# include dir defaults to /usr/include
# ABI defaults to ${ABI} or ${DEFAULT_ABI}
get_ml_incdir() {
	local dir=/usr/include

	if [[ ${#} -gt 0 ]]; then
		incdir=${1}
		shift
	fi

	if [[ -z "${MULTILIB_ABIS}" ]]; then
		echo ${incdir}
		return 0
	fi

	local abi=${ABI-${DEFAULT_ABI}}
	if [[ ${#} -gt 0 ]]; then
		abi=${1}
		shift
	fi

	if [[ -d "${dir}/gentoo-multilib/${abi}" ]]; then
		echo ${dir}/gentoo-multilib/${abi}
	else
		echo ${dir}
	fi
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
	if [ $(number_abis) -gt 1 ]; then
		local dir
		local dirs
		local base

		if [ ${#} -eq 0 ]; then
			dirs="/usr/include"
		else
			dirs="${@}"
		fi

		for dir in ${dirs}; do
			base=${T}/gentoo-multilib/${dir}/gentoo-multilib
			mkdir -p ${base}
			[ -d ${base}/${ABI} ] && rm -rf ${base}/${ABI}
			mv ${D}/${dir} ${base}/${ABI}
		done

		if is_final_abi; then
			base=${T}/gentoo-multilib
			pushd ${base}
			find . | tar -c -T - -f - | tar -x --no-same-owner -f - -C ${D}
			popd

			for dir in ${dirs}; do
				local args=${dir}
				local abi
				for abi in $(get_install_abis); do
					args="${args} $(get_abi_CDEFINE ${abi}):${dir}/gentoo-multilib/${abi}"
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

			local dir
			for dir in ${basedirs}; do
				if [ -f "${D}/${dir}/${file}" ]; then
					local sym=$(create_ml_includes-sym_for_dir ${dir} ${mlinfo})
					if [[ ${sym::1} == "!" ]]; then
						echo "#ifndef ${sym:1}"
					else
						echo "#ifdef ${sym}"
					fi
					echo "#include <$(create_ml_includes-absolute ${dir}/${file})>"
					echo "#endif /* ${sym} */"
					echo ""
				fi
			done

			#echo "#endif /* __CREATE_ML_INCLUDES_STUB_${name}__ */"
		} > ${D}/${dest}/${file}
	done
}

# Helper function for create_ml_includes
create_ml_includes-absolute() {
	local dst="$(create_ml_includes-tidy_path ${1})"

	dst=(${dst//\// })

	local i
	for ((i=0; i<${#dst[*]}; i++)); do
		[ "${dst[i]}" == "include" ] && break
	done

	local strip_upto=$i

	for ((i=strip_upto+1; i<${#dst[*]}-1; i++)); do
		echo -n ${dst[i]}/
	done

	echo -n ${dst[i]}
}

# Helper function for create_ml_includes
create_ml_includes-tidy_path() {
	local removed="${1}"

	if [ -n "${removed}" ]; then
		# Remove multiple slashes
		while [ "${removed}" != "${removed/\/\//\/}" ]; do
			removed=${removed/\/\//\/}
		done

		# Remove . directories
		while [ "${removed}" != "${removed//\/.\//\/}" ]; do
			removed=${removed//\/.\//\/}
		done
		[ "${removed##*/}" = "." ] && removed=${removed%/*}

		# Removed .. directories
		while [ "${removed}" != "${removed//\/..\/}" ]; do
			local p1="${removed%%\/..\/*}"
			local p2="${removed#*\/..\/}"

			removed="${p1%\/*}/${p2}"
		done

		# Remove trailing ..
		[ "${removed##*/}" = ".." ] && removed=${removed%/*/*}

		# Remove trailing /
		[ "${removed##*/}" = "" ] && removed=${removed%/*}

		echo ${removed}
	fi
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

	local basedir
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
	echo "Shouldn't be here -- create_ml_includes-sym_for_dir ${1} ${@}"
	# exit because we'll likely be called from a subshell
	exit 1
}

get_libname() {
	local ver=$1
	if use userland_Darwin ; then
		if [ -z ${ver} ] ; then
			echo ".dylib"
		else
			echo ".${ver}.dylib"
		fi
	else
		if [ -z ${ver} ] ; then
			echo ".so"
		else
			echo ".so.${ver}"
		fi
	fi
}

