# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-dialup/isdn4k-utils/isdn4k-utils-3.1_p1-r3.ebuild,v 1.4 2002/07/17 10:43:24 seemant Exp $

MY_P=isdn4k-utils.v3.1pre1
S=${WORKDIR}/${PN}
DESCRIPTION="ISDN-4-Linux Utils"
SRC_URI="ftp://ftp.isdn4linux.de/pub/isdn4linux/utils/${MY_P}.tar.gz"
HOMEPAGE="http://www.isdn4linux.de/"

DEPEND="virtual/linux-sources
	>=sys-libs/ncurses-5.1
	>=sys-libs/gdbm-1.8.0
	mysql? ( >=dev-db/mysql-3.23.26 )
	>=dev-lang/tk-8.1"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp ${FILESDIR}/${P}.config .config
}

src_compile() {													 
	cd ${S}
	make subconfig || die
	make || die
}

src_install() {															 
	cd ${S}
	dodir /dev
	dodir /usr/sbin
	dodir /usr/bin
	make install DESTDIR=${D} || die
	
	dodoc COPYING NEWS README Mini-FAQ/isdn-faq.txt
	mv ${D}/usr/doc/vbox ${D}/usr/share/doc/isdn4k-utils-3.1_p1-r1

	rm -rf ${D}/usr/doc
	
}
