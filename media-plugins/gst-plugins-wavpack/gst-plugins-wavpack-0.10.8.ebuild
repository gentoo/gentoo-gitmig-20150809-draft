# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-wavpack/gst-plugins-wavpack-0.10.8.ebuild,v 1.3 2008/07/26 23:10:32 eva Exp $

inherit gst-plugins-good

KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="media-sound/wavpack
	>=media-libs/gst-plugins-base-0.10.18
	>=media-libs/gstreamer-0.10.18"
