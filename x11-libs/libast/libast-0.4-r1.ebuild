# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Grant Goodyear <g2boojum@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libast/libast-0.4-r1.ebuild,v 1.1 2002/01/17 20:55:34 g2boojum Exp $

S=${WORKDIR}/${P}
DESCRIPTION="LIBrary of Assorted Spiffy Things.  Needed for Eterm."
SRC_URI="http://www.eterm.org/download/${P}.tar.gz"
HOMEPAGE="http://www.eterm.org/download"

DEPEND="virtual/glibc
		virtual/x11
		>=media-libs/freetype-1.3"

src_compile() {
	# always disable mmx because binutils-2.11.92+ seems to be broken for this package
	myconf="--disable-mmx"
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man "${myconf}" || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README
}
