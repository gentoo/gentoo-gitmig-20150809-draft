# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-soup/gst-plugins-soup-0.10.14.ebuild,v 1.8 2009/06/08 08:44:02 aballier Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin for HTTP client sources"

KEYWORDS="~alpha amd64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/gstreamer-0.10.22
	>=media-libs/gst-plugins-base-0.10.22
	>=net-libs/libsoup-2.3.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
