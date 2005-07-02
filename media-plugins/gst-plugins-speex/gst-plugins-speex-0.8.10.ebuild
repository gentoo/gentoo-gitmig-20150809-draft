# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-speex/gst-plugins-speex-0.8.10.ebuild,v 1.1 2005/07/02 10:22:20 zaheerm Exp $

inherit gst-plugins

KEYWORDS="~x86 ~ppc ~amd64"

DESCRIPTION="GStreamer plugin to allow encoding and decoding of speex"

IUSE=""
RDEPEND=">=media-libs/speex-1.1.6"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
