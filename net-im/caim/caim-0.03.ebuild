# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/caim/caim-0.03.ebuild,v 1.2 2001/04/29 19:42:08 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Console AIM Client"
SRC_URI="http://www.mercyground.co.uk/${A}"
HOMEPAGE="http://www.mercyground.co.uk"

DEPEND=">=sys-libs/ncurses-5.1"

src_unpack() {

    unpack ${A}
    patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
    cd ${S}
    echo "CFLAGS += ${CFLAGS}" >> Makefile.rules

}

src_compile() {

    try make

}

src_install () {

    dobin client/caim
    dolib libfaim.so
    dodoc README Changes
    docinto libfaim
    dodoc faimdocs/BUGS faimdocs/CHANGES faimdocs/README
 
}
