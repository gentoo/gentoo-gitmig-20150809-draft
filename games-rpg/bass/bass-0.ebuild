# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/bass/bass-0.ebuild,v 1.3 2004/02/28 01:55:25 vapier Exp $

inherit games

DESCRIPTION="Beneath a Steel Sky: a science fiction thriller set in a bleak vision of the future"
HOMEPAGE="http://www.revgames.com/"
SRC_URI="mirror://sourceforge/scummvm/BASS-CD.zip"

LICENSE="bass"
SLOT="0"
KEYWORDS="x86 ppc amd64"

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
