# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freecol/freecol-0.5.1.ebuild,v 1.1 2006/10/08 01:34:31 tupone Exp $

inherit eutils games

DESCRIPTION="An open source clone of the game Colonization"
HOMEPAGE="http://www.freecol.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

KEYWORDS="~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.4.1"

S=${WORKDIR}/${PN}

pkg_setup() {
	games_pkg_setup
	if [ -z "${JAVA_HOME}" ]; then
		einfo
		einfo "\${JAVA_HOME} not set!"
		einfo "Please use java-config to configure your JVM and try again."
		einfo
		die "\${JAVA_HOME} not set."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	rm FreeCol.jar

	sed -i \
		-e '/saveDirectory/s/freecol/.freecol/' \
		src/net/sf/freecol/FreeCol.java \
		|| die "sed failed"

	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	ant || die "ant failed"
}

src_install () {
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r FreeCol.jar data/ jars/ || die "doins failed"

	games_make_wrapper ${PN} \
		"java -Xmx256M -jar FreeCol.jar $1 $2 $3 $4 $5 $6 $7 $8 $9" \
		"${GAMES_DATADIR}"/${PN}

	dodoc README
	doicon ${PN}.xpm
	make_desktop_entry ${PN} "FreeCol" ${PN}.xpm
	prepgamesdirs
}
