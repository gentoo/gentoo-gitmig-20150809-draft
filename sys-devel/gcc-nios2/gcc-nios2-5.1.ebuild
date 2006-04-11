# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc-nios2/gcc-nios2-5.1.ebuild,v 1.3 2006/04/11 00:17:38 vapier Exp $

[[ ${CTARGET} != nios* && ${CATEGORY} == "sys-devel" ]] && export CTARGET="nios2-elf"
GCC_A_FAKEIT=${A}
export USE="nocxx -fortran -gcj -objc -multilib"

ETYPE="gcc-compiler"

SPLIT_SPECS=false
TOOLCHAIN_GCC_PV=3.4.1
inherit toolchain eutils

DESCRIPTION="Compiler for Nios2 targets"
# http://www.altera.com/support/kdb/2000/11/rd11272000_7307.html
SRC_URI="mirror://gentoo/niosii-gnutools-src-${PV}.tgz
	mirror://gentoo/nios2-${PV}.patch.bz2"

KEYWORDS="-* ~amd64 ~ppc ~ppc64 ~x86"

DEPEND="${CATEGORY}/binutils-nios2"

S=${WORKDIR}/src/gcc

src_unpack() {
	toolchain_src_unpack
	cd "${WORKDIR}"/src
	epatch "${DISTDIR}"/nios2-${PV}.patch.bz2
}
