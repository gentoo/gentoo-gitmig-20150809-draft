# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/freedoom/freedoom-1.0.ebuild,v 1.1 2003/09/09 18:10:14 vapier Exp $

inherit games

DESCRIPTION="Freedoom - Open Source Doom resources"
HOMEPAGE="http://freedoom.sourceforge.net/"
SRC_URI="mirror://sourceforge/freedoom/doom1.wad.gz
	mirror://sourceforge/freedoom/doom2.wad.gz
	mirror://sourceforge/freedoom/freedoom.wad.gz
	mirror://sourceforge/freedoom/freedoom_graphics.wad.gz
	mirror://sourceforge/freedoom/freedoom_levels.wad.gz
	mirror://sourceforge/freedoom/freedoom_sounds.wad.gz
	mirror://sourceforge/freedoom/freedoom_sprites.wad.gz
	mirror://sourceforge/freedoom/freedoom_textures.wad.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

DEPEND=""

S=${WORKDIR}

src_install() {
	insinto ${GAMES_DATADIR}/freedoom
	doins *.wad
	prepgamesdirs
}
