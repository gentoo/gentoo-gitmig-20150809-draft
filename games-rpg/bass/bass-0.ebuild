# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/bass/bass-0.ebuild,v 1.7 2004/11/03 00:30:08 vapier Exp $

inherit games

DESCRIPTION="Beneath a Steel Sky: a science fiction thriller set in a bleak vision of the future"
HOMEPAGE="http://www.revgames.com/"
SRC_URI="mirror://sourceforge/scummvm/BASS-CD.zip"

LICENSE="bass"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

RDEPEND=">=games-engines/scummvm-0.5.0"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/sky-cd"

src_install() {
	games_make_wrapper bass "scummvm -f -p \"${GAMES_DATADIR}/${PN}\" sky" .
	insinto ${GAMES_DATADIR}/${PN}
	doins sky.* || die "doins failed"
	dodoc readme.txt
	prepgamesdirs
}
