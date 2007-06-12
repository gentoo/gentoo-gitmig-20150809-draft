# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/ngstar/ngstar-2.1.8-r2.ebuild,v 1.4 2007/06/12 01:12:26 nyhm Exp $

inherit eutils games

DESCRIPTION="NGStar is a clone of a HP48 game called dstar"
HOMEPAGE="http://cycojesus.free.fr/faire/coder/jouer/ng-star/"
SRC_URI="http://cycojesus.free.fr/faire/coder/jouer/ng-star/files/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="sys-libs/ncurses
	sys-libs/gpm"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gentoo-path.patch
	sed -i \
		-e "s:@GENTOO_DATA@:${GAMES_DATADIR}:" \
		-e "s:@GENTOO_BIN@:${GAMES_BINDIR}:" \
		-e "/^CPPFLAGS/s:+=:+= ${CXXFLAGS}:" \
		configure || die "sed configure failed"
	sed -i '/strip/d' src/Makefile || die "sed makefile failed"
}

src_compile() {
	./configure \
		--prefix "" \
		--without-fltk2 || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS Changelog README TODO
	prepgamesdirs
}
