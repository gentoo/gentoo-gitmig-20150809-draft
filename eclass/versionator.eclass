# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/versionator.eclass,v 1.6 2005/03/25 00:51:48 ciaranm Exp $
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
#     delete_version_separator        index ver_str
#     delete_all_version_separators   ver_str
#
# Rather than being a number, the index parameter can be a separator character
# such as '-', '.' or '_'. In this case, the first separator of this kind is
# selected.
#
# There's also:
#     version_is_at_least             want      have
# but it doesn't work in all cases, so only use it if you know what you're
# doing.

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
# Rather than being a number, $1 can be a separator character such as '-', '.'
# or '_'. In this case, the first separator of this kind is selected.
replace_version_separator() {
	local w i c found=0 v="${3:-${PV}}"
	w=${1:-1}
	c=( $(get_all_version_components ${v} ) )
	if [[ "${w//[[:digit:]]/}" == "${w}" ]] ; then
		# it's a character, not an index
		for (( i = 0 ; i < ${#c[@]} ; i = $i + 1 )) ; do
			if [[ "${c[${i}]}" == "${w}" ]] ; then
				c[${i}]="${2}"
				break
			fi
		done
	else
		for (( i = 0 ; i < ${#c[@]} ; i = $i + 1 )) ; do
			if [[ -n "${c[${i}]//[^-._]}" ]] ; then
				found=$(($found + 1))
				if [[ "$found" == "${w}" ]] ; then
					c[${i}]="${2}"
					break
				fi
			fi
		done
	fi
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

# Delete the $1th separator in $2 (defaults to $PV if $2 is not supplied). If
# there are fewer than $1 separators, don't change anything.
#     1 1.2.3       -> 12.3
#     2 1.2.3       -> 1.23
#     1 1b-2.3      -> 1b2.3
# Rather than being a number, $1 can be a separator character such as '-', '.'
# or '_'. In this case, the first separator of this kind is deleted.
delete_version_separator() {
	replace_version_separator "${1}" "" "${2}"
}

# Delete all version separators in $1 (defaults to $PV).
#     1b.2.3        -> 1b23
delete_all_version_separators() {
	replace_all_version_separators "" "${1}"
}

# Is $2 (defaults to $PVR) at least version $1? Intended for use in eclasses
# only. Not very reliable, doesn't understand most things, make sure you test
# reaaaallly well before using this. Prod ciaranm if you need it to support more
# things... WARNING: DOES NOT HANDLE 1.2b style versions. WARNING: not very well
# tested, needs lots of work before it's totally reliable. Use with extreme
# caution.
version_is_at_least() {
	local want_s="$1" have_s="${2:-${PVR}}" want_c have_c
	want_c=( $(get_version_components "$want_s" ) )
	have_c=( $(get_version_components "$have_s" ) )

	# Stage 1: compare the version numbers part.
	local done_w="" done_h="" i=0
	while [[ -z "${done_w}" ]] || [[ -z "${done_h}" ]] ; do
		local cur_w="${want_c[$i]}" cur_h="${have_c[$i]}"
		local my_cur_w="${cur_w//#0}" my_cur_h="${cur_h//#0}"
		[[ -z "${my_cur_w##[^[:digit:]]*}" ]] && done_w="yes"
		[[ -z "${my_cur_h##[^[:digit:]]*}" ]] && done_h="yes"
		[[ -z "${done_w}" ]] || my_cur_w=0
		[[ -z "${done_h}" ]] || my_cur_h=0
		if [[ ${my_cur_w} -lt ${my_cur_h} ]] ; then return 0 ; fi
		if [[ ${my_cur_w} -gt ${my_cur_h} ]] ; then return 1 ; fi
		i=$(($i + 1))
	done

	local part
	for part in "_alpha" "_beta" "_pre" "_rc" "_p" "-r" ; do
		local part_w= part_h=

		for (( i = 0 ; i < ${#want_c[@]} ; i = $i + 1 )) ; do
			if [[ -z "${want_c[$i]##${part#[-._]}*}" ]] ; then
				part_w="${want_c[$i]##${part#[-._]}}"
				break
			fi
		done
		for (( i = 0 ; i < ${#have_c[@]} ; i = $i + 1 )) ; do
			if [[ -z "${have_c[$i]##${part#[-._]}*}" ]] ; then
				part_h="${have_c[$i]##${part#[-._]}}"
				break
			fi
		done

		if [[ "${part}" == "_p" ]] || [[ "${part}" == "-r" ]] ; then
			# if present in neither want nor have, go to the next item
			[[ -z "${part_w}" ]] && [[ -z "${part_h}" ]] && continue

			[[ -z "${part_w}" ]] && [[ -n "${part_h}" ]] && return 0
			[[ -n "${part_w}" ]] && [[ -z "${part_h}" ]] && return 1

			if [[ ${part_w} -lt ${part_h} ]] ; then return 0 ; fi
			if [[ ${part_w} -gt ${part_h} ]] ; then return 1 ; fi

		else
			# if present in neither want nor have, go to the next item
			[[ -z "${part_w}" ]] && [[ -z "${part_h}" ]] && continue

			[[ -z "${part_w}" ]] && [[ -n "${part_h}" ]] && return 1
			[[ -n "${part_w}" ]] && [[ -z "${part_h}" ]] && return 0

			if [[ ${part_w} -lt ${part_h} ]] ; then return 0 ; fi
			if [[ ${part_w} -gt ${part_h} ]] ; then return 1 ; fi
		fi
	done

	return 0
}

# Test function thing. To use, source versionator.eclass and then run it.
__versionator__test_version_is_at_least() {
	version_is_at_least "1.2"             "1.2"         || echo "test  1 failed"
	version_is_at_least "1.2"             "1.2.3"       || echo "test  2 failed"
	version_is_at_least "1.2.3"           "1.2"         && echo "test  3 failed"

	version_is_at_least "1.2_beta1"       "1.2"         || echo "test  4 failed"
	version_is_at_least "1.2_alpha1"      "1.2"         || echo "test  5 failed"
	version_is_at_least "1.2_alpha1"      "1.2_beta1"   || echo "test  6 failed"

	version_is_at_least "1.2"             "1.2_beta1"   && echo "test  7 failed"
	version_is_at_least "1.2"             "1.2_alpha1"  && echo "test  8 failed"
	version_is_at_least "1.2_beta1"       "1.2_alpha1"  && echo "test  9 failed"

	version_is_at_least "1.2_beta1"       "1.2_beta1"   || echo "test 10 failed"
	version_is_at_least "1.2_beta2"       "1.2_beta1"   && echo "test 11 failed"
	version_is_at_least "1.2_beta2"       "1.2_beta3"   || echo "test 12 failed"

	version_is_at_least "1.2-r1"          "1.2"         && echo "test 13 failed"
	version_is_at_least "1.2"             "1.2-r1"      || echo "test 14 failed"
	version_is_at_least "1.2-r1"          "1.3"         || echo "test 15 failed"
	version_is_at_least "1.2-r1"          "1.2-r2"      || echo "test 16 failed"
	version_is_at_least "1.2-r3"          "1.2-r2"      && echo "test 17 failed"

	version_is_at_least "1.2-r1"        "1.2_beta2-r3"  && echo "test 18 failed"
	version_is_at_least "1.2-r1"        "1.3_beta2-r3"  || echo "test 19 failed"

	version_is_at_least "1.002"           "1.2"         || echo "test 20 failed"
	version_is_at_least "1.2"             "1.002"       || echo "test 21 failed"
	version_is_at_least "1.003"           "1.2"         && echo "test 22 failed"
	version_is_at_least "1.3"             "1.002"       && echo "test 23 failed"
	return 0
}

