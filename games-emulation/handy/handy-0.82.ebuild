# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit games

MY_RLS="R1"
DESCRIPTION="A Atari Lynx emulator for Linux"
HOMEPAGE="http://sdlemu.ngemu.com/handysdl.php"
SRC_URI="http://sdlemu.ngemu.com/releases/Handy-SDL-${PV}${MY_RLS}.i386.linux-glibc22.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"

RDEPEND="media-libs/libsdl
	sys-libs/zlib
	virtual/glibc
	sys-libs/lib-compat"

S=${WORKDIR}

src_install() {
	exeinto /opt/bin
	newexe sdlhandy handy || die "doexe failed"
	dohtml -r docs/*
	prepgamesdirs
}
