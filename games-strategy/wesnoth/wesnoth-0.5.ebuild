# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/wesnoth/wesnoth-0.5.ebuild,v 1.3 2004/01/29 06:14:55 mr_bones_ Exp $

inherit games

S="${WORKDIR}/${PN}"
DESCRIPTION="A fantasy turn-based strategy game"
HOMEPAGE="http://www.wesnoth.org/"
SRC_URI="http://www.wesnoth.org/files/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-image-1.2
	>=media-libs/sdl-mixer-1.2
	>=media-libs/sdl-ttf-2.0
	media-libs/sdl-net
	virtual/x11"

src_compile() {
	CXXFLAGS="${CXXFLAGS} -DWESNOTH_PATH=\\\"${GAMES_DATADIR}/wesnoth\\\""
	emake || die "emake failed"
}

src_install() {
	dogamesbin wesnoth                || die "dogamesbin failed"
	dodoc MANUAL changelog            || die "dodoc failed"
	dodir ${GAMES_DATADIR}/wesnoth    || die "dodir failed"
	cp -r data fonts images music sounds \
		${D}${GAMES_DATADIR}/wesnoth/ || die "cp failed"

	# Tidy up the mess
	find ${D}${GAMES_DATADIR} -type f -exec chmod a-x \{\} \;
	find ${D} -name CVS | xargs rm -rf \{\} \;
	find ${D} -name .cvsignore -exec rm -f \{\} \;

	prepgamesdirs
}
