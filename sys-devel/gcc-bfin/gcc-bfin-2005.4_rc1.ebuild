# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc-bfin/gcc-bfin-2005.4_rc1.ebuild,v 1.2 2006/04/11 00:18:04 vapier Exp $

[[ ${CTARGET} != bfin* && ${CATEGORY} == "sys-devel" ]] && export CTARGET="bfin-elf"
GCC_A_FAKEIT=${A}
export USE="nocxx -fortran -gcj -objc -multilib"

ETYPE="gcc-compiler"

SPLIT_SPECS=false
TOOLCHAIN_GCC_PV=3.4.4
inherit toolchain eutils

STUPID_STAMP="774"
MY_PV="3.4.05r4-2"
DESCRIPTION="Compiler for Blackfin targets"
HOMEPAGE="http://blackfin.uclinux.org/"
SRC_URI="http://blackfin.uclinux.org/frs/download.php/${STUPID_STAMP}/bfin-gcc-${MY_PV}.tar.gz"

KEYWORDS="-* ~amd64 ~ppc ~ppc64 ~x86"

DEPEND="${CATEGORY}/binutils-bfin"

S=${WORKDIR}/bfin-gcc-${MY_PV}/gcc-3.4

src_unpack() {
	toolchain_src_unpack
	# workaround for parallel build issue
	rm "${S}"/gcc/gengtype-yacc.c
}
