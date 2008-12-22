# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/alienarena/alienarena-20081016.ebuild,v 1.1 2008/12/22 17:20:30 nyhm Exp $

inherit eutils toolchain-funcs games

MY_PN=${PN}${PV:0:4}
DESCRIPTION="Fast-paced multiplayer deathmatch game"
HOMEPAGE="http://red.planetarena.org/"
SRC_URI="http://icculus.org/${PN}/Files/${MY_PN}-linux${PV}.zip"

LICENSE="GPL-2 free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated opengl sdl"

UIRDEPEND="media-libs/jpeg
	virtual/glu
	virtual/opengl
	x11-libs/libXxf86dga
	x11-libs/libXxf86vm
	sdl? ( media-libs/libsdl )"
RDEPEND="opengl? ( ${UIRDEPEND} )
	!opengl? ( !dedicated? ( ${UIRDEPEND} ) )
	net-misc/curl"
UIDEPEND="x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto"
DEPEND="${RDEPEND}
	opengl? ( ${UIDEPEND} )
	!opengl? ( !dedicated? ( ${UIDEPEND} ) )
	app-arch/unzip"

S=${WORKDIR}/source

src_unpack() {
	unpack ${A}
	rm -f */*.so
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		OPTIMIZED_CFLAGS=no \
		WITH_DATADIR=yes \
		WITH_LIBDIR=yes \
		DATADIR="${GAMES_DATADIR}"/${PN} \
		LIBDIR="$(games_get_libdir)"/${PN} \
		$(use opengl && use sdl && echo SDLSOUND=yes || echo SDLSOUND=no) \
		$(use opengl && ! use dedicated && echo BUILD=CLIENT) \
		$(! use opengl && use dedicated && echo BUILD=DEDICATED) \
		$(use opengl && use dedicated && echo BUILD=ALL) \
		$(use opengl || use dedicated || echo BUILD=CLIENT) \
		|| die "emake failed"
}

src_install() {
	cd release
	exeinto "$(games_get_libdir)"/${PN}
	doexe game.so || die "doexe failed"
	dosym . "$(games_get_libdir)"/${PN}/arena
	dosym . "$(games_get_libdir)"/${PN}/data1

	if use opengl || ! use dedicated ; then
		newgamesbin crx ${PN}-oss || die "newgamesbin crx failed"
		make_desktop_entry ${PN}-oss "Alien Arena (OSS audio)"
		use sdl || dosym ${PN}-oss "${GAMES_BINDIR}"/${PN}
	fi

	if use opengl && use sdl ; then
		newgamesbin crx.sdl ${PN}-sdl || die "newgamesbin crx.sdl failed"
		make_desktop_entry ${PN}-sdl "Alien Arena (SDL audio)"
		dosym ${PN}-sdl "${GAMES_BINDIR}"/${PN}
	fi

	if use dedicated ; then
		newgamesbin crded ${PN}-ded || die "newgamesbin crded failed"
	fi

	cd "${WORKDIR}"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r arena botinfo data1 || die "doins failed"
	newicon aa.png ${PN}.png || die "newicon failed"
	dodoc docs/README.txt

	prepgamesdirs
}
