# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/criticalmass/criticalmass-0.98.ebuild,v 1.4 2004/03/02 14:27:38 vapier Exp $

inherit games

DESCRIPTION="SDL/OpenGL space shoot'em up game"
HOMEPAGE="http://criticalmass.sourceforge.net/"
SRC_URI="mirror://sourceforge/criticalmass/CriticalMass-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="media-libs/sdl-mixer
	media-libs/sdl-image
	virtual/opengl"

S=${WORKDIR}/CriticalMass-${PV}

src_compile() {
	egamesconf || die
	sed -i \
		-e "/^CXXFLAGS =.*$/s:$: ${CXXFLAGS}:" \
		{game,puckman,tinyxml,tools,utilities}/Makefile \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dohtml Readme.html
	dodoc TODO
	prepgamesdirs
}
