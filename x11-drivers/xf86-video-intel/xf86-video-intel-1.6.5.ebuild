# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-intel/xf86-video-intel-1.6.5.ebuild,v 1.3 2008/11/26 23:26:27 dberkholz Exp $

inherit x-modular

# Old i810 drivers
SRC_URI="http://xorg.freedesktop.org/archive/individual/driver/xf86-video-i810-${PV}.tar.bz2"
S="${WORKDIR}/xf86-video-i810-${PV}"

DESCRIPTION="X.Org driver for Intel cards"
KEYWORDS="amd64 arm ia64 sh x86 ~x86-fbsd"
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
			>=x11-libs/libdrm-2
			x11-libs/libX11 )"

CONFIGURE_OPTIONS="$(use_enable dri)"

PATCHES=("${FILESDIR}/${PV}-fix_no_dri.patch")
