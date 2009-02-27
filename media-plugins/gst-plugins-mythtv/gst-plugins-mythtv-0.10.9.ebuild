# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mythtv/gst-plugins-mythtv-0.10.9.ebuild,v 1.2 2009/02/27 20:31:11 josejx Exp $

inherit gst-plugins-bad

DESCRIPION="plugin to allow retrieving from a mythbackend"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-libs/gmyth"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
