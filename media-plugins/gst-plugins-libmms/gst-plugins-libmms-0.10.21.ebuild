# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libmms/gst-plugins-libmms-0.10.21.ebuild,v 1.3 2011/05/23 14:57:54 hwoarang Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha amd64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.32
	>=media-libs/libmms-0.4"
DEPEND="${RDEPEND}"
