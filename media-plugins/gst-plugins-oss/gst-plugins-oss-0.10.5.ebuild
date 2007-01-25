# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-oss/gst-plugins-oss-0.10.5.ebuild,v 1.1 2007/01/25 17:45:06 lack Exp $

inherit gst-plugins-good

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/gstreamer-0.10.10
		>=media-libs/gst-plugins-base-0.10.10.1"

DEPEND="virtual/os-headers
	${RDEPEND}"
