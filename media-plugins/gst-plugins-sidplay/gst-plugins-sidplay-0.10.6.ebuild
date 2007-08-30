# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-sidplay/gst-plugins-sidplay-0.10.6.ebuild,v 1.1 2007/08/30 20:20:22 drac Exp $

inherit gst-plugins-ugly

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="=media-libs/libsidplay-1.3*
	 >=media-libs/gstreamer-0.10.13
	 >=media-libs/gst-plugins-base-0.10.13"
