# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vp8/gst-plugins-vp8-0.10.22.ebuild,v 1.4 2012/05/17 15:05:23 aballier Exp $

inherit gst-plugins-bad

KEYWORDS="amd64 x86 ~amd64-fbsd"
IUSE=""

RDEPEND="media-libs/libvpx
	>=media-libs/gst-plugins-base-0.10.33
	>=media-libs/gst-plugins-bad-${PV}" # uses basevideo
DEPEND="${RDEPEND}"
