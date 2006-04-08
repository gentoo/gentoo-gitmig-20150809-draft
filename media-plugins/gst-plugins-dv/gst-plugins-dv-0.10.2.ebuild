# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dv/gst-plugins-dv-0.10.2.ebuild,v 1.3 2006/04/08 12:50:04 dertobi123 Exp $

inherit gst-plugins-good

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

GST_PLUGINS_BUILD="libdv"
DESCRIPTION="GStreamer plugin to decode DV"

IUSE=""
RDEPEND=">=media-libs/libdv-0.100"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
