# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-wavpack/gst-plugins-wavpack-0.10.6.ebuild,v 1.1 2007/08/30 10:54:02 drac Exp $

inherit gst-plugins-good

KEYWORDS="~x86"

RDEPEND="media-sound/wavpack
	>=media-libs/gst-plugins-base-0.10.13
	>=media-libs/gstreamer-0.10.13"

DEPEND="${RDEPEND}"
