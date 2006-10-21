# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-speex/gst-plugins-speex-0.10.2.ebuild,v 1.6 2006/10/21 18:39:41 dertobi123 Exp $

inherit gst-plugins-good

KEYWORDS="~amd64 ppc ~ppc64 sparc ~x86"

DESCRIPTION="GStreamer plugin to allow encoding and decoding of speex"

IUSE=""
RDEPEND=">=media-libs/speex-1.1.6"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
