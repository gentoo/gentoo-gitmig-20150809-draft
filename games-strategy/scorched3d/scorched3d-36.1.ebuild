# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/scorched3d/scorched3d-36.1.ebuild,v 1.1 2004/01/01 22:41:10 mr_bones_ Exp $

inherit games gcc eutils

DESCRIPTION="Multi-player tank battle in 3D (OpenGL)"
HOMEPAGE="http://www.scorched3d.co.uk/"
SRC_URI="mirror://sourceforge/scorched3d/Scorched3D-${PV}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

RDEPEND=">=media-libs/libsdl-1.0.1
	media-libs/sdl-net
	media-libs/sdl-mixer
	>=x11-libs/wxGTK-2.3.4
	dev-games/ode
	>=sys-libs/zlib-1.1.4"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/scorched

src_compile() {
	egamesconf \
		--exec_prefix=${GAMES_PREFIX} \
		--datadir=${GAMES_DATADIR}/${PN} \
		|| die
	sed -i \
		"s:/usr/games/scorched3d/:${GAMES_DATADIR}/${PN}/:" \
		src/scorched/Makefile \
		|| die "sed src/scorched/Makefile failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin src/scorched/scorched3d
	dodoc AUTHORS README TODO documentation/*.txt
	dodir ${GAMES_DATADIR}/${PN}
	cp -R data/ ${D}${GAMES_DATADIR}/${PN} || die "cp failed"
	prepgamesdirs
}
