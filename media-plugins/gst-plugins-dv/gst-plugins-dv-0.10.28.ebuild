# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dv/gst-plugins-dv-0.10.28.ebuild,v 1.3 2011/05/23 14:50:23 hwoarang Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin to demux and decode DV"
KEYWORDS="~alpha amd64 ~hppa ~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=media-libs/libdv-0.100
	>=media-libs/gst-plugins-base-0.10.32"
DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="libdv"
