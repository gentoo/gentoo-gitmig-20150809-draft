# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@intphsys.com>
# $Header: /var/cvsroot/gentoo-x86/app-text/xpdf/xpdf-0.92-r2.ebuild,v 1.1 2001/10/06 15:30:16 danarmak Exp $

S=${WORKDIR}/${P}

SRC_URI="ftp://ftp.foolabs.com/pub/xpdf/${P}.tgz"
HOMEPAGE="http://www.foolabs.com/xpdf/xpdf.html"
DESCRIPTION="An X Viewer for PDF Files"

DEPEND="virtual/x11
	>=media-libs/freetype-1.3
	>=media-libs/t1lib-1.0.1"

src_compile() {
	./configure --prefix=/usr --mandir=/usr/man --with-gzip || die
	make || die
}


src_install() {
	# don't use builtin make install, as it doesn't compress manpages
	into /usr
	dodoc README ANNOUNCE CHANGES
	doman doc/*.1
	dobin xpdf/pdfimages xpdf/pdfinfo xpdf/pdftopbm xpdf/pdftops xpdf/pdftotext xpdf/xpdf        
}
