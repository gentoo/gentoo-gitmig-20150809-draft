# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-theora/gst-plugins-theora-0.10.9.ebuild,v 1.3 2006/09/04 06:41:11 vapier Exp $

inherit gst-plugins-base

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/libtheora-1.0_alpha3
	>=media-libs/libogg-1
	>=media-libs/gst-plugins-base-0.10.9"
DEPEND="${RDEPEND}"
