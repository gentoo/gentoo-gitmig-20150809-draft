# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-amrnb/gst-plugins-amrnb-0.10.8.ebuild,v 1.3 2008/08/07 21:13:23 klausman Exp $

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 ~x86"
IUSE=""

DEPEND=">=media-libs/gst-plugins-base-0.10.17
	>=media-libs/gstreamer-0.10.17
	media-libs/amrnb"
