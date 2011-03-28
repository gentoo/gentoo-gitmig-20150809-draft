# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/phonon-vlc/phonon-vlc-9999.ebuild,v 1.1 2011/03/28 22:57:42 dilfridge Exp $

EAPI="3"

inherit cmake-utils git

DESCRIPTION="Phonon VLC backend"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/phonon/phonon-vlc"
EGIT_REPO_URI="git://anongit.kde.org/${PN}"

LICENSE="LGPL-2.1"
KEYWORDS=""
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
