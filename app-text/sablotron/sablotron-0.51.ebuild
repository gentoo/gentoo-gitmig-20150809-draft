# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/sablotron/sablotron-0.51.ebuild,v 1.2 2001/03/18 03:08:07 drobbins Exp $

A="Sablot-${PV}.tar.gz"
S=${WORKDIR}/Sablot-${PV}
DESCRIPTION="An XSLT Parser in C++"
SRC_URI="http://www.gingerall.com/perl/rd?url=sablot/${A}"
HOMEPAGE="http://www.gingerall.com/charlie-bin/get/webGA/act/sablotron.act"

DEPEND=">=sys-devel/gcc-2.95.2 >=dev-libs/expat-1.95.1 virtual/glibc"

src_unpack() {
	unpack Sablot-${PV}.tar.gz
#	iif [ "`use glibc22`" ]
#	then
#		cd ${S}/Sablot/engine
#		cp utf8.cpp utf8.cpp.orig
#		sed -e '44d;46d' utf8.cpp.orig > utf8.cpp
#	fi
}

src_compile() {
    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try pmake

}

src_install () {
    cd ${S}
    dodir /usr/lib
    dodir /usr/include
    dodir /usr/bin
    try make prefix=${D}/usr install
    dodoc README
    dodoc Sablot/RELEASE Sablot/TODO
}



