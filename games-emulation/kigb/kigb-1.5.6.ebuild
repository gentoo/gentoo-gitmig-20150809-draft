# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/kigb/kigb-1.5.6.ebuild,v 1.4 2004/07/01 11:15:24 eradicator Exp $

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
	virtual/libc"

S=${WORKDIR}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}
	cp -rf * ${D}/${dir}/ || die
	dogamesbin ${FILESDIR}/kigb
	prepgamesdirs
}
