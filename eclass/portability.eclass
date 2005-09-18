# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/portability.eclass,v 1.1 2005/09/18 17:33:44 flameeyes Exp $
#
# Author: Diego Pettenò <flameeyes@gentoo.org>
#
# This eclass is created to avoid using non-portable GNUisms inside ebuilds
#
# NB:  If you add anything, please comment it!

# treecopy orig1 orig2 orig3 .... dest
#
# mimic cp --parents copy, but working on BSD userland as well
treecopy() {
	dest=${!#}
	files_count=$#

	while(( $# > 1 )); do
		dirstruct=$(dirname "$1")
		mkdir -p "${dest}/${dirstruct}"
		cp -pPR "$1" "${dest}/${dirstruct}"

		shift
	done
}

# seq min max
#
# compatibility function that mimes seq command if not available
seq() {
	local p
	p=$(type -P seq)

	case $# in
		1)
			min=1
			max=$1
			step=1
			;;
		2)
			min=$1
			max=$2
			step=1
			;;
		3)
			min=$1
			max=$3
			step=$2
			;;
		*)
			die "seq called with wrong parameters number"
	esac

	if [[ -z "${p}" ]]; then
		local reps
		# BSD userland
		if [[ ${step} != 0 ]]; then
			reps=$(( ($max-$min) / $step +1 ))
		else
			reps=0
		fi

		jot $reps $min $max $step
	else
		"${p}" $min $step $max
	fi
}

# Gets the linker flag to link to dlopen() function
dlopen_lib() {
	if [[ ${ELIBC} != *BSD ]]; then
		echo "-ldl"
	fi
}

