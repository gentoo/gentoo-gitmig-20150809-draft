# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/xdrawchem/xdrawchem-1.4.2.ebuild,v 1.7 2003/08/05 18:41:03 vapier Exp $

DESCRIPTION="a molecular structure drawing program"
HOMEPAGE="http://www.prism.gatech.edu/~gte067k/xdrawchem/"
SRC_URI="http://www.prism.gatech.edu/~gte067k/xdrawchem/xdrawchem-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="qt"

DEPEND="qt? ( >=x11-libs/qt-3.0.0 )"

src_compile() {
	emake INSTRING=/usr/share/${P} || die
}

src_install() {
	dodir /usr/bin
	dobin xdrawchem

	dodir /usr/share/${P}
	insinto /usr/share/${P}
	doins ring/*

	dodoc README.txt TODO.txt COPYRIGHT.txt HISTORY.txt
}
