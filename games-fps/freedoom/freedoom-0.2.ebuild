# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/freedoom/freedoom-0.2.ebuild,v 1.3 2004/11/03 00:20:22 vapier Exp $

inherit games

DESCRIPTION="Freedoom - Open Source Doom resources"
HOMEPAGE="http://freedoom.sourceforge.net/"
SRC_URI="mirror://sourceforge/freedoom/doom1.zip
	mirror://sourceforge/freedoom/doom2.zip
	mirror://sourceforge/freedoom/freedoom.zip
	mirror://sourceforge/freedoom/freedoom_graphics.zip
	mirror://sourceforge/freedoom/freedoom_levels.zip
	mirror://sourceforge/freedoom/freedoom_sounds.zip
	mirror://sourceforge/freedoom/freedoom_sprites.zip
	mirror://sourceforge/freedoom/freedoom_textures.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

RDEPEND="!games-fps/doom-data"
DEPEND="app-arch/unzip"

src_install() {
	insinto ${GAMES_DATADIR}/doom-data
	doins *.wad || die
	dodoc CREDITS ChangeLog NEWS README
	prepgamesdirs
}
