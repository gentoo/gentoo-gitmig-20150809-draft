# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/queen/queen-0.ebuild,v 1.2 2004/03/30 15:45:40 dholm Exp $

inherit games

DESCRIPTION="Flight of the Amazon Queen is a 2D point-and-click adventure game set in the 1940s"
HOMEPAGE="http://scummvm.sourceforge.net/"
SRC_URI="mirror://sourceforge/scummvm/FOTAQ_Talkie.zip"

S="${WORKDIR}/FOTAQ_Talkie"

LICENSE="queen"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=">=games-engines/scummvm-0.6.0"

src_install() {
	games_make_wrapper queen "scummvm -f -p \"${GAMES_DATADIR}/${PN}\" queen" .
	insinto "${GAMES_DATADIR}/${PN}"
	doins queen.1c || die "doins failed"
	dodoc readme.txt
	prepgamesdirs
}
