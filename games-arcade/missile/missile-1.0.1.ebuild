# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/missile/missile-1.0.1.ebuild,v 1.2 2004/02/20 06:20:00 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="The Atari game Missile Command for Linux"
HOMEPAGE="http://missile.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-image-1.2.1
	>=media-libs/sdl-mixer-1.2.4
	media-libs/libpng
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-Makefile-path-fix.patch
	sed -i \
		-e "/^game_prefix/s:=GENTOO:=${GAMES_PREFIX}:" \
		-e "/^game_bin/s:=GENTOO:=${GAMES_PREFIX}/bin:" \
		-e "/^game_data/s:=GENTOO:=${GAMES_DATADIR}/${PN}:" \
		-e "/^game_icons/s:=GENTOO:=/usr/share/pixmaps/${PN}:" \
		-e "/^install_as_owner/s:=GENTOO:=${GAMES_USER}:" \
		-e "/^install_as_group/s:=GENTOO:=${GAMES_GROUP}:" \
		Makefile
}

src_compile() {
	make MYOPTS="${CFLAGS}" || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc README INSTALL
	prepgamesdirs
}
