# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/toolchain-funcs.eclass,v 1.50 2006/01/08 03:37:36 vapier Exp $
#
# Author: Toolchain Ninjas <toolchain@gentoo.org>
#
# This eclass contains (or should) functions to get common info
# about the toolchain (libc/compiler/binutils/etc...)

inherit multilib

DESCRIPTION="Based on the ${ECLASS} eclass"

tc-getPROG() {
	local var=$1
	local prog=$2

	if [[ -n ${!var} ]] ; then
		echo "${!var}"
		return 0
	fi

	local search=
	[[ -n $3 ]] && search=$(type -p "$3-${prog}")
	[[ -z ${search} && -n ${CHOST} ]] && search=$(type -p "${CHOST}-${prog}")
	[[ -n ${search} ]] && prog=${search##*/}

	export ${var}=${prog}
	echo "${!var}"
}

# Returns the name of the archiver
tc-getAR() { tc-getPROG AR ar "$@"; }
# Returns the name of the assembler
tc-getAS() { tc-getPROG AS as "$@"; }
# Returns the name of the C compiler
tc-getCC() { tc-getPROG CC gcc "$@"; }
# Returns the name of the C++ compiler
tc-getCXX() { tc-getPROG CXX g++ "$@"; }
# Returns the name of the linker
tc-getLD() { tc-getPROG LD ld "$@"; }
# Returns the name of the symbol/object thingy
tc-getNM() { tc-getPROG NM nm "$@"; }
# Returns the name of the archiver indexer
tc-getRANLIB() { tc-getPROG RANLIB ranlib "$@"; }
# Returns the name of the fortran compiler
tc-getF77() { tc-getPROG F77 f77 "$@"; }
# Returns the name of the java compiler
tc-getGCJ() { tc-getPROG GCJ gcj "$@"; }

# Returns the name of the C compiler for build
tc-getBUILD_CC() {
	local v
	for v in CC_FOR_BUILD BUILD_CC HOSTCC ; do
		if [[ -n ${!v} ]] ; then
			export BUILD_CC=${!v}
			echo "${!v}"
			return 0
		fi
	done

	local search=
	if [[ -n ${CBUILD} ]] ; then
		search=$(type -p ${CBUILD}-gcc)
		search=${search##*/}
	fi
	search=${search:-gcc}

	export BUILD_CC=${search}
	echo "${search}"
}

# Quick way to export a bunch of vars at once
tc-export() {
	local var
	for var in "$@" ; do
		eval tc-get${var} > /dev/null
	done
}

# A simple way to see if we're using a cross-compiler ...
tc-is-cross-compiler() {
	return $([[ ${CBUILD:-${CHOST}} != ${CHOST} ]])
}


# Parse information from CBUILD/CHOST/CTARGET rather than
# use external variables from the profile.
tc-ninja_magic_to_arch() {
ninj() { [[ ${type} == "kern" ]] && echo $1 || echo $2 ; }

	local type=$1
	local host=$2
	[[ -z ${host} ]] && host=${CTARGET:-${CHOST}}

	case ${host} in
		alpha*)		echo alpha;;
		arm*)		echo arm;;
		cris*)		echo cris;;
		hppa*)		ninj parisc hppa;;
		i?86*)		ninj i386 x86;;
		ia64*)		echo ia64;;
		m68*)		echo m68k;;
		mips*)		echo mips;;
		powerpc*)
					# Starting with linux-2.6.15, the 'ppc' and 'ppc64' trees
					# have been unified into simply 'powerpc'
					if [[ $(KV_to_int ${KV}) -ge $(KV_to_int 2.6.15) ]] && [[ ${type} == "kern" ]] ; then
						echo powerpc
					elif [[ ${host} == powerpc64* ]] ; then
						echo ppc64
					else
						echo ppc
					fi
					;;
		s390*)		echo s390;;
		sh64*)		ninj sh64 sh;;
		sh*)		echo sh;;
		sparc64*)	ninj sparc64 sparc;;
		sparc*)		[[ ${PROFILE_ARCH} == "sparc64" ]] \
						&& ninj sparc64 sparc \
						|| echo sparc
					;;
		vax*)		echo vax;;
		x86_64*)	ninj x86_64 amd64;;
		*)			echo ${ARCH};;
	esac
}
tc-arch-kernel() {
	tc-ninja_magic_to_arch kern $@
}
tc-arch() {
	tc-ninja_magic_to_arch portage $@
}
tc-endian() {
	local host=$1
	[[ -z ${host} ]] && host=${CTARGET:-${CHOST}}
	host=${host%%-*}

	case ${host} in
		alpha*)		echo big;;
		arm*b*)		echo big;;
		arm*)		echo little;;
		cris*)		echo little;;
		hppa*)		echo big;;
		i?86*)		echo little;;
		ia64*)		echo little;;
		m68*)		echo big;;
		mips*l*)	echo little;;
		mips*)		echo big;;
		powerpc*)	echo big;;
		s390*)		echo big;;
		sh*b*)		echo big;;
		sh*)		echo little;;
		sparc*)		echo big;;
		x86_64*)	echo little;;
		*)			echo wtf;;
	esac
}

