# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-print/cups/cups-1.1.4.ebuild,v 1.5 2000/12/19 00:34:25 achim Exp $

GPV="4.0.4"
S=${WORKDIR}/${P}
S0=${WORKDIR}/print-${GPV}/cups
DESCRIPTION="The Common Unix Printing System"
SRC_URI="ftp://ftp.easysw.com/pub/cups/${PV}/${P}-source.tar.bz2
	 http://download.sourceforge.net/gimp-print/print-${GPV}.tar.gz"

HOMEPAGE="http://www.cups.org"

DEPEND=">=sys-devel/gcc-2.95.2
	>=sys-libs/glibc-2.1.3
	>=sys-libs/pam-0.72
	>=media-libs/libpng-1.0.7
	>=media-libs/jpeg-6b
	>=media-libs/tiff-3.5.5"

src_compile() {

    cd ${S}
    try ./configure --prefix=/ -exec-prefix=/usr \
		    --host=${CHOST} --enable-pam 
    cp config.h config.h.orig
    sed  -e "s:/usr/share/doc/cups:/usr/share/cups/doc:" \
	config.h.orig > config.h
    cp Makedefs Makedefs.orig
    sed -e "s:/usr/share/doc/cups:/usr/share/cups/doc:" \
	Makedefs.orig > Makedefs 
    try make 
#    cd ${S0}
#      try ./configure --host=${CHOST} --prefix=/usr --sysconfdir=/etc \
#	--disable-gimptest
#    try make
}

src_install () {

    cd ${S}
    try make exec_prefix=${D}/usr  prefix=${D}/ \
	MANDIR=${D}/usr/man PAMDIR=${D}/etc/pam.d \
	INITDIR=${D}/etc/rc.d DOCDIR=${D}/usr/share/cups/doc \
	INCLUDEDIR=${D}/usr/include install 
    rm -rf ${D}/etc/rc.d
    rm -rf ${D}/usr/man/cat*
    cd ${S}
    dodoc *.txt 
    docinto html
    dodoc LICENSE.html

    insinto /etc/rc.d/init.d
    insopts -m 755
    doins ${FILESDIR}/cupsd
    insinto /etc/pam.d
    insopts -m 644
    doins ${FILESDIR}/cups

#    cd ${S0}
#    dodir /etc
#    dodir /usr/share /usr/lib/cups/backend
#    try make prefix=${D}/usr exec_prefix=${D}/usr sysconfdir=${D}/etc install
#    gunzip ${D}/usr/share/cups/model/*.gz
#    docinto gimp-print-cups
#    dodoc *.txt
}


