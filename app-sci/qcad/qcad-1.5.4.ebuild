# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/qcad/qcad-1.5.4.ebuild,v 1.5 2003/05/28 17:38:23 caleb Exp $
inherit kde-functions

MY_P=${P}-src
S=${WORKDIR}/$P
DESCRIPTION="A 2D CAD package based upon Qt."
SRC_URI="mirror://sourceforge/qcad//${MY_P}.tar.gz"
HOMEPAGE="http://www.qcad.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND=">=x11-libs/qt-3"

set-qtdir 3

src_compile() {
	cd ${S}
    	emake CXXFLAGS="$CXXFLAGS" || die
}

src_install () {
	dobin qcad

	dohtml -r doc

	dodoc AUTHORS COPYING INSTALL MANIFEST README TODO changes-*
	docinto examples
	dodoc examples/*

	dodir /usr/share/${PN}
	cp -a fonts hatches libraries messages templates ${D}/usr/share/${PN}

	insinto /usr/share/${PN}/pixmaps
	doins xpm/*
}

pkg_postinst()
{
	ewarn "The QCad fonts have been installed to /usr/share/${PN}/fonts"
	ewarn "You will need to copy them to ~/.qcad/fonts/ in order for QCad"
	ewarn "to properly find the fonts."
}
