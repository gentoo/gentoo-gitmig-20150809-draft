# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/kigb/kigb-1.5.6.ebuild,v 1.2 2004/05/11 12:51:22 vapier Exp $

inherit games

DESCRIPTION="A Gameboy (GB, SGB, GBA) Emulator for Linux"
HOMEPAGE="http://kigb.emuunlim.com"
SRC_URI="http://kigb.emuunlim.com/${PN}_lin.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="dev-games/hawknl
	virtual/x11
	virtual/glibc"

S=${WORKDIR}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}
	cp -rf * ${D}/${dir}/ || die
	dogamesbin ${FILESDIR}/kigb
	prepgamesdirs
}
