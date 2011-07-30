# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-xvid/gst-plugins-xvid-0.10.22.ebuild,v 1.1 2011/07/30 19:55:20 leio Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64 ~x86"
IUSE=""
DESCRIPTION="GStreamer plugin for XviD (MPEG-4) video encoding/decoding support"

RDEPEND="media-libs/xvid
	>=media-libs/gst-plugins-base-0.10.33"
DEPEND="${RDEPEND}"
