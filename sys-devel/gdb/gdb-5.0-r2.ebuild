# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gdb/gdb-5.0-r2.ebuild,v 1.11 2002/07/25 05:06:50 gerk Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="GNU debugger"
SRC_URI="ftp://sourceware.cygnus.com/pub/gdb/releases/${A}
	 ftp://ftp.freesoftware.com/pub/sourceware/gdb/releases/${A}"

DEPEND="virtual/glibc >=sys-libs/ncurses-5.2-r2
        nls? ( sys-devel/gettext )"

RDEPEND="virtual/glibc >=sys-libs/ncurses-5.2-r2"

HOMEPAGE="http://www.gnu.org/software/gdb/gdb.html"
LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

src_compile() {

    local myconf
    if [ -z "`use nls`" ]
    then
      myconf="--disable-nls"
    fi
    try ./configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info \
        --without-included-regex --without-included-gettext --host=${CHOST} ${myconf}
    try make ${MAKEOPTS}

}

src_install() {

    try make prefix=${D}/usr mandir=${D}/usr/share/man install 
    cd gdb/doc
    try make infodir=${D}/usr/share/info install-info
    cd ${S}/bfd/doc
    try make infodir=${D}/usr/share/info install-info
    cd ${S}
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




