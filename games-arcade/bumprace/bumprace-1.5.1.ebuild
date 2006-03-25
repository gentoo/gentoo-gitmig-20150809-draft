# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/bumprace/bumprace-1.5.1.ebuild,v 1.2 2006/03/25 01:25:24 tupone Exp $

inherit games

DESCRIPTION="simple arcade racing game"
HOMEPAGE="http://www.linux-games.com/bumprace/"
SRC_URI="http://user.cs.tu-berlin.de/~karlb/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.1.5
	media-libs/sdl-mixer
	media-libs/jpeg
	media-libs/sdl-image"

src_install() {
	make DESTDIR=${D} install
	dodoc AUTHORS ChangeLog FAQ README || die "installing docs failed"

	prepgamesdirs
}
