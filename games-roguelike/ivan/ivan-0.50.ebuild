# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/ivan/ivan-0.50.ebuild,v 1.2 2005/11/27 02:01:11 mr_bones_ Exp $

inherit games

DESCRIPTION="Rogue-like game with SDL graphics"
HOMEPAGE="http://ivan.sourceforge.net/"
SRC_URI="mirror://sourceforge/ivan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.0"

src_install() {
	egamesinstall || die
	dodoc AUTHORS ChangeLog LICENSING NEWS README
	keepdir "${GAMES_STATEDIR}/ivan/Bones"
	prepgamesdirs
	fperms g+w "${GAMES_STATEDIR}/ivan/Bones"
}
