# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/phonon-xine/phonon-xine-4.4.4.ebuild,v 1.1 2011/01/23 05:17:16 reavertm Exp $

EAPI="3"

MY_PN="phonon-backend-xine"

inherit cmake-utils

DESCRIPTION="Phonon XINE backend"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/phonon/phonon-xine"
SRC_URI="mirror://kde/stable/phonon/${MY_PN}/${PV}/src/${MY_PN}-${PV}.tar.bz2"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug +xcb"

RDEPEND="
	>=media-libs/xine-lib-1.1.15-r1[xcb?]
	>=media-sound/phonon-4.4.4
	>=x11-libs/qt-dbus-4.6.0:4
	>=x11-libs/qt-gui-4.6.0:4
	xcb? ( x11-libs/libxcb )
"
DEPEND="${RDEPEND}
	>=dev-util/automoc-0.9.87
	dev-util/pkgconfig
"

S="${WORKDIR}/${MY_PN}-${PV}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with xcb)
	)
	cmake-utils_src_configure
}
