# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-v4l2/gst-plugins-v4l2-0.10.6.ebuild,v 1.1 2007/08/30 19:42:33 drac Exp $

inherit gst-plugins-good

DESCRIPION="plugin to allow capture from video4linux2 devices"

KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

RDEPEND="x11-drivers/xf86-video-v4l"

DEPEND="${RDEPEND}
	virtual/os-headers
	>=dev-util/pkgconfig-0.9"
