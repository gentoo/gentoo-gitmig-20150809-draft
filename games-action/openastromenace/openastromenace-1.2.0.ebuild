# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/openastromenace/openastromenace-1.2.0.ebuild,v 1.1 2008/05/08 14:15:03 nyhm Exp $

inherit eutils games

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

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/openal
	media-libs/freealut
	media-libs/libogg
	media-libs/libvorbis
	media-libs/jpeg"
DEPEND="${RDEPEND}
	dev-util/cmake"

S=${WORKDIR}/OpenAstroMenaceSVN

src_compile() {
	cmake -DDATADIR="${GAMES_DATADIR}"/${PN} . || die "cmake failed"
	emake || die "emake failed"
}

src_install() {
	newgamesbin AstroMenace ${PN} || die "newgamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r ../DATA ../*.vfs || die "doins failed"
	dosym gamelang_en.vfs "${GAMES_DATADIR}"/${PN}/gamelang.vfs
	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry ${PN} OpenAstroMenace
	dodoc ReadMe.txt
	prepgamesdirs
}
