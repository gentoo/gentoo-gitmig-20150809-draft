# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/triplea/triplea-0.8.2.2.ebuild,v 1.2 2006/12/24 18:36:43 nyhm Exp $

inherit eutils java-ant-2 java-pkg-2 versionator games

MY_PV=$(replace_all_version_separators _)
DESCRIPTION="An open source clone of the popular Axis and Allies boardgame"
HOMEPAGE="http://triplea.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${MY_PV}_source_code_only.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5
	=dev-java/jgoodies-looks-1.3*"
DEPEND="${RDEPEND}
	>=virtual/jdk-1.5
	dev-java/ant
	app-arch/unzip"

S=${WORKDIR}/${PN}_${MY_PV}

src_unpack() {
	unpack ${A}
	cd "${S}"

	rm lib/*.jar
	java-pkg_jar-from jgoodies-looks-1.3 looks.jar lib/looks-1.3.1.jar
	java-pkg_ensure-no-bundled-jars
}

src_compile() {
	eant || die
	echo "triplea.saveGamesInHomeDir=true" > classes/triplea.properties
}

src_install() {
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r classes data games images maps || die "doins failed"

	java-pkg_addcp "${GAMES_DATADIR}"/${PN}/classes
	java-pkg_dolauncher ${PN} -into "${GAMES_PREFIX}" --main \
		games.strategy.engine.framework.GameRunner

	newicon icons/triplea_icon.bmp ${PN}.bmp
	make_desktop_entry ${PN} TripleA /usr/share/pixmaps/${PN}.bmp

	dodoc changelog.txt
	dohtml -r doc/* readme.html
	prepgamesdirs
}
