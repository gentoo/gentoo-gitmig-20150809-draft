# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-shout2/gst-plugins-shout2-0.10.22.ebuild,v 1.6 2010/09/11 10:05:03 nixnut Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin to send data to an icecast server"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""

DEPEND=">=media-libs/gst-plugins-base-0.10.29
	>=media-libs/libshout-2.0"
