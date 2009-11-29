# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-taglib/gst-plugins-taglib-0.10.16.ebuild,v 1.6 2009/11/29 17:34:16 klausman Exp $

inherit gst-plugins-good

KEYWORDS="alpha amd64 ~ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.24
	>=media-libs/gstreamer-0.10.24
	>=media-libs/taglib-1.5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
