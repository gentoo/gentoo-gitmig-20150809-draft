# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/megamek/megamek-0.32.0.ebuild,v 1.1 2006/10/17 21:57:48 nyhm Exp $

inherit java-ant-2 java-pkg-2 games

DESCRIPTION="an unofficial, online version of the Classic BattleTech board game"
HOMEPAGE="http://megamek.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/MegaMek-v${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.5
	dev-java/ant
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.5"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f *.jar
	sed -i \
		-e "s:/usr/share/java:${GAMES_DATADIR}/${PN}:" \
		-e "s:/usr/share/MegaMek:${GAMES_DATADIR}/${PN}:" \
		startup.sh || die "sed failed"
}

src_compile() {
	eant || die
}

src_install() {
	newgamesbin startup.sh ${PN} || die "newgamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data l10n lib mmconf *.jar || die "doins failed"
	dodoc HACKING readme.txt docs/*txt
	prepgamesdirs
}
