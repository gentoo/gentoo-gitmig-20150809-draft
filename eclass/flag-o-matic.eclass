# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/flag-o-matic.eclass,v 1.33 2003/12/31 16:51:35 vapier Exp $
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
#### strip-unsupported-flags ####
# Strip C[XX]FLAGS of any flags not supported by
# installed version of gcc
#
#### get-flag <flag> ####
# Find and echo the value for a particular flag
#
#### replace-sparc64-flags ####
# Sets mcpu to v8 and uses the original value
# as mtune if none specified.
#
#### filter-mfpmath <math types> ####
# Remove specified math types from the fpmath specification
# If the user has -mfpmath=sse,386, running `filter-mfpmath sse`
# will leave the user with -mfpmath=386
#
#### append-ldflags ####
# Add extra flags to your current LDFLAGS
#
#### etexec-flags ####
# hooked function for hardened-gcc that appends 
# -yet_exec {C,CXX,LD}FLAGS when hardened-gcc is installed
# and a package is filtering -fPIC,-fpic, -fPIE, -fpie
#
#### fstack-flags ####
# hooked function for hardened-gcc that appends
# -yno_propolice to {C,CXX,LD}FLAGS when hardened-gcc is installed
# and a package is filtering -fstack-protector, -fstack-protector-all
#

# C[XX]FLAGS that we allow in strip-flags
ALLOWED_FLAGS="-O -O1 -O2 -mcpu -march -mtune -fstack-protector -pipe -g"
case "${ARCH}" in
	mips)	ALLOWED_FLAGS="${ALLOWED_FLAGS} -mips1 -mips2 -mips3 -mips4 -mabi" ;;
	amd64)	ALLOWED_FLAGS="${ALLOWED_FLAGS} -fPIC" ;;
	alpha)	ALLOWED_FLAGS="${ALLOWED_FLAGS} -fPIC" ;;
	ia64)   ALLOWED_FLAGS="${ALLOWED_FLAGS} -fPIC" ;;
esac

# C[XX]FLAGS that we are think is ok, but needs testing
# NOTE:  currently -Os have issues with gcc3 and K6* arch's
UNSTABLE_FLAGS="-Os -O3 -freorder-blocks -fprefetch-loop-arrays"

filter-mfpmath() {
	for a in $CFLAGS; do
		if [ "${a:0:8}" == "-mfpmath" ]; then
			orig_mfpmath=$a
		fi
	done

	mfpmath="$( echo $orig_mfpmath | awk -F '=' '{print $2}' | tr "," " " )"
	for b in $@; do
		mfpmath="${mfpmath/$b}"
	done

	if [ -z "${mfpmath/ }" ]; then
		filter-flags "$orig_mfpmath"
	else
		new_mfpmath="-mfpmath=$( echo $mfpmath | sed -e "s/ /,/g" -e "s/,,/,/g" )"
		replace-flags "$orig_mfpmath" "$new_mfpmath"
	fi
}

filter-flags() {
	# we do two loops to avoid the first and last char from being chomped.
	for x in $@ ; do
		case "${x}" in
			-fPIC|-fpic|-fPIE|-fpie) etexec-flags;;
			-fstack-protector|-fstack-protector-all) fstack-flags;;
			*) ;;
		esac
	done
	# we do this fancy spacing stuff so as to not filter
	# out part of a flag ... we want flag atoms ! :D
	CFLAGS=" ${CFLAGS} "
	CXXFLAGS=" ${CXXFLAGS} "
	for x in $@ ; do
		CFLAGS="${CFLAGS/ ${x} / }"
		CXXFLAGS="${CXXFLAGS/ ${x} / }"
	done
	CFLAGS="${CFLAGS:1:${#CFLAGS}-2}"
	CXXFLAGS="${CXXFLAGS:1:${#CXXFLAGS}-2}"
}

append-flags() {
	CFLAGS="${CFLAGS} $@"
	CXXFLAGS="${CXXFLAGS} $@"
	[ "`is-flag -fno-stack-protector`" -o "`is-flag -fno-stack-protector-all`" ] && fstack-flags
	return 0
}

replace-flags() {
	CFLAGS="${CFLAGS/${1}/${2} }"
	CXXFLAGS="${CXXFLAGS/${1}/${2} }"
	return 0
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

	# In case we filtered out all optimization flags fallback to -O2
	if [ "${CFLAGS/-O}" != "${CFLAGS}" -a "${NEW_CFLAGS/-O}" = "${NEW_CFLAGS}" ]; then
		NEW_CFLAGS="${NEW_CFLAGS} -O2"
	fi
	if [ "${CXXFLAGS/-O}" != "${CXXFLAGS}" -a "${NEW_CXXFLAGS/-O}" = "${NEW_CXXFLAGS}" ]; then
		NEW_CXXFLAGS="${NEW_CXXFLAGS} -O2"
	fi

	set +f

	[ `use debug` ] \
		&& einfo "CFLAGS=\"${NEW_CFLAGS}\"" \
		&& einfo "CXXFLAGS=\"${NEW_CXXFLAGS}\""

	export CFLAGS="${NEW_CFLAGS}"
	export CXXFLAGS="${NEW_CXXFLAGS}"
}

test_flag () {
	if gcc -S -xc $1 -o /dev/null /dev/null >/dev/null 2>&1; then
		echo "$1"
	fi
}

strip-unsupported-flags() {
	for x in ${CFLAGS}
	do
		NEW_CFLAGS=${NEW_CFLAGS}" ""`test_flag ${x}`"
	done

	for x in ${CXXFLAGS}
	do
		NEW_CXXFLAGS=${NEW_CXXFLAGS}" ""`test_flag ${x}`"
	done

	CFLAGS="${NEW_CFLAGS}"
	CXXFLAGS="${NEW_CXXFLAGS}"
}

get-flag() {
	local findflag="$1"
	for f in ${CFLAGS} ${CXXFLAGS} ; do
		if [ "${f/${findflag}}" != "${f}" ] ; then
			echo "${f/-${findflag}=}"
			return 0
		fi
	done
	return 1
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

append-ldflags() {
	LDFLAGS="${LDFLAGS} $@"
	return 0
}

etexec-flags() {
	has_version 'sys-devel/hardened-gcc' && {
		debug-print ">>> appending flags -yet_exec"
		append-flags -yet_exec
		append-ldflags -yet_exec
	}
}

fstack-flags() {
	has_version 'sys-devel/hardened-gcc' && {
		debug-print ">>> appending flags -yno_propolice"
		append-flags -yno_propolice
		append-ldflags -yno_propolice
	}
}
