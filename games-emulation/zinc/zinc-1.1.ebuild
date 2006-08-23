# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/zinc/zinc-1.1.ebuild,v 1.3 2006/08/23 01:07:04 mr_bones_ Exp $

inherit games

DESCRIPTION="An x86 binary-only emulator for the Sony ZN-1, ZN-2, and Namco System 11 arcade systems"
HOMEPAGE="http://www.emuhype.com/"
SRC_URI="http://www.emuhype.com/files/${P//[-.]/}-lnx.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""
RESTRICT="strip"
QA_EXECSTACK="${GAMES_PREFIX_OPT/\/}/bin/zinc"

DEPEND="|| ( x11-libs/libXext
		virtual/x11 )
	virtual/opengl"

S=${WORKDIR}/zinc

src_install() {
	exeinto "${GAMES_PREFIX_OPT}"/bin
	doexe zinc || die "doexe failed"
	dolib.so libcontrolznc.so librendererznc.so libsoundznc.so libs11player.so
	dodoc readme.txt
	prepgamesdirs
}
