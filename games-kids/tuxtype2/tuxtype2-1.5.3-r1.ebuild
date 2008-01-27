# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/tuxtype2/tuxtype2-1.5.3-r1.ebuild,v 1.2 2008/01/27 08:25:29 nyhm Exp $

inherit eutils games

DESCRIPTION="Typing tutorial with lots of eye-candy"
HOMEPAGE="http://www.geekcomix.com/dm/tuxtype/"
SRC_URI="mirror://sourceforge/tuxtype/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/sdl-ttf"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-checks.patch
	sed -i \
		-e 's:$(prefix)/share:'${GAMES_DATADIR}':g' \
		-e 's:$(prefix)/doc/$(PACKAGE):/usr/share/doc/'${PF}':g' \
		$(find -name Makefile.in) || die "fixing Makefile paths"
	sed -i \
		-e 's:/usr/share:'${GAMES_DATADIR}':' \
		tuxtype/theme.c || die "fixing src paths"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	prepalldocs
	doicon ${PN}.ico
	make_desktop_entry ${PN} TuxType2 /usr/share/pixmaps/${PN}.ico
	prepgamesdirs
}
