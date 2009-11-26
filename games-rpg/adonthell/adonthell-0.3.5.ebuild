# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/adonthell/adonthell-0.3.5.ebuild,v 1.3 2009/11/26 04:01:28 mr_bones_ Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="roleplaying game engine"
HOMEPAGE="http://adonthell.linuxgames.com/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${PN}-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="doc nls"

RDEPEND="media-libs/sdl-ttf
	media-libs/sdl-mixer[vorbis]
	media-libs/libsdl[X,video,audio]
	sys-libs/zlib
	media-libs/freetype
	media-libs/libogg
	media-libs/libvorbis
	dev-lang/python
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-lang/swig
	doc? (
		media-gfx/graphviz
		app-doc/doxygen
	)
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}-${PV/a/}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-configure.in.patch \
		"${FILESDIR}"/${P}-glibc-2.10.patch
	rm -f ac{local,include}.m4
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--disable-py-debug \
		$(use_enable nls) \
		$(use_enable doc)
}

src_install() {
	emake DESTDIR="${D}" install || die
	keepdir "${GAMES_DATADIR}"/${PN}/games
	dodoc AUTHORS ChangeLog FULLSCREEN.howto NEWBIE NEWS README
	prepgamesdirs
}
