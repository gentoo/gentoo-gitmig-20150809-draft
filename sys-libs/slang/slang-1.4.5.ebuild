# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/slang/slang-1.4.5.ebuild,v 1.1 2002/02/20 15:54:59 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Console display library used by most text viewer"
SRC_URI="ftp://space.mit.edu/pub/davis/slang/v1.4/${P}.tar.gz"

DEPEND=">=sys-libs/ncurses-5.2-r2"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr || die "./configure failed"
	# emake doesn't work well with slang, so just use normal make.
	make all elf || die "make failed"
}

src_install() {
	make install install-elf DESTDIR=${D} || die "make install failed"
	# remove the documentation... we want to install it ourselves
	rm -rf ${D}/usr/share
	dodoc COPYING* NEWS README *.txt
	dodoc doc/*.txt doc/internal/*.txt doc/text/*.txt
	docinto html
	dodoc doc/*.html
}
