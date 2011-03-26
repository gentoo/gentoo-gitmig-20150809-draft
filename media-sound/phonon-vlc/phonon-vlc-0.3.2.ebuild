# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/phonon-vlc/phonon-vlc-0.3.2.ebuild,v 1.2 2011/03/26 16:30:12 dilfridge Exp $

EAPI="3"

MY_PN="phonon-backend-vlc"

inherit cmake-utils

DESCRIPTION="Phonon VLC backend"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/phonon/phonon-vlc"
SRC_URI="mirror://kde/stable/phonon/${MY_PN}/${PV}/src/${MY_PN}-${PV}.tar.bz2"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug v4l2"

RDEPEND="
	>=media-libs/phonon-4.4.4
	>=media-video/vlc-1.1.1[dbus]
	>=x11-libs/qt-dbus-4.6.0:4
	>=x11-libs/qt-gui-4.6.0:4
	v4l2? ( media-libs/libv4l )
"
DEPEND="${RDEPEND}
	>=dev-util/automoc-0.9.87
	dev-util/pkgconfig
"

S="${WORKDIR}/${MY_PN}-${PV}"

DOCS=(AUTHORS)

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with v4l2)
	)
	cmake-utils_src_configure
}

pkg_postinst() {
	elog "For more verbose debug information, export the following variables:"
	use v4l2 && elog "PHONON_VLC_DEBUG=3"
	elog "PHONON_DEBUG=1"
	elog ""
	elog "To make KDE detect the new backend without reboot, run:"
	elog "kbuildsycoca4 --noincremental"
}
