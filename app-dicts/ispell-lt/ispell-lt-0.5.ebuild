# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-lt/ispell-lt-0.5.ebuild,v 1.11 2004/06/24 21:43:16 agriffis Exp $

DESCRIPTION="Lithuanian dictionary for ispell"
HOMEPAGE="http://ieva.mif.vu.lt/~alga/lt/ispell/"
SRC_URI="http://ieva.mif.vu.lt/~alga/lt/ispell/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa"
IUSE=""

DEPEND="app-text/ispell
	dev-lang/python"

src_compile() {
	emake || die
}

src_install() {
	insinto /usr/lib/ispell
	doins lietuviu.hash lietuviu.aff
	dodoc README THANKS ChangeLog
}
