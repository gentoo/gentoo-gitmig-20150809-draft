# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tcc/tcc-0.9.16.ebuild,v 1.6 2004/07/14 13:59:42 agriffis Exp $

DESCRIPTION="A very small C compiler for ix86"
HOMEPAGE="http://www.tinycc.org/"
SRC_URI="http://fabrice.bellard.free.fr/tcc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -sparc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	mv Makefile Makefile.orig || die
	sed -e 's:prefix=/usr/local:prefix=/usr:g' \
		-e 's:$(INSTALL) tcc.1 $(manpath)/man1::' \
		-e "s:-O2:${CFLAGS} -DRTLD_DEFAULT=NULL:g" \
		-e 's:-m386::g' \
		Makefile.orig > Makefile || die
	emake || die

	# Fix examples
	for example in ex*.c; do
		tail -n +2 $example >$example.temp
		echo '#! /usr/bin/env tcc' >$example
		cat $example.temp >>$example
		chmod 755 $example
	done
}

src_install() {
	dodir /usr/bin
	dodir /usr/lib
	make prefix=${D}/usr install || die
	doman tcc.1
	dodoc Changelog README TODO
	dohtml tcc-doc.html
	mkdir ${D}/usr/share/doc/${PF}/examples
	cp ex*.c ${D}/usr/share/doc/${PF}/examples/
}
