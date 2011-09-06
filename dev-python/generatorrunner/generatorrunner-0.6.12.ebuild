# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/generatorrunner/generatorrunner-0.6.12.ebuild,v 1.1 2011/09/06 12:42:16 scarabeus Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="A tool that controls bindings generation"
HOMEPAGE="http://www.pyside.org/"
SRC_URI="http://www.pyside.org/files/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug test"

RDEPEND=">=dev-python/apiextractor-0.10
	>=x11-libs/qt-core-4.7.0"
DEPEND="${DEPEND}
	test? ( >=x11-libs/qt-test-4.7.0 )
"

DOCS=( AUTHORS ChangeLog )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build test TESTS)
	)
	cmake-utils_src_configure
}
