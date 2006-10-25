# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/infones/infones-0.97.ebuild,v 1.2 2006/10/25 23:35:03 nyhm Exp $

inherit games

MY_P="InfoNES${PV//.}J_Src"
DESCRIPTION="A fast and portable NES emulator"
HOMEPAGE="http://www.geocities.co.jp/SiliconValley/5604/infones/"
SRC_URI="mirror://sourceforge.jp/${PN}/16325/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="=x11-libs/gtk+-1.2*"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${MY_P}/linux

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:-O6:${CFLAGS}:" \
		-e "/^LDFILGS/s:=:=${LDFLAGS} :" \
		Makefile \
		|| die "sed Makefile failed"
}

src_install() {
	dogamesbin InfoNES || die "dogamesbin failed"
	dohtml ../doc/readme.html
	prepgamesdirs
}
