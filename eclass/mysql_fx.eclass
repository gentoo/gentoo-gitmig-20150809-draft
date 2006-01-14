# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/mysql_fx.eclass,v 1.3 2006/01/14 19:00:32 vivo Exp $

# Author: Francesco Riosa <vivo at gentoo.org>
# Maintainer: Francesco Riosa <vivo at gentoo.org>

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
	local dsc=(), ndsc=0 i

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
				flags=1 ; ndsc=0 ; dsc=()
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


# void mysql_init_vars()
#
# initialize global variables
# 2005-11-19 <vivo at gentoo.org>
mysql_init_vars() {

	if [[ ${SLOT} -eq 0 ]] ; then
		MY_SUFFIX=""
	else
		MY_SUFFIX=${MY_SUFFIX:-"-${SLOT}"}
	fi
	MY_SHAREDSTATEDIR=${MY_SHAREDSTATEDIR:-"/usr/share/mysql${MY_SUFFIX}"}
	MY_SYSCONFDIR=${MY_SYSCONFDIR="/etc/mysql${MY_SUFFIX}"}
	MY_LIBDIR=${MY_LIBDIR="/usr/$(get_libdir)/mysql${MY_SUFFIX}"}
	MY_LOCALSTATEDIR=${MY_LOCALSTATEDIR="/var/lib/mysql${MY_SUFFIX}"}
	MY_LOGDIR=${MY_LOGDIR="/var/log/mysql${MY_SUFFIX}"}
	MY_INCLUDEDIR=${MY_INCLUDEDIR="/usr/include/mysql${MY_SUFFIX}"}

	if [ -z "${DATADIR}" ]; then
		DATADIR=""
		if [ -f "${SYSCONFDIR}/my.cnf" ] ; then
			DATADIR=`"my_print_defaults${MY_SUFFIX}" mysqld 2>/dev/null | sed -ne '/datadir/s|^--datadir=||p' | tail -n1`
			if [ -z "${DATADIR}" ]; then
				DATADIR=`grep ^datadir "${SYSCONFDIR}/my.cnf" | sed -e 's/.*=\s*//'`
			fi
		fi
		if [ -z "${DATADIR}" ]; then
			DATADIR="${MY_LOCALSTATEDIR}"
			einfo "Using default DATADIR"
		fi
		einfo "MySQL DATADIR is ${DATADIR}"

		if [ -z "${PREVIOUS_DATADIR}" ] ; then
			if [ -a "${DATADIR}" ] ; then
				ewarn "Previous datadir found, it's YOUR job to change"
				ewarn "ownership and have care of it"
				PREVIOUS_DATADIR="yes"
				export PREVIOUS_DATADIR
			else
				PREVIOUS_DATADIR="no"
				export PREVIOUS_DATADIR
			fi
		fi
	fi

	export MY_SUFFIX MY_SHAREDSTATEDIR MY_SYSCONFDIR
	export MY_LIBDIR MY_LOCALSTATEDIR MY_LOGDIR
	export MY_INCLUDEDIR
	export DATADIR
}

# void mysql_init_vars()
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

# another one inherited from versionator.eclass (version_sort)
mysql_make_file_list() {
	local items= left=0
	items=( ${1}-[[:digit:]][[:digit:]][[:digit:]] )
	[[ "${items}" == "${1}-[[:digit:]][[:digit:]][[:digit:]]" ]] && items=( )

	while [[ ${left} -lt ${#items[@]} ]] ; do
		local lowest_idx=${left}
		local idx=$(( ${lowest_idx} + 1 ))
		while [[ ${idx} -lt ${#items[@]} ]] ; do
			[[ "${items[${lowest_idx}]}" > "${items[${idx}]}" ]] \
				&& lowest_idx=${idx}
			idx=$(( ${idx} + 1 ))
		done
		local tmp=${items[${lowest_idx}]}
		items[${lowest_idx}]=${items[${left}]}
		items[${left}]=${tmp}
		left=$(( ${left} + 1 ))
	done
	echo ${items[@]}
}

mysql_choose_better_version() {
	local items= better="" i
	items=${1}-[[:digit:]][[:digit:]][[:digit:]]
	[[ "${items}" == "${1}-[[:digit:]][[:digit:]][[:digit:]]" ]] && items=""
	for i in ${items} ; do
		if [[ "${i}" > "${better}" ]] ; then
			better="${i}"
		fi
	done
	echo "${better}"
}


# void mysql_lib_symlinks()
#
# To be called on the live filesystem, reassign symlinks to each mysql
# library to the best version avaiable
# 2005-12-30 <vivo at gentoo.org>
mysql_lib_symlinks() {
	local d dirlist maxdots soname sonameln other better
	pushd "${ROOT}/usr/$(get_libdir)/"
		# dirlist must contain the less significative directory left
		dirlist="mysql (mysql_make_file_list mysql)"

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
	popd

	# "include"s and "mysql_config", needed to compile other sw
	for other in "/usr/include/mysql" "/usr/bin/mysql_config" ; do
		pushd "${ROOT}${other%/*}" &> /dev/null
		if ! [[ -d "${other##*/}" ]] ; then
			better=$( mysql_choose_better_version "${other##*/}" )
			[[ -L "${other##*/}" ]] && rm -f "${other##*/}"
			! [[ -f "${other##*/}" ]] && ln -sf "${better}" "${other##*/}"
		fi
		popd &> /dev/null
	done
}
