# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dvb/gst-plugins-dvb-0.10.7.ebuild,v 1.1 2008/06/29 18:15:50 drac Exp $

inherit gst-plugins-bad

DESCRIPION="plugin to allow capture from dvb devices"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.19"
DEPEND="${RDEPEND}
	virtual/os-headers
	dev-util/pkgconfig"
