# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit games

DESCRIPTION="A Gameboy (GB, SGB, GBA) Emulator for Linux"
HOMEPAGE="http://kigb.emuunlim.com"
SRC_URI="http://kigb.emuunlim.com/${PN}_lin.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

RDEPEND="dev-games/hawknl
	virtual/x11
	virtual/glibc"

S=${WORKDIR}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}
	cp -rf * ${D}/${dir}/
	dogamesbin ${FILESDIR}/kigb
	prepgamesdirs
}
