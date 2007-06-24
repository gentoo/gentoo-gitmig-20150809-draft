# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/qudos/qudos-9999.ebuild,v 1.7 2007/06/24 18:01:12 peper Exp $

inherit eutils subversion toolchain-funcs games

MY_PN="quake2"

DESCRIPTION="Enhanced Quake 2 engine"
HOMEPAGE="http://qudos.quakedev.com/"

# View at http://svn.quakedev.com/viewcvs.cgi/qudos/trunk/
ESVN_REPO_URI="svn://svn.quakedev.com/${PN}/trunk"

SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="alsa cdinstall debug dedicated demo dga ipv6 joystick mods opengl qmax oss sdl textures"

UIDEPEND="alsa? ( media-libs/alsa-lib )
	opengl? (
		virtual/opengl
		virtual/glu )
	sdl? ( media-libs/libsdl )
	media-libs/jpeg
	media-libs/libogg
	media-libs/libpng
	media-libs/libvorbis
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXxf86dga
	x11-libs/libXxf86vm"
RDEPEND="${UIDEPEND}
	cdinstall? ( games-fps/quake2-data )
	demo? ( games-fps/quake2-demodata )
	textures? ( games-fps/quake2-textures )"
DEPEND="${UIDEPEND}"

S=${WORKDIR}
dir=${GAMES_DATADIR}/${MY_PN}

default_client() {
	if use opengl || use sdl || ! use dedicated ; then
		# Build default client
		return 0
	fi
	return 1
}

pkg_setup() {
	games_pkg_setup

	local alert_user

	if ! use qmax && $( use opengl || use sdl ) ; then
		elog "The 'qmax' graphical improvements are recommended."
		echo
		alert_user=y
	fi

	if use debug ; then
		ewarn "The 'debug' USE flag may cause compilation to fail with:"
		ewarn
		ewarn "src/qcommon/cmd.c:364: warning: dereferencing type-punned"
		ewarn "pointer will break strict-aliasing rules."
		echo
		alert_user=y
	fi

	# Determine the default sound driver, in order of preference
	# snd_drv is not a local variable
	snd_drv=""
	[[ -z "${snd_drv}" ]] && use oss && snd_drv="oss"
	[[ -z "${snd_drv}" ]] && use sdl && snd_drv="sdl"
	[[ -z "${snd_drv}" ]] && use alsa && snd_drv="alsa"
	# Default if nothing else chosen
	[[ -z "${snd_drv}" ]] && snd_drv="oss"

	if default_client ; then
		elog "Selected the ${snd_drv} sound driver."
		echo
		if [[ "${snd_drv}" = "alsa" ]] ; then
			ewarn "The ALSA sound driver for this game is incomplete."
			# OSS is the default sound driver in the Makefile
			ewarn "The 'oss' USE flag is recommended instead."
			echo
			alert_user=y
		fi
	fi

	if [[ -n "${alert_user}" ]] ; then
		ebeep
		epause
	fi
}

src_unpack() {
	subversion_src_unpack

	rm docs/gnu.txt

	# Change default sound driver and its location
	sed -i src/client/snd_dma.c \
		-e "s:\"oss\":\"${snd_drv}\":" \
		-e "s:\"\./snd:\"$(games_get_libdir)/${PN}/snd:" \
		|| die "sed snd_dma.c failed"
}

src_compile() {
	yesno() { useq $1 && echo YES || echo NO ; }

	local client="YES"
	default_client || client="NO"

	local type="release"
	use debug && type="debug"

	emake -j1 \
		BUILD_QUAKE2="${client}" \
		BUILD_DEDICATED=$(yesno dedicated) \
		BUILD_GLX=$(yesno opengl) \
		BUILD_SDLGL=$(yesno sdl) \
		BUILD_ALSA_SND=$(yesno alsa) \
		BUILD_SDL_SND=$(yesno sdl) \
		BUILD_OSS_SND=$(yesno oss) \
		WITH_XMMS=NO \
		WITH_DGA_MOUSE=$(yesno dga) \
		WITH_JOYSTICK=$(yesno joystick) \
		TYPE="${type}" \
		DATADIR="${dir}" \
		LOCALBASE=/usr \
		LIBDIR="$(games_get_libdir)"/${PN} \
		WITH_QMAX=$(yesno qmax) \
		BUILD_3ZB2=$(yesno mods) \
		BUILD_CTF=$(yesno mods) \
		BUILD_JABOT=$(yesno mods) \
		BUILD_ROGUE=$(yesno mods) \
		BUILD_XATRIX=$(yesno mods) \
		BUILD_ZAERO=$(yesno mods) \
		WITH_BOTS=$(yesno mods) \
		HAVE_IPV6=$(yesno ipv6) \
		CC="$(tc-getCC)" \
		WITH_X86_ASM=NO \
		WITH_DATADIR=YES \
		WITH_LIBDIR=YES \
		BUILD_DEBUG_DIR=release \
		BUILD_RELEASE_DIR=release \
		|| die "emake failed"
}

src_install() {
	if default_client ; then
		newgamesbin ${MY_PN}/QuDos ${PN} \
			|| die "newgamesbin QuDos failed"
		# This icon is not available in the 0.40.1 tarball
		newicon src/unix/Q2.png ${PN}.png
		make_desktop_entry ${PN} "QuDos" ${PN}.png
	fi

	if use dedicated ; then
		newgamesbin ${MY_PN}/QuDos-ded ${PN}-ded \
			|| die "newgamesbin QuDos-ded failed"
	fi

	insinto "$(games_get_libdir)"/${PN}
	doins -r ${MY_PN}/* || die "doins libs failed"
	rm "${D}/$(games_get_libdir)"/${PN}/QuDos

	insinto "$(games_get_libdir)"/${PN}/baseq2
	doins data/qudos.pk3 || die "doins qudos.pk3 failed"

	dodoc $(find docs -name \*.txt) docs/q2_orig/README*

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	if use demo && ! built_with_use "games-fps/quake2-demodata" symlink ; then
		ewarn "To play the Quake 2 demo,"
		ewarn "emerge games-fps/quake2-demodata with the 'symlink' USE flag."
		echo
	fi
}
