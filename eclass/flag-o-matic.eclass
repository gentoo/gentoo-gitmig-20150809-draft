# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/flag-o-matic.eclass,v 1.74 2004/10/21 07:40:47 kugelfang Exp $
#
# Author Bart Verwilst <verwilst@gentoo.org>

ECLASS=flag-o-matic
INHERITED="$INHERITED $ECLASS"

# Please leave ${IUSE} in this until portage .51 is stable, otherwise
# IUSE gets clobbered.
IUSE="${IUSE} debug"

# need access to emktemp()
inherit eutils toolchain-funcs

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
#### replace-cpu-flags <old.cpus> <new.cpu> ###
# Replace march/mcpu flags that specify <old.cpus>
# with flags that specify <new.cpu>
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
#### filter-ldflags <flags> ####
# Remove particular flags from LDFLAGS
# Matches only complete flags
#
#### etexec-flags ####
# hooked function for hardened gcc that appends
# -fno-pic to {C,CXX,LD}FLAGS
# when a package is filtering -fpic, -fPIC, -fpie, -fPIE
#
#### fstack-flags ####
# hooked function for hardened gcc that appends
# -fno-stack-protector to {C,CXX,LD}FLAGS
# when a package is filtering -fstack-protector, -fstack-protector-all
# notice: modern automatic specs files will also suppress -fstack-protector-all
# when only -fno-stack-protector is given
#

# C[XX]FLAGS that we allow in strip-flags
setup-allowed-flags() {
	if [ -z "${ALLOWED_FLAGS}" ] ; then
		export ALLOWED_FLAGS="-O -O1 -O2 -mcpu -march -mtune -fstack-protector -fno-stack-protector -fno-pie -fno-unit-at-a-time -pipe -g"
		case "${ARCH}" in
			mips)	ALLOWED_FLAGS="${ALLOWED_FLAGS} -mips1 -mips2 -mips3 -mips4 -mips32 -mips64 -mips16 -EL -EB -mabi" ;;
			amd64)	ALLOWED_FLAGS="${ALLOWED_FLAGS} -fPIC -m64" ;;
			x86)	ALLOWED_FLAGS="${ALLOWED_FLAGS} -m32" ;;
			alpha)	ALLOWED_FLAGS="${ALLOWED_FLAGS} -fPIC" ;;
			ia64)	ALLOWED_FLAGS="${ALLOWED_FLAGS} -fPIC" ;;
		esac
	fi
	# allow a bunch of flags that negate features / control ABI
	ALLOWED_FLAGS="${ALLOWED_FLAGS} -fno-stack-protector -fno-stack-protector-all"
	case "${ARCH}" in
		x86|amd64|ia64) ALLOWED_FLAGS="${ALLOWED_FLAGS} -mno-mmx -mno-sse -mno-sse2 -mno-sse3 -mno-3dnow" ;;
	esac
	ALLOWED_FLAGS="${ALLOWED_FLAGS} -mregparm -mno-app-regs -mapp-regs -msoft-float -mflat -mno-faster-structs -mfaster-structs -mlittle-endian -mbig-endian -mlive-g0 -mcmodel -mno-stack-bias -mstack-bias"

	# C[XX]FLAGS that we are think is ok, but needs testing
	# NOTE:  currently -Os have issues with gcc3 and K6* arch's
	export UNSTABLE_FLAGS="-Os -O3 -freorder-blocks -fprefetch-loop-arrays"
	return 0
}

