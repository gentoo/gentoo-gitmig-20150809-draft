# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/sdlsasteriods/sdlsasteriods-1.99.ebuild,v 1.1 2003/09/10 19:29:21 vapier Exp $

inherit games

MY_P="SDLSasteroids-${PV}"
DESCRIPTION="Rework of Sasteroids using SDL"
SRC_URI="mirror://sourceforge/sdlsas/${MY_P}.tar.gz"
HOMEPAGE="http://sdlsas.sourceforge.net/"

KEYWORDS="x86"
LICENSE="GPL-2 freedist"
SLOT="0"

DEPEND=">=media-libs/sdl-mixer-1.2.0"

S=${WORKDIR}/${MY_P}

src_compile() {
	make GAMEDIR=${GAMES_DATADIR}/${PN} || die
}

src_install() {
	dodir /usr/share/man/man6/
	make \
		GAMEDIR=${D}/${GAMES_DATADIR}/${PN} \
		BINDIR=${D}/${GAMES_BINDIR} \
		MANDIR=${D}/usr/share/man/ \
		install || die
	dodoc ChangeLog README README.xast
	prepgamesdirs
}
