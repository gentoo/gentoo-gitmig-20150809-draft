# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/neopocott/neopocott-0.38b.ebuild,v 1.4 2004/06/24 22:31:26 agriffis Exp $

inherit games

MY_RLS="R2.1"
DESCRIPTION="A NeoGeo Pocket emulator for Linux"
HOMEPAGE="http://sdlemu.ngemu.com/neopocottsdl.php"
SRC_URI="http://sdlemu.ngemu.com/releases/NeoPocott-SDL-${PV}${MY_RLS}.i386.linux-glibc22.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

RDEPEND="media-libs/libsdl
	sys-libs/zlib
	virtual/glibc"

S=${WORKDIR}

src_install() {
	exeinto /opt/bin
	doexe neopocott || die "doexe failed"
	dodoc doc/*
	prepgamesdirs
}
