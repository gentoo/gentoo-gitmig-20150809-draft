# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.11.90.0.27.ebuild,v 1.1 2001/08/28 04:27:58 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Tools necessary to build programs"
SRC_URI="http://ftp.kernel.org/pub/linux/devel/binutils/${P}.tar.bz2"

DEPEND="virtual/glibc"

src_compile() {
	local myconf
	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
	fi
	./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} ${myconf} || die
	if [ "`use static`" ]
	then
		emake -e LDFLAGS=-all-static || die
	else
		emake || die
	fi
}

src_install() {
	make prefix=${D}/usr mandir=${D}/usr/share/man install || die
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



