# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/stoned-bin/stoned-bin-1.1.5.ebuild,v 1.1 2004/07/25 12:15:39 mr_bones_ Exp $

inherit games

DESCRIPTION="3D curling simulation"
HOMEPAGE="http://stoned.cute-ninjas.com/"
SRC_URI="http://stoned.cute-ninjas.com/download/${P/-bin}-i386-linux.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""
RESTRICT="nostrip"

RDEPEND="virtual/opengl
	virtual/glut
	media-libs/sdl-net
	media-libs/fmod
	sys-libs/zlib
	media-libs/libpng"

S="${WORKDIR}/${P/-bin}"

src_install() {
	into "${GAMES_PREFIX_OPT}"
	dobin stoned || die "dobin failed"
	dodoc FAQ README
	prepgamesdirs
}
