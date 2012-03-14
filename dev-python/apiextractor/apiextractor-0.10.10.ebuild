# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/apiextractor/apiextractor-0.10.10.ebuild,v 1.3 2012/03/14 13:50:41 pesa Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Library used to create an internal representation of an API in order to create Python bindings"
HOMEPAGE="http://www.pyside.org/"
SRC_URI="http://www.pyside.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug test"

QT_PV="4.7.0:4"

RDEPEND="
	>=dev-libs/libxml2-2.6.32
	>=dev-libs/libxslt-1.1.19
	>=x11-libs/qt-core-${QT_PV}
	>=x11-libs/qt-xmlpatterns-${QT_PV}
"
DEPEND="${RDEPEND}
	test? (
		>=x11-libs/qt-gui-${QT_PV}
		>=x11-libs/qt-test-${QT_PV}
	)"

DOCS=( AUTHORS ChangeLog )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build test TESTS)
	)
	cmake-utils_src_configure
}
