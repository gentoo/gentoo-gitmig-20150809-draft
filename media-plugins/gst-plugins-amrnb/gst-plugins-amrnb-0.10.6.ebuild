# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-amrnb/gst-plugins-amrnb-0.10.6.ebuild,v 1.2 2007/11/18 17:31:56 drac Exp $

inherit gst-plugins-ugly

KEYWORDS="~amd64 ~x86"

RDEPEND=">=media-libs/gst-plugins-base-0.10.13
	>=media-libs/gstreamer-0.10.13
	media-libs/amrnb"

DEPEND="${RDEPEND}"
