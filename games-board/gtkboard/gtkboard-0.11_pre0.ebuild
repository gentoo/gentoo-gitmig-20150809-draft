# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gtkboard/gtkboard-0.11_pre0.ebuild,v 1.4 2004/02/29 10:13:56 vapier Exp $

inherit games

MY_P=${P/_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Board games system"
HOMEPAGE="http://gtkboard.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkboard/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND=">=x11-libs/gtk+-2
	>=media-libs/libsdl-1.2
	media-libs/sdl-mixer"

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--datadir="${GAMES_DATADIR}/${PN}" || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog TODO
	dohtml doc/index.html
	prepgamesdirs
}
