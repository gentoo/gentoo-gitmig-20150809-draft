# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/amoebax/amoebax-0.2.0.ebuild,v 1.3 2008/05/04 20:53:49 nyhm Exp $

inherit autotools eutils games

DESCRIPTION="a cute and addictive action-puzzle game, similar to tetris"
HOMEPAGE="http://www.emma-soft.com/games/amoebax/"
SRC_URI="http://www.emma-soft.com/games/amoebax/download/${P}.tar.bz2"

LICENSE="FreeArt GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
	sed -i \
		-e "/^SUBDIRS/s:doc ::" \
		Makefile.am \
		|| die "sed failed"
	sed -i \
		-e "/^iconsdir/s:=.*:=/usr/share/pixmaps:" \
		-e "/^desktopdir/s:=.*:=/usr/share/applications:" \
		data/Makefile.am \
		|| die "sed failed"
	AT_M4DIR=m4 eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README TODO
	prepgamesdirs
}
