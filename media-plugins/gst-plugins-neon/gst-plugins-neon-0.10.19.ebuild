# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-neon/gst-plugins-neon-0.10.19.ebuild,v 1.3 2010/12/20 17:22:38 hwoarang Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=net-libs/neon-0.26
	>=media-libs/gst-plugins-base-0.10.29"
DEPEND="${RDEPEND}"
