# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vp8/gst-plugins-vp8-0.10.22.ebuild,v 1.8 2012/12/02 18:29:48 eva Exp $

EAPI="2"

inherit gst-plugins-bad gst-plugins10

KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-fbsd"
IUSE=""

RDEPEND="media-libs/libvpx
	>=media-libs/gst-plugins-base-0.10.33:0.10
	>=media-libs/gst-plugins-bad-${PV}:0.10" # uses basevideo
DEPEND="${RDEPEND}"

src_prepare() {
	gst-plugins10_system_link \
		gst-libs/gst/video:gstreamer-video
}
