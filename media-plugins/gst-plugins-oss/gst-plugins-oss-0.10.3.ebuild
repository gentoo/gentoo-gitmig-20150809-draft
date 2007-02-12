# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-oss/gst-plugins-oss-0.10.3.ebuild,v 1.10 2007/02/12 19:26:13 opfer Exp $

inherit gst-plugins-good

KEYWORDS="~alpha amd64 arm hppa ia64 ~ppc ppc64 sh sparc x86"
IUSE=""

RDEPEND=">=media-libs/gstreamer-0.10.5
	>=media-libs/gst-plugins-base-0.10.6"

DEPEND="virtual/os-headers
	${RDEPEND}"
