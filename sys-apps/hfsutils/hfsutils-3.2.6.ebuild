# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hfsutils/hfsutils-3.2.6.ebuild,v 1.11 2002/12/30 00:52:41 vapier Exp $

DESCRIPTION="HFS FS Access utils"
SRC_URI="ftp://ftp.mars.org/pub/hfs/${P}.tar.gz"
HOMEPAGE="http://www.mars.org/home/rob/proj/hfs/"

KEYWORDS="x86 ppc -sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"
RDEPEND=""

MAKEOPTS='PREFIX=/usr MANDIR=/usr/share/man'

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/lib
	dodir /usr/share/man/man1
	make \
		prefix=${D}/usr \
		MANDEST=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
}
