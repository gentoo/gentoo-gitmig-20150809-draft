# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gnuboy/gnuboy-1.0.3.ebuild,v 1.3 2004/03/02 09:39:37 dholm Exp $

DESCRIPTION="Gameboy emulator with multiple renderers"
HOMEPAGE="http://gnuboy.unix-fu.org/"
SRC_URI="http://gnuboy.unix-fu.org/src/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
SLOT="0"

RDEPEND="media-libs/libsdl"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dodoc README docs/CHANGES docs/CONFIG docs/CREDITS docs/FAQ docs/HACKING docs/WHATSNEW
	dobin fbgnuboy sdlgnuboy sgnuboy xgnuboy
}
