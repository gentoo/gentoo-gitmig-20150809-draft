# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ogg/gst-plugins-ogg-0.10.4.ebuild,v 1.4 2006/03/23 18:29:09 gustavoz Exp $

inherit gst-plugins-base

KEYWORDS="~amd64 ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/libogg-1
		 >=media-libs/gst-plugins-base-0.10.4"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
