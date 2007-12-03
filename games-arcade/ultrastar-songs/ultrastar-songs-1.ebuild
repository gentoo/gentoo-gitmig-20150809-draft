# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/ultrastar-songs/ultrastar-songs-1.ebuild,v 1.1 2007/12/03 21:08:34 tupone Exp $

inherit games

DESCRIPTION="UltraStar series songs pack"
HOMEPAGE="http://sourceforge.net/projects/ultrastar-ng/"
SRC_URI="mirror://sourceforge/ultrastar-ng/${P}.tar.bz2"

LICENSE="CCPL-Attribution-NonCommercial-NoDerivs-2.5
	CCPL-Attribution-ShareAlike-NonCommercial-2.5"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	insinto "${GAMES_DATADIR}"/ultrastar-ng
	doins -r songs
	prepgamesdirs
}
