# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doomsday/doomsday-1.9.0_beta52.ebuild,v 1.3 2007/12/05 16:27:18 mr_bones_ Exp $

inherit toolchain-funcs games

MY_P=deng-1.9.0-beta5.2 # FIXME, this is stupid
DESCRIPTION="A modern gaming engine for Doom, Heretic, and Hexen"
HOMEPAGE="http://www.doomsdayhq.com/"
SRC_URI="mirror://sourceforge/deng/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="openal"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-net
	media-libs/libpng
	openal? ( media-libs/openal )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.5
	app-arch/zip"

S=${WORKDIR}/${MY_P}/${MY_P}/build

src_compile() {
	cmake \
		-DCMAKE_C_COMPILER=$(type -P $(tc-getCC)) \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-Ddatadir="${GAMES_DATADIR}"/${PN} \
		-Dbindir="${GAMES_BINDIR}" \
		-Dlibdir="$(games_get_libdir)" \
		$(use openal && echo -DBUILDOPENAL=1) \
		../ || die "cmake failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	mv "${D}/${GAMES_DATADIR}"/{${PN}/data/jdoom,doom-data} || die
	dosym "${GAMES_DATADIR}"/doom-data "${GAMES_DATADIR}"/${PN}/data/jdoom || die

	local game
	for game in jdoom jheretic jhexen ; do
		newgamesbin "${FILESDIR}"/wrapper ${game}
		sed -i "s:GAME:${game}:" \
			"${D}/${GAMES_BINDIR}"/${game} \
			|| die "sed ${GAMES_BINDIR}/${game} failed"
	done

	# Make wrappers for the common wads
	local n
	for n in doom doom2 ; do
		games_make_wrapper ${PN}-${n} \
			"jdoom -file \"${GAMES_DATADIR}\"/doom-data/${n}.wad"
	done

	doman ../engine/doc/${PN}.6
	dodoc ../engine/doc/*.txt README
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "To play the original Doom levels, place doom.wad and/or doom2.wad"
	elog "into ${GAMES_DATADIR}/doom-data"
	elog "Then run doomsday-doom or doomsday-doom2 accordingly."
	elog
	elog "doom1.wad is the shareware demo wad consisting of 1 episode,"
	elog "and doom.wad is the full Doom 1 set of 3 episodes"
	elog "(or 4 in the Final Doom wad)."
	elog
	elog "You can even emerge doom-data and/or freedoom, with the doomsday use"
	elog "flag enabled, to play for free"
}
