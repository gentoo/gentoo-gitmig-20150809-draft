# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Tools Team <tools@gentoo.org>
# Author: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/html-xml-utils/html-xml-utils-2.3.ebuild,v 1.1 2002/03/16 16:23:45 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A number of simple utilities for manipulating HTML and XML files."
SRC_URI="http://www.w3.org/Tools/HTML-XML-utils/${P}.tar.gz"
HOMEPAGE="http://www.w3.org/Tools/HTML-XML-utils/"

DEPEND="virtual/glibc"

src_compile() {

	./configure --prefix=/usr \
			--mandir=/usr/share/man \
			--host=${CHOST} || die
	make || die
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING NEWS README TODO
}
