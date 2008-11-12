# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-soup/gst-plugins-soup-0.10.8.ebuild,v 1.1 2008/11/12 12:22:43 leio Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin for HTTP client sources"

KEYWORDS="~amd64"
IUSE=""

DEPEND=">=net-libs/libsoup-2.3.2
	>=media-libs/gstreamer-0.10.18
	>=media-libs/gst-plugins-base-0.10.18"
