# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xboard/xboard-4.2.7.ebuild,v 1.2 2004/02/05 22:22:10 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="GUI for gnuchess and for internet chess servers"
HOMEPAGE="http://www.tim-mann.org/xboard.html"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/xboard/${P}.tar.gz"

KEYWORDS="x86 ppc alpha"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="games-board/gnuchess"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-default-program.patch
}

src_install() {
	egamesinstall || die
	dodoc FAQ READ_ME ToDo ChangeLog* || die "dodoc failed"
	dohtml FAQ.html || die "dohtml failed"
	prepgamesdirs
}
