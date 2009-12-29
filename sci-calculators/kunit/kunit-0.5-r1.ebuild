# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/kunit/kunit-0.5-r1.ebuild,v 1.2 2009/12/29 18:58:28 ssuominen Exp $

inherit eutils

DESCRIPTION="An excellent qt-based unit conversion tool"
HOMEPAGE="http://www.netmeister.org/apps/kunit/"
SRC_URI="http://www.netmeister.org/apps/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="=x11-libs/qt-3*"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc4.3.patch
}

src_compile() {
	cd kunit
	emake LFLAGS="${LDFLAGS}" CFLAGS="${CFLAGS}" \
			CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	dobin kunit/kunit || die
	dodoc AUTHORS README
	dohtml kunit/docs/*
	make_desktop_entry kunit KUnit kunit Utility
}
