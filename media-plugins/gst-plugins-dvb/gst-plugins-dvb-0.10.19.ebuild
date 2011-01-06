# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dvb/gst-plugins-dvb-0.10.19.ebuild,v 1.6 2011/01/06 16:48:18 armin76 Exp $

inherit gst-plugins-bad

DESCRIPION="plugin to allow capture from dvb devices"
KEYWORDS="alpha amd64 arm ~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.29"
DEPEND="${RDEPEND}
	virtual/os-headers"
