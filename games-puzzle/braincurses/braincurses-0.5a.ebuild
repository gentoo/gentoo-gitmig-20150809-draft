# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/braincurses/braincurses-0.5a.ebuild,v 1.1 2004/12/02 10:03:17 mr_bones_ Exp $

inherit games

DESCRIPTION="An ncurses-based mastermind clone"
HOMEPAGE="http://freshmeat.net/projects/braincurses/"
SRC_URI="http://uhaweb.hartford.edu/hyland/derr/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="sys-libs/ncurses"

S="${WORKDIR}/${PN}"

src_install() {
	dogamesbin braincurses || die "dogamesbin failed"
	dodoc README THANKS Changelog
	prepgamesdirs
}
