# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc-apple/gcc-apple-1762.ebuild,v 1.3 2005/03/18 16:49:25 vapier Exp $

DESCRIPTION="Apple branch of the GNU compiler (based on gcc-3.5.0-tree-ssa)"
HOMEPAGE="http://darwinsource.opendarwin.org/"
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

S=${WORKDIR}/gcc-${PV}

src_compile() {
	:
}

src_install() {
	mkdir -p "${S}"/build/obj "${S}"/build/sym
	gnumake \
		RC_OS=macos RC_ARCHS=ppc TARGETS=ppc \
		SRCROOT="${S}" OBJROOT="${S}"/build/obj \
		DSTROOT="${D}" SYMROOT="${S}"/build/sym \
		install \
		|| die

	if use build ; then
		rm -r "${D}"/Developer
		rm -r "${D}"/usr/share
	fi
}
