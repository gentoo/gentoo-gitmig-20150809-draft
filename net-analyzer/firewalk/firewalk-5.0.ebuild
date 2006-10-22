# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/firewalk/firewalk-5.0.ebuild,v 1.9 2006/10/22 16:05:02 peper Exp $

inherit eutils

DESCRIPTION="A tool for determining a firewall's rule set"
HOMEPAGE="http://www.packetfactory.net/firewalk/"
SRC_URI="http://www.packetfactory.net/firewalk/dist/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="virtual/libpcap
	>=net-libs/libnet-1.1.1
	>=dev-libs/libdnet-1.7"

S="${WORKDIR}/Firewalk"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc3.4.diff
}

src_install() {
	make DESTDIR="${D}" install || "make install failed"
	doman man/firewalk.8
	dodoc README TODO BUGS
}
