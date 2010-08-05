# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-neon/gst-plugins-neon-0.10.18.ebuild,v 1.7 2010/08/05 20:29:07 ssuominen Exp $

inherit autotools gst-plugins-bad

KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=net-libs/neon-0.26
	>=media-libs/gst-plugins-base-0.10.27"
DEPEND="${RDEPEND}"
