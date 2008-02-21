# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-wavpack/gst-plugins-wavpack-0.10.7.ebuild,v 1.1 2008/02/21 16:14:47 zaheerm Exp $

inherit gst-plugins-good

KEYWORDS="~amd64 ~x86"

RDEPEND="media-sound/wavpack
	>=media-libs/gst-plugins-base-0.10.17
	>=media-libs/gstreamer-0.10.17"

DEPEND="${RDEPEND}"
