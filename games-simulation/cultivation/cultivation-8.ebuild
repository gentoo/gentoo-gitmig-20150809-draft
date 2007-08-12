# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/cultivation/cultivation-8.ebuild,v 1.1 2007/08/12 01:21:30 nyhm Exp $

inherit eutils toolchain-funcs games

MY_P=Cultivation_${PV}_UnixSource
DESCRIPTION="A game about the interactions within a gardening community"
HOMEPAGE="http://cultivation.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	virtual/glut
	media-libs/pablio"

S=${WORKDIR}/${MY_P}/game2

src_unpack() {
	unpack ${A}
	cd ${MY_P}
	rm -rf minorGems/sound/portaudio
	epatch \
		"${FILESDIR}"/${P}-portaudio.patch \
		"${FILESDIR}"/${P}-paths.patch
	sed -i "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		game2/gameSource/features.cpp \
		game2/gameSource/game.cpp \
		minorGems/util/TranslationManager.cpp \
		|| die "sed failed"
}

src_compile() {
	# not an autoconf script
	platformSelection=1 ./configure || die
	tc-export CXX
	emake -C gameSource || die "emake failed"
}

src_install() {
	cd gameSource
	newgamesbin Cultivation ${PN} || die "newgamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r features.txt font.tga language.txt languages || die "doins failed"
	dodoc ../documentation/*.txt
	prepgamesdirs
}
