# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/adonthell/adonthell-0.3.4a.ebuild,v 1.7 2006/10/20 06:43:51 nyhm Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"
inherit autotools eutils games

DESCRIPTION="roleplaying game engine"
HOMEPAGE="http://adonthell.linuxgames.com/"
SRC_URI="http://savannah.nongnu.org/download/adonthell/${PN}-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="doc nls"

RDEPEND="dev-lang/python
	>=media-libs/freetype-2
	media-libs/libsdl
	media-libs/libvorbis
	media-libs/libogg
	dev-lang/swig"
DEPEND="${RDEPEND}
	doc? (
		media-gfx/graphviz
		app-doc/doxygen
	)"

S=${WORKDIR}/${PN}-${PV/a/}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${PV}-configure.in.patch \
		"${FILESDIR}"/${P}-gcc-41.patch \
		"${FILESDIR}"/${P}-inline.patch
	rm -f ac{local,include}.m4
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	# the fugly --with-vorbis is to work around #98689
	egamesconf \
		--disable-dependency-tracking \
		--disable-py-debug \
		--with-vorbis="${T}" \
		$(use_enable nls) \
		$(use_enable doc) \
		|| die
	touch doc/items/{footer,header}.html
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	keepdir "${GAMES_DATADIR}/${PN}/games"
	dodoc AUTHORS ChangeLog FULLSCREEN.howto NEWBIE NEWS README
	prepgamesdirs
}
