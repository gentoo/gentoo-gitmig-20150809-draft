# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ogg/gst-plugins-ogg-0.10.14.ebuild,v 1.4 2007/09/10 17:01:40 nixnut Exp $

inherit gst-plugins-base

KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/libogg-1
	>=media-libs/gst-plugins-base-0.10.13.1"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
