# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/scramble/scramble-0.7.ebuild,v 1.1 2004/03/05 09:43:35 mr_bones_ Exp $

inherit games

DESCRIPTION="Create as many words as you can before the time runs out"
HOMEPAGE="http://www.shiftygames.com/scramble/scramble.html"
SRC_URI="http://www.shiftygames.com/scramble/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-mixer-1.2
	>=media-libs/sdl-image-1.2
	media-libs/sdl-ttf"
RDEPEND="${DEPEND}
	sys-apps/miscfiles"

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--datadir=${GAMES_DATADIR_BASE} \
		|| die
	emake || die "emake faile"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	prepgamesdirs
}
