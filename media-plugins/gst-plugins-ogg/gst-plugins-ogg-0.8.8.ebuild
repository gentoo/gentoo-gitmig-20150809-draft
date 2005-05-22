# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ogg/gst-plugins-ogg-0.8.8.ebuild,v 1.8 2005/05/22 12:21:39 kloeri Exp $

inherit gst-plugins

KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-libs/libogg-1"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
