# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/njam/njam-1.25.ebuild,v 1.1 2005/12/28 06:42:07 mr_bones_ Exp $

inherit eutils flag-o-matic games

MY_P="${P}-src"
DESCRIPTION="Multi or single-player network Pacman-like game in SDL"
HOMEPAGE="http://njam.sourceforge.net/"
SRC_URI="mirror://sourceforge/njam/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND=">=media-libs/sdl-mixer-1.2.5
	>=media-libs/sdl-image-1.2.2
	>=media-libs/libsdl-1.2.5
	>=media-libs/sdl-net-1.2.4"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:hiscore.dat:${GAMES_STATEDIR}/${PN}/\0:" \
		src/njam.cpp \
		|| die "sed failed"
	sed -i \
		-e "/hiscore.dat/ s:\$(DEFAULT_LIBDIR):${GAMES_STATEDIR}:" \
		Makefile.in \
		|| die "sed failed"
	# njam segfaults on startup with -Os
	replace-flags "-Os" "-O2"
}

src_install() {
	dodir "${GAMES_STATEDIR}/${PN}"
	make DESTDIR="${D}" install || die "make install failed"
	dohtml -r "${D}${GAMES_DATADIR}/njam/html/"*
	rm -rf "${D}${GAMES_DATADIR}/njam/html/"
	prepgamesdirs
}
