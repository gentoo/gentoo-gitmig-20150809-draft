# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/flag-o-matic.eclass,v 1.8 2002/10/13 01:01:58 azarah Exp $

ECLASS=flag-o-matic
INHERITED="$INHERITED $ECLASS"

#
#### filter-flags <flag> ####
# Remove particular flags from C[XX]FLAGS
#
#### append-flags <flag> ####
# Add extra flags to your current C[XX]FLAGS
#
#### replace-flags <orig.flag> <new.flag> ###
# Replace a flag by another one
#
#### is-flag <flag> ####
# Returns "true" if flag is set in C[XX]FLAGS
# Matches only complete flag
#
#### strip-flags ####
# Strip C[XX]FLAGS of everything except known
# good options.
#

filter-flags () {

	for x in $1
	do
		export CFLAGS="${CFLAGS/${x}}"
		export CXXFLAGS="${CXXFLAGS/${x}}"
	done

}

append-flags () {

	CFLAGS="${CFLAGS} $1"
	CXXFLAGS="${CXXFLAGS} $1"

}

replace-flags () {

	CFLAGS="${CFLAGS/${1}/${2}}"
	CXXFLAGS="${CXXFLAGS/${1}/${2}}"

}

is-flag() {

	for x in ${CFLAGS} ${CXXFLAGS}
	do
	    if [ "${x}" = "$1" ]
		then
			echo true
			break
	    fi
	done

}

strip-flags() {

	local NEW_CFLAGS=""
	local NEW_CXXFLAGS=""

	local ALLOWED_FLAGS="-O -mcpu -march -pipe"

	set -f

	for x in ${CFLAGS}
	do
		for y in ${ALLOWED_FLAGS}
		do
			if [ "${x/${y}}" != "${x}" ]
			then
				if [ -z "${NEW_CFLAGS}" ]
				then
					NEW_CFLAGS="${x}"
				else
					NEW_CFLAGS="${NEW_CFLAGS} ${x}"
				fi
			fi
		done
	done

	for x in ${CXXFLAGS}
	do
		for y in ${ALLOWED_FLAGS}
		do
			if [ "${x/${y}}" != "${x}" ]
			then
				if [ -z "${NEW_CXXFLAGS}" ]
				then
					NEW_CXXFLAGS="${x}"
				else
					NEW_CXXFLAGS="${NEW_CXXFLAGS} ${x}"
				fi
			fi
		done
	done

	set +f

	export CFLAGS="${NEW_CFLAGS}"
	export CXXFLAGS="${NEW_CXXFLAGS}"
}

