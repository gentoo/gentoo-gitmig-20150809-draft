# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/savage-bin/savage-bin-2.00e.ebuild,v 1.6 2008/12/06 14:57:20 nyhm Exp $

inherit eutils games

DESCRIPTION="Unique mix of strategy and FPS"
HOMEPAGE="http://www.s2games.com/savage/
	http://www.notforidiots.com/SFE/"
SRC_URI="http://www.notforidiots.com/SFE/SFE-Standalone.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"

RDEPEND="virtual/opengl
	media-libs/libsdl
	media-libs/jpeg
	>=media-libs/freetype-2"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/savage

QA_TEXTRELS="${dir:1}/libs/libfmod.so
	${dir:1}/libs/libfmod-3.75.so"
QA_EXECSTACK="${dir:1}/libs/libfmod.so
	${dir:1}/libs/libfmod-3.75.so"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f graveyard/game.dll *.sh
	sed \
		-e "s:%GAMES_PREFIX_OPT%:${GAMES_PREFIX_OPT}:" \
		"${FILESDIR}"/savage > "${T}"/savage \
		|| die "sed failed"
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
