# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/snipes/snipes-1.0.0.ebuild,v 1.1 2005/01/29 05:39:03 vapier Exp $

inherit games toolchain-funcs

DESCRIPTION="2D scrolling shooter, resemble	s old DOS game of same name"
HOMEPAGE="http://geocities.com/fnorddaemon/"
SRC_URI="http://geocities.com/fnorddaemon/snipes-1.0.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="virtual/libc
	>=media-libs/libsdl-1.2.0"

src_compile() {
	$(tc-getCC) \
		$(sdl-config --cflags --libs) \
		${CFLAGS} ${LDFLAGS} \
		snipes.c -o snipes \
		|| die "compile failed"
}

src_install() {
	dogamesbin snipes || die "dogamesbin failed."
}
