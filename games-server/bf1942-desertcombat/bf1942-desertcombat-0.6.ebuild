# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/bf1942-desertcombat/bf1942-desertcombat-0.6.ebuild,v 1.2 2004/01/01 16:54:51 mholzer Exp $

inherit games

DESCRIPTION="modern day military modification for BattleField 1942"
HOMEPAGE="http://www.desertcombat.com/"
SRC_URI="desertcombat_0.5l-beta_full_install.tar.bz2
	desertcombat_0.6_server_patch.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="fetch"

DEPEND="games-server/bf1942-lnxded"

S=${WORKDIR}/Mods

pkg_nofetch() {
	einfo "Please visit download ${A} from:"
	einfo "http://www.fileplanet.com/files/130000/132779.shtml"
	einfo "http://www.fileplanet.com/dl.aspx?/planetbattlefield/news/desertcombat_0.6_server_patch.tar.bz2"
	einfo "Then put the files in ${DISTDIR}"
}

src_unpack() {
	mkdir Mods
	cd Mods
	unpack desertcombat_0.5l-beta_full_install.tar.bz2
	cd ..
	unpack dsertcombat_0.6_server_patch.tar.bz2
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/bf1942/mods
	dodir ${dir}
	mv * ${D}/${dir}/
	prepgamesdirs
}
