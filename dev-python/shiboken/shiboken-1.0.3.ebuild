# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/shiboken/shiboken-1.0.3.ebuild,v 1.2 2011/07/28 22:33:11 patrick Exp $

EAPI="2"

PYTHON_DEPEND="2:2.5"

inherit cmake-utils python versionator

MY_PV=$(replace_version_separator '_' '~')
MY_P=${PN}-${MY_PV}

DESCRIPTION="A tool for creating Python bindings for C++ libraries"
HOMEPAGE="http://www.pyside.org/"
SRC_URI="http://www.pyside.org/files/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=dev-python/apiextractor-0.10.3
	>=dev-python/generatorrunner-0.6.10
	>=x11-libs/qt-core-4.5.0"
RDEPEND="${DEPEND}
	!dev-python/boostpythongenerator"

PATCHES=( "${FILESDIR}/${P}-fix-pkgconfig.patch" )

S=${WORKDIR}/${MY_P}

pkg_setup() {
	python_set_active_version 2
}

src_install() {
	cmake-utils_src_install
	dodoc ChangeLog || die "dodoc failed"
}
