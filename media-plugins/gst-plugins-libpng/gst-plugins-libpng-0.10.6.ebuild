# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libpng/gst-plugins-libpng-0.10.6.ebuild,v 1.3 2007/09/10 16:54:07 nixnut Exp $

inherit gst-plugins-good

DESCRIPTION="plug-in to encode png images"

KEYWORDS="~alpha ~amd64 ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=media-libs/libpng-1.2
	>=media-libs/gstreamer-0.10.13
	>=media-libs/gst-plugins-base-0.10.13"

DEPEND="${RDEPEND}"
