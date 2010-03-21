# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-openchrome/xf86-video-openchrome-0.2.904-r1.ebuild,v 1.1 2010/03/21 16:52:14 chithanh Exp $

XDPVER="-1"
IUSE="debug dri"

inherit x-modular

DESCRIPTION="X.Org driver for VIA/S3G cards"
HOMEPAGE="http://www.openchrome.org"
SRC_URI="${HOMEPAGE}/releases/${P}.tar.bz2"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=x11-base/xorg-server-1.2
	dri? ( >=x11-libs/libdrm-2.4.17 )"
DEPEND="${RDEPEND}
	x11-libs/libX11
	x11-libs/libXv
	x11-libs/libXvMC
	x11-proto/randrproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xproto
	dri? (
		x11-proto/xf86driproto
		x11-proto/glproto
	)"

DOCS="ChangeLog NEWS README"

pkg_setup() {
	CONFIGURE_OPTIONS="
		$(use_enable debug)
		$(use_enable debug xv-debug)
		"
	PATCHES=( "${FILESDIR}/${P}-libdrm-2.4.17.patch" )
}

pkg_postinst() {
	elog "Supported chipsets:"
	elog ""
	elog "CLE266 (VT3122)"
	elog "KM400/P4M800 (VT3205)"
	elog "K8M800 (VT3204)"
	elog "PM800/PM880/CN400 (VT3259)"
	elog "VM800/CN700/P4M800Pro (VT3314)"
	elog "CX700 (VT3324)"
	elog "P4M890 (VT3327)"
	elog "K8M890 (VT3336)"
	elog "P4M900/VN896 (VT3364)"
	elog ""
	elog "The driver name is 'openchrome', and this is what you need"
	elog "to use in your xorg.conf now (instead of 'via')."
	elog ""
	elog "See the ChangeLog and release notes for more information."
}
