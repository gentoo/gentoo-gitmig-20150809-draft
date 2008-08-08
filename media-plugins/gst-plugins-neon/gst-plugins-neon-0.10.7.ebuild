# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-neon/gst-plugins-neon-0.10.7.ebuild,v 1.7 2008/08/08 18:44:42 maekke Exp $

inherit gst-plugins-bad

KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=net-misc/neon-0.26
	>=media-libs/gstreamer-0.10.19
	>=media-libs/gst-plugins-base-0.10.19"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
