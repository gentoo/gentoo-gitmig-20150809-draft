# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/netkit-base/netkit-base-0.17-r1.ebuild,v 1.4 2000/10/03 16:02:05 achim Exp $

P=netkit-base-0.17
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard linux net thingees -- inetd, ping"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${A}"

src_compile() {                           
    try make
}

src_unpack() {
    unpack ${A}
    cd ${S}
    try ./configure
    mv MCONFIG MCONFIG.orig
    sed -e "s/-pipe -O2/${CFLAGS}/" MCONFIG.orig > MCONFIG
}

src_install() {                               
    into /
    dobin ping/ping
    into /usr
    dosbin inetd/inetd
    doman inetd/inetd.8 ping/ping.8 
    dodoc BUGS ChangeLog README
    docinto samples
    dodoc etc.sample/*
}



