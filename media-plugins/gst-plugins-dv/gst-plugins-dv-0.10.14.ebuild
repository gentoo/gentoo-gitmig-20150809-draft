# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dv/gst-plugins-dv-0.10.14.ebuild,v 1.3 2009/05/12 20:39:52 fauli Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin to decode DV"
KEYWORDS="alpha ~amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=media-libs/libdv-0.100
	>=media-libs/gstreamer-0.10.22
	>=media-libs/gst-plugins-base-0.10.22"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

GST_PLUGINS_BUILD="libdv"
