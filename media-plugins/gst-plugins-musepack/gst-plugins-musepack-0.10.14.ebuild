# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-musepack/gst-plugins-musepack-0.10.14.ebuild,v 1.4 2009/11/17 21:06:33 ranger Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha amd64 ~ppc ppc64 ~x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.24
	>=media-libs/gstreamer-0.10.24
	>=media-sound/musepack-tools-444"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
