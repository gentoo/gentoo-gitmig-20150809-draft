# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/scourge/scourge-0.1.ebuild,v 1.1 2004/01/26 11:12:49 mr_bones_ Exp $

inherit games

S="${WORKDIR}/${P/-/_}"
DESCRIPTION="A rogue-like adventure game to eliminate pests"
HOMEPAGE="http://scourge.sf.net"
SRC_URI="mirror://sourceforge/scourge/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/x11
	virtual/glut
	virtual/opengl
	>=media-libs/libsdl-1.2
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	sed -i \
		-e "s:\"data/:\"${GAMES_DATADIR}/${PN}/data/:g" \
			shapepalette.cpp text.cpp \
				|| die "sed failed"
}

src_install() {
	dogamesbin scourge || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -r data/ "${D}${GAMES_DATADIR}/${PN}" || die "cp failed"
	dodoc AUTHORS README || die "dodoc failed"
	prepgamesdirs
}
