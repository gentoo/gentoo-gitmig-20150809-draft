# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/snipes/snipes-1.0.1.ebuild,v 1.3 2007/02/07 08:33:20 nyhm Exp $

inherit toolchain-funcs flag-o-matic games

DESCRIPTION="2D scrolling shooter, resembles old DOS game of same name"
HOMEPAGE="http://geocities.com/fnorddaemon/"
SRC_URI="http://geocities.com/fnorddaemon/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl"

src_compile() {
	tc-export CC
	append-flags $(sdl-config --cflags)
	append-ldflags $(sdl-config --libs)

	emake bin2h || die "bin2h failed"
	./bitms.sh || die "./bitms.sh failed"
	emake snipes || die "snipes failed"
}

src_install() {
	dogamesbin snipes || die "dogamesbin failed"
	doman snipes.6
	prepgamesdirs
}
