# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-lt/ispell-lt-0.5.ebuild,v 1.2 2002/12/09 04:17:38 manson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Lithuanian dictionary for ispell."
HOMEPAGE="http://ieva.mif.vu.lt/~alga/lt/ispell/"
SRC_URI="http://ieva.mif.vu.lt/~alga/lt/ispell/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc  alpha"

DEPEND="app-text/ispell
	dev-lang/python"

src_compile() {
	make || die
}

src_install () {
	insinto /usr/lib/ispell
	doins lietuviu.hash lietuviu.aff
#	exeinto /usr/lib/ispell-lt
#	doexe sortkoi8 trans
	dodoc README COPYING THANKS ChangeLog
}
