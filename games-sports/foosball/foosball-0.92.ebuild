# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/foosball/foosball-0.92.ebuild,v 1.5 2004/06/24 23:24:30 agriffis Exp $

inherit games

DESCRIPTION="foosball game that uses SDL"
HOMEPAGE="http://freshmeat.net/projects/foosball/"
SRC_URI="http://www.autismuk.freeserve.co.uk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="media-libs/libsdl"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
	prepgamesdirs
}
