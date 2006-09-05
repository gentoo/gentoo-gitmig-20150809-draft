# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doomsday/doomsday-1.9.0_beta4-r1.ebuild,v 1.1 2006/09/05 18:39:56 tupone Exp $

inherit eutils games

MY_PV=${PV/_/-}
DESCRIPTION="A modern gaming engine for Doom, Heretic, and Hexen"
HOMEPAGE="http://www.doomsdayhq.com/"
SRC_URI="mirror://sourceforge/deng/deng-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="openal"

DEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-net
	media-libs/libpng
	|| ( x11-libs/libXext virtual/x11 )
	openal? ( media-libs/openal )"

S=${WORKDIR}/deng-${MY_PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-music-driver.patch \
		"${FILESDIR}"/${P}-configure.patch
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	rmdir "${D}/${GAMES_PREFIX}/include"
	mv "${D}/${GAMES_DATADIR}/"{deng/Data/jDoom,doom-data}
	dosym "${GAMES_DATADIR}"/doom-data "${GAMES_DATADIR}"/deng/Data/jDoom

	local game
	for game in jdoom jheretic jhexen ; do
		newgamesbin "${FILESDIR}"/wrapper ${game}
		sed -i \
			-e "s:GAME:${game}:" "${D}"/${GAMES_BINDIR}/${game} \
			|| die "sed ${GAMES_BINDIR}/${game} failed"
	done

	# Make wrappers for the common wads
	for n in doom doom2 ; do
		games_make_wrapper ${PN}-${n} "jdoom -file ${GAMES_DATADIR}/doom-data/${n}.wad"
	done

	dodoc Doc/*.txt Doc/*/*.txt README
	prepgamesdirs
}

pkg_postinst() {
	einfo "To play the original Doom levels, place doom.wad and/or doom2.wad"
	einfo "into ${GAMES_DATADIR}/doom-data"
	einfo "Then run doomsday-doom or doomsday-doom2 accordingly."
	einfo
	einfo "doom1.wad is the shareware demo wad consisting of 1 episode,"
	einfo "and doom.wad is the full Doom 1 set of 3 episodes"
	einfo "(or 4 in the Final Doom wad)."
	einfo
	einfo "You can even emerge doom-data and/or freedoom, with the doomsday use"
	einfo "flag enabled, to play for free"

	games_pkg_postinst
}
