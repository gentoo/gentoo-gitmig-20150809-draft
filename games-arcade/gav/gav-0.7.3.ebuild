# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/gav/gav-0.7.3.ebuild,v 1.2 2004/02/20 06:20:00 mr_bones_ Exp $

inherit games

DESCRIPTION="GPL Arcade Volleyball"
HOMEPAGE="http://gav.sourceforge.net"
# the themes are behind a lame php-counter script.
SRC_URI="mirror://sourceforge/gav/${P}.tar.gz
	mirror://gentoo/fabeach.tgz
	mirror://gentoo/inverted.tgz
	mirror://gentoo/naive.tgz
	mirror://gentoo/unnamed.tgz
	mirror://gentoo/yisus.tgz
	mirror://gentoo/yisus2.tgz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

RDEPEND="media-libs/sdl-image
	media-libs/sdl-net
	media-libs/libsdl"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

IUSE=""

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	cp Makefile.Linux Makefile               || die "cp 1 failed"
	cp automa/Makefile.Linux automa/Makefile || die "cp 2 failed"
	cp menu/Makefile.Linux menu/Makefile     || die "cp 3 failed"
	cp net/Makefile.Linux net/Makefile       || die "cp 4 failed"

	sed -i \
		-e "s:/usr/bin:${GAMES_BINDIR}:" Makefile || \
			die "sed Makefile failed"
	sed -i \
		-e "/-Wall/ s$ ${CXXFLAGS}" CommonHeader || \
			die "sed CommonHeader failed"

	# Now, unpack the additional themes
	cd ${S}/themes
	# unpack everything because it's easy
	unpack ${A}
	# and kill off what we don't want
	rm -rf ${P}

	# no reason to have executable files in the themes
	find . -type f -exec chmod a-x \{\} \;
}

src_install() {
	dodir ${GAMES_BINDIR}   || die "dodir failed"
	egamesinstall ROOT=${D} || die
	dodoc CHANGELOG README  || die "dodoc failed"
	prepgamesdirs
}
