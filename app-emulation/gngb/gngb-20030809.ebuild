# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/gngb/gngb-20030809.ebuild,v 1.1 2003/08/09 09:57:27 hanno Exp $

DESCRIPTION="gngb - Gameboy / Gameboy Color emulator"
HOMEPAGE="http://m.peponas.free.fr/gngb/"
SRC_URI="http://m.peponas.free.fr/gngb/download/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 -ppc"
SLOT="0"
IUSE="opengl"

RDEPEND="media-libs/libsdl
	opengl? ( virtual/opengl )"

src_compile() {
	use opengl || myconf=" --with-gl "
	econf ${myconf}
	emake || die
}

src_install() {
	dodoc NEWS README TODO INSTALL AUTHORS
	make DESTDIR=${D} install || die
}
