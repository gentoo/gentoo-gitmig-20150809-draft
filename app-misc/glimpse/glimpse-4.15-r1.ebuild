# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/glimpse/glimpse-4.15-r1.ebuild,v 1.9 2004/10/05 13:34:51 pvdabeel Exp $

inherit eutils

DESCRIPTION="A index/query system to search a large set of files quickly"
HOMEPAGE="http://webglimpse.net/"
SRC_URI="http://webglimpse.net/trial/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc ~mips alpha amd64 ia64"
IUSE=""

RDEPEND="!dev-libs/tre
	virtual/libc"
DEPEND="virtual/libc"

src_compile() {
	epatch ${FILESDIR}/${PV}-errno.patch
	make distclean || die
	econf || die
	make || die
}

src_install() {
	einstall || die
	dodir /usr/share/man/man1
	mv ${D}/usr/share/man/*.1 ${D}/usr/share/man/man1/
}
