# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/criticalmass/criticalmass-0.99.ebuild,v 1.1 2004/03/19 00:59:43 wolf31o2 Exp $

inherit games

DESCRIPTION="SDL/OpenGL space shoot'em up game"
HOMEPAGE="http://criticalmass.sourceforge.net/"
SRC_URI="mirror://sourceforge/criticalmass/CriticalMass-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-libs/sdl-mixer
	media-libs/sdl-image
	virtual/opengl"

S=${WORKDIR}/CriticalMass-${PV}

src_compile() {
	egamesconf || die
	sed -i \
		-e "/^CXXFLAGS =.*$/s:$: ${CXXFLAGS}:" \
		{game,tinyxml,tools,utils}/Makefile \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dohtml Readme.html
	dodoc TODO
	prepgamesdirs
}
