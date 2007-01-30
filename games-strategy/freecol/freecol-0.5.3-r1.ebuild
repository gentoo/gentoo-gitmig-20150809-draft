# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freecol/freecol-0.5.3-r1.ebuild,v 1.3 2007/01/30 00:55:32 caster Exp $

inherit eutils java-pkg-2 java-ant-2 games

DESCRIPTION="An open source clone of the game Colonization"
HOMEPAGE="http://www.freecol.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-java/higlayout"
DEPEND="${RDEPEND}
	>=virtual/jdk-1.6
	dev-java/ant"
RDEPEND="${RDEPEND}
	>=virtual/jre-1.6"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -rf FreeCol.jar src/classes jars/*

	epatch \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-home.patch

	sed -i "/Class-Path/s:jars/.*$:$(java-pkg_getjars higlayout):" \
		src/MANIFEST.MF \
		|| die "sed failed"

	cd jars
	java-pkg_jar-from higlayout
}

src_compile() {
	eant
}

src_install () {
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data || die "doins failed"

	java-pkg_jarinto "${GAMES_DATADIR}"/${PN}
	java-pkg_dojar FreeCol.jar

	java-pkg_dolauncher ${PN} \
		-into "${GAMES_PREFIX}" \
		--pwd "${GAMES_DATADIR}"/${PN} \
		--java_args -Xmx512M

	dodoc README
	doicon ${PN}.xpm
	make_desktop_entry ${PN} FreeCol ${PN}.xpm
	prepgamesdirs
}
