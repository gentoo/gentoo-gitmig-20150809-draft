# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/shorten/shorten-3.3.ebuild,v 1.2 2002/07/11 06:30:41 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Open source, popular and fast lossless audio compressor"
SRC_URI="http://shnutils.etree.org/misc/${P}.tar.gz"
DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
#	mv Makefile Makefile.orig
#	sed -e "s:-O:${CFLAGS}:g" -e 's:/usr/local:/usr:g' -e 's:/man/:/share/man/:' Makefile.orig > Makefile
}

src_compile() {                           
	./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST}
	make || die
}

src_install() {                               
	make DESTDIR=${D} install || die
	dodoc LICENSE
}

