# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/pauker/pauker-1.7.5-r1.ebuild,v 1.1 2008/01/25 21:32:07 robbat2 Exp $

EAPI=1
inherit eutils java-pkg-2 games

DESCRIPTION="A java based flashcard program"
HOMEPAGE="http://pauker.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.src.jar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-java/browserlauncher2
	dev-java/lucene:2.1
	dev-java/javahelp
	dev-java/swing-layout"
DEPEND="${RDEPEND}
	app-arch/unzip
	>=virtual/jdk-1.4"
RDEPEND="${RDEPEND}
	>=virtual/jre-1.4"

S=${WORKDIR}

pkg_setup() {
	games_pkg_setup
	java-pkg-2_pkg_setup
}

src_compile() {
	local cp
	cp=$(java-pkg_getjars browserlauncher2-1.0,lucene-2.1,javahelp,swing-layout-1)

	mkdir -p classes
	ejavac -d classes -cp classes:${cp} $(find . -name '*.java')

	jar cf ${PN}.jar -C classes . || die "jar failed"
}

src_install() {
	java-pkg_jarinto "${GAMES_DATADIR}"/${PN}
	java-pkg_dojar ${PN}.jar

	java-pkg_dolauncher ${PN} \
		-into "${GAMES_PREFIX}" \
		--pwd "${GAMES_DATADIR}"/${PN} \
		--main pauker.program.gui.swing.PaukerFrame

	cd ${PN}
	insinto "${GAMES_DATADIR}"/${PN}/${PN}
	doins -r help icons sounds *.txt *.html Strings* || die "doins failed"

	prepgamesdirs
}
