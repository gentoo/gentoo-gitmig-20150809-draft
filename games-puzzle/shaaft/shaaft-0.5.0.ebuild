# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/shaaft/shaaft-0.5.0.ebuild,v 1.5 2005/06/05 16:27:11 luckyduck Exp $

inherit eutils games

S="${WORKDIR}/${P/s/S}"
DESCRIPTION="A falling block game similar to Blockout"
HOMEPAGE="http://criticalmass.sourceforge.net/shaaft.php"
SRC_URI="mirror://sourceforge/criticalmass/${P/s/S}.tar.bz2"

KEYWORDS="x86 ~amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="virtual/x11
	virtual/opengl
	virtual/libc
	sys-libs/zlib
	media-libs/libpng
	>=media-libs/libsdl-1.2
	media-libs/sdl-mixer
	media-libs/sdl-image"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e 's:DATA_DIR:"'${GAMES_DATADIR}'\/'${PN/s/S}\/'":g' game/main.cpp \
			|| die "sed main.cpp failed"

	epatch ${FILESDIR}/${P}-gcc34.patch
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc TODO.txt || die "dodoc failed"
	prepgamesdirs
}
