# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/triplea/triplea-0.9.0.2.ebuild,v 1.3 2007/02/16 00:48:18 nyhm Exp $

inherit eutils java-pkg-2 java-ant-2 versionator games

MY_PV=$(replace_all_version_separators _)
DESCRIPTION="An open source clone of the popular Axis and Allies boardgame"
HOMEPAGE="http://triplea.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${MY_PV}_source_code_only.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="=dev-java/jgoodies-looks-2*
	=dev-java/commons-httpclient-3*
	dev-java/commons-logging
	dev-java/commons-codec"
DEPEND="${RDEPEND}
	>=virtual/jdk-1.5
	dev-java/ant
	app-arch/unzip"
RDEPEND="${RDEPEND}
	>=virtual/jre-1.5"

S=${WORKDIR}/${PN}_${MY_PV}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e 's/getWindows/getMyWindows/' \
		src/games/strategy/debug/Console.java \
		|| die "sed Console.java failed"

	sed -i \
		-e 's:/triplea/:/.triplea/:' \
		src/games/strategy/engine/framework/ui/SaveGameFileChooser.java \
		|| die "sed SaveGameFileChooser.java failed"

	rm -f lib/{junit.jar,derby_10_1_2.jar}
	java-pkg_jar-from jgoodies-looks-2.0 looks.jar lib/looks-2.0.4.jar
	java-pkg_jar-from commons-httpclient-3 commons-httpclient.jar \
		lib/commons-httpclient-3.0.1.jar
	java-pkg_jar-from commons-logging commons-logging.jar \
		lib/commons-logging-1.1.jar
	java-pkg_jar-from commons-codec commons-codec.jar \
		lib/commons-codec-1.3.jar
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
