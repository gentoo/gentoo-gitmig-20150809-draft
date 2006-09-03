# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/eternal-lands-data/eternal-lands-data-1.3.2.ebuild,v 1.1 2006/09/03 17:00:40 uberlord Exp $

inherit games

MUSIC_DATE="20060803"

MY_PV="${PV//_/}"
MY_PV="${MY_PV//./}"
MY_PN="${PN%*-data}"
DESCRIPTION="An online MMORPG written in C and SDL"
HOMEPAGE="http://www.eternal-lands.com"
SRC_URI="http://www.other-life.com/el/el_${MY_PV}_linux_full.zip
		music? ( mirror://gentoo/el_music_full-${MUSIC_DATE}.zip )"
# WARNING: The music file is held at
# http://www.eternal-lands.com/page/music.php
# We only mirror it so that it is versioned by the date we mirrored it
# AND prefixed with el_ so as not cause any conflicts. Maybe oneday they will
# version their music, maybe not.

LICENSE="eternal_lands"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="music"

DEPEND="app-arch/unzip
	sys-apps/findutils"

src_unpack() {
	cd "${WORKDIR}"
	unpack ${A}

	# Remove CVS entries
	find . -type d -name CVS -exec rm -rf {} \; 2>/dev/null

	# Move our music files to the correct directory
	use music && mv *.ogg *.pll music
}

src_install() {
	cd "${WORKDIR}"

	# These are provided by eternal-lands ebuild
	rm license.txt

	insopts -m 0660
	insinto "${GAMES_DATADIR}/${MY_PN}"
	doins -r 2dobjects 3dobjects actor_defs animations maps meshes music \
		particles skeletons sound textures tiles languages \
		*.lst 3dobjects.txt *.xml \
		|| die "doins failed"

	prepgamesdirs
}

pkg_postinst() {
	# Ensure that the files are writable by the game group for auto
	# updating.
	chmod -R g+rw "${ROOT}/${GAMES_DATADIR}/${MY_PN}"

	# Make sure new files stay in games group
	find "${ROOT}/${GAMES_DATADIR}/${MY_PN}" -type d -exec chmod g+sx {} \;
}
