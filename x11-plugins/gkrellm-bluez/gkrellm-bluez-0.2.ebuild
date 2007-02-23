# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-bluez/gkrellm-bluez-0.2.ebuild,v 1.1 2007/02/23 18:18:58 lack Exp $

inherit multilib

DESCRIPTION="GKrellm plugin for monitoring bluetooth (Linux BlueZ) adapters"
SRC_URI="mirror://sourceforge/gkrellm-bluez/${P}.tar.gz"
HOMEPAGE="http://gkrellm-bluez.sourceforge.net"

RDEPEND="=app-admin/gkrellm-2*
	net-wireless/bluez-libs"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
SLOT="0"

src_compile() {
	econf --disable-static || die
	emake || die
}

src_install () {
	einstall || die
}
