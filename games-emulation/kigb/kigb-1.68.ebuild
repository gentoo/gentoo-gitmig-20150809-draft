# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/kigb/kigb-1.68.ebuild,v 1.1 2004/08/31 11:15:11 mr_bones_ Exp $

inherit games

DESCRIPTION="A Gameboy (GB, SGB, GBA) Emulator for Linux"
HOMEPAGE="http://kigb.emuunlim.com"
# No version upstream
#SRC_URI="http://kigb.emuunlim.com/${PN}_lin.tar.gz"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

RDEPEND="virtual/libc
	virtual/x11
	sys-libs/zlib
	dev-games/hawknl"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# use the system version
	rm -f libNL.so*
	# wrapper script creates these in the users' home directories.
	rm -rf cfg inp snap state rom save
	cp "${FILESDIR}/kigb" "${T}/" || die "cp failed"
	sed -i \
		-e "s:GENTOODIR:${GAMES_PREFIX_OPT}:" "${T}/kigb" \
		|| die "sed failed"
}

src_install() {
	dogamesbin "${T}/kigb" || die "dogamesbin failed"
	exeinto "${GAMES_PREFIX_OPT}/${PN}"
	doexe kigb || die "doexe failed"
	dodoc doc/*
	prepgamesdirs
}
