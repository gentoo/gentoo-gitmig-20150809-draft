# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/cultivation/cultivation-7.ebuild,v 1.4 2007/06/12 13:04:43 nyhm Exp $

inherit eutils games

MY_P=Cultivation_${PV}_UnixSource
DESCRIPTION="A game about the interactions within a gardening community"
HOMEPAGE="http://cultivation.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/glut
	media-libs/pablio"

S=${WORKDIR}/${MY_P}/game2/gameSource

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gentoo.patch
	sed -i -e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		../../minorGems/util/TranslationManager.cpp \
		features.cpp \
		game.cpp \
		|| die "sed failed"
}

src_compile() {
	cd ..
	# not an autoconf script
	platformSelection=1 ./configure || die
	cd gameSource
	emake || die "emake failed"
}

src_install() {
	newgamesbin Cultivation ${PN} || die "newgamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r features.txt font.tga language.txt languages || die "doins failed"
	dodoc ../documentation/*.txt
	prepgamesdirs
}
