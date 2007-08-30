# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-shout2/gst-plugins-shout2-0.10.6.ebuild,v 1.1 2007/08/30 19:47:12 drac Exp $

inherit gst-plugins-good

DESCRIPTION="Plug-in to send data to an icecast server using libshout2"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=media-libs/libshout-0.71
	>=media-libs/gst-plugins-base-0.10.13
	>=media-libs/gstreamer-0.10.13"

DEPEND="${RDEPEND}"
