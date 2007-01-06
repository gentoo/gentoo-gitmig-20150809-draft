# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/eternal-lands-data/eternal-lands-data-1.3.3.ebuild,v 1.1 2007/01/06 12:36:19 uberlord Exp $

inherit games

MUSIC_DATE="20060803"

MY_PV="${PV//_/}"
MY_PV="${MY_PV//./}"
MY_PN="${PN%*-data}"
DESCRIPTION="An online MMORPG written in C and SDL"
HOMEPAGE="http://www.eternal-lands.com"
SRC_URI="http://el.other-life.com/downloads/el_${MY_PV}_linux_full.zip
		music? ( mirror://gentoo/el_music_full-${MUSIC_DATE}.zip )"
# WARNING: The music file is held at
# http://www.eternal-lands.com/page/music.php
# We only mirror it so that it is versioned by the date we mirrored it
# AND prefixed with el_ so as not cause any conflicts. Maybe oneday they will
# version their music, maybe not.

LICENSE="eternal_lands"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="music"

DEPEND="app-arch/unzip"

# Maybe one day upstream will do things in a consistent way.
S="${WORKDIR}/Eternal Lands-1.33"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Move our music files to the correct directory
	use music && mv ../*.ogg ../*.pll music || die
}

src_install() {
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
