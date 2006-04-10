# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/mysql_fx.eclass,v 1.12 2006/04/10 21:35:55 vivo Exp $
# $ID: $


# Author: Francesco Riosa <vivo at gentoo.org>
# Maintainer: Francesco Riosa <vivo at gentoo.org>

inherit multilib

# helper function, version (integer) may have section separated by dots
# for readbility
stripdots() {
	local dotver=${1:-"0"}
	while [[ "${dotver/./}" != "${dotver}" ]] ; do dotver="${dotver/./}" ; done
	echo "${dotver:-"0"}"
}

# bool mysql_check_version_range(char * range, int ver=MYSQL_VERSION_ID, int die_on_err=MYSQL_DIE_ON_RANGE_ERROR)
#
# Check if a version number fall inside a range.
# the range include the extremes and must be specified as
# "low_version to hi_version" i.e. "4.00.00.00 to 5.01.99.99"
# Return true if inside the range
# 2005-11-19 <vivo at gentoo.org>
mysql_check_version_range() {
	local lbound="${1%% to *}" ; lbound=$(stripdots "${lbound}")
	local rbound="${1#* to }"  ; rbound=$(stripdots "${rbound}")
	local my_ver="${2:-"${MYSQL_VERSION_ID}"}"
	[[ $lbound -le $my_ver && $my_ver -le $rbound ]] && return 0
	return 1
}

# private bool _mysql_test_patch_easy( int flags, char * pname )
#
# true if found at least one appliable range
# 2005-11-19 <vivo at gentoo.org>
_mysql_test_patch_easy() {
	local filesdir="${WORKDIR}/mysql-extras"
	[[ -d "${filesdir}" ]] || die 'sourcedir must be a directory'
	local flags=$1 pname=$2
	if [[ $(( $flags & 5 )) -eq 5 ]] ; then
		einfo "using \"${pname}\""
		mv "${filesdir}/${pname}" "${EPATCH_SOURCE}" || die "cannot move ${pname}"
		return 0
	fi
	return 1
}

# void mysql_mv_patches(char * index_file, char * filesdir, int my_ver)
#
# parse a "index_file" looking for patches to apply to current
# version.
# If the patch apply then print it's description
# 2005-11-19 <vivo at gentoo.org>
mysql_mv_patches() {
	local index_file="${1:-"${WORKDIR}/mysql-extras/index.txt"}"
	local my_ver="${2:-"${MYSQL_VERSION_ID}"}"
	local my_test_fx=${3:-"_mysql_test_patch_easy"}
	local dsc ndsc=0 i
	dsc=( )

	# values for flags are (2^x):
	#  1 - one patch found
	#  2 - at  least one version range is wrong
	#  4 - at  least one version range is _good_
	local flags=0 pname='' comments=''
	while read row; do
		case "${row}" in
			@patch\ *)
				${my_test_fx} $flags "${pname}" \
				&& for (( i=0 ; $i < $ndsc ; i++ )) ; do einfo ">    ${dsc[$i]}" ; done
				flags=1 ; ndsc=0 ; dsc=( )
				pname=${row#"@patch "}
				;;
			@ver\ *)
				if mysql_check_version_range "${row#"@ver "}" "${my_ver}" ; then
					flags=$(( $flags | 4 ))
				else
					flags=$(( $flags | 2 ))
				fi
				;;
			# @use\ *) ;;
			@@\ *)
				dsc[$ndsc]="${row#"@@ "}"
				(( ++ndsc ))
				;;
		esac
	done < "${index_file}"
	${my_test_fx} $flags "${pname}" \
		&& for (( i=0 ; $i < $ndsc ; i++ )) ; do einfo ">    ${dsc[$i]}" ; done
}

# * char mysql_strip_double_slash()
#
# initialize global variables
# 2005-11-19 <vivo at gentoo.org>
mysql_strip_double_slash() {
	local path="${1}"
	local newpath="${path/\/\///}"
	while [[ ${path} != ${newpath} ]]; do
		path=${newpath}
		newpath="${path/\/\///}"
	done
	echo "${newpath}"
}

# Is $2 (defaults to $MYSQL_VERSION_ID) at least version $1?
# (nice) idea from versionator.eclass
mysql_version_is_at_least() {
	local want_s=$(stripdots "$1") have_s=$( stripdots "${2:-${MYSQL_VERSION_ID}}")
	[[ -z "${want_s}" ]] && die "mysql_version_is_at_least missing value"
	[[ ${want_s} -le ${have_s} ]] && return 0 || return 1
}

# void mysql_lib_symlinks()
#
# To be called on the live filesystem, reassign symlinks to each mysql
# library to the best version available
# 2005-12-30 <vivo at gentoo.org>
mysql_lib_symlinks() {
	local d dirlist maxdots soname sonameln other better
	pushd "${ROOT}/usr/$(get_libdir)" &> /dev/null
		# dirlist must contain the less significative directory left
		dirlist="mysql"

		# waste some time in removing and recreating symlinks
		for d in $dirlist ; do
			for soname in $(find "${d}" -name "*.so*" -and -not -type "l") ; do
				# maxdot is a limit versus infinite loop
				maxdots=0
				sonameln=${soname##*/}
				# loop in version of the library to link it, similar to the
				# libtool work
				while [[ ${sonameln:0-3} != '.so' ]] && [[ ${maxdots} -lt 6 ]]
				do
					rm -f "${sonameln}"
					ln -s "${soname}" "${sonameln}"
					(( ++maxdots ))
					sonameln="${sonameln%.*}"
				done
				rm -f "${sonameln}"
				ln -s "${soname}" "${sonameln}"
			done
		done
	popd &> /dev/null
}
