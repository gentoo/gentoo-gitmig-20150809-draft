# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/html-xml-utils/html-xml-utils-1.3.ebuild,v 1.2 2000/09/15 20:08:46 drobbins Exp $

P=html-xml-utils-1.3
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A number of simple utilities for manipulating HTML and XML files."
SRC_URI="http://www.w3.org/Tools/HTML-XML-utils/${A}"
HOMEPAGE="http://www.w3.org/Tools/HTML-XML-utils/"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    prepman
    dodoc AUTHORS ChangeLog COPYING NEWS README 

}


