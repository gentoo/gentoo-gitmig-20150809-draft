# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-misc/clockspeed/clockspeed-0.62.ebuild,v 1.1 2001/04/20 00:23:24 pete Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="a simple ntp client"
SRC_URI="http://cr.yp.to/clockspeed/clockspeed-0.62.tar.gz"
HOMEPAGE="http://cr.yp.to/"

DEPEND="virtual/glibc"

src_unpack() {
    unpack ${A}
    cd ${S}
    patch -p1 < ${FILESDIR}/${PF}-gentoo.diff
    cp -a conf-cc conf-cc.orig
    sed "s/@CFLAGS@/${CFLAGS}/" < conf-cc.orig > conf-cc
}

src_compile() {
    try make
}

src_install () {
    dodir /etc /usr/bin /usr/share/man/man1
    insinto /etc
    doins leapsecs.dat
    
    into /usr
    dobin clockspeed clockadd clockview sntpclock taiclock taiclockd
    doman clockspeed.1 clockadd.1 clockview.1 sntpclock.1 taiclock.1 taiclockd.1
    
    dodoc BLURB CHANGES README THANKS TODO
}
