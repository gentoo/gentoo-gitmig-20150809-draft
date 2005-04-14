# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/sdlsasteroids/sdlsasteroids-3.0.1.ebuild,v 1.1 2005/04/14 17:57:28 mr_bones_ Exp $

inherit games

DESCRIPTION="Rework of Sasteroids using SDL"
HOMEPAGE="http://sdlsas.sourceforge.net/"
SRC_URI="mirror://sourceforge/sdlsas/SDLSasteroids-${PV}.tar.gz"

LICENSE="GPL-2 freedist"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="virtual/libc
	virtual/opengl
	>=media-libs/sdl-mixer-1.2.0
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-ttf"

S=${WORKDIR}/SDLSasteroids-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
		#-e '34 d' \
	sed -i \
		-e 's/make /$(MAKE) /' Makefile \
			|| die "sed Makefile failed"
}

src_compile() {
	emake \
		GAMEDIR="${GAMES_DATADIR}/${PN}" \
		OPTS="${CXXFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dodir /usr/share/man/man6/
	make \
		GAMEDIR="${D}/${GAMES_DATADIR}/${PN}" \
		BINDIR="${D}/${GAMES_BINDIR}" \
		MANDIR="${D}/usr/share/man/" \
		install || die "make install failed"
	dodoc ChangeLog README README.xast TODO description
	prepgamesdirs
}
