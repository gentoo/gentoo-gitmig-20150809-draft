# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/fakenes/fakenes-0.3.0.ebuild,v 1.3 2004/02/20 06:26:47 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="portable, Open Source NES emulator which is written mostly in C"
HOMEPAGE="http://fakenes.sourceforge.net/"
SRC_URI="mirror://sourceforge/fakenes/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="zlib fbcon svga"

DEPEND=">=media-libs/allegro-4.1
	zlib? ( sys-libs/zlib )
	dev-games/hawknl
	x86? ( dev-lang/nasm )"

src_unpack() {
	unpack ${A}
	cd ${S}
	chmod a+x configure
	epatch ${FILESDIR}/${PV}-allegro.patch
	[ ! `use fbcon` ] && sed -i '/sedfbme/s:.*::' src/gui.c src/include/gui/menus.h
	[ ! `use svga` ] && sed -i '/sedsvgalibme/s:.*::' src/gui.c src/include/gui/menus.h
}

src_compile() {
	egamesconf `use_with zlib` || die
	emake || die
}

src_install() {
	dogamesbin src/fakenes
	insinto ${GAMES_DATADIR}/${PN}
	doins src/support/fakenes.{dat,ico,rc}
	dodoc CHANGES README SOURCE SUPPORT
	prepgamesdirs
}
