# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-openchrome/xf86-video-openchrome-0.2.904_p918.ebuild,v 1.1 2011/04/14 18:44:48 jer Exp $

EAPI="3"

XDPVER="-1"
IUSE="debug dri"

inherit autotools xorg-2

DESCRIPTION="X.Org driver for VIA/S3G cards"
HOMEPAGE="http://www.openchrome.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=x11-base/xorg-server-1.2
	dri? ( x11-libs/libdrm )"
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

DOCS=( ChangeLog NEWS README )

pkg_setup() {
	CONFIGURE_OPTIONS="
		$(use_enable debug)
		$(use_enable debug xv-debug)
	"
}

src_prepare() {
	eautoreconf
}

pkg_postinst() {
	elog "Supported chipsets:"
	elog "CLE266 KM400/KN400 K8M800/K8N800 PM800/PM880/CN400"
	elog "VM800/P4M800Pro/VN800/CN700 K8M890/K8N890 P4M900/VN896/CN896"
	elog "CX700/VX700 P4M890 VX800/VX820 VX855/VX875"
	elog "The driver name is 'openchrome', and this is what you need"
	elog "to use in your xorg.conf now (instead of 'via')."
	elog ""
	elog "See the ChangeLog and release notes for more information."
}
