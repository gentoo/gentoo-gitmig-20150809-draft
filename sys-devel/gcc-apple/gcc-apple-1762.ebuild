# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc-apple/gcc-apple-1762.ebuild,v 1.2 2005/02/19 23:57:24 swegener Exp $

S=${WORKDIR}/gcc-${PV}

DESCRIPTION="Apple branch of the GNU compiler based on gcc version 3.5.0-tree-ssa"
WEBPAGE="http://darwinsource.opendarwin.org/"
SRC_URI="http://darwinsource.opendarwin.org/tarballs/other/gcc-${PV}.tar.gz"

LICENSE="APSL-2 GPL-2"

SLOT="0"
KEYWORDS="-* ~ppc-macos"
IUSE="build nls"

RDEPEND="virtual/libc
		sys-libs/zlib
		!build? (
			nls? ( sys-devel/gettext )
			sys-libs/ncurses
		)"

DEPEND="sys-apps/texinfo
		sys-devel/bison
		sys-devel/cctools-extras
		sys-libs/csu"

src_compile() {
	:
}

src_install() {
	mkdir -p ${S}/build/obj ${S}/build/sym
	cd ${S}
	gnumake RC_OS=macos RC_ARCHS=ppc TARGETS=ppc \
		SRCROOT=${S} OBJROOT=${S}/build/obj \
		DSTROOT=${D} SYMROOT=${S}/build/sym\
		install|| die

	if use build; then
		rm -rf ${D}/Developer
		rm -rf ${D}/usr/share
	fi
}
