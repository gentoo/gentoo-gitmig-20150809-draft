# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/excido/excido-0.1.5c.ebuild,v 1.4 2004/11/08 01:35:37 josejx Exp $

inherit games toolchain-funcs

DESCRIPTION="A fast paced action game"
HOMEPAGE="http://icculus.org/excido/"
SRC_URI="http://icculus.org/excido/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="dev-games/physfs
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/sdl-image
	media-libs/openal"

src_compile() {
	emake \
		CC="$(tc-getCXX)" \
		PREFIX="/usr" \
		BINDIR="${GAMES_BINDIR}/" \
		DATADIR="${GAMES_DATADIR}/${PN}/" \
		|| die "emake failed"
}

src_install() {
	dodir "${GAMES_BINDIR}" "${GAMES_DATADIR}/${PN}"
	make \
		PREFIX="${D}/usr" \
		BINDIR="${D}${GAMES_BINDIR}/" \
		DATADIR="${D}${GAMES_DATADIR}/${PN}/" \
		install || die "make install failed"
	dodoc BUGS CHANGELOG HACKING INSTALL README TODO \
		keyguide.txt data/CREDITS data/*.txt
	prepgamesdirs
}
