# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/tuxtype/tuxtype-1.0.3-r1.ebuild,v 1.9 2006/10/20 07:03:02 nyhm Exp $

inherit games

DESCRIPTION="Typing tutorial with lots of eye-candy"
HOMEPAGE="http://www.geekcomix.com/dm/tuxtype/"
SRC_URI="mirror://sourceforge/tuxtype/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-mixer-1.2
	>=media-libs/sdl-image-1.2"

src_compile() {
	egamesconf --disable-sdltest || die
	emake || die
}

src_install() {
	egamesinstall || die "install"

	# now fix where the installer put everything
	cd ${D}/${GAMES_PREFIX}/${PN}
	dohtml *.html ; rm -f *.html
	docfiles="`find -type f -maxdepth 1`"
	dodoc ${docfiles} ; rm -f ${docfiles}
	dodir ${GAMES_DATADIR}/${PN}
	mv * ${D}/${GAMES_DATADIR}/${PN}
	cd ${D}/${GAMES_PREFIX}
	rm -rf ${PN}

	prepgamesdirs
}
