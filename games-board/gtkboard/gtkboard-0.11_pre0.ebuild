# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gtkboard/gtkboard-0.11_pre0.ebuild,v 1.1 2004/01/05 04:20:15 vapier Exp $

inherit games

MY_P=${P/_}
DESCRIPTION="Board games system"
HOMEPAGE="http://gtkboard.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkboard/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=x11-libs/gtk+-2"

S=${WORKDIR}/${MY_P}

src_compile() {
	egamesconf --datadir=${GAMES_DATADIR}/${PN} || die
	emake || die
}

src_install() {
	emake install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog TODO
	dohtml doc/index.html
	prepgamesdirs
}
