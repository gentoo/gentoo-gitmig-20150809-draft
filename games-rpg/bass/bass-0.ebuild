# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/bass/bass-0.ebuild,v 1.2 2004/01/13 06:11:32 spider Exp $

inherit games

DESCRIPTION="Beneath a Steel Sky: a science fiction thriller set in a bleak vision of the future"
HOMEPAGE="http://www.revgames.com/"
SRC_URI="mirror://sourceforge/scummvm/BASS-CD.zip"

LICENSE="bass"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND=">=games-engines/scummvm-0.5.0"

S=${WORKDIR}/sky-cd

src_install() {
	insinto ${GAMES_DATADIR}/${PN}
	doins sky.*
	dodoc readme.txt
	dogamesbin ${FILESDIR}/bass
	dosed "s:GENTOO_DIR:${GAMES_DATADIR}/${PN}:" ${GAMES_BINDIR}/bass
	prepgamesdirs
}
