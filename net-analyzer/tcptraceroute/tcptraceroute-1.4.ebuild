# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcptraceroute/tcptraceroute-1.4.ebuild,v 1.6 2003/04/29 00:40:35 zwelch Exp $

S=${WORKDIR}/${P}
DESCRIPTION="tcptraceroute is a traceroute implementation using TCP packets"
SRC_URI="http://michael.toren.net/code/${PN}/${P}.tar.gz"
HOMEPAGE="http://michael.toren.net/code/tcptraceroute/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc arm"

DEPEND="net-libs/libpcap
	=net-libs/libnet-1.0*"

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
