# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/shiboken/shiboken-0.5.1.ebuild,v 1.1 2010/11/25 01:18:06 chiiph Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="A tool for creating Python bindings for C++ libraries"
HOMEPAGE="http://www.pyside.org/"
SRC_URI="http://www.pyside.org/files/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=dev-python/apiextractor-0.8.1
	>=dev-python/generatorrunner-0.6.1
	>=x11-libs/qt-core-4.5.0"
RDEPEND="${DEPEND}
	!dev-python/boostpythongenerator"

PATCHES=( "${FILESDIR}/${P}-fix-pkgconfig.patch" )

src_install() {
	cmake-utils_src_install
	dodoc ChangeLog || die "dodoc failed"
}
