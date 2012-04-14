# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/generatorrunner/generatorrunner-0.6.16.ebuild,v 1.3 2012/04/14 12:45:17 ago Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="A tool to control bindings generation"
HOMEPAGE="http://www.pyside.org/"
SRC_URI="http://www.pyside.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug test"

QT_PV="4.7.0:4"

RDEPEND="
	>=dev-python/apiextractor-0.10.10
	>=x11-libs/qt-core-${QT_PV}
"
DEPEND="${RDEPEND}
	test? ( >=x11-libs/qt-test-${QT_PV} )
"

DOCS=( AUTHORS ChangeLog )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build test TESTS)
	)
	cmake-utils_src_configure
}
