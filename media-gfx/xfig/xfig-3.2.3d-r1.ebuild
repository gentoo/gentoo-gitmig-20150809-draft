# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <tadpol@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xfig/xfig-3.2.3d-r1.ebuild,v 1.2 2002/04/14 03:54:07 seemant Exp $

MY_P=${P/xfig-/xfig.}
S=${WORKDIR}/${MY_P}
DESCRIPTION=""
SRC_URI="http://www.xfig.org/xfigdist/${MY_P}.full.tar.gz"
HOMEPAGE="http://www.xfig.org"

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
    #Now install it.
    make    \
        DESTDIR=${D}    \
        install || die  

    make    \
        DESTDIR=${D}    \
        MANDIR=/usr/share/man/man1  \
        MANSUFFIX=1 \
        install.all || die

    #Install docs
    dodoc README FIGAPPS CHANGES LATEX.AND.XFIG
}
