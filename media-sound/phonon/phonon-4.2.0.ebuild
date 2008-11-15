# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/phonon/phonon-4.2.0.ebuild,v 1.4 2008/11/15 21:58:01 vapier Exp $

EAPI="2"
inherit cmake-utils

DESCRIPTION="KDE multimedia API"
HOMEPAGE="http://phonon.kde.org/"
SRC_URI="mirror://kde/stable/${PN}/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug gstreamer"
RESTRICT="test"

RDEPEND="!kde-base/phonon:kde-svn
	!kde-base/phonon:kde-4
	!x11-libs/qt-phonon:4
	x11-libs/qt-core:4
	x11-libs/qt-dbus:4
	x11-libs/qt-gui:4
	x11-libs/qt-test:4
	gstreamer? ( >=media-libs/gstreamer-0.10.20
		>=media-libs/gst-plugins-base-0.10.20
		x11-libs/qt-opengl:4 )"
DEPEND="${RDEPEND}
	kde-base/automoc"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with gstreamer GStreamer)
		$(cmake-utils_use_with gstreamer GStreamerPlugins)"
	cmake-utils_src_compile
}
