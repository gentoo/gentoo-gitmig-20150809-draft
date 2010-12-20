# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-resindvd/gst-plugins-resindvd-0.10.19.ebuild,v 1.3 2010/12/20 17:22:56 hwoarang Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha amd64 ~hppa ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=media-libs/libdvdnav-4.1.2
	>=media-libs/libdvdread-4.1.2
	>=media-libs/gst-plugins-base-0.10.29"
DEPEND="${RDEPEND}"
