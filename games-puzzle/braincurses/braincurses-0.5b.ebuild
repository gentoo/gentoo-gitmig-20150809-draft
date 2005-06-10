# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/braincurses/braincurses-0.5b.ebuild,v 1.2 2005/06/10 13:29:16 dholm Exp $

inherit games

DESCRIPTION="An ncurses-based mastermind clone"
HOMEPAGE="http://freshmeat.net/projects/braincurses/"
SRC_URI="mirror://sourceforge/braincurses/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~ppc64 x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_install() {
	dogamesbin braincurses || die "dogamesbin failed"
	dodoc README THANKS Changelog
	prepgamesdirs
}
