# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/sdlsasteroids/sdlsasteroids-3.0.ebuild,v 1.3 2004/02/20 06:20:00 mr_bones_ Exp $

inherit games

DESCRIPTION="Rework of Sasteroids using SDL"
HOMEPAGE="http://sdlsas.sourceforge.net/"
SRC_URI="mirror://sourceforge/sdlsas/sasteroids-${PV}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2 freedist"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=media-libs/sdl-mixer-1.2.0
	media-libs/sdl-ttf"

S=${WORKDIR}/SDLSasteroids-${PV}

src_compile() {
	make \
		GAMEDIR=${GAMES_DATADIR}/${PN} \
		OPTS="${CFLAGS}" \
		|| die
}

src_install() {
	dodir /usr/share/man/man6/
	make \
		GAMEDIR=${D}/${GAMES_DATADIR}/${PN} \
		BINDIR=${D}/${GAMES_BINDIR} \
		MANDIR=${D}/usr/share/man/ \
		install || die
	dodoc ChangeLog README README.xast TODO description
	prepgamesdirs
}
