# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hsc/hsc-0.929.ebuild,v 1.5 2005/03/25 14:33:53 kugelfang Exp $

DESCRIPTION="An HTML preprocessor using ML syntax"
HOMEPAGE="http://www.linguistik.uni-erlangen.de/~msbethke/software.html"
SRC_URI="http://www.linguistik.uni-erlangen.de/~msbethke/binaries/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	gzcat ${FILESDIR}/Makefile.${PF}.patch.gz|patch -p1 Makefile || die "patch failed"
}

src_compile() {
	#The patch ensures this line works.
	make || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/lib
	dodir /usr/share
	#This makefile uses INSTDIR instead of DESTDIR
	make INSTDIR=${D}/usr/ install || die
}

pkg_postinst() {
	einfo Documentation and examples for HSC are available in
	einfo /usr/share/doc/${P}/
}
