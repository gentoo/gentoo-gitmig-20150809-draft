# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libwmf/libwmf-0.2.7.ebuild,v 1.1 2002/11/27 11:09:33 bcowan Exp $

#The configure script finds the 5.50 ghostscript Fontmap file while run.
#This will probably work, especially since the real one (6.50) in this case
#is empty. However beware in case there is any trouble

S=${WORKDIR}/${P}

DESCRIPTION="library for converting WMF files"
SRC_URI="mirror://sourceforge/wvware/${P}.tar.gz"
HOMEPAGE="http://www.wvware.com/libwmf.html"

SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

DEPEND=">=app-text/ghostscript-6.50 
	dev-libs/expat
	dev-libs/libxml2
	>=media-libs/freetype-2.0.1
	sys-libs/zlib
	media-libs/libpng
	media-libs/jpeg"
# plotutils are not really supported yet, so looks like that's it
	
src_compile() {
	
	econf \
		--with-gsfontdir=/usr/share/ghostscript/fonts \
		--with-fontdir=/usr/share/libwmf/fonts/ \
		--with-docdir=${D}/usr/share/doc/${PF} || die 

	emake || die
}

src_install () {
    einstall \
		fontdir=${D}/usr/share/libwmf/fonts || die

	dodoc README AUTHORS COPYING CREDITS ChangeLog NEWS TODO
}
