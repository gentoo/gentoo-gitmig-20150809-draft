# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/xpdf/xpdf-1.01.ebuild,v 1.4 2002/08/02 17:42:50 phoenix Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An X Viewer for PDF Files"
SRC_URI="ftp://ftp.foolabs.com/pub/xpdf/${P}.tar.gz"
HOMEPAGE="http://www.foolabs.com/xpdf/xpdf.html"
SLOT="0"

LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="virtual/x11
	>=media-libs/freetype-2.0.9
	>=media-libs/t1lib-1.3"

src_compile() {
	./configure --enable-freetype2 \
		--with-freetype2-library=/usr/lib \
		--with-freetype2-includes=/usr/include/freetype2 \
		--prefix=/usr \
		--mandir=/usr/share/man \
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
