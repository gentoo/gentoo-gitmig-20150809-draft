# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/legends/legends-0.3.6.ebuild,v 1.6 2004/12/04 17:53:10 wolf31o2 Exp $

inherit games

DESCRIPTION="A fast-paced first-person-perspective online multiplayer game similar to Tribes"
HOMEPAGE="http://epsilon.serverseed.com/~legends/"
SRC_URI="http://themasters.co.za/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE="dedicated"
RESTRICT="nomirror"

DEPEND=""
RDEPEND=">=media-libs/libsdl-1.2
	media-libs/openal"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm runlegends libSDL-*.so* libopenal.so
	find . -type f -exec chmod a-x '{}' \;
	chmod a+x ispawn lindedicated LinLegends
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}

	dodir ${dir}
	cp -R * ${D}/${dir}/ || die "cp failed"
	dogamesbin ${FILESDIR}/legends         || die "dogamesbin failed (1)"
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/legends
	if use dedicated ; then
		dogamesbin ${FILESDIR}/legends-ded || die "dogamesbin failed (2)"
		dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/legends-ded
	fi
	prepgamesdirs
}
