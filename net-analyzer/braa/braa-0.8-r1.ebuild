# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/braa/braa-0.8-r1.ebuild,v 1.3 2006/04/26 03:09:13 weeve Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Quick and dirty mass SNMP scanner"
HOMEPAGE="http://s-tech.elsat.net.pl/braa/"
SRC_URI="http://s-tech.elsat.net.pl/braa/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc x86"
IUSE=""

DEPEND="virtual/libc"

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
