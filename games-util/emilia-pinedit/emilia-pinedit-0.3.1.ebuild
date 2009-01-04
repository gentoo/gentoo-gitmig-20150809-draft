# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/emilia-pinedit/emilia-pinedit-0.3.1.ebuild,v 1.17 2009/01/04 23:03:26 ulm Exp $

EAPI=1

inherit eutils qt3 games

MY_P=${PN/emilia-/}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A table-editor for the emilia-pinball"
HOMEPAGE="http://pinball.sourceforge.net/"
SRC_URI="mirror://sourceforge/pinball/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""
RESTRICT="userpriv" # needs to read ${GAMES_LIBDIR}

# A lot of deps are inherited from emilia-pinball, so we don't repeat
# them here.
DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	x11-libs/libXft
	x11-libs/libXt
	x11-libs/qt:3
	>=games-arcade/emilia-pinball-0.3.1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^CFLAGS=/s:-g -W -Wall:${CFLAGS}:" \
		-e "/^CXXFLAGS=/s:-g -W -Wall:${CXXFLAGS}:" \
		configure \
		|| die "sed configure failed"
	sed -i \
		-e "/^LDFLAGS/s:$: $(pinball-config --libs) @LIBS@ -lSDL -lSDL_image -lSDL_mixer:" \
		pinedit/Makefile.in \
		|| die "sed pinedit/Makefile.in failed"
	epatch "${FILESDIR}"/${PV}-assert.patch \
		"${FILESDIR}"/${P}-gcc4.patch
}

src_compile() {
	egamesconf || die
	emake MOC="${QTDIR}"/bin/moc -j1 || die "emake failed"
}

src_install() {
	dodoc AUTHORS NEWS README
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -rf "${D}/${GAMES_PREFIX}"/{include,lib}
	prepgamesdirs
}
