# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/ngstar/ngstar-2.1.8.ebuild,v 1.1 2006/04/11 23:24:16 tupone Exp $

inherit games

DESCRIPTION="NGStar is a clone of a HP48 game called dstar"
HOMEPAGE="http://cycojesus.free.fr/faire/coder/jouer/ng-star/"
SRC_URI="http://cycojesus.free.fr/faire/coder/jouer/ng-star/files/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	./configure \
		--prefix "${GAMES_PREFIX}" \
		--without-fltk2 || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	egamesinstall
	dodoc AUTHORS Changelog README TODO
	prepgamesdirs
}
