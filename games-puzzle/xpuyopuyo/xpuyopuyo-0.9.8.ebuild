# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xpuyopuyo/xpuyopuyo-0.9.8.ebuild,v 1.1 2007/03/04 01:33:22 tupone Exp $

inherit games

DESCRIPTION="A Tetris-like game with opponent"
HOMEPAGE="http://chaos2.org/xpuyopuyo/"
SRC_URI="http://chaos2.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	x11-libs/libXpm
	media-libs/libmikmod"

src_compile() {
	egamesconf --with-gnome \
		--enable-aibreed \
		--enable-network || die "econf failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make failed"
	dodoc AUTHORS ChangeLog README TODO
	doicon ${PN}.xpm
	make_desktop_entry ${PN} ${PN} ${PN}.xpm
	prepgamesdirs
}
