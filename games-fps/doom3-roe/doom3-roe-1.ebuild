# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-roe/doom3-roe-1.ebuild,v 1.1 2006/03/23 00:56:23 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Doom III: Resurrection of Evil expansion pack"
HOMEPAGE="http://www.doom3.com/"
SRC_URI=""

LICENSE="DOOM3"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="nostrip"

DEPEND=""
RDEPEND="games-fps/doom3"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/doom3
Ddir=${D}/${dir}

pkg_setup() {
	games_pkg_setup
	cdrom_get_cds Setup/Data/d3xp/pak000.pk4
}

src_install() {
	insinto "${dir}"/d3xp

	einfo "Copying file from the disk..."
	doins ${CDROM_ROOT}/Setup/Data/d3xp/pak000.pk4 \
		|| die "copying pak000"

	find ${Ddir} -exec touch '{}' \;

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "This is just the data portion of the game.  You will need to emerge"
	einfo "games-fps/doom3 to play the game."
	echo
}
