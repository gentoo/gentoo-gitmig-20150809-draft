# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-jpeg/gst-plugins-jpeg-0.10.16.ebuild,v 1.10 2011/02/26 18:51:42 signals Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer encoder/decoder for JPEG format"
KEYWORDS="alpha amd64 ~arm hppa ppc ppc64 sparc x86"
IUSE=""

RDEPEND="virtual/jpeg
	>=media-libs/gstreamer-0.10.24
	>=media-libs/gst-plugins-base-0.10.24"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
