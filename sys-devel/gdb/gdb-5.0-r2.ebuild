# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gdb/gdb-5.0-r2.ebuild,v 1.1 2001/02/07 16:05:19 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="GNU debugger"
SRC_URI="ftp://sourceware.cygnus.com/pub/gdb/releases/${A}
	 ftp://ftp.freesoftware.com/pub/sourceware/gdb/releases/${A}"

DEPEND=">=sys-libs/ncurses-5.2-r2
        sys-devel/gettext"

RDEPEND=">=sys-libs/ncurses-5.2-r2"

HOMEPAGE="http://www.gnu.org/software/gdb/gdb.html"

src_compile() {

    try ./configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --host=${CHOST}
    try make ${MAKEOPTS}

}

src_install() {

    try make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info install install-info

    # These includes and libs are in binutils already
    rm -f ${D}/usr/lib/libbfd.*
    rm -r ${D}/usr/lib/libiberty.*
    rm -f ${D}/usr/lib/libopcodes.*

    rm -rf ${D}/usr/include

    dodoc COPYING* README
    docinto gdb
    dodoc gdb/CONTRIBUTE gdb/COPYING* gdb/README \
	  gdb/MAINTAINERS gdb/NEWS gdb/ChangeLog* \
	  gdb/TODO
    docinto sim
    dodoc sim/ChangeLog sim/MAINTAINERS sim/README-HACKING
    docinto mmalloc
    dodoc mmalloc/COPYING.LIB mmalloc/MAINTAINERS \
	  mmalloc/ChangeLog mmalloc/TODO
}




