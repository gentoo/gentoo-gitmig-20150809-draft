# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/cultivation/cultivation-7.ebuild,v 1.1 2007/05/17 20:11:01 tupone Exp $

inherit eutils flag-o-matic games

MY_P=Cultivation_${PV}_UnixSource

DESCRIPTION="A game about the interactions within a gardening community."
HOMEPAGE="http://cultivation.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/glut
	media-libs/pablio"

S="${WORKDIR}/${MY_P}/game2/gameSource"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gentoo.patch
	sed -i -e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		../../minorGems/util/TranslationManager.cpp \
		features.cpp \
		game.cpp || die "Changing data path failed"
}

src_compile() {
	cd ..
	platformSelection=1 ./configure
	cd gameSource
	emake || die "emake failed"
}

src_install() {
	dogamesbin Cultivation || die "Installing binary failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r features.txt font.tga language.txt languages \
		|| die "doins languages failed"
	cd ../documentation
	dodoc how_to_*.txt changeLog.txt

	prepgamesdirs
}
