# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gngeo/gngeo-0.6.1.ebuild,v 1.1 2004/03/31 07:14:07 mr_bones_ Exp $

inherit games

DESCRIPTION="A NeoGeo emulator"
HOMEPAGE="http://m.peponas.free.fr/gngeo/"
SRC_URI="http://m.peponas.free.fr/gngeo/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="virtual/glibc
	virtual/opengl
	sys-libs/zlib
	media-libs/sdl-image
	>=media-libs/libsdl-1.2"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	x86? ( >=dev-lang/nasm-0.98 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s/-malign-functions/-falign-functions/" \
		-e "s/-malign-loops/-falign-loops/" \
		-e "s/-malign-jumps/-falign-jumps/" \
		configure \
			|| die "sed failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README sample_gngeorc
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "A licensed NeoGeo BIOS copy is required to run the emulator."
	echo
}
