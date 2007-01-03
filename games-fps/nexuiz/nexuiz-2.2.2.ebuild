# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/nexuiz/nexuiz-2.2.2.ebuild,v 1.1 2007/01/03 16:02:26 nyhm Exp $

inherit eutils toolchain-funcs games

MY_PN=Nexuiz
MY_P=${PN}-v${PV//./}
DESCRIPTION="Deathmatch FPS based on DarkPlaces, an advanced Quake 1 engine"
HOMEPAGE="http://www.nexuiz.com/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip
	mirror://sourceforge/${PN}/nexmappack.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="alsa dedicated opengl sdl"

UIRDEPEND="alsa? ( media-libs/alsa-lib )
	media-libs/libogg
	media-libs/libvorbis
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXxf86dga
	x11-libs/libXxf86vm"
UIDEPEND="x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto
	x11-proto/xproto"
RDEPEND="media-libs/jpeg
	net-misc/curl
	sdl? ( media-libs/libsdl ${UIRDEPEND} )
	opengl? ( virtual/opengl ${UIRDEPEND} )
	!dedicated? ( !sdl? ( !opengl? ( virtual/opengl ${UIRDEPEND} ) ) )"
DEPEND="${RDEPEND}
	app-arch/unzip
	sdl? ( media-libs/libsdl ${UIDEPEND} )
	opengl? ( virtual/opengl ${UIDEPEND} )
	!dedicated? ( !sdl? ( !opengl? ( virtual/opengl ${UIDEPEND} ) ) )"

S=${WORKDIR}/darkplaces

src_unpack() {
	unpack ${MY_P}.zip

	local f
	for f in "${MY_PN}"/sources/*.zip ; do
		unpack ./${f}
	done

	cd "${WORKDIR}"/${MY_PN}
	unpack nexmappack.zip

	cd "${S}"
	# Make the game automatically look in the correct data directory
	sed -i "s:gamedirname1:\"${PN}\":" fs.c \
		|| die "sed fs.c failed"

	sed -i makefile.inc \
		-e "/^CC=/s:gcc:$(tc-getCC):" \
		-e "s/-O2/${CFLAGS}/" \
		-e "/-lm/s:$: ${LDFLAGS}:" \
		-e '/strip/d' \
		|| die "sed makefile.inc failed"

	# This is the right dir, so that e.g. "darkplaces -game nexuiz" will work
	sed -i "s:ifdef DP_.*:DP_FS_BASEDIR=${GAMES_DATADIR}/quake1\n&:" makefile \
		|| die "sed makefile failed"

	if ! use alsa ; then
		sed -i "/DEFAULT_SNDAPI/s:ALSA:OSS:" makefile \
			|| die "sed makefile failed"
	fi
}

src_compile() {
	if use opengl || (! use dedicated && ! use sdl) ; then
		emake cl-${PN} || die "emake cl-${PN} failed"
	fi

	if use sdl ; then
		emake sdl-${PN} || die "emake sdl-${PN} failed"
	fi

	if use dedicated ; then
		emake sv-${PN} || die "emake sv-${PN} failed"
	fi
}

src_install() {
	if use opengl || use sdl || ! use dedicated ; then
		newicon darkplaces72x72.png ${PN}.png
	fi

	if use opengl || (! use dedicated && ! use sdl) ; then
		dogamesbin ${PN}-glx || die "dogamesbin glx failed"
		make_desktop_entry ${PN}-glx "Nexuiz (GLX)"
		dosym "${GAMES_BINDIR}"/{${PN}-glx,${PN}}
	fi

	if use sdl ; then
		dogamesbin ${PN}-sdl || die "dogamesbin sdl failed"
		make_desktop_entry ${PN}-sdl "Nexuiz (SDL)"
		use opengl || dosym "${GAMES_BINDIR}"/{${PN}-sdl,${PN}}
	fi

	if use dedicated ; then
		dogamesbin ${PN}-dedicated || die "dogamesbin dedicated failed"
	fi

	cd "${WORKDIR}"/${MY_PN}
	insinto "${GAMES_DATADIR}"/quake1/${PN}
	doins -r data/* || die "doins data failed"

	dodoc Docs/*.txt
	dohtml Docs/*.{htm,html}
	docinto server
	dodoc Docs/server/*.{cfg,txt}

	prepgamesdirs
}
