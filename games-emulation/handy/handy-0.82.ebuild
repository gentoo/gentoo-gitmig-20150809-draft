# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/handy/handy-0.82.ebuild,v 1.4 2004/07/01 11:14:57 eradicator Exp $

inherit games

MY_RLS="R1"
DESCRIPTION="A Atari Lynx emulator for Linux"
HOMEPAGE="http://sdlemu.ngemu.com/handysdl.php"
SRC_URI="http://sdlemu.ngemu.com/releases/Handy-SDL-${PV}${MY_RLS}.i386.linux-glibc22.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

RDEPEND="media-libs/libsdl
	sys-libs/zlib
	virtual/libc
	sys-libs/lib-compat"

S=${WORKDIR}

src_install() {
	exeinto /opt/bin
	newexe sdlhandy handy || die "doexe failed"
	dohtml -r docs/*
	prepgamesdirs
}
