# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/angst/angst-0.4b-r1.ebuild,v 1.2 2003/08/27 19:59:21 vapier Exp $

inherit eutils

DESCRIPTION="an active sniffer that provides methods for aggressive sniffing on switched LANs"
HOMEPAGE="http://angst.sourceforge.net/"
SRC_URI="http://angst.sourceforge.net/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=net-libs/libpcap-0.7.1
	<net-libs/libnet-1.1
	>=net-libs/libnet-1.0.2a-r3"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-libnet-1.0.patch
}

src_compile() {
	make CFLAGS="${CFLAGS}" -f Makefile.linux || die
}

src_install() {
	dosbin angst
	doman angst.8
	dodoc README LICENSE TODO ChangeLog
}
