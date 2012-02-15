# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-rtmp/gst-plugins-rtmp-0.10.22.ebuild,v 1.1 2012/02/15 12:53:44 ford_prefect Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-video/rtmpdump
	>=media-libs/gst-plugins-base-0.10.33
	>=media-libs/gst-plugins-bad-${PV}" # uses basevideo
DEPEND="${RDEPEND}"
