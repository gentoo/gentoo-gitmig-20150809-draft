# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-jpeg/gst-plugins-jpeg-0.10.23.ebuild,v 1.4 2011/01/06 17:06:11 armin76 Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer encoder/decoder for JPEG format"
KEYWORDS="alpha amd64 ~arm ~hppa ~ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND="media-libs/jpeg
	>=media-libs/gst-plugins-base-0.10.29"
DEPEND="${RDEPEND}"
