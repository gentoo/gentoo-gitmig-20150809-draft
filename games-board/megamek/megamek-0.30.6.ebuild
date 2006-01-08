# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/megamek/megamek-0.30.6.ebuild,v 1.1 2006/01/08 17:38:38 mr_bones_ Exp $
# Nonofficial ebuild by Ycarus. For new version look here : http://gentoo.zugaina.org/

inherit eutils games

DESCRIPTION="an unofficial, online version of the Classic BattleTech board game."
HOMEPAGE="http://megamek.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/MegaMek-v${PV}.zip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
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
