# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyside/pyside-1.1.0.ebuild,v 1.2 2012/01/17 19:45:33 hwoarang Exp $

EAPI=4

PYTHON_DEPEND="2:2.5"

inherit base python cmake-utils virtualx

MY_P="${PN}-qt4.7+${PV}"

DESCRIPTION="Python bindings for the Qt framework"
HOMEPAGE="http://www.pyside.org/"
SRC_URI="http://www.pyside.org/files/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="assistant debug declarative multimedia kde opengl phonon script sql svg test webkit
X xmlpatterns"

QT_PV="4.7.0"

RDEPEND=">=x11-libs/qt-core-${QT_PV}
	assistant? ( >=x11-libs/qt-assistant-${QT_PV} )
	X? ( >=x11-libs/qt-gui-${QT_PV}[accessibility] )
	multimedia? ( >=x11-libs/qt-multimedia-${QT_PV} )
	opengl? ( >=x11-libs/qt-opengl-${QT_PV} )
	phonon? (
		kde? ( media-libs/phonon )
		!kde? (
		|| (
			>=x11-libs/qt-phonon-${QT_PV}
			media-libs/phonon
			)
		)
	)
	script? ( >=x11-libs/qt-script-${QT_PV} )
	sql? ( >=x11-libs/qt-sql-${QT_PV} )
	svg? ( >=x11-libs/qt-svg-${QT_PV}[accessibility] )
	webkit? ( >=x11-libs/qt-webkit-${QT_PV} )
	xmlpatterns? ( >=x11-libs/qt-xmlpatterns-${QT_PV} )"

DEPEND="${RDEPEND}
	>=dev-python/shiboken-1.0.10
	test? ( >=x11-libs/qt-test-${QT_PV} )"

S="${WORKDIR}/${MY_P}"

DOCS=( "ChangeLog" )

REQUIRED_USE="opengl? ( X ) svg? ( X ) script? ( X ) X? ( script )"

cmake-utils_use_build() {
	use ${1} || echo "-DDISABLE_${2:-$1}=1"
}

pkg_setup() {
	python_set_active_version 2
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build test TESTS)
		$(cmake-utils_use_build X QtGui)
		$(cmake-utils_use_build X QtDesigner)
		$(cmake-utils_use_build X QtScriptTools)
		$(cmake-utils_use_build multimedia QtMultimedia)
		$(cmake-utils_use_build declarative QtDeclarative)
		$(cmake-utils_use_build opengl QtOpenGL)
		$(cmake-utils_use_build phonon QtPhonon)
		$(cmake-utils_use_build script QtScript)
		$(cmake-utils_use_build sql QtSql)
		$(cmake-utils_use_build svg QtSvg)
		$(cmake-utils_use_build test QtTest)
		$(cmake-utils_use_build webkit QtWebKit)
		$(cmake-utils_use_build xmlpatterns QtXmlPatterns)
		$(cmake-utils_use_build assistant QtHelp)
	)
	cmake-utils_src_configure
}

src_test() {
	VIRTUALX_COMMAND="cmake-utils_src_test"
	virtualmake
}
