# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-dialup/wvdial/wvdial-1.41-r1.ebuild,v 1.3 2000/09/15 20:09:08 drobbins Exp $

P=wvdial-1.41
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Excellent program which automatically configures your PPP session"
SRC_URI="http://www.worldvisions.ca/wvdial/wvdial-1.41.tar.gz"
HOMEPAGE="http://www.worldvisions.ca/wvdial/"

src_compile() {                           
    try make
}

src_unpack() {
    unpack ${A}
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
    doins ppp.provider
    dodoc ANNOUNCE CHANGES COPYING.LIB README
    dodoc debian/changelog debian/copyright 
}


