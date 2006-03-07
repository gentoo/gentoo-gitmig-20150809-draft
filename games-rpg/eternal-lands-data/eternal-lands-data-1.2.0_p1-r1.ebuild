# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/eternal-lands-data/eternal-lands-data-1.2.0_p1-r1.ebuild,v 1.1 2006/03/07 08:22:51 uberlord Exp $

inherit games

MY_PV="${PV//_/}"
MY_PV="${MY_PV//./}"
MY_PN="${PN%*-data}"
DESCRIPTION="An online MMORPG written in C and SDL"
HOMEPAGE="http://www.eternal-lands.com"
SRC_URI="http://www.other-life.com/el/el_${MY_PV}_linux_full.zip
		music? ( mirror://gentoo/el_music_${MY_PV}.zip )"
# WARNING: The music file is held at
# http://www.other-life.com/downloads/music.zip
# We only mirror it so that it is versioned AND prefixed with el_ so as not
# cause any conflicts.

LICENSE="eternal_lands"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="music"

DEPEND="app-arch/unzip
	sys-apps/findutils"

src_unpack() {
	cd "${WORKDIR}"
	unpack ${A}
	use music && mv *.ogg *.pll music

	# This file has the wrong name, #125302
	mv 3dobjects/misc_objects/stonebrick1.E3D \
		3dobjects/misc_objects/stonebrick1.e3d
}

src_install() {
	cd "${WORKDIR}"

	# These are provided by eternal-lands ebuild
	rm mapinfo.lst license.txt

	insinto "${GAMES_DATADIR}/${MY_PN}"
	doins -r 2dobjects 3dobjects animations maps meshes music particles \
		skeletons sound textures tiles \
		*.lst 3dobjects.txt \
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
