# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/infones/infones-0.91.ebuild,v 1.2 2004/01/02 07:42:10 vapier Exp $

inherit games

MY_P="InfoNES${PV//.}J_Src"
S=${WORKDIR}/${MY_P}/linux
DESCRIPTION="A fast and portable NES emulator"
HOMEPAGE="http://www.geocities.co.jp/SiliconValley/5604/infones/"
SRC_URI="http://www.geocities.co.jp/SiliconValley/5604/bin/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="=x11-libs/gtk+-1.2*"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:-O2:${CFLAGS}:" Makefile || die "sed Makefile failed"
}

src_install() {
	dogamesbin InfoNES
	dohtml ../doc/readme.html
	prepgamesdirs
}
