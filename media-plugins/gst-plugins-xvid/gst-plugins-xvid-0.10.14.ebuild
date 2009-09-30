# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-xvid/gst-plugins-xvid-0.10.14.ebuild,v 1.2 2009/09/30 05:55:12 tester Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64 ~x86"
IUSE=""
DESCRIPTION="GStreamer plugin for XviD (MPEG-4) video encoding/decoding support"

RDEPEND="media-libs/xvid
	>=media-libs/gst-plugins-base-0.10.24
	>=media-libs/gstreamer-0.10.24"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
