# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/selfdhcp/selfdhcp-0.2a.ebuild,v 1.1 2004/08/25 16:58:00 tantive Exp $

inherit gnuconfig flag-o-matic eutils

DESCRIPTION="a small stealth network autoconfigure software."
SRC_URI="mirror://sourceforge/selfdhcp/${P}.tar.bz2"
HOMEPAGE="http://selfdhcp.sourceforge.net"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

DEPEND="dev-libs/popt
		dev-libs/libxml2
		>=net-libs/libnet-1.0.2
		>=net-libs/libpcap-0.7"

src_compile() {
	gnuconfig_update
	econf --sysconfdir=/etc --sbindir=/sbin || die
	emake || die
}

src_install() {
	einstall sbindir=${D}/sbin|| die
	dodoc AUTHORS ChangeLog COPYING INSTALL README TODO
	}
