# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/criticalmass/criticalmass-0.98.ebuild,v 1.3 2004/02/20 06:20:00 mr_bones_ Exp $

inherit games

DESCRIPTION="SDL/OpenGL space shoot'em up game"
HOMEPAGE="http://criticalmass.sourceforge.net/"
SRC_URI="mirror://sourceforge/criticalmass/CriticalMass-${PV}.tar.bz2"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="media-libs/sdl-mixer
	media-libs/sdl-image
	virtual/opengl"

S=${WORKDIR}/CriticalMass-${PV}

src_compile() {
	egamesconf || die
	for d in game puckman tinyxml tools utilities ; do
		cp ${d}/Makefile{,.orig}
		sed -e "/^CXXFLAGS =.*$/s:$: ${CXXFLAGS}:" \
			${d}/Makefile.orig > ${d}/Makefile
	done
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dohtml Readme.html
	dodoc TODO
	prepgamesdirs
}
