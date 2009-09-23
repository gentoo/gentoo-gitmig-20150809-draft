# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ifstat/ifstat-1.1.ebuild,v 1.15 2009/09/23 18:19:40 patrick Exp $

inherit eutils

IUSE="snmp"

DESCRIPTION="Network interface bandwidth usage, with support for snmp targets."
SRC_URI="http://gael.roualland.free.fr/ifstat/${P}.tar.gz"
HOMEPAGE="http://gael.roualland.free.fr/ifstat/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="sparc x86 amd64 ppc64 hppa ppc"

DEPEND="snmp? ( >=net-analyzer/net-snmp-5.0 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-strip_and_cflags.patch
}

src_install () {
	einstall || die
	dodoc HISTORY README TODO VERSION
}
