# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gngb/gngb-20040115.ebuild,v 1.1 2004/02/05 11:30:05 mr_bones_ Exp $

DESCRIPTION="Gameboy / Gameboy Color emulator"
HOMEPAGE="http://m.peponas.free.fr/gngb/"
SRC_URI="http://m.peponas.free.fr/gngb/download/${P}.tar.gz"

KEYWORDS="x86 -ppc"
LICENSE="GPL-2"
SLOT="0"

IUSE="opengl"

DEPEND="media-libs/libsdl
	sys-libs/zlib
	app-arch/bzip2
	opengl? ( virtual/opengl )"

src_compile() {
	econf `use_with opengl gl` || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}
