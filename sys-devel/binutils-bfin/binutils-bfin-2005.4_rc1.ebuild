# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils-bfin/binutils-bfin-2005.4_rc1.ebuild,v 1.1 2006/01/15 11:41:17 vapier Exp $

[[ ${CTARGET} != bfin* && ${CATEGORY} == "sys-devel" ]] && export CTARGET="bfin-elf"

BINUTILS_TYPE="custom"
BINUTILS_VER="2.15"
ELF2FLT_VER="20060111"
inherit toolchain-binutils

STUPID_STAMP="774"
MY_PV="3.4.05r4-2"
DESCRIPTION="Binutils for Blackfin targets"
HOMEPAGE="http://blackfin.uclinux.org/"
SRC_URI="http://blackfin.uclinux.org/frs/download.php/${STUPID_STAMP}/bfin-gcc-${MY_PV}.tar.gz
	mirror://gentoo/elf2flt-${ELF2FLT_VER}.tar.bz2"

KEYWORDS="-* ~amd64 ~x86"

S=${WORKDIR}/bfin-gcc-${MY_PV}/binutils/binutils-${BINUTILS_VER}

src_unpack() {
	tc-binutils_unpack
	cd "${S}"
	epatch "${FILESDIR}"/binutils-bfin-2005.3.1-build.patch
	rm -r gdb libgloss mmalloc newlib readline sim
}