filter-flags() {
	local x f fset 
	declare -a new_CFLAGS new_CXXFLAGS

	for x in "$@" ; do
		case "${x}" in
			-fPIC|-fpic|-fPIE|-fpie|-pie) etexec-flags;;
			-fstack-protector|-fstack-protector-all) fstack-flags;;
		esac
	done

	for fset in CFLAGS CXXFLAGS; do
		# Looping over the flags instead of using a global
		# substitution ensures that we're working with flag atoms.
		# Otherwise globs like -O* have the potential to wipe out the
		# list of flags.
		for f in ${!fset}; do
			for x in "$@"; do
				# Note this should work with globs like -O*
				[[ ${f} == ${x} ]] && continue 2
			done
			eval new_${fset}\[\${\#new_${fset}\[@]}]=\${f}
		done
		eval export ${fset}=\${new_${fset}\[*]}
	done

	return 0
}

filter-lfs-flags() {
	filter-flags -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
}

append-lfs-flags() {
	append-flags -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
}

append-flags() {
	export CFLAGS="${CFLAGS} $*"
	export CXXFLAGS="${CXXFLAGS} $*"
	[ -n "`is-flag -fno-stack-protector`" -o \
		-n "`is-flag -fno-stack-protector-all`" ] && fstack-flags
	return 0
}

replace-flags() {
	local f fset 
	declare -a new_CFLAGS new_CXXFLAGS

	for fset in CFLAGS CXXFLAGS; do
		# Looping over the flags instead of using a global
		# substitution ensures that we're working with flag atoms.
		# Otherwise globs like -O* have the potential to wipe out the
		# list of flags.
		for f in ${!fset}; do
			# Note this should work with globs like -O*
			[[ ${f} == ${1} ]] && f=${2}
			eval new_${fset}\[\${\#new_${fset}\[@]}]=\${f}
		done
		eval export ${fset}=\${new_${fset}\[*]}
	done

	return 0
}

replace-cpu-flags() {
	local newcpu="$#" ; newcpu="${!newcpu}"
	while [ $# -gt 1 ] ; do
		# quote to make sure that no globbing is done (particularly on
		# ${oldcpu} prior to calling replace-flags
		replace-flags "-march=${1}" "-march=${newcpu}"
		replace-flags "-mcpu=${1}" "-mcpu=${newcpu}"
		replace-flags "-mtune=${1}" "-mtune=${newcpu}"
		shift
	done
	return 0
}

is-flag() {
	local x

	for x in ${CFLAGS} ${CXXFLAGS} ; do
		# Note this should work with globs like -mcpu=ultrasparc*
		if [[ ${x} == ${1} ]]; then
			echo true
			return 0
		fi
	done
	return 1
}

filter-mfpmath() {
	local orig_mfpmath new_math prune_math

	# save the original -mfpmath flag
	orig_mfpmath="`get-flag -mfpmath`"
	# get the value of the current -mfpmath flag
	new_math=" `get-flag mfpmath | tr , ' '` "
	# figure out which math values are to be removed
	prune_math=""
	for prune_math in "$@" ; do
		new_math="${new_math/ ${prune_math} / }"
	done
	new_math="`echo ${new_math:1:${#new_math}-2} | tr ' ' ,`"

	if [ -z "${new_math}" ] ; then
		# if we're removing all user specified math values are
		# slated for removal, then we just filter the flag
		filter-flags ${orig_mfpmath}
	else
		# if we only want to filter some of the user specified
		# math values, then we replace the current flag
		replace-flags ${orig_mfpmath} -mfpmath=${new_math}
	fi
	return 0
}

strip-flags() {
	local x y flag NEW_CFLAGS NEW_CXXFLAGS

	setup-allowed-flags

	local NEW_CFLAGS=""
	local NEW_CXXFLAGS=""

	# Allow unstable C[XX]FLAGS if we are using unstable profile ...
	if has ~${ARCH} ${ACCEPT_KEYWORDS} ; then
		use debug && einfo "Enabling the use of some unstable flags"
		ALLOWED_FLAGS="${ALLOWED_FLAGS} ${UNSTABLE_FLAGS}"
	fi

	set -f	# disable pathname expansion

	for x in ${CFLAGS}; do
		for y in ${ALLOWED_FLAGS}; do
			flag=${x%%=*}
			if [ "${flag%%${y}}" = "" ] ; then
				NEW_CFLAGS="${NEW_CFLAGS} ${x}"
				break
			fi
		done
	done

	for x in ${CXXFLAGS}; do
		for y in ${ALLOWED_FLAGS}; do
			flag=${x%%=*}
			if [ "${flag%%${y}}" = "" ] ; then
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

	set +f	# re-enable pathname expansion

	export CFLAGS="${NEW_CFLAGS}"
	export CXXFLAGS="${NEW_CXXFLAGS}"
	return 0
}

test_flag() {
	local cc=${CC:-gcc} ; cc=${cc%% *}
	if ${cc} -S -xc "$@" -o "$(emktemp)" /dev/null &>/dev/null; then
		printf "%s\n" "$*"
		return 0
	fi
	return 1
}

test_version_info() {
	local cc=${CC:-gcc} ; cc=${cc%% *}
	if [[ $(${cc} --version 2>&1) == *$1* ]]; then
		return 0
	else
		return 1
	fi
}

strip-unsupported-flags() {
	local NEW_CFLAGS NEW_CXXFLAGS

	for x in ${CFLAGS} ; do
		NEW_CFLAGS="${NEW_CFLAGS} `test_flag ${x}`"
	done
	for x in ${CXXFLAGS} ; do
		NEW_CXXFLAGS="${NEW_CXXFLAGS} `test_flag ${x}`"
	done

	export CFLAGS="${NEW_CFLAGS}"
	export CXXFLAGS="${NEW_CXXFLAGS}"
}

get-flag() {
	local f findflag="$1"

	# this code looks a little flaky but seems to work for
	# everything we want ...
	# for example, if CFLAGS="-march=i686":
	# `get-flag -march` == "-march=i686"
	# `get-flag march` == "i686"
	for f in ${CFLAGS} ${CXXFLAGS} ; do
		if [ "${f/${findflag}}" != "${f}" ] ; then
			printf "%s\n" "${f/-${findflag}=}"
			return 0
		fi
	done
	return 1
}

has_hardened() {
	test_version_info Hardened && return 0
	# the specs file wont exist unless gcc has GCC_SPECS support
	[ -f "${GCC_SPECS}" -a "${GCC_SPECS}" != "${GCC_SPECS/hardened/}" ] && \
		return 0
	return 1
}

has_pic() {
	[ "${CFLAGS/-fPIC}" != "${CFLAGS}" ] && return 0
	[ "${CFLAGS/-fpic}" != "${CFLAGS}" ] && return 0
	test_version_info pie && return 0
	return 1
}

has_pie() { 
	[ "${CFLAGS/-fPIE}" != "${CFLAGS}" ] && return 0
	[ "${CFLAGS/-fpie}" != "${CFLAGS}" ] && return 0
	test_version_info pie && return 0
	return 1
}
	
has_ssp() {
	[ "${CFLAGS/-fstack-protector}" != "${CFLAGS}" ] && return 0
	test_version_info ssp && return 0
	return 1
}

has_m64() {
	# this doesnt test if the flag is accepted, it tests if the flag
	# actually -WORKS-. non-multilib gcc will take both -m32 and -m64!
	# please dont replace this function with test_flag in some future
	# clean-up!
	local temp="$(emktemp)"
	echo "int main() { return(0); }" > ${temp}.c
	MY_CC=$(tc-getCC)
	${MY_CC/ .*/} -m64 -o "$(emktemp)" ${temp}.c > /dev/null 2>&1
	local ret=$?
	rm -f ${temp}.c
	[ "$ret" != "1" ] && return 0
	return 1
}

has_m32() {
	# this doesnt test if the flag is accepted, it tests if the flag
	# actually -WORKS-. non-multilib gcc will take both -m32 and -m64!
	# please dont replace this function with test_flag in some future
	# clean-up!
	local temp="$(emktemp)"
	echo "int main() { return(0); }" > ${temp}.c
	MY_CC=$(tc-getCC)
	${MY_CC/ .*/} -m32 -o "$(emktemp)" ${temp}.c > /dev/null 2>&1
	local ret=$?
	rm -f ${temp}.c
	[ "$ret" != "1" ] && return 0
	return 1
}

replace-sparc64-flags() {
	local SPARC64_CPUS="ultrasparc v9"

 	if [ "${CFLAGS/mtune}" != "${CFLAGS}" ]; then
		for x in ${SPARC64_CPUS}; do
			CFLAGS="${CFLAGS/-mcpu=${x}/-mcpu=v8}"
		done
 	else
	 	for x in ${SPARC64_CPUS}; do
			CFLAGS="${CFLAGS/-mcpu=${x}/-mcpu=v8 -mtune=${x}}"
		done
	fi
	
 	if [ "${CXXFLAGS/mtune}" != "${CXXFLAGS}" ]; then
		for x in ${SPARC64_CPUS}; do
			CXXFLAGS="${CXXFLAGS/-mcpu=${x}/-mcpu=v8}"
		done
	else
	 	for x in ${SPARC64_CPUS}; do
			CXXFLAGS="${CXXFLAGS/-mcpu=${x}/-mcpu=v8 -mtune=${x}}"
		done
	fi

	export CFLAGS CXXFLAGS
}

append-ldflags() {
	export LDFLAGS="${LDFLAGS} $*"
	return 0
}

filter-ldflags() {
	local x

	# we do this fancy spacing stuff so as to not filter
	# out part of a flag ... we want flag atoms ! :D
	LDFLAGS=" ${LDFLAGS} "
	for x in "$@" ; do
		LDFLAGS="${LDFLAGS// ${x} / }"
	done
	LDFLAGS="${LDFLAGS:1:${#LDFLAGS}-2}"
	export LDFLAGS
	return 0
}

etexec-flags() {
	# if you're not using a hardened compiler you wont need this
	# PIC/no-pic kludge in the first place.
	has_hardened || return 0
	# this kludge breaks on amd64, and probably other -fPIC dependant
	# archs.
	use amd64 && return 0

	if has_pie || has_pic; then
		[ -z "`is-flag -fno-pic`" ] && 
			export CFLAGS="${CFLAGS} `test_flag -fno-pic`"
		[ -z "`is-flag -nopie`" ] && 
			export CFLAGS="${CFLAGS} `test_flag -nopie`"
	fi
	return 0
}

fstack-flags() {
	if has_ssp; then
		[ -z "`is-flag -fno-stack-protector`" ] && 
			export CFLAGS="${CFLAGS} `test_flag -fno-stack-protector`"
	fi
	return 0
}

# This is thanks to great work from Paul de Vrieze <gentoo-user@devrieze.net>,
# bug #9016.  Also thanks to Jukka Salmi <salmi@gmx.net> (bug #13907) for more
# fixes.
#
# Export CFLAGS and CXXFLAGS that are compadible with gcc-2.95.3
gcc2-flags() {
	CFLAGS=${CFLAGS//pentium-mmx/i586}
	CFLAGS=${CFLAGS//pentium[234]/i686}
	CFLAGS=${CFLAGS//k6-[23]/k6}
	CFLAGS=${CFLAGS//athlon-tbird/i686}
	CFLAGS=${CFLAGS//athlon-4/i686}
	CFLAGS=${CFLAGS//athlon-[xm]p/i686}
	CFLAGS=${CFLAGS//athlon/i686}

	CXXFLAGS=${CXXFLAGS//pentium-mmx/i586}
	CXXFLAGS=${CXXFLAGS//pentium[234]/i686}
	CXXFLAGS=${CXXFLAGS//k6-[23]/k6}
	CXXFLAGS=${CXXFLAGS//athlon-tbird/i686}
	CXXFLAGS=${CXXFLAGS//athlon-4/i686}
	CXXFLAGS=${CXXFLAGS//athlon-[xm]p/i686}
	CXXFLAGS=${CXXFLAGS//athlon/i686}

	if [ "$ARCH" = alpha ]; then
		CHOST=${CHOST/#alphaev6[78]/alphaev6}
		CFLAGS=${CFLAGS//ev6[78]/ev6}
		CXXFLAGS=${CXXFLAGS//ev6[78]/ev6}
	fi

	export CFLAGS CXXFLAGS
}
