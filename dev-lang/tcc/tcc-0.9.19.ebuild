# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tcc/tcc-0.9.19.ebuild,v 1.1 2003/06/06 05:34:36 george Exp $

IUSE=""

DESCRIPTION="A very small C compiler for ix86"
HOMEPAGE="http://www.tinycc.org/"
SRC_URI="http://fabrice.bellard.free.fr/tcc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"

DEPEND="virtual/glibc"

src_compile() {
	econf || die "configure failed"
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
	#autoconf for the package does not create dirs if they are missing for some reason
	dodir /usr/bin
	dodir /usr/lib/tcc
	dodir /usr/share/man/man1
	dodir /usr/include
	make prefix=${D}/usr \
		bindir=${D}/usr/bin/ \
		libdir=${D}/usr/lib/ \
		includedir=${D}/usr/include/ \
		mandir=${D}/usr/share/man/ install || die
	dodoc Changelog README TODO
	dohtml tcc-doc.html
	mkdir ${D}/usr/share/doc/${PF}/examples
	cp ex*.c ${D}/usr/share/doc/${PF}/examples/
}
