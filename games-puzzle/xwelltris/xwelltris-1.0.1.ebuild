# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xwelltris/xwelltris-1.0.1.ebuild,v 1.9 2005/01/13 01:40:52 vapier Exp $

inherit games

DESCRIPTION="tetris like popular game"
HOMEPAGE="http://xnc.dubna.su/xwelltris/"
SRC_URI="http://xnc.dubna.su/xwelltris/src/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc"
IUSE="sdl"

RDEPEND="virtual/x11
	sdl? ( media-libs/libsdl media-libs/sdl-image )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_compile() {
	# configure/build process is pretty messed up
	egamesconf $(use_with sdl) || die
	sed -i \
		-e "/GLOBAL_SEARCH/s:\".*\":\"${GAMES_DATADIR}/${PN}\":" \
			src/include/globals.h \
			|| die "sed src/include/globals.h failed"
	emake || die "emake failed"
}

src_install() {
	dodir "${GAMES_BINDIR}" "${GAMES_DATADIR}/${PN}" /usr/share/man
	make install \
		INSTDIR="${D}/${GAMES_BINDIR}" \
		INSTLIB="${D}/${GAMES_DATADIR}/${PN}" \
		INSTMAN=/usr/share/man \
		|| die "make install failed"
	dodoc AUTHORS Changelog README*
	prepgamesdirs
}
