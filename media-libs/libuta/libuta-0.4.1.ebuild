# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libuta/libuta-0.4.1.ebuild,v 1.2 2002/05/27 17:27:38 drobbins Exp $

S=${WORKDIR}/${P}
SRC_URI="mirror://sourceforge/libuta/${P}.tar.gz"
HOMEPAGE="http://libuta.sourceforge.net/"
SLOT="0"
DEPEND="virtual/glibc
	>=media-libs/libsdl-1.2.3-r1
	=media-libs/freetype-1.3.1-r3
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.0.12
	>=dev-libs/libsigc++-1.0.4-r1"


src_compile() {

	./configure --host=${CHOST} --prefix=/usr || die
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

}
