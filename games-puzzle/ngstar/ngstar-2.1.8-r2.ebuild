# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/ngstar/ngstar-2.1.8-r2.ebuild,v 1.7 2010/09/10 07:43:03 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="NGStar is a clone of a HP48 game called dstar"
HOMEPAGE="http://cycojesus.free.fr/faire/coder/jouer/ng-star/"
SRC_URI="http://cycojesus.free.fr/faire/coder/jouer/ng-star/files/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="sys-libs/ncurses
	sys-libs/gpm"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gentoo-path.patch \
		"${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-ldflags.patch
	sed -i \
		-e "s:@GENTOO_DATA@:${GAMES_DATADIR}:" \
		-e "s:@GENTOO_BIN@:${GAMES_BINDIR}:" \
		-e "/^CPPFLAGS/s:+=:+= ${CXXFLAGS}:" \
		-e "/SILENT/d" \
		configure || die "sed configure failed"
}

src_configure() {
	./configure \
		--prefix "" \
		--without-fltk2 || die "configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS Changelog README TODO
	prepgamesdirs
}
