# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gcube/gcube-0.4.ebuild,v 1.1 2005/05/26 00:25:16 mr_bones_ Exp $

inherit games

DESCRIPTION="Gamecube emulator"
HOMEPAGE="http://gcube.exemu.net/"
SRC_URI="http://gcube.exemu.net/downloads/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="virtual/opengl
	media-libs/libsdl
	sys-libs/ncurses
	sys-libs/zlib"

S=${WORKDIR}/${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^CFLAGS=-g/d' Makefile.rules \
		|| die "sed failed"
}

src_install() {
	local x

	dogamesbin gcmap gcube || die "dogamesbin failed"
	for x in bin2dol isopack tplx ; do
		newgamesbin ${x} ${PN}-${x} || die "newgamesbin failed"
	done
	dodoc ChangeLog README
	prepgamesdirs
}
