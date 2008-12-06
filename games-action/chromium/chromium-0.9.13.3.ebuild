# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/chromium/chromium-0.9.13.3.ebuild,v 1.2 2008/12/06 15:03:38 nyhm Exp $

inherit eutils games

DESCRIPTION="Chromium B.S.U. - an arcade game"
HOMEPAGE="http://chromium-bsu.sourceforge.net/"
SRC_URI="mirror://sourceforge/chromium-bsu/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mixer sdl"

DEPEND="media-fonts/dejavu
	>=media-libs/ftgl-2.1.3_rc5
	media-libs/glpng
	virtual/opengl
	virtual/glu
	x11-libs/libXmu
	mixer? ( media-libs/sdl-mixer )
	!mixer? ( media-libs/freealut
		media-libs/openal )
	sdl? ( media-libs/libsdl )
	!sdl? ( virtual/glut )"
RDEPEND="${DEPEND}"

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--with-font-path="/usr/share/fonts/dejavu/DejaVuSerif-Bold.ttf" \
		$(use_enable mixer sdlmixer) \
		$(use_enable !mixer openal) \
		$(use_enable sdl) \
		$(use_enable !sdl glut)

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# remove installed /usr/games/share stuff
	rm -rf "${D}"/"${GAMES_PREFIX}"/share/
	doicon misc/${PN}.png || die "doicon failed"
	make_desktop_entry chromium "Chromium B.S.U"

	# install documentation
	dodoc AUTHORS README NEWS || die "dodoc failed"
	dohtml "${S}"/data/doc/*.htm || die "dohtml failed"
	cd "${S}"/data/doc/images
	insinto /usr/share/doc/${PF}/html/images
	doins *.jpg || die "doins failed"

	prepgamesdirs
}
