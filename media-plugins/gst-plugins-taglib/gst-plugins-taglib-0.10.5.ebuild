# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-taglib/gst-plugins-taglib-0.10.5.ebuild,v 1.5 2007/08/24 03:28:07 metalgod Exp $

inherit gst-plugins-good

KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.10.1
	>=media-libs/gstreamer-0.10.10
	>=media-libs/taglib-1.4"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"
