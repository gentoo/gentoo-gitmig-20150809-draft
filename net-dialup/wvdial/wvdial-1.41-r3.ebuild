# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-dialup/wvdial/wvdial-1.41-r3.ebuild,v 1.1 2001/04/24 15:59:19 achim Exp $

P=wvdial-1.41
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Excellent program which automatically configures your PPP session"
SRC_URI="http://www.worldvisions.ca/wvdial/wvdial-1.41.tar.gz"
HOMEPAGE="http://www.worldvisions.ca/wvdial/"

DEPEND=">=sys-devel/gcc-2.95.2
	>=sys-libs/glibc-2.1.3"

src_compile() {                           
    try make
}

src_unpack() {
    unpack ${A}
    patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
    cd ${S}
    cp rules.mk rules.mk.orig
    sed -e "s/-g//g" -e "s/-O6/${CFLAGS}/" rules.mk.orig > rules.mk
    cp Makefile Makefile.orig
    sed -e "s:PREFIX=/usr/local:PREFIX=/usr:" Makefile.orig > Makefile
}

src_install() {                               
    into /usr
    dobin wvdial/wvdial wvdial/wvdialconf
    doman *.1
    insinto /etc/ppp/peers
    newins ppp.provider wvdial
    dodoc ANNOUNCE CHANGES COPYING.LIB README
    dodoc debian/changelog debian/copyright 
}


