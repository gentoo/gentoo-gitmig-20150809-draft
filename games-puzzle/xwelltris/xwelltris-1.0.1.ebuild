# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xwelltris/xwelltris-1.0.1.ebuild,v 1.1 2003/09/10 06:36:01 vapier Exp $

inherit games

DESCRIPTION="tetris like popular game"
HOMEPAGE="http://xnc.dubna.su/xwelltris/"
SRC_URI="http://xnc.dubna.su/xwelltris/src/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="sdl"

DEPEND="|| (
		sdl? ( media-libs/libsdl )
		virtual/x11
	)"

src_compile() {
	# configure/build process is pretty messed up
	egamesconf `use_with sdl` || die
	sed -i "/GLOBAL_SEARCH/s:\".*\":\"${GAMES_DATADIR}/${PN}\":" src/include/globals.h
	emake || die
}

src_install() {
	dodir ${GAMES_BINDIR} ${GAMES_DATADIR}/${PN} /usr/share/man
	make install \
		INSTDIR=${D}/${GAMES_BINDIR} \
		INSTLIB=${D}/${GAMES_DATADIR}/${PN} \
		INSTMAN=/usr/share/man \
		|| die
	dodoc AUTHORS Changelog README*
	prepgamesdirs
}
