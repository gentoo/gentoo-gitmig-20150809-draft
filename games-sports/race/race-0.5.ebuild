# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/race/race-0.5.ebuild,v 1.1 2003/09/11 12:26:35 vapier Exp $

inherit games gcc eutils

DESCRIPTION="OpenGL Racing Game"
HOMEPAGE="http://projectz.org/?id=70"
SRC_URI="ftp://users.freebsd.org.uk/pub/foobar2k/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/${PV}-gentoo.patch
	sed -i \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:g" \
		-e "s:GENTOO_CONFDIR:${GAMES_SYSCONFDIR}:g" \
		*.c
}

src_compile() {
	emake CC="$(gcc-getCC) ${CFLAGS}" || die
}

src_install() {
	dogamesbin race
	insinto ${GAMES_SYSCONFDIR}
	newins config race.conf
	dodir ${GAMES_DATADIR}/${PN}
	mv data/* ${D}/${GAMES_DATADIR}/${PN}/
	dodoc README
	prepgamesdirs
}
