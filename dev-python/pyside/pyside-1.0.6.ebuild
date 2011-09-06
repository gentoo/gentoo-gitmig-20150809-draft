# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyside/pyside-1.0.6.ebuild,v 1.1 2011/09/06 12:42:17 scarabeus Exp $

EAPI=3

PYTHON_DEPEND="2:2.5"

inherit base python cmake-utils virtualx

MY_P="${PN}-qt4.7+${PV}"

DESCRIPTION="Python bindings for the Qt framework"
HOMEPAGE="http://www.pyside.org/"
SRC_URI="http://www.pyside.org/files/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug kde test"

QT_PV="4.7.0"

RDEPEND=">=dev-python/shiboken-${PV}
	>=x11-libs/qt-core-${QT_PV}
	>=x11-libs/qt-assistant-${QT_PV}
	>=x11-libs/qt-gui-${QT_PV}
	>=x11-libs/qt-multimedia-${QT_PV}
	>=x11-libs/qt-opengl-${QT_PV}
	kde? ( media-libs/phonon )
	!kde? (
		|| (
			>=x11-libs/qt-phonon-${QT_PV}
			media-libs/phonon
		)
	)
	>=x11-libs/qt-script-${QT_PV}
	>=x11-libs/qt-sql-${QT_PV}
	>=x11-libs/qt-svg-${QT_PV}
	>=x11-libs/qt-test-${QT_PV}
	>=x11-libs/qt-webkit-${QT_PV}
	>=x11-libs/qt-xmlpatterns-${QT_PV}"
DEPEND="${DEPEND}
	test? ( >=x11-libs/qt-test-${QT_PV} )"

S="${WORKDIR}/${MY_P}.1"

DOCS=( "ChangeLog" )

PATCHES=(
	"${FILESDIR}/${PN}-find-kde-phonon.patch"
)

pkg_setup() {
	python_set_active_version 2
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build test TESTS)
	)
	cmake-utils_src_configure
}

src_test() {
	VIRTUALX_COMMAND="cmake-utils_src_test"
	virtualmake
}
