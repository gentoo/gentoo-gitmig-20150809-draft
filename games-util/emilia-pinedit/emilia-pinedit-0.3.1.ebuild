# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/emilia-pinedit/emilia-pinedit-0.3.1.ebuild,v 1.13 2006/04/01 10:39:00 tupone Exp $

inherit eutils games

MY_P=${PN/emilia-/}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A table-editor for the emilia-pinball"
HOMEPAGE="http://pinball.sourceforge.net/"
SRC_URI="mirror://sourceforge/pinball/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

# A lot of deps are inherited from emilia-pinball, so we don't repeat
# them here.
RDEPEND="virtual/xft
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	>=games-arcade/emilia-pinball-0.3.1"
DEPEND="${RDEPEND}
	|| ( x11-libs/libXt virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "/^CFLAGS=/s:-g -W -Wall:${CFLAGS}:" \
		-e "/^CXXFLAGS=/s:-g -W -Wall:${CXXFLAGS}:" \
		configure \
		|| die "sed configure failed"
	sed -i \
		-e "/^LDFLAGS/s:$:$(pinball-config --libs) @LIBS@ -lSDL -lSDL_image -lSDL_mixer:" \
		pinedit/Makefile.in \
		|| die "sed pinedit/Makefile.in failed"
	epatch ${FILESDIR}/${PV}-assert.patch \
		"${FILESDIR}"/${P}-gcc4.patch
}

src_compile() {
	egamesconf || die
	emake -j1 || die
}

src_install() {
	dodoc AUTHORS NEWS README
	make DESTDIR=${D} install || die "make install failed"
	rm -rf ${D}/${GAMES_PREFIX}/{include,lib}
	prepgamesdirs
}
