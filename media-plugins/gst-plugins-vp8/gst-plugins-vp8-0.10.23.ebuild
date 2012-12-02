# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vp8/gst-plugins-vp8-0.10.23.ebuild,v 1.1 2012/12/02 18:04:33 eva Exp $

EAPI="5"

inherit gst-plugins-bad gst-plugins10

DESCRIPTION="GStreamer decoder for vpx video format"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-fbsd"
IUSE=""

RDEPEND="media-libs/libvpx"
DEPEND="${RDEPEND}"

src_prepare() {
	gst-plugins10_system_link \
		gst-libs/gst/video:gstreamer-video
}
