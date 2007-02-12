# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-jpeg/gst-plugins-jpeg-0.10.3.ebuild,v 1.6 2007/02/12 19:27:53 opfer Exp $

inherit gst-plugins-good

DESCRIPTION="plug-in to encode and decode jpeg images"

KEYWORDS="amd64 ~ppc ppc64 sparc x86"
IUSE=""

RDEPEND="media-libs/jpeg
	>=media-libs/gstreamer-0.10.5
	>=media-libs/gst-plugins-base-0.10.6"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
