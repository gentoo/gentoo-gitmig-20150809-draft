# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/tuxdash/tuxdash-0.8.ebuild,v 1.3 2004/11/11 00:42:50 josejx Exp $

inherit games

DESCRIPTION="A simple BoulderDash clone"
HOMEPAGE="http://www.tuxdash.de/index.php?language=EN"
SRC_URI="http://www.tuxdash.de/ressources/downloads/${PN}_src_${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-ttf"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f GPL TuxDash
	sed -i \
		-e '/^Fullscreen/ s/0/1/' \
		-e "/^theme/ s:themes:${GAMES_DATADIR}/${PN}/themes:" \
		config || die "sed failed"
	sed -i \
		-e '/PWD/d' \
		-e '/CurrentDirectory;/d' \
		-e "s:CurrentDirectory:\"${GAMES_DATADIR}/${PN}\":" \
		src/main.cpp || die "sed failed"
	sed -i \
		-e 's/-Wall/$(E_CXXFLAGS)/' \
		-e 's/TuxDash/tuxdash/g' \
		src/Makefile || die "sed failed"
	find . -type f -print0 | xargs -0 chmod a-x
}

src_compile() {
	emake E_CXXFLAGS="${CXXFLAGS}" -C src || die "emake failed"
}

src_install() {
	dogamesbin tuxdash || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -r themes maps fonts savegames config "${D}/${GAMES_DATADIR}/${PN}" \
		|| die "cp failed"
	dodoc README*
	prepgamesdirs
}
