# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/poopmup/poopmup-1.2.ebuild,v 1.13 2006/08/21 07:03:41 mr_bones_ Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="You are now free to fly around the city and poop on passers-by"
HOMEPAGE="http://poopmup.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="virtual/glut
	|| ( ( x11-libs/libXi
			x11-libs/libXmu )
		virtual/x11 )
	virtual/opengl"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:textures/:${GAMES_DATADIR}/${PN}/:" \
		includes/textureLoader.h || die "sed failed"
	sed -i \
		-e "s:config/:${GAMES_SYSCONFDIR}/:" \
		myConfig.h || die "sed failed"
	sed -i \
		-e '/clear/d' \
		Makefile || die "sed failed" # bug #120907

	epatch "${FILESDIR}/${P}-freeglut.patch"
	rm -rf $(find -name CVS)
}

src_compile() {
	emake CC="$(tc-getCXX) ${CFLAGS}" || die "emake failed"
}

src_install() {
	newgamesbin poopmup.o poopmup || die "newgamesbin failed"

	insinto "${GAMES_DATADIR}/${PN}"
	doins textures/* || die "doins failed"

	insinto "${GAMES_SYSCONFDIR}"
	doins config/* || die "doins failed"

	dodoc README docs/*.doc
	dohtml docs/userman.htm

	prepgamesdirs
}
