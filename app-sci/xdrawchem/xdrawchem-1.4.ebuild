# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/xdrawchem/xdrawchem-1.4.ebuild,v 1.5 2002/10/04 05:01:42 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XDrawChem--a molecular structure drawing program."
SRC_URI="http://www.prism.gatech.edu/~gte067k/xdrawchem/xdrawchem-${PV}.tgz"
HOMEPAGE="http://www.prism.gatech.edu/~gte067k/xdrawchem/"
KEYWORDS="x86"
SLOT="0"
DEPEND="qt? ( >=qt-3.0.0 )"
LICENSE="GPL-2"

src_compile() {
	emake INSTRING=/usr/share/ringinfo || die
}

src_install () {
	dodir /usr/bin
	dobin xdrawchem

	dodir /usr/share/ringinfo
	insinto /usr/share/ringinfo
	doins ring/*
}

