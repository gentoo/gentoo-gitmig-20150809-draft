# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-dialup/rp-pppoe/rp-pppoe-3.4.ebuild,v 1.2 2002/07/11 06:30:45 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}/src
DESCRIPTION="A user-mode PPPoE client and server suite for Linux"
SRC_URI="http://www.roaringpenguin.com/pppoe/${A}"
HOMEPAGE="http://www.roaringpeguin.com/"

DEPEND="virtual/glibc >=net-dialup/ppp-2.4.1"

src_compile() {

    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST}
    try make

}

src_install () {

    try make RPM_INSTALL_ROOT=${D} install
    dodir /usr/share/doc
    mv ${D}/usr/doc/${P} ${D}/usr/share/doc/${PF}
    rm -rf ${D}/usr/doc
    prepalldocs

}

