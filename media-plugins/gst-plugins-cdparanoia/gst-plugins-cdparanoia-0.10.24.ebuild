# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-cdparanoia/gst-plugins-cdparanoia-0.10.24.ebuild,v 1.9 2010/01/05 18:11:27 nixnut Exp $

inherit gst-plugins-base

KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.23
	>=media-sound/cdparanoia-3.10.2-r3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
