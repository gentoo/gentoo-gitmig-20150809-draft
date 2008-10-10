# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ifstat/ifstat-1.1.ebuild,v 1.13 2008/10/10 11:20:01 jer Exp $

inherit eutils

IUSE="snmp"

DESCRIPTION="Network interface bandwidth usage, with support for snmp targets."
SRC_URI="http://gael.roualland.free.fr/ifstat/${P}.tar.gz"
HOMEPAGE="http://gael.roualland.free.fr/ifstat/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="sparc x86 amd64 ppc64 hppa ppc"

DEPEND="virtual/libc
	snmp? ( >=net-analyzer/net-snmp-5.0 )"


src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-strip_and_cflags.patch
}

src_install () {
	einstall || die
	dodoc HISTORY README TODO VERSION
}
