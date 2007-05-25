# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/megamek/megamek-0.32.0.ebuild,v 1.3 2007/05/25 20:22:17 betelgeuse Exp $

inherit java-pkg-2 java-ant-2 games

DESCRIPTION="an unofficial, online version of the Classic BattleTech board game"
HOMEPAGE="http://megamek.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/MegaMek-v${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.5
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.5"

S=${WORKDIR}

pkg_setup() {
	games_pkg_setup
	java-pkg-2_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -v *.jar || die
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
	dodoc HACKING readme.txt docs/*txt || die
	prepgamesdirs
}
