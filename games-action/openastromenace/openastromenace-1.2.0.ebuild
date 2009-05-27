# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/openastromenace/openastromenace-1.2.0.ebuild,v 1.4 2009/05/27 14:23:14 nyhm Exp $

EAPI=2
inherit cmake-utils eutils games

DESCRIPTION="Modern 3D space shooter with spaceship upgrade possibilities"
HOMEPAGE="http://sourceforge.net/projects/openastromenace/"
SRC_URI="mirror://sourceforge/${PN}/openamenace-src-${PV}.tar.bz2
	mirror://sourceforge/${PN}/oamenace-data-${PV}.tar.bz2
	mirror://sourceforge/${PN}/oamenace-lang-en-${PV}.tar.bz2
	linguas_de? ( mirror://sourceforge/${PN}/oamenace-lang-de-${PV}.tar.bz2 )
	linguas_ru? ( mirror://sourceforge/${PN}/oamenace-lang-ru-${PV}.tar.bz2 )
	mirror://gentoo/${PN}.png"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="linguas_de linguas_ru"

DEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl[joystick]
	media-libs/openal
	media-libs/freealut
	media-libs/libogg
	media-libs/libvorbis
	media-libs/jpeg"

S=${WORKDIR}/OpenAstroMenaceSVN

src_prepare() {
	epatch "${FILESDIR}"/${P}-cmake.patch
}

src_configure() {
	local mycmakeargs="-DDATADIR=${GAMES_DATADIR}/${PN}"
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	newgamesbin "${CMAKE_BUILD_DIR}"/AstroMenace ${PN} || die "newgamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r ../DATA ../*.vfs || die "doins failed"
	dosym gamelang_en.vfs "${GAMES_DATADIR}"/${PN}/gamelang.vfs
	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry ${PN} OpenAstroMenace
	dodoc ReadMe.txt
	prepgamesdirs
}
