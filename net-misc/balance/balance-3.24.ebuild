# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/balance/balance-3.24.ebuild,v 1.1 2005/07/06 00:11:50 vapier Exp $

DESCRIPTION="TCP Load Balancing Port Forwarder"
HOMEPAGE="http://www.inlab.de/balance.html"
SRC_URI="http://www.inlab.de/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dosbin balance || die
	doman balance.1
	dodir /var/run/balance
	fperms 1755 /var/run/balance
}
