# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-via/xf86-video-via-0.1.31.1-r1.ebuild,v 1.2 2005/11/05 03:47:53 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org driver for via cards"
KEYWORDS="~x86"
IUSE="dri"
RDEPEND="x11-base/xorg-server
		x11-libs/libXvMC"
DEPEND="${RDEPEND}
	x11-proto/xproto
	dri? ( x11-proto/xf86driproto
		>=x11-libs/libdrm-1.0.5 )"

PATCHES="${FILESDIR}/VIAVidAdjustFrame_fix.patch"
CONFIGURE_OPTIONS="$(use_enable dri)"

pkg_setup() {
	if use dri && ! built_with_use x11-base/xorg-server dri; then
		die "Build x11-base/xorg-server with USE=dri."
	fi
}
