# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# $Header $

DESCRIPTION="The Common Unix Printing System - Gimp Print Drivers"
HOMEPAGE="http://www.cups.org"

S=${WORKDIR}/print-${PV}/cups
SRC_URI="http://download.sourceforge.net/gimp-print/print-${PV}.tar.gz"
DEPEND="virtual/glibc >=net-print/cups-1.1.4"

src_compile() {

	./configure --prefix=/usr --sysconfdir=/etc --disable-gimptest --host=${CHOST} || die
	emake || die
}

src_install () {

	dodir /etc /usr/share /usr/lib/cups/backend
	make install prefix=${D}/usr exec_prefix=${D}/usr sysconfdir=${D}/etc || die

	gunzip ${D}/usr/share/cups/model/*.gz
	dodoc *.txt
}
