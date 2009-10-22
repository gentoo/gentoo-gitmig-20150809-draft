# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-intel/xf86-video-intel-2.9.0-r1.ebuild,v 1.1 2009/10/22 13:45:49 remi Exp $

inherit x-modular

DESCRIPTION="X.Org driver for Intel cards"

KEYWORDS="~amd64 ~ia64 ~x86 ~x86-fbsd"
IUSE="dri"

RDEPEND=">=x11-base/xorg-server-1.6
	>=x11-libs/libdrm-2.4.11
	x11-libs/libpciaccess
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXvMC"
DEPEND="${RDEPEND}
	>=x11-proto/dri2proto-1.99.3
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/xineramaproto
	x11-proto/xextproto
	x11-proto/xproto
	dri? ( x11-proto/xf86driproto
	       x11-proto/glproto )"

PATCHES=(
"${FILESDIR}/${PV}-0001-drmmode-with-1.7-server-set-mode-major-doesn-t-get-g.patch"
"${FILESDIR}/${PV}-0002-uxa-Free-the-ScratchPixmapHeader-after-its-associate.patch"
"${FILESDIR}/${PV}-0003-Drop-frontbuffer-from-crtc-in-I830CloseScreen.patch"
)

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_enable dri)"
}
