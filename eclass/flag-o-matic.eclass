# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/flag-o-matic.eclass,v 1.85 2005/04/06 23:29:23 vapier Exp $

ECLASS=flag-o-matic
INHERITED="$INHERITED $ECLASS"

IUSE="debug"

# need access to emktemp()
inherit eutils toolchain-funcs multilib

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
#### fstack-flags ####
# hooked function for hardened gcc that appends
# -fno-stack-protector to {C,CXX,LD}FLAGS
# when a package is filtering -fstack-protector, -fstack-protector-all
# notice: modern automatic specs files will also suppress -fstack-protector-all
# when only -fno-stack-protector is given
#

# C[XX]FLAGS that we allow in strip-flags
setup-allowed-flags() {
	if [[ -z ${ALLOWED_FLAGS} ]] ; then
		export ALLOWED_FLAGS="-pipe"
		export ALLOWED_FLAGS="${ALLOWED_FLAGS} -O -O0 -O1 -O2 -mcpu -march -mtune"
		export ALLOWED_FLAGS="${ALLOWED_FLAGS} -fstack-protector -fno-stack-protector"
		export ALLOWED_FLAGS="${ALLOWED_FLAGS} -fno-pie -fno-unit-at-a-time"
		export ALLOWED_FLAGS="${ALLOWED_FLAGS} -g -g0 -g1 -g2 -g3 -ggdb -ggdb0 -ggdb1 -ggdb2 -ggdb3"
		case $(tc-arch) in
			mips)	ALLOWED_FLAGS="${ALLOWED_FLAGS} -mips1 -mips2 -mips3 -mips4 -mips32 -mips64 -mips16 -EL -EB -mabi" ;;
			amd64)	ALLOWED_FLAGS="${ALLOWED_FLAGS} -fPIC -m64" ;;
			x86)	ALLOWED_FLAGS="${ALLOWED_FLAGS} -m32" ;;
			alpha)	ALLOWED_FLAGS="${ALLOWED_FLAGS} -fPIC" ;;
			ia64)	ALLOWED_FLAGS="${ALLOWED_FLAGS} -fPIC" ;;
			sparc)	ALLOWED_FLAGS="${ALLOWED_FLAGS} -m32 -m64" ;;
			ppc)	ALLOWED_FLAGS="${ALLOWED_FLAGS} -mabi" ;;
		esac
	fi
	# allow a bunch of flags that negate features / control ABI
	ALLOWED_FLAGS="${ALLOWED_FLAGS} -fno-stack-protector -fno-stack-protector-all"
	case $(tc-arch) in
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
			-fPIC|-fpic|-fPIE|-fpie|-pie)
				append-flags `test_flag -fno-pie`;;
			-fstack-protector|-fstack-protector-all)
				fstack-flags;;
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
	[[ -z $* ]] && return 0
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
	if has ~$(tc-arch) ${ACCEPT_KEYWORDS} ; then
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
	if $(tc-getCC) -S -xc "$@" -o "$(emktemp)" /dev/null &>/dev/null; then
		printf "%s\n" "$*"
		return 0
	fi
	return 1
}

test_version_info() {
	if [[ $($(tc-getCC) --version 2>&1) == *$1* ]]; then
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

# indicate whether PIC is set
has_pic() {
	[ "${CFLAGS/-fPIC}" != "${CFLAGS}" ] && return 0
	[ "${CFLAGS/-fpic}" != "${CFLAGS}" ] && return 0
	[ "$(echo | $(tc-getCC) ${CFLAGS} -E -dM - | grep __PIC__)" ] && return 0
	test_version_info pie && return 0
	return 1
}

# indicate whether PIE is set
has_pie() {
	[ "${CFLAGS/-fPIE}" != "${CFLAGS}" ] && return 0
	[ "${CFLAGS/-fpie}" != "${CFLAGS}" ] && return 0
	[ "$(echo | $(tc-getCC) ${CFLAGS} -E -dM - | grep __PIE__)" ] && return 0
	# test PIC while waiting for specs to be updated to generate __PIE__
	[ "$(echo | $(tc-getCC) ${CFLAGS} -E -dM - | grep __PIC__)" ] && return 0
	return 1
}

# indicate whether code for SSP is being generated
has_ssp() {
	# note; this matches both -fstack-protector and -fstack-protector-all
	[ "${CFLAGS/-fstack-protector}" != "${CFLAGS}" ] && return 0
	[ "$(echo | $(tc-getCC) ${CFLAGS} -E -dM - | grep __SSP__)" ] && return 0
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

	[ "$(tc-arch)" = "amd64" ] && has_multilib_profile && return 0

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
		LDFLAGS=${LDFLAGS// ${x} / }
	done
	[[ -z ${LDFLAGS// } ]] \
		&& LDFLAGS="" \
		|| LDFLAGS=${LDFLAGS:1:${#LDFLAGS}-2}
	export LDFLAGS
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
	if [[ $(tc-arch) == "x86" || $(tc-arch) == "amd64" ]] ; then
		CFLAGS=${CFLAGS//-mtune=/-mcpu=}
		CXXFLAGS=${CXXFLAGS//-mtune=/-mcpu=}
	fi

	replace-cpu-flags k6-{2,3} k6
	replace-cpu-flags athlon{,-{tbird,4,xp,mp}} i686

	replace-cpu-flags pentium-mmx i586
	replace-cpu-flags pentium{2,3,4} i686

	replace-cpu-flags ev6{7,8} ev6

	export CFLAGS CXXFLAGS
}
