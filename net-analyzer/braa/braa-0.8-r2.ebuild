# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/braa/braa-0.8-r2.ebuild,v 1.1 2009/01/15 03:02:18 jer Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Quick and dirty mass SNMP scanner"
HOMEPAGE="http://s-tech.elsat.net.pl/braa/"
SRC_URI="http://s-tech.elsat.net.pl/braa/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-gentoo.diff
}

src_compile() {
	export CC="$(tc-getCC)"
	emake || die
}

src_install() {
	dobin braa
	dodoc README
}
