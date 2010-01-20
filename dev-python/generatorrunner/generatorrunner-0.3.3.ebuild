# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/generatorrunner/generatorrunner-0.3.3.ebuild,v 1.1 2010/01/20 23:40:41 ayoy Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="A tool that controls bindings generation"
HOMEPAGE="http://www.pyside.org/"
SRC_URI="http://www.pyside.org/files/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~dev-python/apiextractor-${PV}
	>=x11-libs/qt-core-4.5.0"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e 's:cmake-${CMAKE_MAJOR_VERSION}\.${CMAKE_MINOR_VERSION}:cmake:' \
	    -i CMakeLists.txt || die "sed failed"
}

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS ChangeLog || die "dodoc failed"
}
