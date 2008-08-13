# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mythtv/gst-plugins-mythtv-0.10.6.ebuild,v 1.3 2008/08/13 09:44:24 armin76 Exp $

inherit gst-plugins-bad

DESCRIPION="plugin to allow retrieving from a mythbackend"

KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="media-libs/gmyth"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
