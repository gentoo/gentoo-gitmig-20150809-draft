# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-print/cups/cups-1.1.4.ebuild,v 1.2 2000/12/11 14:58:07 achim Exp $

A="${P}-source.tar.bz2"
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
    try ./configure --prefix=/ -exec-prefix=/usr \
		    --host=${CHOST} --enable-pam 
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
	MANDIR=${D}/usr/man PAMDIR=${D}/etc/pam.d \
	INITDIR=${D}/etc/rc.d DOCDIR=${D}/usr/share/cups/doc install 
    rm -rf ${D}/etc/rc.d
    rm -rf ${D}/usr/man/cat*
   # rm -r  ${D}/etc/pam.d
  #  cd ${D}/usr/doc/${P}
  #  gzip *
  #  mkdir html
  #  mv images html
  #  mv *.html.gz html
  #  mv *.css.gz html
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

