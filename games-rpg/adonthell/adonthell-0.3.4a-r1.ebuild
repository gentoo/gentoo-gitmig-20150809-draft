# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/adonthell/adonthell-0.3.4a-r1.ebuild,v 1.1 2007/02/12 21:10:44 nyhm Exp $

inherit autotools eutils games

DESCRIPTION="roleplaying game engine"
HOMEPAGE="http://adonthell.linuxgames.com/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${PN}-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="doc nls"

RDEPEND="media-libs/sdl-ttf
	media-libs/sdl-mixer
	media-libs/libsdl
	dev-lang/swig
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	doc? (
		media-gfx/graphviz
		app-doc/doxygen
	)
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}-${PV/a/}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${PV}-configure.in.patch \
		"${FILESDIR}"/${P}-gcc-41.patch \
		"${FILESDIR}"/${P}-inline.patch \
		"${FILESDIR}"/${P}-external-libs.patch
	rm -f src/SDL_ttf.* # SDL_ttf
	rm -f src/{music*,SDL_mixer.h,wavestream*,mixer.c} # SDL_mixer
	rm -f ac{local,include}.m4
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--disable-py-debug \
		$(use_enable nls) \
		$(use_enable doc) \
		|| die
	touch doc/items/{footer,header}.html
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	keepdir "${GAMES_DATADIR}"/${PN}/games
	dodoc AUTHORS ChangeLog FULLSCREEN.howto NEWBIE NEWS README
	prepgamesdirs
}