# Returns the version as by `$CC -dumpversion`
gcc-fullversion() {
	echo "$($(tc-getCC) -dumpversion)"
}
# Returns the version, but only the <major>.<minor>
gcc-version() {
	echo "$(gcc-fullversion | cut -f1,2 -d.)"
}
# Returns the Major version
gcc-major-version() {
	echo "$(gcc-version | cut -f1 -d.)"
}
# Returns the Minor version
gcc-minor-version() {
	echo "$(gcc-version | cut -f2 -d.)"
}
# Returns the Micro version
gcc-micro-version() {
	echo "$(gcc-fullversion | cut -f3 -d. | cut -f1 -d-)"
}

# Returns requested gcc specs directive
# Note; later specs normally overwrite earlier ones; however if a later
# spec starts with '+' then it appends.
# gcc -dumpspecs is parsed first, followed by files listed by "gcc -v"
# as "Reading <file>", in order.
gcc-specs-directive() {
	local specfiles=$($(tc-getCC) -v 2>&1 | awk '$1=="Reading" {print $NF}')
	$(tc-getCC) -dumpspecs 2> /dev/null | cat - ${specfiles} | awk -v directive=$1 \
'BEGIN	{ pspec=""; spec=""; outside=1 }
$1=="*"directive":"  { pspec=spec; spec=""; outside=0; next }
	outside || NF==0 || ( substr($1,1,1)=="*" && substr($1,length($1),1)==":" ) { outside=1; next }
	spec=="" && substr($0,1,1)=="+" { spec=pspec " " substr($0,2); next }
	{ spec=spec $0 }
END	{ print spec }'
	return 0
}

# Returns true if gcc sets relro
gcc-specs-relro() {
	local directive
	directive=$(gcc-specs-directive link_command)
	return $([[ ${directive/\{!norelro:} != ${directive} ]])
}
# Returns true if gcc sets now
gcc-specs-now() {
	local directive
	directive=$(gcc-specs-directive link_command)
	return $([[ ${directive/\{!nonow:} != ${directive} ]])
}
# Returns true if gcc builds PIEs
gcc-specs-pie() {
	local directive
	directive=$(gcc-specs-directive cc1)
	return $([[ ${directive/\{!nopie:} != ${directive} ]])
}
# Returns true if gcc builds with the stack protector
gcc-specs-ssp() {
	local directive
	directive=$(gcc-specs-directive cc1)
	return $([[ ${directive/\{!fno-stack-protector:} != ${directive} ]])
}
# Returns true if gcc upgrades fstack-protector to fstack-protector-all
gcc-specs-ssp-to-all() {
	local directive
	directive=$(gcc-specs-directive cc1)
	return $([[ ${directive/\{!fno-stack-protector-all:} != ${directive} ]])
}
