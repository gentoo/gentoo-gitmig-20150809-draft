# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/netkit-base/netkit-base-0.17-r1.ebuild,v 1.6 2001/02/03 20:10:31 achim Exp $

P=netkit-base-0.17
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard linux net thingees -- inetd, ping"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${A}"
DEPEND="virtual/glibc"

src_compile() {                           

    try ./configure
    mv MCONFIG MCONFIG.orig
    sed -e "s/-pipe -O2/${CFLAGS}/" MCONFIG.orig > MCONFIG

    try make ${MAKEOPTS}
}


src_install() {                               
    into /
    dobin ping/ping
    into /usr
    dosbin inetd/inetd
    doman inetd/inetd.8 inetd/daemon.3 ping/ping.8 
    dodoc BUGS ChangeLog README
    docinto samples
    dodoc etc.sample/*
}



