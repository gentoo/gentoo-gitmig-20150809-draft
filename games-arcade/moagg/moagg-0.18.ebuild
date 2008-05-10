# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/moagg/moagg-0.18.ebuild,v 1.4 2008/05/10 10:57:08 vapier Exp $

inherit eutils games

DESCRIPTION="MOAGG (Mother Of All Gravity Games) combines several different gravity-type games"
HOMEPAGE="http://moagg.sourceforge.net"
SRC_URI="mirror://sourceforge/moagg/${P}-src.tar.bz2
	mirror://sourceforge/moagg/${P}-data.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-gfx
	>=media-libs/freetype-2.3
	dev-libs/expat
	=media-libs/paragui-1.0*
	!>=media-libs/paragui-1.1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc42.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch
	# We don't want the docs inside ${GAMES_DATADIR}/doc, so we don't
	# let "make install" do the doc install.
	sed -i \
		-e '/^CXXFLAGS/ s/@CXXFLAGS_CONFIG@.*/@CXXFLAGS_CONFIG@/' \
		-e '/^install:/s/install-doc//' Makefile.in \
		|| die "sed failed"
}

src_compile() {
	# Turn off all the tests as they try to access /dev/svga, thus violating
	# the sandbox.
	egamesconf \
		--disable-sdltest \
		--disable-freetypetest \
		--disable-paraguitest \
		--disable-testsuite || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO doc/*.tex
	prepgamesdirs
}
