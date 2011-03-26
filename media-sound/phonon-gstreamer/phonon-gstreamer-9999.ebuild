# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/phonon-gstreamer/phonon-gstreamer-9999.ebuild,v 1.2 2011/03/26 16:20:42 dilfridge Exp $

EAPI="3"

inherit cmake-utils git

DESCRIPTION="Phonon GStreamer backend"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/phonon/phonon-gstreamer"
EGIT_REPO_URI="git://anongit.kde.org/${PN}"

LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="0"
IUSE="alsa debug"

RDEPEND="
	media-libs/gstreamer
	media-plugins/gst-plugins-meta[alsa?]
	>=media-libs/phonon-4.4.4
	>=x11-libs/qt-gui-4.6.0:4
	>=x11-libs/qt-opengl-4.6.0:4
	virtual/opengl
"
DEPEND="${RDEPEND}
	>=dev-util/automoc-0.9.87
	dev-util/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with alsa)
	)
	cmake-utils_src_configure
}
