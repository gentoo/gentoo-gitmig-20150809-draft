# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/sablotron/sablotron-0.43-r1.ebuild,v 1.3 2000/08/25 13:47:34 achim Exp $

P=sablotron-0.43
A="Sablot-0.43.tar.gz Sablot-Expat-1.1.2.tar.gz"
S=${WORKDIR}/Sablot-0.43
DESCRIPTION="An XSLT Parser in C++"
SRC_URI="http://www.gingerall.com/download/Sablot-0.43.tar.gz
	http://www.gingerall.com/download/Sablot-Expat-1.1.2.tar.gz"
HOMEPAGE="http://www.gingerall.com/charlie-bin/get/webGA/act/sablotron.act"

src_unpack() {
  unpack Sablot-0.43.tar.gz
  cd ${S}
  unpack Sablot-Expat-1.1.2.tar.gz
}
src_compile() {

    cd ${S}
    ./configure --prefix=/usr --host=${CHOST}
    make

}

src_install () {

    cd ${S}
    dodir /usr/lib
    dodir /usr/include
    dodir /usr/bin
    make prefix=${D}/usr install
    dodoc README
    dodoc Sablot/RELEASE Sablot/TODO
    docinto html/expat
    dodoc Expat/distribution/expat.html
}



