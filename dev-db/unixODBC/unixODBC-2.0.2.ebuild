# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-db/unixODBC/unixODBC-2.0.2.ebuild,v 1.1 2001/01/13 20:07:52 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="ODBC Interface for Linux"
SRC_URI="http://www.unixodbc.org/${A}"
HOMEPAGE="http://www.unixodbc.org"

DEPEND=">=x11-libs/qt-x11-2.2.2"

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

