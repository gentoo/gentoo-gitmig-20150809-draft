# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/scummvm-tools/scummvm-tools-0.6.0.ebuild,v 1.4 2004/07/01 05:23:12 mr_bones_ Exp $

inherit games

DESCRIPTION="utilities for the SCUMM game engine"
HOMEPAGE="http://scummvm.sourceforge.net/"
SRC_URI="mirror://sourceforge/scummvm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	local f

	for f in convbdf descumm desword2 extract md5table mm_nes_extract queenrebuild rescumm simon1decr simon2mp3
	do
		newgamesbin $f ${PN}-$f || die "newgamesbin $f failed"
	done
	dodoc README
	prepgamesdirs
}
