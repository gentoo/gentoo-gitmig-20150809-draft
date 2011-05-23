# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-v4l2/gst-plugins-v4l2-0.10.28-r1.ebuild,v 1.3 2011/05/23 14:53:39 hwoarang Exp $

inherit gst-plugins-good

DESCRIPION="plugin to allow capture from video4linux2 devices"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.32"
DEPEND="${RDEPEND}
	media-libs/libv4l
	virtual/os-headers"

GST_PLUGINS_BUILD="gst_v4l2"

src_configure() {
	gst-plugins-good_src_configure --with-libv4l2
}
