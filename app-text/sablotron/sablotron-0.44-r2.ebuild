# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/sablotron/sablotron-0.44-r2.ebuild,v 1.2 2000/12/17 20:09:01 achim Exp $

A="Sablot-${PV}.tar.gz Sablot-Expat-1.1.2.tar.gz"
S=${WORKDIR}/Sablot-${PV}
DESCRIPTION="An XSLT Parser in C++"
SRC_URI="http://www.gingerall.com/perl/rd?url=sablot/Sablot-${PV}.tar.gz
	http://www.gingerall.com/perl/rd?url=sablot/Sablot-Expat-1.1.2.tar.gz"
HOMEPAGE="http://www.gingerall.com/charlie-bin/get/webGA/act/sablotron.act"

DEPEND=">=sys-devel/gcc-2.95.2
	>=sys-libs/glibc-2.1.3"

src_unpack() {
  unpack Sablot-${PV}.tar.gz
  cd ${S}
  unpack Sablot-Expat-1.1.2.tar.gz
  if [ "`use glibc22`" ]
  then
	cp ${FILESDIR}/utf8.cpp Sablot/engine/
  fi
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



