# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/alienarena/alienarena-20070613-r1.ebuild,v 1.1 2007/09/24 21:27:48 nyhm Exp $

inherit eutils flag-o-matic toolchain-funcs games

MY_PN=${PN}${PV:0:4}
DESCRIPTION="Fast paced multiplayer deathmatch game"
HOMEPAGE="http://red.planetarena.org/"
SRC_URI="http://cor.planetquake.gamespy.com/codered/files/${MY_PN}-${PV}-linux.zip
	http://icculus.org/${PN}/files/${MY_PN}-${PV}-linux.zip"

LICENSE="GPL-2 free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated opengl sdl"

UIDEPEND="media-libs/jpeg
	virtual/glu
	virtual/opengl
	x11-libs/libXxf86dga
	x11-libs/libXxf86vm"
RDEPEND="!dedicated? ( ${UIDEPEND} )
	opengl? ( ${UIDEPEND} )
	sdl? ( ${UIDEPEND} media-libs/libsdl )"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}
	cd ${MY_PN}
	rm -f */*.so
	epatch \
		"${FILESDIR}"/${P}-paths.patch \
		"${FILESDIR}"/${P}-format-strings.patch \
		"${FILESDIR}"/${P}-dos.patch
	sed -i \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:" \
		-e "s:GENTOO_LIBDIR:$(games_get_libdir)/${PN}:" \
		source/unix/sys_unix.c \
		|| die "sed failed"
}

src_compile() {
	[[ $(gcc-fullversion) == "4.1.1" ]] && replace-flags -O? -O0
	emake \
		CC="$(tc-getCC)" \
		OPTIMIZED_CFLAGS= \
		$(use sdl && echo SDLSOUND=1) \
		$(use opengl && ! use dedicated && echo BUILD=GAME) \
		$(! use opengl && use dedicated && echo BUILD=DEDICATED) \
		$(use opengl && use dedicated && echo BUILD=ALL) \
		$(! use opengl && ! use dedicated && echo BUILD=GAME) \
		|| die "emake failed"
}

src_install() {
	cd release
	exeinto "$(games_get_libdir)"/${PN}
	doexe game.so || die "doexe failed"

	if use opengl || ! use dedicated ; then
		newgamesbin crx ${PN}-oss || die "newgamesbin crx failed"
		make_desktop_entry ${PN}-oss "Alien Arena (OSS audio)" ${PN}.xpm
		use sdl || dosym ${PN}-oss "${GAMES_BINDIR}"/${PN}
	fi

	if use sdl ; then
		newgamesbin crx.sdl ${PN}-sdl || die "newgamesbin crx.sdl failed"
		make_desktop_entry ${PN}-sdl "Alien Arena (SDL audio)" ${PN}.xpm
		dosym ${PN}-sdl "${GAMES_BINDIR}"/${PN}
	fi

	if use dedicated ; then
		newgamesbin crded ${PN}-ded || die "newgamesbin crded failed"
	fi

	cd "${WORKDIR}"/${MY_PN}
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r arena botinfo data1 || die "doins failed"
	doicon "${FILESDIR}"/${PN}.xpm
	dodoc docs/README.txt docs/changelog.txt
	prepgamesdirs
}
