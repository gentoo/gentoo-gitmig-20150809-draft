# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-bluez/gkrellm-bluez-0.2-r1.ebuild,v 1.6 2009/12/02 11:53:45 maekke Exp $

inherit gkrellm-plugin

DESCRIPTION="GKrellm plugin for monitoring bluetooth (Linux BlueZ) adapters"
SRC_URI="mirror://sourceforge/gkrellm-bluez/${P}.tar.gz"
HOMEPAGE="http://gkrellm-bluez.sourceforge.net"

RDEPEND="|| ( net-wireless/bluez-libs net-wireless/bluez )"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""
SLOT="0"

PLUGIN_SO="src/.libs/gkrellmbluez.so"
PLUGIN_DOCS="THEMING NEWS"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-notheme.patch || die "Patch failed"
}

src_compile() {
	econf --disable-static || die "Config failed"
	emake || die "Make failed"
}
