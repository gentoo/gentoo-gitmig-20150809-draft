# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hsc/hsc-0.929.ebuild,v 1.1 2003/06/21 08:22:41 george Exp $

DESCRIPTION="An HTML preprocessor using ML syntax"
HOMEPAGE="http://www.linguistik.uni-erlangen.de/~msbethke/software.html"
SRC_URI="http://www.linguistik.uni-erlangen.de/~msbethke/binaries/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/glibc"

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
