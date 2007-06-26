# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xxdiff/xxdiff-3.2.ebuild,v 1.8 2007/06/26 02:05:52 mr_bones_ Exp $

inherit distutils eutils kde-functions

DESCRIPTION="A graphical file and directories comparator and merge tool."
HOMEPAGE="http://xxdiff.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ppc sparc x86"
IUSE="kde python"

DEPEND="=x11-libs/qt-3*
	kde? ( >=kde-base/kdelibs-3.1 )
	sys-devel/flex
	|| ( sys-devel/bison dev-util/yacc )"
RDEPEND="${DEPEND}
	sys-apps/diffutils"

set-kdedir 3

src_unpack() {
	unpack ${A}

	if use kde; then
		cd "${S}/src"
		epatch "${FILESDIR}/${P}-kdesupport.patch"
		sed -i "s:/usr/include/kde:${KDEDIR}/include:g" xxdiff.pro
		sed -i "s:QMAKE_LIBS +=:QMAKE_LIBS+= -L${KDEDIR}/lib:g" xxdiff.pro
	fi
}

src_compile() {
	if use python; then
		distutils_src_compile
	fi

	cd src
	make -f Makefile.bootstrap makefile || die "Makefile creation failed"
	emake || die
	cd ../doc
	emake || die "Doc failed"

}

src_install () {
	if use python; then
		distutils_src_install
	fi

	dobin bin/xxdiff bin/xx-cvs-diff bin/xx-encrypted bin/xx-find-grep-sed bin/xx-match
	doman src/xxdiff.1
	dodoc README CHANGES TODO
	cd doc
	dodoc xxdiff-doc.html
}
