# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/balance/balance-3.11.ebuild,v 1.2 2004/06/24 23:35:58 agriffis Exp $

DESCRIPTION="TCP Load Balancing Port Forwarder"
HOMEPAGE="http://www.inlab.de/balance.html"
SRC_URI="mirror://sourceforge/balance/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	doman balance.1
	dosbin balance
	dodir /var/run/balance
	fperms 1777 /var/run/balance
}
