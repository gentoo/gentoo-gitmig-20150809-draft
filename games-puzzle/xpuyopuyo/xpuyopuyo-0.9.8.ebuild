# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xpuyopuyo/xpuyopuyo-0.9.8.ebuild,v 1.5 2009/02/11 08:39:43 tupone Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A Tetris-like game with opponent"
HOMEPAGE="http://chaos2.org/xpuyopuyo/"
SRC_URI="http://chaos2.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	x11-libs/libXpm
	media-libs/libmikmod"

src_prepare() {
	epatch "${FILESDIR}"/${P}-as-needed.patch
}

src_configure() {
	egamesconf \
		--with-gnome \
		--enable-aibreed \
		--enable-network \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO
	doicon ${PN}.xpm
	make_desktop_entry ${PN} ${PN} ${PN}
	prepgamesdirs
}
