# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xboard/xboard-4.2.7.ebuild,v 1.4 2004/03/02 14:14:53 vapier Exp $

inherit eutils games

DESCRIPTION="GUI for gnuchess and for internet chess servers"
HOMEPAGE="http://www.tim-mann.org/xboard.html"
SRC_URI="mirror://gnu/xboard/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha amd64"
IUSE=""

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
