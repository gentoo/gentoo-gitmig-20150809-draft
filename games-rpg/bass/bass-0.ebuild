# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/bass/bass-0.ebuild,v 1.6 2004/06/24 23:14:58 agriffis Exp $

inherit games

DESCRIPTION="Beneath a Steel Sky: a science fiction thriller set in a bleak vision of the future"
HOMEPAGE="http://www.revgames.com/"
SRC_URI="mirror://sourceforge/scummvm/BASS-CD.zip"

LICENSE="bass"
SLOT="0"
KEYWORDS="x86 ppc amd64 ~sparc"
IUSE=""

DEPEND=">=games-engines/scummvm-0.5.0"

S="${WORKDIR}/sky-cd"

src_install() {
	games_make_wrapper bass "scummvm -f -p \"${GAMES_DATADIR}/${PN}\" sky" .
	insinto ${GAMES_DATADIR}/${PN}
	doins sky.* || die "doins failed"
	dodoc readme.txt
	prepgamesdirs
}
