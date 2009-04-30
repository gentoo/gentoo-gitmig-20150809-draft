# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/tuxmath/tuxmath-20010907.ebuild,v 1.11 2009/04/30 20:35:56 mr_bones_ Exp $

EAPI=2
inherit eutils games

MY_P="${PN}-2001.09.07-0102"
DESCRIPTION="Educational arcade game where you have to solve math problems"
HOMEPAGE="http://www.newbreedsoftware.com/tuxmath/"
SRC_URI="mirror://sourceforge/tuxmath/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image[jpeg,png]
	media-libs/sdl-mixer[mikmod]"

S=${WORKDIR}/${PN}

src_prepare() {
	find . -name CVS -o -name .xvpics -type d -exec rm -rf '{}' +
	rm -f docs/COPYING.txt
	sed -i \
		-e '/strip/d' \
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
