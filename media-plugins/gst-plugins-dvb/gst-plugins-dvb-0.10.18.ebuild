# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dvb/gst-plugins-dvb-0.10.18.ebuild,v 1.6 2010/08/05 20:30:57 ssuominen Exp $

inherit gst-plugins-bad

DESCRIPION="plugin to allow capture from dvb devices"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.27"
DEPEND="${RDEPEND}
	virtual/os-headers"
