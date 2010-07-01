# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/clementine/clementine-0.4.ebuild,v 1.2 2010/07/01 09:59:27 ssuominen Exp $

EAPI=2
inherit cmake-utils gnome2-utils flag-o-matic

DESCRIPTION="A modern music player and library organizer based on Amarok 1.4 and Qt4"
HOMEPAGE="http://code.google.com/p/clementine-player/"
SRC_URI="http://clementine-player.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xine"

COMMON_DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	x11-libs/qt-sql:4[sqlite]
	>=media-libs/taglib-1.6
	media-libs/liblastfm
	dev-libs/glib:2
	dev-libs/libxml2
	media-libs/glew
	>=media-libs/gstreamer-0.10
	>=media-libs/gst-plugins-base-0.10
	xine? ( media-libs/xine-lib )"
RDEPEND="${COMMON_DEPEND}
	>=media-plugins/gst-plugins-meta-0.10
	>=media-plugins/gst-plugins-gio-0.10"
DEPEND="${COMMON_DEPEND}
	>=dev-libs/boost-1.39
	dev-util/pkgconfig"

DOCS="Changelog TODO"

src_configure() {
	append-cppflags "$(pkg-config --cflags-only-I glib-2.0)" #320699

	local mycmakeargs=(
		"-DENGINE_GSTREAMER_ENABLED=ON"
		"-DENGINE_LIBVLC_ENABLED=OFF"
		$(cmake-utils_use xine ENGINE_LIBXINE_ENABLED)
		"-DENGINE_QT_PHONON_ENABLED=OFF"
		)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	elog
	elog "Install libsoup gstreamer plug-in for internet radio support."
	elog
}

pkg_postrm() {
	gnome2_icon_cache_update
}
