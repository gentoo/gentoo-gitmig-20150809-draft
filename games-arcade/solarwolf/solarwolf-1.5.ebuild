# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/solarwolf/solarwolf-1.5.ebuild,v 1.14 2006/09/27 16:30:34 nyhm Exp $

inherit eutils games

DESCRIPTION="action/arcade recreation of SolarFox"
HOMEPAGE="http://www.pygame.org/shredwheat/solarwolf/"
SRC_URI="http://www.pygame.org/shredwheat/solarwolf/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ~sparc x86"
IUSE=""

DEPEND=">=dev-python/pygame-1.5.6
	>=dev-lang/python-2.3
	media-libs/libsdl"

pkg_setup() {
	if ! built_with_use media-libs/sdl-mixer mikmod ; then
		die "You need to build media-libs/sdl-mixer with USE=mikmod"
	fi
	games_pkg_setup
}

src_unpack() {
	unpack ${A}
	find "${S}" -name .xvpics -print0 | xargs -0 rm -fr
}

src_install() {
	dodoc readme.txt
	doman dist/solarwolf.6.gz
	dodir "${GAMES_LIBDIR}/${PN}"
	cp -r code/ data/ *py "${D}/${GAMES_LIBDIR}/${PN}/" || die "cp failed"
	games_make_wrapper solarwolf "python ./solarwolf.py" "${GAMES_LIBDIR}/${PN}"
	doicon dist/solarwolf.png
	make_desktop_entry solarwolf
	prepgamesdirs
}
