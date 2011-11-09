# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-4.0.4.ebuild,v 1.11 2011/11/09 19:22:57 vapier Exp $

PATCH_VER="1.1"
UCLIBC_VER="1.0"
PIE_VER="8.7.8"
PP_VER=""
HTB_VER=""

# bug #126609
GENTOO_PATCH_EXCLUDE="33_all_gcc4-pr16104.patch"

# whether we should split out specs files for multiple {PIE,SSP}-by-default
# and vanilla configurations.
SPLIT_SPECS=no #${SPLIT_SPECS-true} hard disable until #106690 is fixed

inherit toolchain

DESCRIPTION="The GNU Compiler Collection"

LICENSE="GPL-2 LGPL-2.1 FDL-1.2"
KEYWORDS="-* ~ia64 ~m68k"

RDEPEND=""
DEPEND="${RDEPEND}
	>=${CATEGORY}/binutils-2.15.94"

src_unpack() {
	toolchain_src_unpack

	use vanilla && return 0

	[[ ${CHOST} == ${CTARGET} ]] && epatch "${FILESDIR}"/gcc-spec-env.patch

	# Fix cross-compiling
	epatch "${FILESDIR}"/4.0.2/gcc-4.0.2-cross-compile.patch

	[[ ${CTARGET} == *-softfloat-* ]] && epatch "${FILESDIR}"/4.0.2/gcc-4.0.2-softfloat.patch
}
