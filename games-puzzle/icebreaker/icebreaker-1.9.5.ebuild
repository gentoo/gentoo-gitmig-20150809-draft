# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/icebreaker/icebreaker-1.9.5.ebuild,v 1.11 2007/03/13 13:39:14 nyhm Exp $

inherit eutils games

DESCRIPTION="Trap and capture penguins on Antarctica"
HOMEPAGE="http://www.mattdm.org/icebreaker/"
SRC_URI="http://www.mattdm.org/${PN}/1.9.x/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i '/install/s/-s //' Makefile || die "sed failed"
}

src_compile() {
	emake \
		OPTIMIZE="${CFLAGS}" \
		prefix=/usr \
		bindir="${GAMES_BINDIR}" \
		datadir="${GAMES_DATADIR}" \
		highscoredir="${GAMES_STATEDIR}" \
		|| die "emake failed"
}

src_install() {
	einstall \
		prefix="${D}/usr" \
		bindir="${D}${GAMES_BINDIR}" \
		datadir="${D}${GAMES_DATADIR}" \
		highscoredir="${D}${GAMES_STATEDIR}" || die
	newicon ${PN}_48.bmp ${PN}.bmp
	make_desktop_entry ${PN} IceBreaker /usr/share/pixmaps/${PN}.bmp
	dodoc ChangeLog README* TODO
	prepgamesdirs
}
