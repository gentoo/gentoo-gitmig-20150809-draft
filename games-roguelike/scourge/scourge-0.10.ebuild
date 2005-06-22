# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/scourge/scourge-0.10.ebuild,v 1.1 2005/06/22 17:14:52 mr_bones_ Exp $

inherit games

DESCRIPTION="A rogue-like adventure game to eliminate pests"
HOMEPAGE="http://scourge.sf.net"
SRC_URI="mirror://sourceforge/scourge/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/x11
	virtual/glu
	virtual/opengl
	>=media-libs/freetype-2
	>=media-libs/libsdl-1.2
	media-libs/sdl-net
	media-libs/sdl-mixer"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	find "${S}/data" -type f -exec chmod a-x \{\} \;
	cd "${S}"
	sed -i \
		-e "s:rootDir = (char\*)BR_DATADIR( \"/data\" ):rootDir=DATA_DIR:" \
		src/main.cpp \
		|| die "sed failed"
}

src_compile() {
	egamesconf \
		--with-data-dir="${GAMES_DATADIR}/${PN}/data" \
		|| die
	emake || die "emake failed"
}

src_install() {
	dogamesbin src/scourge || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -r data/ "${D}${GAMES_DATADIR}/${PN}" || die "cp failed"
	dodoc AUTHORS README || die "dodoc failed"
	prepgamesdirs
}
