# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xboard/xboard-4.2.7.ebuild,v 1.1 2004/01/05 05:01:43 vapier Exp $

inherit games eutils

DESCRIPTION="GUI for gnuchess and for internet chess servers"
HOMEPAGE="http://www.tim-mann.org/xboard.html"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/xboard/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="games-board/gnuchess"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-default-program.patch
}

src_install() {
	egamesinstall || die
	dodoc FAQ READ_ME ToDo ChangeLog*
	dohtml FAQ.html
	prepgamesdirs
}
