# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-theora/gst-plugins-theora-0.10.11.ebuild,v 1.7 2007/02/12 19:27:16 opfer Exp $

inherit gst-plugins-base

KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ppc64 ~sh sparc x86"
IUSE=""

RDEPEND=">=media-libs/libtheora-1.0_alpha3
	>=media-libs/libogg-1
	>=media-libs/gst-plugins-base-0.10.11"
DEPEND="${RDEPEND}"
