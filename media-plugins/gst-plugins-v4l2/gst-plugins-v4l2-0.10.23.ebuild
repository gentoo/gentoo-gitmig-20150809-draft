# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-v4l2/gst-plugins-v4l2-0.10.23.ebuild,v 1.1 2010/07/31 11:30:16 leio Exp $

inherit gst-plugins-good

DESCRIPION="plugin to allow capture from video4linux2 devices"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.29"
DEPEND="${RDEPEND}
	virtual/os-headers"

GST_PLUGINS_BUILD="gst_v4l2"
