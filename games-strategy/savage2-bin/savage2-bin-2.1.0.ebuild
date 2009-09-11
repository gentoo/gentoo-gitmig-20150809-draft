# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/savage2-bin/savage2-bin-2.1.0.ebuild,v 1.1 2009/09/11 21:14:31 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Unique mix of strategy and FPS"
HOMEPAGE="http://savage2.s2games.com/"
SRC_URI="x86? ( http://www.savage2.com/en/downloads/installers/Savage2Install-$PV-i686.bin )
		 amd64? ( http://www.savage2.com/en/downloads/installers/Savage2Install-$PV-x86_64.bin )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"
QA_TEXTRELS="
	${GAMES_PREFIX_OPT:1}/savage2/vid_gl2.so
	${GAMES_PREFIX_OPT:1}/savage2/editor/cgame.so
	${GAMES_PREFIX_OPT:1}/savage2/libs/libfmodex.so
	${GAMES_PREFIX_OPT:1}/savage2/libs/libcurl.so.4
	${GAMES_PREFIX_OPT:1}/savage2/game/libgame_shared.so
	${GAMES_PREFIX_OPT:1}/savage2/game/game.so
	${GAMES_PREFIX_OPT:1}/savage2/game/cgame.so
	${GAMES_PREFIX_OPT:1}/savage2/modelviewer/cgame.so
	${GAMES_PREFIX_OPT:1}/savage2/libk2.so"
QA_EXECSTACK="
	${GAMES_PREFIX_OPT:1}/savage2/savage2.bin
	${GAMES_PREFIX_OPT:1}/savage2/libs/libfmodex.so
	${GAMES_PREFIX_OPT:1}/savage2/libs/libcurl.so.4
	${GAMES_PREFIX_OPT:1}/savage2/savage2_update.bin"

RDEPEND="virtual/opengl"
DEPEND="app-arch/unzip"

S=${WORKDIR}

src_unpack() {
	if use x86 ; then
		unzip "${DISTDIR}"/Savage2Install-$PV-i686.bin
	elif use amd64 ; then
		unzip "${DISTDIR}"/Savage2Install-$PV-x86_64.bin
	else
		die "Unsupported arch"
	fi
}

src_prepare() {
	rm data/modelviewer.sh \
		data/dedicated_server.sh \
		data/editor.sh
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/savage2

	cd data
	insinto "${dir}"
	doins -r * || die "doins failed"
	fperms g+x "${dir}"/savage2_update.bin || die "fperms failed"
	fperms g+x "${dir}"/savage2.bin || die "fperms failed"
	doicon s2icon.png

	games_make_wrapper savage2 "./savage2.bin" "${dir}" "${dir}:${dir}/libs"
	make_desktop_entry savage2 "Savage 2: A Tortured Soul" s2icon

	games_make_wrapper savage2-editor "./savage2.bin \"PushMod editor; Set host_autoExec StartClient\"" \
		"${dir}" "${dir}:${dir}/libs"
	make_desktop_entry savage2-editor "Savage 2: Editor" s2icon

	games_make_wrapper savage2-modelviewer "./savage2.bin \"PushMod modelviewer; Set host_autoExec StartClient\"" \
		"${dir}" "${dir}:${dir}/libs"
	make_desktop_entry savage2-modelviewer "Savage 2: Model Viewer" s2icon

	games_make_wrapper savage2-dedicated "./savage2.bin \"Set host_dedicatedServer true\"" \
		"${dir}" "${dir}:${dir}/libs"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "Run as root:"
	einfo "LD_LIBRARY_PATH=\"\${LD_LIBRARY_PATH}:/opt/savage2:/opt/savage2/libs\" ${GAMES_PREFIX_OPT}/savage2/savage2_update.bin --update-runpath"
	einfo "once to complete installation"
}
