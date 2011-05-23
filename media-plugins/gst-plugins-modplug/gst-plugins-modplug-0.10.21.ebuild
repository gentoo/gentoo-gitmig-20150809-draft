# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-modplug/gst-plugins-modplug-0.10.21.ebuild,v 1.3 2011/05/23 14:58:22 hwoarang Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND="media-libs/libmodplug
	>=media-libs/gst-plugins-base-0.10.32"
DEPEND="${RDEPEND}"
