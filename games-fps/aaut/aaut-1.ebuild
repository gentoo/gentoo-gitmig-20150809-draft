# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/aaut/aaut-1.ebuild,v 1.1 2003/09/09 18:10:14 vapier Exp $

inherit games

DESCRIPTION="ascii mode unreal tournament"
HOMEPAGE="http://icculus.org/~chunky/ut/aaut/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="|| ( app-games/unreal-tournament app-games/unreal-tournament-goty )
	media-libs/aalib"

src_install() {
	dogamesbin ${FILESDIR}/aaut
	prepgamesdirs
}
