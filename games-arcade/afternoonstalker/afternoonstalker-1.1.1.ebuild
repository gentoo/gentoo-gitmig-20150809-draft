# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/afternoonstalker/afternoonstalker-1.1.1.ebuild,v 1.1 2007/03/24 10:06:11 tupone Exp $

inherit games

DESCRIPTION="Clone of the 1981 Night Stalker video game by Mattel Electronics"
HOMEPAGE="http://www3.sympatico.ca/sarrazip/dev/afternoonstalker.html"
SRC_URI="http://www3.sympatico.ca/sarrazip/dev/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	dev-games/flatzebra"

src_compile() {
	egamesconf || die "egamesconf failed"

	emake DGAMEDATADIR="${GAMES_DATADIR}/${PN}" \
		pkgsounddir="${GAMES_DATADIR}/${PN}/sounds" \
		|| die "emake failed"
}

src_install() {
	dogamesbin src/${PN} || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r src/data/* src/images/* src/sounds || die "doins failed"

	dodoc AUTHORS NEWS README THANKS TODO

	prepgamesdirs
}
