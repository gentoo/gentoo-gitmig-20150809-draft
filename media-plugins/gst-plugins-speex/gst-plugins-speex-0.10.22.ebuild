# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-speex/gst-plugins-speex-0.10.22.ebuild,v 1.3 2010/07/27 17:46:46 pacho Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin to allow encoding and decoding of speex"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/speex-1.1.6
	>=media-libs/gst-plugins-base-0.10.29"
DEPEND="${RDEPEND}"
