# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/megamek/megamek-0.29.10.ebuild,v 1.2 2005/06/09 08:39:56 dholm Exp $
# Nonofficial ebuild by Ycarus. For new version look here : http://gentoo.zugaina.org/

inherit eutils games

MY_P="MegaMek-v0.29-stable-10"
DESCRIPTION="an unofficial, online version of the Classic BattleTech board game."
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"
HOMEPAGE="http://megamek.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
IUSE=""
RESTRICT="nomirror"

DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}"

src_install() {
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r * || die "Could not copy files"
	games_make_wrapper megamek "java -jar MegaMek.jar" "${GAMES_DATADIR}/${PN}"
	dodoc license.txt readme.txt history.txt ai-readme.txt
	prepgamesdirs
}
