# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libhtmlparse/libhtmlparse-0.1.12.ebuild,v 1.3 2004/03/14 12:22:07 mr_bones_ Exp $

DESCRIPTION="libhtmlparse is a HTML parsing library. It takes HTML tags, text, etc and calls callbacks you define for each type of token in the document."
HOMEPAGE="http://msalem.translator.cx/libhtmlparse.html"
SRC_URI="http://msalem.translator.cx/dist/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS COPYING INSTALL ChangeLog NEWS README TODO
}
