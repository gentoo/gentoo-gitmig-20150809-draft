# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-speex/gst-plugins-speex-0.10.14.ebuild,v 1.4 2009/05/14 19:37:05 maekke Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin to allow encoding and decoding of speex"
KEYWORDS="alpha amd64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=media-libs/speex-1.1.6
	>=media-libs/gstreamer-0.10.22
	>=media-libs/gst-plugins-base-0.10.22"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
