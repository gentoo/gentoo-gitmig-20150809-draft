# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/ivan/ivan-0.430.ebuild,v 1.4 2004/03/15 17:28:08 dholm Exp $

inherit games

DESCRIPTION="Rogue-like game with SDL graphics"
HOMEPAGE="http://ivan.sourceforge.net/"
SRC_URI="mirror://sourceforge/ivan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND=">=media-libs/libsdl-1.2.0"

src_install() {
	egamesinstall || die
	dodoc AUTHORS ChangeLog LICENSING NEWS README
	prepgamesdirs
	fperms g+w ${GAMES_STATEDIR}/ivan/Bones
}
