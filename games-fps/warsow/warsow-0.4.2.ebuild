# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/warsow/warsow-0.4.2.ebuild,v 1.5 2009/01/19 21:48:10 nyhm Exp $

inherit eutils toolchain-funcs versionator games

MY_P=${PN}_$(delete_version_separator 2)
DESCRIPTION="Multiplayer FPS based on the QFusion engine (evolved from Quake 2)"
HOMEPAGE="http://www.warsow.net/"
SRC_URI="http://tastyspleen.net/quake/downloads/mods/warsow/${MY_P}_unified.zip
	http://tastyspleen.net/quake/downloads/mods/warsow/${MY_P}_sdk.zip
	mirror://gentoo/${PN}.png"

LICENSE="GPL-2 warsow"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug dedicated irc openal opengl"

UIRDEPEND="media-libs/jpeg
	media-libs/libvorbis
	media-libs/libsdl
	net-misc/curl
	virtual/opengl
	x11-libs/libXinerama
	x11-libs/libXxf86dga
	x11-libs/libXxf86vm
	openal? ( media-libs/openal )"
RDEPEND="opengl? ( ${UIRDEPEND} )
	!opengl? ( !dedicated? ( ${UIRDEPEND} ) )"
UIDEPEND="x11-proto/xineramaproto
	x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto"
DEPEND="${RDEPEND}
	app-arch/unzip
	x11-misc/makedepend
	opengl? ( ${UIDEPEND} )
	!opengl? ( !dedicated? ( ${UIDEPEND} ) )"

S=${WORKDIR}/${MY_P}_src/source

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "/fs_basepath =/ s:\.:${GAMES_DATADIR}/${PN}:" \
		qcommon/files.c \
		|| die "sed files.c failed"

	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	yesno() { use ${1} && echo YES || echo NO ; }

	local client="NO" irc="NO" openal="NO"
	if use opengl || ! use dedicated ; then
		client="YES"
		use irc && irc="YES"
		use openal && openal="YES"
	fi

	echo emake \
		BUILD_CLIENT=${client} \
		BUILD_SERVER=$(yesno dedicated) \
		BUILD_TV_SERVER=$(yesno dedicated) \
		BUILD_IRC=${irc} \
		BUILD_SND_OPENAL=${openal} \
		BUILD_SND_QF=${client} \
		DEBUG_BUILD=$(yesno debug) \
		CC="$(tc-getCC)" \
		LD="$(tc-getCC)" \
		|| die "emake failed"
	emake \
		BUILD_CLIENT=${client} \
		BUILD_SERVER=$(yesno dedicated) \
		BUILD_TV_SERVER=$(yesno dedicated) \
		BUILD_IRC=${irc} \
		BUILD_SND_OPENAL=${openal} \
		BUILD_SND_QF=${client} \
		DEBUG_BUILD=$(yesno debug) \
		CC="$(tc-getCC)" \
		LD="$(tc-getCC)" \
		|| die "emake failed"
}

src_install() {
	cd release

	if use opengl || ! use dedicated ; then
		newgamesbin ${PN}.* ${PN} || die "newgamesbin ${PN} failed"
		doicon "${DISTDIR}"/${PN}.png
		make_desktop_entry ${PN} Warsow
	fi

	if use dedicated ; then
		newgamesbin wsw_server.* ${PN}-ded || die "newgamesbin ${PN}-ded failed"
		newgamesbin wswtv_server.* ${PN}-tv || die "newgamesbin ${PN}-tv failed"
	fi

	exeinto "$(games_get_libdir)"/${PN}
	doexe */*.so || die "doexe failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r "${WORKDIR}"/${MY_P}_unified/basewsw || die "doins failed"

	local so
	for so in basewsw/*.so ; do
		dosym "$(games_get_libdir)"/${PN}/${so##*/} \
			"${GAMES_DATADIR}"/${PN}/${so} || die "dosym ${so} failed"
	done

	if [[ -e libs ]] ; then
		dodir "${GAMES_DATADIR}"/${PN}/libs
		for so in libs/*.so ; do
			dosym "$(games_get_libdir)"/${PN}/${so##*/} \
				"${GAMES_DATADIR}"/${PN}/${so} || die "dosym ${so} failed"
		done
	fi

	dodoc "${WORKDIR}"/docs/*
	prepgamesdirs
}
