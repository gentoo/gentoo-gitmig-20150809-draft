# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libpng/gst-plugins-libpng-0.10.7.ebuild,v 1.1 2008/02/21 12:49:18 zaheerm Exp $

inherit gst-plugins-good

DESCRIPTION="plug-in to encode png images"

KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/libpng-1.2
	>=media-libs/gstreamer-0.10.17
	>=media-libs/gst-plugins-base-0.10.17"

DEPEND="${RDEPEND}"
