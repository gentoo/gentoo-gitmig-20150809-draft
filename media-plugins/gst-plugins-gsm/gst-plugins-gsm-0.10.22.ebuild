# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gsm/gst-plugins-gsm-0.10.22.ebuild,v 1.1 2011/09/27 10:04:49 leio Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64"
IUSE=""
DESCRIPTION="GStreamer plugin for GSM audio decoding/encoding"

RDEPEND="media-sound/gsm
	>=media-libs/gst-plugins-base-0.10.33"
DEPEND="${RDEPEND}"
