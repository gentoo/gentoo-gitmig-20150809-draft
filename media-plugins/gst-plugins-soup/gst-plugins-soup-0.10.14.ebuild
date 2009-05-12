# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-soup/gst-plugins-soup-0.10.14.ebuild,v 1.2 2009/05/12 20:51:29 fauli Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin for HTTP client sources"

KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND=">=media-libs/gstreamer-0.10.22
	>=media-libs/gst-plugins-base-0.10.22
	>=net-libs/libsoup-2.3.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
