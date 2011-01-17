# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/eternal-lands-data/eternal-lands-data-1.9.1_p20110117.ebuild,v 1.1 2011/01/17 19:58:33 rich0 Exp $

inherit games

MUSIC_DATE="20060803"

MY_PV="${PV//_/}"
MY_PV="${MY_PV//./}"
MY_PN="${PN%*-data}"
DESCRIPTION="An online MMORPG written in C and SDL"
HOMEPAGE="http://www.eternal-lands.com"
SRC_URI="http://www.eternal-lands.com/el_linux_191.zip
		music? ( mirror://gentoo/el_music_full-${MUSIC_DATE}.zip )
		sound? ( http://www.eternal-lands.com/sound/EL_sound_191.zip )"
# WARNING: The music file is held at
# http://www.eternal-lands.com/page/music.php
# We only mirror it so that it is versioned by the date we mirrored it
# AND prefixed with el_ so as not cause any conflicts. Maybe oneday they will
# version their music, maybe not.

LICENSE="eternal_lands"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="music sound bloodsuckermaps"

DEPEND="app-arch/unzip
		!bloodsuckermaps? ( !games-rpg/eternal-lands-bloodsucker )"

PDEPEND="bloodsuckermaps? ( games-rpg/eternal-lands-bloodsucker )"

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

	# don't install maps if using alternate maps
	if use bloodsuckermaps ; then
		rm maps/anitora.bmp maps/cave1.bmp maps/cont2map10.bmp
		rm maps/cont2map11.bmp maps/cont2map12.bmp maps/cont2map13.bmp
		rm maps/cont2map14.bmp maps/cont2map15.bmp maps/cont2map16.bmp
		rm maps/cont2map17.bmp maps/cont2map18.bmp maps/cont2map19.bmp
		rm maps/cont2map1.bmp maps/cont2map20.bmp maps/cont2map21.bmp
		rm maps/cont2map22.bmp maps/cont2map23.bmp maps/cont2map24.bmp
		rm maps/cont2map2.bmp maps/cont2map3.bmp maps/cont2map4.bmp
		rm maps/cont2map5.bmp maps/cont2map6.bmp maps/cont2map7.bmp
		rm maps/cont2map8.bmp maps/cont2map9.bmp maps/irilion.bmp
		rm maps/legend.bmp maps/map11.bmp maps/map12.bmp
		rm maps/map13.bmp maps/map14f.bmp maps/map15f.bmp
		rm maps/map2.bmp maps/map3.bmp maps/map4f.bmp
		rm maps/map5nf.bmp maps/map6nf.bmp maps/map7.bmp
		rm maps/map8.bmp maps/map9f.bmp maps/seridia.bmp
		rm maps/startmap.bmp
	fi

	insopts -m 0660
	insinto "${GAMES_DATADIR}/${MY_PN}"
	doins -r 2dobjects 3dobjects actor_defs animations maps meshes \
		particles skeletons shaders textures languages shaders skybox \
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
