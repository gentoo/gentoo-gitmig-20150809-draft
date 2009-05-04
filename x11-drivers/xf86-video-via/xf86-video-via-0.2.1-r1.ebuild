# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-via/xf86-video-via-0.2.1-r1.ebuild,v 1.10 2009/05/04 15:56:17 ssuominen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="VIA unichrome graphics driver"
KEYWORDS="amd64 ia64 x86 ~x86-fbsd"
IUSE="dri"
RDEPEND=">=x11-base/xorg-server-1.0.99
		x11-libs/libXvMC"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/xextproto
	x11-proto/xproto
	dri? ( x11-proto/xf86driproto
		x11-proto/glproto
		>=x11-libs/libdrm-2
		x11-libs/libX11 )"

PATCHES="${FILESDIR}/missing-assert.patch"

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_enable dri)"
}
