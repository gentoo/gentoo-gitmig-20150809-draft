# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-db/xmysqladmin/xmysqladmin-1.0.ebuild,v 1.4 2002/08/01 11:40:14 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="xforms based front end to mysql"
SRC_URI="ftp://ftp.mysql.com/Contrib/${P}.tar.gz"
HOMEPAGE="http://www.mysql.org"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

DEPEND="virtual/x11
	virtual/xforms"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e 's:^INSTALLPATH.*:INSTALLPATH = /usr/bin:g' -e \
	's:^PIXMAPPATH.*:PIXMAPPATH = /usr/share/pixmaps:g' -e \
	's:^MYSQLINC.*:MYSQLINC = -I/usr/include/mysql:g' -e \
	's:^MYSQLDBDIR.*:MYSQLDBDIR = -DMYSQLDBDIR=\\\"/var/mysql\\\":g' -e \
	's:^MYSQLLOAD.*:MYSQLLOAD = \-Wl\,\-R/usr/lib/mysql \-L/usr/lib/mysql \-lmysqlclient:g' -e \
	's:\./$(PROGRAM)::g' Makefile > Makefile.gentoo
}

src_compile() {
	
	make -f Makefile.gentoo || die
}

src_install () {
	
	dodir /usr/bin
	dodir /usr/share/pixmaps
	make \
		INSTALLPATH=${D}/usr/bin \
		PIXMAPPATH=${D}/usr/share/pixmaps \
		install || die

	dodoc README INSTALL CHANGES ANNOUNCE TODO
}

