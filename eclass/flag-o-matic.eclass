# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/flag-o-matic.eclass,v 1.23 2003/07/18 20:11:22 tester Exp $
#
# Author Bart Verwilst <verwilst@gentoo.org>

ECLASS=flag-o-matic
INHERITED="$INHERITED $ECLASS"

#
#### filter-flags <flags> ####
# Remove particular flags from C[XX]FLAGS
# Matches only complete flags
#
#### append-flags <flags> ####
# Add extra flags to your current C[XX]FLAGS
#
#### replace-flags <orig.flag> <new.flag> ###
# Replace a flag by another one
#
#### is-flag <flag> ####
# Returns "true" if flag is set in C[XX]FLAGS
# Matches only complete a flag
#
#### strip-flags ####
# Strip C[XX]FLAGS of everything except known
# good options.
#
#### get-flag <flag> ####
# Find and echo the value for a particular flag
#
#### replace-sparc64-flags ####
# Sets mcpu to v8 and uses the original value
# as mtune if none specified.
#


# C[XX]FLAGS that we allow in strip-flags
ALLOWED_FLAGS="-O -O1 -O2 -mcpu -march -mtune -fstack-protector -pipe -g"
case "${ARCH}" in
	mips)	ALLOWED_FLAGS="${ALLOWED_FLAGS} -mips1 -mips2 -mips3 -mips4 -mabi" ;;
	amd64)	ALLOWED_FLAGS="${ALLOWED_FLAGS} -fPIC" ;;
esac

# C[XX]FLAGS that we are think is ok, but needs testing
# NOTE:  currently -Os have issues with gcc3 and K6* arch's
UNSTABLE_FLAGS="-Os -O3 -freorder-blocks -fprefetch-loop-arrays"

filter-flags() {
	# we do this fancy spacing stuff so as to not filter
	# out part of a flag ... we want flag atoms ! :D
	export CFLAGS=" ${CFLAGS} "
	export CXXFLAGS=" ${CXXFLAGS} "
	for x in $@ ; do
		export CFLAGS="${CFLAGS/ ${x} / }"
		export CXXFLAGS="${CXXFLAGS/ ${x} / }"
	done
	export CFLAGS="${CFLAGS:1:${#CFLAGS}-2}"
	export CXXFLAGS="${CXXFLAGS:1:${#CXXFLAGS}-2}"
}

append-flags() {
	CFLAGS="${CFLAGS} $@"
	CXXFLAGS="${CXXFLAGS} $@"
}

replace-flags() {
	CFLAGS="${CFLAGS/${1}/${2} }"
	CXXFLAGS="${CXXFLAGS/${1}/${2} }"
}

is-flag() {
	for x in ${CFLAGS} ${CXXFLAGS} ; do
		if [ "${x}" == "$1" ] ; then
			echo true
			return 0
		fi
	done
	return 1
}

strip-flags() {
	local NEW_CFLAGS=""
	local NEW_CXXFLAGS=""

	# Allow unstable C[XX]FLAGS if we are using unstable profile ...
	if [ `has ~${ARCH} ${ACCEPT_KEYWORDS}` ] ; then
		[ `use debug` ] && einfo "Enabling the use of some unstable flags"
		ALLOWED_FLAGS="${ALLOWED_FLAGS} ${UNSTABLE_FLAGS}"
	fi

	set -f

	for x in ${CFLAGS}
	do
		for y in ${ALLOWED_FLAGS}
		do
			flag=${x%%=*}
			if [ "${flag%%${y}}" = "" ]
			then
				NEW_CFLAGS="${NEW_CFLAGS} ${x}"
				break
			fi
		done
	done

	for x in ${CXXFLAGS}
	do
		for y in ${ALLOWED_FLAGS}
		do
			flag=${x%%=*}
			if [ "${flag%%${y}}" = "" ]
			then
				NEW_CXXFLAGS="${NEW_CXXFLAGS} ${x}"
				break
			fi
		done
	done

	set +f

	[ `use debug` ] \
		&& einfo "CFLAGS=\"${NEW_CFLAGS}\"" \
		&& einfo "CXXFLAGS=\"${NEW_CXXFLAGS}\""

	export CFLAGS="${NEW_CFLAGS}"
	export CXXFLAGS="${NEW_CXXFLAGS}"
}

get-flag() {
	local findflag="$1"

	for f in ${CFLAGS} ${CXXFLAGS} ; do
		if [ "${f/${findflag}}" != "${f}" ] ; then
			echo "${f/-${findflag}=}"
			return
		fi
	done
}

replace-sparc64-flags() {
	local SPARC64_CPUS="ultrasparc v9"

 	if [ "${CFLAGS/mtune}" != "${CFLAGS}" ]
	then
		for x in ${SPARC64_CPUS}
		do
			CFLAGS="${CFLAGS/-mcpu=${x}/-mcpu=v8}"
		done
 	else
	 	for x in ${SPARC64_CPUS}
		do
			CFLAGS="${CFLAGS/-mcpu=${x}/-mcpu=v8 -mtune=${x}}"
		done
	fi
	
 	if [ "${CXXFLAGS/mtune}" != "${CXXFLAGS}" ]
	then
		for x in ${SPARC64_CPUS}
		do
			CXXFLAGS="${CXXFLAGS/-mcpu=${x}/-mcpu=v8}"
		done
	else
	 	for x in ${SPARC64_CPUS}
		do
			CXXFLAGS="${CXXFLAGS/-mcpu=${x}/-mcpu=v8 -mtune=${x}}"
		done
	fi
}
