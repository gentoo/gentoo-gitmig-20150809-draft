# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-hotkeys/gaim-hotkeys-0.1.2.ebuild,v 1.2 2007/07/11 20:39:22 mr_bones_ Exp $

DESCRIPTION="gaim-hotkeys is a Gaim plugin that allows you to define global hotkeys for various actions such as toggling buddy list, fetching queued messages, opening preferences or account dialog."

HOMEPAGE="http://gaim-hotkeys.sourceforge.net"

SRC_URI="mirror://sourceforge/gaim-hotkeys/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=net-im/gaim-1.0.0"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
