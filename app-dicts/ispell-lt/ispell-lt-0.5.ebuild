# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-lt/ispell-lt-0.5.ebuild,v 1.6 2003/03/08 01:07:44 vladimir Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Lithuanian dictionary for ispell."
HOMEPAGE="http://ieva.mif.vu.lt/~alga/lt/ispell/"
SRC_URI="http://ieva.mif.vu.lt/~alga/lt/ispell/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="ppc x86 sparc alpha mips hppa arm"

DEPEND="app-text/ispell
	dev-lang/python"

src_compile() {
	make || die
}

src_install () {
	insinto /usr/lib/ispell
	doins lietuviu.hash lietuviu.aff
	dodoc README COPYING THANKS ChangeLog
}
