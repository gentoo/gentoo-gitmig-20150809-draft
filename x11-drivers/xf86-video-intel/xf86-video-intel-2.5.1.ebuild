# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-intel/xf86-video-intel-2.5.1.ebuild,v 1.1 2008/11/17 10:57:54 remi Exp $

SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org driver for Intel cards"

KEYWORDS="~amd64 ~arm ~ia64 ~sh ~x86 ~x86-fbsd"
IUSE="dri"

RDEPEND=">=x11-base/xorg-server-1.2
	x11-libs/libXvMC"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/xextproto
	x11-proto/xineramaproto
	x11-proto/xproto
	dri? ( x11-proto/xf86driproto
			x11-proto/glproto
			>=x11-libs/libdrm-2.4.0
			x11-libs/libX11 )"

CONFIGURE_OPTIONS="$(use_enable dri) --disable-symlinks"

PATCHES=(
"${FILESDIR}/${PV}-0001-clean-up-man-page-generation-and-remove-all-traces-o.patch"
)

pkg_setup() {
	if use dri && ! built_with_use x11-base/xorg-server dri; then
		die "Build x11-base/xorg-server with USE=dri."
	fi
}
