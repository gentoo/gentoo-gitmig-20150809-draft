# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/festival-gaim/festival-gaim-0.71.ebuild,v 1.1 2004/03/21 20:57:29 eradicator Exp $

inherit eutils

DESCRIPTION="A plugin for gaim which enables text-to-speech output of conversations using festival."
HOMEPAGE="http://festival-gaim.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=app-accessibility/festival-1.4.3
	 >=net-im/gaim-0.71"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc INSTALL README THANKS
}
