# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xfig/xfig-3.2.3d-r1.ebuild,v 1.7 2003/01/08 03:26:59 george Exp $

IUSE=""

MY_P=${P/xfig-/xfig.}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A menu-driven tool to draw and manipulate objects interactively in an X window."
SRC_URI="http://www.xfig.org/xfigdist/${MY_P}.full.tar.gz"
HOMEPAGE="http://www.xfig.org"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc"

DEPEND="virtual/x11
	media-libs/jpeg
	media-libs/libpng"

RDEPEND="${DEPEND}
	media-gfx/transfig
	media-libs/netpbm"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}.patch
}

src_compile() {
	xmkmf || die
	make || die
}

src_install () {
	make \
		DESTDIR=${D} \
		install || die

	make \
		DESTDIR=${D} \
		MANDIR=/usr/share/man/man1 \
		MANSUFFIX=1 \
		install.all || die

	dodoc README FIGAPPS CHANGES LATEX.AND.XFIG
}
