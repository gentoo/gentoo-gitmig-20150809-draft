# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/phonon/phonon-4.5.0-r1.ebuild,v 1.2 2011/10/20 20:22:51 dilfridge Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="KDE multimedia API"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/phonon"
SRC_URI="mirror://kde/stable/phonon/${PV}/src/${P}.tar.bz2"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
SLOT="0"
IUSE="aqua debug +gstreamer pulseaudio vlc xine"

COMMON_DEPEND="
	>=x11-libs/qt-core-4.6.0:4
	>=x11-libs/qt-dbus-4.6.0:4
	>=x11-libs/qt-gui-4.6.0:4
	>=x11-libs/qt-test-4.6.0:4
	pulseaudio? (
		dev-libs/glib:2
		>=media-sound/pulseaudio-0.9.21[glib]
	)
	!x11-libs/qt-phonon:4
"
# directshow? ( media-sound/phonon-directshow )
# mmf? ( media-sound/phonon-mmf )
# mplayer? ( media-sound/phonon-mplayer )
# waveout? ( media-sound/phonon-waveout )
PDEPEND="
	aqua? ( media-libs/phonon-qt7 )
	gstreamer? ( media-libs/phonon-gstreamer )
	vlc? ( >=media-libs/phonon-vlc-0.3.2 )
	xine? ( >=media-libs/phonon-xine-0.4.4 )
"
RDEPEND="${COMMON_DEPEND}
	!kde-base/phonon-xine
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/automoc-0.9.87
	dev-util/pkgconfig
"

REQUIRED_USE="|| ( aqua gstreamer vlc xine )"

PATCHES=( "${FILESDIR}/${P}-pow.patch" )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with pulseaudio GLIB2)
		$(cmake-utils_use_with pulseaudio PulseAudio)
	)
	cmake-utils_src_configure
}
