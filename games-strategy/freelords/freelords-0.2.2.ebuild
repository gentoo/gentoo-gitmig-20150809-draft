# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freelords/freelords-0.2.2.ebuild,v 1.1 2003/09/10 05:27:31 vapier Exp $

inherit games

DESCRIPTION="Free Warlords clone"
HOMEPAGE="http://www.freelords.org/"
SRC_URI="http://download.freelords.org/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="dev-libs/expat
	>=media-libs/libsdl-1.2.0
	>=media-libs/paragui-1.0.0
	>=dev-libs/libsigc++-1.2.1
	>=media-libs/sdl-image-1.2.0
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	sed -i \
		-e "s:\.\./pic:${GAMES_DATADIR}/${PN}/pic:" \
		-e "s:\.\./dat:${GAMES_DATADIR}/${PN}/dat:" \
		`egrep '\.\./(pic|dat)' * -RIl`
}

src_compile() {
	egamesconf --disable-paraguitest || die
	make || die
}

src_install() {
	dogamesbin src/freelords src/*.py
	for lib in src/*/*.so ; do
		dogameslib.so ${lib}
		lib=`basename ${lib}`
		dosym ${lib} ${GAMES_LIBDIR}/${lib}.${PV}
	done

	dodir ${GAMES_DATADIR}/${PN}
	cp -rf dat pic ${D}/${GAMES_DATADIR}/${PN}/

	dodoc AUTHORS BUGS ChangeLog DEPENDENCIES HACKER NEWS README TODO doc/*

	prepgamesdirs
}
