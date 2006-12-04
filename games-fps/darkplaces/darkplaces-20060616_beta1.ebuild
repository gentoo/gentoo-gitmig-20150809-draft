# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/darkplaces/darkplaces-20060616_beta1.ebuild,v 1.3 2006/12/04 22:59:10 wolf31o2 Exp $

inherit eutils flag-o-matic versionator games

MOD_V="20060606"
MY_PV=$(replace_version_separator 1 '' )
MY_ENGINE="${PN}engine${MY_PV}.zip"
MY_MOD="${PN}mod${MOD_V}.zip"

# Different Quake 1 engines expect the lights in different directories
# http://www.fuhquake.net/download.html and http://www.kgbsyndicate.com/romi/
MY_LIGHTS="fuhquake-lits.rar"

DESCRIPTION="Enhanced engine for iD Software's Quake 1"
HOMEPAGE="http://icculus.org/twilight/darkplaces/"
SRC_URI="http://icculus.org/twilight/${PN}/files/${MY_ENGINE}
	dpmod? ( http://icculus.org/twilight/${PN}/files/${MY_MOD} )
	lights? (
		http://www.fuhquake.net/files/extras/${MY_LIGHTS}
		http://www.kgbsyndicate.com/romi/id1.pk3 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa cdinstall cdsound dedicated demo dpmod lights opengl oss sdl textures"

UIDEPEND="x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto
	x11-proto/xproto"
UIRDEPEND="alsa? ( media-libs/alsa-lib )
	media-libs/libogg
	media-libs/libvorbis
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXxf86dga
	x11-libs/libXxf86vm"
COMMON="media-libs/jpeg
	sdl? (
		media-libs/libsdl
		${UIDEPEND} )
	opengl? (
		virtual/opengl
		${UIDEPEND} )
	!dedicated? ( !sdl? ( !opengl? ( virtual/opengl ${UIDEPEND} ) ) )"
RDEPEND="cdinstall? ( games-fps/quake1-data )
	demo? ( games-fps/quake1-demodata )
	textures? ( >=games-fps/quake1-textures-20050820 )
	sdl? (
		media-libs/libsdl
		${UIRDEPEND} )
	opengl? (
		virtual/opengl
		${UIRDEPEND} )
	!dedicated? ( !sdl? ( !opengl? ( virtual/opengl ${UIRDEPEND} ) ) )"
DEPEND="dev-util/pkgconfig
	app-arch/unzip
	lights? (
		|| (
			app-arch/unrar
			app-arch/rar ) )
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

S=${WORKDIR}/${PN}
dir=${GAMES_DATADIR}/quake1

default_client() {
	if use opengl || $( ! use dedicated && ! use sdl ) ; then
		# Build default client
		return 0
	fi
	return 1
}

pkg_setup() {
	games_pkg_setup

	if default_client && ! use opengl ; then
		einfo "Defaulting to OpenGL client"
	fi
}

src_unpack() {
	if use lights ; then
		unpack "${MY_LIGHTS}"
		unzip -qo "${DISTDIR}"/id1.pk3 || die "unzip id1.pk3 failed"
		mv *.lit maps
		mv ReadMe.txt rtlights.txt
	fi
	unpack "${MY_ENGINE}"
	if use dpmod ; then
		unpack "${MY_MOD}"
	fi

	unpack ./${PN}*.zip
	find "${WORKDIR}" -name CVS -type d | xargs rm -r
	rm README-SDL.txt
	cd "${S}"
	rm mingw_note.txt

	# Make the game automatically look in the correct data directory
	sed -i fs.c \
		-e "s:strcpy(fs_basedir, \"\"):strcpy(fs_basedir, \"${dir}\"):" \
		|| die "sed fs.c failed"

	# Only additional CFLAGS optimization is the -march flag
	local march=$(get-flag -march)
	sed -i makefile.inc \
		-e '/^CC=/d' \
		-e "s:-lasound:$(pkg-config --libs alsa):" \
		-e "s:CPUOPTIMIZATIONS=:CPUOPTIMIZATIONS=${march}:" \
		-e "s:strip:#strip:" \
		|| die "sed makefile.inc failed"

	if ! use cdsound ; then
		# Turn the CD accesses off
		sed -i cd_linux.c \
			-e "s:/dev/cdrom:/dev/null:" \
			|| die "sed cd_linux.c failed"
		sed -i cd_shared.c \
			-e 's:COM_CheckParm("-nocdaudio"):1:' \
			|| die "sed cd_shared.c failed"
	fi

	# Reduce SDL audio buffer, to fix latency
	sed -i "s:requested->speed / 20.0:512:" snd_sdl.c \
		|| die "sed snd_sdl.c failed"

	# Default sound is alsa.
	if ! use alsa ; then
		if use oss ; then
			sed -i "s:DEFAULT_SNDAPI=ALSA:DEFAULT_SNDAPI=OSS:" makefile \
				|| die "sed oss failed"
		else
			sed -i "s:DEFAULT_SNDAPI=ALSA:DEFAULT_SNDAPI=NULL:" makefile \
				|| die "sed null failed"
		fi
	fi
}

src_compile() {
	if default_client ; then
		emake cl-release || die "emake cl-release failed"
	fi

	if use sdl ; then
		emake sdl-release || die "emake sdl-release failed"
	fi

	if use dedicated ; then
		emake sv-release || die "emake sv-release failed"
	fi
}

src_install() {
	if default_client || use sdl ; then
		newicon darkplaces72x72.png ${PN}.png
	fi

	if default_client ; then
		newgamesbin ${PN}-glx ${PN} || die "dogamesbin glx failed"
		if use cdinstall ; then
			make_desktop_entry ${PN} "Dark Places" ${PN}.png
		fi
		if use dpmod ; then
			games_make_wrapper ${PN}-dpmod "${PN} -game dpmod"
			make_desktop_entry ${PN}-dpmod "Dark Places (mod)" ${PN}.png
		fi
		if use demo ; then
			games_make_wrapper ${PN}-demo "${PN} -game demo"
			make_desktop_entry ${PN}-demo "Dark Places (demo)" ${PN}.png
		fi
	fi

	if use sdl ; then
		dogamesbin ${PN}-sdl || die "dogamesbin sdl failed"
		if use cdinstall ; then
			make_desktop_entry ${PN}-sdl "Dark Places (SDL)" ${PN}.png
		fi
		if use dpmod ; then
			games_make_wrapper ${PN}-sdl-dpmod "${PN}-sdl -game dpmod"
			make_desktop_entry ${PN}-sdl-dpmod "Dark Places (SDL mod)" ${PN}.png
		fi
		if use demo ; then
			games_make_wrapper ${PN}-sdl-demo "${PN}-sdl -game demo"
			make_desktop_entry ${PN}-sdl-demo "Dark Places (SDL demo)" ${PN}.png
		fi
	fi

	if use dedicated ; then
		newgamesbin ${PN}-dedicated ${PN}-ded || die "newgamesbin ded failed"
	fi

	if use dpmod ; then
		insinto "${dir}"
		doins -r "${WORKDIR}"/dpmod || die "doins dpmod failed"
	fi

	dodoc *.txt ChangeLog todo "${WORKDIR}"/{${PN}-cvschangelog,*.{qc,txt}}

	if use lights ; then
		insinto "${dir}"/id1
		doins -r "${WORKDIR}"/{cubemaps,maps} || die "doins cubemaps maps failed"
		if use demo ; then
			# Set up symlinks, for the demo levels to include the lights
			local d
			for d in cubemaps maps ; do
				dosym "${dir}/id1/${d}" "${dir}/demo/${d}"
			done
		fi
	fi

	prepgamesdirs
}
