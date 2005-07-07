# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/kunit/kunit-0.5.ebuild,v 1.2 2005/07/07 11:40:22 george Exp $

DESCRIPTION="An excellent qt-based unit conversion tool"
SRC_URI="http://www.netmeister.org/apps/${P}.tar.gz"
HOMEPAGE="http://www.netmeister.org/apps/kunit/"

KEYWORDS="x86 ppc amd64"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/x11
	=x11-libs/qt-3*"

src_compile() {
	cd kunit
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	dobin kunit/kunit
	dodoc AUTHORS COPYING README
	dohtml kunit/docs/*
}
