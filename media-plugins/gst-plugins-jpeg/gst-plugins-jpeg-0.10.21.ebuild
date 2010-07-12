# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-jpeg/gst-plugins-jpeg-0.10.21.ebuild,v 1.5 2010/07/12 22:44:26 jer Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer encoder/decoder for JPEG format"
KEYWORDS="~alpha amd64 ~arm hppa ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND="media-libs/jpeg
	>=media-libs/gstreamer-0.10.27
	>=media-libs/gst-plugins-base-0.10.27"
DEPEND="${RDEPEND}"
