# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vp8/gst-plugins-vp8-0.10.19.ebuild,v 1.1 2010/07/30 12:25:09 leio Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64"
IUSE=""

RDEPEND="media-libs/libvpx
	>=media-libs/gst-plugins-base-0.10.29"
DEPEND="${RDEPEND}"
