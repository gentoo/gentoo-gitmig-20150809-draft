#Copyright 2002 Gentoo Technologies, Inc.
#Distributed under the terms of the GNU General Public License, v2 or later
#$Header: /var/cvsroot/gentoo-x86/media-gfx/xpaint/xpaint-2.6.2-r1.ebuild,v 1.2 2002/07/23 05:18:07 seemant Exp $

S=${WORKDIR}/xpaint
DESCRIPTION="XPaint is an image editor which supports most standard paint program options."
SRC_URI="http://home.worldonline.dk/~torsten/xpaint/${P}.tar.gz"
HOMEPAGE="http://home.worldonline.dk/~torsten/xpaint/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=media-libs/tiff-3.2 
	virtual/x11 
	media-libs/jpeg
	media-libs/libpng"

src_unpack() {

	unpack ${P}.tar.gz
	cd ${S}
	patch -p0 < ${FILESDIR}/Local.config-2.6.2.diff

}

src_compile() {

	xmkmf || die
	make Makefiles || die
	emake || die

}

src_install () {

	make DESTDIR=${D} install || die
	make DESTDIR=${D} install.man || die
	dodoc ChangeLog INSTALL README README.PNG README.old TODO 

}
