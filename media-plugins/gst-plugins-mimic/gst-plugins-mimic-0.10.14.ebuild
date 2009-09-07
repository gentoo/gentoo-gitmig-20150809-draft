# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mimic/gst-plugins-mimic-0.10.14.ebuild,v 1.1 2009/09/07 05:25:04 tester Exp $

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for the MIMIC codec"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/gstreamer-0.10.24
	>=media-libs/gst-plugins-base-0.10.24
	>=media-libs/libmimic-1.0.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
