# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tinycobol/tinycobol-0.61.ebuild,v 1.4 2004/03/24 10:48:15 phosphan Exp $

inherit eutils

DESCRIPTION="COBOL for linux"
HOMEPAGE="http://tiny-cobol.sourceforge.net/"
SRC_URI="mirror://sourceforge/tiny-cobol/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86"

DEPEND=">=dev-libs/glib-2.0
	sys-libs/db"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.patch
}

src_compile() {
	econf || die
	make || die "make failed"
}

src_install() {
	dodir /usr/bin
	dodir /usr/man/man1
	dodir /usr/lib
	dodir /usr/share/htcobol
	make prefix="${D}/usr" install
	dodoc AUTHORS ChangeLog README STATUS
	cd ${D}/usr/lib
	rm libhtcobol.so libhtcobol.so.0
	ln -s libhtcobol.so.0.* libhtcobol.so.0
	ln -s libhtcobol.so.0 libhtcobol.so
}
