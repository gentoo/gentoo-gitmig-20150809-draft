# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/paketto/paketto-1.10-r1.ebuild,v 1.7 2004/03/21 13:00:46 mboman Exp $

inherit eutils

DESCRIPTION="Paketto Keiretsu - experimental TCP/IP tools - scanrand, minewt, lc, phentropy, paratrace"
HOMEPAGE="http://www.doxpara.com/paketto/"
SRC_URI="http://www.doxpara.com/paketto/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""

#paketto comes with local copies of these ...
DEPEND="<net-libs/libnet-1.1
	>=net-libs/libnet-1.0.2a-r3"
#	net-libs/libpcap
#	dev-libs/libtomcrypt"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc3.patch
	epatch ${FILESDIR}/${PV}-libnet-1.0.patch
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
	dodoc docs/lc_logs.txt docs/minewt_logs.txt docs/paratrace_logs.txt docs/scanrand_logs.txt
}
