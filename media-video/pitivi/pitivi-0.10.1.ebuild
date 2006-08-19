# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/pitivi/pitivi-0.10.1.ebuild,v 1.2 2006/08/19 15:27:02 hanno Exp $

inherit gnome2

DESCRIPTION="A non-linear video editor using the GStreamer multimedia framework"
HOMEPAGE="http://www.pitivi.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-libs/gstreamer-0.10.4
	>=dev-lang/python-2.3.0
	>=dev-python/pygtk-2.8.0
	>=dev-python/gnome-python-2.12.0
	>=dev-python/gst-python-0.10.0
	>=media-libs/gnonlin-0.10.4"
RDEPEND="${DEPEND}
	>=media-libs/gst-plugins-base-0.10.0
	>=media-libs/gst-plugins-good-0.10.0
	>=media-plugins/gst-plugins-ffmpeg-0.10.0
	>=media-plugins/gst-plugins-xvideo-0.10.0
	>=media-plugins/gst-plugins-libpng-0.10.0"

DOCS="AUTHORS ChangeLog NEWS RELEASE"

src_compile() {
	addpredict $(unset HOME; echo ~)/{.gconf,.gconfd,.gstreamer-0.10}
	gnome2_src_compile
}
