# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/eternal-lands-data/eternal-lands-data-1.8.0.ebuild,v 1.1 2009/01/11 02:37:35 rich0 Exp $

inherit games

MUSIC_DATE="20060803"

MY_PV="${PV//_/}"
MY_PV="${MY_PV//./}"
MY_PN="${PN%*-data}"
DESCRIPTION="An online MMORPG written in C and SDL"
HOMEPAGE="http://www.eternal-lands.com"
SRC_URI="http://www.eternal-lands.com/el_linux_180_install.zip
		music? ( mirror://gentoo/el_music_full-${MUSIC_DATE}.zip )
		sound? ( mirror://gentoo/el_sound_150.zip )"
# WARNING: The music file is held at
# http://www.eternal-lands.com/page/music.php
# We only mirror it so that it is versioned by the date we mirrored it
# AND prefixed with el_ so as not cause any conflicts. Maybe oneday they will
# version their music, maybe not.

LICENSE="eternal_lands"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="music sound"

DEPEND="app-arch/unzip"

# Maybe one day upstream will do things in a consistent way.
S="${WORKDIR}/el_linux"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Move our music files to the correct directory
	if use music ; then
		mkdir music
		mv ../*.ogg ../*.pll music || die
	fi
}

src_install() {
	# These are provided by eternal-lands ebuild

	rm license.txt
	rm commands.lst

	insopts -m 0660
	insinto "${GAMES_DATADIR}/${MY_PN}"
	doins -r 2dobjects 3dobjects actor_defs animations maps meshes \
		particles skeletons textures tiles languages skybox \
		*.lst 3dobjects.txt *.xml \
		|| die "doins failed"

	if use music ; then
		doins -r music || die "doins music failed"
	fi

	# Removed sound from above - need to handle sound support

	cd "${WORKDIR}"
	if use sound ; then
	   doins -r sound || die "doins sound failed"
	fi

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	# Ensure that the files are writable by the game group for auto
	# updating.
	chmod -R g+rw "${ROOT}/${GAMES_DATADIR}/${MY_PN}"

	# Make sure new files stay in games group
	find "${ROOT}/${GAMES_DATADIR}/${MY_PN}" -type d -exec chmod g+sx {} \;
}
