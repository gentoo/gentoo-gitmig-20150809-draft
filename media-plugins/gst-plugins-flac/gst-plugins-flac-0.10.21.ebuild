# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-flac/gst-plugins-flac-0.10.21.ebuild,v 1.3 2010/06/27 13:31:02 nixnut Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer encoder/decoder/tagger for FLAC"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/flac-1.1.4
	>=media-libs/gstreamer-0.10.27
	>=media-libs/gst-plugins-base-0.10.27"
DEPEND="${RDEPEND}"
