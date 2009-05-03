# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-shout2/gst-plugins-shout2-0.10.14.ebuild,v 1.2 2009/05/03 17:44:53 klausman Exp $

inherit gst-plugins-good

DESCRIPTION="Plug-in to send data to an icecast server using libshout2"
KEYWORDS="alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=media-libs/gst-plugins-base-0.10.22
	>=media-libs/gstreamer-0.10.22
	>=media-libs/libshout-2.0"
