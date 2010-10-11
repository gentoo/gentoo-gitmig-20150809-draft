# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/icebreaker/icebreaker-1.9.5.ebuild,v 1.13 2010/10/11 16:12:26 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Trap and capture penguins on Antarctica"
HOMEPAGE="http://www.mattdm.org/icebreaker/"
SRC_URI="http://www.mattdm.org/${PN}/1.9.x/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i '/install/s/-s //' Makefile || die "sed failed"
	epatch "${FILESDIR}"/${P}-ldflags.patch
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
