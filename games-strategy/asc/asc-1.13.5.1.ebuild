# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/asc/asc-1.13.5.1.ebuild,v 1.1 2003/09/10 05:27:31 vapier Exp $

inherit games

DESCRIPTION="turn based strategy game designed in the tradition of the Battle Isle series"
HOMEPAGE="http://www.asc-hq.org/"
SRC_URI="mirror://sourceforge/asc-hq/asc-source-${PV}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-image-1.2
	>=media-libs/sdl-mixer-1.2
	>=media-libs/sdlmm-0.1.8
	>=media-libs/paragui-1.0.1"

src_compile() {
	egamesconf \
		--datadir=${GAMES_DATADIR_BASE} \
		--with-gnu-ld \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc COPYING README TODO

	prepgamesdirs
}
