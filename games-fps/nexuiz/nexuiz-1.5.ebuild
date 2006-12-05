# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/nexuiz/nexuiz-1.5.ebuild,v 1.8 2006/12/05 17:14:21 wolf31o2 Exp $

inherit eutils games

MY_PV=${PV//./}
MY_PN=${PN/n/N}

DESCRIPTION="Deathmatch FPS based on DarkPlaces, an advanced Quake1 engine"
HOMEPAGE="http://www.nexuiz.com"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="dedicated opengl sdl"

UIDEPEND="media-libs/alsa-lib
	media-libs/libogg
	media-libs/libvorbis
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext"
RDEPEND="media-libs/jpeg
	sys-libs/glibc
	sys-libs/zlib
	sdl? (
		media-libs/libsdl
		${UIDEPEND} )
	opengl? (
		virtual/opengl
		${UIDEPEND} )
	!dedicated? (
		!sdl? (
			!opengl? (
				virtual/opengl
				${UIDEPEND} ) ) )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-arch/unzip"

S=${WORKDIR}/${MY_PN}/darkplaces
dir=${GAMES_DATADIR}/${PN}
exe=${PN}

default_client() {
	if use opengl || $( ! use dedicated && ! use sdl )
	then
		# Build default client
		return 0
	fi
	return 1
}

pkg_setup() {
	games_pkg_setup
	if default_client && ! use opengl
	then
		einfo "Defaulting to OpenGL client"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${MY_PN}
	unzip $(ls -A ${PN}enginesource*.zip) || die "unzip failed"

	cd "${S}"
	sed -i \
		-e '/^CC/d' \
		-e "s:-lasound:$(pkg-config --libs alsa):" \
		makefile.inc \
		|| die "sed makefile failed"
}

src_compile() {
	if default_client
	then
		emake cl-release \
			CFLAGS_RELEASE="" OPTIM_RELEASE="" \
			CFLAGS_COMMON="${CFLAGS}" \
			|| die "emake cl-release failed"
	fi

	if use sdl
	then
		emake sdl-release \
			CFLAGS_RELEASE="" OPTIM_RELEASE="" \
			CFLAGS_COMMON="${CFLAGS}" \
			|| die "emake sdl-release failed"
	fi

	if use dedicated
	then
		emake sv-release \
			CFLAGS_RELEASE="" OPTIM_RELEASE="" \
			CFLAGS_COMMON="${CFLAGS}" \
			|| die "emake dedicated failed"
	fi
}

src_install() {
	insinto "${dir}"
	exeinto "${dir}"

	if default_client || use sdl
	then
		newicon darkplaces72x72.png ${PN}.png
	fi

	if default_client
	then
		newexe darkplaces-glx ${exe} || die "newexe glx failed"
		games_make_wrapper ${PN} ./${exe} "${dir}"
		make_desktop_entry ${PN} Nexuiz ${PN}.png
	fi

	if use sdl
	then
		newexe darkplaces-sdl ${PN}-sdl || die "newexe sdl failed"
		games_make_wrapper ${PN}-sdl ./${PN}-sdl "${dir}"
		make_desktop_entry ${PN}-sdl "Nexuiz (SDL)" ${PN}.png
	fi

	if use dedicated
	then
		newexe darkplaces-dedicated ${PN}-ded || die "newexe ded failed"
		games_make_wrapper ${PN}-ded ./${PN}-ded "${dir}"
	fi

	cd "${WORKDIR}/${MY_PN}"
	insinto "${dir}/data"
	doins -r data/* || die "doins data failed"
	dodoc Docs/*.txt
	dohtml Docs/*.{htm,html}

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "For sound problems, read:"
	einfo "   http://www.alientrap.org/forum/viewtopic.php?t=72"
}
