# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/sablotron/sablotron-0.52.ebuild,v 1.1 2001/05/06 18:24:28 achim Exp $

A="Sablot-${PV}.tar.gz"
S=${WORKDIR}/Sablot-${PV}
DESCRIPTION="An XSLT Parser in C++"
SRC_URI="http://www.gingerall.com/perl/rd?url=sablot/${A}"
HOMEPAGE="http://www.gingerall.com/charlie-bin/get/webGA/act/sablotron.act"

DEPEND=">=sys-devel/gcc-2.95.2 >=dev-libs/expat-1.95.1 virtual/glibc"


src_compile() {
    try ./configure --prefix=/usr --host=${CHOST}
    try pmake

}

src_install () {
    dodir /usr/lib
    dodir /usr/include
    dodir /usr/bin
    try make prefix=${D}/usr install
    dodoc README RELEASE 
    dodoc Sablot/TODO
}



