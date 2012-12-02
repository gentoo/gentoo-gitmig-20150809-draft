# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mplex/gst-plugins-mplex-0.10.23.ebuild,v 1.1 2012/12/02 18:00:10 eva Exp $

EAPI="5"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for MPEG/DVD/SVCD/VCD video/audio multiplexing"
KEYWORDS="~amd64 ~hppa ~x86 ~amd64-fbsd"
IUSE=""

RDEPEND=">=media-video/mjpegtools-2"
DEPEND="${RDEPEND}"
