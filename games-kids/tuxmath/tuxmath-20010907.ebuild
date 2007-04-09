# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/tuxmath/tuxmath-20010907.ebuild,v 1.10 2007/04/09 21:28:09 welp Exp $

inherit eutils toolchain-funcs games

MY_P="${PN}-2001.09.07-0102"
DESCRIPTION="Educational arcade game where you have to solve math problems"
HOMEPAGE="http://www.newbreedsoftware.com/tuxmath/"
SRC_URI="mirror://sourceforge/tuxmath/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -rf $(find -name CVS -o -name .xvpics -type d)
	rm -f docs/COPYING.txt
	sed -i \
		-e '/strip/d' \
		-e "1i CC=$(tc-getCC)" \
		-e "s/-O2/${CFLAGS}/" \
		-e "s:\$(DATA_PREFIX):${GAMES_DATADIR}/${PN}:" \
		Makefile \
		|| die "sed failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/{images,sounds} || die "doins failed"
	newicon data/images/icon.png ${PN}.png
	make_desktop_entry ${PN} "Tux Math"
	dodoc docs/*.txt
	prepgamesdirs
}
