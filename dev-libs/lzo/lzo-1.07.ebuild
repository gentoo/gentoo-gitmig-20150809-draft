# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bryce Allen <ballen@mum.edu>
# Maintainer Jon Nelson <jnelson@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/lzo/lzo-1.07.ebuild,v 1.1 2002/04/13 18:56:08 jnelson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An extremely fast compression and decompression library"
HOMEPAGE="http://www.oberhumer.com/opensource/lzo/"
SRC_URI="http://www.oberhumer.com/opensource/lzo/download/${P}.tar.gz"

DEPEND="virtual/glibc"

src_compile() {
	./configure \
	--enable-shared \
	--host=${CHOST} \
	--prefix=/usr \
	--infodir=/usr/share/info \
	--mandir=/usr/share/man || die "./configure failed"

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README THANKS doc/LZO*

	docinto examples
	dodoc examples/*.c examples/Makefile
}

