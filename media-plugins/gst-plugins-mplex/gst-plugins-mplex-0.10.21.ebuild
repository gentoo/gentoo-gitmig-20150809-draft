# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mplex/gst-plugins-mplex-0.10.21.ebuild,v 1.1 2011/04/13 09:59:02 leio Exp $

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for MPEG/DVD/SVCD/VCD video/audio multiplexing"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-video/mjpegtools-1.9.0
	>=media-libs/gst-plugins-base-0.10.32"
DEPEND="${RDEPEND}"
