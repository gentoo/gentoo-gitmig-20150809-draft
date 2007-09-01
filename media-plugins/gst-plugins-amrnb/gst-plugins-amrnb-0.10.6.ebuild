# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-amrnb/gst-plugins-amrnb-0.10.6.ebuild,v 1.1 2007/09/01 07:03:29 drac Exp $

inherit gst-plugins-ugly

KEYWORDS="~x86"

RDEPEND=">=media-libs/gst-plugins-base-0.10.13
	>=media-libs/gstreamer-0.10.13
	media-libs/amrnb"

DEPEND="${RDEPEND}"
