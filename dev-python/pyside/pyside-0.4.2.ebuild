# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyside/pyside-0.4.2.ebuild,v 1.3 2010/12/29 10:24:07 ayoy Exp $

EAPI="2"

PYTHON_DEPEND="2:2.5"

inherit cmake-utils python

MY_P="${PN}-qt4.7+${PV}"

DESCRIPTION="Python bindings for the Qt framework"
HOMEPAGE="http://www.pyside.org/"
SRC_URI="http://www.pyside.org/files/${MY_P}.tar.bz2"
RESTRICT="test"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug kde"

QT_PV="4.6.0"

DEPEND=">=dev-libs/boost-1.41.0[python]
	>=dev-python/shiboken-${PV}
	>=x11-libs/qt-core-${QT_PV}
	>=x11-libs/qt-assistant-${QT_PV}
	>=x11-libs/qt-gui-${QT_PV}
	>=x11-libs/qt-multimedia-${QT_PV}
	>=x11-libs/qt-opengl-${QT_PV}
	kde? ( media-sound/phonon )
	!kde? (	|| ( >=x11-libs/qt-phonon-${QT_PV}
		media-sound/phonon ) )
	>=x11-libs/qt-script-${QT_PV}
	>=x11-libs/qt-sql-${QT_PV}
	>=x11-libs/qt-svg-${QT_PV}
	>=x11-libs/qt-webkit-${QT_PV}
	>=x11-libs/qt-xmlpatterns-${QT_PV}"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-find-kde-phonon.patch"
	epatch "${FILESDIR}/${PN}-cmake-namespace.patch"
}

src_install() {
	cmake-utils_src_install
	dodoc ChangeLog || die "dodoc failed"
}
