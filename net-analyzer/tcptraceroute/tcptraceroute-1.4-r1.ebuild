# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcptraceroute/tcptraceroute-1.4-r1.ebuild,v 1.2 2003/06/28 18:02:41 aliz Exp $

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="tcptraceroute is a traceroute implementation using TCP packets"
SRC_URI="http://michael.toren.net/code/tcptraceroute/${P}.tar.gz"
HOMEPAGE="http://michael.toren.net/code/tcptraceroute/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc arm"

DEPEND="net-libs/libpcap
	=net-libs/libnet-1.0*"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	cd ${S}
	make CFLAGS="$CFLAGS" || die
}

src_install () {
	dodir /usr/bin
	dobin tcptraceroute
	fperms u+s /usr/bin/tcptraceroute

	doman tcptraceroute.8
	dodoc examples.txt COPYING README changelog
	dohtml -r ./
}
