# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/ngstar/ngstar-2.1.8-r2.ebuild,v 1.1 2006/06/01 20:39:10 tupone Exp $

inherit eutils games

DESCRIPTION="NGStar is a clone of a HP48 game called dstar"
HOMEPAGE="http://cycojesus.free.fr/faire/coder/jouer/ng-star/"
SRC_URI="http://cycojesus.free.fr/faire/coder/jouer/ng-star/files/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gentoo-path.patch
	sed -i \
		-e "s:@GENTOO_DATA@:${GAMES_DATADIR}:" \
		-e "s:@GENTOO_BIN@:${GAMES_BINDIR}:" \
		-e "/^CPPFLAGS/s:+=:+= ${CXXFLAGS}:" \
		configure
}

src_compile() {
	./configure \
		--prefix "" \
		--without-fltk2 || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS Changelog README TODO
	prepgamesdirs
}
