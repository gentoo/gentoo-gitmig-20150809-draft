# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-openchrome/xf86-video-openchrome-0.2.904_p932.ebuild,v 1.1 2011/06/28 19:01:02 jer Exp $

EAPI=4

XORG_DRI=dri
XORG_EAUTORECONF=yes
inherit xorg-2

DESCRIPTION="X.Org driver for VIA/S3G cards"
HOMEPAGE="http://www.openchrome.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=x11-base/xorg-server-1.9"
DEPEND="${RDEPEND}
	x11-libs/libX11
	x11-libs/libXv
	x11-libs/libXvMC
"

DOCS=( ChangeLog NEWS README )

pkg_setup() {
	xorg-2_pkg_setup
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable debug)
		$(use_enable debug xv-debug)
	)
}

pkg_postinst() {
	xorg-2_pkg_postinst

	elog "Supported chipsets:"
	elog "CLE266 KM400/KN400 K8M800/K8N800 PM800/PM880/CN400"
	elog "VM800/P4M800Pro/VN800/CN700 K8M890/K8N890 P4M900/VN896/CN896"
	elog "CX700/VX700 P4M890 VX800/VX820 VX855/VX875"
	elog "The driver name is 'openchrome', and this is what you need"
	elog "to use in your xorg.conf now (instead of 'via')."
	elog ""
	elog "See the ChangeLog and release notes for more information."
}
