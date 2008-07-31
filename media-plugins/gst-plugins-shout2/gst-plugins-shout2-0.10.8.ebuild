# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-shout2/gst-plugins-shout2-0.10.8.ebuild,v 1.3 2008/07/31 17:04:45 ranger Exp $

inherit gst-plugins-good

DESCRIPTION="Plug-in to send data to an icecast server using libshout2"

KEYWORDS="amd64 ~ppc ppc64 ~x86"
IUSE=""

DEPEND=">=media-libs/libshout-0.71
	>=media-libs/gst-plugins-base-0.10.18
	>=media-libs/gstreamer-0.10.18"
