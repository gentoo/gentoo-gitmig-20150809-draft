# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-neon/gst-plugins-neon-0.10.19.ebuild,v 1.4 2011/01/06 16:55:12 armin76 Exp $

inherit gst-plugins-bad

KEYWORDS="alpha amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=net-libs/neon-0.26
	>=media-libs/gst-plugins-base-0.10.29"
DEPEND="${RDEPEND}"
