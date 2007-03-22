# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/bumprace/bumprace-1.5.3.ebuild,v 1.1 2007/03/22 00:49:39 mr_bones_ Exp $

inherit games

DESCRIPTION="simple arcade racing game"
HOMEPAGE="http://www.linux-games.com/bumprace/"
SRC_URI="http://user.cs.tu-berlin.de/~karlb/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/jpeg
	media-libs/sdl-image"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog FAQ README
	prepgamesdirs
}
