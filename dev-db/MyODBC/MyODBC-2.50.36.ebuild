# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-db/MyODBC/MyODBC-2.50.36.ebuild,v 1.1 2000/11/17 09:35:03 achim Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="ODBC interface for MySQL"
SRC_URI="http://www.mysql.com/Downloads/MyODBC/${A}"
HOMEPAGE="http://www.mysql.com"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} \
	--with-unixODBC=/usr --with-odbc-ini=/etc/odbc
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc ChangeLog ChangeSet 
}

