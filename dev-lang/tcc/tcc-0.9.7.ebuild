# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tcc/tcc-0.9.7.ebuild,v 1.11 2004/07/14 13:59:42 agriffis Exp $

DESCRIPTION="A very small C compiler for ix86"
HOMEPAGE="http://www.tinycc.org/"
LICENSE="GPL-2"
DEPEND=""
SRC_URI="http://fabrice.bellard.free.fr/tcc/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86 -sparc"
IUSE=""

src_compile() {
	mv Makefile Makefile.orig || die
	sed -e 's:prefix=/usr/local:prefix=/usr:g' Makefile.orig > Makefile || die
	emake || die
}

src_install () {
	dodir /usr/bin
	dodir /usr/lib
	make prefix=${D}/usr install || die
	dodoc Changelog README TODO ex*.c
	dohtml tcc-doc.html
}
