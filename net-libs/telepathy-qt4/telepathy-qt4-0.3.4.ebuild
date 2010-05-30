# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/telepathy-qt4/telepathy-qt4-0.3.4.ebuild,v 1.1 2010/05/30 10:05:10 hwoarang Exp $

PYTHON_DEPEND="2"

EAPI="2"
inherit versionator python base

DESCRIPTION="Qt4 bindings for the Telepathy D-Bus protocol"
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug static"

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
	econf $(use_enable debug) $(use_enable static)
}

src_test() {
	dbus-launch emake -j1 check || die "emake check failed"
}

src_install() {
	base_src_install
	! use static && rm "${D}"/usr/$(get_libdir)/lib${PN}.la
}
