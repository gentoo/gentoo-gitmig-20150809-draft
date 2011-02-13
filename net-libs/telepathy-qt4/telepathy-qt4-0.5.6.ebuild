# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/telepathy-qt4/telepathy-qt4-0.5.6.ebuild,v 1.1 2011/02/13 11:38:25 scarabeus Exp $

PYTHON_DEPEND="2"

EAPI=3
inherit python base cmake-utils

DESCRIPTION="Qt4 bindings for the Telepathy D-Bus protocol"
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="x11-libs/qt-core:4
	x11-libs/qt-dbus:4"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	dev-util/pkgconfig
	net-libs/telepathy-farsight"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_configure() {
	local mycmakeargs=( "-DHAVE_QDBUSVARIANT_OPERATOR_EQUAL=1" )
	cmake-utils_src_configure
}
