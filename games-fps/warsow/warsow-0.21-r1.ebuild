# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/warsow/warsow-0.21-r1.ebuild,v 1.2 2007/04/06 05:34:06 nyhm Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="Multiplayer FPS based on the QFusion engine (evolved from Quake 2)"
HOMEPAGE="http://www.warsow.net/"
SRC_URI="ftp://ftp.club-internet.fr/pub/games/nofrag/${PN}/${PN}_${PV/_/}_linux.tar.gz
	ftp://ftp.club-internet.fr/pub/games/nofrag/${PN}/${PN}_${PV/_/}_sdk.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug dedicated irc openal sdl"

UIRDEPEND="media-libs/jpeg
	media-libs/libogg
	media-libs/libvorbis
	net-misc/curl
	virtual/opengl
	>=media-libs/libsdl-1.2.8-r1
	>=media-libs/sdl-sound-1.0.1-r1
	openal? ( media-libs/openal )
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext"
UIDEPEND="x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto"
RDEPEND="sdl? ( ${UIRDEPEND} )
	!sdl? ( !dedicated? ( ${UIRDEPEND} ) )"
DEPEND="${RDEPEND}
	sdl? ( ${UIDEPEND} )
	!sdl? ( !dedicated? ( ${UIDEPEND} ) )
	app-arch/unzip"

S=${WORKDIR}/source

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Make fs_usehomedir default to 1, so the game will write to ~/.warsow/
	# Make fs_basepath default to correct path.
	# Add libdir as game directory.
	sed -i qcommon/files.c \
		-e 's:"fs_usehomedir", "0":"fs_usehomedir", "1":' \
		-e "s:\"fs_basepath\", \"\.\":\"fs_basepath\", \"${GAMES_DATADIR}/${PN}\":" \
		|| die "sed files.c failed"

	# Remove pre-compiled binaries, because they are compiled in src_compile()
	# Also remove the startup scripts.
	rm -f "${WORKDIR}"/${PN}/{${PN}*,wsw_server*}
	rm -rf "${WORKDIR}"/${PN}/libs/*.so

	# Move docs to a convenient directory, away from the files to be installed.
	rm -f "${WORKDIR}"/${PN}/docs/gnu.txt
	mv "${WORKDIR}"/${PN}/docs "${S}"

	sed -i Makefile \
		-e '/^CFLAGS_RELEASE/s/=.* \(-fno.* \).* .* /=\1/' \
		-e '/^CFLAGS_DEBUG/s/-O0 -ggdb/-fno-strict-aliasing/' \
		|| die "sed Makefile failed"

	epatch "${FILESDIR}"/${P}-inverted-mouse.patch
}

src_compile() {
	yesno() { useq $1 && echo YES || echo NO ; }

	local client="NO"

	if use sdl || ! use dedicated ; then
		client="YES"
	fi

	emake \
		BUILD_CLIENT=${client} \
		BUILD_SERVER=$(yesno dedicated) \
		BUILD_IRC=$(yesno irc) \
		BUILD_SND_QF=${client} \
		BUILD_SND_OPENAL=$(yesno openal) \
		DEBUG_BUILD=$(yesno debug) \
		BINDIR=release \
		SERVER_EXE=${PN}-ded \
		CLIENT_EXE=${PN} \
		CC="$(tc-getCC)" \
		LD="$(tc-getCC)" \
		|| die "emake failed"

	mv -f release/basewsw/*.so "${WORKDIR}" || die "mv *.so failed"
	cp -rf release/basewsw "${WORKDIR}"/${PN} || die "cp basewsw failed"
}

src_install() {
	cd "${WORKDIR}"/${PN}

	if use sdl || use openal || ! use dedicated ; then
		dogamesbin "${S}"/release/${PN} || die "dogamesbin ${PN} failed"
		make_desktop_entry ${PN} "Warsow"
	fi

	if use dedicated ; then
		dogamesbin "${S}"/release/${PN}-ded || die "dogamesbin ${PN}-ded failed"
	fi

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r * || die "doins failed"

	exeinto "$(games_get_libdir)"/${PN}/basewsw
	local lib
	for lib in $(cd "${WORKDIR}" && ls -A *.so) ; do
		doexe "${WORKDIR}"/${lib} || die "doexe ${lib} failed"
		dosym "$(games_get_libdir)"/${PN}/basewsw/${lib} \
			"${GAMES_DATADIR}"/${PN}/basewsw/ || die "dosym basewsw failed"
	done

	exeinto "$(games_get_libdir)"/${PN}
	local lib2
	for lib2 in $(cd "${S}"/release/libs && ls -A *.so) ; do
		doexe "${S}"/release/libs/${lib2} || die "doexe ${lib2} failed"
		dosym "$(games_get_libdir)"/${PN}/${lib2} \
			"${GAMES_DATADIR}"/${PN}/libs/ || die "dosym libs failed"
	done

	dodoc "${S}"/docs/*
	prepgamesdirs
}
