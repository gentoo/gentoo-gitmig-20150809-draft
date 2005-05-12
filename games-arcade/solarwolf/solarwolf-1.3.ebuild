# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/solarwolf/solarwolf-1.3.ebuild,v 1.6 2005/05/12 17:48:14 mr_bones_ Exp $

inherit games

DESCRIPTION="action/arcade recreation of SolarFox"
HOMEPAGE="http://www.pygame.org/shredwheat/solarwolf/"
SRC_URI="http://www.pygame.org/shredwheat/solarwolf/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE=""

DEPEND="dev-python/pygame
	dev-lang/python
	media-libs/libsdl"

src_install() {
	dodoc readme.txt
	rm *.txt
	dodir ${GAMES_LIBDIR}/${PN}
	cp -r * ${D}/${GAMES_LIBDIR}/${PN}/
	dogamesbin ${FILESDIR}/solarwolf
	dosed "s:GENTOO_DIR:${GAMES_LIBDIR}/${PN}:" ${GAMES_BINDIR}/solarwolf
	prepgamesdirs
}
