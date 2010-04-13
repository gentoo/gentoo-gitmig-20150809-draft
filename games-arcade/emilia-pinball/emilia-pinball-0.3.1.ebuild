# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/emilia-pinball/emilia-pinball-0.3.1.ebuild,v 1.16 2010/04/13 18:03:55 armin76 Exp $

EAPI=2
inherit eutils games

MY_PN=${PN/emilia-/}
MY_P=${MY_PN}-${PV}
DESCRIPTION="SDL OpenGL pinball game"
HOMEPAGE="http://pinball.sourceforge.net/"
SRC_URI="mirror://sourceforge/pinball/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

RDEPEND="virtual/opengl
	x11-libs/libSM
	media-libs/libsdl[opengl,video,X]
	media-libs/sdl-image[png]
	media-libs/sdl-mixer[vorbis]"
DEPEND="${RDEPEND}
	x11-libs/libXt"

S=${WORKDIR}/${MY_P}

PATCHES=( "${FILESDIR}"/${P}-glibc210.patch )

src_configure() {
	egamesconf --with-x
}

src_compile() {
	emake -j1 CXXFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	dodoc README || die "dodoc failed"
	emake DESTDIR="${D}" install || die "emake install failed"
	dosym "${GAMES_BINDIR}"/pinball "${GAMES_BINDIR}"/emilia-pinball
	mv "${D}/${GAMES_PREFIX}/include" "${D}/usr/" \
		|| die "mv failed (include)"
	dodir /usr/bin
	mv "${D}/${GAMES_BINDIR}/pinball-config" "${D}/usr/bin/" \
		|| die "mv failed (bin)"
	sed -i \
		-e 's:-I${prefix}/include/pinball:-I/usr/include/pinball:' \
		"${D}"/usr/bin/pinball-config || die "sed failed"
	newicon data/pinball.xpm ${PN}.xpm
	make_desktop_entry emilia-pinball "Emilia pinball"
	prepgamesdirs
}
