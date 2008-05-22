# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-i810/xf86-video-i810-2.3.1-r1.ebuild,v 1.1 2008/05/22 12:19:29 remi Exp $

# Must be before x-modular eclass is inherited
# Enable snapshot to get the man page in the right place
# This should be fixed with a XDP patch later
SNAPSHOT="yes"
XDPVER=-1

inherit x-modular

# This really needs a pkgmove...
SRC_URI="http://xorg.freedesktop.org/archive/individual/driver/xf86-video-intel-${PV}.tar.bz2"

S="${WORKDIR}/xf86-video-intel-${PV}"

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
			>=x11-libs/libdrm-2.2
			x11-libs/libX11 )"

CONFIGURE_OPTIONS="$(use_enable dri)"
PATCHES=(
"${FILESDIR}/2.3.1/0001-Skip-copying-on-FOURCC_XVMC-surfaces.patch"
"${FILESDIR}/2.3.1/0002-Only-use-FOURCC_XVMC-when-INTEL_XVMC-is-defined.patch"
"${FILESDIR}/2.3.1/0003-Panel-fitting-fix-letterbox-modes.patch"
"${FILESDIR}/2.3.1/0004-Add-glproto-to-DRI-dependencies.patch"
"${FILESDIR}/2.3.1/0005-Revert-Add-FIFO-watermark-regs-to-register-dumper.patch")

pkg_setup() {
	if use dri && ! built_with_use x11-base/xorg-server dri; then
		die "Build x11-base/xorg-server with USE=dri."
	fi
}
