# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/firewalk/firewalk-5.0.ebuild,v 1.1 2005/01/25 11:29:05 angusyoung Exp $

inherit eutils

DESCRIPTION="A tool for determining a firewall's rule set"
SRC_URI="http://www.packetfactory.net/firewalk/dist/${P}.tgz"
HOMEPAGE="http://www.packetfactory.net/firewalk/"
IUSE=""

S=${WORKDIR}/Firewalk

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=net-libs/libpcap-0.6.1
	>=net-libs/libnet-1.1.1
	>=dev-libs/libdnet-1.7"

src_compile() {
	cd ${S}
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || "einstall failed"
	doman man/firewalk.8
	dodoc README TODO BUGS
}
