# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Ryan Tolboom <ryan@intphsys.com>
# $Header: /var/cvsroot/gentoo-x86/app-text/xpdf/xpdf-1.00.ebuild,v 1.1 2002/02/02 21:21:22 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An X Viewer for PDF Files"
SRC_URI="ftp://ftp.foolabs.com/pub/xpdf/${P}.tar.gz"
HOMEPAGE="http://www.foolabs.com/xpdf/xpdf.html"

DEPEND="virtual/x11
	>=media-libs/freetype-2.0.5
	>=media-libs/t1lib-1.3"

src_compile() {
	./configure --enable-freetype2 \
		--with-freetype2-library=/usr/lib \
		--with-freetype2-includes=/usr/include/freetype2 \
		--prefix=/usr \
		--mandir=/usr/man \
		--with-gzip || die
		
	make || die
}


src_install() {
	# don't use builtin make install, as it doesn't compress manpages
	into /usr
	dodoc README ANNOUNCE CHANGES
	doman doc/*.1
	dobin xpdf/pdfimages xpdf/pdfinfo xpdf/pdftopbm
	dobin xpdf/pdftops xpdf/pdftotext xpdf/xpdf        
}
