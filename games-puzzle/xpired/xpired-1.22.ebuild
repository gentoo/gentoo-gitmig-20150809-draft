# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xpired/xpired-1.22.ebuild,v 1.3 2004/06/04 21:45:18 jhuebel Exp $

inherit games

S="${WORKDIR}/src"
DESCRIPTION="A Sokoban-styled puzzle game with lots more action."
HOMEPAGE="http://xpired.sourceforge.net"
SRC_URI="mirror://sourceforge/xpired/${P}-linux_source.tar.gz"

KEYWORDS="x86 ~amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc
	media-libs/sdl-gfx
	media-libs/sdl-image
	media-libs/sdl-mixer"

src_compile() {
	emake PREFIX=/usr/games SHARE_PREFIX=/usr/share/games/xpired || \
		die "emake failed"
}
src_install() {
	make \
		PREFIX="${D}/usr/games" \
		SHARE_PREFIX="${D}/usr/share/games/${PN}" \
		install || die "make install failed"
	prepgamesdirs
}
