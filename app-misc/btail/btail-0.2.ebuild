# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/btail/btail-0.2.ebuild,v 1.1 2005/01/02 17:11:15 stuart Exp $

inherit eutils

DESCRIPTION="Bayesian logfile filter"
HOMEPAGE="http://www.vanheusden.com/btail/"
SRC_URI="${HOMEPAGE}/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
#RESTRICT="nostrip"

DEPEND=""
#RDEPEND=""

src_compile() {
	make || die "make failed"
}

src_install() {
	dobin blearn || die
	dobin btail || die

	dodoc readme.txt || die
	dodoc btail.conf || die
	dodoc license.txt || die
}
