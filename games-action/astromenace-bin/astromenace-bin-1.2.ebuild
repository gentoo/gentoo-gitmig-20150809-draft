# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/astromenace-bin/astromenace-bin-1.2.ebuild,v 1.2 2007/08/28 22:16:34 mr_bones_ Exp $

inherit eutils versionator games

MY_PN=amenace
MY_PV=$(delete_all_version_separators)
MY_P=${MY_PN}${MY_PV}
DL="http://www.viewizard.com/download"

DESCRIPTION="Modern 3D space shooter with spaceship upgrade possibilities"
HOMEPAGE="http://www.viewizard.com/astromenace/index_linux.php"
SRC_URI="linguas_de? ( ${DL}/${MY_P}_lin_de.tar.bz2 )
	!linguas_de? ( linguas_ru? ( ${DL}/${MY_P}_lin_ru.tar.bz2 ) )
	!linguas_de? ( !linguas_ru? ( ${DL}/${MY_P}_lin_en.tar.bz2 ) )"

LICENSE="astromenace"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="linguas_de linguas_ru"
RESTRICT="strip"

RDEPEND="
	virtual/glu
	virtual/opengl
	>=media-libs/freealut-1.0.1
	>=media-libs/jpeg-6b
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXrandr
	x11-libs/libXrender
	media-libs/libmikmod
	>=media-libs/openal-0.0.8
	>=media-libs/sdl-image-1.2.4
	>=media-libs/libsdl-1.2.6
	>=media-libs/libogg-1.1
	>=media-libs/libvorbis-1.1"

S=${WORKDIR}/${MY_P}_lin_en

src_unpack() {
	unpack ${A}

	# Standardize directory name
	if [[ ! -d ${S} ]] ; then
		if [[ -d ${MY_P}_lin_de ]] ; then
			mv ${MY_P}_lin_de ${S} || die
		else
			mv ${MY_P}_lin_ru ${S} || die
		fi
	fi
}

src_install() {
	exeinto "${GAMES_PREFIX_OPT}/${MY_PN}"
	if use amd64; then
		newexe AstroMenace64 AstroMenace || die "newexe failed"
	else
		doexe AstroMenace || die "doexe failed"
	fi
	insinto "${GAMES_PREFIX_OPT}/${MY_PN}"
	doins -r *.vfs DATA || die "doins failed"

	games_make_wrapper ${MY_PN} "./AstroMenace" "${GAMES_PREFIX_OPT}/${MY_PN}"
	make_desktop_entry ${MY_PN} "Astro Menace"
	prepgamesdirs
}
