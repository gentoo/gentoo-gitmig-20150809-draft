# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libpng/gst-plugins-libpng-0.10.3.ebuild,v 1.2 2006/05/20 14:56:07 tcort Exp $

inherit gst-plugins-good

DESCRIPTION="plug-in to encode png images"

KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=media-libs/libpng-1.2
	>=media-libs/gstreamer-0.10.5
	>=media-libs/gst-plugins-base-0.10.6"

DEPEND="${RDEPEND}"
