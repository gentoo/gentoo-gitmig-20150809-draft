# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/xdrawchem/xdrawchem-1.5.ebuild,v 1.1 2002/11/02 01:02:47 george Exp $

IUSE="qt"

S=${WORKDIR}/${P}
DESCRIPTION="XDrawChem--a molecular structure drawing program."
SRC_URI="http://www.prism.gatech.edu/~gte067k/${PN}/${P}.tgz"
HOMEPAGE="http://www.prism.gatech.edu/~gte067k/${PN}"

KEYWORDS="~x86 ~ppc ~sparc ~sparc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="qt? ( >=qt-3.0.0 )"

src_compile() {
	emake -f Makefile.orig INSTRING=/usr/share/${P} || die
}

src_install () {
	dodir /usr/bin
	dobin xdrawchem

	dodir /usr/share/${P}
	insinto /usr/share/${P}
	doins ring/*

	dodoc README.txt TODO.txt COPYRIGHT.txt HISTORY.txt
}

