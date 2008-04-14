# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-speex/gst-plugins-speex-0.10.7-r1.ebuild,v 1.2 2008/04/14 18:36:49 corsair Exp $

inherit eutils gst-plugins-good

KEYWORDS="~amd64 ~ppc ppc64 ~sparc ~x86"
DESCRIPTION="GStreamer plugin to allow encoding and decoding of speex"
IUSE=""

RDEPEND=">=media-libs/speex-1.1.6
	>=media-libs/gstreamer-0.10.17
	>=media-libs/gst-plugins-base-0.10.17"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

src_unpack() {
	gst-plugins-good_src_unpack
	epatch "${FILESDIR}"/${P}-sec.patch
}
