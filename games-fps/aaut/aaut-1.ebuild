# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/aaut/aaut-1.ebuild,v 1.3 2004/02/20 06:40:06 mr_bones_ Exp $

inherit games

DESCRIPTION="ascii mode unreal tournament"
HOMEPAGE="http://icculus.org/~chunky/ut/aaut/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="|| ( games-fps/unreal-tournament games-fps/unreal-tournament-goty )
	media-libs/aalib"

src_install() {
	dogamesbin ${FILESDIR}/aaut
	prepgamesdirs
}
