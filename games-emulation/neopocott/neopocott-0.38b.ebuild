# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/neopocott/neopocott-0.38b.ebuild,v 1.7 2006/09/19 19:11:16 wolf31o2 Exp $

inherit games

MY_RLS="R2.1"
DESCRIPTION="A NeoGeo Pocket emulator for Linux"
HOMEPAGE="http://sdlemu.ngemu.com/neopocottsdl.php"
SRC_URI="http://sdlemu.ngemu.com/releases/NeoPocott-SDL-${PV}${MY_RLS}.i386.linux-glibc22.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
RESTRICT="strip"
IUSE=""

RDEPEND="media-libs/libsdl
	sys-libs/zlib
	virtual/libc"

S=${WORKDIR}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	exeinto "${dir}"
	doexe neopocott || die "doexe failed"
	dodoc doc/*
	games_make_wrapper neopocott ./neopocott "${dir}" "${dir}"
	prepgamesdirs
}
