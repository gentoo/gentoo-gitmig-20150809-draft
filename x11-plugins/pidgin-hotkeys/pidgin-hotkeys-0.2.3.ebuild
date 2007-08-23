# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-hotkeys/pidgin-hotkeys-0.2.3.ebuild,v 1.3 2007/08/23 15:49:15 jer Exp $

DESCRIPTION="pidgin-hotkeys is a Gaim plugin that allows you to define global hotkeys for various actions such as toggling buddy list, fetching queued messages, opening preferences or account dialog."

HOMEPAGE="http://gaim-hotkeys.sourceforge.net"

SRC_URI="mirror://sourceforge/gaim-hotkeys/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 hppa ~x86"
IUSE=""

DEPEND="net-im/pidgin"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
