# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doomsday-resources/doomsday-resources-1.01.ebuild,v 1.1 2006/05/31 23:53:06 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Improved models & textures for doomsday"
HOMEPAGE="http://www.doomsdayhq.com/"
SRC_URI="mirror://sourceforge/deng/jdoom-resource-pack-${PV}.zip
	mirror://sourceforge/deng/jdoom-details.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="games-fps/doomsday"

S=${WORKDIR}

src_install() {
	insinto /usr/share/games/deng/Data/jDoom/Auto/
	doins data/jDoom/* *.pk3

	# The definitions file cannot be auto-loaded
	insinto /usr/share/games/deng/Defs/jDoom/
	doins defs/jDoom/*

	dodoc *.txt docs/*

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	# Must specify full path to .ded file
	einfo "Add the following to the jdoom/doomsday command-line options:"
	einfo "  -def /usr/share/games/deng/Defs/jDoom/jDRP.ded"
	echo
}
