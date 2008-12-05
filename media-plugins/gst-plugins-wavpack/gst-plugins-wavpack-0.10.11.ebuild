# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-wavpack/gst-plugins-wavpack-0.10.11.ebuild,v 1.1 2008/12/05 21:09:38 ssuominen Exp $

inherit gst-plugins-good

KEYWORDS="~alpha ~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.21
	>=media-libs/gstreamer-0.10.21
	media-sound/wavpack"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
