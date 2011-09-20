# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-shout2/gst-plugins-shout2-0.10.30.ebuild,v 1.2 2011/09/20 03:59:26 phajdan.jr Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin to send data to an icecast server"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.33
	>=media-libs/libshout-2.0"
DEPEND="${RDEPEND}"
