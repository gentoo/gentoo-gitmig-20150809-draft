# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qx11grab/qx11grab-0.4.1-r2.ebuild,v 1.2 2012/04/20 13:41:29 chainsaw Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="X11 desktop video grabber tray"
HOMEPAGE="http://qx11grab.hjcms.de/"
SRC_URI="http://qx11grab.hjcms.de/downloads/${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="opengl pulseaudio"

RDEPEND="
	>=media-libs/alsa-lib-1.0.24
	>=media-libs/fontconfig-2.4
	>=media-libs/freetype-2.4:2
	>=sys-apps/dbus-1.4.16
	>=x11-libs/libX11-1.3.4
	>=x11-libs/libXrandr-1.3
	>=x11-libs/qt-core-4.7.2:4
	>=x11-libs/qt-dbus-4.7.2:4
	>=x11-libs/qt-gui-4.7.2:4[dbus]
	>=virtual/ffmpeg-0.9[X,encode]
	opengl? ( >=x11-libs/qt-opengl-4.7.2:4 )
	pulseaudio? ( >=media-sound/pulseaudio-1.1 )
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
"
PDEPEND="virtual/freedesktop-icon-theme"

PATCHES=(
	"${FILESDIR}/${PV}-detect-avconv-presets-dir.patch"
	"${FILESDIR}/${PV}-fix-install-destination.patch"
	"${FILESDIR}/${PV}-fix-typos-in-CMakeLists.patch"
	"${FILESDIR}/${PV}-optional-pulseaudio.patch"
)

src_prepare() {
	base_src_prepare

	# install docs into standard Gentoo location
	sed -i -e "s: share/\${CMAKE_PROJECT_NAME}: share/doc/${PF}:" \
		CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable opengl)
		$(cmake-utils_use_enable pulseaudio PULSE)
	)
	cmake-utils_src_configure
}
