# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libwmf/libwmf-0.2.8.ebuild,v 1.2 2003/05/13 05:18:22 vladimir Exp $

inherit libtool

IUSE="jpeg X"

#The configure script finds the 5.50 ghostscript Fontmap file while run.
#This will probably work, especially since the real one (6.50) in this case
#is empty. However beware in case there is any trouble

S=${WORKDIR}/${P}
DESCRIPTION="library for converting WMF files"
SRC_URI="mirror://sourceforge/wvware/${P}.tar.gz"
HOMEPAGE="http://www.wvware.com/libwmf.html"

SLOT="0"
KEYWORDS="~x86 ppc"
LICENSE="GPL-2"

DEPEND=">=app-text/ghostscript-6.50
	dev-libs/expat
	dev-libs/libxml2
	>=media-libs/freetype-2.0.1
	sys-libs/zlib
	media-libs/libpng
	jpeg? ( media-libs/jpeg )
	X? ( virtual/x11 )"
# plotutils are not really supported yet, so looks like that's it

src_compile() {
	# Have to use the reverse-deps patch to prevent libwmf from
    # linking an older installed version of libwmflite
	elibtoolize --reverse-deps
	
	use jpeg || myconf="${myconf} --with-jpeg=no"
	use X || myconf="${myconf} --with-x=no"

	econf \
		${myconf} \
		--with-gsfontdir=/usr/share/ghostscript/fonts \
		--with-fontdir=/usr/share/libwmf/fonts/ \
		--with-docdir=/usr/share/doc/${PF} || die "./configure failed"

	make || die
}

src_install () {
	    
	# Must use einstall because of stubborn libtool
    einstall \
		fontdir=${D}/usr/share/libwmf/fonts \
		wmfonedocdir=${D}/usr/share/doc/${PF}/caolan \
		wmfdocdir=${D}/usr/share/doc/${PF} \
		libdir=${D}/usr/lib \
		|| die
    dodoc README AUTHORS COPYING CREDITS ChangeLog NEWS TODO
}
