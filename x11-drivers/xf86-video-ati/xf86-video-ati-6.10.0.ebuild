# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-ati/xf86-video-ati-6.10.0.ebuild,v 1.1 2009/01/13 06:02:23 dberkholz Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular eutils

DESCRIPTION="ATI video driver"

KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="dri"

RDEPEND=">=x11-base/xorg-server-1.2"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xineramaproto
	x11-proto/xf86miscproto
	x11-proto/xproto
	dri? ( x11-proto/glproto
			x11-proto/xf86driproto
			>=x11-libs/libdrm-2 )"

CONFIGURE_OPTIONS="$(use_enable dri)"

PATCHES=""

pkg_postinst() {
	x-modular_pkg_postinst

	ewarn "If you have a mach64 or r128 video card, read this"
	ewarn "The mach64 and r128 drivers moved to their own packages,"
	ewarn "xf86-video-mach64 and xf86-video-r128. If these weren't installed"
	ewarn "automatically by xorg-server and you have one of these cards,"
	ewarn "check your VIDEO_CARDS settings."
	ebeep
	epause
}
