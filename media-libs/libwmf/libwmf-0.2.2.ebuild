# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License
# Maintainer: George Shapovalov <georges@cco.caltech.edu>
# /space/gentoo/cvsroot/gentoo-x86/dev-libs/libwmf/libwmf-0.2.2.ebuild,v 1.2 2002/01/24 19:40:43 karltk Exp

#The configure script finds the 5.50 ghostscript Fontmap file while run.
#This will probably work, especially since the real one (6.50) in this case
#is empty. However beware in case there is any trouble


S=${WORKDIR}/${P}
DESCRIPTION="library for converting WMF files"
SRC_URI="http://prdownloads.sourceforge.net/wvware/libwmf-0.2.2.tar.gz"
HOMEPAGE="http://www.wvware.com/libwmf.html"

DEPEND="virtual/glibc
	>=sys-devel/gcc-2.95.2
	>=app-text/ghostscript-6.50 
	dev-libs/expat
	dev-libs/libxml2
	>=media-libs/freetype-2.0.1
	sys-libs/zlib
	media-libs/libpng
	media-libs/jpeg"
# plotutils are not really supported yet, so looks like that's it
	
RDEPEND=""

src_compile() {
	
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-gsfontdir=/usr/share/ghostscript/fonts \
		--with-fontdir=/usr/share/libwmf/fonts/ \
		--with-docdir=${D}/usr/share/doc/${PF} || die "./configure failed"

	make || die
}

src_install () {
    make \
        prefix=${D}/usr \
        mandir=${D}/usr/share/man \
        infodir=${D}/usr/share/info \
		fontdir=${D}/usr/share/libwmf/fonts/ \
        install || die
}
