# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/kajaani-kombat/kajaani-kombat-0.4.ebuild,v 1.1 2004/04/06 03:24:03 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A rampart-like game set in space"
HOMEPAGE="http://kombat.kajaani.net/"
SRC_URI="http://kombat.kajaani.net/dl/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-net
	media-libs/sdl-image
	media-libs/sdl-ttf
	sys-libs/ncurses
	sys-libs/readline"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${PV}-makefile.patch"
	sed -i \
		-e "/^CXXFLAGS/ s:-Wall:${CXXFLAGS}:" Makefile \
			|| die "sed Makefile failed"
}

src_install() {
	dodir "${GAMES_BINDIR}" "${GAMES_DATADIR}/${PN}" /usr/share/man/man6
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
	prepgamesdirs
}
