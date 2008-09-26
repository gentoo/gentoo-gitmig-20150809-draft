# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-data/doom3-data-1.1.1282-r1.ebuild,v 1.5 2008/09/26 17:57:58 zmedico Exp $

inherit eutils games

DESCRIPTION="Doom III - data portion"
HOMEPAGE="http://www.doom3.com/"
SRC_URI=""

LICENSE="DOOM3"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
PROPERTIES="interactive"
RESTRICT="strip"

DEPEND="app-arch/bzip2
	app-arch/tar"
RDEPEND="games-fps/doom3"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/doom3
Ddir=${D}/${dir}

src_install() {
	cdrom_get_cds Setup/Data/base/pak002.pk4 \
		Setup/Data/base/pak000.pk4 \
		Setup/Data/base/pak003.pk4
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
	elog "This is just the data portion of the game.  You will need to emerge"
	elog "games-fps/doom3 to play the game."
	echo
}
