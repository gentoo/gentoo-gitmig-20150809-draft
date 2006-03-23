# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-data/doom3-data-1.1.1282-r1.ebuild,v 1.1 2006/03/23 00:53:56 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Doom III - data portion"
HOMEPAGE="http://www.doom3.com/"
SRC_URI=""

LICENSE="DOOM3"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
RESTRICT="nostrip"

DEPEND="app-arch/bzip2
	app-arch/tar"
RDEPEND="games-fps/doom3"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/doom3
Ddir=${D}/${dir}

pkg_setup() {
	games_pkg_setup
	cdrom_get_cds Setup/Data/base/pak002.pk4 \
		Setup/Data/base/pak000.pk4 \
		Setup/Data/base/pak003.pk4
}

src_install() {
	insinto "${dir}"/base

	einfo "Copying files from Disk 1..."
	doins ${CDROM_ROOT}/Setup/Data/base/pak002.pk4 \
		|| die "copying pak002"
	cdrom_load_next_cd
	einfo "Copying files from Disk 2..."
	doins ${CDROM_ROOT}/Setup/Data/base/pak00{0,1}.pk4 \
		|| die "copying pak000 and pak001"
	cdrom_load_next_cd
	einfo "Copying files from Disk 3..."
	doins ${CDROM_ROOT}/Setup/Data/base/pak00{3,4}.pk4 \
		|| die "copying pak003 and pak004"

	find ${Ddir} -exec touch '{}' \;

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "This is just the data portion of the game.  You will need to emerge"
	einfo "games-fps/doom3 to play the game."
	echo
}
