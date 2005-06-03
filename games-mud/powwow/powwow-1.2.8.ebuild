# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/powwow/powwow-1.2.8.ebuild,v 1.1 2005/06/03 05:16:29 mr_bones_ Exp $

inherit toolchain-funcs eutils games

DESCRIPTION="PowWow Console MUD Client"
HOMEPAGE="http://hoopajoo.net/projects/powwow.html"
SRC_URI="http://hoopajoo.net/static/projects/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}"/${PV}-copyfile.patch
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dosym movie "${GAMES_BINDIR}/movie2ascii"
	dosym movie "${GAMES_BINDIR}/movie_play"
	dodoc ChangeLog Config.demo Hacking NEWS README.* TODO
	prepgamesdirs
}
