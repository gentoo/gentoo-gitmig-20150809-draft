# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/gnuboy/gnuboy-1.0.3.ebuild,v 1.4 2003/06/29 20:06:54 aliz Exp $

DESCRIPTION="Gameboy emulator with multiple renderers"
HOMEPAGE="http://gnuboy.unix-fu.org/"
SRC_URI="http://gnuboy.unix-fu.org/src/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
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
