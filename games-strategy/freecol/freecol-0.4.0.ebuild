# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freecol/freecol-0.4.0.ebuild,v 1.1 2005/06/24 04:21:32 mr_bones_ Exp $

inherit games

DESCRIPTION="An open source clone of the game Colonization"
HOMEPAGE="http://freecol.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV}-src.tar.gz"

KEYWORDS="~ppc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.4.1"

S=${WORKDIR}/${PN}

pkg_setup() {
	if [ -z "$JAVA_HOME" ]; then
		einfo
		einfo "\$JAVA_HOME not set!"
		einfo "Please use java-config to configure your JVM and try again."
		einfo
		die "\$JAVA_HOME not set."
	fi
	games_pkg_setup
}

src_unpack() {
	unpack ${A}

	echo "#!/bin/sh" > "${T}/${PN}"
	echo "\"\${JAVA_HOME}\"/bin/java -Xmx128M -jar '${GAMES_DATADIR}/${PN}/FreeCol.jar' --freecol-data '${GAMES_DATADIR}/${PN}/data'" >> "${T}/${PN}"

	find "${S}/data/" -type f -exec chmod a-x \{\} \;
}

src_compile() {
	ant -Dnojars=true -Dnodata=true || die "ant failed"
}

src_install () {
	dogamesbin "${T}/${PN}" || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r FreeCol.jar data/ jars/ || die "doins failed"
	dodoc README
	prepgamesdirs
}
