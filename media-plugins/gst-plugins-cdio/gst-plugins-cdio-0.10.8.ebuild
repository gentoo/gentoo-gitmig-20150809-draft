# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-cdio/gst-plugins-cdio-0.10.8.ebuild,v 1.3 2008/07/30 13:27:03 ranger Exp $

inherit gst-plugins-good

KEYWORDS="amd64 ppc ~x86"
IUSE=""

DEPEND=">=dev-libs/libcdio-0.71
	>=media-libs/gst-plugins-base-0.10.18
	>=media-libs/gstreamer-0.10.18"
