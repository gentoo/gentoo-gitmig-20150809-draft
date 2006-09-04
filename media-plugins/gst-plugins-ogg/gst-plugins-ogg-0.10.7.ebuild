# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ogg/gst-plugins-ogg-0.10.7.ebuild,v 1.2 2006/09/04 06:35:30 vapier Exp $

inherit gst-plugins-base

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/libogg-1
		 >=media-libs/gst-plugins-base-0.10.7"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
