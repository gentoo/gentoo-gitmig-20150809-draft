# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/poopmup/poopmup-1.2.ebuild,v 1.4 2004/03/16 16:03:39 vapier Exp $

inherit games gcc

DESCRIPTION="You are now free to fly around the city and poop on passers-by"
HOMEPAGE="http://poopmup.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/glut
	virtual/x11
	virtual/opengl"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:textures/:${GAMES_DATADIR}/${PN}/:" \
		includes/textureLoader.h || die
	sed -i \
		-e "s:config/:${GAMES_SYSCONFDIR}/:" \
		myConfig.h || die
}

src_compile() {
	emake CC="$(gcc-getCXX) ${CFLAGS}" || die
}

src_install() {
	rm -rf `find -name CVS`

	newgamesbin poopmup.o poopmup || die

	insinto ${GAMES_DATADIR}/${PN}
	doins textures/*

	insinto ${GAMES_SYSCONFDIR}
	doins config/*

	dodoc README docs/*.doc
	dohtml docs/userman.htm

	prepgamesdirs
}
