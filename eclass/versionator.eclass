# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/versionator.eclass,v 1.1 2004/09/10 18:45:01 ciaranm Exp $
#
# Original Author: Ciaran McCreesh <ciaranm@gentoo.org>
#
# This eclass provides functions which simplify manipulating $PV and similar
# variables. Most functions default to working with $PV, although other
# values can be used.
#
# Simple Example 1: $PV is 1.2.3b, we want 1_2.3b:
#     MY_PV=$(replace_version_separator 1 '_' )
#
# Simple Example 2: $PV is 1.4.5, we want 1:
#     MY_MAJORV=$(get_major_version )
#
# Full list of user usable functions provided by this eclass (see the functions
# themselves for documentation):
#     get_all_version_components      ver_str
#     get_version_components          ver_str
#     get_major_version               ver_str
#     get_version_component_range     range     ver_str
#     get_after_major_version         ver_str
#     replace_version_separator       index     newvalue   ver_str
#     replace_all_version_separators  newvalue  ver_str

ECLASS=versionator
INHERITED="$INHERITED $ECLASS"

shopt -s extglob

# Split up a version string into its component parts. If no parameter is
# supplied, defaults to $PV.
#     0.8.3       ->  0 . 8 . 3
#     7c          ->  7 c
#     3.0_p2      ->  3 . 0 _ p2
#     20040905    ->  20040905
#     3.0c-r1     ->  3 . 0 c - r1
get_all_version_components() {
	local ver_str=${1:-${PV}} result result_idx=0
	result=( )

	# sneaky cache trick cache to avoid having to parse the same thing several
	# times.
	if [[ "${VERSIONATOR_CACHE_VER_STR}" == "${ver_str}" ]] ; then
		echo ${VERSIONATOR_CACHE_RESULT}
		return
	fi
	export VERSIONATOR_CACHE_VER_STR="${ver_str}"

	while [[ -n "$ver_str" ]] ; do
		case "${ver_str:0:1}" in
			# number: parse whilst we have a number
			[[:digit:]])
				result[$result_idx]="${ver_str%%[^[:digit:]]*}"
				ver_str="${ver_str##+([[:digit:]])}"
				result_idx=$(($result_idx + 1))
				;;

			# separator: single character
			[-_.])
				result[$result_idx]="${ver_str:0:1}"
				ver_str="${ver_str:1}"
				result_idx=$(($result_idx + 1))
				;;

			# letter: grab the letters plus any following numbers
			[[:alpha:]])
				local not_match="${ver_str##+([[:alpha:]])*([[:digit:]])}"
				result[$result_idx]=${ver_str:0:$((${#ver_str} - ${#not_match}))}
				ver_str="${not_match}"
				result_idx=$(($result_idx + 1))
				;;

			# huh?
			*)
				result[$result_idx]="${ver_str:0:1}"
				ver_str="${ver_str:1}"
				result_idx=$(($result_idx + 1))
				;;
		esac
	done

	export VERSIONATOR_CACHE_RESULT="${result[@]}"
	echo ${result[@]}
}

# Get the important version components, excluding '.', '-' and '_'. Defaults to
# $PV if no parameter is supplied.
#     0.8.3       ->  0 8 3
#     7c          ->  7 c
#     3.0_p2      ->  3 0 p2
#     20040905    ->  20040905
#     3.0c-r1     ->  3 0 c r1
get_version_components() {
	local c="$(get_all_version_components "${1:-${PV}}")"
	c=( ${c[@]//[-._]/ } )
	echo ${c[@]}
}

# Get the major version of a value. Defaults to $PV if no parameter is supplied.
#     0.8.3       ->  0
#     7c          ->  7
#     3.0_p2      ->  3
#     20040905    ->  20040905
#     3.0c-r1     ->  3
get_major_version() {
	local c
	c=( $(get_all_version_components "${1:-${PV}}" ) )
	echo ${c[0]}
}

# Get a particular component or range of components from the version. If no
# version parameter is supplied, defaults to $PV.
#    1      1.2.3       -> 1
#    1-2    1.2.3       -> 1.2
#    2-     1.2.3       -> 2.3
get_version_component_range() {
	local c v="${2:-${PV}}" range="${1}" range_start range_end i=-1 j=0
	c=( $(get_all_version_components ${v} ) )
	range_start="${range%-*}" ; range_start="${range_start:-1}"
	range_end="${range#*-}"   ; range_end="${range_end:-${#c[@]}}"

	while (( j < ${range_start} )) ; do
		i=$(($i + 1))
		[[ $i -gt ${#c[@]} ]] && return
		[[ -n "${c[${i}]//[-._]}" ]] && j=$(($j + 1))
	done

	while (( j <= ${range_end} )) ; do
		echo -n ${c[$i]}
		[[ $i -gt ${#c[@]} ]] && return
		[[ -n "${c[${i}]//[-._]}" ]] && j=$(($j + 1))
		i=$(($i + 1))
	done
}

# Get everything after the major version and its separator (if present) of a
# value. Defaults to $PV if no parameter is supplied.
#     0.8.3       ->  8.3
#     7c          ->  c
#     3.0_p2      ->  0_p2
#     20040905    ->  (empty string)
#     3.0c-r1     ->  0c-r1
get_after_major_version() {
	echo $(get_version_component_range 2- "${1:-PV}" )
}

# Replace the $1th separator with $2 in $3 (defaults to $PV if $3 is not
# supplied). If there are fewer than $1 separators, don't change anything.
#     1 '_' 1.2.3       -> 1_2.3
#     2 '_' 1.2.3       -> 1.2_3
#     1 '_' 1b-2.3      -> 1b_2.3
replace_version_separator() {
	local i c found=0 v="${3:-${PV}}"
	c=( $(get_all_version_components ${v} ) )
	for (( i = 0 ; i < ${#c[@]} ; i = $i + 1 )) ; do
		if [[ -n "${c[${i}]//[^-._]}" ]] ; then
			found=$(($found + 1))
			if [[ "$found" == "${1:-1}" ]] ; then
				c[${i}]="${2}"
				break
			fi
		fi
	done
	c=${c[@]}
	echo ${c// }
}

# Replace all version separators in $2 (defaults to $PV) with $1.
#     '_' 1b.2.3        -> 1b_2_3
replace_all_version_separators() {
	local c
	c=( $(get_all_version_components "${2:-${PV}}" ) )
	c="${c[@]//[-._]/$1}"
	echo ${c// }
}

