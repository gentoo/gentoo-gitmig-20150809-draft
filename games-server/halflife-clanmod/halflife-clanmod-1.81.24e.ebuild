# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/halflife-clanmod/halflife-clanmod-1.81.24e.ebuild,v 1.3 2004/02/20 07:31:48 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="tool for Half-Life mods which helps ease admining a server"
HOMEPAGE="http://www.unitedadmins.com/clanmod.php"
SRC_URI="mirror://sourceforge/clanmod/cm-${PV}-all-mods.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"

RDEPEND="games-server/halflife-metamod"

S=${WORKDIR}/cm-${PV}/addons/clanmod

src_unpack() {
	unpack ${A}
	edos2unix `find -name '*.cfg' -o -name '*.sql' -o -name '*.txt'`
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/halflife/addons/clanmod
	dodir ${dir}
	cp -rf * ${D}/${dir}
	prepgamesdirs
}
