# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/solarwolf/solarwolf-1.4.ebuild,v 1.3 2004/01/29 08:43:52 vapier Exp $

inherit games

DESCRIPTION="action/arcade recreation of SolarFox"
HOMEPAGE="http://www.pygame.org/shredwheat/solarwolf/"
SRC_URI="http://www.pygame.org/shredwheat/solarwolf/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND=">=dev-python/pygame-1.5.6
	>=dev-lang/python-2.3
	media-libs/libsdl"

src_unpack() {
	unpack ${A}
	find ${S} -name .xvpics | xargs rm -rf
}

src_install() {
	dodoc readme.txt
	dodir ${GAMES_LIBDIR}/${PN}
	cp -r code/ data/ *py ${D}/${GAMES_LIBDIR}/${PN}/ || die "cp failed"
	games_make_wrapper solarwolf "python ./solarwolf.py" ${GAMES_LIBDIR}/${PN}
	insinto /usr/share/icons
	doins ${FILESDIR}/solarwolf.png
	make_desktop_entry solarwolf
	prepgamesdirs
}
