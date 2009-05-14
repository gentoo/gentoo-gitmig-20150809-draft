# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dvb/gst-plugins-dvb-0.10.11.ebuild,v 1.4 2009/05/14 19:45:34 maekke Exp $

inherit gst-plugins-bad

DESCRIPION="plugin to allow capture from dvb devices"
KEYWORDS="alpha amd64 ~ppc x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.22"
DEPEND="${RDEPEND}
	virtual/os-headers
	dev-util/pkgconfig"
