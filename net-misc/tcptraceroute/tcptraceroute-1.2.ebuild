# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/tcptraceroute/tcptraceroute-1.2.ebuild,v 1.1 2001/11/20 01:32:50 blocke Exp $


S=${WORKDIR}/${P}
DESCRIPTION="tcptraceroute is a traceroute implementation using TCP packets"
SRC_URI="http://michael.toren.net/code/tcptraceroute/${P}.tar.gz"
HOMEPAGE="http://michael.toren.net/code/tcptraceroute/"

DEPEND="sys-libs/glibc net-libs/libpcap net-libs/libnet"

src_compile() {
    cd ${S}
    make || die
}

src_install () {
    cd ${S}

    dodir /usr/sbin
    dosbin tcptraceroute

    doman tcptraceroute.8
    dodoc tcptraceroute.8.html examples.txt COPYING README changelog
}
