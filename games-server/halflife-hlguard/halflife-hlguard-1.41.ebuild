# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/halflife-hlguard/halflife-hlguard-1.41.ebuild,v 1.6 2004/11/03 13:47:25 vapier Exp $

inherit games eutils

DESCRIPTION="server-side anti-cheat solution for Half-Life and it's many MODs"
HOMEPAGE="http://www.unitedadmins.com/hlguard.php"
SRC_URI="http://www.unitedadmins.com/files/hlg-${PV/./_}-en.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

RDEPEND="games-server/halflife-metamod"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/addons/hlguard

src_unpack() {
	unpack ${A}
	edos2unix `find -name '*.txt' -o -name '*.cfg'`
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/halflife/addons/hlguard
	dodir ${dir}
	mv * ${D}/${dir}/
	dodoc ${WORKDIR}/hlg_readme.txt
	prepgamesdirs
}
