# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/phonon-gstreamer/phonon-gstreamer-4.4.4.ebuild,v 1.2 2011/04/03 18:23:02 dilfridge Exp $

EAPI="3"

MY_PN="phonon-backend-gstreamer"

inherit cmake-utils

DESCRIPTION="Phonon GStreamer backend"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/phonon/phonon-gstreamer"
SRC_URI="mirror://kde/stable/phonon/${MY_PN}/${PV}/src/${MY_PN}-${PV}.tar.bz2"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="alsa debug"

RDEPEND="
	media-libs/gstreamer
	media-plugins/gst-plugins-meta[alsa?]
	>=media-libs/phonon-4.4.4
	>=x11-libs/qt-core-4.6.0:4[glib]
	>=x11-libs/qt-gui-4.6.0:4[glib]
	>=x11-libs/qt-opengl-4.6.0:4
	virtual/opengl
"
DEPEND="${RDEPEND}
	>=dev-util/automoc-0.9.87
	dev-util/pkgconfig
"

S="${WORKDIR}/${MY_PN}-${PV}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with alsa)
	)
	cmake-utils_src_configure
}
