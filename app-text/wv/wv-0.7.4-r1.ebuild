# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wv/wv-0.7.4-r1.ebuild,v 1.2 2003/02/13 09:48:03 vapier Exp $

S=${WORKDIR}/${P}

DESCRIPTION="tool for convertion of MSWord doc and rtf files to something readable"
SRC_URI="mirror://sourceforge/wvware/${P}.tar.gz"
HOMEPAGE="http://www.wvware.com"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-libs/libwmf-0.2.2 
	>=media-libs/freetype-2.0.1
	sys-libs/zlib
	media-libs/libpng"
	
RDEPEND="media-gfx/imagemagick"		

src_compile() {
	
	econf \
		--with-docdir=/usr/share/doc/${PF} || die 

	make || die
}

src_install () {
	einstall
	
	insinto /usr/include
	doins wvinternal.h
	
	rm -f ${D}/usr/share/man/man1/wvConvert.1
	dosym  /usr/share/man/man1/wvWare.1 /usr/share/man/man1/wvConvert.1
}
