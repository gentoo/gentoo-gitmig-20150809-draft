# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-db/unixODBC/unixODBC-1.8.13.ebuild,v 1.3 2000/11/22 12:23:28 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="ODBC Interface for Linux"
SRC_URI="http://www.unixodbc.org/${A}"
HOMEPAGE="http://www.unixodbc.org"

DEPEND=">=kde-base/qt-x11-2.2.1"

src_unpack() {

    unpack ${A}
    cd ${S}
    cp Makefile.in Makefile.orig
    sed -e "s:touch :touch \${DESTDIR}/:" Makefile.orig > Makefile.in

}
src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --sysconfdir=/etc/unixODBC --host=${CHOST}

    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS REDAME*
}

