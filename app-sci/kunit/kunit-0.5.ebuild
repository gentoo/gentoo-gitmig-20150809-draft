# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/kunit/kunit-0.5.ebuild,v 1.3 2003/02/15 07:11:33 gerk Exp $

DESCRIPTION="An excellent qt-based unit conversion tool"
SRC_URI="http://www.netmeister.org/apps/${P}.tar.gz"
HOMEPAGE="http://www.netmeister.org/apps/kunit/"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/x11
	>=x11-libs/qt-2.2.0"

src_compile() {
	cd kunit
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	dobin kunit/kunit
	dodoc AUTHORS COPYING README
	dohtml kunit/docs/*
}
