# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libmms/gst-plugins-libmms-0.10.4.ebuild,v 1.1 2007/01/25 20:03:09 lack Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64 ~x86"

RDEPEND=">=media-libs/gst-plugins-base-0.10.10.1
		>=media-libs/gstreamer-0.10.10
		>=media-libs/libmms-0.3"

DEPEND="${RDEPEND}"
