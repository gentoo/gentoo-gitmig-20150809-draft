# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/alienarena/alienarena-20070224-r1.ebuild,v 1.2 2007/03/07 01:26:50 peper Exp $

inherit eutils flag-o-matic toolchain-funcs games

MY_PN=${PN}${PV:0:4}
DESCRIPTION="Fast paced multiplayer deathmatch game"
HOMEPAGE="http://red.planetarena.org/"
SRC_URI="http://cor.planetquake.gamespy.com/codered/files/${MY_PN}-linux${PV}-x86.zip
	ftp://ftp.planetmirror.com/pub/gamershell/demo/${MY_PN}-linux${PV}-x86.zip
	ftp://ftp.planetmirror.com/pub/worthplaying/${MY_PN}-linux${PV}-x86.zip"

LICENSE="GPL-2 free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated opengl sdl"

UIRDEPEND="media-libs/jpeg
	virtual/glu
	virtual/opengl
	x11-libs/libXxf86dga
	x11-libs/libXxf86vm"
UIDEPEND="x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto
	x11-proto/xproto"
RDEPEND="opengl? ( ${UIRDEPEND} )
	sdl? ( >=media-libs/libsdl-1.2.8-r1 ${UIRDEPEND} )
	!opengl? ( !dedicated? ( !sdl? ( ${UIRDEPEND} ) ) )"
DEPEND="${RDEPEND}
	app-arch/unzip
	opengl? ( ${UIDEPEND} )
	sdl? ( >=media-libs/libsdl-1.2.8-r1 ${UIDEPEND} )
	!opengl? ( !dedicated? ( !sdl? ( ${UIDEPEND} ) ) )"

S=${WORKDIR}/${MY_PN}/source/linux

src_unpack() {
	unpack ${A}
	cd ${MY_PN}
	rm -f */*.so
	epatch \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-paths.patch \
		"${FILESDIR}"/${P}-exec-stack.patch \
		"${FILESDIR}"/${P}-gamedir.patch
	sed -i \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:" \
		-e "s:GENTOO_LIBDIR:${GAMES_LIBDIR}/${PN}:" \
		source/linux/sys_linux.c \
		|| die "sed failed"
}

src_compile() {
	[[ $(gcc-fullversion) == "4.1.1" ]] && replace-flags -O? -O0
	emake \
		CC="$(tc-getCC)" \
		$(use sdl && echo SDLSOUND=1) \
		$(use opengl || use sdl && echo BUILD_ARENA=1) \
		$(use opengl || use sdl || use dedicated || echo BUILD_ARENA=1) \
		$(use dedicated && echo BUILD_DED=1) \
		|| die "emake failed"
}

src_install() {
	cd debug
	exeinto "${GAMES_LIBDIR}"/${PN}
	doexe game.so || die "doexe failed"

	if (use opengl || use sdl) || use opengl || use sdl || ! use dedicated ; then
		newgamesbin crx. ${PN}-oss || die "newgamesbin crx failed"
		make_desktop_entry ${PN}-oss "Alien Arena (OSS audio)" ${PN}.xpm
		use sdl || dosym ${PN}-oss "${GAMES_BINDIR}"/${PN}
	fi

	if use sdl ; then
		newgamesbin crx.sdl. ${PN}-sdl || die "newgamesbin crx.sdl failed"
		make_desktop_entry ${PN}-sdl "Alien Arena (SDL audio)" ${PN}.xpm
		dosym ${PN}-sdl "${GAMES_BINDIR}"/${PN}
	fi

	if use dedicated ; then
		newgamesbin crded. ${PN}-ded || die "newgamesbin crded failed"
	fi

	cd "${WORKDIR}"/${MY_PN}
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r arena botinfo data1 || die "doins failed"
	doicon ${PN}.xpm
	dodoc README.txt version.txt
	prepgamesdirs
}
