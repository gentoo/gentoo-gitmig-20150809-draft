# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xfig/xfig-3.2.3d-r1.ebuild,v 1.3 2002/07/23 05:18:07 seemant Exp $

MY_P=${P/xfig-/xfig.}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A menu-driven tool to draw and manipulate objects interactively in an X window."
SRC_URI="http://www.xfig.org/xfigdist/${MY_P}.full.tar.gz"
HOMEPAGE="http://www.xfig.org"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86"

DEPEND="virtual/x11
	media-libs/jpeg
	media-libs/libpng"

RDEPEND="${DEPEND}
	media-gfx/transfig"

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
