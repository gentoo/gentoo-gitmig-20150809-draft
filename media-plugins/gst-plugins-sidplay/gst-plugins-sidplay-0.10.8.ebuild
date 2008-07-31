# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-sidplay/gst-plugins-sidplay-0.10.8.ebuild,v 1.4 2008/07/31 17:05:04 ranger Exp $

inherit gst-plugins-ugly

KEYWORDS="amd64 ppc ppc64 ~sparc ~x86"
IUSE=""

DEPEND="=media-libs/libsidplay-1.3*
	 >=media-libs/gstreamer-0.10.17
	 >=media-libs/gst-plugins-base-0.10.17"
