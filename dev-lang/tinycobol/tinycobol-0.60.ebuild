# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/cvsroot/gentoo-x86/dev-lang

DESCRIPTION="tinycobol - COBOL for linux."
HOMEPAGE="http://tiny-cobol.sf.net"
SRC_URI="mirror://sourceforge/tiny-cobol/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"

DEPEND="virtual/glibc
		>=dev-libs/glib-2.0
		>=sys-libs/db-3.0"
KEYWORDS="~x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}.patch
}

src_compile() {
	econf --with-libdb=3 
	make || die "make failed"
}

src_install () {
	dodir /usr/bin
	dodir /usr/man/man1
	dodir /usr/lib
	dodir /usr/share/htcobol
	einstall
	dodoc AUTHORS ChangeLog README STATUS
}
