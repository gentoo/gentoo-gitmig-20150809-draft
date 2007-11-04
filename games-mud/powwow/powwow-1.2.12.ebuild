# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/powwow/powwow-1.2.12.ebuild,v 1.1 2007/11/04 20:38:25 tupone Exp $

inherit games

DESCRIPTION="PowWow Console MUD Client"
HOMEPAGE="http://hoopajoo.net/projects/powwow.html"
SRC_URI="http://hoopajoo.net/static/projects/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

src_compile() {
	egamesconf \
		--includedir=/usr/include \
		|| die
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dosym movie "${GAMES_BINDIR}"/movie2ascii
	dosym movie "${GAMES_BINDIR}"/movie_play
	dodoc ChangeLog Config.demo Hacking NEWS README.* TODO
	prepgamesdirs
}
