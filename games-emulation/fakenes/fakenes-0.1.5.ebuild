# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/fakenes/fakenes-0.1.5.ebuild,v 1.2 2004/02/20 06:26:47 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="portable, Open Source NES emulator which is written mostly in C"
HOMEPAGE="http://fakenes.sourceforge.net/"
SRC_URI="mirror://sourceforge/fakenes/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="X gnome"

DEPEND="media-libs/allegro
	sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/${PV}-datadir.patch
	sed -i "s:GENTOO_DIR:${GAMES_DATADIR}/${PN}:" main.c
}

src_compile() {
	egamesconf || die
	make || die
}

src_install() {
	dogamesbin src/fakenes
	insinto ${GAMES_DATADIR}/${PN}
	doins src/support/fakenes.{dat,ico,rc}
	dodoc CHANGES README SOURCE SUPPORT
}
