# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/trigger/trigger-0.5.0.ebuild,v 1.1 2004/10/20 07:59:57 mr_bones_ Exp $

inherit games

PSOURCE="${P}-src"
PDATA="${P}-data"
DESCRIPTION="Trigger is a free OpenGL rally car racing game. Suports 3D-stereo-views"
HOMEPAGE="http://www.positro.net/trigger/"
SRC_URI="http://files.scapecaster.com/posit/${PSOURCE}.tar.bz2
	http://files.scapecaster.com/posit/${PDATA}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/x11
	virtual/opengl
	>=media-libs/libsdl-1.2.5
	>=media-libs/sdl-image-1.2
	media-libs/openal
	dev-games/physfs"
DEPEND="${RDEPEND}
	dev-util/jam"

S="${WORKDIR}/${PSOURCE}"

src_compile() {
	./autogen.sh || die "autogen failed"
	egamesconf \
		--datadir="${GAMES_DATADIR}/${PN}" \
		|| die
	jam || "jam failed"
}

src_install() {
	dogamesbin trigger || die "dogamesbin failed"

	dodir "${GAMES_DATADIR}/${PN}"
	cp -r ../${PDATA}/{events,maps,plugins,sounds,textures,vehicles,trigger.config.defs} \
		"${D}${GAMES_DATADIR}/${PN}" \
		|| die "cp failed"

	dodoc ../${PDATA}/{README.txt,README-stereo.txt}
	prepgamesdirs
}
