# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="gnuboy is a Gameboy / Gameboy Color emulator with multiple renderers."
HOMEPAGE="http://gnuboy.unix-fu.org"
SRC_URI="http://gnuboy.unix-fu.org/src/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

RDEPEND="media-libs/libsdl"
DEPEND="${RDEPEND}"

src_compile() {
   econf
   emake || die
}

src_install() {
   dodoc INSTALL README docs/CHANGES docs/CONFIG docs/CREDITS docs/FAQ docs/HACKING docs/WHATSNEW
   dobin fbgnuboy sdlgnuboy sgnuboy xgnuboy
}
