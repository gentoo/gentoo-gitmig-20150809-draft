# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-flac/gst-plugins-flac-0.10.5.ebuild,v 1.1 2007/01/25 18:44:30 lack Exp $

inherit gst-plugins-good

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="~media-libs/flac-1.1.2
	>=media-libs/gstreamer-0.10.10
	>=media-libs/gst-plugins-base-0.10.10.1"
DEPEND="${RDEPEND}"
