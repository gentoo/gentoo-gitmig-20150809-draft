# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/hfsutils/hfsutils-3.2.6.ebuild,v 1.5 2005/02/05 21:20:43 hansmi Exp $

DESCRIPTION="HFS FS Access utils"
HOMEPAGE="http://www.mars.org/home/rob/proj/hfs/"
SRC_URI="ftp://ftp.mars.org/pub/hfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc"
IUSE=""

DEPEND="virtual/libc"
RDEPEND=""

src_compile() {
	econf || die
	emake PREFIX=/usr MANDIR=/usr/share/man || die
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
