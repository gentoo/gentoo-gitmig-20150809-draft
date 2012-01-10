# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/pingus/pingus-0.7.5.ebuild,v 1.4 2012/01/10 20:19:52 ranger Exp $

EAPI=2
inherit eutils scons-utils toolchain-funcs games

DESCRIPTION="free Lemmings clone"
HOMEPAGE="http://pingus.seul.org/"
SRC_URI="http://pingus.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="opengl"

DEPEND="media-libs/libsdl[joystick,opengl?,video]
	media-libs/sdl-image[png]
	media-libs/sdl-mixer
	opengl? ( virtual/opengl )
	media-libs/libpng
	dev-libs/boost"

src_compile() {
	escons \
		CXX="$(tc-getCXX)" \
		CCFLAGS="${CXXFLAGS}" \
		LINKFLAGS="${LDFLAGS}" \
		$(use_scons opengl with_opengl) \
		|| die
}

src_install() {
	emake install-exec install-data \
		DESTDIR="${D}" \
		PREFIX="/usr" \
		DATADIR="${GAMES_DATADIR}/${PN}" \
		BINDIR="${GAMES_BINDIR}" \
		|| die
	doman doc/man/pingus.6
	newicon data/images/core/worldmap/pingus_standing.png ${PN}.png
	make_desktop_entry ${PN} Pingus
	dodoc AUTHORS NEWS README TODO
	prepgamesdirs
}
