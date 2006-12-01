# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-eternalspu/psemu-eternalspu-1.41-r2.ebuild,v 1.3 2006/12/01 21:42:05 wolf31o2 Exp $

inherit games

DESCRIPTION="PSEmu Eternal SPU"
HOMEPAGE="http://www1.odn.ne.jp/psx-alternative/"
SRC_URI="http://www1.odn.ne.jp/psx-alternative/download/spuEternal${PV//.}_linux.tgz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"
RESTRICT="strip"
IUSE=""

RDEPEND="x11-libs/libXext
	sys-libs/lib-compat"

S="${WORKDIR}"

src_install() {
	exeinto "${GAMES_LIBDIR}/psemu/plugins"
	doexe libspuEternal.so.*
	dodoc *.txt
	prepgamesdirs
}
