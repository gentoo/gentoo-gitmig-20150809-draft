# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gngeo/gngeo-0.5.9a.ebuild,v 1.2 2004/02/20 06:26:47 mr_bones_ Exp $

DESCRIPTION="A NeoGeo emulator"
HOMEPAGE="http://m.peponas.free.fr/gngeo/"
SRC_URI="http://m.peponas.free.fr/gngeo/download/${P}.tar.gz"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="sys-libs/zlib
	x86? ( >=dev-lang/nasm-0.98 )
	>=media-libs/libsdl-1.2"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS NEWS README sample_gngeorc
}

pkg_postinst() {
	einfo
	einfo "A licensed NeoGeo BIOS copy is required to run the emulator."
	einfo
}
