# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/sablotron/sablotron-0.44.ebuild,v 1.1 2000/09/20 17:15:17 achim Exp $

A="Sablot-${PV}.tar.gz Sablot-Expat-1.1.2.tar.gz"
S=${WORKDIR}/Sablot-${PV}
DESCRIPTION="An XSLT Parser in C++"
SRC_URI="http://www.gingerall.com/perl/rd?url=sablot/Sablot-${PV}.tar.gz
	http://www.gingerall.com/perl/rd?url=sablot/Sablot-Expat-1.1.2.tar.gz"
HOMEPAGE="http://www.gingerall.com/charlie-bin/get/webGA/act/sablotron.act"

src_unpack() {
  unpack Sablot-${PV}.tar.gz
  cd ${S}
  unpack Sablot-Expat-1.1.2.tar.gz
}
src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    dodir /usr/lib
    dodir /usr/include
    dodir /usr/bin
    try make prefix=${D}/usr install
    dodoc README
    dodoc Sablot/RELEASE Sablot/TODO
    docinto html/expat
    dodoc Expat/distribution/expat.html
}



