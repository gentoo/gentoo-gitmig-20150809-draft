# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-lame/gst-plugins-lame-0.10.12.ebuild,v 1.4 2009/11/18 22:49:54 fauli Exp $

inherit gst-plugins-ugly

KEYWORDS="~alpha amd64 ~ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-sound/lame-3.95
	>=media-libs/gstreamer-0.10.23
	>=media-libs/gst-plugins-base-0.10.23"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
