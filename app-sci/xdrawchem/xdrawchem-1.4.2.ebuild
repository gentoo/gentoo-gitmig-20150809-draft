# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/xdrawchem/xdrawchem-1.4.2.ebuild,v 1.1 2002/08/07 10:23:01 george Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XDrawChem--a molecular structure drawing program."
SRC_URI="http://www.prism.gatech.edu/~gte067k/xdrawchem/xdrawchem-${PV}.tgz"
HOMEPAGE="http://www.prism.gatech.edu/~gte067k/xdrawchem"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="qt? ( >=qt-3.0.0 )"
RDEPEND="${DEPEND}"

src_compile() {
	emake INSTRING=/usr/share/${P} || die
}

src_install () {
	dodir /usr/bin
	dobin xdrawchem

	dodir /usr/share/${P}
	insinto /usr/share/${P}
	doins ring/*

	dodoc README.txt TODO.txt COPYRIGHT.txt HISTORY.txt
}

