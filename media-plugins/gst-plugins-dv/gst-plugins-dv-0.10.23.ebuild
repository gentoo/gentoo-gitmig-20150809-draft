# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dv/gst-plugins-dv-0.10.23.ebuild,v 1.4 2011/01/06 17:01:29 armin76 Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin to demux and decode DV"
KEYWORDS="alpha amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=media-libs/libdv-0.100
	>=media-libs/gst-plugins-base-0.10.29"
DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="libdv"
