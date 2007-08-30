# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dv/gst-plugins-dv-0.10.6.ebuild,v 1.1 2007/08/30 20:11:49 drac Exp $

inherit gst-plugins-good

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

GST_PLUGINS_BUILD="libdv"
DESCRIPTION="GStreamer plugin to decode DV"

IUSE=""
RDEPEND=">=media-libs/libdv-0.100
	>=media-libs/gstreamer-0.10.13
	>=media-libs/gst-plugins-base-0.10.13"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
