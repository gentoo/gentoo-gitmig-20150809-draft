# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-3.3.6-r1.ebuild,v 1.20 2011/11/09 19:22:56 vapier Exp $

MAN_VER=""
PATCH_VER="1.7"
UCLIBC_VER="1.0"
PIE_VER="8.7.8"
PP_VER="1.0"
HTB_VER="1.00-r2"

# arch/libc configurations known to be stable with {PIE,SSP}-by-default
SSP_STABLE="x86 sparc amd64"
SSP_UCLIBC_STABLE="arm mips ppc x86"
PIE_GLIBC_STABLE="x86 sparc amd64"
PIE_UCLIBC_STABLE="x86 mips ppc"

# arch/libc configurations known to be broken with {PIE,SSP}-by-default
SSP_UNSUPPORTED="hppa"
SSP_UCLIBC_UNSUPPORTED="${SSP_UNSUPPORTED}"
PIE_UCLIBC_UNSUPPORTED="alpha amd64 arm hppa ia64 m68k ppc64 s390 sh sparc"
PIE_GLIBC_UNSUPPORTED="hppa"

# whether we should split out specs files for multiple {PIE,SSP}-by-default
# and vanilla configurations.
SPLIT_SPECS=no

#GENTOO_PATCH_EXCLUDE=""
#PIEPATCH_EXCLUDE=""

inherit toolchain eutils

DESCRIPTION="The GNU Compiler Collection"

# ia64 - broken static handling; USE=static emerge busybox
KEYWORDS="~amd64 ~x86"

# NOTE: we SHOULD be using at least binutils 2.15.90.0.1 everywhere for proper
# .eh_frame ld optimisation and symbol visibility support, but it hasnt been
# well tested in gentoo on any arch other than amd64!!
RDEPEND=">=sys-devel/binutils-2.14.90.0.6-r1"
DEPEND="${RDEPEND}
	amd64? ( >=sys-devel/binutils-2.15.90.0.1.1-r1 )"

src_unpack() {
	toolchain_src_unpack

	if [[ -n ${UCLIBC_VER} ]] && [[ ${CTARGET} == *-uclibc* ]] ; then
		mv "${S}"/gcc-3.3.2/libstdc++-v3/config/os/uclibc "${S}"/libstdc++-v3/config/os/ || die
		mv "${S}"/gcc-3.3.2/libstdc++-v3/config/locale/uclibc "${S}"/libstdc++-v3/config/locale/ || die
	fi

	# misc patches that havent made it into a patch tarball yet
	[[ ${CHOST} == ${CTARGET} ]] && epatch "${FILESDIR}"/gcc-spec-env.patch

	# Anything useful and objc will require libffi. Seriously. Lets just force
	# libffi to install with USE="objc", even though it normally only installs
	# if you attempt to build gcj.
	if ! use build && use objc && ! use gcj ; then
		epatch "${FILESDIR}"/3.3.4/libffi-without-libgcj.patch
		#epatch "${FILESDIR}"/3.4.3/libffi-nogcj-lib-path-fix.patch
	fi
}
