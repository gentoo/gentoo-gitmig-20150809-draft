# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Adam Tenderholt <a-tenderholt@northwestern.edu>
# $Header: /var/cvsroot/gentoo-x86/app-sci/xdrawchem/xdrawchem-1.3.2.ebuild,v 1.1 2002/06/10 00:55:49 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XDrawChem--a molecular structure drawing program."
SRC_URI="http://www.prism.gatech.edu/~gte067k/xdrawchem/xdrawchem-${PV}.tgz"
HOMEPAGE="http://www.prism.gatech.edu/~gte067k/xdrawchem"
DEPEND="qt? ( >=qt-3.0.0 )"

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

