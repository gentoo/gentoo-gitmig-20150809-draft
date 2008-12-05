# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-soup/gst-plugins-soup-0.10.11.ebuild,v 1.1 2008/12/05 21:12:09 ssuominen Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin for HTTP client sources"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/gstreamer-0.10.21
	>=media-libs/gst-plugins-base-0.10.21
	>=net-libs/libsoup-2.3.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
