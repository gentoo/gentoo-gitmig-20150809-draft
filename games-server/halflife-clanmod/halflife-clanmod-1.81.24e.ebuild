# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/halflife-clanmod/halflife-clanmod-1.81.24e.ebuild,v 1.6 2004/11/03 00:31:47 vapier Exp $

inherit games eutils

DESCRIPTION="tool for Half-Life mods which helps ease admining a server"
HOMEPAGE="http://www.unitedadmins.com/clanmod.php"
SRC_URI="mirror://sourceforge/clanmod/cm-${PV}-all-mods.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

RDEPEND="games-server/halflife-metamod"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/cm-${PV}/addons/clanmod"

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
