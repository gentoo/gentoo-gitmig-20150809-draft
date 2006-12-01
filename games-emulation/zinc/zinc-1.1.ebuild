# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/zinc/zinc-1.1.ebuild,v 1.4 2006/12/01 22:07:42 wolf31o2 Exp $

inherit games

DESCRIPTION="An x86 binary-only emulator for the Sony ZN-1, ZN-2, and Namco System 11 arcade systems"
HOMEPAGE="http://www.emuhype.com/"
SRC_URI="http://www.emuhype.com/files/${P//[-.]/}-lnx.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""
RESTRICT="strip"
QA_EXECSTACK="${GAMES_PREFIX_OPT:1}/bin/zinc"

DEPEND="x11-libs/libXext
	virtual/opengl"

S=${WORKDIR}/zinc

src_install() {
	exeinto "${GAMES_PREFIX_OPT}"/bin
	doexe zinc || die "doexe failed"
	dolib.so libcontrolznc.so librendererznc.so libsoundznc.so libs11player.so
	dodoc readme.txt
	prepgamesdirs
}
