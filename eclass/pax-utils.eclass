# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/pax-utils.eclass,v 1.1 2006/01/22 14:18:48 kevquinn Exp $

# Author:
#	Kevin F. Quinn <kevquinn@gentoo.org>
#
# This eclass provides support for manipulating PaX markings on ELF
# binaries, wrapping the use of the chpax and paxctl utilities.

inherit eutils

##### pax-mark ####
# Mark a file for PaX with the given flags.
# Tries chpax (EI_FLAGS) and paxctl (PT_FLAGS) if they are installed.
# If neither are installed, returns 0 (i.e. has no effect on non-PaX
# systems unless the owner has installed chpax and/or paxctl).
# Deliberately does _not_ check whether the build system is PaX or not.
#
# Syntax:
#   pax-mark [-q] {<flags>} [{<files>}]
#
# -q: do things quietly (no einfo/ewarn)
#
# There must be at least one <flags>, and can include:
#     -execstack           equivalent to -E
#     -execheap            equivalent to -m
#     -unrestricted        equivalent to -psmxer
#     -{[pPsSmMxXeErR]}    as used direcly by chpax/paxctl
#
# Where more than one flag is given they are concatenated.
#
# {<files>} may be empty, so it's safe to use for example the results
# of a find that may not return any results.
#
# Return codes:
#  0: for all files, all installed utilities succeed.
#  1: No flags specified
# >1: bit 2 => chpax failed, bit 3 => paxctl failed

pax-mark() {
	local flags ret quiet
	# Fail if no parameters at all (especially no flags)
	[[ -z $1 ]] && return 1
	flags=
	ret=0
	quiet=
	while [[ ${1:0:1} == "-" ]]; do
		case ${1} in
		-execstack)
			flags="${flags}E"
			;;
		-execheap)
			flags="${flags}m"
			;;
		-unrestricted)
			flags="${flags}psmxer"
			;;
		-q)
			quiet="/bin/false "
			;;
		*)
			flags="${flags}${1:1}"
			;;
		esac
		shift
	done
	# Fail if no flags given
	[[ -z ${flags} ]] && return 1
	# Quietly exit if no files given
	[[ -z $1 ]] && return 0
	if [[ -x /sbin/chpax ]]; then
		if /sbin/chpax -${flags} $*; then
			${quiet} einfo "PaX EI flags set to ${flags} on $*"
		else
			${quiet} ewarn "Failed to set EI flags to ${flags} on $*"
			(( ret=${ret}|2 ))
		fi
	fi
	if [[ -x /sbin/paxctl ]]; then
		# Steal PT_GNU_STACK if paxctl supports it
		/sbin/paxctl -v 2>&1 | grep PT_GNU_STACK > /dev/null && \
			flags="c${flags}"
		if /sbin/paxctl -${flags} $*; then
			${quiet} einfo "PaX PT flags set to ${flags} on $*"
		else
			${quiet} ewarn "Failed to set PT flags to ${flags} on $*"
			(( ret=${ret}|4))
		fi
	fi
	return ${ret}
}
