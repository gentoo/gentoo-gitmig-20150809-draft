# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libpng/gst-plugins-libpng-0.10.14.ebuild,v 1.2 2009/05/03 17:43:26 klausman Exp $

inherit gst-plugins-good

DESCRIPTION="plug-in to encode png images"
KEYWORDS="alpha ~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=media-libs/libpng-1.2
	>=media-libs/gstreamer-0.10.22
	>=media-libs/gst-plugins-base-0.10.22"
