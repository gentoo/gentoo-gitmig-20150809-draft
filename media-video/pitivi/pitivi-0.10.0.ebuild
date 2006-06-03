# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/pitivi/pitivi-0.10.0.ebuild,v 1.2 2006/06/03 01:45:48 hanno Exp $

DESCRIPTION="A non-linear video editor using the GStreamer multimedia framework"
HOMEPAGE="http://www.pitivi.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-libs/gstreamer-0.10.0
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

src_compile() {
	addpredict "/root/.gconf"
	addpredict "/root/.gconfd"
	addpredict "/root/.gstreamer-0.10"
	econf || die
	emake || die
}

src_install() {
	einstall || die
	domenu pitivi.desktop
	dodoc AUTHORS ChangeLog NEWS RELEASE
}
