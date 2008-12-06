# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libpng/gst-plugins-libpng-0.10.11.ebuild,v 1.2 2008/12/06 18:06:50 solar Exp $

inherit gst-plugins-good

DESCRIPTION="plug-in to encode png images"
KEYWORDS="~arm ~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=media-libs/libpng-1.2
	>=media-libs/gstreamer-0.10.21
	>=media-libs/gst-plugins-base-0.10.21"
