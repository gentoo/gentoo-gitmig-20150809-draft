# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xboard/xboard-4.2.6-r1.ebuild,v 1.1 2003/09/10 17:46:27 vapier Exp $

inherit games eutils

DESCRIPTION="GUI for gnuchess and for internet chess servers"
HOMEPAGE="http://www.tim-mann.org/xboard.html"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/xboard/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="app-games/gnuchess"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-patch.diff
}

src_install() {
	egamesinstall || die
	dodoc FAQ READ_ME ToDo ChangeLog*
	dohtml FAQ.html
}
