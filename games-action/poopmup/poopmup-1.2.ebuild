# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/poopmup/poopmup-1.2.ebuild,v 1.2 2004/02/20 06:13:57 mr_bones_ Exp $

inherit games

DESCRIPTION="You are now free to fly around the city and poop on passers-by"
HOMEPAGE="http://poopmup.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glut
	virtual/x11
	virtual/opengl"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}/includes
	cp textureLoader.h{,.orig}
	sed -e "s:textures/:${GAMES_DATADIR}/${PN}/:" \
		textureLoader.h.orig > textureLoader.h
	cd ${S}
	cp myConfig.h{,.orig}
	sed -e "s:config/:${GAMES_SYSCONFDIR}/:" \
		myConfig.h.orig > myConfig.h
}

src_compile() {
	emake CC="${CXX:-g++} ${CFLAGS}" || die
}

src_install() {
	rm -rf `find -name CVS`

	newgamesbin poopmup.o poopmup

	insinto ${GAMES_DATADIR}/${PN}
	doins textures/*

	insinto ${GAMES_SYSCONFDIR}
	doins config/*

	dodoc README docs/*.doc
	dohtml docs/userman.htm

	prepgamesdirs
}
