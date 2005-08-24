# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/rocksndiamonds/rocksndiamonds-3.1.1.ebuild,v 1.1 2005/08/24 05:11:21 mr_bones_ Exp $

inherit flag-o-matic eutils games

DESCRIPTION="A Boulderdash clone"
HOMEPAGE="http://www.artsoft.org/rocksndiamonds/"
SRC_URI="http://www.artsoft.org/RELEASES/unix/rocksndiamonds/${P}.tar.gz
	http://www.artsoft.org/RELEASES/rocksndiamonds/levels/BD2K3-1.0.0.zip
	http://www.artsoft.org/RELEASES/rocksndiamonds/levels/rnd-contrib-1.0.0.tar.gz
	http://www.artsoft.org/RELEASES/unix/rocksndiamonds/levels/rockslevels-emc-1.0.tar.gz
	http://www.artsoft.org/RELEASES/unix/rocksndiamonds/levels/rockslevels-sp-1.0.tar.gz
	http://www.artsoft.org/RELEASES/unix/rocksndiamonds/levels/rockslevels-dx-1.0.tar.gz
	http://www.artsoft.org/RELEASES/rocksndiamonds/levels/Snake_Bite-1.0.0.zip
	http://www.jb-line.de/rnd_jue-v6.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="X sdl"

RDEPEND="virtual/libc
	app-arch/unzip
	X? ( virtual/x11 )
	!sdl? ( virtual/x11 )
	sdl? ( >=media-libs/libsdl-1.2.3
		>=media-libs/sdl-mixer-1.2.4
		media-libs/sdl-net
		>=media-libs/sdl-image-1.2.2 )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	unpack \
		rockslevels-emc-1.0.tar.gz \
		rockslevels-sp-1.0.tar.gz \
		rockslevels-dx-1.0.tar.gz

	# make it parallel-friendly.
	sed -i \
		-e 's:\$(MAKE_CMD):$(MAKE) -C $(SRC_DIR):' \
		-e '/^MAKE/d' \
		Makefile \
		|| die "sed failed"

	cd levels
	unpack \
		rnd_jue-v6.zip \
		BD2K3-1.0.0.zip \
		rnd-contrib-1.0.0.tar.gz \
		Snake_Bite-1.0.0.zip
}

src_compile() {
	replace-cpu-flags k6 k6-1 k6-2 i586

	local makeopts="RO_GAME_DIR=${GAMES_DATADIR}/${PN} RW_GAME_DIR=${GAMES_STATEDIR}/${PN}"
	if use X || { ! use X && ! use sdl; } ; then
		make clean || die
		emake ${makeopts} OPTIONS="${CFLAGS}" x11 || die
		mv rocksndiamonds{,.x11}
	fi
	if use sdl ; then
		make clean || die
		emake ${makeopts} OPTIONS="${CFLAGS}" sdl || die
		mv rocksndiamonds{,.sdl}
	fi
}

src_install() {
	dogamesbin rocksndiamonds.x11 || die "dogamesbin failed"
	if use sdl ; then
		dogamesbin rocksndiamonds.sdl || die "dogamesbin failed"
		dosym rocksndiamonds.sdl "${GAMES_BINDIR}/rocksndiamonds"
	else
		dosym rocksndiamonds.x11 "${GAMES_BINDIR}/rocksndiamonds"
	fi
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r graphics levels music sounds || die "doins failed"

	newman rocksndiamonds.{1,6}
	dodoc CHANGES CREDITS HARDWARE README TODO docs/elements/*.txt
	make_desktop_entry rocksndiamonds "Rocks 'N' Diamonds"

	prepgamesdirs
}
