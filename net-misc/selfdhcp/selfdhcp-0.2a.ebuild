# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/selfdhcp/selfdhcp-0.2a.ebuild,v 1.5 2010/10/28 11:08:05 ssuominen Exp $

DESCRIPTION="a small stealth network autoconfigure software."
HOMEPAGE="http://selfdhcp.sourceforge.net"
SRC_URI="mirror://sourceforge/selfdhcp/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-libs/popt
	dev-libs/libxml2
	>=net-libs/libnet-1.0.2
	net-libs/libpcap"

src_compile() {
	econf --sysconfdir=/etc --sbindir=/sbin
	emake || die
}

src_install() {
	einstall sbindir="${D}"/sbin || die
	dodoc AUTHORS ChangeLog README TODO
}
