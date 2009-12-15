# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-sis/xf86-video-sis-0.10.2.ebuild,v 1.6 2009/12/15 15:44:59 armin76 Exp $

EAPI="2"

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="SiS and XGI video driver"
KEYWORDS="amd64 ia64 ppc x86 ~x86-fbsd"
IUSE="dri"
RDEPEND="dri? ( x11-base/xorg-server[-minimal] )
	!dri? ( x11-base/xorg-server )
"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xf86miscproto
	x11-proto/xineramaproto
	x11-proto/xproto
	dri? (
		x11-proto/xf86driproto
		>=x11-libs/libdrm-2
	)"

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_enable dri)"
}
