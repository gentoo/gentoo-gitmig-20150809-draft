# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dvb/gst-plugins-dvb-0.10.21.ebuild,v 1.3 2011/05/23 14:56:57 hwoarang Exp $

inherit gst-plugins-bad

DESCRIPION="plugin to allow capture from dvb devices"
KEYWORDS="~alpha amd64 ~arm ~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.32"
DEPEND="${RDEPEND}
	virtual/os-headers"
