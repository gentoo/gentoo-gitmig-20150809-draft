# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/halflife-hlguard/halflife-hlguard-1.50.02.ebuild,v 1.4 2004/02/20 07:31:48 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="server-side anti-cheat solution for Half-Life and it's many MODs"
HOMEPAGE="http://www.unitedadmins.com/hlguard.php"
SRC_URI="http://www.unitedadmins.com/files/hlg-${PV//./_}-en.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"

RDEPEND="games-server/halflife-metamod
	games-server/halflife-modsetup"

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
	exeinto ${dir}
	doexe ${FILESDIR}/modsetup
	dosed "s:GENTOO_CFGDIR:${GAMES_SYSCONFDIR}/halflife:" ${dir}/modsetup
	prepgamesdirs
}
