# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-lt/ispell-lt-1.1.ebuild,v 1.1 2005/02/06 11:48:12 arj Exp $

DESCRIPTION="Lithuanian dictionary for ispell"
HOMEPAGE="http://files.akl.lt/ispell-lt/"
SRC_URI="http://files.akl.lt/ispell-lt/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64"
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
