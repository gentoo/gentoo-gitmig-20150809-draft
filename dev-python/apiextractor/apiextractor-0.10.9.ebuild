# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/apiextractor/apiextractor-0.10.9.ebuild,v 1.1 2011/12/27 08:33:26 patrick Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Library used to create an internal representation of an API in order to create Python bindings"
HOMEPAGE="http://www.pyside.org/"
SRC_URI="http://www.pyside.org/files/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug test"

RDEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
	>=x11-libs/qt-core-4.7.0
	>=x11-libs/qt-xmlpatterns-4.7.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? ( >=x11-libs/qt-test-4.7.0 )"

DOCS=( AUTHORS ChangeLog )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build test TESTS)
	)
	cmake-utils_src_configure
}
