# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xpired/xpired-1.22.ebuild,v 1.7 2005/10/31 08:41:40 mr_bones_ Exp $

inherit games

DESCRIPTION="A Sokoban-styled puzzle game with lots more action."
HOMEPAGE="http://xpired.sourceforge.net"
SRC_URI="mirror://sourceforge/xpired/${P}-linux_source.tar.gz"

KEYWORDS="~amd64 ~ppc x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/libc
	media-libs/sdl-gfx
	media-libs/sdl-image
	media-libs/sdl-mixer"

S=${WORKDIR}/src

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
