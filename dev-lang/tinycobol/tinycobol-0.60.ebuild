# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tinycobol/tinycobol-0.60.ebuild,v 1.8 2003/09/08 07:19:48 msterret Exp $

inherit eutils

DESCRIPTION="COBOL for linux"
HOMEPAGE="http://tiny-cobol.sourceforge.net/"
SRC_URI="mirror://sourceforge/tiny-cobol/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	>=dev-libs/glib-2.0
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
	einstall
	dodoc AUTHORS ChangeLog README STATUS
}
