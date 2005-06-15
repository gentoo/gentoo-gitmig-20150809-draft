# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/adonthell/adonthell-0.3.4a.ebuild,v 1.2 2005/06/15 19:02:21 wolf31o2 Exp $

inherit eutils games

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
	sys-libs/zlib"
DEPEND="${RDEPEND}
	doc? (
		media-gfx/graphviz
		app-doc/doxygen )
	sys-devel/autoconf"

S=${WORKDIR}/${PN}-${PV/a/}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-configure.in.patch"
	aclocal && automake -a && autoconf || die "autotools failed"
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
	make DESTDIR="${D}" install || die "make install failed"
	keepdir "${GAMES_DATADIR}/${PN}/games"
	dodoc AUTHORS ChangeLog FULLSCREEN.howto NEWBIE NEWS README
	prepgamesdirs
}
