# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qx11grab/qx11grab-0.3.2.ebuild,v 1.1 2012/02/02 11:22:27 johu Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="X11 desktop video grabber tray"
HOMEPAGE="http://qx11grab.hjcms.de/"
SRC_URI="ftp://ftp.hjcms.de/qx11grab/${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=media-libs/alsa-lib-1.0.24
	>=x11-libs/libX11-1.3.4
	>=x11-libs/qt-core-4.7.2:4
	>=x11-libs/qt-dbus-4.7.2:4
	>=x11-libs/qt-gui-4.7.2:4[dbus]
	>=virtual/ffmpeg-0.9[X,encode]
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
"

src_prepare() {
	# install docs into standard Gentoo location
	sed -i -e "s: share/\${CMAKE_PROJECT_NAME}: share/doc/${PF}:" \
		CMakeLists.txt || die
}
