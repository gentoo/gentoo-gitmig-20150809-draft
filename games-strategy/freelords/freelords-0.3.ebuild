# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freelords/freelords-0.3.ebuild,v 1.4 2004/01/04 09:00:06 mr_bones_ Exp $

inherit games

DESCRIPTION="Free Warlords clone"
HOMEPAGE="http://www.freelords.org/"
SRC_URI="mirror://sourceforge/freelords/${PN}_${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="dev-libs/expat
	>=media-libs/libsdl-1.2.0
	>=media-libs/paragui-1.0.4
	>=dev-libs/libsigc++-1.2.1
	>=media-libs/sdl-image-1.2.0
	>=sys-apps/sed-4"

S=${WORKDIR}/${PN}_sdl

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:/etc/freelordsrc:${GAMES_SYSCONFDIR}/freelordsrc:" src/main.cpp
}

src_compile() {
	egamesconf --disable-paraguitest || die
	emake CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	make install DESTDIR=${D} || die

	dodir ${GAMES_SYSCONFDIR}
	mv ${D}/etc/freelordsrc ${D}/${GAMES_SYSCONFDIR}/

	dodoc AUTHORS BUGS ChangeLog DEPENDENCIES HACKER NEWS README TODO doc/*

	prepgamesdirs
}
