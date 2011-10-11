# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dts/gst-plugins-dts-0.10.22.ebuild,v 1.3 2011/10/11 19:54:48 jer Exp $

EAPI=4

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for MPEG-1/2 video encoding"
KEYWORDS="~amd64 hppa ~x86"
IUSE="+orc"

RDEPEND="media-libs/libdca
	>=media-libs/gstreamer-0.10.33
	>=media-libs/gst-plugins-base-0.10.33
	orc? ( >=dev-lang/orc-0.4.11 )"
DEPEND="${RDEPEND}"

src_configure() {
	gst-plugins-bad_src_configure $(use_enable orc)
}
