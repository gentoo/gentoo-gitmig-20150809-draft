# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-v4l/gst-plugins-v4l-0.10.4.ebuild,v 1.2 2006/04/08 13:00:01 dertobi123 Exp $

inherit gst-plugins-base

DESCRIPION="plugin to allow capture from video4linux1 devices"

KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

RDEPEND="|| ( x11-drivers/xf86-video-v4l virtual/x11 )"

DEPEND="${RDEPEND}
	virtual/os-headers
	>=dev-util/pkgconfig-0.9"

