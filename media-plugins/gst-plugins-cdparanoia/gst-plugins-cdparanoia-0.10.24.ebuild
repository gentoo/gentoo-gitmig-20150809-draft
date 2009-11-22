# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-cdparanoia/gst-plugins-cdparanoia-0.10.24.ebuild,v 1.7 2009/11/22 18:49:56 klausman Exp $

inherit gst-plugins-base

KEYWORDS="alpha amd64 hppa ~ia64 ~ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.23
	>=media-sound/cdparanoia-3.10.2-r3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
