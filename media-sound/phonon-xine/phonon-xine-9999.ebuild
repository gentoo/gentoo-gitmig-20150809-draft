# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/phonon-xine/phonon-xine-9999.ebuild,v 1.1 2011/01/23 05:17:16 reavertm Exp $

EAPI="3"

inherit cmake-utils git

DESCRIPTION="Phonon XINE backend"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/phonon/phonon-xine"
EGIT_REPO_URI="git://anongit.kde.org/${PN}"

LICENSE="LGPL-2.1"
KEYWORDS=""
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

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with xcb)
	)
	cmake-utils_src_configure
}
