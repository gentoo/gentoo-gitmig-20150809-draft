# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/unreal-tournament-infiltration/unreal-tournament-infiltration-286.ebuild,v 1.4 2004/06/24 22:48:32 agriffis Exp $

inherit games

INFFILE="Infiltration${PV}-MAN.zip"
INFMAPS="INFMapPacks123FULL-MAN.zip"

DESCRIPTION="Realistic mod for Unreal Tournament"
HOMEPAGE="http://infiltration.sentrystudios.net/"
SRC_URI="ftp://inffilemirror.theonlinegaming.com/INF286/Full-Zipped/${INFFILE}
	ftp://inffilemirror.theonlinegaming.com/MapPacks/MapPackFull123/Full-Zipped/${INFMAPS}"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

DEPEND="app-arch/unzip
	|| ( games-fps/unreal-tournament games-fps/unreal-tournament-goty )"

S=${WORKDIR}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/unreal-tournament
	dodir ${dir}

	mv ${S}/* ${D}/${dir}/

	insinto ${dir}/System
	[ -e ${dir}/System/Infiltration.ini ] \
		&& newins ${FILESDIR}/Infiltration.ini Infiltration.ini.sample \
		|| doins ${FILESDIR}/Infiltration.ini

	dogamesbin ${FILESDIR}/ut-inf

	prepgamesdirs
}

pkg_postinst() {
	touch ${GAMES_PREFIX_OPT}/unreal-tournament/System/Infiltration.ini
	games_pkg_postinst
}
