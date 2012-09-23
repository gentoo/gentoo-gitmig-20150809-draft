# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vp8/gst-plugins-vp8-0.10.22.ebuild,v 1.5 2012/09/23 05:21:20 blueness Exp $

inherit gst-plugins-bad

KEYWORDS="amd64 ~ppc64 x86 ~amd64-fbsd"
IUSE=""

RDEPEND="media-libs/libvpx
	>=media-libs/gst-plugins-base-0.10.33
	>=media-libs/gst-plugins-bad-${PV}" # uses basevideo
DEPEND="${RDEPEND}"
