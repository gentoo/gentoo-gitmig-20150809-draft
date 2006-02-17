# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gemdropx/gemdropx-0.9-r1.ebuild,v 1.6 2006/02/17 22:01:54 tupone Exp $

inherit games

DESCRIPTION="A puzzle game where it's your job to clear the screen of gems"
HOMEPAGE="http://www.newbreedsoftware.com/gemdropx/"
SRC_URI="ftp://ftp.sonic.net/pub/users/nbs/unix/x/gemdropx/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.3-r1
	>=media-libs/sdl-mixer-1.2.1"

src_compile() {
	emake \
		DATA_PREFIX="${GAMES_DATADIR}/${PN}" \
		XTRA_FLAGS="${CFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dogamesbin gemdropx || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -r data/* "${D}/${GAMES_DATADIR}/${PN}/"
	dodoc AUTHORS.txt CHANGES.txt ICON.txt README.txt TODO.txt
	prepgamesdirs
}
