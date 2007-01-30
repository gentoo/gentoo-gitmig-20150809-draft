# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freecol/freecol-0.5.3.ebuild,v 1.2 2007/01/30 00:55:32 caster Exp $

inherit eutils java-pkg-2 java-ant-2 games

DESCRIPTION="An open source clone of the game Colonization"
HOMEPAGE="http://www.freecol.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5
	dev-java/ant"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	rm -f FreeCol.jar

	sed -i \
		-e '/saveDirectory/s/freecol/.freecol/' \
		src/net/sf/freecol/FreeCol.java \
		|| die "sed failed"

	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	eant || die
}

src_install () {
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r FreeCol.jar data/ jars/ || die "doins failed"

	games_make_wrapper ${PN} "java -Xmx512M -jar FreeCol.jar" \
		"${GAMES_DATADIR}"/${PN}

	dodoc README
	doicon ${PN}.xpm
	make_desktop_entry ${PN} FreeCol ${PN}.xpm
	prepgamesdirs
}
