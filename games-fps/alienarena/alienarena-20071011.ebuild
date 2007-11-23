# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/alienarena/alienarena-20071011.ebuild,v 1.1 2007/11/23 06:33:09 nyhm Exp $

inherit eutils flag-o-matic toolchain-funcs games

MY_PN=${PN}${PV:0:4}
DESCRIPTION="Fast-paced multiplayer deathmatch game"
HOMEPAGE="http://red.planetarena.org/"
SRC_URI="http://icculus.org/${PN}/files/${MY_PN}-${PV}-linux.zip"

LICENSE="GPL-2 free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated opengl sdl"

UIDEPEND="media-libs/jpeg
	media-libs/libpng
	virtual/glu
	virtual/opengl
	x11-libs/libXxf86dga
	x11-libs/libXxf86vm"
RDEPEND="!dedicated? ( ${UIDEPEND} )
	opengl? ( ${UIDEPEND} )
	sdl? ( ${UIDEPEND} media-libs/libsdl )
	net-misc/curl"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${MY_PN}/source

src_unpack() {
	unpack ${A}
	cd "${MY_PN}"

	rm -f */*.so *.dll crded crx crx.sdl

	epatch "${FILESDIR}"/${P}-paths.patch

	cd "${S}"
	sed -i \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:" \
		-e "s:GENTOO_LIBDIR:$(games_get_libdir)/${PN}:" \
		unix/sys_unix.c \
		|| die "sed sys_unix.c"
}

src_compile() {
	# To avoid audio crackling
	[[ $(gcc-fullversion) == "4.1.1" ]] && replace-flags -O? -O0

	emake \
		CC="$(tc-getCC)" \
		BASE_CFLAGS="${CFLAGS} -Dstricmp=strcasecmp -D_stricmp=strcasecmp -DHAVE_CURL" \
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

	cd "${WORKDIR}/${MY_PN}"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r arena botinfo data1 || die "doins failed"
	newicon aa.png ${PN}.png || die "newicon"
	dodoc docs/README.txt

	prepgamesdirs
}
