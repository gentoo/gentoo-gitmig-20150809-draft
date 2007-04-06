# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/solarwolf/solarwolf-1.5.ebuild,v 1.16 2007/04/06 00:47:31 nyhm Exp $

inherit eutils games

DESCRIPTION="action/arcade recreation of SolarFox"
HOMEPAGE="http://www.pygame.org/shredwheat/solarwolf/"
SRC_URI="http://www.pygame.org/shredwheat/solarwolf/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ~sparc x86"
IUSE=""

RDEPEND=">=dev-python/pygame-1.5.6"

pkg_setup() {
	if ! built_with_use media-libs/sdl-mixer mikmod ; then
		die "You need to build media-libs/sdl-mixer with USE=mikmod"
	fi
	games_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	find . -name .xvpics -print0 | xargs -0 rm -fr
}

src_install() {
	insinto "$(games_get_libdir)"/${PN}
	doins -r code data *py || die "doins lib failed"
	games_make_wrapper ${PN} "python ./solarwolf.py" "$(games_get_libdir)"/${PN}
	doicon dist/${PN}.png
	make_desktop_entry ${PN} SolarWolf
	dodoc readme.txt
	doman dist/${PN}.6.gz
	prepgamesdirs
}
