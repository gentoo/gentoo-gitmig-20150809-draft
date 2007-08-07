# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-sidplay/gst-plugins-sidplay-0.10.4.ebuild,v 1.3 2007/08/07 15:03:49 gustavoz Exp $

inherit gst-plugins-ugly

KEYWORDS="~amd64 ~ppc ~ppc64 sparc ~x86"
IUSE=""

RDEPEND="=media-libs/libsidplay-1.3*
	 >=media-libs/gstreamer-0.10.3
	 >=media-libs/gst-plugins-base-0.10.3"
