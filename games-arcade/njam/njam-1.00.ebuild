# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/njam/njam-1.00.ebuild,v 1.3 2004/02/20 06:20:00 mr_bones_ Exp $

inherit eutils games

MY_P="${P}-src"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Multi or single-player network Pacman-like game in SDL"
HOMEPAGE="http://njam.sourceforge.net/"
SRC_URI="mirror://sourceforge/njam/${MY_P}.tar.gz"
RESTRICT="nomirror"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

RDEPEND=">=media-libs/sdl-mixer-1.2.5
	>=media-libs/sdl-image-1.2.2
	>=media-libs/libsdl-1.2.5
	>=media-libs/sdl-net-1.2.4"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	# store the conf file in the user's home directory.
	epatch ${FILESDIR}/${P}-conf.patch

	sed -i \
		-e "s:\"data:\"${GAMES_DATADIR}/${PN}/data:" njam.cpp njamgame.cpp || \
			die "sed njam.cpp and njamgame.cpp failed"
	sed -i \
		-e "s:\"hiscore.dat:\"${GAMES_STATEDIR}/${PN}/hiscore.dat:" \
		-e "s:\"skins:\"${GAMES_DATADIR}/${PN}/skins:" njam.cpp || \
			die "sed njam.cpp failed"
	sed -i \
		-e "s:\"levels:\"${GAMES_DATADIR}/${PN}/levels:" njamedit.cpp || \
			die "sed njamedit.cpp failed"
	sed -i \
		-e "s:\"log.txt:\"/dev/null:" njamutils.cpp || \
			die "sed njamutils.cpp failed"
	sed -i \
		-e "s:-O3:${CFLAGS}:" Makefile || \
			die "sed Makefile failed"
}

src_compile() {
	emake PREFIX="/usr/share" || die "emake failed"
}

src_install() {
	dogamesbin njam                 || die "dogamesbin failed"
	dodoc CHANGES README TODO       || die "dodoc failed"
	dohtml html/*                   || die "dohtml failed"
	insinto ${GAMES_DATADIR}/njam/data
	doins data/*                    || die "doins failed (data)"
	insinto ${GAMES_DATADIR}/njam/skins
	doins skins/*                   || die "doins failed (skins)"
	insinto ${GAMES_DATADIR}/njam/levels
	doins levels/*                  || die "doins failed (levels)"
	dodir "${GAMES_STATEDIR}/${PN}" || die "dodir failed"
	touch "${D}${GAMES_STATEDIR}/${PN}/hiscore.dat"
	fperms 664 "${GAMES_STATEDIR}/${PN}/hiscore.dat" || die "fperms failed"
	prepgamesdirs
}
