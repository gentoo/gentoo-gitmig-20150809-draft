# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gngeo/gngeo-0.5.9a.ebuild,v 1.3 2004/03/31 07:15:26 mr_bones_ Exp $

DESCRIPTION="A NeoGeo emulator"
HOMEPAGE="http://m.peponas.free.fr/gngeo/"
SRC_URI="http://m.peponas.free.fr/gngeo/download/${P}.tar.gz"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="sys-libs/zlib
	>=media-libs/libsdl-1.2"
DEPEND="${RDEPEND}
	x86? ( >=dev-lang/nasm-0.98 )"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS NEWS README sample_gngeorc
}

pkg_postinst() {
	einfo
	einfo "A licensed NeoGeo BIOS copy is required to run the emulator."
	einfo
}
