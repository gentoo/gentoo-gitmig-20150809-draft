# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/html-xml-utils/html-xml-utils-2.3-r1.ebuild,v 1.8 2004/04/26 11:51:32 obz Exp $

DESCRIPTION="A number of simple utilities for manipulating HTML and XML files."
SRC_URI="http://www.w3.org/Tools/HTML-XML-utils/${P}.tar.gz"
HOMEPAGE="http://www.w3.org/Tools/HTML-XML-utils/"
LICENSE="W3C"

KEYWORDS="x86 sparc"
SLOT="0"
IUSE=""

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

	# Check bug #27399, the following binary conflicts with
	# one provided by the 'normalize' package, so we're
	# renaming this one <obz@gentoo.org>
	mv ${D}/usr/bin/normalize ${D}/usr/bin/normalize-html
	mv ${D}/usr/share/man/man1/normalize.1 \
	   ${D}/usr/share/man/man1/normalize-html.1

}
