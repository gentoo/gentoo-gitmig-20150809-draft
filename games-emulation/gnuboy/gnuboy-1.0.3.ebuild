# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gnuboy/gnuboy-1.0.3.ebuild,v 1.5 2004/03/31 12:35:13 aliz Exp $

DESCRIPTION="Gameboy emulator with multiple renderers"
HOMEPAGE="http://gnuboy.unix-fu.org/"
SRC_URI="http://gnuboy.unix-fu.org/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"

RDEPEND="media-libs/libsdl"

src_install() {
	dodoc README docs/CHANGES docs/CONFIG docs/CREDITS docs/FAQ docs/HACKING docs/WHATSNEW
	dobin fbgnuboy sdlgnuboy sgnuboy xgnuboy || die
}
