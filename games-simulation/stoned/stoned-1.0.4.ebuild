# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/stoned/stoned-1.0.4.ebuild,v 1.5 2004/07/14 14:59:35 agriffis Exp $

inherit games

DESCRIPTION="3D curling simulation"
HOMEPAGE="http://www.webhome.de/stoned/"
SRC_URI="http://www.webhome.de/stoned/download/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

RDEPEND="virtual/opengl
	virtual/glut
	media-libs/sdl-net"

src_install() {
	into ${GAMES_PREFIX_OPT}
	dobin stoned
	dodoc FAQ README
	prepgamesdirs
}
