# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-wavpack/gst-plugins-wavpack-0.10.8.ebuild,v 1.1 2008/06/29 16:04:10 drac Exp $

inherit gst-plugins-good

KEYWORDS="~amd64 ~x86"

DEPEND="media-sound/wavpack
	>=media-libs/gst-plugins-base-0.10.18
	>=media-libs/gstreamer-0.10.18"
