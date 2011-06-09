# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-resindvd/gst-plugins-resindvd-0.10.21.ebuild,v 1.5 2011/06/09 16:18:15 jer Exp $

inherit gst-plugins-bad

KEYWORDS="alpha amd64 hppa ~ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-libs/libdvdnav-4.1.2
	>=media-libs/libdvdread-4.1.2
	>=media-libs/gst-plugins-base-0.10.32"
DEPEND="${RDEPEND}"
