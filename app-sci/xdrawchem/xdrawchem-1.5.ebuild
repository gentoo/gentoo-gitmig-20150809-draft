# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/xdrawchem/xdrawchem-1.5.ebuild,v 1.6 2003/08/05 18:41:03 vapier Exp $

DESCRIPTION="a molecular structure drawing program"
HOMEPAGE="http://www.prism.gatech.edu/~gte067k/${PN}"
SRC_URI="http://www.prism.gatech.edu/~gte067k/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE="qt"

DEPEND="qt? ( >=x11-libs/qt-3.0.0 )"
#the app requires babel at run time to be able to perform various file type conversions
RDEPEND="${DEPEND}
	app-sci/babel"

src_compile() {
	emake -f Makefile.orig INSTRING=/usr/share/${P} || die
}

src_install() {
	dodir /usr/bin
	dobin xdrawchem

	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins ring/*

	dodoc README.txt TODO.txt COPYRIGHT.txt HISTORY.txt
}
