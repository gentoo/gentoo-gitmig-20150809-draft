# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-amrnb/gst-plugins-amrnb-0.10.11.ebuild,v 1.2 2009/05/03 17:48:19 klausman Exp $

inherit gst-plugins-ugly

KEYWORDS="alpha ~amd64 ~x86"
IUSE=""

DEPEND=">=media-libs/gst-plugins-base-0.10.22
	>=media-libs/gstreamer-0.10.22
	media-libs/amrnb"
