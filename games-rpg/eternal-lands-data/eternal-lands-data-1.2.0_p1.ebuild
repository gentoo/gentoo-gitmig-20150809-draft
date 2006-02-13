# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/eternal-lands-data/eternal-lands-data-1.2.0_p1.ebuild,v 1.2 2006/02/13 21:17:23 uberlord Exp $

inherit games

MY_PV="${PV//_/}"
MY_PV="${MY_PV//./}"
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

DEPEND="app-arch/unzip"

src_unpack() {
	cd "${WORKDIR}"
	unpack ${A}
	use music && mv *.ogg *.pll music
}

src_install() {
	cd "${WORKDIR}"

	# These are provided by eternal-lands ebuild
	rm mapinfo.lst license.txt

	insinto "${GAMES_DATADIR}/${PN%*-data}"
	doins -r 2dobjects 3dobjects animations maps meshes music particles \
		skeletons sound textures tiles \
		*.lst 3dobjects.txt \
		|| die "doins failed"

	prepgamesdirs
}
