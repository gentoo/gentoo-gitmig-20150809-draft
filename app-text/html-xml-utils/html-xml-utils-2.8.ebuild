# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/html-xml-utils/html-xml-utils-2.8.ebuild,v 1.1 2004/01/17 09:49:57 obz Exp $

DESCRIPTION="A number of simple utilities for manipulating HTML and XML files."
SRC_URI="http://www.w3.org/Tools/HTML-XML-utils/${P}.tar.gz"
HOMEPAGE="http://www.w3.org/Tools/HTML-XML-utils/"
LICENSE="W3C"

IUSE=""
KEYWORDS="~x86 ~sparc"
SLOT="0"

DEPEND="virtual/glibc"

src_compile() {

	econf || die
	emake || die

}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL README TODO

}
