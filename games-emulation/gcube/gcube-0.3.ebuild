# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gcube/gcube-0.3.ebuild,v 1.1 2004/12/26 22:37:27 vapier Exp $

inherit games

DESCRIPTION="Gamecube emulator"
HOMEPAGE="http://gcube.exemu.net/"
SRC_URI="http://gcube.exemu.net/downloads/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/opengl
	media-libs/libsdl
	sys-libs/ncurses
	sys-libs/zlib"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i '/^CFLAGS=-g/d' Makefile.rules
}

src_install() {
	dogamesbin gcmap gcube || die "gcube"
	local x
	for x in bin2dol isopack tplx ; do
		newgamesbin ${x} ${PN}-${x} || die "${x} failed"
	done
	dodoc ChangeLog README
	prepgamesdirs
}
