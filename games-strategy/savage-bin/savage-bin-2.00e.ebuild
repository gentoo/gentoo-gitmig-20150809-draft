# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/savage-bin/savage-bin-2.00e.ebuild,v 1.10 2009/10/30 15:10:00 maekke Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Unique mix of strategy and FPS"
HOMEPAGE="http://www.s2games.com/savage/
	http://www.notforidiots.com/SFE/
	http://www.newerth.com/"
SRC_URI="http://www.newerth.com/downloads/SFE-Standalone.tar.gz
	http://www.newerth.com/downloads/lin-client-auth-patch.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror strip"

RDEPEND="virtual/opengl
	x86? ( media-libs/libsdl
		>=media-libs/freetype-2
		|| ( media-libs/jpeg-compat <media-libs/jpeg-7 ) )
	amd64? ( app-emulation/emul-linux-x86-sdl )"
DEPEND="app-arch/unzip"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/savage

QA_TEXTRELS="${dir:1}/libs/libfmod.so
	${dir:1}/libs/libfmod-3.75.so
	${dir:1}/game/game.so"
QA_EXECSTACK="${dir:1}/libs/libfmod.so
	${dir:1}/libs/libfmod-3.75.so"

src_prepare() {
	cp -f lin-client-auth-patch/silverback.bin .
	cp -f lin-client-auth-patch/game/game.so game/.
	cp -f lin-client-auth-patch/libs/libpng12.so.0 libs/.
	rm -rf lin-client-auth-patch/
	rm -f graveyard/game.dll *.sh
	sed \
		-e "s:%GAMES_PREFIX_OPT%:${GAMES_PREFIX_OPT}:" \
		"${FILESDIR}"/savage > "${T}"/savage \
		|| die "sed failed"
	# Here, we default to the best resolution
	sed -i -e  \
		's/setsave vid_mode -1/setsave vid_mode 1/' \
		game/settings/default.cfg || die "sed failed"
}

src_install() {
	insinto "${dir}"
	doins -r * || die "doins failed"
	fperms g+x "${dir}"/silverback.bin || die "fperms failed"
	dosym /dev/null "${dir}"/scripts.log || die "dosym failed"

	dogamesbin "${T}"/savage
	make_desktop_entry savage "Savage: The Battle For Newerth"

	games_make_wrapper savage-graveyard "./silverback.bin set mod graveyard" \
		"${dir}" "${dir}"/libs
	make_desktop_entry savage-graveyard "Savage: Graveyard"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "In order to play \"Savage: The Battle For Newerth\", use:"
	elog "savage"
	elog "In order to start Editor, use:"
	elog "savage-graveyard"
}
