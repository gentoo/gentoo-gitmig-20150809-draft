# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/icebreaker/icebreaker-1.9.5.ebuild,v 1.10 2006/06/29 15:59:40 wolf31o2 Exp $

inherit games

DESCRIPTION="Trap and capture penguins on Antarctica"
HOMEPAGE="http://www.mattdm.org/icebreaker/"
SRC_URI="http://www.mattdm.org/icebreaker/1.9.x/${P}.tgz"

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

	dodoc ChangeLog README* TODO
	prepgamesdirs
}
