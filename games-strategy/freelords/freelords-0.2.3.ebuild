# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freelords/freelords-0.2.3.ebuild,v 1.3 2004/01/04 09:00:06 mr_bones_ Exp $

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
	cd ${S}
	sed -i "s:/etc/freelordsrc:${GAMES_SYSCONFDIR}/freelordsrc:" src/{file,main}.cpp
	epatch ${FILESDIR}/${PV}-gcc3.patch
}

src_compile() {
	egamesconf --disable-paraguitest || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	insinto ${GAMES_SYSCONFDIR}
	doins ${FILESDIR}/freelordsrc
	dosed "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:" ${GAMES_SYSCONFDIR}/freelordsrc
	dosed "s:GENTOO_SAVEDIR:${GAMES_STATEDIR}:" ${GAMES_SYSCONFDIR}/freelordsrc

	dodoc AUTHORS BUGS ChangeLog DEPENDENCIES HACKER NEWS README TODO doc/*

	prepgamesdirs
}
