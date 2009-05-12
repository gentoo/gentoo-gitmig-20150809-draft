# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-x264/gst-plugins-x264-0.10.11.ebuild,v 1.3 2009/05/12 21:25:09 fauli Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND=">=media-libs/x264-0.0.20081006
	>=media-libs/gstreamer-0.10.22
	>=media-libs/gst-plugins-base-0.10.22"
DEPEND="${RDEPEND}"
