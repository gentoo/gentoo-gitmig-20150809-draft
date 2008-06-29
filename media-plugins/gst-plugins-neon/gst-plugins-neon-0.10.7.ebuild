# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-neon/gst-plugins-neon-0.10.7.ebuild,v 1.1 2008/06/29 18:21:27 drac Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=net-misc/neon-0.26
	>=media-libs/gstreamer-0.10.19
	>=media-libs/gst-plugins-base-0.10.19"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
