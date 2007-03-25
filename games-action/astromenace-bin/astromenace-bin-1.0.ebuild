# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/astromenace-bin/astromenace-bin-1.0.ebuild,v 1.3 2007/03/25 07:09:52 mr_bones_ Exp $

inherit eutils versionator games

MY_PN=${PN%-bin}
MY_PV=$(delete_all_version_separators)
DL="http://www.viewizard.com/download"

DESCRIPTION="Modern 3D space shooter with spaceship upgrade possibilities"
HOMEPAGE="http://www.viewizard.com/astromenace/index_linux.php"
SRC_URI="linguas_de? ( ${DL}/amenace${MY_PV}_de.tar.bz2 )
	!linguas_de? ( linguas_ru? ( ${DL}/amenace${MY_PV}_ru.tar.bz2 ) )
	!linguas_de? ( !linguas_ru? ( ${DL}/amenace${MY_PV}.tar.bz2 ) )"

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

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}

	# Standardize directory name
	if [[ ! -d ${MY_PN} ]] ; then
		if [[ -d ${MY_PN}_de ]] ; then
			mv ${MY_PN}_de ${MY_PN} || die
		else
			mv ${MY_PN}_ru ${MY_PN} || die
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
	doins -r gamedata.vfs DATA || die "doins failed"

	docinto ${MY_PN}
	dodoc ChangeLog.txt ReadMe.txt

	games_make_wrapper ${MY_PN} "./AstroMenace" "${GAMES_PREFIX_OPT}/${MY_PN}"

	newicon ${MY_PN}_128.png ${MY_PN}.png || die "newicon failed"
	make_desktop_entry ${MY_PN} "Astro Menace" ${MY_PN}.png

	prepgamesdirs
}
