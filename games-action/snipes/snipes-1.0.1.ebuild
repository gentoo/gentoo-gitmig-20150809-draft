# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/snipes/snipes-1.0.1.ebuild,v 1.2 2005/02/12 01:18:30 mr_bones_ Exp $

inherit toolchain-funcs flag-o-matic games

DESCRIPTION="2D scrolling shooter, resembles old DOS game of same name"
HOMEPAGE="http://geocities.com/fnorddaemon/"
SRC_URI="http://geocities.com/fnorddaemon/snipes-1.0.1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="virtual/libc
	>=media-libs/libsdl-1.2.0"

src_compile() {
	export CC=$(tc-getCC)
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
