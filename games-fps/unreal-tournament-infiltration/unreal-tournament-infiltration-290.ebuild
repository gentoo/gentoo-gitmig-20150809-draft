# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/unreal-tournament-infiltration/unreal-tournament-infiltration-290.ebuild,v 1.1 2004/02/22 01:41:07 vapier Exp $

inherit games

DESCRIPTION="Realistic mod for Unreal Tournament"
HOMEPAGE="http://infiltration.sentrystudios.net/"
SRC_URI="infiltration${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
RESTRICT="nofetch"

DEPEND="app-arch/unzip
	|| ( games-fps/unreal-tournament games-fps/unreal-tournament-goty )"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please visit the following site and download ${A}"
	einfo "http://files.worthplaying.com/files/modules.php?name=Downloads&d_op=viewdownload&cid=604"
	einfo "Then just place the file in ${DISTDIR}"
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/unreal-tournament
	dodir ${dir}
	cp -r ${S}/* ${D}/${dir}/
	dogamesbin ${FILESDIR}/ut-inf
	prepgamesdirs
}
