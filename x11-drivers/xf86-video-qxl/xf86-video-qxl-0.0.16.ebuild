# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-qxl/xf86-video-qxl-0.0.16.ebuild,v 1.4 2011/09/04 12:19:16 maekke Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="QEMU QXL paravirt video driver"

KEYWORDS="amd64 x86"
IUSE="xspice"

RDEPEND="xspice? ( app-emulation/spice )
	>=app-emulation/spice-protocol-0.8.1
	x11-base/xorg-server[-minimal]"
DEPEND="${RDEPEND}
	x11-proto/xf86dgaproto"

pkg_setup() {
	xorg-2_pkg_setup
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable xspice)
	)
}
