# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/foosball/foosball-0.92.ebuild,v 1.2 2003/10/25 10:17:17 vapier Exp $

inherit games

DESCRIPTION="foosball game that uses SDL"
HOMEPAGE="http://freshmeat.net/projects/foosball/"
SRC_URI="http://www.autismuk.freeserve.co.uk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="media-libs/libsdl"

src_install() {
	emake install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog README TODO
	prepgamesdirs
}
