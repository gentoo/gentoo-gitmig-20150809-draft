# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/solarwolf/solarwolf-1.4.ebuild,v 1.2 2004/01/29 07:07:33 mr_bones_ Exp $

inherit games

DESCRIPTION="action/arcade recreation of SolarFox"
HOMEPAGE="http://www.pygame.org/shredwheat/solarwolf/"
SRC_URI="http://www.pygame.org/shredwheat/solarwolf/${P}.tar.gz"

KEYWORDS="x86 sparc"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=">=dev-python/pygame-1.5.6
	>=dev-lang/python-2.3
	media-libs/libsdl"

src_unpack() {
	unpack ${A}
	find ${S} -name .xvpics | xargs rm -rf
}

src_install() {
	dodoc readme.txt || die "dodoc failed"
	dodir "${GAMES_LIBDIR}/${PN}"
	cp -r code/ data/ *py "${D}/${GAMES_LIBDIR}/${PN}/" || die "cp failed"
	games_make_wrapper solarwolf "python ./solarwolf.py" "${GAMES_LIBDIR}/${PN}"
	prepgamesdirs
}
