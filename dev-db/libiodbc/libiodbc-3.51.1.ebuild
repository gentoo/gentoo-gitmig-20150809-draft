# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/libiodbc/libiodbc-3.51.1.ebuild,v 1.1 2003/12/01 15:52:15 tantive Exp $
S=${WORKDIR}/${P}
DESCRIPTION="iODBC is the acronym for Independent Open DataBase Connectivity, an Open Source platform independent implementation of both the ODBC and X/Open specifications. It is rapidly emerging as the industry standard for developing solutions that are language, platform and database independent."
SRC_URI="http://www.iodbc.org/dist/libiodbc-${PV}.tar.gz"
HOMEPAGE="http://www.ioodbc.com"
LICENSE="LGPL-2 BSD"
DEPEND=""
KEYWORDS="~x86"
SLOT=0

src_compile() {
	./configure --prefix=${D}/usr/local --with-iodbc-inidir=/etc
	make
}

src_install () {
	make install || die "make install failed"
}
