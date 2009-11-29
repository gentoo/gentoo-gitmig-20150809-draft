# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-sidplay/gst-plugins-sidplay-0.10.12.ebuild,v 1.5 2009/11/29 17:37:21 klausman Exp $

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 ~ppc ppc64 ~sparc x86"
IUSE=""

DEPEND="=media-libs/libsidplay-1.3*
	 >=media-libs/gstreamer-0.10.23
	 >=media-libs/gst-plugins-base-0.10.23"
