# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/moagg/moagg-0.15.ebuild,v 1.1 2004/11/03 22:35:25 mr_bones_ Exp $

inherit games

DESCRIPTION="MOAGG (Mother Of All Gravity Games) combines several different gravity-type games"
HOMEPAGE="http://moagg.sourceforge.net"
SRC_URI="mirror://sourceforge/moagg/${P}-src.tar.bz2
	mirror://sourceforge/moagg/${P}-data.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.6
	>=media-libs/sdl-mixer-1.2.4
	>=media-libs/sdl-gfx-2.0.8
	>=media-libs/freetype-2.1.4
	sys-libs/zlib
	>=dev-libs/expat-1.95.6
	=media-libs/paragui-1.0*"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# We don't want the docs inside ${GAMES_DATADIR}/doc, so we don't
	# let "make install" do the doc install.
	sed -i \
		-e '/^CXXFLAGS/ s/@CXXFLAGS_CONFIG@.*/@CXXFLAGS_CONFIG@/' \
		-e '/^install:/s/install-doc//' Makefile.in \
		|| die "sed Makefile.in failed"
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
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO doc/*.tex
	prepgamesdirs
}
