# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/apiextractor/apiextractor-0.7.0.ebuild,v 1.1 2010/08/24 19:44:31 ayoy Exp $

EAPI="2"

inherit cmake-utils virtualx

DESCRIPTION="Library used to create an internal representation of an API in order to create Python bindings"
HOMEPAGE="http://www.pyside.org/"
SRC_URI="http://www.pyside.org/files/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-libs/boost-1.41.0[python]
	dev-libs/libxml2
	dev-libs/libxslt
	>=x11-libs/qt-core-4.5.0
	>=x11-libs/qt-xmlpatterns-4.5.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_test() {
	# bug 299766
	Xemake test -C "${CMAKE_BUILD_DIR}/tests" || die "running tests failed"
}

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS ChangeLog || die "dodoc failed"
}
