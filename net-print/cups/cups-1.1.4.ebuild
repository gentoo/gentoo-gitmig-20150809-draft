# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-print/cups/cups-1.1.4.ebuild,v 1.1 2000/11/05 09:38:42 achim Exp $

A=${P}-source.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="The Common Unix Printing System"
SRC_URI="ftp://ftp.easysw.com/pub/cups/${PV}/${A}"
HOMEPAGE="http://www.cups.org"

DEPEND=">=sys-devel/gcc-2.95.2
	>=sys-libs/glibc-2.1.3
	>=sys-libs/pam-0.72
	>=media-libs/libpng-1.0.7
	>=media-libs/jpeg-6b
	>=media-libs/tiff-3.5.5"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --sysconfdir=/etc \
		    --localstatedir=/var --host=${CHOST} --enable-pam 
    cp Makedefs Makedefs.orig
    sed -e "s:^INITDIR.*:INITDIR = /etc:" \
	-e "s:/share/doc/cups:/doc/${P}:" \
	-e "s:^SERVERROOT.*:SERVERROOT = /etc/cups:" \
	-e "s:^LOGDIR.*:LOGDIR = /var/log/cups:" \
	-e "s:^REQUESTS.*:REQUESTS = /var/spool/cups:" \
	Makedefs.orig > Makedefs
    try make

}

src_install () {

    cd ${S}
    try make exec_prefix=${D}/usr  prefix=${D}/usr \
	     localstatedir=${D}/var/state sysconfdir=${D}/etc \
	     INITDIT=${D}/etc PAMDIR=${D}/etc/pam.d \
	     DOCDIR=${D}/usr/doc/${P} SERVERROOT=${D}/etc/cups \
	     LOGDIR=${D}/var/log/cups REQUESTS=${D}/var/spool/cups install
    rm -rf ${D}/usr/etc
    rm -rf ${D}/usr/man/cat*
    rm -r  ${D}/etc/pam.d
    cd ${D}/usr/doc/${P}
    gzip *
    mkdir html
    mv images html
    mv *.html.gz html
    mv *.css.gz html
    cd ${S}
    dodoc *.txt 
    docinto html
    dodoc LICENSE.html

    insinto /etc/rc.d/init.d
    insopts -m 755
    doins ${FILESDIR}/cups
}

