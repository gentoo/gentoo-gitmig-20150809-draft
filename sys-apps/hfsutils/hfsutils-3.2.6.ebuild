# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hfsutils/hfsutils-3.2.6.ebuild,v 1.9 2002/10/19 01:52:44 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="HFS FS Access utils"
SRC_URI="ftp://ftp.mars.org/pub/hfs/${P}.tar.gz"
HOMEPAGE="http://www.mars.org/home/rob/proj/hfs/"
KEYWORDS="ppc -x86 -sparc -sparc64"
DEPEND="virtual/glibc"
RDEPEND=""
SLOT="0"
LICENSE="GPL-2"

MAKEOPTS='PREFIX=/usr MANDIR=/usr/share/man'

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/lib
	dodir /usr/share/man
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
		
}
