# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-print/gimp-print-cups/gimp-print-cups-4.1.1.ebuild,v 1.1 2000/12/25 16:17:42 achim Exp $

S=${WORKDIR}/print-${PV}/cups
DESCRIPTION="The Common Unix Printing System - Gimp Print Drivers"
SRC_URI=" http://download.sourceforge.net/gimp-print/print-${PV}.tar.gz"

HOMEPAGE="http://www.cups.org"

DEPEND=">=net-print/cups-1.1.4"

src_compile() {
    cd ${S}
    try ./configure --host=${CHOST} --prefix=/usr --sysconfdir=/etc \
	--disable-gimptest
    try make
}

src_install () {

    cd ${S}
    dodir /etc
    dodir /usr/share /usr/lib/cups/backend
    try make prefix=${D}/usr exec_prefix=${D}/usr sysconfdir=${D}/etc install
    gunzip ${D}/usr/share/cups/model/*.gz
    docinto gimp-print-cups
    dodoc *.txt
}


