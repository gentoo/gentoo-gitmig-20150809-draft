# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@gentoo.org>

S=${WORKDIR}/sqlite
DESCRIPTION="SQLite: An SQL Database Engine in a C Library."
SRC_URI="http://www.hwaci.com/sw/sqlite/${P}.tar.gz"
HOMEPAGE="http://www.hwaci.com/sw/sqlite/"

DEPEND="virtual/glibc"


src_compile() {

	./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man
	emake || die
	
}

src_install () {
	
	dodir /usr/{bin,include,lib}
	make prefix=${D}/usr install || die
	make doc || die

	dobin lemon

	dodoc README VERSION doc/*.html doc/*.txt doc/*.png
	
}

