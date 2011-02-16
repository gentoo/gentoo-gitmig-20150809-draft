# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/drumstick/drumstick-0.5.0.ebuild,v 1.4 2011/02/16 22:26:40 hwoarang Exp $

EAPI=2
inherit cmake-utils fdo-mime gnome2-utils

DESCRIPTION="Qt4/C++ wrapper for ALSA sequencer"
HOMEPAGE="http://drumstick.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="dbus"

RDEPEND="media-libs/alsa-lib
	x11-libs/qt-gui:4
	x11-libs/qt-svg:4
	dbus? ( x11-libs/qt-dbus:4 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_prepare() {
	sed -i \
		-e '/CMAKE_EXE_LINKER_FLAGS/d' \
		CMakeLists.txt || die
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_use dbus)
		)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
