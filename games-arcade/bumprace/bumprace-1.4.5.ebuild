# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/bumprace/bumprace-1.4.5.ebuild,v 1.1 2006/03/18 11:05:14 tupone Exp $

inherit games

MY_PV=${PV/./_}
MY_PV=${MY_PV/./}
MY_PV=${MY_PV/_/.}
MY_P=${PN}-${MY_PV}

DESCRIPTION="simple arcade racing game"
HOMEPAGE="http://www.linux-games.com/bumprace/"
SRC_URI="http://user.cs.tu-berlin.de/~karlb/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc"
IUSE=""

DEPEND=">=media-libs/libsdl-1.1.5
	media-libs/sdl-mixer
	sys-libs/zlib
	media-libs/jpeg
	media-libs/libpng"

S="${WORKDIR}/${MY_P}"

src_install() {
	egamesinstall || die
	dodoc AUTHORS ChangeLog FAQ NEWS README
	prepgamesdirs
}
