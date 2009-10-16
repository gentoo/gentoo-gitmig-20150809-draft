# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/wrogue/wrogue-0.7.7b.ebuild,v 1.3 2009/10/16 04:18:49 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Gothic science fantasy roguelike game"
HOMEPAGE="http://todoom.sourceforge.net/"
SRC_URI="mirror://sourceforge/todoom/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl"

src_prepare() {
	sed -i -e "s:./data/:${GAMES_DATADIR}/${PN}/:" \
		src/platform/unix/pl_unix.c || die "sed failed"
}

src_compile() {
	local myCPPFLAGS="-std=c99 -I. -I./lib -I./ui -I./generate"
	local myCFLAGS="$(sdl-config --cflags) ${CFLAGS}"
	emake -C src -f unix.mak MAKECMDGOALS=release STRIP_BINARY=NO \
		CFLAGS="${myCPPFLAGS} ${myCFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data/* || die "doins failed"
	dodoc changes.txt sc_guide.txt

	newicon data/engine/graphics/icon.bmp ${PN}.png
	make_desktop_entry ${PN} "Warp Rogue"

	prepgamesdirs
}
