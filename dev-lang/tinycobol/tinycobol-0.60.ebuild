# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tinycobol/tinycobol-0.60.ebuild,v 1.3 2003/06/27 11:44:22 phosphan Exp $

DESCRIPTION="tinycobol - COBOL for linux."
HOMEPAGE="http://tiny-cobol.sf.net"
SRC_URI="mirror://sourceforge/tiny-cobol/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"

DEPEND="virtual/glibc
		>=dev-libs/glib-2.0
		=sys-libs/db-3*"
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
