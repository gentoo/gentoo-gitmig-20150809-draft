# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# Updated by Sebastian Werner <sebastian@werner-productions.de>
# /home/cvsroot/gentoo-x86/net-print/cups/cups-1.1.6.ebuild,v 1.1 2001/04/28 04:19:58 achim Exp

S=${WORKDIR}/${PN}-1.1.7
DESCRIPTION="The Common Unix Printing System"
SRC_URI="ftp://ftp.easysw.com/pub/cups/1.1.7/${PN}-1.1.7-source.tar.bz2"

HOMEPAGE="http://www.cups.org"

PROVIDE="virtual/lpr"

DEPEND="virtual/glibc
	pam? ( >=sys-libs/pam-0.72 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	>=media-libs/libpng-1.0.9
	>=media-libs/jpeg-6b
	>=media-libs/tiff-3.5.5
	!net-print/LPRng"


src_compile() {

    local myconf
    if [ "`use pam`" ]
    then
      myconf="--enable-pam"
    fi
    if [ "`use ssl`" ]
    then
      myconf="${myconf} --enable-ssl"
    fi
    try ./configure --prefix=/ -exec-prefix=/usr \
		    --mandir=/usr/share/man --host=${CHOST} ${myconf}
    cp config.h config.h.orig
    sed  -e "s:/usr/share/doc/cups:/usr/share/cups/doc:" \
	config.h.orig > config.h
    cp Makedefs Makedefs.orig
    sed -e "s:/usr/share/doc/cups:/usr/share/cups/doc:" \
	Makedefs.orig > Makedefs 
    try make 
}

src_install () {

    cd ${S}
    try make exec_prefix=${D}/usr  prefix=${D}/ \
	datadir=${D}/usr/share localstatedir=${D}/var \
	includedir=${D}/usr/include \
	MANDIR=${D}/usr/share/man PAMDIR=${D}/etc/pam.d \
	INITDIR=${D}/etc/rc.d DOCDIR=${D}/usr/share/cups/doc \
	install 
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

}


