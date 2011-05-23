# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libpng/gst-plugins-libpng-0.10.28.ebuild,v 1.3 2011/05/23 14:51:46 hwoarang Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer encoder/decoder for PNG images"
KEYWORDS="~alpha amd64 ~arm ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=media-libs/libpng-1.4
	>=media-libs/gst-plugins-base-0.10.32"
DEPEND="${RDEPEND}"
