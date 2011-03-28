# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/chromium/chromium-0.9.15.ebuild,v 1.3 2011/03/28 13:20:39 phajdan.jr Exp $

EAPI=2
inherit eutils games

MY_P="${PN}-bsu-${PV}"
DESCRIPTION="Chromium B.S.U. - an arcade game"
HOMEPAGE="http://chromium-bsu.sourceforge.net/"
SRC_URI="mirror://sourceforge/chromium-bsu/${MY_P}.tar.gz"

LICENSE="Clarified-Artistic"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="mixer nls +sdl"

RDEPEND="media-fonts/dejavu
	media-libs/quesoglc
	media-libs/glpng
	virtual/opengl
	virtual/glu
	x11-libs/libXmu
	mixer? ( media-libs/sdl-mixer )
	!mixer? (
		media-libs/freealut
		media-libs/openal
	)
	nls? ( virtual/libintl )
	sdl? (
		media-libs/libsdl[X]
		media-libs/sdl-image[png]
	)
	!sdl? ( media-libs/freeglut )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${MY_P}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--disable-ftgl \
		--enable-glc \
		$(use_enable mixer sdlmixer) \
		$(use_enable !mixer openal) \
		$(use_enable nls) \
		$(use_enable sdl) \
		$(use_enable sdl sdlimage) \
		$(use_enable !sdl glut)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# remove installed /usr/games/share stuff
	rm -rf "${D}"/"${GAMES_PREFIX}"/share/
	newicon misc/${PN}-bsu.png  ${PN}.png || die "doicon failed"
	make_desktop_entry ${PN}-bsu "Chromium B.S.U"

	# install documentation
	dodoc AUTHORS README NEWS || die "dodoc failed"
	dohtml "${S}"/data/doc/*.htm || die "dohtml failed"
	cd "${S}"/data/doc/images
	insinto /usr/share/doc/${PF}/html/images
	doins *.jpg || die "doins failed"

	prepgamesdirs
}
