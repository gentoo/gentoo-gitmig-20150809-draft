# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/festival-gaim/festival-gaim-0.78.ebuild,v 1.1 2004/06/15 19:18:04 squinky86 Exp $

inherit eutils

IUSE=""

DESCRIPTION="A plugin for gaim which enables text-to-speech output of conversations using festival."
HOMEPAGE="http://festival-gaim.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"

RDEPEND=">=app-accessibility/festival-1.4.3
	 >=net-im/gaim-0.78"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-0.71-gentoo.patch
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc INSTALL README THANKS
}
