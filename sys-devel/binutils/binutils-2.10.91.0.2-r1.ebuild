# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.10.91.0.2-r1.ebuild,v 1.3 2001/05/01 10:08:50 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Tools necessary to build programs"
SRC_URI="http://ftp.valinux.com/pub/support/hjl/binutils/${A}"

if [ -z "`use build`" ] ; then
  DEPEND="nls? ( sys-devel/gettext )"
fi

src_compile() {

    local myconf
    if [ -z "`use nls`" ]
    then
      myconf="--disable-nls"
    fi
	try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} ${myconf}
    if [ "`use static`" ]
    then
        try make -e LDFLAGS=-all-static ${MAKEOPTS}
    else
	    try make ${MAKEOPTS}
    fi
}

src_install() {

	try make prefix=${D}/usr mandir=${D}/usr/share/man install

    if [ -z "`use build`" ]
    then
	    dodoc COPYING* README
	    docinto bfd
        dodoc bfd/ChangeLog* bfd/COPYING bfd/README bfd/PORTING bfd/TODO
	    docinto binutils
 	    dodoc binutils/ChangeLog binutils/NEWS binutils/README
	    docinto gas
	    dodoc gas/ChangeLog* gas/CONTRIBUTORS gas/COPYING \
	        gas/NEWS gas/README*
	    docinto gprof
	    dodoc gprof/ChangeLog* gprof/NOTES gprof/TEST gprof/TODO
	    docinto ld
	    dodoc ld/ChangeLog* ld/README ld/NEWS ld/TODO
	    docinto libiberty
	    dodoc libiberty/ChangeLog* libiberty/COPYING.LIB libiberty/README
	    docinto opcodes
	    dodoc opcodes/ChangeLog*
    else
        rm -rf ${D}/usr/share/man
    fi
	
}



