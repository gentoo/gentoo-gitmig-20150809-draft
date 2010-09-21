# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/clementine/clementine-0.4.2.ebuild,v 1.3 2010/09/21 19:08:41 hwoarang Exp $

EAPI=2
inherit cmake-utils gnome2-utils flag-o-matic

DESCRIPTION="A modern music player and library organizer based on Amarok 1.4 and Qt4"
HOMEPAGE="http://code.google.com/p/clementine-player/"
SRC_URI="http://clementine-player.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="gstreamer projectm +xine"

COMMON_DEPEND="dev-libs/glib:2
	dev-libs/libxml2
	media-libs/liblastfm
	>=media-libs/taglib-1.6
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	x11-libs/qt-sql:4[sqlite]
	x11-libs/qt-test:4
	gstreamer? ( >=media-libs/gstreamer-0.10
		>=media-libs/gst-plugins-base-0.10
		projectm? ( media-libs/glew ) )
	xine? ( media-libs/xine-lib )
	!gstreamer? ( media-libs/xine-lib )"
RDEPEND="${COMMON_DEPEND}
	gstreamer? ( >=media-plugins/gst-plugins-meta-0.10 )"
DEPEND="${COMMON_DEPEND}
	>=dev-libs/boost-1.39
	dev-util/pkgconfig"

DOCS="Changelog TODO"

MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	echo "" > pig.txt
}

src_configure() {
	append-cppflags "$(pkg-config --cflags-only-I glib-2.0)" #320699

	mycmakeargs=(
		"-DENABLE_VISUALISATIONS=OFF"
		$(cmake-utils_use gstreamer ENGINE_GSTREAMER_ENABLED)
		"-DENGINE_LIBVLC_ENABLED=OFF"
		$(cmake-utils_use xine ENGINE_LIBXINE_ENABLED)
		"-DENGINE_QT_PHONON_ENABLED=OFF"
		)

	if ! use gstreamer; then
		mycmakeargs+=(
			"-DENGINE_LIBXINE_ENABLED=ON"
			)
	else
		mycmakeargs+=(
			$(cmake-utils_use_enable projectm VISUALISATIONS)
			)
	fi

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	if use gstreamer; then
		ewarn
		ewarn "If media-plugins/gst-plugins-meta doesn't pull in the plugins you"
		ewarn "need, you have to install them yourself."
		ewarn
	fi
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
