# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-v4l2/gst-plugins-v4l2-0.10.8.ebuild,v 1.6 2008/08/08 19:16:40 maekke Exp $

inherit gst-plugins-good

DESCRIPION="plugin to allow capture from video4linux2 devices"

KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.18"
DEPEND="${RDEPEND}
	virtual/os-headers
	dev-util/pkgconfig"
