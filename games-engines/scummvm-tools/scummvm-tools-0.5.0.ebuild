# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/scummvm-tools/scummvm-tools-0.5.0.ebuild,v 1.2 2004/02/20 06:27:48 mr_bones_ Exp $

inherit games

DESCRIPTION="utilities for the SCUMM game engine"
HOMEPAGE="http://scummvm.sourceforge.net/"
SRC_URI="mirror://sourceforge/scummvm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND=""

src_unpack() {
	unpack ${A}
	sed -i "s:-g -O -Wall:${CFLAGS}:" ${S}/Makefile
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dogamesbin descumm descumm6 extract rescumm simon1decr simon2mp3
	dodoc README
	prepgamesdirs
}
