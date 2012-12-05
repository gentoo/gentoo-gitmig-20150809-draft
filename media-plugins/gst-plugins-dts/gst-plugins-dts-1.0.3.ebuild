# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dts/gst-plugins-dts-1.0.3.ebuild,v 1.1 2012/12/05 22:43:40 eva Exp $

EAPI="5"

inherit gst-plugins-bad gst-plugins10

DESCRIPTION="GStreamer plugin for MPEG-1/2 video encoding"
KEYWORDS="~amd64 ~hppa ~x86 ~amd64-fbsd"
IUSE="+orc"

RDEPEND="
	media-libs/libdca
	orc? ( >=dev-lang/orc-0.4.16 )
"
DEPEND="${RDEPEND}"

src_configure() {
	gst-plugins10_src_configure $(use_enable orc)
}
