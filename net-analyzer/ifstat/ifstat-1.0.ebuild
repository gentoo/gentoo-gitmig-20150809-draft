# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ifstat/ifstat-1.0.ebuild,v 1.2 2003/11/11 20:13:48 gmsoft Exp $

DESCRIPTION="Network interface bandwidth usage, with support for snmp targets."
SRC_URI="http://gael.roualland.free.fr/ifstat/${P}.tar.gz"
HOMEPAGE="http://gael.roualland.free.fr/ifstat/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc hppa"

DEPEND="virtual/glibc
	snmp? ( >=net-analyzer/net-snmp-5.0 )"

src_compile() {
	econf || die
	make || die
}

src_install () {
	einstall || die
	dodoc COPYING HISTORY INSTALL README TODO VERSION
}
