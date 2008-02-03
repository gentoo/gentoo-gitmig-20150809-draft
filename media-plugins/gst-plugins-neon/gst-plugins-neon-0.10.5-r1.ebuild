# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-neon/gst-plugins-neon-0.10.5-r1.ebuild,v 1.1 2008/02/03 11:39:50 drac Exp $

inherit eutils gst-plugins-bad

KEYWORDS="~amd64 ~x86"

RDEPEND=">=net-misc/neon-0.25.5
	>=media-libs/gstreamer-0.10.14
	>=media-libs/gst-plugins-base-0.10.14"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	gst-plugins-bad_src_unpack
	epatch "${FILESDIR}"/${P}-neon.patch
}
