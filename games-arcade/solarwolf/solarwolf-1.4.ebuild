# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/solarwolf/solarwolf-1.4.ebuild,v 1.1 2004/01/08 14:34:39 vapier Exp $

inherit games

DESCRIPTION="action/arcade recreation of SolarFox"
HOMEPAGE="http://www.pygame.org/shredwheat/solarwolf/"
SRC_URI="http://www.pygame.org/shredwheat/solarwolf/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~sparc"

DEPEND=">=dev-python/pygame-1.5.6
	>=dev-lang/python-2.3
	media-libs/libsdl"

src_install() {
	dodoc readme.txt
	rm *.txt
	dodir ${GAMES_LIBDIR}/${PN}
	cp -r * ${D}/${GAMES_LIBDIR}/${PN}/
	games_make_wrapper solarwolf "python ./solarwolf.py" ${GAMES_LIBDIR}/${PN}
	prepgamesdirs
}
