# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-wavpack/gst-plugins-wavpack-0.10.14.ebuild,v 1.5 2009/05/21 15:30:17 ranger Exp $

inherit gst-plugins-good

KEYWORDS="alpha amd64 ~ppc x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.22
	>=media-libs/gstreamer-0.10.22
	>=media-sound/wavpack-4.40"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
