# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-4.0.4.ebuild,v 1.13 2011/12/03 02:36:35 vapier Exp $

PATCH_VER="1.1"
UCLIBC_VER="1.0"
PIE_VER="8.7.8"
PP_VER=""
HTB_VER=""

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
