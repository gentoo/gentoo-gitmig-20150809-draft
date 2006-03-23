# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/megamek/megamek-0.30.9.ebuild,v 1.1 2006/03/23 21:39:38 tupone Exp $

inherit eutils games

DESCRIPTION="an unofficial, online version of the Classic BattleTech board game."
HOMEPAGE="http://megamek.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/MegaMek-v${PV}.zip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}

src_install() {
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r * || die "Could not copy files"
	games_make_wrapper megamek "java -jar MegaMek.jar" "${GAMES_DATADIR}/${PN}"
	dodoc HACKING license.txt readme.txt docs/*txt
	prepgamesdirs
}
