# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/insaneodyssey/insaneodyssey-000311.ebuild,v 1.5 2006/12/06 17:02:08 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Help West Muldune escape from a futuristic mental hospital"
HOMEPAGE="http://members.fortunecity.com/rivalentertainment/iox.html"
# Upstream has download issues.
#SRC_URI="http://members.fortunecity.com/rivalentertainment/io${PV}.tar.gz"
SRC_URI="mirror://gentoo/io${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2.7
	>=media-libs/sdl-mixer-1.2.5
	>=media-libs/sdl-image-1.2.3"

S=${WORKDIR}/${PN}

DEST_DIR=${GAMES_DATADIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}/${PN}"

	# Modify data load code and paths to game data
	epatch "${FILESDIR}/${P}-datafiles.patch"
	sed -i \
		-e "/lvl/s:^:${DEST_DIR}/:" \
		-e "s:night:${DEST_DIR}/night:" \
		levels.dat || die "sed levels.dat failed"
	sed -i \
		-e "s:tiles.dat:${DEST_DIR}/tiles.dat:" \
		-e "s:sprites.dat:${DEST_DIR}/sprites.dat:" \
		-e "s:levels.dat:${DEST_DIR}/levels.dat:" \
		-e "s:IO_T:${DEST_DIR}/IO_T:" \
		-e "s:tiles.att:${DEST_DIR}/tiles.att:" \
		-e "s:shot:${DEST_DIR}/shot:" \
		io.cpp || die "sed io.cpp failed"
	sed -i \
		-e 's:\[32:[100:' \
		io.h || die "sed io.h failed"
}

src_install() {
	cd ${PN}
	dogamesbin insaneodyssey || die "dogamesbin failed"
	insinto "${DEST_DIR}"
	doins *bmp *png *dat *att *lvl *wav *mod *IT || die "doins failed"
	prepgamesdirs
}
