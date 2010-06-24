# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/rogue/rogue-5.4.4.ebuild,v 1.2 2010/06/24 21:17:54 pacho Exp $

EAPI=2
inherit games

MY_P=${PN}${PV}
DESCRIPTION="The original graphical adventure game that spawned an entire genre"
HOMEPAGE="http://rogue.rogueforge.net/"
SRC_URI="http://rogue.rogueforge.net/files/rogue5.4/${MY_P}-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"

S=${WORKDIR}/${MY_P}

src_configure() {
	egamesconf \
		--enable-scorefile="${GAMES_STATEDIR}/${PN}/${PN}.scr" \
		--docdir=/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install || die
	prepgamesdirs
}
