# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libuta/libuta-0.4.1-r1.ebuild,v 1.4 2002/07/11 06:30:39 drobbins Exp $

S=${WORKDIR}/${P}
SRC_URI="mirror://sourceforge/libuta/${P}.tar.gz"
HOMEPAGE="http://libuta.sourceforge.net/"
SLOT="0"
DEPEND="virtual/glibc
	>=media-libs/libsdl-1.2.3-r1
	=media-libs/freetype-1.3*
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.0.12
	( >=dev-libs/libsigc++-1.0.4-r1
	  <dev-libs/libsigc++-1.1.0 )"


src_compile() {

	./configure --host=${CHOST} --prefix=/usr || die
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

}
