# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-radeonhd/xf86-video-radeonhd-1.2.5.ebuild,v 1.1 2009/04/29 04:58:13 je_fro Exp $

XDPVER=-1
inherit x-modular

DESCRIPTION="Experimental Radeon HD video driver."
HOMEPAGE="http://wiki.x.org/wiki/radeonhd"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.3.0
	sys-apps/pciutils"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xproto"

src_install() {
	x-modular_src_install
	dobin utils/conntest/rhd_{conntest,dump}
}
