# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/mkcfm/mkcfm-0.99.2.ebuild,v 1.1 2005/11/11 19:49:50 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org mkcfm application"
KEYWORDS="~x86"
RDEPEND="x11-libs/libXfont
	x11-libs/libX11
	x11-libs/libFS"
DEPEND="${RDEPEND}
	x11-proto/fontsproto"

pkg_setup() {
	if ! built_with_use x11-libs/libXfont cid; then
		die "Build x11-libs/libXfont with USE=cid."
	fi
}

