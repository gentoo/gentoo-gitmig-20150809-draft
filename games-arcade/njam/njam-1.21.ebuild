# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/njam/njam-1.21.ebuild,v 1.1 2004/09/11 07:22:55 mr_bones_ Exp $

inherit eutils flag-o-matic games

MY_P="${P}-src"
DESCRIPTION="Multi or single-player network Pacman-like game in SDL"
HOMEPAGE="http://njam.sourceforge.net/"
SRC_URI="miqrror://sourceforge/njam/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

DEPEND=">=media-libs/sdl-mixer-1.2.5
	>=media-libs/sdl-image-1.2.2
	>=media-libs/libsdl-1.2.5
	>=media-libs/sdl-net-1.2.4"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# store the conf file in the user's home directory.
	epatch "${FILESDIR}/${PV}-conf.patch"

	sed -i \
		-e "s:\"data:\"${GAMES_DATADIR}/${PN}/data:" njam.cpp njamgame.cpp \
		|| die "sed njam.cpp and njamgame.cpp failed"
	sed -i \
		-e "s:\"hiscore.dat:\"${GAMES_STATEDIR}/${PN}/hiscore.dat:" \
		-e "s:\"skins:\"${GAMES_DATADIR}/${PN}/skins:" njam.cpp \
		|| die "sed njam.cpp failed"
	sed -i \
		-e "s:\"levels:\"${GAMES_DATADIR}/${PN}/levels:" njamedit.cpp \
		|| die "sed njamedit.cpp failed"
	sed -i \
		-e "s:\"log.txt:\"/dev/null:" njamutils.cpp \
		|| die "sed njamutils.cpp failed"

	# njam segfaults on startup with -Os
	replace-flags "-Os" "-O2"

	sed -i \
		-e '/^PREFIX/s:=.*:=/usr/share:' \
		-e "s:-O3:${CFLAGS}:" Makefile \
		|| die "sed Makefile failed"
}

src_install() {
	dogamesbin njam || die "dogamesbin failed"
	dodoc CHANGES README TODO
	dohtml html/*
	dodir "${GAMES_DATADIR}/njam"
	cp -r data/ skins/ levels/ "${D}${GAMES_DATADIR}/njam" || die "cp failed"
	dodir "${GAMES_STATEDIR}/${PN}"
	touch "${D}/${GAMES_STATEDIR}/${PN}/hiscore.dat"
	fperms 664 "${GAMES_STATEDIR}/${PN}/hiscore.dat"
	prepgamesdirs
}
