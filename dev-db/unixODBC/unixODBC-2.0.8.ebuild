# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-db/unixODBC/unixODBC-2.0.8.ebuild,v 1.1 2001/07/01 21:56:57 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="ODBC Interface for Linux"
SRC_URI="http://www.unixodbc.org/${A}"
HOMEPAGE="http://www.unixodbc.org"

DEPEND="virtual/glibc
        >=sys-libs/readline-4.1
        >=sys-libs/ncurses-5.2
        qt? ( >=x11-libs/qt-x11-2.3.0 )"

src_unpack() {

    unpack ${A}
    cd ${S}
    cp Makefile.in Makefile.orig
    sed -e "s:touch :touch \${DESTDIR}/:" Makefile.orig > Makefile.in

}
src_compile() {
    local myconf
    if [ "`use qt`" ]
    then
      myconf="--enable-gui=yes"
    else
      myconf="--enable-gui=no"
    fi
    try ./configure --prefix=/usr --sysconfdir=/etc/unixODBC --host=${CHOST} ${myconf}

    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README*
    cp -a doc ${D}/usr/share/doc/${PF}/html
    find ${D}/usr/share/doc/${PF}/html -name "Makefile*" -exec rm {} \;
    prepalldocs
}
