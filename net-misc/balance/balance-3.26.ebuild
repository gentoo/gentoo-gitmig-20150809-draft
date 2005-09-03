# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/balance/balance-3.26.ebuild,v 1.1 2005/09/03 08:52:01 dragonheart Exp $

inherit toolchain-funcs

DESCRIPTION="TCP Load Balancing Port Forwarder"
HOMEPAGE="http://www.inlab.de/balance.html"
SRC_URI="http://www.inlab.de/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="doc"

DEPEND="doc? ( app-text/ghostscript )"
RDEPEND=""

src_compile() {
	use doc || touch balance.pdf
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die
}

src_install() {
	dosbin balance || die
	doman balance.1
	use doc && dodoc balance.pdf
	dodir /var/run/balance
	fperms 1755 /var/run/balance
}
