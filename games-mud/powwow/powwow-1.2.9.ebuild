# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/powwow/powwow-1.2.9.ebuild,v 1.1 2005/11/14 07:20:40 mr_bones_ Exp $

inherit games

DESCRIPTION="PowWow Console MUD Client"
HOMEPAGE="http://hoopajoo.net/projects/powwow.html"
SRC_URI="http://hoopajoo.net/static/projects/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dosym movie "${GAMES_BINDIR}/movie2ascii"
	dosym movie "${GAMES_BINDIR}/movie_play"
	dodoc ChangeLog Config.demo Hacking NEWS README.* TODO
	prepgamesdirs
}
