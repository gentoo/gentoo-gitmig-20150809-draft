# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/html-xml-utils/html-xml-utils-2.3-r1.ebuild,v 1.5 2004/01/17 09:49:57 obz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A number of simple utilities for manipulating HTML and XML files."
SRC_URI="http://www.w3.org/Tools/HTML-XML-utils/${P}.tar.gz"
HOMEPAGE="http://www.w3.org/Tools/HTML-XML-utils/"
KEYWORDS="x86 sparc "
SLOT="0"
LICENSE="W3C"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp heap.c heap.c.orig
	sed -e "s/#define FILE.*/#define FILE __FILE__/" \
		-e "s/#define LINE.*/#define LINE __LINE__/" \
		< heap.c.orig > heap.c || die
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING NEWS README TODO
}
