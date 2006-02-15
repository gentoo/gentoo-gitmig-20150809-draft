# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/angst/angst-0.4b-r1.ebuild,v 1.8 2006/02/15 21:10:56 jokey Exp $

inherit eutils

DESCRIPTION="an active sniffer that provides methods for aggressive sniffing on switched LANs"
HOMEPAGE="http://angst.sourceforge.net/"
SRC_URI="http://angst.sourceforge.net/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="net-libs/libpcap
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
