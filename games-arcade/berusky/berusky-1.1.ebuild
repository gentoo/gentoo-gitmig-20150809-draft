# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/berusky/berusky-1.1.ebuild,v 1.1 2007/08/28 15:31:36 tupone Exp $

inherit autotools eutils games

DATAFILE=${PN}-data-1.0
DESCRIPTION="free logic game based on an ancient puzzle named Sokoban."
HOMEPAGE="http://www.anakreon.cz/en/Berusky.htm"
SRC_URI="http://www.anakreon.cz/download/${PN}/tar.gz/${P}.tar.gz
	http://www.anakreon.cz/download/${PN}/tar.gz/${DATAFILE}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/libsdl"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv ../${DATAFILE}/{berusky.ini,GameData,Graphics,Levels} . \
		|| die "failed moving data"
	epatch "${FILESDIR}"/${P}-gentoo.patch
	sed -i -e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		-e "s:@GENTOO_BINDIR@:${GAMES_BINDIR}:" \
		src/defines.h berusky.ini || die "sed for patching path failed"
	eautoreconf
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r berusky.ini GameData Graphics Levels \
		|| die "failed installing data"
	make_desktop_entry ${PN}
	prepgamesdirs
}
