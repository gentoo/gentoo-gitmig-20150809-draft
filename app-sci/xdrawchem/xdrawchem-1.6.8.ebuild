# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/xdrawchem/xdrawchem-1.6.8.ebuild,v 1.1 2003/04/25 08:57:40 george Exp $

IUSE="qt"

S=${WORKDIR}/${P}
DESCRIPTION="XDrawChem--a molecular structure drawing program."
SRC_URI="http://www.prism.gatech.edu/~gte067k/${PN}/${P}.tgz"
HOMEPAGE="http://www.prism.gatech.edu/~gte067k/${PN}"

KEYWORDS="~x86 ~ppc ~sparc "
SLOT="0"
LICENSE="GPL-2"

DEPEND="qt? ( >=qt-3.1.0 )"

src_compile() {
	./configure --prefix=/usr || die
	emake -f Makefile INSTRING=/usr/share/xdrawchem || die
}

src_install () {
	dodir /usr/bin
	dobin xdrawchem/xdrawchem

	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins ring/*

	dodoc README.txt TODO.txt COPYRIGHT.txt HISTORY.txt
	dohtml doc/*
}

