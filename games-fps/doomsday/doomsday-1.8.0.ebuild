# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doomsday/doomsday-1.8.0.ebuild,v 1.1 2004/07/21 04:24:36 vapier Exp $

inherit games eutils

DESCRIPTION="A modern gaming engine for Doom, Heretic, and Hexen"
HOMEPAGE="http://www.doomsdayhq.com/"
SRC_URI="mirror://sourceforge/deng/deng-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="openal"

DEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-net
	openal? ( media-libs/openal )"

S=${WORKDIR}/deng-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-filename-case.patch
}

src_install() {
	make install DESTDIR=${D} || die "egamesinstall failed"
	rmdir ${D}/${GAMES_PREFIX}/include
	mv ${D}/${GAMES_DATADIR}/{deng/Data/jDoom,doom-data}
	dosym ${GAMES_DATADIR}/doom-data ${GAMES_DATADIR}/deng/Data/jDoom

	local game
	for game in jdoom jheretic jhexen ; do
		newgamesbin ${FILESDIR}/wrapper ${game}
		dosed "s:GAME:${game}:" ${GAMES_BINDIR}/${game}
	done

	dodoc Doc/*.txt Doc/*/*.txt README
	prepgamesdirs
}
