# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcptraceroute/tcptraceroute-1.2.ebuild,v 1.3 2002/07/18 23:22:51 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="tcptraceroute is a traceroute implementation using TCP packets"
SRC_URI="http://michael.toren.net/code/tcptraceroute/${P}.tar.gz"
HOMEPAGE="http://michael.toren.net/code/tcptraceroute/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="net-libs/libpcap
	net-libs/libnet"

src_compile() {
    cd ${S}
    make CFLAGS="$CFLAGS" || die
}

src_install () {
    cd ${S}

    dodir /usr/sbin
    dosbin tcptraceroute

    doman tcptraceroute.8
    dodoc examples.txt COPYING README changelog
	dohtml -r ./
}
