# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mplex/gst-plugins-mplex-0.10.22.ebuild,v 1.1 2011/07/29 08:46:58 leio Exp $

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for MPEG/DVD/SVCD/VCD video/audio multiplexing"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-video/mjpegtools-1.9.0
	>=media-libs/gst-plugins-base-0.10.33"
DEPEND="${RDEPEND}"
