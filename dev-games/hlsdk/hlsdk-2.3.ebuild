# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/hlsdk/hlsdk-2.3.ebuild,v 1.1 2003/07/13 03:13:40 vapier Exp $

inherit games

DESCRIPTION="Half-Life Software Development Kit for mod authors"
HOMEPAGE="http://www.valvesoftware.com/hlsdk.htm"
SRC_URI="http://www.metamod.org/files/sdk/${P}.tgz"

LICENSE="ValveSDK"
SLOT="0"
KEYWORDS="x86"

S=${WORKDIR}/${P}

src_compile() {
	find -iname '*.orig' -exec rm -f '{}' \;
}

src_install() {
	dodir ${GAMES_LIBDIR}/${PN}
	mv multiplayer singleplayer ${D}/${GAMES_LIBDIR}/${PN}/
	dodoc metamod.hlsdk-2.3.txt metamod.hlsdk-2.3.patch
	prepgamesdirs
}
