# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-soundtouch/gst-plugins-soundtouch-0.10.22.ebuild,v 1.1 2011/10/13 06:43:29 leio Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64"
IUSE=""
DESCRIPTION="GStreamer elements for beats-per-minute detection and pitch controlling"

RDEPEND=">=media-libs/libsoundtouch-1.4
	>=media-libs/gst-plugins-base-0.10.33"
DEPEND="${RDEPEND}"
