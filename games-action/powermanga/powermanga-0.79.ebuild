# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/powermanga/powermanga-0.79.ebuild,v 1.5 2006/04/13 19:49:56 wolf31o2 Exp $

inherit games

DESCRIPTION="An arcade 2D shoot-em-up game"
HOMEPAGE="http://linux.tlk.fr/"
SRC_URI="http://linux.tlk.fr/games/Powermanga/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="virtual/libc
	>=media-libs/libsdl-0.11.0
	media-libs/sdl-mixer"

pkg_setup() {
	games_pkg_setup
	if ! built_with_use media-libs/sdl-mixer mikmod
	then
		eerror "${PN} needs sdl-mixer compiled with mikmod use-flag enabled!"
		die "sdl-mixer without mikmod detected"
	fi
}

src_compile() {
	egamesconf --prefix=/usr || die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	local f

	dogamesbin powermanga || die "dogamesbin failed"
	doman powermanga.6
	dodoc AUTHORS CHANGES README

	insinto "${GAMES_DATADIR}/powermanga/sounds"
	doins sounds/*

	insinto "${GAMES_DATADIR}/powermanga/graphics"
	doins graphics/*

	find "${D}${GAMES_DATADIR}/powermanga/" -name "Makefile*" -exec rm -f \{\} \;

	insinto /var/games
	for f in powermanga.hi-easy powermanga.hi powermanga.hi-hard
	do
		touch "${D}/var/games/${f}" || die "touch ${f} failed"
		fperms 660 "/var/games/${f}" || die "fperms ${f} failed"
	done

	prepgamesdirs
}
